import chisel3._
import chisel3.experimental.Analog
import chisel3.stage.ChiselStage

import caravan.bus.common._

import nucleusrv.components.{Core, Configs}

// abstract class AbstractCoreIO extends CoreIO

abstract trait AbstractCore
    // val io: AbstractCoreIO

class NRV(override implicit val config:Configs) extends Core with AbstractCore{
    // val io:CoreIO
}