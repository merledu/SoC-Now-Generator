module WishboneHost(
  input         clock,
  input         reset,
  input         io_wbMasterTransmitter_ready,
  output        io_wbMasterTransmitter_valid,
  output        io_wbMasterTransmitter_bits_cyc,
  output        io_wbMasterTransmitter_bits_stb,
  output        io_wbMasterTransmitter_bits_we,
  output [31:0] io_wbMasterTransmitter_bits_adr,
  output [31:0] io_wbMasterTransmitter_bits_dat,
  output        io_wbSlaveReceiver_ready,
  input         io_wbSlaveReceiver_bits_ack,
  input  [31:0] io_wbSlaveReceiver_bits_dat,
  input         io_wbSlaveReceiver_bits_err,
  output        io_reqIn_ready,
  input         io_reqIn_valid,
  input  [31:0] io_reqIn_bits_addrRequest,
  input  [31:0] io_reqIn_bits_dataRequest,
  input         io_reqIn_bits_isWrite,
  output        io_rspOut_valid,
  output [31:0] io_rspOut_bits_dataResponse,
  output        io_rspOut_bits_error
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg  startWBTransaction; // @[WishboneHost.scala 39:35]
  reg [31:0] dataReg; // @[WishboneHost.scala 41:24]
  reg  respReg; // @[WishboneHost.scala 42:24]
  reg  errReg; // @[WishboneHost.scala 43:23]
  reg  stbReg; // @[WishboneHost.scala 46:23]
  reg  cycReg; // @[WishboneHost.scala 47:23]
  reg  weReg; // @[WishboneHost.scala 48:22]
  reg [31:0] datReg; // @[WishboneHost.scala 49:23]
  reg [31:0] adrReg; // @[WishboneHost.scala 50:23]
  reg  stateReg; // @[WishboneHost.scala 56:25]
  reg  readyReg; // @[WishboneHost.scala 62:25]
  wire  _T_2 = io_reqIn_valid & io_wbMasterTransmitter_ready; // @[WishboneHost.scala 18:37]
  wire  _GEN_0 = _T_2 ? 1'h0 : readyReg; // @[WishboneHost.scala 63:14 WishboneHost.scala 64:14 WishboneHost.scala 62:25]
  wire  _GEN_1 = stateReg | _GEN_0; // @[WishboneHost.scala 66:33 WishboneHost.scala 67:14]
  wire  _GEN_2 = io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | startWBTransaction; // @[WishboneHost.scala 85:92 WishboneHost.scala 86:26 WishboneHost.scala 39:35]
  wire  _GEN_3 = io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | stbReg; // @[WishboneHost.scala 85:92 WishboneHost.scala 87:14 WishboneHost.scala 46:23]
  wire  _GEN_4 = io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | cycReg; // @[WishboneHost.scala 85:92 WishboneHost.scala 88:14 WishboneHost.scala 47:23]
  wire  _GEN_9 = ~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | _GEN_2; // @[WishboneHost.scala 77:86 WishboneHost.scala 78:26]
  wire  _GEN_10 = ~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | _GEN_3; // @[WishboneHost.scala 77:86 WishboneHost.scala 79:14]
  wire  _GEN_11 = ~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid | _GEN_4; // @[WishboneHost.scala 77:86 WishboneHost.scala 80:14]
  wire  _GEN_23 = io_wbSlaveReceiver_bits_err & ~io_wbSlaveReceiver_bits_ack | respReg; // @[WishboneHost.scala 112:78 WishboneHost.scala 114:15 WishboneHost.scala 42:24]
  wire  _GEN_24 = io_wbSlaveReceiver_bits_err & ~io_wbSlaveReceiver_bits_ack | errReg; // @[WishboneHost.scala 112:78 WishboneHost.scala 115:14 WishboneHost.scala 43:23]
  wire  _GEN_27 = io_wbSlaveReceiver_bits_ack & ~io_wbSlaveReceiver_bits_err | _GEN_23; // @[WishboneHost.scala 106:71 WishboneHost.scala 108:15]
  assign io_wbMasterTransmitter_valid = io_wbMasterTransmitter_bits_stb; // @[WishboneHost.scala 23:32]
  assign io_wbMasterTransmitter_bits_cyc = ~startWBTransaction ? 1'h0 : cycReg; // @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 96:37]
  assign io_wbMasterTransmitter_bits_stb = ~startWBTransaction ? 1'h0 : stbReg; // @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 95:37]
  assign io_wbMasterTransmitter_bits_we = ~startWBTransaction ? 1'h0 : weReg; // @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 97:36]
  assign io_wbMasterTransmitter_bits_adr = ~startWBTransaction ? 32'h0 : adrReg; // @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 98:37]
  assign io_wbMasterTransmitter_bits_dat = ~startWBTransaction ? 32'h0 : datReg; // @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 99:37]
  assign io_wbSlaveReceiver_ready = 1'h1; // @[WishboneHost.scala 26:28]
  assign io_reqIn_ready = readyReg; // @[WishboneHost.scala 76:20]
  assign io_rspOut_valid = respReg; // @[WishboneHost.scala 128:21]
  assign io_rspOut_bits_dataResponse = dataReg; // @[WishboneHost.scala 129:33]
  assign io_rspOut_bits_error = errReg; // @[WishboneHost.scala 130:26]
  always @(posedge clock) begin
    if (reset) begin // @[WishboneHost.scala 39:35]
      startWBTransaction <= 1'h0; // @[WishboneHost.scala 39:35]
    end else if (io_wbSlaveReceiver_bits_ack & ~io_wbSlaveReceiver_bits_err) begin // @[WishboneHost.scala 106:71]
      startWBTransaction <= 1'h0; // @[WishboneHost.scala 111:26]
    end else if (io_wbSlaveReceiver_bits_err & ~io_wbSlaveReceiver_bits_ack) begin // @[WishboneHost.scala 112:78]
      startWBTransaction <= 1'h0; // @[WishboneHost.scala 116:26]
    end else begin
      startWBTransaction <= _GEN_9;
    end
    if (reset) begin // @[WishboneHost.scala 41:24]
      dataReg <= 32'h0; // @[WishboneHost.scala 41:24]
    end else if (io_wbSlaveReceiver_bits_ack & ~io_wbSlaveReceiver_bits_err) begin // @[WishboneHost.scala 106:71]
      dataReg <= io_wbSlaveReceiver_bits_dat; // @[WishboneHost.scala 107:15]
    end else if (io_wbSlaveReceiver_bits_err & ~io_wbSlaveReceiver_bits_ack) begin // @[WishboneHost.scala 112:78]
      dataReg <= io_wbSlaveReceiver_bits_dat; // @[WishboneHost.scala 113:15]
    end
    if (reset) begin // @[WishboneHost.scala 42:24]
      respReg <= 1'h0; // @[WishboneHost.scala 42:24]
    end else if (~stateReg) begin // @[WishboneHost.scala 119:29]
      respReg <= _GEN_27;
    end else if (stateReg) begin // @[WishboneHost.scala 121:42]
      respReg <= 1'h0; // @[WishboneHost.scala 122:15]
    end else begin
      respReg <= _GEN_27;
    end
    if (reset) begin // @[WishboneHost.scala 43:23]
      errReg <= 1'h0; // @[WishboneHost.scala 43:23]
    end else if (io_wbSlaveReceiver_bits_ack & ~io_wbSlaveReceiver_bits_err) begin // @[WishboneHost.scala 106:71]
      errReg <= 1'h0; // @[WishboneHost.scala 109:14]
    end else begin
      errReg <= _GEN_24;
    end
    if (reset) begin // @[WishboneHost.scala 46:23]
      stbReg <= 1'h0; // @[WishboneHost.scala 46:23]
    end else begin
      stbReg <= _GEN_10;
    end
    if (reset) begin // @[WishboneHost.scala 47:23]
      cycReg <= 1'h0; // @[WishboneHost.scala 47:23]
    end else begin
      cycReg <= _GEN_11;
    end
    if (reset) begin // @[WishboneHost.scala 48:22]
      weReg <= 1'h0; // @[WishboneHost.scala 48:22]
    end else if (~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 77:86]
      weReg <= io_reqIn_bits_isWrite; // @[WishboneHost.scala 81:13]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 85:92]
      weReg <= io_reqIn_bits_isWrite; // @[WishboneHost.scala 89:13]
    end
    if (reset) begin // @[WishboneHost.scala 49:23]
      datReg <= 32'h0; // @[WishboneHost.scala 49:23]
    end else if (~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 77:86]
      datReg <= 32'h0; // @[WishboneHost.scala 83:14]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 85:92]
      datReg <= io_reqIn_bits_dataRequest; // @[WishboneHost.scala 91:14]
    end
    if (reset) begin // @[WishboneHost.scala 50:23]
      adrReg <= 32'h0; // @[WishboneHost.scala 50:23]
    end else if (~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 77:86]
      adrReg <= io_reqIn_bits_addrRequest; // @[WishboneHost.scala 82:14]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 85:92]
      adrReg <= io_reqIn_bits_addrRequest; // @[WishboneHost.scala 90:14]
    end
    if (reset) begin // @[WishboneHost.scala 56:25]
      stateReg <= 1'h0; // @[WishboneHost.scala 56:25]
    end else if (~stateReg) begin // @[WishboneHost.scala 119:29]
      stateReg <= io_wbSlaveReceiver_bits_ack | io_wbSlaveReceiver_bits_err; // @[WishboneHost.scala 120:16]
    end else if (stateReg) begin // @[WishboneHost.scala 121:42]
      stateReg <= 1'h0; // @[WishboneHost.scala 123:16]
    end
    readyReg <= reset | _GEN_1; // @[WishboneHost.scala 62:25 WishboneHost.scala 62:25]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  startWBTransaction = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  respReg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  errReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  stbReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  cycReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  weReg = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  datReg = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  adrReg = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  stateReg = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  readyReg = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module WishboneDevice(
  input         io_wbSlaveTransmitter_ready,
  output        io_wbSlaveTransmitter_bits_ack,
  output [31:0] io_wbSlaveTransmitter_bits_dat,
  output        io_wbSlaveTransmitter_bits_err,
  output        io_wbMasterReceiver_ready,
  input         io_wbMasterReceiver_valid,
  input         io_wbMasterReceiver_bits_cyc,
  input         io_wbMasterReceiver_bits_stb,
  input         io_wbMasterReceiver_bits_we,
  input  [31:0] io_wbMasterReceiver_bits_adr,
  input  [31:0] io_wbMasterReceiver_bits_dat,
  output        io_reqOut_valid,
  output [31:0] io_reqOut_bits_addrRequest,
  output [31:0] io_reqOut_bits_dataRequest,
  output        io_reqOut_bits_isWrite,
  input         io_rspIn_valid,
  input  [31:0] io_rspIn_bits_dataResponse,
  input         io_rspIn_bits_error
);
  wire  _T_1 = io_wbMasterReceiver_valid & io_wbMasterReceiver_bits_cyc & io_wbMasterReceiver_bits_stb; // @[WishboneDevice.scala 16:80]
  wire  _T_4 = io_rspIn_valid & ~io_rspIn_bits_error; // @[WishboneDevice.scala 36:27]
  wire  _T_5 = io_rspIn_valid & io_rspIn_bits_error; // @[WishboneDevice.scala 42:34]
  wire  _GEN_5 = io_rspIn_valid & ~io_rspIn_bits_error ? 1'h0 : _T_5; // @[WishboneDevice.scala 36:52 WishboneDevice.scala 40:40]
  wire  _GEN_18 = ~io_wbMasterReceiver_bits_we ? _T_4 : _T_4; // @[WishboneDevice.scala 26:40]
  wire  _GEN_19 = ~io_wbMasterReceiver_bits_we ? _GEN_5 : _GEN_5; // @[WishboneDevice.scala 26:40]
  assign io_wbSlaveTransmitter_bits_ack = _T_1 & _GEN_18; // @[WishboneDevice.scala 25:16 WishboneDevice.scala 88:9]
  assign io_wbSlaveTransmitter_bits_dat = io_rspIn_bits_dataResponse; // @[WishboneDevice.scala 36:52 WishboneDevice.scala 41:40]
  assign io_wbSlaveTransmitter_bits_err = _T_1 & _GEN_19; // @[WishboneDevice.scala 25:16 WishboneDevice.scala 89:36]
  assign io_wbMasterReceiver_ready = 1'h1; // @[WishboneDevice.scala 19:29]
  assign io_reqOut_valid = io_wbMasterReceiver_valid & io_wbMasterReceiver_bits_cyc & io_wbMasterReceiver_bits_stb; // @[WishboneDevice.scala 16:80]
  assign io_reqOut_bits_addrRequest = io_wbMasterReceiver_bits_adr; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 32:34 WishboneDevice.scala 56:34]
  assign io_reqOut_bits_dataRequest = io_wbMasterReceiver_bits_dat; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 57:34]
  assign io_reqOut_bits_isWrite = ~io_wbMasterReceiver_bits_we ? 1'h0 : io_wbMasterReceiver_bits_we; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 35:30 WishboneDevice.scala 59:30]
endmodule
module uartTX(
  input         clock,
  input         reset,
  input         io_tx_en,
  input  [7:0]  io_i_TX_Byte,
  input  [15:0] io_CLKS_PER_BIT,
  output        io_o_TX_Serial,
  output        io_o_TX_Done
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] r_SM_Main; // @[uartTX.scala 23:28]
  reg [15:0] r_Clock_Count; // @[uartTX.scala 24:32]
  reg [2:0] r_Bit_Index; // @[uartTX.scala 25:30]
  reg [7:0] r_TX_Data; // @[uartTX.scala 26:28]
  reg  r_TX_Done; // @[uartTX.scala 27:28]
  wire  _T = 3'h0 == r_SM_Main; // @[Conditional.scala 37:30]
  wire  _T_2 = 3'h1 == r_SM_Main; // @[Conditional.scala 37:30]
  wire [15:0] _T_4 = io_CLKS_PER_BIT - 16'h1; // @[uartTX.scala 51:49]
  wire  _T_5 = r_Clock_Count < _T_4; // @[uartTX.scala 51:32]
  wire [15:0] _r_Clock_Count_T_1 = r_Clock_Count + 16'h1; // @[uartTX.scala 52:48]
  wire [15:0] _GEN_2 = r_Clock_Count < _T_4 ? _r_Clock_Count_T_1 : 16'h0; // @[uartTX.scala 51:54 uartTX.scala 52:31 uartTX.scala 55:31]
  wire  _T_6 = 3'h2 == r_SM_Main; // @[Conditional.scala 37:30]
  wire [7:0] _io_o_TX_Serial_T = r_TX_Data >> r_Bit_Index; // @[uartTX.scala 61:40]
  wire [2:0] _r_Bit_Index_T_1 = r_Bit_Index + 3'h1; // @[uartTX.scala 69:48]
  wire [2:0] _GEN_4 = r_Bit_Index < 3'h7 ? _r_Bit_Index_T_1 : 3'h0; // @[uartTX.scala 68:40 uartTX.scala 69:33 uartTX.scala 72:33]
  wire [2:0] _GEN_5 = r_Bit_Index < 3'h7 ? 3'h2 : 3'h3; // @[uartTX.scala 68:40 uartTX.scala 70:31 uartTX.scala 73:31]
  wire [2:0] _GEN_7 = _T_5 ? 3'h2 : _GEN_5; // @[uartTX.scala 63:56 uartTX.scala 65:27]
  wire [2:0] _GEN_8 = _T_5 ? r_Bit_Index : _GEN_4; // @[uartTX.scala 63:56 uartTX.scala 25:30]
  wire  _T_11 = 3'h3 == r_SM_Main; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_10 = _T_5 ? 3'h3 : 3'h4; // @[uartTX.scala 83:56 uartTX.scala 85:27 uartTX.scala 89:27]
  wire  _GEN_11 = _T_5 ? r_TX_Done : 1'h1; // @[uartTX.scala 83:56 uartTX.scala 27:28 uartTX.scala 87:27]
  wire  _T_15 = 3'h4 == r_SM_Main; // @[Conditional.scala 37:30]
  wire  _GEN_13 = _T_15 | r_TX_Done; // @[Conditional.scala 39:67 uartTX.scala 96:23 uartTX.scala 27:28]
  wire [2:0] _GEN_14 = _T_15 ? 3'h0 : r_SM_Main; // @[Conditional.scala 39:67 uartTX.scala 97:23 uartTX.scala 23:28]
  wire [15:0] _GEN_16 = _T_11 ? _GEN_2 : r_Clock_Count; // @[Conditional.scala 39:67 uartTX.scala 24:32]
  wire [2:0] _GEN_17 = _T_11 ? _GEN_10 : _GEN_14; // @[Conditional.scala 39:67]
  wire  _GEN_18 = _T_11 ? _GEN_11 : _GEN_13; // @[Conditional.scala 39:67]
  wire  _GEN_19 = _T_6 ? _io_o_TX_Serial_T[0] : 1'h1; // @[Conditional.scala 39:67 uartTX.scala 61:28]
  wire  _GEN_24 = _T_2 ? 1'h0 : _GEN_19; // @[Conditional.scala 39:67 uartTX.scala 49:28]
  assign io_o_TX_Serial = _T | _GEN_24; // @[Conditional.scala 40:58 uartTX.scala 35:28]
  assign io_o_TX_Done = r_TX_Done; // @[uartTX.scala 103:18]
  always @(posedge clock) begin
    if (reset) begin // @[uartTX.scala 23:28]
      r_SM_Main <= 3'h0; // @[uartTX.scala 23:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_tx_en) begin // @[uartTX.scala 40:35]
        r_SM_Main <= 3'h1; // @[uartTX.scala 42:27]
      end else begin
        r_SM_Main <= 3'h0; // @[uartTX.scala 44:27]
      end
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      if (r_Clock_Count < _T_4) begin // @[uartTX.scala 51:54]
        r_SM_Main <= 3'h1; // @[uartTX.scala 53:27]
      end else begin
        r_SM_Main <= 3'h2; // @[uartTX.scala 56:27]
      end
    end else if (_T_6) begin // @[Conditional.scala 39:67]
      r_SM_Main <= _GEN_7;
    end else begin
      r_SM_Main <= _GEN_17;
    end
    if (reset) begin // @[uartTX.scala 24:32]
      r_Clock_Count <= 16'h0; // @[uartTX.scala 24:32]
    end else if (_T) begin // @[Conditional.scala 40:58]
      r_Clock_Count <= 16'h0; // @[uartTX.scala 37:27]
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      r_Clock_Count <= _GEN_2;
    end else if (_T_6) begin // @[Conditional.scala 39:67]
      r_Clock_Count <= _GEN_2;
    end else begin
      r_Clock_Count <= _GEN_16;
    end
    if (reset) begin // @[uartTX.scala 25:30]
      r_Bit_Index <= 3'h0; // @[uartTX.scala 25:30]
    end else if (_T) begin // @[Conditional.scala 40:58]
      r_Bit_Index <= 3'h0; // @[uartTX.scala 38:25]
    end else if (!(_T_2)) begin // @[Conditional.scala 39:67]
      if (_T_6) begin // @[Conditional.scala 39:67]
        r_Bit_Index <= _GEN_8;
      end
    end
    if (reset) begin // @[uartTX.scala 26:28]
      r_TX_Data <= 8'h0; // @[uartTX.scala 26:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_tx_en) begin // @[uartTX.scala 40:35]
        r_TX_Data <= io_i_TX_Byte; // @[uartTX.scala 41:27]
      end
    end
    if (reset) begin // @[uartTX.scala 27:28]
      r_TX_Done <= 1'h0; // @[uartTX.scala 27:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      r_TX_Done <= 1'h0; // @[uartTX.scala 36:23]
    end else if (!(_T_2)) begin // @[Conditional.scala 39:67]
      if (!(_T_6)) begin // @[Conditional.scala 39:67]
        r_TX_Done <= _GEN_18;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  r_SM_Main = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  r_Clock_Count = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  r_Bit_Index = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  r_TX_Data = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  r_TX_Done = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module uartRX(
  input         clock,
  input         reset,
  input         io_i_Rx_Serial,
  input  [15:0] io_CLKS_PER_BIT,
  output        io_o_Rx_DV,
  output [7:0]  io_o_Rx_Byte
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[uartRX.scala 18:32]
  reg  rxReg; // @[uartRX.scala 18:24]
  reg [7:0] shiftReg; // @[uartRX.scala 19:27]
  reg [2:0] r_SM_Main; // @[uartRX.scala 21:28]
  reg [15:0] r_Clock_Count; // @[uartRX.scala 22:32]
  reg [2:0] r_Bit_Index; // @[uartRX.scala 23:30]
  reg  r_Rx_DV; // @[uartRX.scala 24:26]
  wire  _T = 3'h0 == r_SM_Main; // @[Conditional.scala 37:30]
  wire  _T_1 = ~io_i_Rx_Serial; // @[uartRX.scala 33:33]
  wire  _T_2 = 3'h1 == r_SM_Main; // @[Conditional.scala 37:30]
  wire [15:0] _T_4 = io_CLKS_PER_BIT - 16'h1; // @[uartRX.scala 41:52]
  wire [15:0] _T_5 = _T_4 / 2'h2; // @[uartRX.scala 41:57]
  wire [15:0] _GEN_1 = _T_1 ? 16'h0 : r_Clock_Count; // @[uartRX.scala 42:45 uartRX.scala 43:35 uartRX.scala 22:32]
  wire [2:0] _GEN_2 = _T_1 ? 3'h2 : 3'h0; // @[uartRX.scala 42:45 uartRX.scala 44:31 uartRX.scala 46:31]
  wire [15:0] _r_Clock_Count_T_1 = r_Clock_Count + 16'h1; // @[uartRX.scala 49:48]
  wire  _T_8 = 3'h2 == r_SM_Main; // @[Conditional.scala 37:30]
  wire  _T_11 = r_Clock_Count < _T_4; // @[uartRX.scala 55:32]
  wire [6:0] shiftReg_lo = shiftReg[7:1]; // @[uartRX.scala 60:49]
  wire [7:0] _shiftReg_T = {rxReg,shiftReg_lo}; // @[Cat.scala 30:58]
  wire [2:0] _r_Bit_Index_T_1 = r_Bit_Index + 3'h1; // @[uartRX.scala 63:48]
  wire [2:0] _GEN_5 = r_Bit_Index < 3'h7 ? _r_Bit_Index_T_1 : 3'h0; // @[uartRX.scala 62:40 uartRX.scala 63:33 uartRX.scala 66:33]
  wire [2:0] _GEN_6 = r_Bit_Index < 3'h7 ? 3'h2 : 3'h3; // @[uartRX.scala 62:40 uartRX.scala 64:31 uartRX.scala 67:31]
  wire [15:0] _GEN_7 = r_Clock_Count < _T_4 ? _r_Clock_Count_T_1 : 16'h0; // @[uartRX.scala 55:56 uartRX.scala 56:31 uartRX.scala 59:31]
  wire [2:0] _GEN_8 = r_Clock_Count < _T_4 ? 3'h2 : _GEN_6; // @[uartRX.scala 55:56 uartRX.scala 57:27]
  wire [7:0] _GEN_9 = r_Clock_Count < _T_4 ? shiftReg : _shiftReg_T; // @[uartRX.scala 55:56 uartRX.scala 19:27 uartRX.scala 60:26]
  wire [2:0] _GEN_10 = r_Clock_Count < _T_4 ? r_Bit_Index : _GEN_5; // @[uartRX.scala 55:56 uartRX.scala 23:30]
  wire  _T_13 = 3'h3 == r_SM_Main; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_12 = _T_11 ? 3'h3 : 3'h4; // @[uartRX.scala 74:56 uartRX.scala 76:27 uartRX.scala 80:27]
  wire  _GEN_13 = _T_11 ? r_Rx_DV : 1'h1; // @[uartRX.scala 74:56 uartRX.scala 24:26 uartRX.scala 78:25]
  wire  _T_17 = 3'h4 == r_SM_Main; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_14 = _T_17 ? 3'h0 : r_SM_Main; // @[Conditional.scala 39:67 uartRX.scala 85:23 uartRX.scala 21:28]
  wire  _GEN_15 = _T_17 ? 1'h0 : r_Rx_DV; // @[Conditional.scala 39:67 uartRX.scala 86:21 uartRX.scala 24:26]
  wire [15:0] _GEN_16 = _T_13 ? _GEN_7 : r_Clock_Count; // @[Conditional.scala 39:67 uartRX.scala 22:32]
  wire [2:0] _GEN_17 = _T_13 ? _GEN_12 : _GEN_14; // @[Conditional.scala 39:67]
  wire  _GEN_18 = _T_13 ? _GEN_13 : _GEN_15; // @[Conditional.scala 39:67]
  assign io_o_Rx_DV = r_Rx_DV; // @[uartRX.scala 90:16]
  assign io_o_Rx_Byte = shiftReg; // @[uartRX.scala 91:18]
  always @(posedge clock) begin
    rxReg_REG <= reset | io_i_Rx_Serial; // @[uartRX.scala 18:32 uartRX.scala 18:32 uartRX.scala 18:32]
    rxReg <= reset | rxReg_REG; // @[uartRX.scala 18:24 uartRX.scala 18:24 uartRX.scala 18:24]
    if (reset) begin // @[uartRX.scala 19:27]
      shiftReg <= 8'h0; // @[uartRX.scala 19:27]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_2)) begin // @[Conditional.scala 39:67]
        if (_T_8) begin // @[Conditional.scala 39:67]
          shiftReg <= _GEN_9;
        end
      end
    end
    if (reset) begin // @[uartRX.scala 21:28]
      r_SM_Main <= 3'h0; // @[uartRX.scala 21:28]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (~io_i_Rx_Serial) begin // @[uartRX.scala 33:41]
        r_SM_Main <= 3'h1; // @[uartRX.scala 34:27]
      end else begin
        r_SM_Main <= 3'h0; // @[uartRX.scala 36:27]
      end
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      if (r_Clock_Count == _T_5) begin // @[uartRX.scala 41:62]
        r_SM_Main <= _GEN_2;
      end else begin
        r_SM_Main <= 3'h1; // @[uartRX.scala 50:27]
      end
    end else if (_T_8) begin // @[Conditional.scala 39:67]
      r_SM_Main <= _GEN_8;
    end else begin
      r_SM_Main <= _GEN_17;
    end
    if (reset) begin // @[uartRX.scala 22:32]
      r_Clock_Count <= 16'h0; // @[uartRX.scala 22:32]
    end else if (_T) begin // @[Conditional.scala 40:58]
      r_Clock_Count <= 16'h0; // @[uartRX.scala 29:27]
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      if (r_Clock_Count == _T_5) begin // @[uartRX.scala 41:62]
        r_Clock_Count <= _GEN_1;
      end else begin
        r_Clock_Count <= _r_Clock_Count_T_1; // @[uartRX.scala 49:31]
      end
    end else if (_T_8) begin // @[Conditional.scala 39:67]
      r_Clock_Count <= _GEN_7;
    end else begin
      r_Clock_Count <= _GEN_16;
    end
    if (reset) begin // @[uartRX.scala 23:30]
      r_Bit_Index <= 3'h0; // @[uartRX.scala 23:30]
    end else if (_T) begin // @[Conditional.scala 40:58]
      r_Bit_Index <= 3'h0; // @[uartRX.scala 30:25]
    end else if (!(_T_2)) begin // @[Conditional.scala 39:67]
      if (_T_8) begin // @[Conditional.scala 39:67]
        r_Bit_Index <= _GEN_10;
      end
    end
    if (reset) begin // @[uartRX.scala 24:26]
      r_Rx_DV <= 1'h0; // @[uartRX.scala 24:26]
    end else if (_T) begin // @[Conditional.scala 40:58]
      r_Rx_DV <= 1'h0; // @[uartRX.scala 28:21]
    end else if (!(_T_2)) begin // @[Conditional.scala 39:67]
      if (!(_T_8)) begin // @[Conditional.scala 39:67]
        r_Rx_DV <= _GEN_18;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rxReg_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rxReg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  shiftReg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  r_SM_Main = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  r_Clock_Count = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  r_Bit_Index = _RAND_5[2:0];
  _RAND_6 = {1{`RANDOM}};
  r_Rx_DV = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module UartTOP(
  input         clock,
  input         reset,
  input         io_ren,
  input         io_we,
  input  [31:0] io_wdata,
  input  [7:0]  io_addr,
  input         io_rx_i,
  output [31:0] io_rdata,
  output        io_tx_o,
  output        io_intr_tx
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  wire  uart_tx_clock; // @[UartTOP.scala 60:25]
  wire  uart_tx_reset; // @[UartTOP.scala 60:25]
  wire  uart_tx_io_tx_en; // @[UartTOP.scala 60:25]
  wire [7:0] uart_tx_io_i_TX_Byte; // @[UartTOP.scala 60:25]
  wire [15:0] uart_tx_io_CLKS_PER_BIT; // @[UartTOP.scala 60:25]
  wire  uart_tx_io_o_TX_Serial; // @[UartTOP.scala 60:25]
  wire  uart_tx_io_o_TX_Done; // @[UartTOP.scala 60:25]
  wire  uart_rx_clock; // @[UartTOP.scala 69:25]
  wire  uart_rx_reset; // @[UartTOP.scala 69:25]
  wire  uart_rx_io_i_Rx_Serial; // @[UartTOP.scala 69:25]
  wire [15:0] uart_rx_io_CLKS_PER_BIT; // @[UartTOP.scala 69:25]
  wire  uart_rx_io_o_Rx_DV; // @[UartTOP.scala 69:25]
  wire [7:0] uart_rx_io_o_Rx_Byte; // @[UartTOP.scala 69:25]
  reg [15:0] control; // @[UartTOP.scala 29:26]
  reg [7:0] tx; // @[UartTOP.scala 30:21]
  reg [7:0] rx; // @[UartTOP.scala 31:21]
  reg [7:0] rx_reg; // @[UartTOP.scala 32:25]
  reg  rx_en; // @[UartTOP.scala 33:24]
  reg  tx_en; // @[UartTOP.scala 34:24]
  reg  rx_status; // @[UartTOP.scala 35:28]
  reg  rx_clr; // @[UartTOP.scala 36:25]
  reg  rx_done; // @[UartTOP.scala 37:26]
  wire  _GEN_0 = io_addr == 8'h18 & io_wdata[0]; // @[UartTOP.scala 48:38 UartTOP.scala 49:20 UartTOP.scala 55:20]
  wire [7:0] _GEN_1 = io_addr == 8'h18 ? tx : 8'h0; // @[UartTOP.scala 48:38 UartTOP.scala 30:21 UartTOP.scala 52:16]
  wire  _GEN_2 = io_addr == 8'h18 & rx_en; // @[UartTOP.scala 48:38 UartTOP.scala 33:24 UartTOP.scala 53:19]
  wire  _GEN_3 = io_addr == 8'h18 & tx_en; // @[UartTOP.scala 48:38 UartTOP.scala 34:24 UartTOP.scala 54:19]
  wire  _GEN_4 = io_addr == 8'h10 ? io_wdata[0] : _GEN_3; // @[UartTOP.scala 46:38 UartTOP.scala 47:19]
  wire  _GEN_5 = io_addr == 8'h10 ? rx_clr : _GEN_0; // @[UartTOP.scala 46:38 UartTOP.scala 36:25]
  wire [7:0] _GEN_6 = io_addr == 8'h10 ? tx : _GEN_1; // @[UartTOP.scala 46:38 UartTOP.scala 30:21]
  wire  _GEN_7 = io_addr == 8'h10 ? rx_en : _GEN_2; // @[UartTOP.scala 46:38 UartTOP.scala 33:24]
  wire  _GEN_8 = io_addr == 8'hc ? io_wdata[0] : _GEN_7; // @[UartTOP.scala 44:38 UartTOP.scala 45:19]
  wire  _GEN_9 = io_addr == 8'hc ? tx_en : _GEN_4; // @[UartTOP.scala 44:38 UartTOP.scala 34:24]
  wire  _GEN_10 = io_addr == 8'hc ? rx_clr : _GEN_5; // @[UartTOP.scala 44:38 UartTOP.scala 36:25]
  wire [7:0] _GEN_11 = io_addr == 8'hc ? tx : _GEN_6; // @[UartTOP.scala 44:38 UartTOP.scala 30:21]
  wire  _GEN_15 = io_addr == 8'h4 ? rx_clr : _GEN_10; // @[UartTOP.scala 42:40 UartTOP.scala 36:25]
  wire  _GEN_20 = io_addr == 8'h0 ? rx_clr : _GEN_15; // @[UartTOP.scala 40:36 UartTOP.scala 36:25]
  wire  _GEN_25 = ~io_ren & io_we ? _GEN_20 : rx_clr; // @[UartTOP.scala 39:29 UartTOP.scala 36:25]
  wire  _GEN_27 = ~rx_clr ? 1'h0 : rx_status; // @[UartTOP.scala 84:26 UartTOP.scala 85:19 UartTOP.scala 35:28]
  wire  _GEN_29 = rx_done | _GEN_27; // @[UartTOP.scala 81:18 UartTOP.scala 83:19]
  wire [7:0] _io_rdata_T_2 = io_addr == 8'h8 ? rx_reg : 8'h0; // @[UartTOP.scala 88:55]
  wire [7:0] _io_rdata_T_3 = io_addr == 8'h14 ? {{7'd0}, rx_status} : _io_rdata_T_2; // @[UartTOP.scala 88:20]
  uartTX uart_tx ( // @[UartTOP.scala 60:25]
    .clock(uart_tx_clock),
    .reset(uart_tx_reset),
    .io_tx_en(uart_tx_io_tx_en),
    .io_i_TX_Byte(uart_tx_io_i_TX_Byte),
    .io_CLKS_PER_BIT(uart_tx_io_CLKS_PER_BIT),
    .io_o_TX_Serial(uart_tx_io_o_TX_Serial),
    .io_o_TX_Done(uart_tx_io_o_TX_Done)
  );
  uartRX uart_rx ( // @[UartTOP.scala 69:25]
    .clock(uart_rx_clock),
    .reset(uart_rx_reset),
    .io_i_Rx_Serial(uart_rx_io_i_Rx_Serial),
    .io_CLKS_PER_BIT(uart_rx_io_CLKS_PER_BIT),
    .io_o_Rx_DV(uart_rx_io_o_Rx_DV),
    .io_o_Rx_Byte(uart_rx_io_o_Rx_Byte)
  );
  assign io_rdata = {{24'd0}, _io_rdata_T_3}; // @[UartTOP.scala 88:20]
  assign io_tx_o = uart_tx_io_o_TX_Serial; // @[UartTOP.scala 66:13]
  assign io_intr_tx = uart_tx_io_o_TX_Done; // @[UartTOP.scala 67:16]
  assign uart_tx_clock = clock;
  assign uart_tx_reset = reset;
  assign uart_tx_io_tx_en = tx_en; // @[UartTOP.scala 61:22]
  assign uart_tx_io_i_TX_Byte = tx; // @[UartTOP.scala 62:26]
  assign uart_tx_io_CLKS_PER_BIT = control; // @[UartTOP.scala 63:29]
  assign uart_rx_clock = clock;
  assign uart_rx_reset = reset;
  assign uart_rx_io_i_Rx_Serial = rx_en ? io_rx_i : 1'h1; // @[UartTOP.scala 70:16 UartTOP.scala 71:32 UartTOP.scala 73:32]
  assign uart_rx_io_CLKS_PER_BIT = control; // @[UartTOP.scala 75:29]
  always @(posedge clock) begin
    if (reset) begin // @[UartTOP.scala 29:26]
      control <= 16'h0; // @[UartTOP.scala 29:26]
    end else if (~io_ren & io_we) begin // @[UartTOP.scala 39:29]
      if (io_addr == 8'h0) begin // @[UartTOP.scala 40:36]
        control <= io_wdata[15:0]; // @[UartTOP.scala 41:21]
      end
    end
    if (reset) begin // @[UartTOP.scala 30:21]
      tx <= 8'h0; // @[UartTOP.scala 30:21]
    end else if (~io_ren & io_we) begin // @[UartTOP.scala 39:29]
      if (!(io_addr == 8'h0)) begin // @[UartTOP.scala 40:36]
        if (io_addr == 8'h4) begin // @[UartTOP.scala 42:40]
          tx <= io_wdata[7:0]; // @[UartTOP.scala 43:16]
        end else begin
          tx <= _GEN_11;
        end
      end
    end
    if (reset) begin // @[UartTOP.scala 31:21]
      rx <= 8'h0; // @[UartTOP.scala 31:21]
    end else begin
      rx <= uart_rx_io_o_Rx_Byte; // @[UartTOP.scala 78:8]
    end
    if (reset) begin // @[UartTOP.scala 32:25]
      rx_reg <= 8'h0; // @[UartTOP.scala 32:25]
    end else if (rx_done) begin // @[UartTOP.scala 81:18]
      rx_reg <= rx; // @[UartTOP.scala 82:16]
    end
    if (reset) begin // @[UartTOP.scala 33:24]
      rx_en <= 1'h0; // @[UartTOP.scala 33:24]
    end else if (~io_ren & io_we) begin // @[UartTOP.scala 39:29]
      if (!(io_addr == 8'h0)) begin // @[UartTOP.scala 40:36]
        if (!(io_addr == 8'h4)) begin // @[UartTOP.scala 42:40]
          rx_en <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[UartTOP.scala 34:24]
      tx_en <= 1'h0; // @[UartTOP.scala 34:24]
    end else if (~io_ren & io_we) begin // @[UartTOP.scala 39:29]
      if (!(io_addr == 8'h0)) begin // @[UartTOP.scala 40:36]
        if (!(io_addr == 8'h4)) begin // @[UartTOP.scala 42:40]
          tx_en <= _GEN_9;
        end
      end
    end
    if (reset) begin // @[UartTOP.scala 35:28]
      rx_status <= 1'h0; // @[UartTOP.scala 35:28]
    end else begin
      rx_status <= _GEN_29;
    end
    rx_clr <= reset | _GEN_25; // @[UartTOP.scala 36:25 UartTOP.scala 36:25]
    if (reset) begin // @[UartTOP.scala 37:26]
      rx_done <= 1'h0; // @[UartTOP.scala 37:26]
    end else begin
      rx_done <= uart_rx_io_o_Rx_DV; // @[UartTOP.scala 77:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  control = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  tx = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  rx = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  rx_reg = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  rx_en = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  tx_en = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  rx_status = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  rx_clr = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  rx_done = _RAND_8[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module uart(
  input         clock,
  input         reset,
  output        io_request_ready,
  input         io_request_valid,
  input  [31:0] io_request_bits_addrRequest,
  input  [31:0] io_request_bits_dataRequest,
  input         io_request_bits_isWrite,
  output        io_response_valid,
  output [31:0] io_response_bits_dataResponse,
  output        io_response_bits_error,
  input         io_cio_uart_rx_i,
  output        io_cio_uart_tx_o,
  output        io_cio_uart_intr_tx_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  uart_top_clock; // @[uart.scala 57:27]
  wire  uart_top_reset; // @[uart.scala 57:27]
  wire  uart_top_io_ren; // @[uart.scala 57:27]
  wire  uart_top_io_we; // @[uart.scala 57:27]
  wire [31:0] uart_top_io_wdata; // @[uart.scala 57:27]
  wire [7:0] uart_top_io_addr; // @[uart.scala 57:27]
  wire  uart_top_io_rx_i; // @[uart.scala 57:27]
  wire [31:0] uart_top_io_rdata; // @[uart.scala 57:27]
  wire  uart_top_io_tx_o; // @[uart.scala 57:27]
  wire  uart_top_io_intr_tx; // @[uart.scala 57:27]
  wire  _write_register_T = io_request_ready & io_request_valid; // @[Decoupled.scala 40:37]
  wire  write_register = _write_register_T & io_request_bits_isWrite; // @[uart.scala 64:26]
  wire  read_register = _write_register_T & ~io_request_bits_isWrite; // @[uart.scala 65:25]
  reg [31:0] io_response_bits_dataResponse_REG; // @[uart.scala 73:45]
  reg  io_response_valid_REG; // @[uart.scala 74:33]
  reg  io_response_bits_error_REG; // @[uart.scala 75:38]
  UartTOP uart_top ( // @[uart.scala 57:27]
    .clock(uart_top_clock),
    .reset(uart_top_reset),
    .io_ren(uart_top_io_ren),
    .io_we(uart_top_io_we),
    .io_wdata(uart_top_io_wdata),
    .io_addr(uart_top_io_addr),
    .io_rx_i(uart_top_io_rx_i),
    .io_rdata(uart_top_io_rdata),
    .io_tx_o(uart_top_io_tx_o),
    .io_intr_tx(uart_top_io_intr_tx)
  );
  assign io_request_ready = 1'h1; // @[uart.scala 19:22]
  assign io_response_valid = io_response_valid_REG; // @[uart.scala 74:23]
  assign io_response_bits_dataResponse = io_response_bits_dataResponse_REG; // @[uart.scala 73:35]
  assign io_response_bits_error = io_response_bits_error_REG; // @[uart.scala 75:28]
  assign io_cio_uart_tx_o = uart_top_io_tx_o; // @[uart.scala 78:22]
  assign io_cio_uart_intr_tx_o = uart_top_io_intr_tx; // @[uart.scala 77:27]
  assign uart_top_clock = clock;
  assign uart_top_reset = reset;
  assign uart_top_io_ren = _write_register_T & ~io_request_bits_isWrite; // @[uart.scala 65:25]
  assign uart_top_io_we = _write_register_T & io_request_bits_isWrite; // @[uart.scala 64:26]
  assign uart_top_io_wdata = io_request_bits_dataRequest; // @[uart.scala 61:24 uart.scala 66:14]
  assign uart_top_io_addr = io_request_bits_addrRequest[7:0]; // @[uart.scala 67:44]
  assign uart_top_io_rx_i = io_cio_uart_rx_i; // @[uart.scala 79:22]
  always @(posedge clock) begin
    io_response_bits_dataResponse_REG <= uart_top_io_rdata; // @[uart.scala 73:49]
    io_response_valid_REG <= write_register | read_register; // @[uart.scala 74:53]
    io_response_bits_error_REG <= uart_top_io_intr_tx; // @[uart.scala 75:42]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_response_bits_dataResponse_REG = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  io_response_valid_REG = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  io_response_bits_error_REG = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module uartHarness(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input  [3:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  input         io_rsp_ready,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse,
  output        io_rsp_bits_error,
  input         io_cio_uart_rx_i,
  output        io_cio_uart_tx_o,
  output        io_cio_uart_intr_tx_o
);
  wire  hostAdapter_clock; // @[uartHarness.scala 24:27]
  wire  hostAdapter_reset; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_wbMasterTransmitter_ready; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_wbMasterTransmitter_valid; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_wbMasterTransmitter_bits_cyc; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_wbMasterTransmitter_bits_stb; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_wbMasterTransmitter_bits_we; // @[uartHarness.scala 24:27]
  wire [31:0] hostAdapter_io_wbMasterTransmitter_bits_adr; // @[uartHarness.scala 24:27]
  wire [31:0] hostAdapter_io_wbMasterTransmitter_bits_dat; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_wbSlaveReceiver_ready; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_wbSlaveReceiver_bits_ack; // @[uartHarness.scala 24:27]
  wire [31:0] hostAdapter_io_wbSlaveReceiver_bits_dat; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_wbSlaveReceiver_bits_err; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_reqIn_ready; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_reqIn_valid; // @[uartHarness.scala 24:27]
  wire [31:0] hostAdapter_io_reqIn_bits_addrRequest; // @[uartHarness.scala 24:27]
  wire [31:0] hostAdapter_io_reqIn_bits_dataRequest; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_reqIn_bits_isWrite; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_rspOut_valid; // @[uartHarness.scala 24:27]
  wire [31:0] hostAdapter_io_rspOut_bits_dataResponse; // @[uartHarness.scala 24:27]
  wire  hostAdapter_io_rspOut_bits_error; // @[uartHarness.scala 24:27]
  wire  deviceAdapter_io_wbSlaveTransmitter_ready; // @[uartHarness.scala 25:29]
  wire  deviceAdapter_io_wbSlaveTransmitter_bits_ack; // @[uartHarness.scala 25:29]
  wire [31:0] deviceAdapter_io_wbSlaveTransmitter_bits_dat; // @[uartHarness.scala 25:29]
  wire  deviceAdapter_io_wbSlaveTransmitter_bits_err; // @[uartHarness.scala 25:29]
  wire  deviceAdapter_io_wbMasterReceiver_ready; // @[uartHarness.scala 25:29]
  wire  deviceAdapter_io_wbMasterReceiver_valid; // @[uartHarness.scala 25:29]
  wire  deviceAdapter_io_wbMasterReceiver_bits_cyc; // @[uartHarness.scala 25:29]
  wire  deviceAdapter_io_wbMasterReceiver_bits_stb; // @[uartHarness.scala 25:29]
  wire  deviceAdapter_io_wbMasterReceiver_bits_we; // @[uartHarness.scala 25:29]
  wire [31:0] deviceAdapter_io_wbMasterReceiver_bits_adr; // @[uartHarness.scala 25:29]
  wire [31:0] deviceAdapter_io_wbMasterReceiver_bits_dat; // @[uartHarness.scala 25:29]
  wire  deviceAdapter_io_reqOut_valid; // @[uartHarness.scala 25:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_addrRequest; // @[uartHarness.scala 25:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_dataRequest; // @[uartHarness.scala 25:29]
  wire  deviceAdapter_io_reqOut_bits_isWrite; // @[uartHarness.scala 25:29]
  wire  deviceAdapter_io_rspIn_valid; // @[uartHarness.scala 25:29]
  wire [31:0] deviceAdapter_io_rspIn_bits_dataResponse; // @[uartHarness.scala 25:29]
  wire  deviceAdapter_io_rspIn_bits_error; // @[uartHarness.scala 25:29]
  wire  uart_wrapper_clock; // @[uartHarness.scala 26:28]
  wire  uart_wrapper_reset; // @[uartHarness.scala 26:28]
  wire  uart_wrapper_io_request_ready; // @[uartHarness.scala 26:28]
  wire  uart_wrapper_io_request_valid; // @[uartHarness.scala 26:28]
  wire [31:0] uart_wrapper_io_request_bits_addrRequest; // @[uartHarness.scala 26:28]
  wire [31:0] uart_wrapper_io_request_bits_dataRequest; // @[uartHarness.scala 26:28]
  wire  uart_wrapper_io_request_bits_isWrite; // @[uartHarness.scala 26:28]
  wire  uart_wrapper_io_response_valid; // @[uartHarness.scala 26:28]
  wire [31:0] uart_wrapper_io_response_bits_dataResponse; // @[uartHarness.scala 26:28]
  wire  uart_wrapper_io_response_bits_error; // @[uartHarness.scala 26:28]
  wire  uart_wrapper_io_cio_uart_rx_i; // @[uartHarness.scala 26:28]
  wire  uart_wrapper_io_cio_uart_tx_o; // @[uartHarness.scala 26:28]
  wire  uart_wrapper_io_cio_uart_intr_tx_o; // @[uartHarness.scala 26:28]
  WishboneHost hostAdapter ( // @[uartHarness.scala 24:27]
    .clock(hostAdapter_clock),
    .reset(hostAdapter_reset),
    .io_wbMasterTransmitter_ready(hostAdapter_io_wbMasterTransmitter_ready),
    .io_wbMasterTransmitter_valid(hostAdapter_io_wbMasterTransmitter_valid),
    .io_wbMasterTransmitter_bits_cyc(hostAdapter_io_wbMasterTransmitter_bits_cyc),
    .io_wbMasterTransmitter_bits_stb(hostAdapter_io_wbMasterTransmitter_bits_stb),
    .io_wbMasterTransmitter_bits_we(hostAdapter_io_wbMasterTransmitter_bits_we),
    .io_wbMasterTransmitter_bits_adr(hostAdapter_io_wbMasterTransmitter_bits_adr),
    .io_wbMasterTransmitter_bits_dat(hostAdapter_io_wbMasterTransmitter_bits_dat),
    .io_wbSlaveReceiver_ready(hostAdapter_io_wbSlaveReceiver_ready),
    .io_wbSlaveReceiver_bits_ack(hostAdapter_io_wbSlaveReceiver_bits_ack),
    .io_wbSlaveReceiver_bits_dat(hostAdapter_io_wbSlaveReceiver_bits_dat),
    .io_wbSlaveReceiver_bits_err(hostAdapter_io_wbSlaveReceiver_bits_err),
    .io_reqIn_ready(hostAdapter_io_reqIn_ready),
    .io_reqIn_valid(hostAdapter_io_reqIn_valid),
    .io_reqIn_bits_addrRequest(hostAdapter_io_reqIn_bits_addrRequest),
    .io_reqIn_bits_dataRequest(hostAdapter_io_reqIn_bits_dataRequest),
    .io_reqIn_bits_isWrite(hostAdapter_io_reqIn_bits_isWrite),
    .io_rspOut_valid(hostAdapter_io_rspOut_valid),
    .io_rspOut_bits_dataResponse(hostAdapter_io_rspOut_bits_dataResponse),
    .io_rspOut_bits_error(hostAdapter_io_rspOut_bits_error)
  );
  WishboneDevice deviceAdapter ( // @[uartHarness.scala 25:29]
    .io_wbSlaveTransmitter_ready(deviceAdapter_io_wbSlaveTransmitter_ready),
    .io_wbSlaveTransmitter_bits_ack(deviceAdapter_io_wbSlaveTransmitter_bits_ack),
    .io_wbSlaveTransmitter_bits_dat(deviceAdapter_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(deviceAdapter_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_ready(deviceAdapter_io_wbMasterReceiver_ready),
    .io_wbMasterReceiver_valid(deviceAdapter_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(deviceAdapter_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(deviceAdapter_io_wbMasterReceiver_bits_stb),
    .io_wbMasterReceiver_bits_we(deviceAdapter_io_wbMasterReceiver_bits_we),
    .io_wbMasterReceiver_bits_adr(deviceAdapter_io_wbMasterReceiver_bits_adr),
    .io_wbMasterReceiver_bits_dat(deviceAdapter_io_wbMasterReceiver_bits_dat),
    .io_reqOut_valid(deviceAdapter_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(deviceAdapter_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(deviceAdapter_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_isWrite(deviceAdapter_io_reqOut_bits_isWrite),
    .io_rspIn_valid(deviceAdapter_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(deviceAdapter_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(deviceAdapter_io_rspIn_bits_error)
  );
  uart uart_wrapper ( // @[uartHarness.scala 26:28]
    .clock(uart_wrapper_clock),
    .reset(uart_wrapper_reset),
    .io_request_ready(uart_wrapper_io_request_ready),
    .io_request_valid(uart_wrapper_io_request_valid),
    .io_request_bits_addrRequest(uart_wrapper_io_request_bits_addrRequest),
    .io_request_bits_dataRequest(uart_wrapper_io_request_bits_dataRequest),
    .io_request_bits_isWrite(uart_wrapper_io_request_bits_isWrite),
    .io_response_valid(uart_wrapper_io_response_valid),
    .io_response_bits_dataResponse(uart_wrapper_io_response_bits_dataResponse),
    .io_response_bits_error(uart_wrapper_io_response_bits_error),
    .io_cio_uart_rx_i(uart_wrapper_io_cio_uart_rx_i),
    .io_cio_uart_tx_o(uart_wrapper_io_cio_uart_tx_o),
    .io_cio_uart_intr_tx_o(uart_wrapper_io_cio_uart_intr_tx_o)
  );
  assign io_req_ready = hostAdapter_io_reqIn_ready; // @[uartHarness.scala 28:24]
  assign io_rsp_valid = hostAdapter_io_rspOut_valid; // @[uartHarness.scala 29:10]
  assign io_rsp_bits_dataResponse = hostAdapter_io_rspOut_bits_dataResponse; // @[uartHarness.scala 29:10]
  assign io_rsp_bits_error = hostAdapter_io_rspOut_bits_error; // @[uartHarness.scala 29:10]
  assign io_cio_uart_tx_o = uart_wrapper_io_cio_uart_tx_o; // @[uartHarness.scala 37:22]
  assign io_cio_uart_intr_tx_o = uart_wrapper_io_cio_uart_intr_tx_o; // @[uartHarness.scala 38:27]
  assign hostAdapter_clock = clock;
  assign hostAdapter_reset = reset;
  assign hostAdapter_io_wbMasterTransmitter_ready = deviceAdapter_io_wbMasterReceiver_ready; // @[uartHarness.scala 30:38]
  assign hostAdapter_io_wbSlaveReceiver_bits_ack = deviceAdapter_io_wbSlaveTransmitter_bits_ack; // @[uartHarness.scala 31:34]
  assign hostAdapter_io_wbSlaveReceiver_bits_dat = deviceAdapter_io_wbSlaveTransmitter_bits_dat; // @[uartHarness.scala 31:34]
  assign hostAdapter_io_wbSlaveReceiver_bits_err = deviceAdapter_io_wbSlaveTransmitter_bits_err; // @[uartHarness.scala 31:34]
  assign hostAdapter_io_reqIn_valid = io_req_valid; // @[uartHarness.scala 28:24]
  assign hostAdapter_io_reqIn_bits_addrRequest = io_req_bits_addrRequest; // @[uartHarness.scala 28:24]
  assign hostAdapter_io_reqIn_bits_dataRequest = io_req_bits_dataRequest; // @[uartHarness.scala 28:24]
  assign hostAdapter_io_reqIn_bits_isWrite = io_req_bits_isWrite; // @[uartHarness.scala 28:24]
  assign deviceAdapter_io_wbSlaveTransmitter_ready = hostAdapter_io_wbSlaveReceiver_ready; // @[uartHarness.scala 31:34]
  assign deviceAdapter_io_wbMasterReceiver_valid = hostAdapter_io_wbMasterTransmitter_valid; // @[uartHarness.scala 30:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_cyc = hostAdapter_io_wbMasterTransmitter_bits_cyc; // @[uartHarness.scala 30:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_stb = hostAdapter_io_wbMasterTransmitter_bits_stb; // @[uartHarness.scala 30:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_we = hostAdapter_io_wbMasterTransmitter_bits_we; // @[uartHarness.scala 30:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_adr = hostAdapter_io_wbMasterTransmitter_bits_adr; // @[uartHarness.scala 30:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_dat = hostAdapter_io_wbMasterTransmitter_bits_dat; // @[uartHarness.scala 30:38]
  assign deviceAdapter_io_rspIn_valid = uart_wrapper_io_response_valid; // @[uartHarness.scala 34:28]
  assign deviceAdapter_io_rspIn_bits_dataResponse = uart_wrapper_io_response_bits_dataResponse; // @[uartHarness.scala 34:28]
  assign deviceAdapter_io_rspIn_bits_error = uart_wrapper_io_response_bits_error; // @[uartHarness.scala 34:28]
  assign uart_wrapper_clock = clock;
  assign uart_wrapper_reset = reset;
  assign uart_wrapper_io_request_valid = deviceAdapter_io_reqOut_valid; // @[uartHarness.scala 33:27]
  assign uart_wrapper_io_request_bits_addrRequest = deviceAdapter_io_reqOut_bits_addrRequest; // @[uartHarness.scala 33:27]
  assign uart_wrapper_io_request_bits_dataRequest = deviceAdapter_io_reqOut_bits_dataRequest; // @[uartHarness.scala 33:27]
  assign uart_wrapper_io_request_bits_isWrite = deviceAdapter_io_reqOut_bits_isWrite; // @[uartHarness.scala 33:27]
  assign uart_wrapper_io_cio_uart_rx_i = io_cio_uart_rx_i; // @[uartHarness.scala 36:35]
endmodule
