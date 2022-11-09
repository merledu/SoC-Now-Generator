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
  output [3:0]  io_wbMasterTransmitter_bits_sel,
  output        io_wbSlaveReceiver_ready,
  input         io_wbSlaveReceiver_bits_ack,
  input  [31:0] io_wbSlaveReceiver_bits_dat,
  input         io_wbSlaveReceiver_bits_err,
  output        io_reqIn_ready,
  input         io_reqIn_valid,
  input  [31:0] io_reqIn_bits_addrRequest,
  input  [31:0] io_reqIn_bits_dataRequest,
  input  [3:0]  io_reqIn_bits_activeByteLane,
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
  reg [31:0] _RAND_11;
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
  reg [3:0] selReg; // @[WishboneHost.scala 51:23]
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
  assign io_wbMasterTransmitter_bits_sel = ~startWBTransaction ? 4'h0 : selReg; // @[WishboneHost.scala 102:31 WishboneHost.scala 103:118 WishboneHost.scala 100:37]
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
    if (reset) begin // @[WishboneHost.scala 51:23]
      selReg <= 4'h0; // @[WishboneHost.scala 51:23]
    end else if (~io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 77:86]
      selReg <= io_reqIn_bits_activeByteLane; // @[WishboneHost.scala 84:14]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 85:92]
      selReg <= io_reqIn_bits_activeByteLane; // @[WishboneHost.scala 92:14]
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
  selReg = _RAND_9[3:0];
  _RAND_10 = {1{`RANDOM}};
  stateReg = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  readyReg = _RAND_11[0:0];
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
  input  [3:0]  io_wbMasterReceiver_bits_sel,
  output        io_reqOut_valid,
  output [31:0] io_reqOut_bits_addrRequest,
  output [31:0] io_reqOut_bits_dataRequest,
  output [3:0]  io_reqOut_bits_activeByteLane,
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
  assign io_reqOut_bits_activeByteLane = io_wbMasterReceiver_bits_sel; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 34:37 WishboneDevice.scala 58:37]
  assign io_reqOut_bits_isWrite = ~io_wbMasterReceiver_bits_we ? 1'h0 : io_wbMasterReceiver_bits_we; // @[WishboneDevice.scala 26:40 WishboneDevice.scala 35:30 WishboneDevice.scala 59:30]
endmodule
module Protocol(
  input         clock,
  input         reset,
  input         io_miso,
  output        io_mosi,
  output        io_ss,
  output        io_sck,
  input         io_data_in_valid,
  input  [31:0] io_data_in_bits,
  output        io_data_out_valid,
  output [31:0] io_data_out_bits,
  input         io_CPOL
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  state; // @[Protocol.scala 28:24]
  reg [31:0] miso_dataReg; // @[Protocol.scala 30:31]
  reg [6:0] count; // @[Protocol.scala 31:24]
  reg [63:0] dataReg; // @[Protocol.scala 32:26]
  wire  _io_sck_T_2 = io_CPOL ? ~clock : clock; // @[Protocol.scala 35:38]
  wire  _T = ~state; // @[Conditional.scala 37:30]
  wire [63:0] _dataReg_T = {io_data_in_bits,32'h0}; // @[Cat.scala 30:58]
  wire [63:0] _GEN_0 = io_data_in_valid ? _dataReg_T : dataReg; // @[Protocol.scala 49:59 Protocol.scala 50:25 Protocol.scala 32:26]
  wire  _GEN_1 = io_data_in_valid | state; // @[Protocol.scala 49:59 Protocol.scala 51:23 Protocol.scala 28:24]
  wire  _T_2 = count == 7'h40; // @[Protocol.scala 60:25]
  wire [64:0] _dataReg_T_1 = {dataReg, 1'h0}; // @[Protocol.scala 68:36]
  wire [6:0] _count_T_1 = count + 7'h1; // @[Protocol.scala 69:32]
  wire  _GEN_5 = count == 7'h40 ? 1'h0 : dataReg[63]; // @[Protocol.scala 60:38 Protocol.scala 43:13 Protocol.scala 67:25]
  wire [64:0] _GEN_6 = count == 7'h40 ? {{1'd0}, dataReg} : _dataReg_T_1; // @[Protocol.scala 60:38 Protocol.scala 32:26 Protocol.scala 68:25]
  wire  _GEN_8 = state ? _T_2 : 1'h1; // @[Conditional.scala 39:67 Protocol.scala 42:11]
  wire  _GEN_11 = state & _GEN_5; // @[Conditional.scala 39:67 Protocol.scala 43:13]
  wire [64:0] _GEN_12 = state ? _GEN_6 : {{1'd0}, dataReg}; // @[Conditional.scala 39:67 Protocol.scala 32:26]
  wire [64:0] _GEN_14 = _T ? {{1'd0}, _GEN_0} : _GEN_12; // @[Conditional.scala 40:58]
  wire  _GEN_16 = _T | _GEN_8; // @[Conditional.scala 40:58 Protocol.scala 42:11]
  reg [6:0] count1; // @[Protocol.scala 75:25]
  wire  _T_4 = count1 == 7'h40; // @[Protocol.scala 79:26]
  wire [32:0] _miso_dataReg_T = {miso_dataReg, 1'h0}; // @[Protocol.scala 84:46]
  wire [32:0] _GEN_28 = {{32'd0}, io_miso}; // @[Protocol.scala 84:51]
  wire [32:0] _miso_dataReg_T_1 = _miso_dataReg_T | _GEN_28; // @[Protocol.scala 84:51]
  wire [6:0] _count1_T_1 = count1 + 7'h1; // @[Protocol.scala 85:34]
  wire [31:0] _GEN_19 = count1 == 7'h40 ? miso_dataReg : 32'h0; // @[Protocol.scala 79:63 Protocol.scala 80:34 Protocol.scala 41:22]
  wire [32:0] _GEN_22 = count1 == 7'h40 ? {{1'd0}, miso_dataReg} : _miso_dataReg_T_1; // @[Protocol.scala 79:63 Protocol.scala 30:31 Protocol.scala 84:30]
  wire [32:0] _GEN_27 = state ? _GEN_22 : {{1'd0}, miso_dataReg}; // @[Conditional.scala 40:58 Protocol.scala 30:31]
  assign io_mosi = _T ? 1'h0 : _GEN_11; // @[Conditional.scala 40:58 Protocol.scala 43:13]
  assign io_ss = state ? 1'h0 : _GEN_16; // @[Conditional.scala 40:58 Protocol.scala 78:19]
  assign io_sck = state & _io_sck_T_2; // @[Protocol.scala 35:18]
  assign io_data_out_valid = state & _T_4; // @[Conditional.scala 40:58 Protocol.scala 40:23]
  assign io_data_out_bits = state ? _GEN_19 : 32'h0; // @[Conditional.scala 40:58 Protocol.scala 41:22]
  always @(posedge clock) begin
    if (reset) begin // @[Protocol.scala 28:24]
      state <= 1'h0; // @[Protocol.scala 28:24]
    end else if (_T) begin // @[Conditional.scala 40:58]
      state <= _GEN_1;
    end else if (state) begin // @[Conditional.scala 39:67]
      if (count == 7'h40) begin // @[Protocol.scala 60:38]
        state <= 1'h0; // @[Protocol.scala 63:23]
      end
    end
    if (reset) begin // @[Protocol.scala 30:31]
      miso_dataReg <= 32'h0; // @[Protocol.scala 30:31]
    end else begin
      miso_dataReg <= _GEN_27[31:0];
    end
    if (reset) begin // @[Protocol.scala 31:24]
      count <= 7'h0; // @[Protocol.scala 31:24]
    end else if (!(_T)) begin // @[Conditional.scala 40:58]
      if (state) begin // @[Conditional.scala 39:67]
        if (count == 7'h40) begin // @[Protocol.scala 60:38]
          count <= 7'h0; // @[Protocol.scala 64:23]
        end else begin
          count <= _count_T_1; // @[Protocol.scala 69:23]
        end
      end
    end
    if (reset) begin // @[Protocol.scala 32:26]
      dataReg <= 64'h0; // @[Protocol.scala 32:26]
    end else begin
      dataReg <= _GEN_14[63:0];
    end
    if (reset) begin // @[Protocol.scala 75:25]
      count1 <= 7'h0; // @[Protocol.scala 75:25]
    end else if (state) begin // @[Conditional.scala 40:58]
      if (count1 == 7'h40) begin // @[Protocol.scala 79:63]
        count1 <= 7'h0; // @[Protocol.scala 82:24]
      end else begin
        count1 <= _count1_T_1; // @[Protocol.scala 85:24]
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
  state = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  miso_dataReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  count = _RAND_2[6:0];
  _RAND_3 = {2{`RANDOM}};
  dataReg = _RAND_3[63:0];
  _RAND_4 = {1{`RANDOM}};
  count1 = _RAND_4[6:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SpiFlash(
  input         clock,
  input         reset,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input  [3:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse,
  output        io_rsp_bits_error,
  output        io_cs_n,
  output        io_sclk,
  output        io_mosi,
  input         io_miso
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
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
`endif // RANDOMIZE_REG_INIT
  wire  spiProtocol_clock; // @[SpiFlash.scala 126:29]
  wire  spiProtocol_reset; // @[SpiFlash.scala 126:29]
  wire  spiProtocol_io_miso; // @[SpiFlash.scala 126:29]
  wire  spiProtocol_io_mosi; // @[SpiFlash.scala 126:29]
  wire  spiProtocol_io_ss; // @[SpiFlash.scala 126:29]
  wire  spiProtocol_io_sck; // @[SpiFlash.scala 126:29]
  wire  spiProtocol_io_data_in_valid; // @[SpiFlash.scala 126:29]
  wire [31:0] spiProtocol_io_data_in_bits; // @[SpiFlash.scala 126:29]
  wire  spiProtocol_io_data_out_valid; // @[SpiFlash.scala 126:29]
  wire [31:0] spiProtocol_io_data_out_bits; // @[SpiFlash.scala 126:29]
  wire  spiProtocol_io_CPOL; // @[SpiFlash.scala 126:29]
  reg [31:0] ControlReg; // @[SpiFlash.scala 28:29]
  reg [31:0] TxDataReg; // @[SpiFlash.scala 29:31]
  reg  TxDataValidReg; // @[SpiFlash.scala 30:33]
  reg [31:0] RxDataReg; // @[SpiFlash.scala 31:31]
  reg  RxDataValidReg; // @[SpiFlash.scala 32:33]
  wire [7:0] maskedData_0 = io_req_bits_activeByteLane[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] maskedData_1 = io_req_bits_activeByteLane[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] maskedData_2 = io_req_bits_activeByteLane[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] maskedData_3 = io_req_bits_activeByteLane[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire  _T_13 = io_req_bits_addrRequest[3:0] == 4'h0; // @[SpiFlash.scala 41:40]
  wire [31:0] _ControlReg_T = {maskedData_3,maskedData_2,maskedData_1,maskedData_0}; // @[SpiFlash.scala 42:78]
  wire [31:0] _ControlReg_T_1 = io_req_bits_dataRequest & _ControlReg_T; // @[SpiFlash.scala 42:65]
  reg [31:0] io_rsp_bits_dataResponse_REG; // @[SpiFlash.scala 44:44]
  reg  io_rsp_valid_REG; // @[SpiFlash.scala 45:32]
  wire  _T_18 = ~io_req_bits_isWrite; // @[SpiFlash.scala 51:75]
  reg [31:0] io_rsp_bits_dataResponse_REG_1; // @[SpiFlash.scala 52:44]
  reg  io_rsp_valid_REG_1; // @[SpiFlash.scala 53:32]
  wire  _T_21 = io_req_bits_addrRequest[3:0] == 4'h4; // @[SpiFlash.scala 59:44]
  wire [23:0] TxDataReg_lo_1 = _ControlReg_T_1[23:0]; // @[SpiFlash.scala 61:107]
  wire [25:0] _TxDataReg_T_2 = {2'h3,TxDataReg_lo_1}; // @[Cat.scala 30:58]
  wire [25:0] _TxDataReg_T_3 = io_req_valid ? _TxDataReg_T_2 : 26'h0; // @[SpiFlash.scala 61:29]
  wire [26:0] _TxDataReg_T_5 = io_req_valid ? 27'h6000000 : 27'h0; // @[SpiFlash.scala 65:29]
  wire [25:0] _TxDataReg_T_8 = {2'h2,TxDataReg_lo_1}; // @[Cat.scala 30:58]
  wire [25:0] _TxDataReg_T_9 = io_req_valid ? _TxDataReg_T_8 : 26'h0; // @[SpiFlash.scala 69:29]
  wire [31:0] _TxDataReg_T_12 = io_req_valid ? _ControlReg_T_1 : 32'h0; // @[SpiFlash.scala 73:29]
  wire [26:0] _TxDataReg_T_14 = io_req_valid ? 27'h4000000 : 27'h0; // @[SpiFlash.scala 77:29]
  wire [31:0] _GEN_0 = ControlReg[4:2] == 3'h4 ? {{5'd0}, _TxDataReg_T_14} : TxDataReg; // @[SpiFlash.scala 76:43 SpiFlash.scala 77:23 SpiFlash.scala 29:31]
  wire  _GEN_1 = ControlReg[4:2] == 3'h4 ? io_req_valid : TxDataValidReg; // @[SpiFlash.scala 76:43 SpiFlash.scala 78:28 SpiFlash.scala 30:33]
  wire [31:0] _GEN_2 = ControlReg[4:2] == 3'h3 ? _TxDataReg_T_12 : _GEN_0; // @[SpiFlash.scala 72:43 SpiFlash.scala 73:23]
  wire  _GEN_3 = ControlReg[4:2] == 3'h3 ? io_req_valid : _GEN_1; // @[SpiFlash.scala 72:43 SpiFlash.scala 74:28]
  wire [31:0] _GEN_4 = ControlReg[4:2] == 3'h2 ? {{6'd0}, _TxDataReg_T_9} : _GEN_2; // @[SpiFlash.scala 68:43 SpiFlash.scala 69:23]
  wire  _GEN_5 = ControlReg[4:2] == 3'h2 ? io_req_valid : _GEN_3; // @[SpiFlash.scala 68:43 SpiFlash.scala 70:28]
  wire [31:0] _GEN_6 = ControlReg[4:2] == 3'h1 ? {{5'd0}, _TxDataReg_T_5} : _GEN_4; // @[SpiFlash.scala 64:43 SpiFlash.scala 65:23]
  wire  _GEN_7 = ControlReg[4:2] == 3'h1 ? io_req_valid : _GEN_5; // @[SpiFlash.scala 64:43 SpiFlash.scala 66:28]
  wire [31:0] _GEN_8 = ControlReg[4:2] == 3'h0 ? {{6'd0}, _TxDataReg_T_3} : _GEN_6; // @[SpiFlash.scala 60:38 SpiFlash.scala 61:23]
  wire  _GEN_9 = ControlReg[4:2] == 3'h0 ? io_req_valid : _GEN_7; // @[SpiFlash.scala 60:38 SpiFlash.scala 62:28]
  reg [31:0] io_rsp_bits_dataResponse_REG_2; // @[SpiFlash.scala 82:44]
  reg [31:0] io_rsp_bits_dataResponse_REG_3; // @[SpiFlash.scala 89:44]
  reg  io_rsp_valid_REG_3; // @[SpiFlash.scala 90:32]
  wire  _T_39 = io_req_bits_addrRequest[3:0] == 4'h8; // @[SpiFlash.scala 95:44]
  reg [31:0] io_rsp_bits_dataResponse_REG_4; // @[SpiFlash.scala 96:44]
  reg [31:0] io_rsp_bits_dataResponse_REG_5; // @[SpiFlash.scala 107:44]
  wire [31:0] _GEN_10 = io_req_bits_addrRequest[3:0] == 4'h8 & _T_18 ? io_rsp_bits_dataResponse_REG_4 :
    io_rsp_bits_dataResponse_REG_5; // @[SpiFlash.scala 95:83 SpiFlash.scala 96:34 SpiFlash.scala 107:34]
  wire [31:0] _GEN_12 = _T_21 & _T_18 ? io_rsp_bits_dataResponse_REG_3 : _GEN_10; // @[SpiFlash.scala 88:83 SpiFlash.scala 89:34]
  wire  _GEN_13 = _T_21 & _T_18 ? io_rsp_valid_REG_3 : RxDataValidReg; // @[SpiFlash.scala 88:83 SpiFlash.scala 90:22]
  wire [31:0] _GEN_16 = io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite ? io_rsp_bits_dataResponse_REG_2 :
    _GEN_12; // @[SpiFlash.scala 59:83 SpiFlash.scala 82:34]
  wire  _GEN_17 = io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite | _GEN_13; // @[SpiFlash.scala 59:83 SpiFlash.scala 83:22]
  wire [31:0] _GEN_18 = _T_13 & ~io_req_bits_isWrite ? io_rsp_bits_dataResponse_REG_1 : _GEN_16; // @[SpiFlash.scala 51:83 SpiFlash.scala 52:34]
  wire  _GEN_19 = _T_13 & ~io_req_bits_isWrite ? io_rsp_valid_REG_1 : _GEN_17; // @[SpiFlash.scala 51:83 SpiFlash.scala 53:22]
  wire [25:0] _spiProtocol_clock_T_3 = ControlReg[31:6] - 26'h1; // @[SpiFlash.scala 116:36]
  reg [25:0] spiProtocol_clock_x; // @[SpiFlash.scala 112:24]
  wire [25:0] _spiProtocol_clock_x_T_2 = spiProtocol_clock_x + 26'h1; // @[SpiFlash.scala 113:36]
  wire  _spiProtocol_clock_T_4 = spiProtocol_clock_x == 26'h0; // @[SpiFlash.scala 116:43]
  reg  spiProtocol_clock_x_1; // @[SpiFlash.scala 118:24]
  wire  _GEN_28 = spiProtocol_io_data_out_valid | RxDataValidReg; // @[SpiFlash.scala 136:40 SpiFlash.scala 138:24 SpiFlash.scala 32:33]
  wire  addr_miss = ~(_T_13 | _T_21 | _T_39); // @[SpiFlash.scala 160:18]
  reg  io_rsp_bits_error_REG; // @[SpiFlash.scala 161:78]
  reg  io_rsp_bits_error_REG_1; // @[SpiFlash.scala 162:44]
  Protocol spiProtocol ( // @[SpiFlash.scala 126:29]
    .clock(spiProtocol_clock),
    .reset(spiProtocol_reset),
    .io_miso(spiProtocol_io_miso),
    .io_mosi(spiProtocol_io_mosi),
    .io_ss(spiProtocol_io_ss),
    .io_sck(spiProtocol_io_sck),
    .io_data_in_valid(spiProtocol_io_data_in_valid),
    .io_data_in_bits(spiProtocol_io_data_in_bits),
    .io_data_out_valid(spiProtocol_io_data_out_valid),
    .io_data_out_bits(spiProtocol_io_data_out_bits),
    .io_CPOL(spiProtocol_io_CPOL)
  );
  assign io_rsp_valid = io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite ? io_rsp_valid_REG : _GEN_19; // @[SpiFlash.scala 41:79 SpiFlash.scala 45:22]
  assign io_rsp_bits_dataResponse = io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite ?
    io_rsp_bits_dataResponse_REG : _GEN_18; // @[SpiFlash.scala 41:79 SpiFlash.scala 44:34]
  assign io_rsp_bits_error = _T_39 & io_req_bits_isWrite ? io_rsp_bits_error_REG : io_rsp_bits_error_REG_1; // @[SpiFlash.scala 161:49 SpiFlash.scala 161:68 SpiFlash.scala 162:34]
  assign io_cs_n = spiProtocol_io_ss; // @[SpiFlash.scala 135:121]
  assign io_sclk = spiProtocol_io_sck; // @[SpiFlash.scala 135:121]
  assign io_mosi = spiProtocol_io_mosi; // @[SpiFlash.scala 135:121]
  assign spiProtocol_clock = spiProtocol_clock_x_1; // @[SpiFlash.scala 128:53]
  assign spiProtocol_reset = reset;
  assign spiProtocol_io_miso = io_miso; // @[SpiFlash.scala 133:25]
  assign spiProtocol_io_data_in_valid = TxDataValidReg; // @[SpiFlash.scala 130:34]
  assign spiProtocol_io_data_in_bits = TxDataReg; // @[SpiFlash.scala 129:34]
  assign spiProtocol_io_CPOL = ControlReg[1]; // @[SpiFlash.scala 131:38]
  always @(posedge clock) begin
    if (reset) begin // @[SpiFlash.scala 28:29]
      ControlReg <= 32'h60; // @[SpiFlash.scala 28:29]
    end else if (io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite) begin // @[SpiFlash.scala 41:79]
      if (io_req_valid) begin // @[SpiFlash.scala 42:26]
        ControlReg <= _ControlReg_T_1;
      end
    end
    if (reset) begin // @[SpiFlash.scala 29:31]
      TxDataReg <= 32'h0; // @[SpiFlash.scala 29:31]
    end else if (!(io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite)) begin // @[SpiFlash.scala 41:79]
      if (!(_T_13 & ~io_req_bits_isWrite)) begin // @[SpiFlash.scala 51:83]
        if (io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite) begin // @[SpiFlash.scala 59:83]
          TxDataReg <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[SpiFlash.scala 30:33]
      TxDataValidReg <= 1'h0; // @[SpiFlash.scala 30:33]
    end else if (!(io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite)) begin // @[SpiFlash.scala 41:79]
      if (!(_T_13 & ~io_req_bits_isWrite)) begin // @[SpiFlash.scala 51:83]
        if (io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite) begin // @[SpiFlash.scala 59:83]
          TxDataValidReg <= _GEN_9;
        end
      end
    end
    if (reset) begin // @[SpiFlash.scala 31:31]
      RxDataReg <= 32'h0; // @[SpiFlash.scala 31:31]
    end else if (spiProtocol_io_data_out_valid) begin // @[SpiFlash.scala 136:40]
      RxDataReg <= spiProtocol_io_data_out_bits; // @[SpiFlash.scala 137:19]
    end
    if (reset) begin // @[SpiFlash.scala 32:33]
      RxDataValidReg <= 1'h0; // @[SpiFlash.scala 32:33]
    end else begin
      RxDataValidReg <= _GEN_28;
    end
    io_rsp_bits_dataResponse_REG <= io_req_bits_dataRequest; // @[SpiFlash.scala 44:48]
    io_rsp_valid_REG <= io_req_valid; // @[SpiFlash.scala 45:32]
    io_rsp_bits_dataResponse_REG_1 <= ControlReg; // @[SpiFlash.scala 52:48]
    io_rsp_valid_REG_1 <= io_req_valid; // @[SpiFlash.scala 53:36]
    io_rsp_bits_dataResponse_REG_2 <= io_req_bits_addrRequest; // @[SpiFlash.scala 82:48]
    io_rsp_bits_dataResponse_REG_3 <= TxDataReg; // @[SpiFlash.scala 89:48]
    io_rsp_valid_REG_3 <= io_req_valid; // @[SpiFlash.scala 90:32]
    io_rsp_bits_dataResponse_REG_4 <= RxDataReg; // @[SpiFlash.scala 96:48]
    io_rsp_bits_dataResponse_REG_5 <= io_req_bits_addrRequest; // @[SpiFlash.scala 107:44]
    if (reset) begin // @[SpiFlash.scala 112:24]
      spiProtocol_clock_x <= 26'h0; // @[SpiFlash.scala 112:24]
    end else if (spiProtocol_clock_x == _spiProtocol_clock_T_3) begin // @[SpiFlash.scala 113:17]
      spiProtocol_clock_x <= 26'h0;
    end else begin
      spiProtocol_clock_x <= _spiProtocol_clock_x_T_2;
    end
    if (reset) begin // @[SpiFlash.scala 118:24]
      spiProtocol_clock_x_1 <= 1'h0; // @[SpiFlash.scala 118:24]
    end else if (_spiProtocol_clock_T_4) begin // @[SpiFlash.scala 119:17]
      spiProtocol_clock_x_1 <= ~spiProtocol_clock_x_1;
    end
    io_rsp_bits_error_REG <= io_req_valid; // @[SpiFlash.scala 161:78]
    io_rsp_bits_error_REG_1 <= io_req_valid & addr_miss; // @[SpiFlash.scala 162:58]
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
  ControlReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  TxDataReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  TxDataValidReg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  RxDataReg = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  RxDataValidReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  io_rsp_valid_REG = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_1 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  io_rsp_valid_REG_1 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_2 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_3 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  io_rsp_valid_REG_3 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_4 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_5 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  spiProtocol_clock_x = _RAND_14[25:0];
  _RAND_15 = {1{`RANDOM}};
  spiProtocol_clock_x_1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  io_rsp_bits_error_REG = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  io_rsp_bits_error_REG_1 = _RAND_17[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SpiFlashHarness(
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
  output        io_cs_n,
  output        io_sclk,
  output        io_mosi,
  input         io_miso
);
  wire  hostAdapter_clock; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_reset; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_wbMasterTransmitter_ready; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_wbMasterTransmitter_valid; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_wbMasterTransmitter_bits_cyc; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_wbMasterTransmitter_bits_stb; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_wbMasterTransmitter_bits_we; // @[SpiFlashHarness.scala 23:27]
  wire [31:0] hostAdapter_io_wbMasterTransmitter_bits_adr; // @[SpiFlashHarness.scala 23:27]
  wire [31:0] hostAdapter_io_wbMasterTransmitter_bits_dat; // @[SpiFlashHarness.scala 23:27]
  wire [3:0] hostAdapter_io_wbMasterTransmitter_bits_sel; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_wbSlaveReceiver_ready; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_wbSlaveReceiver_bits_ack; // @[SpiFlashHarness.scala 23:27]
  wire [31:0] hostAdapter_io_wbSlaveReceiver_bits_dat; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_wbSlaveReceiver_bits_err; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_reqIn_ready; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_reqIn_valid; // @[SpiFlashHarness.scala 23:27]
  wire [31:0] hostAdapter_io_reqIn_bits_addrRequest; // @[SpiFlashHarness.scala 23:27]
  wire [31:0] hostAdapter_io_reqIn_bits_dataRequest; // @[SpiFlashHarness.scala 23:27]
  wire [3:0] hostAdapter_io_reqIn_bits_activeByteLane; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_reqIn_bits_isWrite; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_rspOut_valid; // @[SpiFlashHarness.scala 23:27]
  wire [31:0] hostAdapter_io_rspOut_bits_dataResponse; // @[SpiFlashHarness.scala 23:27]
  wire  hostAdapter_io_rspOut_bits_error; // @[SpiFlashHarness.scala 23:27]
  wire  deviceAdapter_io_wbSlaveTransmitter_ready; // @[SpiFlashHarness.scala 24:29]
  wire  deviceAdapter_io_wbSlaveTransmitter_bits_ack; // @[SpiFlashHarness.scala 24:29]
  wire [31:0] deviceAdapter_io_wbSlaveTransmitter_bits_dat; // @[SpiFlashHarness.scala 24:29]
  wire  deviceAdapter_io_wbSlaveTransmitter_bits_err; // @[SpiFlashHarness.scala 24:29]
  wire  deviceAdapter_io_wbMasterReceiver_ready; // @[SpiFlashHarness.scala 24:29]
  wire  deviceAdapter_io_wbMasterReceiver_valid; // @[SpiFlashHarness.scala 24:29]
  wire  deviceAdapter_io_wbMasterReceiver_bits_cyc; // @[SpiFlashHarness.scala 24:29]
  wire  deviceAdapter_io_wbMasterReceiver_bits_stb; // @[SpiFlashHarness.scala 24:29]
  wire  deviceAdapter_io_wbMasterReceiver_bits_we; // @[SpiFlashHarness.scala 24:29]
  wire [31:0] deviceAdapter_io_wbMasterReceiver_bits_adr; // @[SpiFlashHarness.scala 24:29]
  wire [31:0] deviceAdapter_io_wbMasterReceiver_bits_dat; // @[SpiFlashHarness.scala 24:29]
  wire [3:0] deviceAdapter_io_wbMasterReceiver_bits_sel; // @[SpiFlashHarness.scala 24:29]
  wire  deviceAdapter_io_reqOut_valid; // @[SpiFlashHarness.scala 24:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_addrRequest; // @[SpiFlashHarness.scala 24:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_dataRequest; // @[SpiFlashHarness.scala 24:29]
  wire [3:0] deviceAdapter_io_reqOut_bits_activeByteLane; // @[SpiFlashHarness.scala 24:29]
  wire  deviceAdapter_io_reqOut_bits_isWrite; // @[SpiFlashHarness.scala 24:29]
  wire  deviceAdapter_io_rspIn_valid; // @[SpiFlashHarness.scala 24:29]
  wire [31:0] deviceAdapter_io_rspIn_bits_dataResponse; // @[SpiFlashHarness.scala 24:29]
  wire  deviceAdapter_io_rspIn_bits_error; // @[SpiFlashHarness.scala 24:29]
  wire  spi_clock; // @[SpiFlashHarness.scala 25:19]
  wire  spi_reset; // @[SpiFlashHarness.scala 25:19]
  wire  spi_io_req_valid; // @[SpiFlashHarness.scala 25:19]
  wire [31:0] spi_io_req_bits_addrRequest; // @[SpiFlashHarness.scala 25:19]
  wire [31:0] spi_io_req_bits_dataRequest; // @[SpiFlashHarness.scala 25:19]
  wire [3:0] spi_io_req_bits_activeByteLane; // @[SpiFlashHarness.scala 25:19]
  wire  spi_io_req_bits_isWrite; // @[SpiFlashHarness.scala 25:19]
  wire  spi_io_rsp_valid; // @[SpiFlashHarness.scala 25:19]
  wire [31:0] spi_io_rsp_bits_dataResponse; // @[SpiFlashHarness.scala 25:19]
  wire  spi_io_rsp_bits_error; // @[SpiFlashHarness.scala 25:19]
  wire  spi_io_cs_n; // @[SpiFlashHarness.scala 25:19]
  wire  spi_io_sclk; // @[SpiFlashHarness.scala 25:19]
  wire  spi_io_mosi; // @[SpiFlashHarness.scala 25:19]
  wire  spi_io_miso; // @[SpiFlashHarness.scala 25:19]
  WishboneHost hostAdapter ( // @[SpiFlashHarness.scala 23:27]
    .clock(hostAdapter_clock),
    .reset(hostAdapter_reset),
    .io_wbMasterTransmitter_ready(hostAdapter_io_wbMasterTransmitter_ready),
    .io_wbMasterTransmitter_valid(hostAdapter_io_wbMasterTransmitter_valid),
    .io_wbMasterTransmitter_bits_cyc(hostAdapter_io_wbMasterTransmitter_bits_cyc),
    .io_wbMasterTransmitter_bits_stb(hostAdapter_io_wbMasterTransmitter_bits_stb),
    .io_wbMasterTransmitter_bits_we(hostAdapter_io_wbMasterTransmitter_bits_we),
    .io_wbMasterTransmitter_bits_adr(hostAdapter_io_wbMasterTransmitter_bits_adr),
    .io_wbMasterTransmitter_bits_dat(hostAdapter_io_wbMasterTransmitter_bits_dat),
    .io_wbMasterTransmitter_bits_sel(hostAdapter_io_wbMasterTransmitter_bits_sel),
    .io_wbSlaveReceiver_ready(hostAdapter_io_wbSlaveReceiver_ready),
    .io_wbSlaveReceiver_bits_ack(hostAdapter_io_wbSlaveReceiver_bits_ack),
    .io_wbSlaveReceiver_bits_dat(hostAdapter_io_wbSlaveReceiver_bits_dat),
    .io_wbSlaveReceiver_bits_err(hostAdapter_io_wbSlaveReceiver_bits_err),
    .io_reqIn_ready(hostAdapter_io_reqIn_ready),
    .io_reqIn_valid(hostAdapter_io_reqIn_valid),
    .io_reqIn_bits_addrRequest(hostAdapter_io_reqIn_bits_addrRequest),
    .io_reqIn_bits_dataRequest(hostAdapter_io_reqIn_bits_dataRequest),
    .io_reqIn_bits_activeByteLane(hostAdapter_io_reqIn_bits_activeByteLane),
    .io_reqIn_bits_isWrite(hostAdapter_io_reqIn_bits_isWrite),
    .io_rspOut_valid(hostAdapter_io_rspOut_valid),
    .io_rspOut_bits_dataResponse(hostAdapter_io_rspOut_bits_dataResponse),
    .io_rspOut_bits_error(hostAdapter_io_rspOut_bits_error)
  );
  WishboneDevice deviceAdapter ( // @[SpiFlashHarness.scala 24:29]
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
    .io_wbMasterReceiver_bits_sel(deviceAdapter_io_wbMasterReceiver_bits_sel),
    .io_reqOut_valid(deviceAdapter_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(deviceAdapter_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(deviceAdapter_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(deviceAdapter_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(deviceAdapter_io_reqOut_bits_isWrite),
    .io_rspIn_valid(deviceAdapter_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(deviceAdapter_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(deviceAdapter_io_rspIn_bits_error)
  );
  SpiFlash spi ( // @[SpiFlashHarness.scala 25:19]
    .clock(spi_clock),
    .reset(spi_reset),
    .io_req_valid(spi_io_req_valid),
    .io_req_bits_addrRequest(spi_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(spi_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(spi_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(spi_io_req_bits_isWrite),
    .io_rsp_valid(spi_io_rsp_valid),
    .io_rsp_bits_dataResponse(spi_io_rsp_bits_dataResponse),
    .io_rsp_bits_error(spi_io_rsp_bits_error),
    .io_cs_n(spi_io_cs_n),
    .io_sclk(spi_io_sclk),
    .io_mosi(spi_io_mosi),
    .io_miso(spi_io_miso)
  );
  assign io_req_ready = hostAdapter_io_reqIn_ready; // @[SpiFlashHarness.scala 27:24]
  assign io_rsp_valid = hostAdapter_io_rspOut_valid; // @[SpiFlashHarness.scala 28:10]
  assign io_rsp_bits_dataResponse = hostAdapter_io_rspOut_bits_dataResponse; // @[SpiFlashHarness.scala 28:10]
  assign io_rsp_bits_error = hostAdapter_io_rspOut_bits_error; // @[SpiFlashHarness.scala 28:10]
  assign io_cs_n = spi_io_cs_n; // @[SpiFlashHarness.scala 36:13]
  assign io_sclk = spi_io_sclk; // @[SpiFlashHarness.scala 37:13]
  assign io_mosi = spi_io_mosi; // @[SpiFlashHarness.scala 38:13]
  assign hostAdapter_clock = clock;
  assign hostAdapter_reset = reset;
  assign hostAdapter_io_wbMasterTransmitter_ready = deviceAdapter_io_wbMasterReceiver_ready; // @[SpiFlashHarness.scala 29:38]
  assign hostAdapter_io_wbSlaveReceiver_bits_ack = deviceAdapter_io_wbSlaveTransmitter_bits_ack; // @[SpiFlashHarness.scala 30:34]
  assign hostAdapter_io_wbSlaveReceiver_bits_dat = deviceAdapter_io_wbSlaveTransmitter_bits_dat; // @[SpiFlashHarness.scala 30:34]
  assign hostAdapter_io_wbSlaveReceiver_bits_err = deviceAdapter_io_wbSlaveTransmitter_bits_err; // @[SpiFlashHarness.scala 30:34]
  assign hostAdapter_io_reqIn_valid = io_req_valid; // @[SpiFlashHarness.scala 27:24]
  assign hostAdapter_io_reqIn_bits_addrRequest = io_req_bits_addrRequest; // @[SpiFlashHarness.scala 27:24]
  assign hostAdapter_io_reqIn_bits_dataRequest = io_req_bits_dataRequest; // @[SpiFlashHarness.scala 27:24]
  assign hostAdapter_io_reqIn_bits_activeByteLane = io_req_bits_activeByteLane; // @[SpiFlashHarness.scala 27:24]
  assign hostAdapter_io_reqIn_bits_isWrite = io_req_bits_isWrite; // @[SpiFlashHarness.scala 27:24]
  assign deviceAdapter_io_wbSlaveTransmitter_ready = hostAdapter_io_wbSlaveReceiver_ready; // @[SpiFlashHarness.scala 30:34]
  assign deviceAdapter_io_wbMasterReceiver_valid = hostAdapter_io_wbMasterTransmitter_valid; // @[SpiFlashHarness.scala 29:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_cyc = hostAdapter_io_wbMasterTransmitter_bits_cyc; // @[SpiFlashHarness.scala 29:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_stb = hostAdapter_io_wbMasterTransmitter_bits_stb; // @[SpiFlashHarness.scala 29:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_we = hostAdapter_io_wbMasterTransmitter_bits_we; // @[SpiFlashHarness.scala 29:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_adr = hostAdapter_io_wbMasterTransmitter_bits_adr; // @[SpiFlashHarness.scala 29:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_dat = hostAdapter_io_wbMasterTransmitter_bits_dat; // @[SpiFlashHarness.scala 29:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_sel = hostAdapter_io_wbMasterTransmitter_bits_sel; // @[SpiFlashHarness.scala 29:38]
  assign deviceAdapter_io_rspIn_valid = spi_io_rsp_valid; // @[SpiFlashHarness.scala 33:14]
  assign deviceAdapter_io_rspIn_bits_dataResponse = spi_io_rsp_bits_dataResponse; // @[SpiFlashHarness.scala 33:14]
  assign deviceAdapter_io_rspIn_bits_error = spi_io_rsp_bits_error; // @[SpiFlashHarness.scala 33:14]
  assign spi_clock = clock;
  assign spi_reset = reset;
  assign spi_io_req_valid = deviceAdapter_io_reqOut_valid; // @[SpiFlashHarness.scala 32:14]
  assign spi_io_req_bits_addrRequest = deviceAdapter_io_reqOut_bits_addrRequest; // @[SpiFlashHarness.scala 32:14]
  assign spi_io_req_bits_dataRequest = deviceAdapter_io_reqOut_bits_dataRequest; // @[SpiFlashHarness.scala 32:14]
  assign spi_io_req_bits_activeByteLane = deviceAdapter_io_reqOut_bits_activeByteLane; // @[SpiFlashHarness.scala 32:14]
  assign spi_io_req_bits_isWrite = deviceAdapter_io_reqOut_bits_isWrite; // @[SpiFlashHarness.scala 32:14]
  assign spi_io_miso = io_miso; // @[SpiFlashHarness.scala 40:17]
endmodule
