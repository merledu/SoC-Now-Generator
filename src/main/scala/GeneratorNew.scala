import chisel3._
import chisel3.experimental.Analog
import chisel3.stage.ChiselStage

import nucleusrv.components.Core

import caravan.bus.common._
import caravan.bus.tilelink._
import caravan.bus.wishbone._

import jigsaw.fpga.boards.artyA7._
import jigsaw.rams.fpga.BlockRam
import jigsaw.peripherals.gpio._
import jigsaw.peripherals.spiflash._
import jigsaw.peripherals.spi._
import jigsaw.peripherals.UART._
import jigsaw.peripherals.timer._
import jigsaw.peripherals.i2c._
import java.util.Timer

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

    // def this() = {
    //     this()
    val addressMap = new AddressMap
    Peripherals.addValuesFromJson("peripherals.json")
    setupBus("wb")
    // }


    private def setupBus(busType:String): Unit = {
        if (busType == "wb"){
            // implicit val config: WishboneConfig = WishboneConfig(32,32)         // keeping statis 32 address width and 32 data width for now
            setupWishboneBus()
        }
    }

    private def setupWishboneBus(): Unit = {
        implicit val config:WishboneConfig = WishboneConfig(32,32)

        // connect GPIO
        setupPeripheral[WBRequest, WBResponse, Gpio[WBRequest, WBResponse], WishboneDevice]("GPIO", () => new Gpio(new WBRequest(), new WBResponse()), connectGPIO, connectDevice[WBRequest, WBResponse, Gpio[WBRequest, WBResponse], WishboneDevice], () => new WishboneDevice )



    }

    // Generic method to setup a peripheral based on configuration
    private def setupPeripheral[T <:AbstrRequest, R <: AbstrResponse, P <: Gpio[T,R], B <: DeviceAdapter](name: String, createPeripheral: () => P, connectPeripheral: P => Unit, connectDevice: (P,B) => Unit, busDevice: () => B): Unit = {
        // if (configs(name)("is").asInstanceOf[Boolean]) {
        val peripheral = Module(createPeripheral())
        connectPeripheral(peripheral)
        val bus = Module(busDevice())
        connectDevice(peripheral, bus)
        addressMap.addDevice(
            Peripherals.get(name),
            configs(name)("baseAddr").asInstanceOf[String].U(32.W),
            configs(name)("mask").asInstanceOf[String].U(32.W),
            bus
        )
        // }
    }

    private def connectDevice[T <:AbstrRequest, R <: AbstrResponse, P <: Gpio[T,R], B <: WishboneDevice](device:P,bus:B): Unit = {
        // val gen_peripheral = Module(bus)

        bus.io.reqOut <> device.io.req
        bus.io.rspIn  <> device.io.rsp

        // bus
    }

    // Specific method to connect GPIO
    private def connectGPIO[A <:AbstrRequest, B <: AbstrResponse](gpio: Gpio[A,B]): Unit = {
        val n = configs("GPIO")("n").asInstanceOf[Int]
        io.gpio_o.get       := gpio.io.cio_gpio_o(n - 1, 0)
        io.gpio_en_o.get    := gpio.io.cio_gpio_en_o(n - 1, 0)
        gpio.io.cio_gpio_i  := io.gpio_i.get
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
