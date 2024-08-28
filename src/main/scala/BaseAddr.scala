case class BaseAddr(
    DCCM            : String = "h40000000",
    GPIO            : String = "h40001000",
    SPI             : String = "h40002000",
    UART            : String = "h40003000",
    SPIF            : String = "h40004000",
    I2C             : String = "h40005000",
    TIMER           : String = "h40006000",
    BabyKyber       : String = "h40007000"
)

case class Mask(
    DCCM            : String = "h00000fff",
    GPIO            : String = "h00000fff",
    SPI             : String = "h00000fff",
    UART            : String = "h00000fff",
    SPIF            : String = "h00000fff",
    I2C             : String = "h00000fff",
    TIMER           : String = "h00000fff",
    BabyKyber       : String = "h00000fff"

)