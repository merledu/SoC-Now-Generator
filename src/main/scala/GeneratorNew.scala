import chisel3._
import chisel3.experimental.Analog
import chisel3.stage.ChiselStage

import nucleusrv.components.{Core, Configs}

import caravan.bus.common._
import caravan.bus.tilelink._
import caravan.bus.wishbone._

import jigsaw.fpga.boards.artyA7._
import jigsaw.rams.fpga._
import jigsaw.peripherals.gpio._
import jigsaw.peripherals.spiflash._
import jigsaw.peripherals.spi._
import jigsaw.peripherals.UART._
import jigsaw.peripherals.timer._
import jigsaw.peripherals.i2c._
import java.util.Timer
import jigsaw.peripherals.common._

class GeneratornewIOs(configs:Map[Any, Map[Any, Any]], fpga:Boolean = false) extends Bundle
{
    def getConfig[T](key: String, default: T): T = 
        configs.getOrElse(key, Map("is" -> default)).asInstanceOf[Map[String, T]].getOrElse("is", default)

    val n = configs("GPIO")("n").asInstanceOf[Int]

    val gpio_io = if (getConfig("GPIO", false) & fpga) Some(Vec(n, Analog(1.W))) else None

    val gpio_o     = if (getConfig("GPIO", false) & !fpga) Some(Output(UInt(n.W))) else None
    val gpio_en_o  = if (getConfig("GPIO", false) & !fpga) Some(Output(UInt(n.W))) else None
    val gpio_i     = if (getConfig("GPIO", false) & !fpga) Some(Input(UInt(n.W))) else None

    val spi_cs_n   = if (getConfig("SPI", false)) Some(Output(Bool())) else None
    val spi_sclk   = if (getConfig("SPI", false)) Some(Output(Bool())) else None
    val spi_mosi   = if (getConfig("SPI", false)) Some(Output(Bool())) else None
    val spi_miso   = if (getConfig("SPI", false)) Some(Input(Bool()))  else None

    val cio_uart_rx_i        = if (getConfig("UART", false)) Some(Input(Bool())) else None
    val cio_uart_tx_o        = if (getConfig("UART", false)) Some(Output(Bool())) else None
    val cio_uart_intr_tx_o   = if (getConfig("UART", false)) Some(Output(Bool())) else None

    val timer_intr_cmp = if (getConfig("TIMER", false)) Some(Output(Bool())) else None
    val timer_intr_ovf = if (getConfig("TIMER", false)) Some(Output(Bool())) else None

    val spi_flash_cs_n  = if (getConfig("SPIF", false)) Some(Output(Bool())) else None
    val spi_flash_sclk  = if (getConfig("SPIF", false)) Some(Output(Bool())) else None
    val spi_flash_mosi  = if (getConfig("SPIF", false)) Some(Output(Bool())) else None
    val spi_flash_miso  = if (getConfig("SPIF", false)) Some(Input(Bool()))  else None

    val i2c_sda_in = if (getConfig("I2C", false)) Some(Input(Bool())) else None
    val i2c_sda    = if (getConfig("I2C", false)) Some(Output(Bool())) else None
    val i2c_scl    = if (getConfig("I2C", false)) Some(Output(Bool())) else None
    val i2c_intr   = if (getConfig("I2C", false)) Some(Output(Bool())) else None
}

class GeneratorNew (programFile: Option[String],
                 configs:Map[Any, Map[Any, Any]]) extends Module
{
    val io = IO(new GeneratornewIOs(configs))

    val addressMap = new AddressMap
    Peripherals.addValuesFromJson("peripherals.json")
    setupBus("wb")

    

    private def setupBus(busType:String): Unit = busType match {

        case "wb" => setupWishboneBus()
        // case "tl" => setupTilelinkBus()
        case _    => throw new IllegalArgumentException(s"Unsupported bus type: $busType")

    }

    private def setupWishboneBus(): Unit = {
        implicit val config :WishboneConfig = WishboneConfig(32,32)


        // setupPeripheral[WBRequest, WBResponse, Gpio[WBRequest, WBResponse], WishboneDevice, WishboneDeviceIO](
        //     "DCCM",
        //     () => BlockRam.createMaskableRAM(bus=config, rows=1024),
        //     () => None,
        //     connectDevice[WBRequest, WBResponse, Gpio[WBRequest, WBResponse], WishboneDeviceIO],
        //     () => new WishboneDevice
        // )

        // connect DCCM
        setupPeripheral[WBRequest, WBResponse, jigsaw.rams.fpga.BlockRamWithMasking[WBRequest, WBResponse], WishboneDevice, WishboneDeviceIO, AbstractDeviceIO[WBRequest, WBResponse]](
            "DCCM",
            () => new jigsaw.rams.fpga.BlockRamWithMasking(new WBRequest, new WBResponse, 1024), //BlockRam.createMaskableRAM(bus=config, rows=1024),
            P => (),
            (device: AbstractDeviceIO[WBRequest, WBResponse], bus: WishboneDeviceIO) => 
            connectDevice[WBRequest, WBResponse, AbstractDeviceIO[WBRequest, WBResponse], WishboneDeviceIO](
                device.asInstanceOf[AbstractDeviceIO[WBRequest, WBResponse]], 
                bus.asInstanceOf[WishboneDeviceIO]
            ),
            () => new WishboneDevice
        )

        // connect GPIO
        setupPeripheral[WBRequest, WBResponse, Gpio[WBRequest, WBResponse], WishboneDevice, WishboneDeviceIO, AbstractDeviceIO[WBRequest, WBResponse]](
            "GPIO",                                                                                 // name
            () => new Gpio(new WBRequest(), new WBResponse()),                                      // createPeripheral
            connectGPIO _,                                                                            // connectPeripheral
            (device: AbstractDeviceIO[WBRequest, WBResponse], bus: WishboneDeviceIO) => 
            connectDevice[WBRequest, WBResponse, AbstractDeviceIO[WBRequest, WBResponse], WishboneDeviceIO](
                device.asInstanceOf[AbstractDeviceIO[WBRequest, WBResponse]], 
                bus.asInstanceOf[WishboneDeviceIO]
            ),   // connectDevice
            () => new WishboneDevice                                                                // busDevice
        )

        // connect SPI
        setupPeripheral[WBRequest, WBResponse, Spi[WBRequest, WBResponse], WishboneDevice, WishboneDeviceIO, AbstractDeviceIO[WBRequest, WBResponse]](
            "SPI",
            () => new Spi(new WBRequest(), new WBResponse()),
            connectSPI _,
            (device: AbstractDeviceIO[WBRequest, WBResponse], bus: WishboneDeviceIO) => 
            connectDevice[WBRequest, WBResponse, AbstractDeviceIO[WBRequest, WBResponse], WishboneDeviceIO](
                device.asInstanceOf[AbstractDeviceIO[WBRequest, WBResponse]], 
                bus.asInstanceOf[WishboneDeviceIO]
            ),
            () => new WishboneDevice
        )

        // connect UART
        setupPeripheral[WBRequest, WBResponse, Uart[WBRequest, WBResponse], WishboneDevice, WishboneDeviceIO, AbstractDeviceIO[WBRequest, WBResponse]](
            "UART",
            () => new Uart(new WBRequest(), new WBResponse()),
            connectUART _,
            (device: AbstractDeviceIO[WBRequest, WBResponse], bus: WishboneDeviceIO) => 
            connectDevice[WBRequest, WBResponse, AbstractDeviceIO[WBRequest, WBResponse], WishboneDeviceIO](
                device.asInstanceOf[AbstractDeviceIO[WBRequest, WBResponse]], 
                bus.asInstanceOf[WishboneDeviceIO]
            ),
            () => new WishboneDevice
        )

        // connect TIMER
        setupPeripheral[WBRequest, WBResponse, jigsaw.peripherals.timer.Timer[WBRequest, WBResponse], WishboneDevice, WishboneDeviceIO, AbstractDeviceIO[WBRequest, WBResponse]](
            "TIMER",
            () => new jigsaw.peripherals.timer.Timer(new WBRequest(), new WBResponse()),
            connectTIMER _,
            (device: AbstractDeviceIO[WBRequest, WBResponse], bus: WishboneDeviceIO) => 
            connectDevice[WBRequest, WBResponse, AbstractDeviceIO[WBRequest, WBResponse], WishboneDeviceIO](
                device.asInstanceOf[AbstractDeviceIO[WBRequest, WBResponse]], 
                bus.asInstanceOf[WishboneDeviceIO]
            ),
            () => new WishboneDevice
        )

        // connect SPI-Flash
        setupPeripheral[WBRequest, WBResponse, SpiFlash[WBRequest, WBResponse], WishboneDevice, WishboneDeviceIO, AbstractDeviceIO[WBRequest, WBResponse]](
            "SPIF",
            () => new SpiFlash(new WBRequest(), new WBResponse()),
            connectSPIF _,
            (device: AbstractDeviceIO[WBRequest, WBResponse], bus: WishboneDeviceIO) => 
            connectDevice[WBRequest, WBResponse, AbstractDeviceIO[WBRequest, WBResponse], WishboneDeviceIO](
                device.asInstanceOf[AbstractDeviceIO[WBRequest, WBResponse]], 
                bus.asInstanceOf[WishboneDeviceIO]
            ),
            () => new WishboneDevice
        )

        // connect I2C
        setupPeripheral[WBRequest, WBResponse, I2c[WBRequest, WBResponse], WishboneDevice, WishboneDeviceIO, AbstractDeviceIO[WBRequest, WBResponse]](
            "I2C",
            () => new I2c(new WBRequest(), new WBResponse()),
            connectI2C _,
            (device: AbstractDeviceIO[WBRequest, WBResponse], bus: WishboneDeviceIO) => 
            connectDevice[WBRequest, WBResponse, AbstractDeviceIO[WBRequest, WBResponse], WishboneDeviceIO](
                device.asInstanceOf[AbstractDeviceIO[WBRequest, WBResponse]], 
                bus.asInstanceOf[WishboneDeviceIO]
            ),
            () => new WishboneDevice
        )

        // instantiate core
        val core = connectNRV

        // connecting imem to core
        connectImemToCore[WBRequest, WBResponse, BlockRamWithoutMasking[WBRequest, WBResponse]](
            programFile,
            1024,
            (pf, rows) => new BlockRamWithoutMasking(new WBRequest, new WBResponse, pf, rows),
            core,
            () => new WishboneAdapter
        )

        // connecting Switch w. Core and selected Devices
        connectCrossbarSwitch[WBRequest, WBResponse, WishboneMaster, WishboneSlave, WishboneHost, WishboneDevice, Switch1toN[WishboneMaster, WishboneSlave], WishboneErr](
            () => new WishboneHost(),
            core,
            (devSize) => new Switch1toN(new WishboneMaster, new WishboneSlave, devSize),
            () => new WishboneErr
        )

    }

    // Generic method to setup a peripheral based on configuration
    private def setupPeripheral[T <:AbstrRequest, R <: AbstrResponse, P <: AbstractDevice[T,R], B <: DeviceAdapter, I<:DeviceAdapterIO, O<:AbstractDeviceIO[T,R]]
    (
        name: String, 
        createPeripheral: () => P, 
        connectPeripheral: P => Unit, 
        connectDevice: (O,I) => Unit, 
        busDevice: () => B
    ): Unit = {
        if (configs(name)("is").asInstanceOf[Boolean]) {
            val peripheral = Module(createPeripheral())
            connectPeripheral(peripheral)
            val bus = Module(busDevice())
            connectDevice(peripheral.io.asInstanceOf[O], bus.io.asInstanceOf[I])
            addressMap.addDevice(
                Peripherals.get(name),
                configs(name)("baseAddr").asInstanceOf[String].U(32.W),
                configs(name)("mask").asInstanceOf[String].U(32.W),
                bus
            )
        }
    }

    private def connectDevice[T <:AbstrRequest, R <: AbstrResponse, P <: AbstractDeviceIO[T,R], B <: DeviceAdapterIO]
    (
        device  :P,
        bus     :B
    ): Unit = {
        bus.reqOut <> device.req
        bus.rspIn  <> device.rsp
    }

    // Specific method to connect GPIO
    private def connectGPIO[A <:AbstrRequest, B <: AbstrResponse](gpio: Gpio[A,B]): Unit = {
        val n = configs("GPIO")("n").asInstanceOf[Int]
        io.gpio_o.get       := gpio.io.cio_gpio_o(n - 1, 0)
        io.gpio_en_o.get    := gpio.io.cio_gpio_en_o(n - 1, 0)
        gpio.io.cio_gpio_i  := io.gpio_i.get
    }

    // Specific method to connect SPI
    private def connectSPI[A <: AbstrRequest, B <: AbstrResponse](spi: Spi[A,B]): Unit = {
        io.spi_cs_n.get := spi.io.cs_n
        io.spi_sclk.get := spi.io.sclk
        io.spi_mosi.get := spi.io.mosi
        spi.io.miso     := io.spi_miso.get
    }

    // Specific method to connect UART
    private def connectUART[A <: AbstrRequest, B <: AbstrResponse](uart: Uart[A,B]): Unit = {
        uart.io.cio_uart_rx_i := io.cio_uart_rx_i.get
        io.cio_uart_tx_o.get := uart.io.cio_uart_tx_o
        io.cio_uart_intr_tx_o.get := uart.io.cio_uart_intr_tx_o 
    }

    // Speciifc method to connect TIMER
    private def connectTIMER[A <: AbstrRequest, B <: AbstrResponse](timer: jigsaw.peripherals.timer.Timer[A,B]): Unit = {
        io.timer_intr_cmp.get := timer.io.cio_timer_intr_cmp
        io.timer_intr_ovf.get := timer.io.cio_timer_intr_ovf
    }

    // Specific method to connect SPI FLASH
    private def connectSPIF[A <: AbstrRequest, B <: AbstrResponse](spi_flash: SpiFlash[A,B]): Unit = {
        io.spi_flash_cs_n.get := spi_flash.io.cs_n
        io.spi_flash_sclk.get := spi_flash.io.sclk
        io.spi_flash_mosi.get := spi_flash.io.mosi
        spi_flash.io.miso := io.spi_flash_miso.get
    }

    // Specific method to connect I2C
    private def connectI2C[A <: AbstrRequest, B <: AbstrResponse](i2c: I2c[A,B]): Unit = {
        i2c.io.cio_i2c_sda_in := io.i2c_sda_in.get
        io.i2c_sda.get := i2c.io.cio_i2c_sda
        io.i2c_scl.get := i2c.io.cio_i2c_scl
        io.i2c_intr.get := i2c.io.cio_i2c_intr
    }

    // private method for NRV // TODO: Make more generic
    private def connectNRV: NRV = {
        implicit val coreconfig = Configs()
        val core = Module(new NRV)
        core.io.stall := false.B
        core
    }

    private def connectImemToCore[T <: AbstrRequest, R <: AbstrResponse, D <: AbstractDevice[T,R]]
    (
        pf: Option[String],
        rw: Int,
        createImem: (Option[String],Int) => D,
        core: NRV,
        createAdapter: () => BusAdapter
    ):Unit = {
        val imem_adapter = Module(createAdapter()) //Module(new WishboneAdapter)
        val imem = Module(createImem(pf,rw)) //Module(new BlockRamWithoutMasking(new WBRequest, new WBResponse, programFile, 1024)) //Module(BlockRam.createNonMaskableRAM(programFile, bus=config, rows=1024))

        imem_adapter.io.reqIn   <> core.io.imemReq
        imem_adapter.io.rspOut  <> core.io.imemRsp
        imem_adapter.io.reqOut  <> imem.io.req
        imem_adapter.io.rspIn   <> imem.io.rsp
    }

    private def connectCrossbarSwitch[T <: AbstrRequest, R <: AbstrResponse, M <: BusHost, S <: BusDevice, H <: HostAdapter, D <: DeviceAdapter, SW <: Switch1toN[M,S], E <: ErrorDevice](
        createHost: () => H,
        core: NRV,
        createSwitch: (Int) => SW,
        createError: () => E
    ) = {

        val bus_host = Module(createHost())

        bus_host.io.reqIn   <> core.io.dmemReq
        bus_host.io.rspOut  <> core.io.dmemRsp

        // setup switch
        val devices = addressMap.getDevices
        println(devices)
        val switch = Module(createSwitch(devices.size))

        switch.io.hostIn    <> bus_host.io.masterTransmitter
        switch.io.hostOut   <> bus_host.io.slaveReceiver

        for (i <- 0 until devices.size)
        {
            println(devices(i)._2.litValue().toInt)
            println(devices(i)._1.asInstanceOf[D])
            switch.io.devIn(devices(i)._2.litValue().toInt)     <> devices(i)._1.asInstanceOf[D].io.slaveTransmitter
            switch.io.devOut(devices(i)._2.litValue().toInt)    <> devices(i)._1.asInstanceOf[D].io.masterReceiver
        }

        // error device
        val wbError = Module(createError())

        switch.io.devIn(devices.size)   <> wbError.io.slaveTransmitter
        switch.io.devOut(devices.size)  <> wbError.io.masterReceiver
        println(addressMap.getMap())

        switch.io.devSel    := BusDecoder.decode(bus_host.getAddressPin, addressMap)
    }
    

}

/*
class Generator(programFile: Option[String],
                 configs:Map[Any, Map[Any, Any]]) extends Module
{
    val n = configs("GPIO")("n").asInstanceOf[Int]

    val io = IO(new GeneratorIOs(configs))

    implicit val config: BusConfig = if (configs("WB")("is").asInstanceOf[Boolean]) WishboneConfig(32, 32)
                          else if (configs("TL")("is").asInstanceOf[Boolean]) TilelinkConfig(10, 32)
                          else TilelinkConfig(10, 32)

    def createHost(): BusHost = if (configs("WB")("is").asInstanceOf[Boolean]) Module(new WishboneHost())
                     else Module(new TilelinkHost())

    def createSlave(): BusDevice = if (configs("WB")("is").asInstanceOf[Boolean]) Module(new WishboneDevice())
                     else Module(new TilelinkDevice())

    val gen_imem_host = createHost()
    val gen_imem_slave = createSlave()
    val gen_dmem_host = createHost()
    val gen_dmem_slave = createSlave()

    val addressMap = new AddressMap

    Peripherals.addValuesFromJson("config.json")

    addressMap.addDevice( Peripherals.get("DCCM"), configs("DCCM")("baseAddr").asInstanceOf[String].U(32.W), configs("GPIO")("mask").asInstanceOf[String].U(32.W), gen_dmem_slave)

    

    val imem = Module(BlockRam.createNonMaskableRAM(programFile, bus=config, rows=1024))
    val dmem = Module(BlockRam.createMaskableRAM(bus=config, rows=1024))

    val busErr = Module(if (configs("WB")("is").asInstanceOf[Boolean]) new WishboneErr() else new TilelinkError())
    val core = Module(new Core())

    val devices = addressMap.getDevices

    val switch = Module(
        new Switch1toN(
            if (configs("WB")("is").asInstanceOf[Boolean]) new WishboneMaster()
            else new TilelinkMaster(),
            if (configs("WB")("is").asInstanceOf[Boolean]) new WishboneSlave()
            else new TilelinkSlave(),
            devices.size
        )
    )

    // wb <-> Core (fetch)
    gen_imem_host.io.reqIn <> core.io.imemReq
    core.io.imemRsp <> gen_imem_host.io.rspOut
    gen_imem_slave.io.reqOut <> imem.io.req
    gen_imem_slave.io.rspIn <> imem.io.rsp

    // wb <-> wb (fetch)
    gen_imem_host.io.wbMasterTransmitter <> gen_imem_slave.io.wbMasterReceiver
    gen_imem_slave.io.wbSlaveTransmitter <> gen_imem_host.io
        gen_imem_host.io.wbSlaveReceiver

    // wb <-> Core (load/store)
    gen_dmem_host.io.reqIn <> core.io.dmemReq
    core.io.dmemRsp <> gen_dmem_host.io.rspOut
    gen_dmem_slave.io.reqOut <> dmem.io.req
    gen_dmem_slave.io.rspIn <> dmem.io.rsp

    // wb <-> wb (load/store)
    gen_dmem_host.io.wbMasterTransmitter <> gen_dmem_slave.io.wbMasterReceiver
    gen_dmem_slave.io.wbSlaveTransmitter <> gen_dmem_host.io.wbSlaveReceiver

    // Connecting all peripherals to the bus switch
    for ((device, i) <- devices.zipWithIndex) {
        switch.io.slaves(i).reqOut <> device.io.req
        switch.io.slaves(i).rspIn <> device.io.rsp
    }

    // Connecting the bus switch to the master (e.g., core)
    switch.io.master.reqIn <> core.io.dmemReq
    core.io.dmemRsp <> switch.io.master.rspOut

    // Connecting the bus switch to the error handler
    busErr.io.master.reqIn <> switch.io.master.reqIn
    busErr.io.master.rspOut <> switch.io.master.rspOut

    // Assigning the reset vector
    core.io.reset_vector := imem.io.addr // Assuming the reset vector is at the start of the instruction memory

    // For debugging purposes
    // printf("GPIO output: %d\n", io.gpio_o.get)
    // printf("SPI CS: %b, SCLK: %b, MOSI: %b, MISO: %b\n", io.spi_cs_n.get, io.spi_sclk.get, io.spi_mosi.get, io.spi_miso.get)
    // printf("UART RX: %b, TX: %b\n", io.cio_uart_rx_i.get, io.cio_uart_tx_o.get)
}
*/
import spray.json._
import DefaultJsonProtocol._

object NewGeneratorDriver extends App {
    val programFile = if (args.length > 0) Some(args(0)) else None
    val file = scala.io.Source.fromFile((os.pwd.toString)+"//src//main//scala//config.json").mkString

    val fileToJson = file.parseJson.convertTo[Map[String, JsValue]]
    val oneZero = fileToJson.map({case (a,b) => a -> {if (b == JsNumber(1)) true else false}})

    val baseAddr = BaseAddr()
    val mask     = Mask()
    val ids      = PeripheralFactory.idCount()
    val configs:Map[Any, Map[Any,Any]] = Map("DCCM" -> Map("id" -> ids("DCCM"), "is" -> true           , "baseAddr" -> baseAddr.DCCM, "mask" -> mask.DCCM),
                                           "GPIO" -> Map("id" -> ids("GPIO"), "is" -> oneZero("gpio"), "baseAddr" -> baseAddr.GPIO, "mask" -> mask.GPIO, "n" -> 4),
                                           "SPI"  -> Map("id" -> ids("SPI"), "is" -> oneZero("spi") , "baseAddr" -> baseAddr.SPI , "mask" -> mask.SPI ),
                                           "UART" -> Map("id" -> ids("UART"), "is" -> oneZero("uart"), "baseAddr" -> baseAddr.UART, "mask" -> mask.UART),
                                           "TIMER"-> Map("id" -> ids("TIMER"), "is"-> oneZero("timer"), "baseAddr"-> baseAddr.TIMER, "mask"-> mask.TIMER),
                                           "SPIF" -> Map("id" -> ids("SPIF"), "is" -> oneZero("spi_flash"), "baseAddr" -> baseAddr.SPIF, "mask" -> mask.SPIF),
                                           "I2C"  -> Map("id" -> ids("I2C"), "is" -> oneZero("i2c") , "baseAddr" -> baseAddr.I2C , "mask" -> mask.I2C ),
                                           "M"    -> Map("is" -> oneZero("m")),
                                           "TL"   -> Map("is" -> oneZero("tl")),
                                           "WB"   -> Map("is" -> oneZero("wb")),
                                           "TLC"   -> Map("is" -> oneZero("tlc")))

    (new ChiselStage).emitVerilog(new GeneratorNew(programFile, configs))
}
