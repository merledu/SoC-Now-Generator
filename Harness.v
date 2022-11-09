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
module SubReg(
  input         clock,
  input         reset,
  input         io_we,
  input  [31:0] io_wd,
  input         io_de,
  input  [31:0] io_d,
  output [31:0] io_q,
  output [31:0] io_qs
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] q_reg; // @[SubReg.scala 24:22]
  wire  wr_en = io_we | io_de; // @[SubReg.scala 33:20]
  wire [31:0] _wr_data_T = io_de ? io_d : q_reg; // @[SubReg.scala 34:19]
  wire [31:0] _wr_data_T_1 = ~io_wd; // @[SubReg.scala 34:53]
  wire [31:0] _wr_data_T_3 = io_we ? _wr_data_T_1 : 32'hffffffff; // @[SubReg.scala 34:45]
  wire [31:0] wr_data = _wr_data_T & _wr_data_T_3; // @[SubReg.scala 34:40]
  assign io_q = q_reg; // @[SubReg.scala 52:8]
  assign io_qs = q_reg; // @[SubReg.scala 51:9]
  always @(posedge clock) begin
    if (reset) begin // @[SubReg.scala 24:22]
      q_reg <= 32'h0; // @[SubReg.scala 24:22]
    end else if (wr_en) begin // @[SubReg.scala 47:15]
      q_reg <= wr_data; // @[SubReg.scala 48:11]
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
  q_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SubReg_1(
  input         clock,
  input         reset,
  input         io_we,
  input  [31:0] io_wd,
  output [31:0] io_q,
  output [31:0] io_qs
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] q_reg; // @[SubReg.scala 24:22]
  assign io_q = q_reg; // @[SubReg.scala 52:8]
  assign io_qs = q_reg; // @[SubReg.scala 51:9]
  always @(posedge clock) begin
    if (reset) begin // @[SubReg.scala 24:22]
      q_reg <= 32'h0; // @[SubReg.scala 24:22]
    end else if (io_we) begin // @[SubReg.scala 47:15]
      if (io_we) begin // @[SubReg.scala 28:19]
        q_reg <= io_wd;
      end else begin
        q_reg <= 32'h0;
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
  q_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SubRegExt(
  input         io_we,
  input  [31:0] io_wd,
  input  [31:0] io_d,
  output        io_qe,
  output [31:0] io_q,
  output [31:0] io_qs
);
  assign io_qe = io_we; // @[SubRegExt.scala 25:9]
  assign io_q = io_wd; // @[SubRegExt.scala 24:8]
  assign io_qs = io_d; // @[SubRegExt.scala 23:9]
endmodule
module SubReg_2(
  input         clock,
  input         reset,
  input  [31:0] io_d,
  output [31:0] io_qs
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] q_reg; // @[SubReg.scala 24:22]
  assign io_qs = q_reg; // @[SubReg.scala 51:9]
  always @(posedge clock) begin
    if (reset) begin // @[SubReg.scala 24:22]
      q_reg <= 32'h0; // @[SubReg.scala 24:22]
    end else begin
      q_reg <= io_d;
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
  q_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SubRegExt_2(
  input         io_we,
  input  [15:0] io_wd,
  input  [15:0] io_d,
  output        io_qe,
  output [15:0] io_q,
  output [15:0] io_qs
);
  assign io_qe = io_we; // @[SubRegExt.scala 25:9]
  assign io_q = io_wd; // @[SubRegExt.scala 24:8]
  assign io_qs = io_d; // @[SubRegExt.scala 23:9]
endmodule
module GpioRegTop(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input  [3:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse,
  output        io_rsp_bits_error,
  output [31:0] io_reg2hw_intr_state_q,
  output [31:0] io_reg2hw_intr_enable_q,
  output [31:0] io_reg2hw_intr_test_q,
  output        io_reg2hw_intr_test_qe,
  output [31:0] io_reg2hw_direct_out_q,
  output        io_reg2hw_direct_out_qe,
  output [15:0] io_reg2hw_masked_out_lower_data_q,
  output        io_reg2hw_masked_out_lower_data_qe,
  output [15:0] io_reg2hw_masked_out_lower_mask_q,
  output [15:0] io_reg2hw_masked_out_upper_data_q,
  output        io_reg2hw_masked_out_upper_data_qe,
  output [15:0] io_reg2hw_masked_out_upper_mask_q,
  output [31:0] io_reg2hw_direct_oe_q,
  output        io_reg2hw_direct_oe_qe,
  output [15:0] io_reg2hw_masked_oe_lower_data_q,
  output        io_reg2hw_masked_oe_lower_data_qe,
  output [15:0] io_reg2hw_masked_oe_lower_mask_q,
  output [15:0] io_reg2hw_masked_oe_upper_data_q,
  output        io_reg2hw_masked_oe_upper_data_qe,
  output [15:0] io_reg2hw_masked_oe_upper_mask_q,
  output [31:0] io_reg2hw_intr_ctrl_en_rising_q,
  output [31:0] io_reg2hw_intr_ctrl_en_falling_q,
  output [31:0] io_reg2hw_intr_ctrl_en_lvlHigh_q,
  output [31:0] io_reg2hw_intr_ctrl_en_lvlLow_q,
  input  [31:0] io_hw2reg_intr_state_d,
  input         io_hw2reg_intr_state_de,
  input  [31:0] io_hw2reg_data_in_d,
  input  [31:0] io_hw2reg_direct_out_d,
  input  [15:0] io_hw2reg_masked_out_lower_data_d,
  input  [15:0] io_hw2reg_masked_out_upper_data_d,
  input  [31:0] io_hw2reg_direct_oe_d,
  input  [15:0] io_hw2reg_masked_oe_lower_data_d,
  input  [15:0] io_hw2reg_masked_oe_upper_data_d
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  intr_state_reg_clock; // @[GpioRegTop.scala 93:30]
  wire  intr_state_reg_reset; // @[GpioRegTop.scala 93:30]
  wire  intr_state_reg_io_we; // @[GpioRegTop.scala 93:30]
  wire [31:0] intr_state_reg_io_wd; // @[GpioRegTop.scala 93:30]
  wire  intr_state_reg_io_de; // @[GpioRegTop.scala 93:30]
  wire [31:0] intr_state_reg_io_d; // @[GpioRegTop.scala 93:30]
  wire [31:0] intr_state_reg_io_q; // @[GpioRegTop.scala 93:30]
  wire [31:0] intr_state_reg_io_qs; // @[GpioRegTop.scala 93:30]
  wire  intr_enable_reg_clock; // @[GpioRegTop.scala 108:31]
  wire  intr_enable_reg_reset; // @[GpioRegTop.scala 108:31]
  wire  intr_enable_reg_io_we; // @[GpioRegTop.scala 108:31]
  wire [31:0] intr_enable_reg_io_wd; // @[GpioRegTop.scala 108:31]
  wire [31:0] intr_enable_reg_io_q; // @[GpioRegTop.scala 108:31]
  wire [31:0] intr_enable_reg_io_qs; // @[GpioRegTop.scala 108:31]
  wire  intr_test_reg_io_we; // @[GpioRegTop.scala 117:29]
  wire [31:0] intr_test_reg_io_wd; // @[GpioRegTop.scala 117:29]
  wire [31:0] intr_test_reg_io_d; // @[GpioRegTop.scala 117:29]
  wire  intr_test_reg_io_qe; // @[GpioRegTop.scala 117:29]
  wire [31:0] intr_test_reg_io_q; // @[GpioRegTop.scala 117:29]
  wire [31:0] intr_test_reg_io_qs; // @[GpioRegTop.scala 117:29]
  wire  data_in_reg_clock; // @[GpioRegTop.scala 126:27]
  wire  data_in_reg_reset; // @[GpioRegTop.scala 126:27]
  wire [31:0] data_in_reg_io_d; // @[GpioRegTop.scala 126:27]
  wire [31:0] data_in_reg_io_qs; // @[GpioRegTop.scala 126:27]
  wire  direct_out_reg_io_we; // @[GpioRegTop.scala 134:30]
  wire [31:0] direct_out_reg_io_wd; // @[GpioRegTop.scala 134:30]
  wire [31:0] direct_out_reg_io_d; // @[GpioRegTop.scala 134:30]
  wire  direct_out_reg_io_qe; // @[GpioRegTop.scala 134:30]
  wire [31:0] direct_out_reg_io_q; // @[GpioRegTop.scala 134:30]
  wire [31:0] direct_out_reg_io_qs; // @[GpioRegTop.scala 134:30]
  wire  masked_out_lower_data_reg_io_we; // @[GpioRegTop.scala 145:41]
  wire [15:0] masked_out_lower_data_reg_io_wd; // @[GpioRegTop.scala 145:41]
  wire [15:0] masked_out_lower_data_reg_io_d; // @[GpioRegTop.scala 145:41]
  wire  masked_out_lower_data_reg_io_qe; // @[GpioRegTop.scala 145:41]
  wire [15:0] masked_out_lower_data_reg_io_q; // @[GpioRegTop.scala 145:41]
  wire [15:0] masked_out_lower_data_reg_io_qs; // @[GpioRegTop.scala 145:41]
  wire  masked_out_lower_mask_reg_io_we; // @[GpioRegTop.scala 156:41]
  wire [15:0] masked_out_lower_mask_reg_io_wd; // @[GpioRegTop.scala 156:41]
  wire [15:0] masked_out_lower_mask_reg_io_d; // @[GpioRegTop.scala 156:41]
  wire  masked_out_lower_mask_reg_io_qe; // @[GpioRegTop.scala 156:41]
  wire [15:0] masked_out_lower_mask_reg_io_q; // @[GpioRegTop.scala 156:41]
  wire [15:0] masked_out_lower_mask_reg_io_qs; // @[GpioRegTop.scala 156:41]
  wire  masked_out_upper_data_reg_io_we; // @[GpioRegTop.scala 166:41]
  wire [15:0] masked_out_upper_data_reg_io_wd; // @[GpioRegTop.scala 166:41]
  wire [15:0] masked_out_upper_data_reg_io_d; // @[GpioRegTop.scala 166:41]
  wire  masked_out_upper_data_reg_io_qe; // @[GpioRegTop.scala 166:41]
  wire [15:0] masked_out_upper_data_reg_io_q; // @[GpioRegTop.scala 166:41]
  wire [15:0] masked_out_upper_data_reg_io_qs; // @[GpioRegTop.scala 166:41]
  wire  masked_out_upper_mask_reg_io_we; // @[GpioRegTop.scala 177:41]
  wire [15:0] masked_out_upper_mask_reg_io_wd; // @[GpioRegTop.scala 177:41]
  wire [15:0] masked_out_upper_mask_reg_io_d; // @[GpioRegTop.scala 177:41]
  wire  masked_out_upper_mask_reg_io_qe; // @[GpioRegTop.scala 177:41]
  wire [15:0] masked_out_upper_mask_reg_io_q; // @[GpioRegTop.scala 177:41]
  wire [15:0] masked_out_upper_mask_reg_io_qs; // @[GpioRegTop.scala 177:41]
  wire  direct_oe_reg_io_we; // @[GpioRegTop.scala 186:29]
  wire [31:0] direct_oe_reg_io_wd; // @[GpioRegTop.scala 186:29]
  wire [31:0] direct_oe_reg_io_d; // @[GpioRegTop.scala 186:29]
  wire  direct_oe_reg_io_qe; // @[GpioRegTop.scala 186:29]
  wire [31:0] direct_oe_reg_io_q; // @[GpioRegTop.scala 186:29]
  wire [31:0] direct_oe_reg_io_qs; // @[GpioRegTop.scala 186:29]
  wire  masked_oe_lower_data_reg_io_we; // @[GpioRegTop.scala 197:40]
  wire [15:0] masked_oe_lower_data_reg_io_wd; // @[GpioRegTop.scala 197:40]
  wire [15:0] masked_oe_lower_data_reg_io_d; // @[GpioRegTop.scala 197:40]
  wire  masked_oe_lower_data_reg_io_qe; // @[GpioRegTop.scala 197:40]
  wire [15:0] masked_oe_lower_data_reg_io_q; // @[GpioRegTop.scala 197:40]
  wire [15:0] masked_oe_lower_data_reg_io_qs; // @[GpioRegTop.scala 197:40]
  wire  masked_oe_lower_mask_reg_io_we; // @[GpioRegTop.scala 208:40]
  wire [15:0] masked_oe_lower_mask_reg_io_wd; // @[GpioRegTop.scala 208:40]
  wire [15:0] masked_oe_lower_mask_reg_io_d; // @[GpioRegTop.scala 208:40]
  wire  masked_oe_lower_mask_reg_io_qe; // @[GpioRegTop.scala 208:40]
  wire [15:0] masked_oe_lower_mask_reg_io_q; // @[GpioRegTop.scala 208:40]
  wire [15:0] masked_oe_lower_mask_reg_io_qs; // @[GpioRegTop.scala 208:40]
  wire  masked_oe_upper_data_reg_io_we; // @[GpioRegTop.scala 219:40]
  wire [15:0] masked_oe_upper_data_reg_io_wd; // @[GpioRegTop.scala 219:40]
  wire [15:0] masked_oe_upper_data_reg_io_d; // @[GpioRegTop.scala 219:40]
  wire  masked_oe_upper_data_reg_io_qe; // @[GpioRegTop.scala 219:40]
  wire [15:0] masked_oe_upper_data_reg_io_q; // @[GpioRegTop.scala 219:40]
  wire [15:0] masked_oe_upper_data_reg_io_qs; // @[GpioRegTop.scala 219:40]
  wire  masked_oe_upper_mask_reg_io_we; // @[GpioRegTop.scala 230:40]
  wire [15:0] masked_oe_upper_mask_reg_io_wd; // @[GpioRegTop.scala 230:40]
  wire [15:0] masked_oe_upper_mask_reg_io_d; // @[GpioRegTop.scala 230:40]
  wire  masked_oe_upper_mask_reg_io_qe; // @[GpioRegTop.scala 230:40]
  wire [15:0] masked_oe_upper_mask_reg_io_q; // @[GpioRegTop.scala 230:40]
  wire [15:0] masked_oe_upper_mask_reg_io_qs; // @[GpioRegTop.scala 230:40]
  wire  intr_ctrl_en_rising_reg_clock; // @[GpioRegTop.scala 240:39]
  wire  intr_ctrl_en_rising_reg_reset; // @[GpioRegTop.scala 240:39]
  wire  intr_ctrl_en_rising_reg_io_we; // @[GpioRegTop.scala 240:39]
  wire [31:0] intr_ctrl_en_rising_reg_io_wd; // @[GpioRegTop.scala 240:39]
  wire [31:0] intr_ctrl_en_rising_reg_io_q; // @[GpioRegTop.scala 240:39]
  wire [31:0] intr_ctrl_en_rising_reg_io_qs; // @[GpioRegTop.scala 240:39]
  wire  intr_ctrl_en_falling_reg_clock; // @[GpioRegTop.scala 249:40]
  wire  intr_ctrl_en_falling_reg_reset; // @[GpioRegTop.scala 249:40]
  wire  intr_ctrl_en_falling_reg_io_we; // @[GpioRegTop.scala 249:40]
  wire [31:0] intr_ctrl_en_falling_reg_io_wd; // @[GpioRegTop.scala 249:40]
  wire [31:0] intr_ctrl_en_falling_reg_io_q; // @[GpioRegTop.scala 249:40]
  wire [31:0] intr_ctrl_en_falling_reg_io_qs; // @[GpioRegTop.scala 249:40]
  wire  intr_ctrl_en_lvlhigh_reg_clock; // @[GpioRegTop.scala 258:40]
  wire  intr_ctrl_en_lvlhigh_reg_reset; // @[GpioRegTop.scala 258:40]
  wire  intr_ctrl_en_lvlhigh_reg_io_we; // @[GpioRegTop.scala 258:40]
  wire [31:0] intr_ctrl_en_lvlhigh_reg_io_wd; // @[GpioRegTop.scala 258:40]
  wire [31:0] intr_ctrl_en_lvlhigh_reg_io_q; // @[GpioRegTop.scala 258:40]
  wire [31:0] intr_ctrl_en_lvlhigh_reg_io_qs; // @[GpioRegTop.scala 258:40]
  wire  intr_ctrl_en_lvllow_reg_clock; // @[GpioRegTop.scala 267:39]
  wire  intr_ctrl_en_lvllow_reg_reset; // @[GpioRegTop.scala 267:39]
  wire  intr_ctrl_en_lvllow_reg_io_we; // @[GpioRegTop.scala 267:39]
  wire [31:0] intr_ctrl_en_lvllow_reg_io_wd; // @[GpioRegTop.scala 267:39]
  wire [31:0] intr_ctrl_en_lvllow_reg_io_q; // @[GpioRegTop.scala 267:39]
  wire [31:0] intr_ctrl_en_lvllow_reg_io_qs; // @[GpioRegTop.scala 267:39]
  wire  _reg_we_T = io_req_ready & io_req_valid; // @[Decoupled.scala 40:37]
  wire  reg_we = _reg_we_T & io_req_bits_isWrite; // @[GpioRegTop.scala 33:16]
  wire  reg_re = _reg_we_T & ~io_req_bits_isWrite; // @[GpioRegTop.scala 34:16]
  reg  io_rsp_valid_REG; // @[GpioRegTop.scala 39:26]
  wire [5:0] reg_addr = io_req_bits_addrRequest[5:0]; // @[GpioRegTop.scala 26:22 GpioRegTop.scala 36:12]
  wire  addr_hit_0 = reg_addr == 6'h0; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_1 = reg_addr == 6'h4; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_2 = reg_addr == 6'h8; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_3 = reg_addr == 6'hc; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_4 = reg_addr == 6'h10; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_5 = reg_addr == 6'h14; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_6 = reg_addr == 6'h18; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_7 = reg_addr == 6'h1c; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_8 = reg_addr == 6'h20; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_9 = reg_addr == 6'h24; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_10 = reg_addr == 6'h28; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_11 = reg_addr == 6'h2c; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_12 = reg_addr == 6'h30; // @[GpioRegTop.scala 277:29]
  wire  addr_hit_13 = reg_addr == 6'h34; // @[GpioRegTop.scala 277:29]
  wire  addr_miss = (reg_re | reg_we) & ~(addr_hit_0 | addr_hit_1 | addr_hit_2 | addr_hit_3 | addr_hit_4 | addr_hit_5 |
    addr_hit_6 | addr_hit_7 | addr_hit_8 | addr_hit_9 | addr_hit_10 | addr_hit_11 | addr_hit_12 | addr_hit_13); // @[GpioRegTop.scala 280:19]
  wire  _T = addr_hit_0 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_3 = addr_hit_0 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_4 = addr_hit_1 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_7 = addr_hit_1 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_8 = addr_hit_2 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_11 = addr_hit_2 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_15 = addr_hit_3 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_16 = addr_hit_4 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_19 = addr_hit_4 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_20 = addr_hit_5 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_23 = addr_hit_5 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_24 = addr_hit_6 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_27 = addr_hit_6 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_28 = addr_hit_7 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_31 = addr_hit_7 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_32 = addr_hit_8 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_35 = addr_hit_8 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_36 = addr_hit_9 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_39 = addr_hit_9 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_40 = addr_hit_10 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_43 = addr_hit_10 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_44 = addr_hit_11 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_47 = addr_hit_11 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_48 = addr_hit_12 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_51 = addr_hit_12 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  _T_52 = addr_hit_13 & reg_we; // @[GpioRegTop.scala 289:8]
  wire  _T_55 = addr_hit_13 & reg_we & 4'hf != io_req_bits_activeByteLane; // @[GpioRegTop.scala 289:18]
  wire  wr_err = _T_3 | (_T_7 | (_T_11 | (_T_15 | (_T_19 | (_T_23 | (_T_27 | (_T_31 | (_T_35 | (_T_39 | (_T_43 | (_T_47
     | (_T_51 | _T_55)))))))))))); // @[Mux.scala 98:16]
  wire  _intr_state_we_T_1 = ~wr_err; // @[GpioRegTop.scala 296:43]
  wire [15:0] masked_out_lower_data_qs = masked_out_lower_data_reg_io_qs; // @[GpioRegTop.scala 61:90 GpioRegTop.scala 152:28]
  wire [31:0] _reg_rdata_next_T = {16'h0,masked_out_lower_data_qs}; // @[Cat.scala 30:58]
  wire [15:0] masked_out_upper_data_qs = masked_out_upper_data_reg_io_qs; // @[GpioRegTop.scala 64:90 GpioRegTop.scala 173:28]
  wire [31:0] _reg_rdata_next_T_1 = {16'h0,masked_out_upper_data_qs}; // @[Cat.scala 30:58]
  wire [15:0] masked_oe_lower_mask_qs = masked_oe_lower_mask_reg_io_qs; // @[GpioRegTop.scala 71:112 GpioRegTop.scala 215:27]
  wire [15:0] masked_oe_lower_data_qs = masked_oe_lower_data_reg_io_qs; // @[GpioRegTop.scala 71:112 GpioRegTop.scala 204:27]
  wire [31:0] _reg_rdata_next_T_2 = {masked_oe_lower_mask_qs,masked_oe_lower_data_qs}; // @[Cat.scala 30:58]
  wire [15:0] masked_oe_upper_mask_qs = masked_oe_upper_mask_reg_io_qs; // @[GpioRegTop.scala 74:112 GpioRegTop.scala 237:27]
  wire [15:0] masked_oe_upper_data_qs = masked_oe_upper_data_reg_io_qs; // @[GpioRegTop.scala 74:112 GpioRegTop.scala 226:27]
  wire [31:0] _reg_rdata_next_T_3 = {masked_oe_upper_mask_qs,masked_oe_upper_data_qs}; // @[Cat.scala 30:58]
  wire [31:0] intr_ctrl_en_lvllow_qs = intr_ctrl_en_lvllow_reg_io_qs; // @[GpioRegTop.scala 86:60 GpioRegTop.scala 273:26]
  wire [31:0] _GEN_0 = addr_hit_13 ? intr_ctrl_en_lvllow_qs : 32'hffffffff; // @[GpioRegTop.scala 382:28 GpioRegTop.scala 383:20 GpioRegTop.scala 385:20]
  wire [31:0] intr_ctrl_en_lvlhigh_qs = intr_ctrl_en_lvlhigh_reg_io_qs; // @[GpioRegTop.scala 83:62 GpioRegTop.scala 264:27]
  wire [31:0] _GEN_1 = addr_hit_12 ? intr_ctrl_en_lvlhigh_qs : _GEN_0; // @[GpioRegTop.scala 380:28 GpioRegTop.scala 381:20]
  wire [31:0] intr_ctrl_en_falling_qs = intr_ctrl_en_falling_reg_io_qs; // @[GpioRegTop.scala 80:62 GpioRegTop.scala 255:27]
  wire [31:0] _GEN_2 = addr_hit_11 ? intr_ctrl_en_falling_qs : _GEN_1; // @[GpioRegTop.scala 378:28 GpioRegTop.scala 379:20]
  wire [31:0] intr_ctrl_en_rising_qs = intr_ctrl_en_rising_reg_io_qs; // @[GpioRegTop.scala 77:60 GpioRegTop.scala 246:26]
  wire [31:0] _GEN_3 = addr_hit_10 ? intr_ctrl_en_rising_qs : _GEN_2; // @[GpioRegTop.scala 376:28 GpioRegTop.scala 377:20]
  wire [31:0] _GEN_4 = addr_hit_9 ? _reg_rdata_next_T_3 : _GEN_3; // @[GpioRegTop.scala 374:27 GpioRegTop.scala 375:20]
  wire [31:0] _GEN_5 = addr_hit_8 ? _reg_rdata_next_T_2 : _GEN_4; // @[GpioRegTop.scala 372:27 GpioRegTop.scala 373:20]
  wire [31:0] direct_oe_qs = direct_oe_reg_io_qs; // @[GpioRegTop.scala 67:26 GpioRegTop.scala 193:16]
  wire [31:0] _GEN_6 = addr_hit_7 ? direct_oe_qs : _GEN_5; // @[GpioRegTop.scala 370:27 GpioRegTop.scala 371:20]
  wire [31:0] _GEN_7 = addr_hit_6 ? _reg_rdata_next_T_1 : _GEN_6; // @[GpioRegTop.scala 368:27 GpioRegTop.scala 369:20]
  wire [31:0] _GEN_8 = addr_hit_5 ? _reg_rdata_next_T : _GEN_7; // @[GpioRegTop.scala 366:27 GpioRegTop.scala 367:20]
  wire [31:0] direct_out_qs = direct_out_reg_io_qs; // @[GpioRegTop.scala 58:42 GpioRegTop.scala 141:17]
  wire [31:0] _GEN_9 = addr_hit_4 ? direct_out_qs : _GEN_8; // @[GpioRegTop.scala 364:27 GpioRegTop.scala 365:20]
  wire [31:0] data_in_qs = data_in_reg_io_qs; // @[GpioRegTop.scala 56:24 GpioRegTop.scala 131:14]
  wire [31:0] _GEN_10 = addr_hit_3 ? data_in_qs : _GEN_9; // @[GpioRegTop.scala 362:27 GpioRegTop.scala 363:20]
  wire [31:0] _GEN_11 = addr_hit_2 ? 32'h0 : _GEN_10; // @[GpioRegTop.scala 360:27 GpioRegTop.scala 361:20]
  wire [31:0] intr_enable_qs = intr_enable_reg_io_qs; // @[GpioRegTop.scala 50:44 GpioRegTop.scala 114:18]
  wire [31:0] _GEN_12 = addr_hit_1 ? intr_enable_qs : _GEN_11; // @[GpioRegTop.scala 358:27 GpioRegTop.scala 359:20]
  wire [31:0] intr_state_qs = intr_state_reg_io_qs; // @[GpioRegTop.scala 47:42 GpioRegTop.scala 105:17]
  SubReg intr_state_reg ( // @[GpioRegTop.scala 93:30]
    .clock(intr_state_reg_clock),
    .reset(intr_state_reg_reset),
    .io_we(intr_state_reg_io_we),
    .io_wd(intr_state_reg_io_wd),
    .io_de(intr_state_reg_io_de),
    .io_d(intr_state_reg_io_d),
    .io_q(intr_state_reg_io_q),
    .io_qs(intr_state_reg_io_qs)
  );
  SubReg_1 intr_enable_reg ( // @[GpioRegTop.scala 108:31]
    .clock(intr_enable_reg_clock),
    .reset(intr_enable_reg_reset),
    .io_we(intr_enable_reg_io_we),
    .io_wd(intr_enable_reg_io_wd),
    .io_q(intr_enable_reg_io_q),
    .io_qs(intr_enable_reg_io_qs)
  );
  SubRegExt intr_test_reg ( // @[GpioRegTop.scala 117:29]
    .io_we(intr_test_reg_io_we),
    .io_wd(intr_test_reg_io_wd),
    .io_d(intr_test_reg_io_d),
    .io_qe(intr_test_reg_io_qe),
    .io_q(intr_test_reg_io_q),
    .io_qs(intr_test_reg_io_qs)
  );
  SubReg_2 data_in_reg ( // @[GpioRegTop.scala 126:27]
    .clock(data_in_reg_clock),
    .reset(data_in_reg_reset),
    .io_d(data_in_reg_io_d),
    .io_qs(data_in_reg_io_qs)
  );
  SubRegExt direct_out_reg ( // @[GpioRegTop.scala 134:30]
    .io_we(direct_out_reg_io_we),
    .io_wd(direct_out_reg_io_wd),
    .io_d(direct_out_reg_io_d),
    .io_qe(direct_out_reg_io_qe),
    .io_q(direct_out_reg_io_q),
    .io_qs(direct_out_reg_io_qs)
  );
  SubRegExt_2 masked_out_lower_data_reg ( // @[GpioRegTop.scala 145:41]
    .io_we(masked_out_lower_data_reg_io_we),
    .io_wd(masked_out_lower_data_reg_io_wd),
    .io_d(masked_out_lower_data_reg_io_d),
    .io_qe(masked_out_lower_data_reg_io_qe),
    .io_q(masked_out_lower_data_reg_io_q),
    .io_qs(masked_out_lower_data_reg_io_qs)
  );
  SubRegExt_2 masked_out_lower_mask_reg ( // @[GpioRegTop.scala 156:41]
    .io_we(masked_out_lower_mask_reg_io_we),
    .io_wd(masked_out_lower_mask_reg_io_wd),
    .io_d(masked_out_lower_mask_reg_io_d),
    .io_qe(masked_out_lower_mask_reg_io_qe),
    .io_q(masked_out_lower_mask_reg_io_q),
    .io_qs(masked_out_lower_mask_reg_io_qs)
  );
  SubRegExt_2 masked_out_upper_data_reg ( // @[GpioRegTop.scala 166:41]
    .io_we(masked_out_upper_data_reg_io_we),
    .io_wd(masked_out_upper_data_reg_io_wd),
    .io_d(masked_out_upper_data_reg_io_d),
    .io_qe(masked_out_upper_data_reg_io_qe),
    .io_q(masked_out_upper_data_reg_io_q),
    .io_qs(masked_out_upper_data_reg_io_qs)
  );
  SubRegExt_2 masked_out_upper_mask_reg ( // @[GpioRegTop.scala 177:41]
    .io_we(masked_out_upper_mask_reg_io_we),
    .io_wd(masked_out_upper_mask_reg_io_wd),
    .io_d(masked_out_upper_mask_reg_io_d),
    .io_qe(masked_out_upper_mask_reg_io_qe),
    .io_q(masked_out_upper_mask_reg_io_q),
    .io_qs(masked_out_upper_mask_reg_io_qs)
  );
  SubRegExt direct_oe_reg ( // @[GpioRegTop.scala 186:29]
    .io_we(direct_oe_reg_io_we),
    .io_wd(direct_oe_reg_io_wd),
    .io_d(direct_oe_reg_io_d),
    .io_qe(direct_oe_reg_io_qe),
    .io_q(direct_oe_reg_io_q),
    .io_qs(direct_oe_reg_io_qs)
  );
  SubRegExt_2 masked_oe_lower_data_reg ( // @[GpioRegTop.scala 197:40]
    .io_we(masked_oe_lower_data_reg_io_we),
    .io_wd(masked_oe_lower_data_reg_io_wd),
    .io_d(masked_oe_lower_data_reg_io_d),
    .io_qe(masked_oe_lower_data_reg_io_qe),
    .io_q(masked_oe_lower_data_reg_io_q),
    .io_qs(masked_oe_lower_data_reg_io_qs)
  );
  SubRegExt_2 masked_oe_lower_mask_reg ( // @[GpioRegTop.scala 208:40]
    .io_we(masked_oe_lower_mask_reg_io_we),
    .io_wd(masked_oe_lower_mask_reg_io_wd),
    .io_d(masked_oe_lower_mask_reg_io_d),
    .io_qe(masked_oe_lower_mask_reg_io_qe),
    .io_q(masked_oe_lower_mask_reg_io_q),
    .io_qs(masked_oe_lower_mask_reg_io_qs)
  );
  SubRegExt_2 masked_oe_upper_data_reg ( // @[GpioRegTop.scala 219:40]
    .io_we(masked_oe_upper_data_reg_io_we),
    .io_wd(masked_oe_upper_data_reg_io_wd),
    .io_d(masked_oe_upper_data_reg_io_d),
    .io_qe(masked_oe_upper_data_reg_io_qe),
    .io_q(masked_oe_upper_data_reg_io_q),
    .io_qs(masked_oe_upper_data_reg_io_qs)
  );
  SubRegExt_2 masked_oe_upper_mask_reg ( // @[GpioRegTop.scala 230:40]
    .io_we(masked_oe_upper_mask_reg_io_we),
    .io_wd(masked_oe_upper_mask_reg_io_wd),
    .io_d(masked_oe_upper_mask_reg_io_d),
    .io_qe(masked_oe_upper_mask_reg_io_qe),
    .io_q(masked_oe_upper_mask_reg_io_q),
    .io_qs(masked_oe_upper_mask_reg_io_qs)
  );
  SubReg_1 intr_ctrl_en_rising_reg ( // @[GpioRegTop.scala 240:39]
    .clock(intr_ctrl_en_rising_reg_clock),
    .reset(intr_ctrl_en_rising_reg_reset),
    .io_we(intr_ctrl_en_rising_reg_io_we),
    .io_wd(intr_ctrl_en_rising_reg_io_wd),
    .io_q(intr_ctrl_en_rising_reg_io_q),
    .io_qs(intr_ctrl_en_rising_reg_io_qs)
  );
  SubReg_1 intr_ctrl_en_falling_reg ( // @[GpioRegTop.scala 249:40]
    .clock(intr_ctrl_en_falling_reg_clock),
    .reset(intr_ctrl_en_falling_reg_reset),
    .io_we(intr_ctrl_en_falling_reg_io_we),
    .io_wd(intr_ctrl_en_falling_reg_io_wd),
    .io_q(intr_ctrl_en_falling_reg_io_q),
    .io_qs(intr_ctrl_en_falling_reg_io_qs)
  );
  SubReg_1 intr_ctrl_en_lvlhigh_reg ( // @[GpioRegTop.scala 258:40]
    .clock(intr_ctrl_en_lvlhigh_reg_clock),
    .reset(intr_ctrl_en_lvlhigh_reg_reset),
    .io_we(intr_ctrl_en_lvlhigh_reg_io_we),
    .io_wd(intr_ctrl_en_lvlhigh_reg_io_wd),
    .io_q(intr_ctrl_en_lvlhigh_reg_io_q),
    .io_qs(intr_ctrl_en_lvlhigh_reg_io_qs)
  );
  SubReg_1 intr_ctrl_en_lvllow_reg ( // @[GpioRegTop.scala 267:39]
    .clock(intr_ctrl_en_lvllow_reg_clock),
    .reset(intr_ctrl_en_lvllow_reg_reset),
    .io_we(intr_ctrl_en_lvllow_reg_io_we),
    .io_wd(intr_ctrl_en_lvllow_reg_io_wd),
    .io_q(intr_ctrl_en_lvllow_reg_io_q),
    .io_qs(intr_ctrl_en_lvllow_reg_io_qs)
  );
  assign io_req_ready = 1'h1; // @[GpioRegTop.scala 18:16]
  assign io_rsp_valid = io_rsp_valid_REG; // @[GpioRegTop.scala 39:16]
  assign io_rsp_bits_dataResponse = addr_hit_0 ? intr_state_qs : _GEN_12; // @[GpioRegTop.scala 356:21 GpioRegTop.scala 357:20]
  assign io_rsp_bits_error = addr_miss | wr_err; // @[GpioRegTop.scala 44:26]
  assign io_reg2hw_intr_state_q = intr_state_reg_io_q; // @[GpioRegTop.scala 103:26]
  assign io_reg2hw_intr_enable_q = intr_enable_reg_io_q; // @[GpioRegTop.scala 113:27]
  assign io_reg2hw_intr_test_q = intr_test_reg_io_q; // @[GpioRegTop.scala 123:25]
  assign io_reg2hw_intr_test_qe = intr_test_reg_io_qe; // @[GpioRegTop.scala 122:26]
  assign io_reg2hw_direct_out_q = direct_out_reg_io_q; // @[GpioRegTop.scala 140:26]
  assign io_reg2hw_direct_out_qe = direct_out_reg_io_qe; // @[GpioRegTop.scala 139:27]
  assign io_reg2hw_masked_out_lower_data_q = masked_out_lower_data_reg_io_q; // @[GpioRegTop.scala 151:37]
  assign io_reg2hw_masked_out_lower_data_qe = masked_out_lower_data_reg_io_qe; // @[GpioRegTop.scala 150:38]
  assign io_reg2hw_masked_out_lower_mask_q = masked_out_lower_mask_reg_io_q; // @[GpioRegTop.scala 162:37]
  assign io_reg2hw_masked_out_upper_data_q = masked_out_upper_data_reg_io_q; // @[GpioRegTop.scala 172:37]
  assign io_reg2hw_masked_out_upper_data_qe = masked_out_upper_data_reg_io_qe; // @[GpioRegTop.scala 171:38]
  assign io_reg2hw_masked_out_upper_mask_q = masked_out_upper_mask_reg_io_q; // @[GpioRegTop.scala 183:37]
  assign io_reg2hw_direct_oe_q = direct_oe_reg_io_q; // @[GpioRegTop.scala 192:25]
  assign io_reg2hw_direct_oe_qe = direct_oe_reg_io_qe; // @[GpioRegTop.scala 191:26]
  assign io_reg2hw_masked_oe_lower_data_q = masked_oe_lower_data_reg_io_q; // @[GpioRegTop.scala 203:36]
  assign io_reg2hw_masked_oe_lower_data_qe = masked_oe_lower_data_reg_io_qe; // @[GpioRegTop.scala 202:37]
  assign io_reg2hw_masked_oe_lower_mask_q = masked_oe_lower_mask_reg_io_q; // @[GpioRegTop.scala 214:36]
  assign io_reg2hw_masked_oe_upper_data_q = masked_oe_upper_data_reg_io_q; // @[GpioRegTop.scala 225:36]
  assign io_reg2hw_masked_oe_upper_data_qe = masked_oe_upper_data_reg_io_qe; // @[GpioRegTop.scala 224:37]
  assign io_reg2hw_masked_oe_upper_mask_q = masked_oe_upper_mask_reg_io_q; // @[GpioRegTop.scala 236:36]
  assign io_reg2hw_intr_ctrl_en_rising_q = intr_ctrl_en_rising_reg_io_q; // @[GpioRegTop.scala 245:35]
  assign io_reg2hw_intr_ctrl_en_falling_q = intr_ctrl_en_falling_reg_io_q; // @[GpioRegTop.scala 254:36]
  assign io_reg2hw_intr_ctrl_en_lvlHigh_q = intr_ctrl_en_lvlhigh_reg_io_q; // @[GpioRegTop.scala 263:36]
  assign io_reg2hw_intr_ctrl_en_lvlLow_q = intr_ctrl_en_lvllow_reg_io_q; // @[GpioRegTop.scala 272:35]
  assign intr_state_reg_clock = clock;
  assign intr_state_reg_reset = reset;
  assign intr_state_reg_io_we = _T & ~wr_err; // @[GpioRegTop.scala 296:41]
  assign intr_state_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_state_reg_io_de = io_hw2reg_intr_state_de; // @[GpioRegTop.scala 99:24]
  assign intr_state_reg_io_d = io_hw2reg_intr_state_d; // @[GpioRegTop.scala 101:23]
  assign intr_enable_reg_clock = clock;
  assign intr_enable_reg_reset = reset;
  assign intr_enable_reg_io_we = _T_4 & _intr_state_we_T_1; // @[GpioRegTop.scala 299:42]
  assign intr_enable_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_test_reg_io_we = _T_8 & _intr_state_we_T_1; // @[GpioRegTop.scala 302:40]
  assign intr_test_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_test_reg_io_d = 32'h0; // @[GpioRegTop.scala 121:22]
  assign data_in_reg_clock = clock;
  assign data_in_reg_reset = reset;
  assign data_in_reg_io_d = io_hw2reg_data_in_d; // @[GpioRegTop.scala 130:20]
  assign direct_out_reg_io_we = _T_16 & _intr_state_we_T_1; // @[GpioRegTop.scala 305:41]
  assign direct_out_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign direct_out_reg_io_d = io_hw2reg_direct_out_d; // @[GpioRegTop.scala 138:23]
  assign masked_out_lower_data_reg_io_we = _T_20 & _intr_state_we_T_1; // @[GpioRegTop.scala 309:52]
  assign masked_out_lower_data_reg_io_wd = io_req_bits_dataRequest[15:0]; // @[GpioRegTop.scala 310:40]
  assign masked_out_lower_data_reg_io_d = io_hw2reg_masked_out_lower_data_d; // @[GpioRegTop.scala 149:34]
  assign masked_out_lower_mask_reg_io_we = _T_20 & _intr_state_we_T_1; // @[GpioRegTop.scala 313:52]
  assign masked_out_lower_mask_reg_io_wd = io_req_bits_dataRequest[31:16]; // @[GpioRegTop.scala 314:40]
  assign masked_out_lower_mask_reg_io_d = 16'h0; // @[GpioRegTop.scala 160:34]
  assign masked_out_upper_data_reg_io_we = _T_24 & _intr_state_we_T_1; // @[GpioRegTop.scala 316:52]
  assign masked_out_upper_data_reg_io_wd = io_req_bits_dataRequest[15:0]; // @[GpioRegTop.scala 317:40]
  assign masked_out_upper_data_reg_io_d = io_hw2reg_masked_out_upper_data_d; // @[GpioRegTop.scala 170:34]
  assign masked_out_upper_mask_reg_io_we = _T_24 & _intr_state_we_T_1; // @[GpioRegTop.scala 320:52]
  assign masked_out_upper_mask_reg_io_wd = io_req_bits_dataRequest[31:16]; // @[GpioRegTop.scala 321:40]
  assign masked_out_upper_mask_reg_io_d = 16'h0; // @[GpioRegTop.scala 181:34]
  assign direct_oe_reg_io_we = _T_28 & _intr_state_we_T_1; // @[GpioRegTop.scala 323:40]
  assign direct_oe_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign direct_oe_reg_io_d = io_hw2reg_direct_oe_d; // @[GpioRegTop.scala 190:22]
  assign masked_oe_lower_data_reg_io_we = _T_32 & _intr_state_we_T_1; // @[GpioRegTop.scala 327:51]
  assign masked_oe_lower_data_reg_io_wd = io_req_bits_dataRequest[15:0]; // @[GpioRegTop.scala 328:39]
  assign masked_oe_lower_data_reg_io_d = io_hw2reg_masked_oe_lower_data_d; // @[GpioRegTop.scala 201:33]
  assign masked_oe_lower_mask_reg_io_we = _T_32 & _intr_state_we_T_1; // @[GpioRegTop.scala 331:51]
  assign masked_oe_lower_mask_reg_io_wd = io_req_bits_dataRequest[31:16]; // @[GpioRegTop.scala 332:39]
  assign masked_oe_lower_mask_reg_io_d = 16'h0; // @[GpioRegTop.scala 212:33]
  assign masked_oe_upper_data_reg_io_we = _T_36 & _intr_state_we_T_1; // @[GpioRegTop.scala 335:51]
  assign masked_oe_upper_data_reg_io_wd = io_req_bits_dataRequest[15:0]; // @[GpioRegTop.scala 336:39]
  assign masked_oe_upper_data_reg_io_d = io_hw2reg_masked_oe_upper_data_d; // @[GpioRegTop.scala 223:33]
  assign masked_oe_upper_mask_reg_io_we = _T_36 & _intr_state_we_T_1; // @[GpioRegTop.scala 339:51]
  assign masked_oe_upper_mask_reg_io_wd = io_req_bits_dataRequest[31:16]; // @[GpioRegTop.scala 340:39]
  assign masked_oe_upper_mask_reg_io_d = 16'h0; // @[GpioRegTop.scala 234:33]
  assign intr_ctrl_en_rising_reg_clock = clock;
  assign intr_ctrl_en_rising_reg_reset = reset;
  assign intr_ctrl_en_rising_reg_io_we = _T_40 & _intr_state_we_T_1; // @[GpioRegTop.scala 343:51]
  assign intr_ctrl_en_rising_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_ctrl_en_falling_reg_clock = clock;
  assign intr_ctrl_en_falling_reg_reset = reset;
  assign intr_ctrl_en_falling_reg_io_we = _T_44 & _intr_state_we_T_1; // @[GpioRegTop.scala 346:52]
  assign intr_ctrl_en_falling_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_ctrl_en_lvlhigh_reg_clock = clock;
  assign intr_ctrl_en_lvlhigh_reg_reset = reset;
  assign intr_ctrl_en_lvlhigh_reg_io_we = _T_48 & _intr_state_we_T_1; // @[GpioRegTop.scala 349:52]
  assign intr_ctrl_en_lvlhigh_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  assign intr_ctrl_en_lvllow_reg_clock = clock;
  assign intr_ctrl_en_lvllow_reg_reset = reset;
  assign intr_ctrl_en_lvllow_reg_io_we = _T_52 & _intr_state_we_T_1; // @[GpioRegTop.scala 352:51]
  assign intr_ctrl_en_lvllow_reg_io_wd = io_req_bits_dataRequest; // @[GpioRegTop.scala 25:34 GpioRegTop.scala 35:13]
  always @(posedge clock) begin
    io_rsp_valid_REG <= reg_we | reg_re; // @[GpioRegTop.scala 39:38]
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
  io_rsp_valid_REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IntrHardware(
  input         clock,
  input         reset,
  input  [31:0] io_event_intr_i,
  input  [31:0] io_reg2hw_intr_enable_q_i,
  input  [31:0] io_reg2hw_intr_test_q_i,
  input         io_reg2hw_intr_test_qe_i,
  input  [31:0] io_reg2hw_intr_state_q_i,
  output        io_hw2reg_intr_state_de_o,
  output [31:0] io_hw2reg_intr_state_d_o,
  output [31:0] io_intr_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] _new_event_T_1 = io_reg2hw_intr_test_qe_i ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _new_event_T_2 = _new_event_T_1 & io_reg2hw_intr_test_q_i; // @[IntrHardware.scala 26:54]
  wire [31:0] new_event = _new_event_T_2 | io_event_intr_i; // @[IntrHardware.scala 26:80]
  reg [31:0] reg_; // @[IntrHardware.scala 31:22]
  wire [31:0] _reg_T = io_reg2hw_intr_state_q_i & io_reg2hw_intr_enable_q_i; // @[IntrHardware.scala 32:37]
  assign io_hw2reg_intr_state_de_o = |new_event; // @[IntrHardware.scala 27:45]
  assign io_hw2reg_intr_state_d_o = new_event | io_reg2hw_intr_state_q_i; // @[IntrHardware.scala 28:41]
  assign io_intr_o = reg_; // @[IntrHardware.scala 33:15]
  always @(posedge clock) begin
    if (reset) begin // @[IntrHardware.scala 31:22]
      reg_ <= 32'h0; // @[IntrHardware.scala 31:22]
    end else begin
      reg_ <= _reg_T; // @[IntrHardware.scala 32:9]
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
  reg_ = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Gpio(
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
  input  [31:0] io_cio_gpio_i,
  output [31:0] io_cio_gpio_o,
  output [31:0] io_cio_gpio_en_o,
  output [31:0] io_intr_gpio_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  gpioRegTop_clock; // @[Gpio.scala 23:26]
  wire  gpioRegTop_reset; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_req_ready; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_req_valid; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_req_bits_addrRequest; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_req_bits_dataRequest; // @[Gpio.scala 23:26]
  wire [3:0] gpioRegTop_io_req_bits_activeByteLane; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_req_bits_isWrite; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_rsp_valid; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_rsp_bits_dataResponse; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_rsp_bits_error; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_state_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_enable_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_test_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_intr_test_qe; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_direct_out_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_direct_out_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_out_lower_data_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_masked_out_lower_data_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_out_lower_mask_q; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_out_upper_data_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_masked_out_upper_data_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_out_upper_mask_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_direct_oe_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_direct_oe_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_oe_lower_data_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_masked_oe_lower_data_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_oe_lower_mask_q; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_oe_upper_data_q; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_reg2hw_masked_oe_upper_data_qe; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_reg2hw_masked_oe_upper_mask_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_ctrl_en_rising_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_ctrl_en_falling_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_ctrl_en_lvlHigh_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_reg2hw_intr_ctrl_en_lvlLow_q; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_hw2reg_intr_state_d; // @[Gpio.scala 23:26]
  wire  gpioRegTop_io_hw2reg_intr_state_de; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_hw2reg_data_in_d; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_hw2reg_direct_out_d; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_hw2reg_masked_out_lower_data_d; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_hw2reg_masked_out_upper_data_d; // @[Gpio.scala 23:26]
  wire [31:0] gpioRegTop_io_hw2reg_direct_oe_d; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_hw2reg_masked_oe_lower_data_d; // @[Gpio.scala 23:26]
  wire [15:0] gpioRegTop_io_hw2reg_masked_oe_upper_data_d; // @[Gpio.scala 23:26]
  wire  intr_hw_clock; // @[Gpio.scala 115:23]
  wire  intr_hw_reset; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_event_intr_i; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_reg2hw_intr_enable_q_i; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_reg2hw_intr_test_q_i; // @[Gpio.scala 115:23]
  wire  intr_hw_io_reg2hw_intr_test_qe_i; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_reg2hw_intr_state_q_i; // @[Gpio.scala 115:23]
  wire  intr_hw_io_hw2reg_intr_state_de_o; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_hw2reg_intr_state_d_o; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_intr_o; // @[Gpio.scala 115:23]
  reg [31:0] cio_gpio_q; // @[Gpio.scala 31:27]
  reg [31:0] cio_gpio_en_q; // @[Gpio.scala 32:30]
  reg [31:0] data_in_q; // @[Gpio.scala 33:26]
  wire [15:0] hw2reg_masked_out_upper_data_d = cio_gpio_q[31:16]; // @[Gpio.scala 48:47]
  wire [15:0] hw2reg_masked_out_lower_data_d = cio_gpio_q[15:0]; // @[Gpio.scala 50:47]
  wire [15:0] reg2hw_masked_out_upper_data_q = gpioRegTop_io_reg2hw_masked_out_upper_data_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] reg2hw_masked_out_upper_mask_q = gpioRegTop_io_reg2hw_masked_out_upper_mask_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] _cio_gpio_q_T = reg2hw_masked_out_upper_data_q & reg2hw_masked_out_upper_mask_q; // @[Gpio.scala 57:39]
  wire [15:0] _cio_gpio_q_T_1 = ~reg2hw_masked_out_upper_mask_q; // @[Gpio.scala 58:10]
  wire [15:0] _cio_gpio_q_T_3 = _cio_gpio_q_T_1 & hw2reg_masked_out_upper_data_d; // @[Gpio.scala 58:42]
  wire [15:0] cio_gpio_q_hi = _cio_gpio_q_T | _cio_gpio_q_T_3; // @[Gpio.scala 57:73]
  wire [31:0] _cio_gpio_q_T_4 = {cio_gpio_q_hi,16'h0}; // @[Cat.scala 30:58]
  wire [15:0] reg2hw_masked_out_lower_data_q = gpioRegTop_io_reg2hw_masked_out_lower_data_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] reg2hw_masked_out_lower_mask_q = gpioRegTop_io_reg2hw_masked_out_lower_mask_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] _cio_gpio_q_T_5 = reg2hw_masked_out_lower_data_q & reg2hw_masked_out_lower_mask_q; // @[Gpio.scala 67:66]
  wire [15:0] _cio_gpio_q_T_6 = ~reg2hw_masked_out_lower_mask_q; // @[Gpio.scala 68:8]
  wire [15:0] _cio_gpio_q_T_8 = _cio_gpio_q_T_6 & hw2reg_masked_out_lower_data_d; // @[Gpio.scala 68:40]
  wire [15:0] cio_gpio_q_lo = _cio_gpio_q_T_5 | _cio_gpio_q_T_8; // @[Gpio.scala 67:100]
  wire [31:0] _cio_gpio_q_T_9 = {16'h0,cio_gpio_q_lo}; // @[Cat.scala 30:58]
  wire  reg2hw_masked_out_lower_data_qe = gpioRegTop_io_reg2hw_masked_out_lower_data_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire  reg2hw_masked_out_upper_data_qe = gpioRegTop_io_reg2hw_masked_out_upper_data_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire  reg2hw_direct_out_qe = gpioRegTop_io_reg2hw_direct_out_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] reg2hw_direct_out_q = gpioRegTop_io_reg2hw_direct_out_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] hw2reg_masked_oe_upper_data_d = cio_gpio_en_q[31:16]; // @[Gpio.scala 73:49]
  wire [15:0] hw2reg_masked_oe_lower_data_d = cio_gpio_en_q[15:0]; // @[Gpio.scala 75:49]
  wire [15:0] reg2hw_masked_oe_upper_data_q = gpioRegTop_io_reg2hw_masked_oe_upper_data_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] reg2hw_masked_oe_upper_mask_q = gpioRegTop_io_reg2hw_masked_oe_upper_mask_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] _cio_gpio_en_q_T = reg2hw_masked_oe_upper_data_q & reg2hw_masked_oe_upper_mask_q; // @[Gpio.scala 81:57]
  wire [15:0] _cio_gpio_en_q_T_1 = ~reg2hw_masked_oe_upper_mask_q; // @[Gpio.scala 82:8]
  wire [15:0] _cio_gpio_en_q_T_3 = _cio_gpio_en_q_T_1 & hw2reg_masked_oe_upper_data_d; // @[Gpio.scala 82:39]
  wire [15:0] cio_gpio_en_q_hi = _cio_gpio_en_q_T | _cio_gpio_en_q_T_3; // @[Gpio.scala 81:90]
  wire [31:0] _cio_gpio_en_q_T_4 = {cio_gpio_en_q_hi,16'h0}; // @[Cat.scala 30:58]
  wire [15:0] reg2hw_masked_oe_lower_data_q = gpioRegTop_io_reg2hw_masked_oe_lower_data_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] reg2hw_masked_oe_lower_mask_q = gpioRegTop_io_reg2hw_masked_oe_lower_mask_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [15:0] _cio_gpio_en_q_T_5 = reg2hw_masked_oe_lower_data_q & reg2hw_masked_oe_lower_mask_q; // @[Gpio.scala 84:68]
  wire [15:0] _cio_gpio_en_q_T_6 = ~reg2hw_masked_oe_lower_mask_q; // @[Gpio.scala 85:8]
  wire [15:0] _cio_gpio_en_q_T_8 = _cio_gpio_en_q_T_6 & hw2reg_masked_oe_lower_data_d; // @[Gpio.scala 85:39]
  wire [15:0] cio_gpio_en_q_lo = _cio_gpio_en_q_T_5 | _cio_gpio_en_q_T_8; // @[Gpio.scala 84:101]
  wire [31:0] _cio_gpio_en_q_T_9 = {16'h0,cio_gpio_en_q_lo}; // @[Cat.scala 30:58]
  wire  reg2hw_masked_oe_lower_data_qe = gpioRegTop_io_reg2hw_masked_oe_lower_data_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire  reg2hw_masked_oe_upper_data_qe = gpioRegTop_io_reg2hw_masked_oe_upper_data_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire  reg2hw_direct_oe_qe = gpioRegTop_io_reg2hw_direct_oe_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] reg2hw_direct_oe_q = gpioRegTop_io_reg2hw_direct_oe_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] _event_intr_rise_T = ~data_in_q; // @[Gpio.scala 95:23]
  wire [31:0] _event_intr_rise_T_1 = _event_intr_rise_T & io_cio_gpio_i; // @[Gpio.scala 95:34]
  wire [31:0] reg2hw_intr_ctrl_en_rising_q = gpioRegTop_io_reg2hw_intr_ctrl_en_rising_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] event_intr_rise = _event_intr_rise_T_1 & reg2hw_intr_ctrl_en_rising_q; // @[Gpio.scala 95:47]
  wire [31:0] _event_intr_fall_T = ~io_cio_gpio_i; // @[Gpio.scala 99:35]
  wire [31:0] _event_intr_fall_T_1 = data_in_q & _event_intr_fall_T; // @[Gpio.scala 99:33]
  wire [31:0] reg2hw_intr_ctrl_en_falling_q = gpioRegTop_io_reg2hw_intr_ctrl_en_falling_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] event_intr_fall = _event_intr_fall_T_1 & reg2hw_intr_ctrl_en_falling_q; // @[Gpio.scala 99:47]
  wire [31:0] reg2hw_intr_ctrl_en_lvlHigh_q = gpioRegTop_io_reg2hw_intr_ctrl_en_lvlHigh_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] event_intr_acthigh = io_cio_gpio_i & reg2hw_intr_ctrl_en_lvlHigh_q; // @[Gpio.scala 105:35]
  wire [31:0] reg2hw_intr_ctrl_en_lvlLow_q = gpioRegTop_io_reg2hw_intr_ctrl_en_lvlLow_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  wire [31:0] event_intr_actlow = _event_intr_fall_T & reg2hw_intr_ctrl_en_lvlLow_q; // @[Gpio.scala 111:35]
  wire [31:0] _event_intr_combined_T = event_intr_rise | event_intr_fall; // @[Gpio.scala 113:42]
  wire [31:0] _event_intr_combined_T_1 = _event_intr_combined_T | event_intr_acthigh; // @[Gpio.scala 113:60]
  GpioRegTop gpioRegTop ( // @[Gpio.scala 23:26]
    .clock(gpioRegTop_clock),
    .reset(gpioRegTop_reset),
    .io_req_ready(gpioRegTop_io_req_ready),
    .io_req_valid(gpioRegTop_io_req_valid),
    .io_req_bits_addrRequest(gpioRegTop_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(gpioRegTop_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(gpioRegTop_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(gpioRegTop_io_req_bits_isWrite),
    .io_rsp_valid(gpioRegTop_io_rsp_valid),
    .io_rsp_bits_dataResponse(gpioRegTop_io_rsp_bits_dataResponse),
    .io_rsp_bits_error(gpioRegTop_io_rsp_bits_error),
    .io_reg2hw_intr_state_q(gpioRegTop_io_reg2hw_intr_state_q),
    .io_reg2hw_intr_enable_q(gpioRegTop_io_reg2hw_intr_enable_q),
    .io_reg2hw_intr_test_q(gpioRegTop_io_reg2hw_intr_test_q),
    .io_reg2hw_intr_test_qe(gpioRegTop_io_reg2hw_intr_test_qe),
    .io_reg2hw_direct_out_q(gpioRegTop_io_reg2hw_direct_out_q),
    .io_reg2hw_direct_out_qe(gpioRegTop_io_reg2hw_direct_out_qe),
    .io_reg2hw_masked_out_lower_data_q(gpioRegTop_io_reg2hw_masked_out_lower_data_q),
    .io_reg2hw_masked_out_lower_data_qe(gpioRegTop_io_reg2hw_masked_out_lower_data_qe),
    .io_reg2hw_masked_out_lower_mask_q(gpioRegTop_io_reg2hw_masked_out_lower_mask_q),
    .io_reg2hw_masked_out_upper_data_q(gpioRegTop_io_reg2hw_masked_out_upper_data_q),
    .io_reg2hw_masked_out_upper_data_qe(gpioRegTop_io_reg2hw_masked_out_upper_data_qe),
    .io_reg2hw_masked_out_upper_mask_q(gpioRegTop_io_reg2hw_masked_out_upper_mask_q),
    .io_reg2hw_direct_oe_q(gpioRegTop_io_reg2hw_direct_oe_q),
    .io_reg2hw_direct_oe_qe(gpioRegTop_io_reg2hw_direct_oe_qe),
    .io_reg2hw_masked_oe_lower_data_q(gpioRegTop_io_reg2hw_masked_oe_lower_data_q),
    .io_reg2hw_masked_oe_lower_data_qe(gpioRegTop_io_reg2hw_masked_oe_lower_data_qe),
    .io_reg2hw_masked_oe_lower_mask_q(gpioRegTop_io_reg2hw_masked_oe_lower_mask_q),
    .io_reg2hw_masked_oe_upper_data_q(gpioRegTop_io_reg2hw_masked_oe_upper_data_q),
    .io_reg2hw_masked_oe_upper_data_qe(gpioRegTop_io_reg2hw_masked_oe_upper_data_qe),
    .io_reg2hw_masked_oe_upper_mask_q(gpioRegTop_io_reg2hw_masked_oe_upper_mask_q),
    .io_reg2hw_intr_ctrl_en_rising_q(gpioRegTop_io_reg2hw_intr_ctrl_en_rising_q),
    .io_reg2hw_intr_ctrl_en_falling_q(gpioRegTop_io_reg2hw_intr_ctrl_en_falling_q),
    .io_reg2hw_intr_ctrl_en_lvlHigh_q(gpioRegTop_io_reg2hw_intr_ctrl_en_lvlHigh_q),
    .io_reg2hw_intr_ctrl_en_lvlLow_q(gpioRegTop_io_reg2hw_intr_ctrl_en_lvlLow_q),
    .io_hw2reg_intr_state_d(gpioRegTop_io_hw2reg_intr_state_d),
    .io_hw2reg_intr_state_de(gpioRegTop_io_hw2reg_intr_state_de),
    .io_hw2reg_data_in_d(gpioRegTop_io_hw2reg_data_in_d),
    .io_hw2reg_direct_out_d(gpioRegTop_io_hw2reg_direct_out_d),
    .io_hw2reg_masked_out_lower_data_d(gpioRegTop_io_hw2reg_masked_out_lower_data_d),
    .io_hw2reg_masked_out_upper_data_d(gpioRegTop_io_hw2reg_masked_out_upper_data_d),
    .io_hw2reg_direct_oe_d(gpioRegTop_io_hw2reg_direct_oe_d),
    .io_hw2reg_masked_oe_lower_data_d(gpioRegTop_io_hw2reg_masked_oe_lower_data_d),
    .io_hw2reg_masked_oe_upper_data_d(gpioRegTop_io_hw2reg_masked_oe_upper_data_d)
  );
  IntrHardware intr_hw ( // @[Gpio.scala 115:23]
    .clock(intr_hw_clock),
    .reset(intr_hw_reset),
    .io_event_intr_i(intr_hw_io_event_intr_i),
    .io_reg2hw_intr_enable_q_i(intr_hw_io_reg2hw_intr_enable_q_i),
    .io_reg2hw_intr_test_q_i(intr_hw_io_reg2hw_intr_test_q_i),
    .io_reg2hw_intr_test_qe_i(intr_hw_io_reg2hw_intr_test_qe_i),
    .io_reg2hw_intr_state_q_i(intr_hw_io_reg2hw_intr_state_q_i),
    .io_hw2reg_intr_state_de_o(intr_hw_io_hw2reg_intr_state_de_o),
    .io_hw2reg_intr_state_d_o(intr_hw_io_hw2reg_intr_state_d_o),
    .io_intr_o(intr_hw_io_intr_o)
  );
  assign io_rsp_valid = gpioRegTop_io_rsp_valid; // @[Gpio.scala 26:10]
  assign io_rsp_bits_dataResponse = gpioRegTop_io_rsp_bits_dataResponse; // @[Gpio.scala 26:10]
  assign io_rsp_bits_error = gpioRegTop_io_rsp_bits_error; // @[Gpio.scala 26:10]
  assign io_cio_gpio_o = cio_gpio_q; // @[Gpio.scala 44:17]
  assign io_cio_gpio_en_o = cio_gpio_en_q; // @[Gpio.scala 45:20]
  assign io_intr_gpio_o = intr_hw_io_intr_o; // @[Gpio.scala 123:18]
  assign gpioRegTop_clock = clock;
  assign gpioRegTop_reset = reset;
  assign gpioRegTop_io_req_valid = io_req_valid; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_req_bits_addrRequest = io_req_bits_addrRequest; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_req_bits_dataRequest = io_req_bits_dataRequest; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_req_bits_activeByteLane = io_req_bits_activeByteLane; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_req_bits_isWrite = io_req_bits_isWrite; // @[Gpio.scala 25:21]
  assign gpioRegTop_io_hw2reg_intr_state_d = intr_hw_io_hw2reg_intr_state_d_o; // @[Gpio.scala 21:20 Gpio.scala 122:23]
  assign gpioRegTop_io_hw2reg_intr_state_de = intr_hw_io_hw2reg_intr_state_de_o; // @[Gpio.scala 21:20 Gpio.scala 121:24]
  assign gpioRegTop_io_hw2reg_data_in_d = io_cio_gpio_i; // @[Gpio.scala 35:23 Gpio.scala 36:13]
  assign gpioRegTop_io_hw2reg_direct_out_d = cio_gpio_q; // @[Gpio.scala 21:20 Gpio.scala 47:23]
  assign gpioRegTop_io_hw2reg_masked_out_lower_data_d = cio_gpio_q[15:0]; // @[Gpio.scala 50:47]
  assign gpioRegTop_io_hw2reg_masked_out_upper_data_d = cio_gpio_q[31:16]; // @[Gpio.scala 48:47]
  assign gpioRegTop_io_hw2reg_direct_oe_d = cio_gpio_en_q; // @[Gpio.scala 21:20 Gpio.scala 72:22]
  assign gpioRegTop_io_hw2reg_masked_oe_lower_data_d = cio_gpio_en_q[15:0]; // @[Gpio.scala 75:49]
  assign gpioRegTop_io_hw2reg_masked_oe_upper_data_d = cio_gpio_en_q[31:16]; // @[Gpio.scala 73:49]
  assign intr_hw_clock = clock;
  assign intr_hw_reset = reset;
  assign intr_hw_io_event_intr_i = _event_intr_combined_T_1 | event_intr_actlow; // @[Gpio.scala 113:81]
  assign intr_hw_io_reg2hw_intr_enable_q_i = gpioRegTop_io_reg2hw_intr_enable_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  assign intr_hw_io_reg2hw_intr_test_q_i = gpioRegTop_io_reg2hw_intr_test_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  assign intr_hw_io_reg2hw_intr_test_qe_i = gpioRegTop_io_reg2hw_intr_test_qe; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  assign intr_hw_io_reg2hw_intr_state_q_i = gpioRegTop_io_reg2hw_intr_state_q; // @[Gpio.scala 20:20 Gpio.scala 28:10]
  always @(posedge clock) begin
    if (reset) begin // @[Gpio.scala 31:27]
      cio_gpio_q <= 32'h0; // @[Gpio.scala 31:27]
    end else if (reg2hw_direct_out_qe) begin // @[Gpio.scala 53:30]
      cio_gpio_q <= reg2hw_direct_out_q; // @[Gpio.scala 54:16]
    end else if (reg2hw_masked_out_upper_data_qe) begin // @[Gpio.scala 55:48]
      cio_gpio_q <= _cio_gpio_q_T_4; // @[Gpio.scala 56:16]
    end else if (reg2hw_masked_out_lower_data_qe) begin // @[Gpio.scala 66:48]
      cio_gpio_q <= _cio_gpio_q_T_9; // @[Gpio.scala 67:16]
    end
    if (reset) begin // @[Gpio.scala 32:30]
      cio_gpio_en_q <= 32'h0; // @[Gpio.scala 32:30]
    end else if (reg2hw_direct_oe_qe) begin // @[Gpio.scala 78:29]
      cio_gpio_en_q <= reg2hw_direct_oe_q; // @[Gpio.scala 79:19]
    end else if (reg2hw_masked_oe_upper_data_qe) begin // @[Gpio.scala 80:47]
      cio_gpio_en_q <= _cio_gpio_en_q_T_4; // @[Gpio.scala 81:19]
    end else if (reg2hw_masked_oe_lower_data_qe) begin // @[Gpio.scala 83:47]
      cio_gpio_en_q <= _cio_gpio_en_q_T_9; // @[Gpio.scala 84:19]
    end
    if (reset) begin // @[Gpio.scala 33:26]
      data_in_q <= 32'h0; // @[Gpio.scala 33:26]
    end else begin
      data_in_q <= io_cio_gpio_i; // @[Gpio.scala 37:13]
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
  cio_gpio_q = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  cio_gpio_en_q = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  data_in_q = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Harness(
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
  input  [31:0] io_gpio_i,
  output [31:0] io_gpio_o,
  output [31:0] io_gpio_en_o,
  output [31:0] io_gpio_intr_o
);
  wire  hostAdapter_clock; // @[Harness.scala 20:27]
  wire  hostAdapter_reset; // @[Harness.scala 20:27]
  wire  hostAdapter_io_wbMasterTransmitter_ready; // @[Harness.scala 20:27]
  wire  hostAdapter_io_wbMasterTransmitter_valid; // @[Harness.scala 20:27]
  wire  hostAdapter_io_wbMasterTransmitter_bits_cyc; // @[Harness.scala 20:27]
  wire  hostAdapter_io_wbMasterTransmitter_bits_stb; // @[Harness.scala 20:27]
  wire  hostAdapter_io_wbMasterTransmitter_bits_we; // @[Harness.scala 20:27]
  wire [31:0] hostAdapter_io_wbMasterTransmitter_bits_adr; // @[Harness.scala 20:27]
  wire [31:0] hostAdapter_io_wbMasterTransmitter_bits_dat; // @[Harness.scala 20:27]
  wire [3:0] hostAdapter_io_wbMasterTransmitter_bits_sel; // @[Harness.scala 20:27]
  wire  hostAdapter_io_wbSlaveReceiver_ready; // @[Harness.scala 20:27]
  wire  hostAdapter_io_wbSlaveReceiver_bits_ack; // @[Harness.scala 20:27]
  wire [31:0] hostAdapter_io_wbSlaveReceiver_bits_dat; // @[Harness.scala 20:27]
  wire  hostAdapter_io_wbSlaveReceiver_bits_err; // @[Harness.scala 20:27]
  wire  hostAdapter_io_reqIn_ready; // @[Harness.scala 20:27]
  wire  hostAdapter_io_reqIn_valid; // @[Harness.scala 20:27]
  wire [31:0] hostAdapter_io_reqIn_bits_addrRequest; // @[Harness.scala 20:27]
  wire [31:0] hostAdapter_io_reqIn_bits_dataRequest; // @[Harness.scala 20:27]
  wire [3:0] hostAdapter_io_reqIn_bits_activeByteLane; // @[Harness.scala 20:27]
  wire  hostAdapter_io_reqIn_bits_isWrite; // @[Harness.scala 20:27]
  wire  hostAdapter_io_rspOut_valid; // @[Harness.scala 20:27]
  wire [31:0] hostAdapter_io_rspOut_bits_dataResponse; // @[Harness.scala 20:27]
  wire  hostAdapter_io_rspOut_bits_error; // @[Harness.scala 20:27]
  wire  deviceAdapter_io_wbSlaveTransmitter_ready; // @[Harness.scala 21:29]
  wire  deviceAdapter_io_wbSlaveTransmitter_bits_ack; // @[Harness.scala 21:29]
  wire [31:0] deviceAdapter_io_wbSlaveTransmitter_bits_dat; // @[Harness.scala 21:29]
  wire  deviceAdapter_io_wbSlaveTransmitter_bits_err; // @[Harness.scala 21:29]
  wire  deviceAdapter_io_wbMasterReceiver_ready; // @[Harness.scala 21:29]
  wire  deviceAdapter_io_wbMasterReceiver_valid; // @[Harness.scala 21:29]
  wire  deviceAdapter_io_wbMasterReceiver_bits_cyc; // @[Harness.scala 21:29]
  wire  deviceAdapter_io_wbMasterReceiver_bits_stb; // @[Harness.scala 21:29]
  wire  deviceAdapter_io_wbMasterReceiver_bits_we; // @[Harness.scala 21:29]
  wire [31:0] deviceAdapter_io_wbMasterReceiver_bits_adr; // @[Harness.scala 21:29]
  wire [31:0] deviceAdapter_io_wbMasterReceiver_bits_dat; // @[Harness.scala 21:29]
  wire [3:0] deviceAdapter_io_wbMasterReceiver_bits_sel; // @[Harness.scala 21:29]
  wire  deviceAdapter_io_reqOut_valid; // @[Harness.scala 21:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_addrRequest; // @[Harness.scala 21:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_dataRequest; // @[Harness.scala 21:29]
  wire [3:0] deviceAdapter_io_reqOut_bits_activeByteLane; // @[Harness.scala 21:29]
  wire  deviceAdapter_io_reqOut_bits_isWrite; // @[Harness.scala 21:29]
  wire  deviceAdapter_io_rspIn_valid; // @[Harness.scala 21:29]
  wire [31:0] deviceAdapter_io_rspIn_bits_dataResponse; // @[Harness.scala 21:29]
  wire  deviceAdapter_io_rspIn_bits_error; // @[Harness.scala 21:29]
  wire  gpio_clock; // @[Harness.scala 22:20]
  wire  gpio_reset; // @[Harness.scala 22:20]
  wire  gpio_io_req_valid; // @[Harness.scala 22:20]
  wire [31:0] gpio_io_req_bits_addrRequest; // @[Harness.scala 22:20]
  wire [31:0] gpio_io_req_bits_dataRequest; // @[Harness.scala 22:20]
  wire [3:0] gpio_io_req_bits_activeByteLane; // @[Harness.scala 22:20]
  wire  gpio_io_req_bits_isWrite; // @[Harness.scala 22:20]
  wire  gpio_io_rsp_valid; // @[Harness.scala 22:20]
  wire [31:0] gpio_io_rsp_bits_dataResponse; // @[Harness.scala 22:20]
  wire  gpio_io_rsp_bits_error; // @[Harness.scala 22:20]
  wire [31:0] gpio_io_cio_gpio_i; // @[Harness.scala 22:20]
  wire [31:0] gpio_io_cio_gpio_o; // @[Harness.scala 22:20]
  wire [31:0] gpio_io_cio_gpio_en_o; // @[Harness.scala 22:20]
  wire [31:0] gpio_io_intr_gpio_o; // @[Harness.scala 22:20]
  WishboneHost hostAdapter ( // @[Harness.scala 20:27]
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
  WishboneDevice deviceAdapter ( // @[Harness.scala 21:29]
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
  Gpio gpio ( // @[Harness.scala 22:20]
    .clock(gpio_clock),
    .reset(gpio_reset),
    .io_req_valid(gpio_io_req_valid),
    .io_req_bits_addrRequest(gpio_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(gpio_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(gpio_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(gpio_io_req_bits_isWrite),
    .io_rsp_valid(gpio_io_rsp_valid),
    .io_rsp_bits_dataResponse(gpio_io_rsp_bits_dataResponse),
    .io_rsp_bits_error(gpio_io_rsp_bits_error),
    .io_cio_gpio_i(gpio_io_cio_gpio_i),
    .io_cio_gpio_o(gpio_io_cio_gpio_o),
    .io_cio_gpio_en_o(gpio_io_cio_gpio_en_o),
    .io_intr_gpio_o(gpio_io_intr_gpio_o)
  );
  assign io_req_ready = hostAdapter_io_reqIn_ready; // @[Harness.scala 24:24]
  assign io_rsp_valid = hostAdapter_io_rspOut_valid; // @[Harness.scala 25:10]
  assign io_rsp_bits_dataResponse = hostAdapter_io_rspOut_bits_dataResponse; // @[Harness.scala 25:10]
  assign io_rsp_bits_error = hostAdapter_io_rspOut_bits_error; // @[Harness.scala 25:10]
  assign io_gpio_o = gpio_io_cio_gpio_o; // @[Harness.scala 34:13]
  assign io_gpio_en_o = gpio_io_cio_gpio_en_o; // @[Harness.scala 35:16]
  assign io_gpio_intr_o = gpio_io_intr_gpio_o; // @[Harness.scala 36:18]
  assign hostAdapter_clock = clock;
  assign hostAdapter_reset = reset;
  assign hostAdapter_io_wbMasterTransmitter_ready = deviceAdapter_io_wbMasterReceiver_ready; // @[Harness.scala 27:38]
  assign hostAdapter_io_wbSlaveReceiver_bits_ack = deviceAdapter_io_wbSlaveTransmitter_bits_ack; // @[Harness.scala 28:34]
  assign hostAdapter_io_wbSlaveReceiver_bits_dat = deviceAdapter_io_wbSlaveTransmitter_bits_dat; // @[Harness.scala 28:34]
  assign hostAdapter_io_wbSlaveReceiver_bits_err = deviceAdapter_io_wbSlaveTransmitter_bits_err; // @[Harness.scala 28:34]
  assign hostAdapter_io_reqIn_valid = io_req_valid; // @[Harness.scala 24:24]
  assign hostAdapter_io_reqIn_bits_addrRequest = io_req_bits_addrRequest; // @[Harness.scala 24:24]
  assign hostAdapter_io_reqIn_bits_dataRequest = io_req_bits_dataRequest; // @[Harness.scala 24:24]
  assign hostAdapter_io_reqIn_bits_activeByteLane = io_req_bits_activeByteLane; // @[Harness.scala 24:24]
  assign hostAdapter_io_reqIn_bits_isWrite = io_req_bits_isWrite; // @[Harness.scala 24:24]
  assign deviceAdapter_io_wbSlaveTransmitter_ready = hostAdapter_io_wbSlaveReceiver_ready; // @[Harness.scala 28:34]
  assign deviceAdapter_io_wbMasterReceiver_valid = hostAdapter_io_wbMasterTransmitter_valid; // @[Harness.scala 27:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_cyc = hostAdapter_io_wbMasterTransmitter_bits_cyc; // @[Harness.scala 27:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_stb = hostAdapter_io_wbMasterTransmitter_bits_stb; // @[Harness.scala 27:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_we = hostAdapter_io_wbMasterTransmitter_bits_we; // @[Harness.scala 27:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_adr = hostAdapter_io_wbMasterTransmitter_bits_adr; // @[Harness.scala 27:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_dat = hostAdapter_io_wbMasterTransmitter_bits_dat; // @[Harness.scala 27:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_sel = hostAdapter_io_wbMasterTransmitter_bits_sel; // @[Harness.scala 27:38]
  assign deviceAdapter_io_rspIn_valid = gpio_io_rsp_valid; // @[Harness.scala 31:15]
  assign deviceAdapter_io_rspIn_bits_dataResponse = gpio_io_rsp_bits_dataResponse; // @[Harness.scala 31:15]
  assign deviceAdapter_io_rspIn_bits_error = gpio_io_rsp_bits_error; // @[Harness.scala 31:15]
  assign gpio_clock = clock;
  assign gpio_reset = reset;
  assign gpio_io_req_valid = deviceAdapter_io_reqOut_valid; // @[Harness.scala 30:15]
  assign gpio_io_req_bits_addrRequest = deviceAdapter_io_reqOut_bits_addrRequest; // @[Harness.scala 30:15]
  assign gpio_io_req_bits_dataRequest = deviceAdapter_io_reqOut_bits_dataRequest; // @[Harness.scala 30:15]
  assign gpio_io_req_bits_activeByteLane = deviceAdapter_io_reqOut_bits_activeByteLane; // @[Harness.scala 30:15]
  assign gpio_io_req_bits_isWrite = deviceAdapter_io_reqOut_bits_isWrite; // @[Harness.scala 30:15]
  assign gpio_io_cio_gpio_i = io_gpio_i; // @[Harness.scala 33:22]
endmodule
