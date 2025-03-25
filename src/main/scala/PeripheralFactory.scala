import java.io.File
import java.io.PrintWriter
import spray.json._
import DefaultJsonProtocol._

object PeripheralFactory extends App {

  def fileWriter(fileName: String, content: String) = {
      val pw = new PrintWriter(new File(fileName))
      pw.write(content)
      pw.close()
  }

  def idCount():Map[String, Int] = {
    val basePath = (os.pwd.toString)
    val jsonPath = "config.json"

    val file = scala.io.Source.fromFile(jsonPath).mkString

    val fileToJson = file.parseJson.convertTo[Map[String, JsValue]]
    val config = fileToJson.map({case (a,b) => a -> {if (b == JsNumber(1)) true else false}})

    var GPIO = 0; var SPI = 0; var UART = 0; var TIMER = 0; var SPIF = 0; var I2C = 0

    var dev_count = 1
    if (config("gpio") == true) {
      GPIO = dev_count
      dev_count += 1
    }

    if (config("spi") == true) {
      SPI = dev_count
      dev_count += 1
    }

    if (config("uart") == true){
      UART = dev_count
      dev_count += 1
    }

    if (config("timer") == true){
      TIMER = dev_count
      dev_count += 1
    }

    if (config("spi_flash") == true) {
      SPIF = dev_count
      dev_count += 1
    }

    if (config("i2c") == true) {
      I2C = dev_count
      dev_count += 1
    }

    return Map("DCCM" -> 0,
               "GPIO" -> GPIO,
               "SPI"  -> SPI,
               "UART" -> UART,
               "TIMER"-> TIMER,
               "SPIF" -> SPIF,
               "I2C"  -> I2C)
  }

  def peripheralManager():Map[String, Boolean] = {

    val basePath = (os.pwd.toString)
    val jsonPath = basePath+"/src/main/scala/config.json"

    val file = scala.io.Source.fromFile(jsonPath).mkString

    val fileToJson = file.parseJson.convertTo[Map[String, JsValue]]
    val config = fileToJson.map({case (a,b) => a -> {if (b == JsNumber(1)) true else false}})

    val base = """
        package caravan.bus.common
        import chisel3._
        import chisel3.experimental.ChiselEnum
        """

    val dccm = """
        object Peripherals extends ChiselEnum {
        val DCCM = Value(0.U)
      """

    val closer = "}"

    var content = base + dccm
    var dev_count = 1

    if (config("gpio") == true) {
      val gpio = s"""
        val GPIO = Value(${dev_count}.U)
      """
      content += gpio
      dev_count += 1
    }

    if (config("spi_flash") == true) {
      val spi_f = s"""
        val SPI  = Value(${dev_count}.U)
      """
      content += spi_f
      dev_count += 1
    }

    if (config("uart") == true){
      val uart = s"""
        val UART = Value(${dev_count}.U)
      """
      content += uart
      dev_count += 1
    }

    if (config("timer") == true){
      val timer = s"""
        val TIMER = Value(${dev_count}.U)
      """
      content += timer
      dev_count += 1
    }

    if (config("i2c") == true){
      val i2c = s"""
        val I2C = Value(${dev_count}.U)
      """
      content += i2c
      dev_count += 1
    }

    content += closer

    println(content)
    val caravanPath = basePath+"/caravan/src/main/scala/caravan/bus/common/PeripheralsMap.scala"
    fileWriter(caravanPath, content = content)

    return config
  }

}