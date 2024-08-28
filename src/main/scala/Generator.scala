import chisel3._
import nucleusrv.components.{Core, Configs}
import caravan.bus.common.{AddressMap, BusDecoder, Switch1toN, Peripherals}

import caravan.bus.tilelink.{TLRequest, TLResponse, TilelinkConfig, TilelinkDevice, TilelinkError, TilelinkHost, TilelinkMaster, TilelinkSlave, TilelinkCDevice}
import caravan.bus.wishbone.{WBRequest, WBResponse, WishboneConfig, WishboneDevice, WishboneHost, WishboneMaster, WishboneSlave}
import caravan.bus.wishbone.{WishboneErr}
import chisel3.experimental.Analog
import chisel3.stage.ChiselStage
import jigsaw.fpga.boards.artyA7._
import jigsaw.rams.fpga.BlockRam
import jigsaw.peripherals.gpio._
import jigsaw.peripherals.spiflash._
import jigsaw.peripherals.spi._
import jigsaw.peripherals.UART._
import jigsaw.peripherals.timer._
import jigsaw.peripherals.i2c._

import BabyKyberAcceleratorCHISEL.BabyKyber.BabyKyberTop
// import ccache.caches.DMCache

class SoCNow(programFile: Option[String],
                 configs:Map[Any, Map[Any, Any]]) extends Module {

    val n = configs("GPIO")("n").asInstanceOf[Int]

    val io = IO(new GeneratorIOs(configs = configs, fpga = true))

    val gen = Module(new Generator(programFile, configs))
    val pll = Module(new PLL_8MHz())

    pll.io.clk_in1 := clock
    gen.clock := pll.io.clk_out1

    if(configs("GPIO")("is").asInstanceOf[Boolean]){
      val gpioInputWires = Wire(Vec(n, Bool()))
      val gpioOutputWires = Wire(Vec(n, Bool()))
      val gpioEnableWires = Wire(Vec(n, Bool()))

      val gpioPads = TriStateBuffer(quantity=n)
      val triStateBufferWires = for {
        ((((a,b),c),d),e) <- gpioPads zip gpioInputWires zip gpioOutputWires zip gpioEnableWires zip io.gpio_io.get
      } yield (a,b,c,d,e)

      triStateBufferWires map { case(buf: IOBUF, in: Bool, out: Bool, en: Bool, io: Analog) => {
        buf.io.connect(in, out, io, en)
      }}

      gen.io.gpio_i.get := gpioInputWires.asUInt()
      gpioOutputWires := gen.io.gpio_o.get.asBools()
      gpioEnableWires := gen.io.gpio_en_o.get.asBools()
    }
    if(configs("SPIF")("is").asInstanceOf[Boolean]){
      io.spi_flash_cs_n.get := gen.io.spi_flash_cs_n.get
      io.spi_flash_sclk.get := gen.io.spi_flash_sclk.get
      io.spi_flash_mosi.get := gen.io.spi_flash_mosi.get
      gen.io.spi_flash_miso.get := io.spi_flash_miso.get
    }
    if(configs("SPI")("is").asInstanceOf[Boolean]){
      io.spi_cs_n.get := gen.io.spi_cs_n.get
      io.spi_sclk.get := gen.io.spi_sclk.get
      io.spi_mosi.get := gen.io.spi_mosi.get
      gen.io.spi_miso.get := io.spi_miso.get
    }
    if(configs("UART")("is").asInstanceOf[Boolean]){
      io.cio_uart_intr_tx_o.get := gen.io.cio_uart_intr_tx_o.get
      io.cio_uart_tx_o.get := gen.io.cio_uart_tx_o.get
      gen.io.cio_uart_rx_i.get := io.cio_uart_rx_i.get
    }
    if(configs("TIMER")("is").asInstanceOf[Boolean]){
      io.timer_intr_cmp.get := gen.io.timer_intr_cmp.get
      io.timer_intr_ovf.get := gen.io.timer_intr_ovf.get
    }
    if(configs("I2C")("is").asInstanceOf[Boolean]){
      io.i2c_sda.get := gen.io.i2c_sda.get
      io.i2c_scl.get := gen.io.i2c_scl.get
      io.i2c_intr.get := gen.io.i2c_intr.get
      gen.io.i2c_sda_in.get := io.i2c_sda_in.get
    }
}

class GeneratorIOs(configs:Map[Any, Map[Any, Any]], fpga:Boolean = false) extends Bundle{
    val n = configs("GPIO")("n").asInstanceOf[Int]

    val gpio_io = if (configs("GPIO")("is").asInstanceOf[Boolean] & fpga) Some(Vec(n, Analog(1.W))) else None

    val gpio_o = if (configs("GPIO")("is").asInstanceOf[Boolean] & !fpga) Some(Output(UInt(n.W))) else None       
    val gpio_en_o = if (configs("GPIO")("is").asInstanceOf[Boolean] & !fpga) Some(Output(UInt(n.W))) else None 
    val gpio_i = if (configs("GPIO")("is").asInstanceOf[Boolean] & !fpga) Some(Input(UInt(n.W))) else None 

    val spi_cs_n = if (configs("SPI")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None 
    val spi_sclk = if (configs("SPI")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None 
    val spi_mosi = if (configs("SPI")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None 
    val spi_miso = if (configs("SPI")("is").asInstanceOf[Boolean]) Some(Input(Bool()))  else None 

    val cio_uart_rx_i = if (configs("UART")("is").asInstanceOf[Boolean]) Some(Input(Bool())) else None 
    val cio_uart_tx_o = if (configs("UART")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None 
    val cio_uart_intr_tx_o = if (configs("UART")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None 

    val timer_intr_cmp = if (configs("TIMER")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None 
    val timer_intr_ovf = if (configs("TIMER")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None 

    val spi_flash_cs_n = if (configs("SPIF")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None 
    val spi_flash_sclk = if (configs("SPIF")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None          
    val spi_flash_mosi = if (configs("SPIF")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None
    val spi_flash_miso = if (configs("SPIF")("is").asInstanceOf[Boolean]) Some(Input(Bool()))  else None

    val i2c_sda_in = if (configs("I2C")("is").asInstanceOf[Boolean]) Some(Input(Bool())) else None 
    val i2c_sda = if (configs("I2C")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None 
    val i2c_scl = if (configs("I2C")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None 
    val i2c_intr = if (configs("I2C")("is").asInstanceOf[Boolean]) Some(Output(Bool())) else None 
}

class Generator(programFile: Option[String],
                 configs:Map[Any, Map[Any, Any]]) extends Module {

  val n = configs("GPIO")("n").asInstanceOf[Int]

  val io = IO(new GeneratorIOs(configs))

  if (configs("WB")("is").asInstanceOf[Boolean]){
    implicit val config:WishboneConfig = WishboneConfig(32,32)

    val gen_imem_host = Module(new WishboneHost())
    val gen_imem_slave = Module(new WishboneDevice())
    val gen_dmem_host = Module(new WishboneHost())
    val gen_dmem_slave = Module(new WishboneDevice())

    val addressMap = new AddressMap

    Peripherals.addValuesFromJson("peripherals.json")

    addressMap.addDevice(Peripherals.get("DCCM"), configs("DCCM")("baseAddr").asInstanceOf[String].U(32.W), configs("GPIO")("mask").asInstanceOf[String].U(32.W), gen_dmem_slave)

    if(configs("GPIO")("is").asInstanceOf[Boolean]){
        // GPIO
        val gpio = Module(new Gpio(new WBRequest(), new WBResponse()))
        val gen_gpio_slave = Module(new WishboneDevice())

        gen_gpio_slave.io.reqOut <> gpio.io.req
        gen_gpio_slave.io.rspIn <> gpio.io.rsp

        io.gpio_o.get := gpio.io.cio_gpio_o(n-1,0)
        io.gpio_en_o.get := gpio.io.cio_gpio_en_o(n-1,0)
        gpio.io.cio_gpio_i := io.gpio_i.get

        addressMap.addDevice(Peripherals.get("GPIO"), configs("GPIO")("baseAddr").asInstanceOf[String].U(32.W), configs("GPIO")("mask").asInstanceOf[String].U(32.W), gen_gpio_slave)
      //
    }
    if(configs("SPI")("is").asInstanceOf[Boolean]){
      val spi = Module(new Spi(new WBRequest(), new WBResponse()))
      val gen_spi_slave = Module(new WishboneDevice())

      gen_spi_slave.io.reqOut <> spi.io.req
      gen_spi_slave.io.rspIn <> spi.io.rsp

      io.spi_cs_n.get := spi.io.cs_n
      io.spi_sclk.get := spi.io.sclk
      io.spi_mosi.get := spi.io.mosi
      spi.io.miso := io.spi_miso.get

      addressMap.addDevice(Peripherals.get("SPI"), configs("SPI")("baseAddr").asInstanceOf[String].U(32.W), configs("SPI")("mask").asInstanceOf[String].U(32.W), gen_spi_slave)
    }
    if (configs("UART")("is").asInstanceOf[Boolean]){
      val uart = Module(new uart(new WBRequest(), new WBResponse()))
      val gen_uart_slave = Module(new WishboneDevice())

      gen_uart_slave.io.reqOut <> uart.io.request
      gen_uart_slave.io.rspIn <> uart.io.response

      uart.io.cio_uart_rx_i := io.cio_uart_rx_i.get
      io.cio_uart_tx_o.get := uart.io.cio_uart_tx_o
      io.cio_uart_intr_tx_o.get := uart.io.cio_uart_intr_tx_o  

      addressMap.addDevice(Peripherals.get("UART"), configs("UART")("baseAddr").asInstanceOf[String].U(32.W), configs("UART")("mask").asInstanceOf[String].U(32.W), gen_uart_slave)
    }
    if (configs("TIMER")("is").asInstanceOf[Boolean]){
      val timer = Module(new Timer(new WBRequest(), new WBResponse()))
      val gen_timer_slave = Module(new WishboneDevice())

      gen_timer_slave.io.reqOut <> timer.io.req
      gen_timer_slave.io.rspIn <> timer.io.rsp 

      io.timer_intr_cmp.get := timer.io.cio_timer_intr_cmp
      io.timer_intr_ovf.get := timer.io.cio_timer_intr_ovf

      addressMap.addDevice(Peripherals.get("TIMER"), configs("TIMER")("baseAddr").asInstanceOf[String].U(32.W), configs("TIMER")("mask").asInstanceOf[String].U(32.W), gen_timer_slave)
    }
    if (configs("SPIF")("is").asInstanceOf[Boolean]){
      val spi_flash = Module(new SpiFlash(new WBRequest(), new WBResponse()))
      val gen_spi_flash_slave = Module(new WishboneDevice())

      gen_spi_flash_slave.io.reqOut <> spi_flash.io.req
      gen_spi_flash_slave.io.rspIn <> spi_flash.io.rsp

      io.spi_flash_cs_n.get := spi_flash.io.cs_n
      io.spi_flash_sclk.get := spi_flash.io.sclk
      io.spi_flash_mosi.get := spi_flash.io.mosi
      spi_flash.io.miso := io.spi_flash_miso.get

      addressMap.addDevice(Peripherals.get("SPIF"), configs("SPIF")("baseAddr").asInstanceOf[String].U(32.W), configs("SPIF")("mask").asInstanceOf[String].U(32.W), gen_spi_flash_slave)
    }
    if (configs("I2C")("is").asInstanceOf[Boolean]){
      val i2c = Module(new i2c(new WBRequest(), new WBResponse()))
      val gen_i2c_slave = Module(new WishboneDevice())

      gen_i2c_slave.io.reqOut <> i2c.io.request
      gen_i2c_slave.io.rspIn <> i2c.io.response 

      i2c.io.cio_i2c_sda_in := io.i2c_sda_in.get
      io.i2c_sda.get := i2c.io.cio_i2c_sda
      io.i2c_scl.get := i2c.io.cio_i2c_scl
      io.i2c_intr.get := i2c.io.cio_i2c_intr

      addressMap.addDevice(Peripherals.get("I2C"), configs("I2C")("baseAddr").asInstanceOf[String].U(32.W), configs("I2C")("mask").asInstanceOf[String].U(32.W), gen_i2c_slave)

    }

    if (configs("BabyKyber")("is").asInstanceOf[Boolean]){

      val babykyber = Module(new BabyKyberTop())
      val gen_babykyber_slave = Module(new WishboneDevice())

      gen_babykyber_slave.io.reqOut <> babykyber.io.req
      gen_babykyber_slave.io.rspIn  <> babykyber.io.rsp

      addressMap.addDevice(Peripherals.get("BabyKyber"), configs("BabyKyber")("baseAddr").asInstanceOf[String].U(32.W), configs("BabyKyber")("mask").asInstanceOf[String].U(32.W), gen_babykyber_slave)
    }

    val imem = Module(BlockRam.createNonMaskableRAM(programFile, bus=config, rows=1024))
    val dmem = Module(BlockRam.createMaskableRAM(bus=config, rows=1024))
    
    val wbErr = Module(new WishboneErr())

    implicit val coreconfig = Configs()
    val core = Module(new Core())

    core.io.stall := false.B


    val devices = addressMap.getDevices

    val switch = Module(new Switch1toN(new WishboneMaster(), new WishboneSlave(), devices.size))

    // wb <-> Core (fetch)
    gen_imem_host.io.reqIn <> core.io.imemReq
    core.io.imemRsp <> gen_imem_host.io.rspOut
    gen_imem_slave.io.reqOut <> imem.io.req
    gen_imem_slave.io.rspIn <> imem.io.rsp

    // wb <-> wb (fetch)
    gen_imem_host.io.wbMasterTransmitter <> gen_imem_slave.io.wbMasterReceiver
    gen_imem_slave.io.wbSlaveTransmitter <> gen_imem_host.io.wbSlaveReceiver

    // wb <-> Core (memory)
    gen_dmem_host.io.reqIn <> core.io.dmemReq
    core.io.dmemRsp <> gen_dmem_host.io.rspOut
    gen_dmem_slave.io.reqOut <> dmem.io.req
    gen_dmem_slave.io.rspIn <> dmem.io.rsp


    // Switch connection
    switch.io.hostIn <> gen_dmem_host.io.wbMasterTransmitter
    switch.io.hostOut <> gen_dmem_host.io.wbSlaveReceiver
    for (i <- 0 until devices.size) {
      switch.io.devIn(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[WishboneDevice].io.wbSlaveTransmitter
      switch.io.devOut(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[WishboneDevice].io.wbMasterReceiver
    }
    switch.io.devIn(devices.size) <> wbErr.io.wbSlaveTransmitter
    switch.io.devOut(devices.size) <> wbErr.io.wbMasterReceiver
    switch.io.devSel := BusDecoder.decode(gen_dmem_host.io.wbMasterTransmitter.bits.adr, addressMap)
  }
  else if (configs("TL")("is").asInstanceOf[Boolean]){
    implicit val config:TilelinkConfig = TilelinkConfig(10,32)

    val gen_imem_host = Module(new TilelinkHost())
    val gen_imem_slave = Module(new TilelinkDevice())
    val gen_dmem_host = Module(new TilelinkHost())
    val gen_dmem_slave = Module(new TilelinkDevice())

    val addressMap = new AddressMap

    Peripherals.addValuesFromJson("peripherals.json")

    addressMap.addDevice(Peripherals.get("DCCM"), configs("DCCM")("baseAddr").asInstanceOf[String].U(32.W), configs("GPIO")("mask").asInstanceOf[String].U(32.W), gen_dmem_slave)

    if(configs("GPIO")("is").asInstanceOf[Boolean]){
        // GPIO
        val gpio = Module(new Gpio(new TLRequest(), new TLResponse()))
        val gen_gpio_slave = Module(new TilelinkDevice())

        gen_gpio_slave.io.reqOut <> gpio.io.req
        gen_gpio_slave.io.rspIn <> gpio.io.rsp

        io.gpio_o.get := gpio.io.cio_gpio_o(n-1,0)
        io.gpio_en_o.get := gpio.io.cio_gpio_en_o(n-1,0)
        gpio.io.cio_gpio_i := io.gpio_i.get

        addressMap.addDevice(Peripherals.get("GPIO"), configs("GPIO")("baseAddr").asInstanceOf[String].U(32.W), configs("GPIO")("mask").asInstanceOf[String].U(32.W), gen_gpio_slave)
      //
    }
    if(configs("SPI")("is").asInstanceOf[Boolean]){
      val spi = Module(new Spi(new TLRequest(), new TLResponse()))
      val gen_spi_slave = Module(new TilelinkDevice())

      gen_spi_slave.io.reqOut <> spi.io.req
      gen_spi_slave.io.rspIn <> spi.io.rsp

      io.spi_cs_n.get := spi.io.cs_n
      io.spi_sclk.get := spi.io.sclk
      io.spi_mosi.get := spi.io.mosi
      spi.io.miso := io.spi_miso.get

      addressMap.addDevice(Peripherals.get("SPI"), configs("SPI")("baseAddr").asInstanceOf[String].U(32.W), configs("SPI")("mask").asInstanceOf[String].U(32.W), gen_spi_slave)
    }
    if (configs("UART")("is").asInstanceOf[Boolean]){
      val uart = Module(new uart(new TLRequest(), new TLResponse()))
      val gen_uart_slave = Module(new TilelinkDevice())

      gen_uart_slave.io.reqOut <> uart.io.request
      gen_uart_slave.io.rspIn <> uart.io.response

      uart.io.cio_uart_rx_i := io.cio_uart_rx_i.get
      io.cio_uart_tx_o.get := uart.io.cio_uart_tx_o
      io.cio_uart_intr_tx_o.get := uart.io.cio_uart_intr_tx_o  

      addressMap.addDevice(Peripherals.get("UART"), configs("UART")("baseAddr").asInstanceOf[String].U(32.W), configs("UART")("mask").asInstanceOf[String].U(32.W), gen_uart_slave)
    }
    if (configs("TIMER")("is").asInstanceOf[Boolean]){
      val timer = Module(new Timer(new TLRequest(), new TLResponse()))
      val gen_timer_slave = Module(new TilelinkDevice())

      gen_timer_slave.io.reqOut <> timer.io.req
      gen_timer_slave.io.rspIn <> timer.io.rsp 

      io.timer_intr_cmp.get := timer.io.cio_timer_intr_cmp
      io.timer_intr_ovf.get := timer.io.cio_timer_intr_ovf

      addressMap.addDevice(Peripherals.get("TIMER"), configs("TIMER")("baseAddr").asInstanceOf[String].U(32.W), configs("TIMER")("mask").asInstanceOf[String].U(32.W), gen_timer_slave)
    }
    if (configs("SPIF")("is").asInstanceOf[Boolean]){
      val spi_flash = Module(new SpiFlash(new TLRequest(), new TLResponse()))
      val gen_spi_flash_slave = Module(new TilelinkDevice())

      gen_spi_flash_slave.io.reqOut <> spi_flash.io.req
      gen_spi_flash_slave.io.rspIn <> spi_flash.io.rsp

      io.spi_flash_cs_n.get := spi_flash.io.cs_n
      io.spi_flash_sclk.get := spi_flash.io.sclk
      io.spi_flash_mosi.get := spi_flash.io.mosi
      spi_flash.io.miso := io.spi_flash_miso.get

      addressMap.addDevice(Peripherals.get("SPIF"), configs("SPIF")("baseAddr").asInstanceOf[String].U(32.W), configs("SPIF")("mask").asInstanceOf[String].U(32.W), gen_spi_flash_slave)
    }
    if (configs("I2C")("is").asInstanceOf[Boolean]){
      val i2c = Module(new i2c(new TLRequest(), new TLResponse()))
      val gen_i2c_slave = Module(new TilelinkDevice())

      gen_i2c_slave.io.reqOut <> i2c.io.request
      gen_i2c_slave.io.rspIn <> i2c.io.response 

      i2c.io.cio_i2c_sda_in := io.i2c_sda_in.get
      io.i2c_sda.get := i2c.io.cio_i2c_sda
      io.i2c_scl.get := i2c.io.cio_i2c_scl
      io.i2c_intr.get := i2c.io.cio_i2c_intr

      addressMap.addDevice(Peripherals.get("I2C"), configs("I2C")("baseAddr").asInstanceOf[String].U(32.W), configs("I2C")("mask").asInstanceOf[String].U(32.W), gen_i2c_slave)

    }

    val imem = Module(BlockRam.createNonMaskableRAM(programFile, bus=config, rows=1024))
    val dmem = Module(BlockRam.createMaskableRAM(bus=config, rows=1024))
    
    val tlErr = Module(new TilelinkError())
    implicit val coreconfig = Configs()
    val core = Module(new Core())

    core.io.stall := false.B


    val devices = addressMap.getDevices

    val switch = Module(new Switch1toN(new TilelinkMaster(), new TilelinkSlave(), devices.size))

    // TL <-> Core (fetch)
    gen_imem_host.io.reqIn <> core.io.imemReq
    core.io.imemRsp <> gen_imem_host.io.rspOut
    gen_imem_slave.io.reqOut <> imem.io.req
    gen_imem_slave.io.rspIn <> imem.io.rsp

    // TL <-> TL (fetch)
    gen_imem_host.io.tlMasterTransmitter <> gen_imem_slave.io.tlMasterReceiver
    gen_imem_slave.io.tlSlaveTransmitter <> gen_imem_host.io.tlSlaveReceiver

    // TL <-> Core (memory)
    gen_dmem_host.io.reqIn <> core.io.dmemReq
    core.io.dmemRsp <> gen_dmem_host.io.rspOut
    gen_dmem_slave.io.reqOut <> dmem.io.req
    gen_dmem_slave.io.rspIn <> dmem.io.rsp


    // Switch connection
    switch.io.hostIn <> gen_dmem_host.io.tlMasterTransmitter
    switch.io.hostOut <> gen_dmem_host.io.tlSlaveReceiver
    for (i <- 0 until devices.size) {
      switch.io.devIn(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[TilelinkDevice].io.tlSlaveTransmitter
      switch.io.devOut(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[TilelinkDevice].io.tlMasterReceiver
    }
    switch.io.devIn(devices.size) <> tlErr.io.tlSlaveTransmitter
    switch.io.devOut(devices.size) <> tlErr.io.tlMasterReceiver
    switch.io.devSel := BusDecoder.decode(gen_dmem_host.io.tlMasterTransmitter.bits.a_address, addressMap)
  }/**
  else if (configs("TLC")("is").asInstanceOf[Boolean]){
    implicit val config:TilelinkConfig = TilelinkConfig(10,32)

    val gen_imem_host = Module(new TilelinkHost())
    val gen_imem_slave = Module(new TilelinkDevice())
    val gen_dmem_host = Module(new DMCache(4, 10, 32)(new TLRequest(), new TLResponse()))
    val gen_dmem_slave = Module(new TilelinkDevice())

    val addressMap = new AddressMap

    addressMap.addDevice(Peripherals.all(configs("DCCM")("id").asInstanceOf[Int]), configs("DCCM")("baseAddr").asInstanceOf[String].U(32.W), configs("GPIO")("mask").asInstanceOf[String].U(32.W), gen_dmem_slave)

    if(configs("GPIO")("is").asInstanceOf[Boolean]){
        // GPIO
        val gpio = Module(new Gpio(new TLRequest(), new TLResponse()))
        val gen_gpio_slave = Module(new TilelinkDevice())

        gen_gpio_slave.io.reqOut <> gpio.io.req
        gen_gpio_slave.io.rspIn <> gpio.io.rsp

        io.gpio_o.get := gpio.io.cio_gpio_o(n-1,0)
        io.gpio_en_o.get := gpio.io.cio_gpio_en_o(n-1,0)
        gpio.io.cio_gpio_i := io.gpio_i.get

        addressMap.addDevice(Peripherals.all(configs("GPIO")("id").asInstanceOf[Int]), configs("GPIO")("baseAddr").asInstanceOf[String].U(32.W), configs("GPIO")("mask").asInstanceOf[String].U(32.W), gen_gpio_slave)
      //
    }
    if(configs("SPI")("is").asInstanceOf[Boolean]){
      val spi = Module(new Spi(new TLRequest(), new TLResponse()))
      val gen_spi_slave = Module(new TilelinkDevice())

      gen_spi_slave.io.reqOut <> spi.io.req
      gen_spi_slave.io.rspIn <> spi.io.rsp

      io.spi_cs_n.get := spi.io.cs_n
      io.spi_sclk.get := spi.io.sclk
      io.spi_mosi.get := spi.io.mosi
      spi.io.miso := io.spi_miso.get

      addressMap.addDevice(Peripherals.all(configs("SPI")("id").asInstanceOf[Int]), configs("SPI")("baseAddr").asInstanceOf[String].U(32.W), configs("SPI")("mask").asInstanceOf[String].U(32.W), gen_spi_slave)
    }
    if (configs("UART")("is").asInstanceOf[Boolean]){
      val uart = Module(new uart(new TLRequest(), new TLResponse()))
      val gen_uart_slave = Module(new TilelinkDevice())

      gen_uart_slave.io.reqOut <> uart.io.request
      gen_uart_slave.io.rspIn <> uart.io.response

      uart.io.cio_uart_rx_i := io.cio_uart_rx_i.get
      io.cio_uart_tx_o.get := uart.io.cio_uart_tx_o
      io.cio_uart_intr_tx_o.get := uart.io.cio_uart_intr_tx_o  

      addressMap.addDevice(Peripherals.all(configs("UART")("id").asInstanceOf[Int]), configs("UART")("baseAddr").asInstanceOf[String].U(32.W), configs("UART")("mask").asInstanceOf[String].U(32.W), gen_uart_slave)
    }
    if (configs("TIMER")("is").asInstanceOf[Boolean]){
      val timer = Module(new Timer(new TLRequest(), new TLResponse()))
      val gen_timer_slave = Module(new TilelinkDevice())

      gen_timer_slave.io.reqOut <> timer.io.req
      gen_timer_slave.io.rspIn <> timer.io.rsp 

      io.timer_intr_cmp.get := timer.io.cio_timer_intr_cmp
      io.timer_intr_ovf.get := timer.io.cio_timer_intr_ovf

      addressMap.addDevice(Peripherals.all(configs("TIMER")("id").asInstanceOf[Int]), configs("TIMER")("baseAddr").asInstanceOf[String].U(32.W), configs("TIMER")("mask").asInstanceOf[String].U(32.W), gen_timer_slave)
    }
    if (configs("SPIF")("is").asInstanceOf[Boolean]){
      val spi_flash = Module(new SpiFlash(new TLRequest(), new TLResponse()))
      val gen_spi_flash_slave = Module(new TilelinkDevice())

      gen_spi_flash_slave.io.reqOut <> spi_flash.io.req
      gen_spi_flash_slave.io.rspIn <> spi_flash.io.rsp

      io.spi_flash_cs_n.get := spi_flash.io.cs_n
      io.spi_flash_sclk.get := spi_flash.io.sclk
      io.spi_flash_mosi.get := spi_flash.io.mosi
      spi_flash.io.miso := io.spi_flash_miso.get

      addressMap.addDevice(Peripherals.all(configs("SPIF")("id").asInstanceOf[Int]), configs("SPIF")("baseAddr").asInstanceOf[String].U(32.W), configs("SPIF")("mask").asInstanceOf[String].U(32.W), gen_spi_flash_slave)
    }
    if (configs("I2C")("is").asInstanceOf[Boolean]){
      val i2c = Module(new i2c(new TLRequest(), new TLResponse()))
      val gen_i2c_slave = Module(new TilelinkDevice())

      gen_i2c_slave.io.reqOut <> i2c.io.request
      gen_i2c_slave.io.rspIn <> i2c.io.response 

      i2c.io.cio_i2c_sda_in := io.i2c_sda_in.get
      io.i2c_sda.get := i2c.io.cio_i2c_sda
      io.i2c_scl.get := i2c.io.cio_i2c_scl
      io.i2c_intr.get := i2c.io.cio_i2c_intr

      addressMap.addDevice(Peripherals.all(configs("I2C")("id").asInstanceOf[Int]), configs("I2C")("baseAddr").asInstanceOf[String].U(32.W), configs("I2C")("mask").asInstanceOf[String].U(32.W), gen_i2c_slave)

    }

    val imem = Module(BlockRam.createNonMaskableRAM(programFile, bus=config, rows=1024))
    val dmem = Module(BlockRam.createMaskableRAM(bus=config, rows=1024))
    
    val tlErr = Module(new TilelinkError())
    val core = Module(new Core(new TLRequest, new TLResponse)(M = configs("M")("is").asInstanceOf[Boolean]))


    val devices = addressMap.getDevices

    val switch = Module(new Switch1toN(new TilelinkMaster(), new TilelinkSlave(), devices.size))

    // TL <-> Core (fetch)
    gen_imem_host.io.reqIn <> core.io.imemReq
    core.io.imemRsp <> gen_imem_host.io.rspOut
    gen_imem_slave.io.reqOut <> imem.io.req
    gen_imem_slave.io.rspIn <> imem.io.rsp

    // TL <-> TL (fetch)
    gen_imem_host.io.tlMasterTransmitter <> gen_imem_slave.io.tlMasterReceiver
    gen_imem_slave.io.tlSlaveTransmitter <> gen_imem_host.io.tlSlaveReceiver

    // TL <-> Core (memory)
    gen_dmem_host.io.reqIn <> core.io.dmemReq
    core.io.dmemRsp <> gen_dmem_host.io.rspOut
    gen_dmem_slave.io.reqOut <> dmem.io.req
    gen_dmem_slave.io.rspIn <> dmem.io.rsp


    // Switch connection
    switch.io.hostIn <> gen_dmem_host.io.tlMasterTransmitter
    switch.io.hostOut <> gen_dmem_host.io.tlSlaveReceiver
    for (i <- 0 until devices.size) {
      switch.io.devIn(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[TilelinkDevice].io.tlSlaveTransmitter
      switch.io.devOut(devices(i)._2.litValue().toInt) <> devices(i)._1.asInstanceOf[TilelinkDevice].io.tlMasterReceiver
    }
    switch.io.devIn(devices.size) <> tlErr.io.tlSlaveTransmitter
    switch.io.devOut(devices.size) <> tlErr.io.tlMasterReceiver
    switch.io.devSel := BusDecoder.decode(gen_dmem_host.io.tlMasterTransmitter.bits.a_address, addressMap)
  }**/
}

import spray.json._
import DefaultJsonProtocol._

object GeneratorDriver extends App {

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
                                           "TLC"   -> Map("is" -> oneZero("tlc")),
                                           "BabyKyber"   -> Map("is" -> oneZero("babykyber"), "is" -> oneZero("babykyber") , "baseAddr" -> baseAddr.BabyKyber , "mask" -> mask.BabyKyber )
                                           )

  (new ChiselStage).emitVerilog(new Generator(programFile=None, configs))
}

object SoCNowDriver extends App {

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
                                           "TLC"   -> Map("is" -> oneZero("tlc")),
                                           "BabyKyber"   -> Map("is" -> oneZero("babykyber"), "is" -> oneZero("babykyber") , "baseAddr" -> baseAddr.BabyKyber , "mask" -> mask.BabyKyber )
                                           )

  (new ChiselStage).emitVerilog(new SoCNow(programFile=None, configs))
}