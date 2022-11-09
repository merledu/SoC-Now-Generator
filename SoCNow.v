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
  input         io_reqIn_bits_isWrite,
  output        io_rspOut_valid,
  output [31:0] io_rspOut_bits_dataResponse
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
      selReg <= 4'hf; // @[WishboneHost.scala 84:14]
    end else if (io_reqIn_bits_isWrite & readyReg & io_reqIn_valid) begin // @[WishboneHost.scala 85:92]
      selReg <= 4'hf; // @[WishboneHost.scala 92:14]
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
  stbReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  cycReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  weReg = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  datReg = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  adrReg = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  selReg = _RAND_8[3:0];
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
  input  [31:0] io_event_intr_i,
  input  [31:0] io_reg2hw_intr_test_q_i,
  input         io_reg2hw_intr_test_qe_i,
  input  [31:0] io_reg2hw_intr_state_q_i,
  output        io_hw2reg_intr_state_de_o,
  output [31:0] io_hw2reg_intr_state_d_o
);
  wire [31:0] _new_event_T_1 = io_reg2hw_intr_test_qe_i ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _new_event_T_2 = _new_event_T_1 & io_reg2hw_intr_test_q_i; // @[IntrHardware.scala 26:54]
  wire [31:0] new_event = _new_event_T_2 | io_event_intr_i; // @[IntrHardware.scala 26:80]
  assign io_hw2reg_intr_state_de_o = |new_event; // @[IntrHardware.scala 27:45]
  assign io_hw2reg_intr_state_d_o = new_event | io_reg2hw_intr_state_q_i; // @[IntrHardware.scala 28:41]
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
  output [31:0] io_cio_gpio_en_o
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
  wire [31:0] intr_hw_io_event_intr_i; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_reg2hw_intr_test_q_i; // @[Gpio.scala 115:23]
  wire  intr_hw_io_reg2hw_intr_test_qe_i; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_reg2hw_intr_state_q_i; // @[Gpio.scala 115:23]
  wire  intr_hw_io_hw2reg_intr_state_de_o; // @[Gpio.scala 115:23]
  wire [31:0] intr_hw_io_hw2reg_intr_state_d_o; // @[Gpio.scala 115:23]
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
    .io_event_intr_i(intr_hw_io_event_intr_i),
    .io_reg2hw_intr_test_q_i(intr_hw_io_reg2hw_intr_test_q_i),
    .io_reg2hw_intr_test_qe_i(intr_hw_io_reg2hw_intr_test_qe_i),
    .io_reg2hw_intr_state_q_i(intr_hw_io_reg2hw_intr_state_q_i),
    .io_hw2reg_intr_state_de_o(intr_hw_io_hw2reg_intr_state_de_o),
    .io_hw2reg_intr_state_d_o(intr_hw_io_hw2reg_intr_state_d_o)
  );
  assign io_rsp_valid = gpioRegTop_io_rsp_valid; // @[Gpio.scala 26:10]
  assign io_rsp_bits_dataResponse = gpioRegTop_io_rsp_bits_dataResponse; // @[Gpio.scala 26:10]
  assign io_rsp_bits_error = gpioRegTop_io_rsp_bits_error; // @[Gpio.scala 26:10]
  assign io_cio_gpio_o = cio_gpio_q; // @[Gpio.scala 44:17]
  assign io_cio_gpio_en_o = cio_gpio_en_q; // @[Gpio.scala 45:20]
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
  assign intr_hw_io_event_intr_i = _event_intr_combined_T_1 | event_intr_actlow; // @[Gpio.scala 113:81]
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
module BlockRamWithoutMasking(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse,
  output        io_rsp_bits_error
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:1023]; // @[BlockRam.scala 82:24]
  wire [31:0] mem_io_rsp_bits_dataResponse_MPORT_data; // @[BlockRam.scala 82:24]
  wire [9:0] mem_io_rsp_bits_dataResponse_MPORT_addr; // @[BlockRam.scala 82:24]
  wire [31:0] mem_MPORT_data; // @[BlockRam.scala 82:24]
  wire [9:0] mem_MPORT_addr; // @[BlockRam.scala 82:24]
  wire  mem_MPORT_mask; // @[BlockRam.scala 82:24]
  wire  mem_MPORT_en; // @[BlockRam.scala 82:24]
  reg  mem_io_rsp_bits_dataResponse_MPORT_en_pipe_0;
  reg [9:0] mem_io_rsp_bits_dataResponse_MPORT_addr_pipe_0;
  reg  validReg; // @[BlockRam.scala 72:25]
  reg  errReg; // @[BlockRam.scala 73:23]
  wire  _addrMisaligned_T = io_req_ready & io_req_valid; // @[Decoupled.scala 40:37]
  wire  addrMisaligned = _addrMisaligned_T & |io_req_bits_addrRequest[1:0]; // @[BlockRam.scala 78:24]
  wire [31:0] _addrOutOfBounds_T_1 = io_req_bits_addrRequest / 3'h4; // @[BlockRam.scala 79:65]
  wire  addrOutOfBounds = _addrMisaligned_T & _addrOutOfBounds_T_1 >= 32'h3ff; // @[BlockRam.scala 79:25]
  wire  _T_1 = ~io_req_bits_isWrite; // @[BlockRam.scala 88:25]
  wire  _T_2 = _addrMisaligned_T & ~io_req_bits_isWrite; // @[BlockRam.scala 88:22]
  wire  _T_4 = _addrMisaligned_T & io_req_bits_isWrite; // @[BlockRam.scala 92:29]
  wire  _GEN_9 = _addrMisaligned_T & ~io_req_bits_isWrite | _T_4; // @[BlockRam.scala 88:47 BlockRam.scala 91:14]
  assign mem_io_rsp_bits_dataResponse_MPORT_addr = mem_io_rsp_bits_dataResponse_MPORT_addr_pipe_0;
  assign mem_io_rsp_bits_dataResponse_MPORT_data = mem[mem_io_rsp_bits_dataResponse_MPORT_addr]; // @[BlockRam.scala 82:24]
  assign mem_MPORT_data = io_req_bits_dataRequest;
  assign mem_MPORT_addr = _addrOutOfBounds_T_1[9:0];
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = _T_2 ? 1'h0 : _T_4;
  assign io_req_ready = 1'h1; // @[BlockRam.scala 76:16]
  assign io_rsp_valid = validReg; // @[BlockRam.scala 74:16]
  assign io_rsp_bits_dataResponse = mem_io_rsp_bits_dataResponse_MPORT_data; // @[BlockRam.scala 88:47 BlockRam.scala 90:30]
  assign io_rsp_bits_error = errReg; // @[BlockRam.scala 75:21]
  always @(posedge clock) begin
    if(mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[BlockRam.scala 82:24]
    end
    mem_io_rsp_bits_dataResponse_MPORT_en_pipe_0 <= _addrMisaligned_T & _T_1;
    if (_addrMisaligned_T & _T_1) begin
      mem_io_rsp_bits_dataResponse_MPORT_addr_pipe_0 <= _addrOutOfBounds_T_1[9:0];
    end
    if (reset) begin // @[BlockRam.scala 72:25]
      validReg <= 1'h0; // @[BlockRam.scala 72:25]
    end else begin
      validReg <= _GEN_9;
    end
    if (reset) begin // @[BlockRam.scala 73:23]
      errReg <= 1'h0; // @[BlockRam.scala 73:23]
    end else begin
      errReg <= addrMisaligned | addrOutOfBounds; // @[BlockRam.scala 81:10]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_io_rsp_bits_dataResponse_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_io_rsp_bits_dataResponse_MPORT_addr_pipe_0 = _RAND_2[9:0];
  _RAND_3 = {1{`RANDOM}};
  validReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  errReg = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BlockRamWithMasking(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input  [3:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem_0 [0:1023]; // @[BlockRam.scala 141:24]
  wire [7:0] mem_0_MPORT_data; // @[BlockRam.scala 141:24]
  wire [9:0] mem_0_MPORT_addr; // @[BlockRam.scala 141:24]
  wire [7:0] mem_0_MPORT_1_data; // @[BlockRam.scala 141:24]
  wire [9:0] mem_0_MPORT_1_addr; // @[BlockRam.scala 141:24]
  wire  mem_0_MPORT_1_mask; // @[BlockRam.scala 141:24]
  wire  mem_0_MPORT_1_en; // @[BlockRam.scala 141:24]
  reg  mem_0_MPORT_en_pipe_0;
  reg [9:0] mem_0_MPORT_addr_pipe_0;
  reg [7:0] mem_1 [0:1023]; // @[BlockRam.scala 141:24]
  wire [7:0] mem_1_MPORT_data; // @[BlockRam.scala 141:24]
  wire [9:0] mem_1_MPORT_addr; // @[BlockRam.scala 141:24]
  wire [7:0] mem_1_MPORT_1_data; // @[BlockRam.scala 141:24]
  wire [9:0] mem_1_MPORT_1_addr; // @[BlockRam.scala 141:24]
  wire  mem_1_MPORT_1_mask; // @[BlockRam.scala 141:24]
  wire  mem_1_MPORT_1_en; // @[BlockRam.scala 141:24]
  reg  mem_1_MPORT_en_pipe_0;
  reg [9:0] mem_1_MPORT_addr_pipe_0;
  reg [7:0] mem_2 [0:1023]; // @[BlockRam.scala 141:24]
  wire [7:0] mem_2_MPORT_data; // @[BlockRam.scala 141:24]
  wire [9:0] mem_2_MPORT_addr; // @[BlockRam.scala 141:24]
  wire [7:0] mem_2_MPORT_1_data; // @[BlockRam.scala 141:24]
  wire [9:0] mem_2_MPORT_1_addr; // @[BlockRam.scala 141:24]
  wire  mem_2_MPORT_1_mask; // @[BlockRam.scala 141:24]
  wire  mem_2_MPORT_1_en; // @[BlockRam.scala 141:24]
  reg  mem_2_MPORT_en_pipe_0;
  reg [9:0] mem_2_MPORT_addr_pipe_0;
  reg [7:0] mem_3 [0:1023]; // @[BlockRam.scala 141:24]
  wire [7:0] mem_3_MPORT_data; // @[BlockRam.scala 141:24]
  wire [9:0] mem_3_MPORT_addr; // @[BlockRam.scala 141:24]
  wire [7:0] mem_3_MPORT_1_data; // @[BlockRam.scala 141:24]
  wire [9:0] mem_3_MPORT_1_addr; // @[BlockRam.scala 141:24]
  wire  mem_3_MPORT_1_mask; // @[BlockRam.scala 141:24]
  wire  mem_3_MPORT_1_en; // @[BlockRam.scala 141:24]
  reg  mem_3_MPORT_en_pipe_0;
  reg [9:0] mem_3_MPORT_addr_pipe_0;
  wire  byteLane_0 = io_req_bits_activeByteLane[0]; // @[BlockRam.scala 128:52]
  wire  byteLane_1 = io_req_bits_activeByteLane[1]; // @[BlockRam.scala 128:52]
  wire  byteLane_2 = io_req_bits_activeByteLane[2]; // @[BlockRam.scala 128:52]
  wire  byteLane_3 = io_req_bits_activeByteLane[3]; // @[BlockRam.scala 128:52]
  reg  validReg; // @[BlockRam.scala 136:25]
  wire  _T = io_req_ready & io_req_valid; // @[Decoupled.scala 40:37]
  wire  _T_1 = ~io_req_bits_isWrite; // @[BlockRam.scala 143:25]
  wire  _T_2 = _T & ~io_req_bits_isWrite; // @[BlockRam.scala 143:22]
  wire [31:0] _T_3 = io_req_bits_addrRequest / 3'h4; // @[BlockRam.scala 145:46]
  wire  _T_6 = _T & io_req_bits_isWrite; // @[BlockRam.scala 147:29]
  wire [7:0] rdata_0 = mem_0_MPORT_data; // @[BlockRam.scala 143:47 BlockRam.scala 145:11]
  wire [7:0] rdata_1 = mem_1_MPORT_data; // @[BlockRam.scala 143:47 BlockRam.scala 145:11]
  wire [7:0] rdata_2 = mem_2_MPORT_data; // @[BlockRam.scala 143:47 BlockRam.scala 145:11]
  wire [7:0] rdata_3 = mem_3_MPORT_data; // @[BlockRam.scala 143:47 BlockRam.scala 145:11]
  wire  _GEN_26 = _T & ~io_req_bits_isWrite | _T_6; // @[BlockRam.scala 143:47 BlockRam.scala 146:14]
  wire [7:0] data_0 = byteLane_0 ? rdata_0 : 8'h0; // @[BlockRam.scala 160:8]
  wire [7:0] data_1 = byteLane_1 ? rdata_1 : 8'h0; // @[BlockRam.scala 160:8]
  wire [7:0] data_2 = byteLane_2 ? rdata_2 : 8'h0; // @[BlockRam.scala 160:8]
  wire [7:0] data_3 = byteLane_3 ? rdata_3 : 8'h0; // @[BlockRam.scala 160:8]
  wire [15:0] io_rsp_bits_dataResponse_lo = {data_1,data_0}; // @[Cat.scala 30:58]
  wire [15:0] io_rsp_bits_dataResponse_hi = {data_3,data_2}; // @[Cat.scala 30:58]
  assign mem_0_MPORT_addr = mem_0_MPORT_addr_pipe_0;
  assign mem_0_MPORT_data = mem_0[mem_0_MPORT_addr]; // @[BlockRam.scala 141:24]
  assign mem_0_MPORT_1_data = io_req_bits_dataRequest[7:0];
  assign mem_0_MPORT_1_addr = _T_3[9:0];
  assign mem_0_MPORT_1_mask = io_req_bits_activeByteLane[0];
  assign mem_0_MPORT_1_en = _T_2 ? 1'h0 : _T_6;
  assign mem_1_MPORT_addr = mem_1_MPORT_addr_pipe_0;
  assign mem_1_MPORT_data = mem_1[mem_1_MPORT_addr]; // @[BlockRam.scala 141:24]
  assign mem_1_MPORT_1_data = io_req_bits_dataRequest[15:8];
  assign mem_1_MPORT_1_addr = _T_3[9:0];
  assign mem_1_MPORT_1_mask = io_req_bits_activeByteLane[1];
  assign mem_1_MPORT_1_en = _T_2 ? 1'h0 : _T_6;
  assign mem_2_MPORT_addr = mem_2_MPORT_addr_pipe_0;
  assign mem_2_MPORT_data = mem_2[mem_2_MPORT_addr]; // @[BlockRam.scala 141:24]
  assign mem_2_MPORT_1_data = io_req_bits_dataRequest[23:16];
  assign mem_2_MPORT_1_addr = _T_3[9:0];
  assign mem_2_MPORT_1_mask = io_req_bits_activeByteLane[2];
  assign mem_2_MPORT_1_en = _T_2 ? 1'h0 : _T_6;
  assign mem_3_MPORT_addr = mem_3_MPORT_addr_pipe_0;
  assign mem_3_MPORT_data = mem_3[mem_3_MPORT_addr]; // @[BlockRam.scala 141:24]
  assign mem_3_MPORT_1_data = io_req_bits_dataRequest[31:24];
  assign mem_3_MPORT_1_addr = _T_3[9:0];
  assign mem_3_MPORT_1_mask = io_req_bits_activeByteLane[3];
  assign mem_3_MPORT_1_en = _T_2 ? 1'h0 : _T_6;
  assign io_req_ready = 1'h1; // @[BlockRam.scala 139:16]
  assign io_rsp_valid = validReg; // @[BlockRam.scala 137:16]
  assign io_rsp_bits_dataResponse = {io_rsp_bits_dataResponse_hi,io_rsp_bits_dataResponse_lo}; // @[Cat.scala 30:58]
  always @(posedge clock) begin
    if(mem_0_MPORT_1_en & mem_0_MPORT_1_mask) begin
      mem_0[mem_0_MPORT_1_addr] <= mem_0_MPORT_1_data; // @[BlockRam.scala 141:24]
    end
    mem_0_MPORT_en_pipe_0 <= _T & _T_1;
    if (_T & _T_1) begin
      mem_0_MPORT_addr_pipe_0 <= _T_3[9:0];
    end
    if(mem_1_MPORT_1_en & mem_1_MPORT_1_mask) begin
      mem_1[mem_1_MPORT_1_addr] <= mem_1_MPORT_1_data; // @[BlockRam.scala 141:24]
    end
    mem_1_MPORT_en_pipe_0 <= _T & _T_1;
    if (_T & _T_1) begin
      mem_1_MPORT_addr_pipe_0 <= _T_3[9:0];
    end
    if(mem_2_MPORT_1_en & mem_2_MPORT_1_mask) begin
      mem_2[mem_2_MPORT_1_addr] <= mem_2_MPORT_1_data; // @[BlockRam.scala 141:24]
    end
    mem_2_MPORT_en_pipe_0 <= _T & _T_1;
    if (_T & _T_1) begin
      mem_2_MPORT_addr_pipe_0 <= _T_3[9:0];
    end
    if(mem_3_MPORT_1_en & mem_3_MPORT_1_mask) begin
      mem_3[mem_3_MPORT_1_addr] <= mem_3_MPORT_1_data; // @[BlockRam.scala 141:24]
    end
    mem_3_MPORT_en_pipe_0 <= _T & _T_1;
    if (_T & _T_1) begin
      mem_3_MPORT_addr_pipe_0 <= _T_3[9:0];
    end
    if (reset) begin // @[BlockRam.scala 136:25]
      validReg <= 1'h0; // @[BlockRam.scala 136:25]
    end else begin
      validReg <= _GEN_26;
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_0[initvar] = _RAND_0[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_1[initvar] = _RAND_3[7:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_2[initvar] = _RAND_6[7:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_3[initvar] = _RAND_9[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_0_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_0_MPORT_addr_pipe_0 = _RAND_2[9:0];
  _RAND_4 = {1{`RANDOM}};
  mem_1_MPORT_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  mem_1_MPORT_addr_pipe_0 = _RAND_5[9:0];
  _RAND_7 = {1{`RANDOM}};
  mem_2_MPORT_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  mem_2_MPORT_addr_pipe_0 = _RAND_8[9:0];
  _RAND_10 = {1{`RANDOM}};
  mem_3_MPORT_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  mem_3_MPORT_addr_pipe_0 = _RAND_11[9:0];
  _RAND_12 = {1{`RANDOM}};
  validReg = _RAND_12[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module WishboneErr(
  input         clock,
  input         reset,
  output [31:0] io_wbSlaveTransmitter_bits_dat,
  output        io_wbSlaveTransmitter_bits_err,
  input         io_wbMasterReceiver_valid,
  input         io_wbMasterReceiver_bits_cyc,
  input         io_wbMasterReceiver_bits_stb
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] dataReg; // @[WishboneErr.scala 15:24]
  reg  errReg; // @[WishboneErr.scala 16:23]
  wire  _T_1 = io_wbMasterReceiver_valid & io_wbMasterReceiver_bits_cyc & io_wbMasterReceiver_bits_stb; // @[WishboneErr.scala 12:80]
  assign io_wbSlaveTransmitter_bits_dat = dataReg; // @[WishboneErr.scala 44:34]
  assign io_wbSlaveTransmitter_bits_err = errReg; // @[WishboneErr.scala 45:35]
  always @(posedge clock) begin
    if (reset) begin // @[WishboneErr.scala 15:24]
      dataReg <= 32'h0; // @[WishboneErr.scala 15:24]
    end else if (_T_1) begin // @[WishboneErr.scala 21:16]
      dataReg <= 32'hffffffff;
    end else begin
      dataReg <= 32'h0; // @[WishboneErr.scala 37:13]
    end
    if (reset) begin // @[WishboneErr.scala 16:23]
      errReg <= 1'h0; // @[WishboneErr.scala 16:23]
    end else begin
      errReg <= _T_1;
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
  dataReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  errReg = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InstructionFetch(
  input  [31:0] io_address,
  output [31:0] io_instruction,
  input         io_coreInstrReq_ready,
  output        io_coreInstrReq_valid,
  output [31:0] io_coreInstrReq_bits_addrRequest,
  input         io_coreInstrResp_valid,
  input  [31:0] io_coreInstrResp_bits_dataResponse
);
  assign io_instruction = io_coreInstrResp_valid ? io_coreInstrResp_bits_dataResponse : 32'h0; // @[InstructionFetch.scala 26:24]
  assign io_coreInstrReq_valid = io_coreInstrReq_ready; // @[InstructionFetch.scala 24:31]
  assign io_coreInstrReq_bits_addrRequest = io_address; // @[InstructionFetch.scala 23:36]
endmodule
module HazardUnit(
  input        io_id_ex_memRead,
  input        io_ex_mem_memRead,
  input        io_id_ex_branch,
  input  [4:0] io_id_ex_rd,
  input  [4:0] io_ex_mem_rd,
  input  [4:0] io_id_rs1,
  input  [4:0] io_id_rs2,
  input        io_taken,
  input  [1:0] io_jump,
  input        io_branch,
  output       io_if_reg_write,
  output       io_pc_write,
  output       io_ctl_mux,
  output       io_ifid_flush,
  output       io_take_branch
);
  wire  _T_3 = io_id_ex_rd == io_id_rs1 | io_id_ex_rd == io_id_rs2; // @[HazardUnit.scala 35:34]
  wire  _T_4 = (io_id_ex_memRead | io_branch) & _T_3; // @[HazardUnit.scala 34:37]
  wire  _T_5 = io_id_ex_rd != 5'h0; // @[HazardUnit.scala 36:21]
  wire  _T_10 = _T_5 & io_id_rs2 != 5'h0; // @[HazardUnit.scala 37:28]
  wire  _T_11 = io_id_ex_rd != 5'h0 & io_id_rs1 != 5'h0 | _T_10; // @[HazardUnit.scala 36:51]
  wire  _T_12 = _T_4 & _T_11; // @[HazardUnit.scala 35:65]
  wire  _T_13 = ~io_id_ex_branch; // @[HazardUnit.scala 38:7]
  wire  _T_14 = _T_12 & _T_13; // @[HazardUnit.scala 37:51]
  wire  _GEN_0 = _T_14 ? 1'h0 : 1'h1; // @[HazardUnit.scala 40:3 HazardUnit.scala 41:16 HazardUnit.scala 26:14]
  assign io_if_reg_write = io_ex_mem_memRead & io_branch & (io_ex_mem_rd == io_id_rs1 | io_ex_mem_rd == io_id_rs2) ? 1'h0
     : _GEN_0; // @[HazardUnit.scala 47:101 HazardUnit.scala 48:16]
  assign io_pc_write = io_ex_mem_memRead & io_branch & (io_ex_mem_rd == io_id_rs1 | io_ex_mem_rd == io_id_rs2) ? 1'h0 :
    _GEN_0; // @[HazardUnit.scala 47:101 HazardUnit.scala 48:16]
  assign io_ctl_mux = io_ex_mem_memRead & io_branch & (io_ex_mem_rd == io_id_rs1 | io_ex_mem_rd == io_id_rs2) ? 1'h0 :
    _GEN_0; // @[HazardUnit.scala 47:101 HazardUnit.scala 48:16]
  assign io_ifid_flush = io_taken | io_jump != 2'h0; // @[HazardUnit.scala 55:17]
  assign io_take_branch = io_ex_mem_memRead & io_branch & (io_ex_mem_rd == io_id_rs1 | io_ex_mem_rd == io_id_rs2) ? 1'h0
     : _GEN_0; // @[HazardUnit.scala 47:101 HazardUnit.scala 48:16]
endmodule
module Control(
  input  [31:0] io_in,
  output        io_aluSrc,
  output [1:0]  io_memToReg,
  output        io_regWrite,
  output        io_memRead,
  output        io_memWrite,
  output        io_branch,
  output [1:0]  io_aluOp,
  output [1:0]  io_jump,
  output [1:0]  io_aluSrc1
);
  wire [31:0] _T = io_in & 32'h7f; // @[Lookup.scala 31:38]
  wire  _T_1 = 32'h33 == _T; // @[Lookup.scala 31:38]
  wire  _T_3 = 32'h13 == _T; // @[Lookup.scala 31:38]
  wire  _T_5 = 32'h3 == _T; // @[Lookup.scala 31:38]
  wire  _T_7 = 32'h23 == _T; // @[Lookup.scala 31:38]
  wire  _T_9 = 32'h63 == _T; // @[Lookup.scala 31:38]
  wire  _T_11 = 32'h37 == _T; // @[Lookup.scala 31:38]
  wire  _T_13 = 32'h17 == _T; // @[Lookup.scala 31:38]
  wire  _T_15 = 32'h6f == _T; // @[Lookup.scala 31:38]
  wire  _T_17 = 32'h67 == _T; // @[Lookup.scala 31:38]
  wire  _T_23 = _T_7 ? 1'h0 : _T_9; // @[Lookup.scala 33:37]
  wire  _T_24 = _T_5 ? 1'h0 : _T_23; // @[Lookup.scala 33:37]
  wire  _T_25 = _T_3 ? 1'h0 : _T_24; // @[Lookup.scala 33:37]
  wire [1:0] _T_26 = _T_17 ? 2'h2 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _T_27 = _T_15 ? 2'h2 : _T_26; // @[Lookup.scala 33:37]
  wire [1:0] _T_28 = _T_13 ? 2'h0 : _T_27; // @[Lookup.scala 33:37]
  wire [1:0] _T_29 = _T_11 ? 2'h0 : _T_28; // @[Lookup.scala 33:37]
  wire [1:0] _T_30 = _T_9 ? 2'h0 : _T_29; // @[Lookup.scala 33:37]
  wire [1:0] _T_31 = _T_7 ? 2'h0 : _T_30; // @[Lookup.scala 33:37]
  wire [1:0] _T_32 = _T_5 ? 2'h1 : _T_31; // @[Lookup.scala 33:37]
  wire [1:0] _T_33 = _T_3 ? 2'h0 : _T_32; // @[Lookup.scala 33:37]
  wire  _T_38 = _T_9 ? 1'h0 : _T_11 | (_T_13 | (_T_15 | _T_17)); // @[Lookup.scala 33:37]
  wire  _T_39 = _T_7 ? 1'h0 : _T_38; // @[Lookup.scala 33:37]
  wire  _T_49 = _T_3 ? 1'h0 : _T_5; // @[Lookup.scala 33:37]
  wire  _T_56 = _T_5 ? 1'h0 : _T_7; // @[Lookup.scala 33:37]
  wire  _T_57 = _T_3 ? 1'h0 : _T_56; // @[Lookup.scala 33:37]
  wire [1:0] _T_67 = _T_15 ? 2'h1 : _T_26; // @[Lookup.scala 33:37]
  wire [1:0] _T_68 = _T_13 ? 2'h0 : _T_67; // @[Lookup.scala 33:37]
  wire [1:0] _T_69 = _T_11 ? 2'h0 : _T_68; // @[Lookup.scala 33:37]
  wire [1:0] _T_70 = _T_9 ? 2'h0 : _T_69; // @[Lookup.scala 33:37]
  wire [1:0] _T_71 = _T_7 ? 2'h0 : _T_70; // @[Lookup.scala 33:37]
  wire [1:0] _T_72 = _T_5 ? 2'h0 : _T_71; // @[Lookup.scala 33:37]
  wire [1:0] _T_73 = _T_3 ? 2'h0 : _T_72; // @[Lookup.scala 33:37]
  wire [1:0] _T_81 = _T_3 ? 2'h2 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _T_85 = _T_11 ? 2'h2 : {{1'd0}, _T_13}; // @[Lookup.scala 33:37]
  wire [1:0] _T_86 = _T_9 ? 2'h0 : _T_85; // @[Lookup.scala 33:37]
  wire [1:0] _T_87 = _T_7 ? 2'h0 : _T_86; // @[Lookup.scala 33:37]
  wire [1:0] _T_88 = _T_5 ? 2'h0 : _T_87; // @[Lookup.scala 33:37]
  wire [1:0] _T_89 = _T_3 ? 2'h0 : _T_88; // @[Lookup.scala 33:37]
  assign io_aluSrc = _T_1 | _T_25; // @[Lookup.scala 33:37]
  assign io_memToReg = _T_1 ? 2'h0 : _T_33; // @[Lookup.scala 33:37]
  assign io_regWrite = _T_1 | (_T_3 | (_T_5 | _T_39)); // @[Lookup.scala 33:37]
  assign io_memRead = _T_1 ? 1'h0 : _T_49; // @[Lookup.scala 33:37]
  assign io_memWrite = _T_1 ? 1'h0 : _T_57; // @[Lookup.scala 33:37]
  assign io_branch = _T_1 ? 1'h0 : _T_25; // @[Lookup.scala 33:37]
  assign io_aluOp = _T_1 ? 2'h2 : _T_81; // @[Lookup.scala 33:37]
  assign io_jump = _T_1 ? 2'h0 : _T_73; // @[Lookup.scala 33:37]
  assign io_aluSrc1 = _T_1 ? 2'h0 : _T_89; // @[Lookup.scala 33:37]
endmodule
module Registers(
  input         clock,
  input         reset,
  input  [4:0]  io_readAddress_0,
  input  [4:0]  io_readAddress_1,
  input         io_writeEnable,
  input  [4:0]  io_writeAddress,
  input  [31:0] io_writeData,
  output [31:0] io_readData_0,
  output [31:0] io_readData_1
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
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_0; // @[Registers.scala 14:20]
  reg [31:0] reg_1; // @[Registers.scala 14:20]
  reg [31:0] reg_2; // @[Registers.scala 14:20]
  reg [31:0] reg_3; // @[Registers.scala 14:20]
  reg [31:0] reg_4; // @[Registers.scala 14:20]
  reg [31:0] reg_5; // @[Registers.scala 14:20]
  reg [31:0] reg_6; // @[Registers.scala 14:20]
  reg [31:0] reg_7; // @[Registers.scala 14:20]
  reg [31:0] reg_8; // @[Registers.scala 14:20]
  reg [31:0] reg_9; // @[Registers.scala 14:20]
  reg [31:0] reg_10; // @[Registers.scala 14:20]
  reg [31:0] reg_11; // @[Registers.scala 14:20]
  reg [31:0] reg_12; // @[Registers.scala 14:20]
  reg [31:0] reg_13; // @[Registers.scala 14:20]
  reg [31:0] reg_14; // @[Registers.scala 14:20]
  reg [31:0] reg_15; // @[Registers.scala 14:20]
  reg [31:0] reg_16; // @[Registers.scala 14:20]
  reg [31:0] reg_17; // @[Registers.scala 14:20]
  reg [31:0] reg_18; // @[Registers.scala 14:20]
  reg [31:0] reg_19; // @[Registers.scala 14:20]
  reg [31:0] reg_20; // @[Registers.scala 14:20]
  reg [31:0] reg_21; // @[Registers.scala 14:20]
  reg [31:0] reg_22; // @[Registers.scala 14:20]
  reg [31:0] reg_23; // @[Registers.scala 14:20]
  reg [31:0] reg_24; // @[Registers.scala 14:20]
  reg [31:0] reg_25; // @[Registers.scala 14:20]
  reg [31:0] reg_26; // @[Registers.scala 14:20]
  reg [31:0] reg_27; // @[Registers.scala 14:20]
  reg [31:0] reg_28; // @[Registers.scala 14:20]
  reg [31:0] reg_29; // @[Registers.scala 14:20]
  reg [31:0] reg_30; // @[Registers.scala 14:20]
  reg [31:0] reg_31; // @[Registers.scala 14:20]
  wire [31:0] _GEN_65 = 5'h1 == io_readAddress_0 ? reg_1 : reg_0; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_66 = 5'h2 == io_readAddress_0 ? reg_2 : _GEN_65; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_67 = 5'h3 == io_readAddress_0 ? reg_3 : _GEN_66; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_68 = 5'h4 == io_readAddress_0 ? reg_4 : _GEN_67; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_69 = 5'h5 == io_readAddress_0 ? reg_5 : _GEN_68; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_70 = 5'h6 == io_readAddress_0 ? reg_6 : _GEN_69; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_71 = 5'h7 == io_readAddress_0 ? reg_7 : _GEN_70; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_72 = 5'h8 == io_readAddress_0 ? reg_8 : _GEN_71; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_73 = 5'h9 == io_readAddress_0 ? reg_9 : _GEN_72; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_74 = 5'ha == io_readAddress_0 ? reg_10 : _GEN_73; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_75 = 5'hb == io_readAddress_0 ? reg_11 : _GEN_74; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_76 = 5'hc == io_readAddress_0 ? reg_12 : _GEN_75; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_77 = 5'hd == io_readAddress_0 ? reg_13 : _GEN_76; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_78 = 5'he == io_readAddress_0 ? reg_14 : _GEN_77; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_79 = 5'hf == io_readAddress_0 ? reg_15 : _GEN_78; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_80 = 5'h10 == io_readAddress_0 ? reg_16 : _GEN_79; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_81 = 5'h11 == io_readAddress_0 ? reg_17 : _GEN_80; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_82 = 5'h12 == io_readAddress_0 ? reg_18 : _GEN_81; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_83 = 5'h13 == io_readAddress_0 ? reg_19 : _GEN_82; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_84 = 5'h14 == io_readAddress_0 ? reg_20 : _GEN_83; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_85 = 5'h15 == io_readAddress_0 ? reg_21 : _GEN_84; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_86 = 5'h16 == io_readAddress_0 ? reg_22 : _GEN_85; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_87 = 5'h17 == io_readAddress_0 ? reg_23 : _GEN_86; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_88 = 5'h18 == io_readAddress_0 ? reg_24 : _GEN_87; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_89 = 5'h19 == io_readAddress_0 ? reg_25 : _GEN_88; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_90 = 5'h1a == io_readAddress_0 ? reg_26 : _GEN_89; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_91 = 5'h1b == io_readAddress_0 ? reg_27 : _GEN_90; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_92 = 5'h1c == io_readAddress_0 ? reg_28 : _GEN_91; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_93 = 5'h1d == io_readAddress_0 ? reg_29 : _GEN_92; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_94 = 5'h1e == io_readAddress_0 ? reg_30 : _GEN_93; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_95 = 5'h1f == io_readAddress_0 ? reg_31 : _GEN_94; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_98 = 5'h1 == io_readAddress_1 ? reg_1 : reg_0; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_99 = 5'h2 == io_readAddress_1 ? reg_2 : _GEN_98; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_100 = 5'h3 == io_readAddress_1 ? reg_3 : _GEN_99; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_101 = 5'h4 == io_readAddress_1 ? reg_4 : _GEN_100; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_102 = 5'h5 == io_readAddress_1 ? reg_5 : _GEN_101; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_103 = 5'h6 == io_readAddress_1 ? reg_6 : _GEN_102; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_104 = 5'h7 == io_readAddress_1 ? reg_7 : _GEN_103; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_105 = 5'h8 == io_readAddress_1 ? reg_8 : _GEN_104; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_106 = 5'h9 == io_readAddress_1 ? reg_9 : _GEN_105; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_107 = 5'ha == io_readAddress_1 ? reg_10 : _GEN_106; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_108 = 5'hb == io_readAddress_1 ? reg_11 : _GEN_107; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_109 = 5'hc == io_readAddress_1 ? reg_12 : _GEN_108; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_110 = 5'hd == io_readAddress_1 ? reg_13 : _GEN_109; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_111 = 5'he == io_readAddress_1 ? reg_14 : _GEN_110; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_112 = 5'hf == io_readAddress_1 ? reg_15 : _GEN_111; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_113 = 5'h10 == io_readAddress_1 ? reg_16 : _GEN_112; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_114 = 5'h11 == io_readAddress_1 ? reg_17 : _GEN_113; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_115 = 5'h12 == io_readAddress_1 ? reg_18 : _GEN_114; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_116 = 5'h13 == io_readAddress_1 ? reg_19 : _GEN_115; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_117 = 5'h14 == io_readAddress_1 ? reg_20 : _GEN_116; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_118 = 5'h15 == io_readAddress_1 ? reg_21 : _GEN_117; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_119 = 5'h16 == io_readAddress_1 ? reg_22 : _GEN_118; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_120 = 5'h17 == io_readAddress_1 ? reg_23 : _GEN_119; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_121 = 5'h18 == io_readAddress_1 ? reg_24 : _GEN_120; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_122 = 5'h19 == io_readAddress_1 ? reg_25 : _GEN_121; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_123 = 5'h1a == io_readAddress_1 ? reg_26 : _GEN_122; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_124 = 5'h1b == io_readAddress_1 ? reg_27 : _GEN_123; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_125 = 5'h1c == io_readAddress_1 ? reg_28 : _GEN_124; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_126 = 5'h1d == io_readAddress_1 ? reg_29 : _GEN_125; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_127 = 5'h1e == io_readAddress_1 ? reg_30 : _GEN_126; // @[Registers.scala 23:22 Registers.scala 23:22]
  wire [31:0] _GEN_128 = 5'h1f == io_readAddress_1 ? reg_31 : _GEN_127; // @[Registers.scala 23:22 Registers.scala 23:22]
  assign io_readData_0 = io_readAddress_0 == 5'h0 ? 32'h0 : _GEN_95; // @[Registers.scala 20:37 Registers.scala 21:22 Registers.scala 23:22]
  assign io_readData_1 = io_readAddress_1 == 5'h0 ? 32'h0 : _GEN_128; // @[Registers.scala 20:37 Registers.scala 21:22 Registers.scala 23:22]
  always @(posedge clock) begin
    if (reset) begin // @[Registers.scala 14:20]
      reg_0 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h0 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_0 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_1 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_1 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_2 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h2 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_2 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_3 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h3 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_3 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_4 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h4 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_4 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_5 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h5 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_5 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_6 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h6 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_6 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_7 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h7 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_7 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_8 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h8 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_8 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_9 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h9 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_9 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_10 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'ha == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_10 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_11 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'hb == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_11 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_12 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'hc == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_12 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_13 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'hd == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_13 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_14 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'he == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_14 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_15 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'hf == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_15 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_16 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h10 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_16 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_17 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h11 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_17 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_18 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h12 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_18 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_19 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h13 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_19 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_20 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h14 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_20 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_21 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h15 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_21 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_22 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h16 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_22 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_23 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h17 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_23 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_24 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h18 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_24 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_25 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h19 == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_25 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_26 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1a == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_26 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_27 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1b == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_27 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_28 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1c == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_28 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_29 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1d == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_29 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_30 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1e == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_30 <= io_writeData; // @[Registers.scala 17:26]
      end
    end
    if (reset) begin // @[Registers.scala 14:20]
      reg_31 <= 32'h0; // @[Registers.scala 14:20]
    end else if (io_writeEnable) begin // @[Registers.scala 16:24]
      if (5'h1f == io_writeAddress) begin // @[Registers.scala 17:26]
        reg_31 <= io_writeData; // @[Registers.scala 17:26]
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
  reg_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  reg_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  reg_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  reg_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  reg_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  reg_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  reg_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  reg_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  reg_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  reg_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  reg_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  reg_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  reg_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  reg_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  reg_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  reg_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  reg_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  reg_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  reg_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  reg_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  reg_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  reg_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  reg_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  reg_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  reg_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  reg_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  reg_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  reg_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  reg_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  reg_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  reg_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  reg_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ImmediateGen(
  input  [31:0] io_instruction,
  output [31:0] io_out
);
  wire [6:0] opcode = io_instruction[6:0]; // @[ImmediateGen.scala 11:30]
  wire  _T_10 = opcode == 7'h3 | opcode == 7'hf | opcode == 7'h13 | opcode == 7'h1b | opcode == 7'h67 | opcode == 7'h73; // @[ImmediateGen.scala 15:97]
  wire [11:0] lo = io_instruction[31:20]; // @[ImmediateGen.scala 17:31]
  wire [19:0] hi = lo[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_13 = {hi,lo}; // @[Cat.scala 30:58]
  wire [19:0] hi_1 = io_instruction[31:12]; // @[ImmediateGen.scala 24:33]
  wire [31:0] _T_17 = {hi_1,12'h0}; // @[Cat.scala 30:58]
  wire [6:0] hi_2 = io_instruction[31:25]; // @[ImmediateGen.scala 30:37]
  wire [4:0] lo_2 = io_instruction[11:7]; // @[ImmediateGen.scala 30:61]
  wire [11:0] lo_3 = {hi_2,lo_2}; // @[Cat.scala 30:58]
  wire [19:0] hi_3 = lo_3[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_21 = {hi_3,hi_2,lo_2}; // @[Cat.scala 30:58]
  wire  hi_hi = io_instruction[31]; // @[ImmediateGen.scala 37:23]
  wire  hi_lo = io_instruction[7]; // @[ImmediateGen.scala 38:23]
  wire [5:0] lo_hi = io_instruction[30:25]; // @[ImmediateGen.scala 39:23]
  wire [3:0] lo_lo = io_instruction[11:8]; // @[ImmediateGen.scala 40:23]
  wire [11:0] hi_lo_1 = {hi_hi,hi_lo,lo_hi,lo_lo}; // @[Cat.scala 30:58]
  wire [18:0] hi_hi_1 = hi_lo_1[11] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_25 = {hi_hi_1,hi_hi,hi_lo,lo_hi,lo_lo,1'h0}; // @[Cat.scala 30:58]
  wire [7:0] hi_lo_2 = io_instruction[19:12]; // @[ImmediateGen.scala 50:21]
  wire  lo_hi_1 = io_instruction[20]; // @[ImmediateGen.scala 51:21]
  wire [9:0] lo_lo_1 = io_instruction[30:21]; // @[ImmediateGen.scala 52:21]
  wire [19:0] hi_lo_3 = {hi_hi,hi_lo_2,lo_hi_1,lo_lo_1}; // @[Cat.scala 30:58]
  wire [10:0] hi_hi_3 = hi_lo_3[19] ? 11'h7ff : 11'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_28 = {hi_hi_3,hi_hi,hi_lo_2,lo_hi_1,lo_lo_1,1'h0}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_0 = opcode == 7'h63 ? _T_25 : _T_28; // @[ImmediateGen.scala 35:32 ImmediateGen.scala 43:14 ImmediateGen.scala 55:12]
  wire [31:0] _GEN_1 = opcode == 7'h23 ? _T_21 : _GEN_0; // @[ImmediateGen.scala 29:32 ImmediateGen.scala 32:14]
  wire [31:0] _GEN_2 = opcode == 7'h17 | opcode == 7'h37 ? _T_17 : _GEN_1; // @[ImmediateGen.scala 23:51 ImmediateGen.scala 26:14]
  assign io_out = _T_10 ? _T_13 : _GEN_2; // @[ImmediateGen.scala 16:5 ImmediateGen.scala 19:12]
endmodule
module BranchUnit(
  input         io_branch,
  input  [2:0]  io_funct3,
  input  [31:0] io_rd1,
  input  [31:0] io_rd2,
  input         io_take_branch,
  output        io_taken
);
  wire  _T = 3'h0 == io_funct3; // @[Conditional.scala 37:30]
  wire  _T_2 = 3'h1 == io_funct3; // @[Conditional.scala 37:30]
  wire  _T_4 = 3'h4 == io_funct3; // @[Conditional.scala 37:30]
  wire  _T_8 = 3'h5 == io_funct3; // @[Conditional.scala 37:30]
  wire  _T_12 = 3'h6 == io_funct3; // @[Conditional.scala 37:30]
  wire  _T_15 = io_rd1 >= io_rd2; // @[BranchUnit.scala 28:32]
  wire  _GEN_1 = _T_12 ? io_rd1 < io_rd2 : _T_15; // @[Conditional.scala 39:67 BranchUnit.scala 27:21]
  wire  _GEN_2 = _T_8 ? $signed(io_rd1) >= $signed(io_rd2) : _GEN_1; // @[Conditional.scala 39:67 BranchUnit.scala 26:21]
  wire  _GEN_3 = _T_4 ? $signed(io_rd1) < $signed(io_rd2) : _GEN_2; // @[Conditional.scala 39:67 BranchUnit.scala 25:21]
  wire  _GEN_4 = _T_2 ? io_rd1 != io_rd2 : _GEN_3; // @[Conditional.scala 39:67 BranchUnit.scala 24:21]
  wire  check = _T ? io_rd1 == io_rd2 : _GEN_4; // @[Conditional.scala 40:58 BranchUnit.scala 23:21]
  assign io_taken = check & io_branch & io_take_branch; // @[BranchUnit.scala 31:33]
endmodule
module InstructionDecode(
  input         clock,
  input         reset,
  input  [31:0] io_id_instruction,
  input  [31:0] io_writeData,
  input  [4:0]  io_writeReg,
  input  [31:0] io_pcAddress,
  input         io_ctl_writeEnable,
  input         io_id_ex_mem_read,
  input         io_ex_mem_mem_read,
  input  [4:0]  io_id_ex_rd,
  input  [4:0]  io_ex_mem_rd,
  input         io_id_ex_branch,
  input  [31:0] io_ex_mem_ins,
  input  [31:0] io_mem_wb_ins,
  input  [31:0] io_ex_ins,
  input  [31:0] io_ex_result,
  input  [31:0] io_ex_mem_result,
  input  [31:0] io_mem_wb_result,
  output [31:0] io_immediate,
  output [4:0]  io_writeRegAddress,
  output [31:0] io_readData1,
  output [31:0] io_readData2,
  output [6:0]  io_func7,
  output [2:0]  io_func3,
  output        io_ctl_aluSrc,
  output [1:0]  io_ctl_memToReg,
  output        io_ctl_regWrite,
  output        io_ctl_memRead,
  output        io_ctl_memWrite,
  output        io_ctl_branch,
  output [1:0]  io_ctl_aluOp,
  output [1:0]  io_ctl_jump,
  output [1:0]  io_ctl_aluSrc1,
  output        io_hdu_pcWrite,
  output        io_hdu_if_reg_write,
  output        io_pcSrc,
  output [31:0] io_pcPlusOffset,
  output        io_ifid_flush
);
  wire  hdu_io_id_ex_memRead; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_ex_mem_memRead; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_id_ex_branch; // @[InstructionDecode.scala 51:19]
  wire [4:0] hdu_io_id_ex_rd; // @[InstructionDecode.scala 51:19]
  wire [4:0] hdu_io_ex_mem_rd; // @[InstructionDecode.scala 51:19]
  wire [4:0] hdu_io_id_rs1; // @[InstructionDecode.scala 51:19]
  wire [4:0] hdu_io_id_rs2; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_taken; // @[InstructionDecode.scala 51:19]
  wire [1:0] hdu_io_jump; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_branch; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_if_reg_write; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_pc_write; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_ctl_mux; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_ifid_flush; // @[InstructionDecode.scala 51:19]
  wire  hdu_io_take_branch; // @[InstructionDecode.scala 51:19]
  wire [31:0] control_io_in; // @[InstructionDecode.scala 67:23]
  wire  control_io_aluSrc; // @[InstructionDecode.scala 67:23]
  wire [1:0] control_io_memToReg; // @[InstructionDecode.scala 67:23]
  wire  control_io_regWrite; // @[InstructionDecode.scala 67:23]
  wire  control_io_memRead; // @[InstructionDecode.scala 67:23]
  wire  control_io_memWrite; // @[InstructionDecode.scala 67:23]
  wire  control_io_branch; // @[InstructionDecode.scala 67:23]
  wire [1:0] control_io_aluOp; // @[InstructionDecode.scala 67:23]
  wire [1:0] control_io_jump; // @[InstructionDecode.scala 67:23]
  wire [1:0] control_io_aluSrc1; // @[InstructionDecode.scala 67:23]
  wire  registers_clock; // @[InstructionDecode.scala 86:25]
  wire  registers_reset; // @[InstructionDecode.scala 86:25]
  wire [4:0] registers_io_readAddress_0; // @[InstructionDecode.scala 86:25]
  wire [4:0] registers_io_readAddress_1; // @[InstructionDecode.scala 86:25]
  wire  registers_io_writeEnable; // @[InstructionDecode.scala 86:25]
  wire [4:0] registers_io_writeAddress; // @[InstructionDecode.scala 86:25]
  wire [31:0] registers_io_writeData; // @[InstructionDecode.scala 86:25]
  wire [31:0] registers_io_readData_0; // @[InstructionDecode.scala 86:25]
  wire [31:0] registers_io_readData_1; // @[InstructionDecode.scala 86:25]
  wire [31:0] immediate_io_instruction; // @[InstructionDecode.scala 117:25]
  wire [31:0] immediate_io_out; // @[InstructionDecode.scala 117:25]
  wire  bu_io_branch; // @[InstructionDecode.scala 143:18]
  wire [2:0] bu_io_funct3; // @[InstructionDecode.scala 143:18]
  wire [31:0] bu_io_rd1; // @[InstructionDecode.scala 143:18]
  wire [31:0] bu_io_rd2; // @[InstructionDecode.scala 143:18]
  wire  bu_io_take_branch; // @[InstructionDecode.scala 143:18]
  wire  bu_io_taken; // @[InstructionDecode.scala 143:18]
  wire [31:0] _GEN_2 = io_id_instruction[19:15] == 5'h0 ? 32'h0 : io_writeData; // @[InstructionDecode.scala 98:30 InstructionDecode.scala 99:20 InstructionDecode.scala 101:20]
  wire [31:0] _GEN_4 = io_id_instruction[24:20] == 5'h0 ? 32'h0 : io_writeData; // @[InstructionDecode.scala 107:30 InstructionDecode.scala 108:20 InstructionDecode.scala 110:20]
  wire  _T_11 = io_id_instruction[19:15] == io_ex_mem_ins[11:7]; // @[InstructionDecode.scala 125:20]
  wire  _T_13 = io_id_instruction[19:15] == io_mem_wb_ins[11:7]; // @[InstructionDecode.scala 127:26]
  wire [31:0] _GEN_6 = io_id_instruction[19:15] == io_mem_wb_ins[11:7] ? io_mem_wb_result : io_readData1; // @[InstructionDecode.scala 127:52 InstructionDecode.scala 128:14 InstructionDecode.scala 131:14]
  wire [31:0] _GEN_8 = io_id_instruction[24:20] == io_mem_wb_ins[11:7] ? io_mem_wb_result : io_readData2; // @[InstructionDecode.scala 135:52 InstructionDecode.scala 136:14 InstructionDecode.scala 139:14]
  wire  _T_20 = io_id_instruction[19:15] == io_ex_ins[11:7]; // @[InstructionDecode.scala 153:22]
  wire [31:0] _GEN_10 = _T_20 ? io_ex_result : io_readData1; // @[InstructionDecode.scala 159:47 InstructionDecode.scala 160:14 InstructionDecode.scala 162:16]
  wire [31:0] _GEN_11 = _T_13 ? io_mem_wb_result : _GEN_10; // @[InstructionDecode.scala 157:52 InstructionDecode.scala 158:14]
  wire [31:0] _GEN_12 = _T_11 ? io_ex_mem_result : _GEN_11; // @[InstructionDecode.scala 155:54 InstructionDecode.scala 156:14]
  wire [31:0] j_offset = io_id_instruction[19:15] == io_ex_ins[11:7] ? io_ex_result : _GEN_12; // @[InstructionDecode.scala 153:43 InstructionDecode.scala 154:16]
  wire [31:0] _T_29 = io_pcAddress + io_immediate; // @[InstructionDecode.scala 167:37]
  wire [31:0] _T_32 = j_offset + io_immediate; // @[InstructionDecode.scala 169:35]
  wire [31:0] _T_34 = io_pcAddress + immediate_io_out; // @[InstructionDecode.scala 172:39]
  wire [31:0] _GEN_14 = io_ctl_jump == 2'h2 ? _T_32 : _T_34; // @[InstructionDecode.scala 168:35 InstructionDecode.scala 169:23 InstructionDecode.scala 172:23]
  HazardUnit hdu ( // @[InstructionDecode.scala 51:19]
    .io_id_ex_memRead(hdu_io_id_ex_memRead),
    .io_ex_mem_memRead(hdu_io_ex_mem_memRead),
    .io_id_ex_branch(hdu_io_id_ex_branch),
    .io_id_ex_rd(hdu_io_id_ex_rd),
    .io_ex_mem_rd(hdu_io_ex_mem_rd),
    .io_id_rs1(hdu_io_id_rs1),
    .io_id_rs2(hdu_io_id_rs2),
    .io_taken(hdu_io_taken),
    .io_jump(hdu_io_jump),
    .io_branch(hdu_io_branch),
    .io_if_reg_write(hdu_io_if_reg_write),
    .io_pc_write(hdu_io_pc_write),
    .io_ctl_mux(hdu_io_ctl_mux),
    .io_ifid_flush(hdu_io_ifid_flush),
    .io_take_branch(hdu_io_take_branch)
  );
  Control control ( // @[InstructionDecode.scala 67:23]
    .io_in(control_io_in),
    .io_aluSrc(control_io_aluSrc),
    .io_memToReg(control_io_memToReg),
    .io_regWrite(control_io_regWrite),
    .io_memRead(control_io_memRead),
    .io_memWrite(control_io_memWrite),
    .io_branch(control_io_branch),
    .io_aluOp(control_io_aluOp),
    .io_jump(control_io_jump),
    .io_aluSrc1(control_io_aluSrc1)
  );
  Registers registers ( // @[InstructionDecode.scala 86:25]
    .clock(registers_clock),
    .reset(registers_reset),
    .io_readAddress_0(registers_io_readAddress_0),
    .io_readAddress_1(registers_io_readAddress_1),
    .io_writeEnable(registers_io_writeEnable),
    .io_writeAddress(registers_io_writeAddress),
    .io_writeData(registers_io_writeData),
    .io_readData_0(registers_io_readData_0),
    .io_readData_1(registers_io_readData_1)
  );
  ImmediateGen immediate ( // @[InstructionDecode.scala 117:25]
    .io_instruction(immediate_io_instruction),
    .io_out(immediate_io_out)
  );
  BranchUnit bu ( // @[InstructionDecode.scala 143:18]
    .io_branch(bu_io_branch),
    .io_funct3(bu_io_funct3),
    .io_rd1(bu_io_rd1),
    .io_rd2(bu_io_rd2),
    .io_take_branch(bu_io_take_branch),
    .io_taken(bu_io_taken)
  );
  assign io_immediate = immediate_io_out; // @[InstructionDecode.scala 119:16]
  assign io_writeRegAddress = io_id_instruction[11:7]; // @[InstructionDecode.scala 184:42]
  assign io_readData1 = io_ctl_writeEnable & io_writeReg == io_id_instruction[19:15] ? _GEN_2 : registers_io_readData_0; // @[InstructionDecode.scala 97:60 InstructionDecode.scala 104:18]
  assign io_readData2 = io_ctl_writeEnable & io_writeReg == io_id_instruction[24:20] ? _GEN_4 : registers_io_readData_1; // @[InstructionDecode.scala 106:60 InstructionDecode.scala 113:18]
  assign io_func7 = io_id_instruction[31:25]; // @[InstructionDecode.scala 186:32]
  assign io_func3 = io_id_instruction[14:12]; // @[InstructionDecode.scala 185:32]
  assign io_ctl_aluSrc = control_io_aluSrc; // @[InstructionDecode.scala 70:17]
  assign io_ctl_memToReg = control_io_memToReg; // @[InstructionDecode.scala 74:19]
  assign io_ctl_regWrite = hdu_io_ctl_mux & io_id_instruction != 32'h13 & control_io_regWrite; // @[InstructionDecode.scala 76:57 InstructionDecode.scala 78:21 InstructionDecode.scala 82:21]
  assign io_ctl_memRead = control_io_memRead; // @[InstructionDecode.scala 73:18]
  assign io_ctl_memWrite = hdu_io_ctl_mux & io_id_instruction != 32'h13 & control_io_memWrite; // @[InstructionDecode.scala 76:57 InstructionDecode.scala 77:21 InstructionDecode.scala 81:21]
  assign io_ctl_branch = control_io_branch; // @[InstructionDecode.scala 72:17]
  assign io_ctl_aluOp = control_io_aluOp; // @[InstructionDecode.scala 69:16]
  assign io_ctl_jump = control_io_jump; // @[InstructionDecode.scala 75:15]
  assign io_ctl_aluSrc1 = control_io_aluSrc1; // @[InstructionDecode.scala 71:18]
  assign io_hdu_pcWrite = hdu_io_pc_write; // @[InstructionDecode.scala 63:18]
  assign io_hdu_if_reg_write = hdu_io_if_reg_write; // @[InstructionDecode.scala 64:23]
  assign io_pcSrc = bu_io_taken | io_ctl_jump != 2'h0; // @[InstructionDecode.scala 175:20]
  assign io_pcPlusOffset = io_ctl_jump == 2'h1 ? _T_29 : _GEN_14; // @[InstructionDecode.scala 166:29 InstructionDecode.scala 167:21]
  assign io_ifid_flush = hdu_io_ifid_flush; // @[InstructionDecode.scala 182:17]
  assign hdu_io_id_ex_memRead = io_id_ex_mem_read; // @[InstructionDecode.scala 53:24]
  assign hdu_io_ex_mem_memRead = io_ex_mem_mem_read; // @[InstructionDecode.scala 55:25]
  assign hdu_io_id_ex_branch = io_id_ex_branch; // @[InstructionDecode.scala 57:23]
  assign hdu_io_id_ex_rd = io_id_ex_rd; // @[InstructionDecode.scala 56:19]
  assign hdu_io_ex_mem_rd = io_ex_mem_rd; // @[InstructionDecode.scala 58:20]
  assign hdu_io_id_rs1 = io_id_instruction[19:15]; // @[InstructionDecode.scala 59:37]
  assign hdu_io_id_rs2 = io_id_instruction[24:20]; // @[InstructionDecode.scala 60:37]
  assign hdu_io_taken = bu_io_taken; // @[InstructionDecode.scala 149:16]
  assign hdu_io_jump = io_ctl_jump; // @[InstructionDecode.scala 61:15]
  assign hdu_io_branch = io_ctl_branch; // @[InstructionDecode.scala 62:17]
  assign control_io_in = io_id_instruction; // @[InstructionDecode.scala 68:17]
  assign registers_clock = clock;
  assign registers_reset = reset;
  assign registers_io_readAddress_0 = io_id_instruction[19:15]; // @[InstructionDecode.scala 88:38]
  assign registers_io_readAddress_1 = io_id_instruction[24:20]; // @[InstructionDecode.scala 89:38]
  assign registers_io_writeEnable = io_ctl_writeEnable; // @[InstructionDecode.scala 92:28]
  assign registers_io_writeAddress = io_writeReg; // @[InstructionDecode.scala 93:29]
  assign registers_io_writeData = io_writeData; // @[InstructionDecode.scala 94:26]
  assign immediate_io_instruction = io_id_instruction; // @[InstructionDecode.scala 118:28]
  assign bu_io_branch = io_ctl_branch; // @[InstructionDecode.scala 144:16]
  assign bu_io_funct3 = io_id_instruction[14:12]; // @[InstructionDecode.scala 145:36]
  assign bu_io_rd1 = io_id_instruction[19:15] == io_ex_mem_ins[11:7] ? io_ex_mem_result : _GEN_6; // @[InstructionDecode.scala 125:46 InstructionDecode.scala 126:12]
  assign bu_io_rd2 = io_id_instruction[24:20] == io_ex_mem_ins[11:7] ? io_ex_mem_result : _GEN_8; // @[InstructionDecode.scala 133:46 InstructionDecode.scala 134:12]
  assign bu_io_take_branch = hdu_io_take_branch; // @[InstructionDecode.scala 148:21]
endmodule
module ALU(
  input  [31:0] io_input1,
  input  [31:0] io_input2,
  input  [3:0]  io_aluCtl,
  output [31:0] io_result
);
  wire  _T = io_aluCtl == 4'h0; // @[ALU.scala 17:18]
  wire [31:0] _T_1 = io_input1 & io_input2; // @[ALU.scala 17:41]
  wire  _T_2 = io_aluCtl == 4'h1; // @[ALU.scala 18:18]
  wire [31:0] _T_3 = io_input1 | io_input2; // @[ALU.scala 18:41]
  wire  _T_4 = io_aluCtl == 4'h2; // @[ALU.scala 19:18]
  wire [31:0] _T_6 = io_input1 + io_input2; // @[ALU.scala 19:41]
  wire  _T_7 = io_aluCtl == 4'h3; // @[ALU.scala 20:18]
  wire [31:0] _T_9 = io_input1 - io_input2; // @[ALU.scala 20:41]
  wire  _T_10 = io_aluCtl == 4'h4; // @[ALU.scala 21:18]
  wire  _T_13 = $signed(io_input1) < $signed(io_input2); // @[ALU.scala 21:48]
  wire  _T_14 = io_aluCtl == 4'h5; // @[ALU.scala 22:18]
  wire  _T_15 = io_input1 < io_input2; // @[ALU.scala 22:41]
  wire  _T_16 = io_aluCtl == 4'h6; // @[ALU.scala 23:18]
  wire [62:0] _GEN_0 = {{31'd0}, io_input1}; // @[ALU.scala 23:41]
  wire [62:0] _T_18 = _GEN_0 << io_input2[4:0]; // @[ALU.scala 23:41]
  wire  _T_19 = io_aluCtl == 4'h7; // @[ALU.scala 24:18]
  wire [31:0] _T_21 = io_input1 >> io_input2[4:0]; // @[ALU.scala 24:41]
  wire  _T_22 = io_aluCtl == 4'h8; // @[ALU.scala 25:18]
  wire [31:0] _T_26 = $signed(io_input1) >>> io_input2[4:0]; // @[ALU.scala 25:68]
  wire  _T_27 = io_aluCtl == 4'h9; // @[ALU.scala 26:18]
  wire [31:0] _T_28 = io_input1 ^ io_input2; // @[ALU.scala 26:41]
  wire [31:0] _T_29 = _T_27 ? _T_28 : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _T_30 = _T_22 ? _T_26 : _T_29; // @[Mux.scala 98:16]
  wire [31:0] _T_31 = _T_19 ? _T_21 : _T_30; // @[Mux.scala 98:16]
  wire [62:0] _T_32 = _T_16 ? _T_18 : {{31'd0}, _T_31}; // @[Mux.scala 98:16]
  wire [62:0] _T_33 = _T_14 ? {{62'd0}, _T_15} : _T_32; // @[Mux.scala 98:16]
  wire [62:0] _T_34 = _T_10 ? {{62'd0}, _T_13} : _T_33; // @[Mux.scala 98:16]
  wire [62:0] _T_35 = _T_7 ? {{31'd0}, _T_9} : _T_34; // @[Mux.scala 98:16]
  wire [62:0] _T_36 = _T_4 ? {{31'd0}, _T_6} : _T_35; // @[Mux.scala 98:16]
  wire [62:0] _T_37 = _T_2 ? {{31'd0}, _T_3} : _T_36; // @[Mux.scala 98:16]
  wire [62:0] _T_38 = _T ? {{31'd0}, _T_1} : _T_37; // @[Mux.scala 98:16]
  assign io_result = _T_38[31:0]; // @[ALU.scala 14:13]
endmodule
module AluControl(
  input  [1:0] io_aluOp,
  input        io_f7,
  input  [2:0] io_f3,
  input        io_aluSrc,
  output [3:0] io_out
);
  wire  _T_1 = 3'h0 == io_f3; // @[Conditional.scala 37:30]
  wire  _T_3 = ~io_f7; // @[AluControl.scala 38:34]
  wire [1:0] _GEN_0 = ~io_aluSrc | ~io_f7 ? 2'h2 : 2'h3; // @[AluControl.scala 38:43 AluControl.scala 39:18 AluControl.scala 42:20]
  wire  _T_5 = 3'h1 == io_f3; // @[Conditional.scala 37:30]
  wire  _T_6 = 3'h2 == io_f3; // @[Conditional.scala 37:30]
  wire  _T_7 = 3'h3 == io_f3; // @[Conditional.scala 37:30]
  wire  _T_8 = 3'h5 == io_f3; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_1 = _T_3 ? 4'h7 : 4'h8; // @[AluControl.scala 55:29 AluControl.scala 56:18 AluControl.scala 58:18]
  wire  _T_10 = 3'h7 == io_f3; // @[Conditional.scala 37:30]
  wire  _T_11 = 3'h6 == io_f3; // @[Conditional.scala 37:30]
  wire  _T_12 = 3'h4 == io_f3; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_2 = _T_12 ? 4'h9 : 4'hf; // @[Conditional.scala 39:67 AluControl.scala 68:16 AluControl.scala 31:10]
  wire [3:0] _GEN_3 = _T_11 ? 4'h1 : _GEN_2; // @[Conditional.scala 39:67 AluControl.scala 65:16]
  wire [3:0] _GEN_4 = _T_10 ? 4'h0 : _GEN_3; // @[Conditional.scala 39:67 AluControl.scala 62:16]
  wire [3:0] _GEN_5 = _T_8 ? _GEN_1 : _GEN_4; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_6 = _T_7 ? 4'h5 : _GEN_5; // @[Conditional.scala 39:67 AluControl.scala 52:16]
  wire [3:0] _GEN_7 = _T_6 ? 4'h4 : _GEN_6; // @[Conditional.scala 39:67 AluControl.scala 49:16]
  wire [3:0] _GEN_8 = _T_5 ? 4'h6 : _GEN_7; // @[Conditional.scala 39:67 AluControl.scala 46:16]
  wire [3:0] _GEN_9 = _T_1 ? {{2'd0}, _GEN_0} : _GEN_8; // @[Conditional.scala 40:58]
  assign io_out = io_aluOp == 2'h0 ? 4'h2 : _GEN_9; // @[AluControl.scala 33:26 AluControl.scala 34:12]
endmodule
module ForwardingUnit(
  input  [4:0] io_ex_reg_rd,
  input  [4:0] io_mem_reg_rd,
  input  [4:0] io_reg_rs1,
  input  [4:0] io_reg_rs2,
  input        io_ex_regWrite,
  input        io_mem_regWrite,
  output [1:0] io_forwardA,
  output [1:0] io_forwardB
);
  wire  _T_1 = io_ex_reg_rd != 5'h0; // @[ForwardingUnit.scala 21:52]
  wire  _T_5 = io_mem_reg_rd != 5'h0; // @[ForwardingUnit.scala 24:53]
  wire  _T_7 = io_reg_rs1 == io_mem_reg_rd & io_mem_reg_rd != 5'h0 & io_mem_regWrite; // @[ForwardingUnit.scala 24:61]
  wire [1:0] _GEN_0 = _T_7 ? 2'h2 : 2'h0; // @[ForwardingUnit.scala 25:7 ForwardingUnit.scala 26:19 ForwardingUnit.scala 29:19]
  wire  _T_15 = io_reg_rs2 == io_mem_reg_rd & _T_5 & io_mem_regWrite; // @[ForwardingUnit.scala 35:61]
  wire [1:0] _GEN_2 = _T_15 ? 2'h2 : 2'h0; // @[ForwardingUnit.scala 36:7 ForwardingUnit.scala 37:19 ForwardingUnit.scala 40:19]
  assign io_forwardA = io_reg_rs1 == io_ex_reg_rd & io_ex_reg_rd != 5'h0 & io_ex_regWrite ? 2'h1 : _GEN_0; // @[ForwardingUnit.scala 21:79 ForwardingUnit.scala 22:17]
  assign io_forwardB = io_reg_rs2 == io_ex_reg_rd & _T_1 & io_ex_regWrite ? 2'h1 : _GEN_2; // @[ForwardingUnit.scala 32:79 ForwardingUnit.scala 33:17]
endmodule
module Execute(
  input  [31:0] io_immediate,
  input  [31:0] io_readData1,
  input  [31:0] io_readData2,
  input  [31:0] io_pcAddress,
  input  [6:0]  io_func7,
  input  [2:0]  io_func3,
  input  [31:0] io_mem_result,
  input  [31:0] io_wb_result,
  input         io_ex_mem_regWrite,
  input         io_mem_wb_regWrite,
  input  [31:0] io_id_ex_ins,
  input  [31:0] io_ex_mem_ins,
  input  [31:0] io_mem_wb_ins,
  input         io_ctl_aluSrc,
  input  [1:0]  io_ctl_aluOp,
  input  [1:0]  io_ctl_aluSrc1,
  output [31:0] io_writeData,
  output [31:0] io_ALUresult
);
  wire [31:0] alu_io_input1; // @[Execute.scala 31:19]
  wire [31:0] alu_io_input2; // @[Execute.scala 31:19]
  wire [3:0] alu_io_aluCtl; // @[Execute.scala 31:19]
  wire [31:0] alu_io_result; // @[Execute.scala 31:19]
  wire [1:0] aluCtl_io_aluOp; // @[Execute.scala 32:22]
  wire  aluCtl_io_f7; // @[Execute.scala 32:22]
  wire [2:0] aluCtl_io_f3; // @[Execute.scala 32:22]
  wire  aluCtl_io_aluSrc; // @[Execute.scala 32:22]
  wire [3:0] aluCtl_io_out; // @[Execute.scala 32:22]
  wire [4:0] ForwardingUnit_io_ex_reg_rd; // @[Execute.scala 33:18]
  wire [4:0] ForwardingUnit_io_mem_reg_rd; // @[Execute.scala 33:18]
  wire [4:0] ForwardingUnit_io_reg_rs1; // @[Execute.scala 33:18]
  wire [4:0] ForwardingUnit_io_reg_rs2; // @[Execute.scala 33:18]
  wire  ForwardingUnit_io_ex_regWrite; // @[Execute.scala 33:18]
  wire  ForwardingUnit_io_mem_regWrite; // @[Execute.scala 33:18]
  wire [1:0] ForwardingUnit_io_forwardA; // @[Execute.scala 33:18]
  wire [1:0] ForwardingUnit_io_forwardB; // @[Execute.scala 33:18]
  wire  _T_4 = ForwardingUnit_io_forwardA == 2'h0; // @[Execute.scala 47:20]
  wire  _T_5 = ForwardingUnit_io_forwardA == 2'h1; // @[Execute.scala 48:20]
  wire  _T_6 = ForwardingUnit_io_forwardA == 2'h2; // @[Execute.scala 49:20]
  wire [31:0] _T_7 = _T_6 ? io_wb_result : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _T_8 = _T_5 ? io_mem_result : _T_7; // @[Mux.scala 98:16]
  wire [31:0] inputMux1 = _T_4 ? io_readData1 : _T_8; // @[Mux.scala 98:16]
  wire  _T_9 = ForwardingUnit_io_forwardB == 2'h0; // @[Execute.scala 55:20]
  wire  _T_10 = ForwardingUnit_io_forwardB == 2'h1; // @[Execute.scala 56:20]
  wire  _T_11 = ForwardingUnit_io_forwardB == 2'h2; // @[Execute.scala 57:20]
  wire [31:0] _T_12 = _T_11 ? io_wb_result : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _T_13 = _T_10 ? io_mem_result : _T_12; // @[Mux.scala 98:16]
  wire [31:0] inputMux2 = _T_9 ? io_readData2 : _T_13; // @[Mux.scala 98:16]
  wire  _T_14 = io_ctl_aluSrc1 == 2'h1; // @[Execute.scala 64:23]
  wire  _T_15 = io_ctl_aluSrc1 == 2'h2; // @[Execute.scala 65:23]
  wire [31:0] _T_16 = _T_15 ? 32'h0 : inputMux1; // @[Mux.scala 98:16]
  ALU alu ( // @[Execute.scala 31:19]
    .io_input1(alu_io_input1),
    .io_input2(alu_io_input2),
    .io_aluCtl(alu_io_aluCtl),
    .io_result(alu_io_result)
  );
  AluControl aluCtl ( // @[Execute.scala 32:22]
    .io_aluOp(aluCtl_io_aluOp),
    .io_f7(aluCtl_io_f7),
    .io_f3(aluCtl_io_f3),
    .io_aluSrc(aluCtl_io_aluSrc),
    .io_out(aluCtl_io_out)
  );
  ForwardingUnit ForwardingUnit ( // @[Execute.scala 33:18]
    .io_ex_reg_rd(ForwardingUnit_io_ex_reg_rd),
    .io_mem_reg_rd(ForwardingUnit_io_mem_reg_rd),
    .io_reg_rs1(ForwardingUnit_io_reg_rs1),
    .io_reg_rs2(ForwardingUnit_io_reg_rs2),
    .io_ex_regWrite(ForwardingUnit_io_ex_regWrite),
    .io_mem_regWrite(ForwardingUnit_io_mem_regWrite),
    .io_forwardA(ForwardingUnit_io_forwardA),
    .io_forwardB(ForwardingUnit_io_forwardB)
  );
  assign io_writeData = _T_9 ? io_readData2 : _T_13; // @[Mux.scala 98:16]
  assign io_ALUresult = alu_io_result; // @[Execute.scala 95:22]
  assign alu_io_input1 = _T_14 ? io_pcAddress : _T_16; // @[Mux.scala 98:16]
  assign alu_io_input2 = io_ctl_aluSrc ? inputMux2 : io_immediate; // @[Execute.scala 68:19]
  assign alu_io_aluCtl = aluCtl_io_out; // @[Execute.scala 77:17]
  assign aluCtl_io_aluOp = io_ctl_aluOp; // @[Execute.scala 72:19]
  assign aluCtl_io_f7 = io_func7[5]; // @[Execute.scala 71:27]
  assign aluCtl_io_f3 = io_func3; // @[Execute.scala 70:16]
  assign aluCtl_io_aluSrc = io_ctl_aluSrc; // @[Execute.scala 73:20]
  assign ForwardingUnit_io_ex_reg_rd = io_ex_mem_ins[11:7]; // @[Execute.scala 39:32]
  assign ForwardingUnit_io_mem_reg_rd = io_mem_wb_ins[11:7]; // @[Execute.scala 40:33]
  assign ForwardingUnit_io_reg_rs1 = io_id_ex_ins[19:15]; // @[Execute.scala 41:29]
  assign ForwardingUnit_io_reg_rs2 = io_id_ex_ins[24:20]; // @[Execute.scala 42:29]
  assign ForwardingUnit_io_ex_regWrite = io_ex_mem_regWrite; // @[Execute.scala 37:18]
  assign ForwardingUnit_io_mem_regWrite = io_mem_wb_regWrite; // @[Execute.scala 38:19]
endmodule
module MemoryFetch(
  input         clock,
  input         reset,
  input  [31:0] io_aluResultIn,
  input  [31:0] io_writeData,
  input         io_writeEnable,
  input         io_readEnable,
  output [31:0] io_readData,
  output        io_stall,
  output        io_dccmReq_valid,
  output [31:0] io_dccmReq_bits_addrRequest,
  output [31:0] io_dccmReq_bits_dataRequest,
  output        io_dccmReq_bits_isWrite,
  input         io_dccmRsp_valid,
  input  [31:0] io_dccmRsp_bits_dataResponse
);
  wire  _T = io_writeEnable | io_readEnable; // @[MemoryFetch.scala 33:42]
  wire  _T_8 = io_writeEnable & io_aluResultIn[31:28] == 4'h8; // @[MemoryFetch.scala 42:23]
  assign io_readData = io_dccmRsp_valid ? io_dccmRsp_bits_dataResponse : 32'h0; // @[MemoryFetch.scala 40:21]
  assign io_stall = _T & ~io_dccmRsp_valid; // @[MemoryFetch.scala 35:49]
  assign io_dccmReq_valid = io_writeEnable | io_readEnable; // @[MemoryFetch.scala 33:42]
  assign io_dccmReq_bits_addrRequest = io_aluResultIn; // @[MemoryFetch.scala 31:31]
  assign io_dccmReq_bits_dataRequest = io_writeData; // @[MemoryFetch.scala 30:31]
  assign io_dccmReq_bits_isWrite = io_writeEnable; // @[MemoryFetch.scala 32:27]
  always @(posedge clock) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_8 & ~reset) begin
          $fwrite(32'h80000002,"%x\n",io_writeData); // @[MemoryFetch.scala 43:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module PC(
  input         clock,
  input         reset,
  input  [31:0] io_in,
  input         io_halt,
  output [31:0] io_out,
  output [31:0] io_pc4
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pc_reg; // @[PC.scala 12:23]
  wire [31:0] _T_2 = $signed(pc_reg) + 32'sh4; // @[PC.scala 15:41]
  assign io_out = pc_reg; // @[PC.scala 14:10]
  assign io_pc4 = io_halt ? $signed(pc_reg) : $signed(_T_2); // @[PC.scala 15:16]
  always @(posedge clock) begin
    if (reset) begin // @[PC.scala 12:23]
      pc_reg <= -32'sh4; // @[PC.scala 12:23]
    end else begin
      pc_reg <= io_in; // @[PC.scala 13:10]
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
  pc_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Core(
  input         clock,
  input         reset,
  output        io_dmemReq_valid,
  output [31:0] io_dmemReq_bits_addrRequest,
  output [31:0] io_dmemReq_bits_dataRequest,
  output        io_dmemReq_bits_isWrite,
  input         io_dmemRsp_valid,
  input  [31:0] io_dmemRsp_bits_dataResponse,
  input         io_imemReq_ready,
  output        io_imemReq_valid,
  output [31:0] io_imemReq_bits_addrRequest,
  input         io_imemRsp_valid,
  input  [31:0] io_imemRsp_bits_dataResponse
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
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] InstructionFetch_io_address; // @[Core.scala 70:18]
  wire [31:0] InstructionFetch_io_instruction; // @[Core.scala 70:18]
  wire  InstructionFetch_io_coreInstrReq_ready; // @[Core.scala 70:18]
  wire  InstructionFetch_io_coreInstrReq_valid; // @[Core.scala 70:18]
  wire [31:0] InstructionFetch_io_coreInstrReq_bits_addrRequest; // @[Core.scala 70:18]
  wire  InstructionFetch_io_coreInstrResp_valid; // @[Core.scala 70:18]
  wire [31:0] InstructionFetch_io_coreInstrResp_bits_dataResponse; // @[Core.scala 70:18]
  wire  InstructionDecode_clock; // @[Core.scala 71:18]
  wire  InstructionDecode_reset; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_id_instruction; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_writeData; // @[Core.scala 71:18]
  wire [4:0] InstructionDecode_io_writeReg; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_pcAddress; // @[Core.scala 71:18]
  wire  InstructionDecode_io_ctl_writeEnable; // @[Core.scala 71:18]
  wire  InstructionDecode_io_id_ex_mem_read; // @[Core.scala 71:18]
  wire  InstructionDecode_io_ex_mem_mem_read; // @[Core.scala 71:18]
  wire [4:0] InstructionDecode_io_id_ex_rd; // @[Core.scala 71:18]
  wire [4:0] InstructionDecode_io_ex_mem_rd; // @[Core.scala 71:18]
  wire  InstructionDecode_io_id_ex_branch; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_ex_mem_ins; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_mem_wb_ins; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_ex_ins; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_ex_result; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_ex_mem_result; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_mem_wb_result; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_immediate; // @[Core.scala 71:18]
  wire [4:0] InstructionDecode_io_writeRegAddress; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_readData1; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_readData2; // @[Core.scala 71:18]
  wire [6:0] InstructionDecode_io_func7; // @[Core.scala 71:18]
  wire [2:0] InstructionDecode_io_func3; // @[Core.scala 71:18]
  wire  InstructionDecode_io_ctl_aluSrc; // @[Core.scala 71:18]
  wire [1:0] InstructionDecode_io_ctl_memToReg; // @[Core.scala 71:18]
  wire  InstructionDecode_io_ctl_regWrite; // @[Core.scala 71:18]
  wire  InstructionDecode_io_ctl_memRead; // @[Core.scala 71:18]
  wire  InstructionDecode_io_ctl_memWrite; // @[Core.scala 71:18]
  wire  InstructionDecode_io_ctl_branch; // @[Core.scala 71:18]
  wire [1:0] InstructionDecode_io_ctl_aluOp; // @[Core.scala 71:18]
  wire [1:0] InstructionDecode_io_ctl_jump; // @[Core.scala 71:18]
  wire [1:0] InstructionDecode_io_ctl_aluSrc1; // @[Core.scala 71:18]
  wire  InstructionDecode_io_hdu_pcWrite; // @[Core.scala 71:18]
  wire  InstructionDecode_io_hdu_if_reg_write; // @[Core.scala 71:18]
  wire  InstructionDecode_io_pcSrc; // @[Core.scala 71:18]
  wire [31:0] InstructionDecode_io_pcPlusOffset; // @[Core.scala 71:18]
  wire  InstructionDecode_io_ifid_flush; // @[Core.scala 71:18]
  wire [31:0] Execute_io_immediate; // @[Core.scala 72:18]
  wire [31:0] Execute_io_readData1; // @[Core.scala 72:18]
  wire [31:0] Execute_io_readData2; // @[Core.scala 72:18]
  wire [31:0] Execute_io_pcAddress; // @[Core.scala 72:18]
  wire [6:0] Execute_io_func7; // @[Core.scala 72:18]
  wire [2:0] Execute_io_func3; // @[Core.scala 72:18]
  wire [31:0] Execute_io_mem_result; // @[Core.scala 72:18]
  wire [31:0] Execute_io_wb_result; // @[Core.scala 72:18]
  wire  Execute_io_ex_mem_regWrite; // @[Core.scala 72:18]
  wire  Execute_io_mem_wb_regWrite; // @[Core.scala 72:18]
  wire [31:0] Execute_io_id_ex_ins; // @[Core.scala 72:18]
  wire [31:0] Execute_io_ex_mem_ins; // @[Core.scala 72:18]
  wire [31:0] Execute_io_mem_wb_ins; // @[Core.scala 72:18]
  wire  Execute_io_ctl_aluSrc; // @[Core.scala 72:18]
  wire [1:0] Execute_io_ctl_aluOp; // @[Core.scala 72:18]
  wire [1:0] Execute_io_ctl_aluSrc1; // @[Core.scala 72:18]
  wire [31:0] Execute_io_writeData; // @[Core.scala 72:18]
  wire [31:0] Execute_io_ALUresult; // @[Core.scala 72:18]
  wire  MEM_clock; // @[Core.scala 73:19]
  wire  MEM_reset; // @[Core.scala 73:19]
  wire [31:0] MEM_io_aluResultIn; // @[Core.scala 73:19]
  wire [31:0] MEM_io_writeData; // @[Core.scala 73:19]
  wire  MEM_io_writeEnable; // @[Core.scala 73:19]
  wire  MEM_io_readEnable; // @[Core.scala 73:19]
  wire [31:0] MEM_io_readData; // @[Core.scala 73:19]
  wire  MEM_io_stall; // @[Core.scala 73:19]
  wire  MEM_io_dccmReq_valid; // @[Core.scala 73:19]
  wire [31:0] MEM_io_dccmReq_bits_addrRequest; // @[Core.scala 73:19]
  wire [31:0] MEM_io_dccmReq_bits_dataRequest; // @[Core.scala 73:19]
  wire  MEM_io_dccmReq_bits_isWrite; // @[Core.scala 73:19]
  wire  MEM_io_dccmRsp_valid; // @[Core.scala 73:19]
  wire [31:0] MEM_io_dccmRsp_bits_dataResponse; // @[Core.scala 73:19]
  wire  pc_clock; // @[Core.scala 79:18]
  wire  pc_reset; // @[Core.scala 79:18]
  wire [31:0] pc_io_in; // @[Core.scala 79:18]
  wire  pc_io_halt; // @[Core.scala 79:18]
  wire [31:0] pc_io_out; // @[Core.scala 79:18]
  wire [31:0] pc_io_pc4; // @[Core.scala 79:18]
  reg [31:0] if_reg_pc; // @[Core.scala 23:26]
  reg [31:0] if_reg_ins; // @[Core.scala 24:27]
  reg [31:0] id_reg_pc; // @[Core.scala 27:26]
  reg [31:0] id_reg_rd1; // @[Core.scala 28:27]
  reg [31:0] id_reg_rd2; // @[Core.scala 29:27]
  reg [31:0] id_reg_imm; // @[Core.scala 30:27]
  reg [4:0] id_reg_wra; // @[Core.scala 31:27]
  reg [6:0] id_reg_f7; // @[Core.scala 32:26]
  reg [2:0] id_reg_f3; // @[Core.scala 33:26]
  reg [31:0] id_reg_ins; // @[Core.scala 34:27]
  reg  id_reg_ctl_aluSrc; // @[Core.scala 35:34]
  reg [1:0] id_reg_ctl_aluSrc1; // @[Core.scala 36:35]
  reg [1:0] id_reg_ctl_memToReg; // @[Core.scala 37:36]
  reg  id_reg_ctl_regWrite; // @[Core.scala 38:36]
  reg  id_reg_ctl_memRead; // @[Core.scala 39:35]
  reg  id_reg_ctl_memWrite; // @[Core.scala 40:36]
  reg [1:0] id_reg_ctl_aluOp; // @[Core.scala 42:33]
  reg [31:0] ex_reg_result; // @[Core.scala 48:30]
  reg [31:0] ex_reg_wd; // @[Core.scala 49:26]
  reg [4:0] ex_reg_wra; // @[Core.scala 50:27]
  reg [31:0] ex_reg_ins; // @[Core.scala 51:27]
  reg [1:0] ex_reg_ctl_memToReg; // @[Core.scala 52:36]
  reg  ex_reg_ctl_regWrite; // @[Core.scala 53:36]
  reg  ex_reg_ctl_memRead; // @[Core.scala 54:35]
  reg  ex_reg_ctl_memWrite; // @[Core.scala 55:36]
  reg [31:0] ex_reg_pc; // @[Core.scala 57:26]
  reg [31:0] mem_reg_ins; // @[Core.scala 61:28]
  reg [31:0] mem_reg_result; // @[Core.scala 62:31]
  reg [4:0] mem_reg_wra; // @[Core.scala 64:28]
  reg [1:0] mem_reg_ctl_memToReg; // @[Core.scala 65:37]
  reg  mem_reg_ctl_regWrite; // @[Core.scala 66:37]
  reg [31:0] mem_reg_pc; // @[Core.scala 67:27]
  wire  _T_2 = ~MEM_io_stall; // @[Core.scala 88:37]
  wire [31:0] _T_5 = InstructionDecode_io_pcSrc ? $signed(InstructionDecode_io_pcPlusOffset) : $signed(pc_io_pc4); // @[Core.scala 88:55]
  wire [4:0] _T_16 = io_dmemRsp_valid ? mem_reg_wra : 5'h0; // @[Core.scala 225:19]
  wire [31:0] _GEN_14 = mem_reg_ctl_memToReg == 2'h2 ? mem_reg_pc : mem_reg_result; // @[Core.scala 226:44 Core.scala 227:15 Core.scala 231:15]
  InstructionFetch InstructionFetch ( // @[Core.scala 70:18]
    .io_address(InstructionFetch_io_address),
    .io_instruction(InstructionFetch_io_instruction),
    .io_coreInstrReq_ready(InstructionFetch_io_coreInstrReq_ready),
    .io_coreInstrReq_valid(InstructionFetch_io_coreInstrReq_valid),
    .io_coreInstrReq_bits_addrRequest(InstructionFetch_io_coreInstrReq_bits_addrRequest),
    .io_coreInstrResp_valid(InstructionFetch_io_coreInstrResp_valid),
    .io_coreInstrResp_bits_dataResponse(InstructionFetch_io_coreInstrResp_bits_dataResponse)
  );
  InstructionDecode InstructionDecode ( // @[Core.scala 71:18]
    .clock(InstructionDecode_clock),
    .reset(InstructionDecode_reset),
    .io_id_instruction(InstructionDecode_io_id_instruction),
    .io_writeData(InstructionDecode_io_writeData),
    .io_writeReg(InstructionDecode_io_writeReg),
    .io_pcAddress(InstructionDecode_io_pcAddress),
    .io_ctl_writeEnable(InstructionDecode_io_ctl_writeEnable),
    .io_id_ex_mem_read(InstructionDecode_io_id_ex_mem_read),
    .io_ex_mem_mem_read(InstructionDecode_io_ex_mem_mem_read),
    .io_id_ex_rd(InstructionDecode_io_id_ex_rd),
    .io_ex_mem_rd(InstructionDecode_io_ex_mem_rd),
    .io_id_ex_branch(InstructionDecode_io_id_ex_branch),
    .io_ex_mem_ins(InstructionDecode_io_ex_mem_ins),
    .io_mem_wb_ins(InstructionDecode_io_mem_wb_ins),
    .io_ex_ins(InstructionDecode_io_ex_ins),
    .io_ex_result(InstructionDecode_io_ex_result),
    .io_ex_mem_result(InstructionDecode_io_ex_mem_result),
    .io_mem_wb_result(InstructionDecode_io_mem_wb_result),
    .io_immediate(InstructionDecode_io_immediate),
    .io_writeRegAddress(InstructionDecode_io_writeRegAddress),
    .io_readData1(InstructionDecode_io_readData1),
    .io_readData2(InstructionDecode_io_readData2),
    .io_func7(InstructionDecode_io_func7),
    .io_func3(InstructionDecode_io_func3),
    .io_ctl_aluSrc(InstructionDecode_io_ctl_aluSrc),
    .io_ctl_memToReg(InstructionDecode_io_ctl_memToReg),
    .io_ctl_regWrite(InstructionDecode_io_ctl_regWrite),
    .io_ctl_memRead(InstructionDecode_io_ctl_memRead),
    .io_ctl_memWrite(InstructionDecode_io_ctl_memWrite),
    .io_ctl_branch(InstructionDecode_io_ctl_branch),
    .io_ctl_aluOp(InstructionDecode_io_ctl_aluOp),
    .io_ctl_jump(InstructionDecode_io_ctl_jump),
    .io_ctl_aluSrc1(InstructionDecode_io_ctl_aluSrc1),
    .io_hdu_pcWrite(InstructionDecode_io_hdu_pcWrite),
    .io_hdu_if_reg_write(InstructionDecode_io_hdu_if_reg_write),
    .io_pcSrc(InstructionDecode_io_pcSrc),
    .io_pcPlusOffset(InstructionDecode_io_pcPlusOffset),
    .io_ifid_flush(InstructionDecode_io_ifid_flush)
  );
  Execute Execute ( // @[Core.scala 72:18]
    .io_immediate(Execute_io_immediate),
    .io_readData1(Execute_io_readData1),
    .io_readData2(Execute_io_readData2),
    .io_pcAddress(Execute_io_pcAddress),
    .io_func7(Execute_io_func7),
    .io_func3(Execute_io_func3),
    .io_mem_result(Execute_io_mem_result),
    .io_wb_result(Execute_io_wb_result),
    .io_ex_mem_regWrite(Execute_io_ex_mem_regWrite),
    .io_mem_wb_regWrite(Execute_io_mem_wb_regWrite),
    .io_id_ex_ins(Execute_io_id_ex_ins),
    .io_ex_mem_ins(Execute_io_ex_mem_ins),
    .io_mem_wb_ins(Execute_io_mem_wb_ins),
    .io_ctl_aluSrc(Execute_io_ctl_aluSrc),
    .io_ctl_aluOp(Execute_io_ctl_aluOp),
    .io_ctl_aluSrc1(Execute_io_ctl_aluSrc1),
    .io_writeData(Execute_io_writeData),
    .io_ALUresult(Execute_io_ALUresult)
  );
  MemoryFetch MEM ( // @[Core.scala 73:19]
    .clock(MEM_clock),
    .reset(MEM_reset),
    .io_aluResultIn(MEM_io_aluResultIn),
    .io_writeData(MEM_io_writeData),
    .io_writeEnable(MEM_io_writeEnable),
    .io_readEnable(MEM_io_readEnable),
    .io_readData(MEM_io_readData),
    .io_stall(MEM_io_stall),
    .io_dccmReq_valid(MEM_io_dccmReq_valid),
    .io_dccmReq_bits_addrRequest(MEM_io_dccmReq_bits_addrRequest),
    .io_dccmReq_bits_dataRequest(MEM_io_dccmReq_bits_dataRequest),
    .io_dccmReq_bits_isWrite(MEM_io_dccmReq_bits_isWrite),
    .io_dccmRsp_valid(MEM_io_dccmRsp_valid),
    .io_dccmRsp_bits_dataResponse(MEM_io_dccmRsp_bits_dataResponse)
  );
  PC pc ( // @[Core.scala 79:18]
    .clock(pc_clock),
    .reset(pc_reset),
    .io_in(pc_io_in),
    .io_halt(pc_io_halt),
    .io_out(pc_io_out),
    .io_pc4(pc_io_pc4)
  );
  assign io_dmemReq_valid = MEM_io_dccmReq_valid; // @[Core.scala 177:14]
  assign io_dmemReq_bits_addrRequest = MEM_io_dccmReq_bits_addrRequest; // @[Core.scala 177:14]
  assign io_dmemReq_bits_dataRequest = MEM_io_dccmReq_bits_dataRequest; // @[Core.scala 177:14]
  assign io_dmemReq_bits_isWrite = MEM_io_dccmReq_bits_isWrite; // @[Core.scala 177:14]
  assign io_imemReq_valid = InstructionFetch_io_coreInstrReq_valid; // @[Core.scala 81:14]
  assign io_imemReq_bits_addrRequest = InstructionFetch_io_coreInstrReq_bits_addrRequest; // @[Core.scala 81:14]
  assign InstructionFetch_io_address = pc_io_in; // @[Core.scala 84:32]
  assign InstructionFetch_io_coreInstrReq_ready = io_imemReq_ready; // @[Core.scala 81:14]
  assign InstructionFetch_io_coreInstrResp_valid = io_imemRsp_valid; // @[Core.scala 82:20]
  assign InstructionFetch_io_coreInstrResp_bits_dataResponse = io_imemRsp_bits_dataResponse; // @[Core.scala 82:20]
  assign InstructionDecode_clock = clock;
  assign InstructionDecode_reset = reset;
  assign InstructionDecode_io_id_instruction = if_reg_ins; // @[Core.scala 122:21]
  assign InstructionDecode_io_writeData = mem_reg_ctl_memToReg == 2'h1 ? MEM_io_readData : _GEN_14; // @[Core.scala 223:38 Core.scala 224:13]
  assign InstructionDecode_io_writeReg = mem_reg_ctl_memToReg == 2'h1 ? _T_16 : mem_reg_wra; // @[Core.scala 223:38 Core.scala 225:13]
  assign InstructionDecode_io_pcAddress = if_reg_pc; // @[Core.scala 123:16]
  assign InstructionDecode_io_ctl_writeEnable = mem_reg_ctl_regWrite; // @[Core.scala 240:22]
  assign InstructionDecode_io_id_ex_mem_read = id_reg_ctl_memRead; // @[Core.scala 159:21]
  assign InstructionDecode_io_ex_mem_mem_read = ex_reg_ctl_memRead; // @[Core.scala 160:22]
  assign InstructionDecode_io_id_ex_rd = id_reg_ins[11:7]; // @[Core.scala 167:28]
  assign InstructionDecode_io_ex_mem_rd = ex_reg_ins[11:7]; // @[Core.scala 169:29]
  assign InstructionDecode_io_id_ex_branch = id_reg_ins[6:0] == 7'h63; // @[Core.scala 168:42]
  assign InstructionDecode_io_ex_mem_ins = ex_reg_ins; // @[Core.scala 128:17]
  assign InstructionDecode_io_mem_wb_ins = mem_reg_ins; // @[Core.scala 129:17]
  assign InstructionDecode_io_ex_ins = id_reg_ins; // @[Core.scala 127:13]
  assign InstructionDecode_io_ex_result = Execute_io_ALUresult; // @[Core.scala 170:16]
  assign InstructionDecode_io_ex_mem_result = ex_reg_result; // @[Core.scala 130:20]
  assign InstructionDecode_io_mem_wb_result = mem_reg_ctl_memToReg == 2'h1 ? MEM_io_readData : _GEN_14; // @[Core.scala 223:38 Core.scala 224:13]
  assign Execute_io_immediate = id_reg_imm; // @[Core.scala 141:16]
  assign Execute_io_readData1 = id_reg_rd1; // @[Core.scala 142:16]
  assign Execute_io_readData2 = id_reg_rd2; // @[Core.scala 143:16]
  assign Execute_io_pcAddress = id_reg_pc; // @[Core.scala 144:16]
  assign Execute_io_func7 = id_reg_f7; // @[Core.scala 146:12]
  assign Execute_io_func3 = id_reg_f3; // @[Core.scala 145:12]
  assign Execute_io_mem_result = ex_reg_result; // @[Core.scala 214:17]
  assign Execute_io_wb_result = mem_reg_ctl_memToReg == 2'h1 ? MEM_io_readData : _GEN_14; // @[Core.scala 223:38 Core.scala 224:13]
  assign Execute_io_ex_mem_regWrite = ex_reg_ctl_regWrite; // @[Core.scala 209:22]
  assign Execute_io_mem_wb_regWrite = mem_reg_ctl_regWrite; // @[Core.scala 238:22]
  assign Execute_io_id_ex_ins = id_reg_ins; // @[Core.scala 164:16]
  assign Execute_io_ex_mem_ins = ex_reg_ins; // @[Core.scala 165:17]
  assign Execute_io_mem_wb_ins = mem_reg_ins; // @[Core.scala 166:17]
  assign Execute_io_ctl_aluSrc = id_reg_ctl_aluSrc; // @[Core.scala 147:17]
  assign Execute_io_ctl_aluOp = id_reg_ctl_aluOp; // @[Core.scala 148:16]
  assign Execute_io_ctl_aluSrc1 = id_reg_ctl_aluSrc1; // @[Core.scala 149:18]
  assign MEM_clock = clock;
  assign MEM_reset = reset;
  assign MEM_io_aluResultIn = ex_reg_result; // @[Core.scala 210:22]
  assign MEM_io_writeData = ex_reg_wd; // @[Core.scala 211:20]
  assign MEM_io_writeEnable = ex_reg_ctl_memWrite; // @[Core.scala 213:22]
  assign MEM_io_readEnable = ex_reg_ctl_memRead; // @[Core.scala 212:21]
  assign MEM_io_dccmRsp_valid = io_dmemRsp_valid; // @[Core.scala 178:18]
  assign MEM_io_dccmRsp_bits_dataResponse = io_dmemRsp_bits_dataResponse; // @[Core.scala 178:18]
  assign pc_clock = clock;
  assign pc_reset = reset;
  assign pc_io_in = InstructionDecode_io_hdu_pcWrite & ~MEM_io_stall ? $signed(_T_5) : $signed(pc_io_out); // @[Core.scala 88:18]
  assign pc_io_halt = io_imemReq_valid ? 1'h0 : 1'h1; // @[Core.scala 87:20]
  always @(posedge clock) begin
    if (reset) begin // @[Core.scala 23:26]
      if_reg_pc <= 32'h0; // @[Core.scala 23:26]
    end else if (InstructionDecode_io_hdu_if_reg_write & _T_2) begin // @[Core.scala 91:46]
      if_reg_pc <= pc_io_out; // @[Core.scala 92:15]
    end
    if (reset) begin // @[Core.scala 24:27]
      if_reg_ins <= 32'h0; // @[Core.scala 24:27]
    end else if (InstructionDecode_io_ifid_flush) begin // @[Core.scala 95:23]
      if_reg_ins <= 32'h0; // @[Core.scala 96:16]
    end else if (InstructionDecode_io_hdu_if_reg_write & _T_2) begin // @[Core.scala 91:46]
      if (io_imemRsp_valid) begin // @[Core.scala 85:24]
        if_reg_ins <= InstructionFetch_io_instruction;
      end else begin
        if_reg_ins <= 32'h13;
      end
    end
    if (reset) begin // @[Core.scala 27:26]
      id_reg_pc <= 32'h0; // @[Core.scala 27:26]
    end else begin
      id_reg_pc <= if_reg_pc; // @[Core.scala 111:13]
    end
    if (reset) begin // @[Core.scala 28:27]
      id_reg_rd1 <= 32'h0; // @[Core.scala 28:27]
    end else begin
      id_reg_rd1 <= InstructionDecode_io_readData1; // @[Core.scala 104:14]
    end
    if (reset) begin // @[Core.scala 29:27]
      id_reg_rd2 <= 32'h0; // @[Core.scala 29:27]
    end else begin
      id_reg_rd2 <= InstructionDecode_io_readData2; // @[Core.scala 105:14]
    end
    if (reset) begin // @[Core.scala 30:27]
      id_reg_imm <= 32'h0; // @[Core.scala 30:27]
    end else begin
      id_reg_imm <= InstructionDecode_io_immediate; // @[Core.scala 106:14]
    end
    if (reset) begin // @[Core.scala 31:27]
      id_reg_wra <= 5'h0; // @[Core.scala 31:27]
    end else begin
      id_reg_wra <= InstructionDecode_io_writeRegAddress; // @[Core.scala 107:14]
    end
    if (reset) begin // @[Core.scala 32:26]
      id_reg_f7 <= 7'h0; // @[Core.scala 32:26]
    end else begin
      id_reg_f7 <= InstructionDecode_io_func7; // @[Core.scala 109:13]
    end
    if (reset) begin // @[Core.scala 33:26]
      id_reg_f3 <= 3'h0; // @[Core.scala 33:26]
    end else begin
      id_reg_f3 <= InstructionDecode_io_func3; // @[Core.scala 108:13]
    end
    if (reset) begin // @[Core.scala 34:27]
      id_reg_ins <= 32'h0; // @[Core.scala 34:27]
    end else begin
      id_reg_ins <= if_reg_ins; // @[Core.scala 110:14]
    end
    if (reset) begin // @[Core.scala 35:34]
      id_reg_ctl_aluSrc <= 1'h0; // @[Core.scala 35:34]
    end else begin
      id_reg_ctl_aluSrc <= InstructionDecode_io_ctl_aluSrc; // @[Core.scala 112:21]
    end
    if (reset) begin // @[Core.scala 36:35]
      id_reg_ctl_aluSrc1 <= 2'h0; // @[Core.scala 36:35]
    end else begin
      id_reg_ctl_aluSrc1 <= InstructionDecode_io_ctl_aluSrc1; // @[Core.scala 120:22]
    end
    if (reset) begin // @[Core.scala 37:36]
      id_reg_ctl_memToReg <= 2'h0; // @[Core.scala 37:36]
    end else begin
      id_reg_ctl_memToReg <= InstructionDecode_io_ctl_memToReg; // @[Core.scala 113:23]
    end
    if (reset) begin // @[Core.scala 38:36]
      id_reg_ctl_regWrite <= 1'h0; // @[Core.scala 38:36]
    end else begin
      id_reg_ctl_regWrite <= InstructionDecode_io_ctl_regWrite; // @[Core.scala 114:23]
    end
    if (reset) begin // @[Core.scala 39:35]
      id_reg_ctl_memRead <= 1'h0; // @[Core.scala 39:35]
    end else begin
      id_reg_ctl_memRead <= InstructionDecode_io_ctl_memRead; // @[Core.scala 115:22]
    end
    if (reset) begin // @[Core.scala 40:36]
      id_reg_ctl_memWrite <= 1'h0; // @[Core.scala 40:36]
    end else begin
      id_reg_ctl_memWrite <= InstructionDecode_io_ctl_memWrite; // @[Core.scala 116:23]
    end
    if (reset) begin // @[Core.scala 42:33]
      id_reg_ctl_aluOp <= 2'h0; // @[Core.scala 42:33]
    end else begin
      id_reg_ctl_aluOp <= InstructionDecode_io_ctl_aluOp; // @[Core.scala 118:20]
    end
    if (reset) begin // @[Core.scala 48:30]
      ex_reg_result <= 32'h0; // @[Core.scala 48:30]
    end else begin
      ex_reg_result <= Execute_io_ALUresult; // @[Core.scala 139:17]
    end
    if (reset) begin // @[Core.scala 49:26]
      ex_reg_wd <= 32'h0; // @[Core.scala 49:26]
    end else begin
      ex_reg_wd <= Execute_io_writeData; // @[Core.scala 138:13]
    end
    if (reset) begin // @[Core.scala 50:27]
      ex_reg_wra <= 5'h0; // @[Core.scala 50:27]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 181:21]
      ex_reg_wra <= id_reg_wra; // @[Core.scala 153:14]
    end
    if (reset) begin // @[Core.scala 51:27]
      ex_reg_ins <= 32'h0; // @[Core.scala 51:27]
    end else begin
      ex_reg_ins <= id_reg_ins; // @[Core.scala 154:14]
    end
    if (reset) begin // @[Core.scala 52:36]
      ex_reg_ctl_memToReg <= 2'h0; // @[Core.scala 52:36]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 181:21]
      ex_reg_ctl_memToReg <= id_reg_ctl_memToReg; // @[Core.scala 155:23]
    end
    if (reset) begin // @[Core.scala 53:36]
      ex_reg_ctl_regWrite <= 1'h0; // @[Core.scala 53:36]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 181:21]
      ex_reg_ctl_regWrite <= id_reg_ctl_regWrite; // @[Core.scala 156:23]
    end
    if (reset) begin // @[Core.scala 54:35]
      ex_reg_ctl_memRead <= 1'h0; // @[Core.scala 54:35]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 181:21]
      ex_reg_ctl_memRead <= id_reg_ctl_memRead; // @[Core.scala 204:24]
    end
    if (reset) begin // @[Core.scala 55:36]
      ex_reg_ctl_memWrite <= 1'h0; // @[Core.scala 55:36]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 181:21]
      ex_reg_ctl_memWrite <= id_reg_ctl_memWrite; // @[Core.scala 205:25]
    end
    if (reset) begin // @[Core.scala 57:26]
      ex_reg_pc <= 32'h0; // @[Core.scala 57:26]
    end else begin
      ex_reg_pc <= id_reg_pc; // @[Core.scala 152:13]
    end
    if (reset) begin // @[Core.scala 61:28]
      mem_reg_ins <= 32'h0; // @[Core.scala 61:28]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 181:21]
      mem_reg_ins <= ex_reg_ins; // @[Core.scala 201:17]
    end
    if (reset) begin // @[Core.scala 62:31]
      mem_reg_result <= 32'h0; // @[Core.scala 62:31]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 181:21]
      mem_reg_result <= ex_reg_result; // @[Core.scala 198:20]
    end
    if (reset) begin // @[Core.scala 64:28]
      mem_reg_wra <= 5'h0; // @[Core.scala 64:28]
    end else begin
      mem_reg_wra <= ex_reg_wra; // @[Core.scala 207:15]
    end
    if (reset) begin // @[Core.scala 65:37]
      mem_reg_ctl_memToReg <= 2'h0; // @[Core.scala 65:37]
    end else begin
      mem_reg_ctl_memToReg <= ex_reg_ctl_memToReg; // @[Core.scala 208:24]
    end
    if (reset) begin // @[Core.scala 66:37]
      mem_reg_ctl_regWrite <= 1'h0; // @[Core.scala 66:37]
    end else begin
      mem_reg_ctl_regWrite <= ex_reg_ctl_regWrite;
    end
    if (reset) begin // @[Core.scala 67:27]
      mem_reg_pc <= 32'h0; // @[Core.scala 67:27]
    end else if (!(MEM_io_stall)) begin // @[Core.scala 181:21]
      mem_reg_pc <= ex_reg_pc; // @[Core.scala 202:16]
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
  if_reg_pc = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  if_reg_ins = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  id_reg_pc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  id_reg_rd1 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  id_reg_rd2 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  id_reg_imm = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  id_reg_wra = _RAND_6[4:0];
  _RAND_7 = {1{`RANDOM}};
  id_reg_f7 = _RAND_7[6:0];
  _RAND_8 = {1{`RANDOM}};
  id_reg_f3 = _RAND_8[2:0];
  _RAND_9 = {1{`RANDOM}};
  id_reg_ins = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  id_reg_ctl_aluSrc = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  id_reg_ctl_aluSrc1 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  id_reg_ctl_memToReg = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  id_reg_ctl_regWrite = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  id_reg_ctl_memRead = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  id_reg_ctl_memWrite = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  id_reg_ctl_aluOp = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  ex_reg_result = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  ex_reg_wd = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  ex_reg_wra = _RAND_19[4:0];
  _RAND_20 = {1{`RANDOM}};
  ex_reg_ins = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  ex_reg_ctl_memToReg = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  ex_reg_ctl_regWrite = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  ex_reg_ctl_memRead = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  ex_reg_ctl_memWrite = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  ex_reg_pc = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  mem_reg_ins = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  mem_reg_result = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  mem_reg_wra = _RAND_28[4:0];
  _RAND_29 = {1{`RANDOM}};
  mem_reg_ctl_memToReg = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  mem_reg_ctl_regWrite = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  mem_reg_pc = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Switch1toN(
  input         io_hostIn_valid,
  input         io_hostIn_bits_cyc,
  input         io_hostIn_bits_stb,
  input         io_hostIn_bits_we,
  input  [31:0] io_hostIn_bits_adr,
  input  [31:0] io_hostIn_bits_dat,
  input  [3:0]  io_hostIn_bits_sel,
  output        io_hostOut_bits_ack,
  output [31:0] io_hostOut_bits_dat,
  output        io_hostOut_bits_err,
  output        io_devOut_0_valid,
  output        io_devOut_0_bits_cyc,
  output        io_devOut_0_bits_stb,
  output        io_devOut_0_bits_we,
  output [31:0] io_devOut_0_bits_adr,
  output [31:0] io_devOut_0_bits_dat,
  output [3:0]  io_devOut_0_bits_sel,
  output        io_devOut_1_valid,
  output        io_devOut_1_bits_cyc,
  output        io_devOut_1_bits_stb,
  output        io_devOut_1_bits_we,
  output [31:0] io_devOut_1_bits_adr,
  output [31:0] io_devOut_1_bits_dat,
  output [3:0]  io_devOut_1_bits_sel,
  output        io_devOut_2_valid,
  output        io_devOut_2_bits_cyc,
  output        io_devOut_2_bits_stb,
  input         io_devIn_0_bits_ack,
  input  [31:0] io_devIn_0_bits_dat,
  input         io_devIn_0_bits_err,
  input         io_devIn_1_bits_ack,
  input  [31:0] io_devIn_1_bits_dat,
  input         io_devIn_1_bits_err,
  input  [31:0] io_devIn_2_bits_dat,
  input         io_devIn_2_bits_err,
  input  [1:0]  io_devSel
);
  wire  _io_devOut_0_valid_T = io_devSel == 2'h0; // @[Switch1toN.scala 33:57]
  wire  _io_devOut_1_valid_T = io_devSel == 2'h1; // @[Switch1toN.scala 33:57]
  wire  _GEN_0 = _io_devOut_0_valid_T ? io_devIn_0_bits_err : io_devIn_2_bits_err; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23 Switch1toN.scala 27:19]
  wire [31:0] _GEN_1 = _io_devOut_0_valid_T ? io_devIn_0_bits_dat : io_devIn_2_bits_dat; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23 Switch1toN.scala 27:19]
  wire  _GEN_2 = _io_devOut_0_valid_T & io_devIn_0_bits_ack; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23 Switch1toN.scala 27:19]
  assign io_hostOut_bits_ack = _io_devOut_1_valid_T ? io_devIn_1_bits_ack : _GEN_2; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  assign io_hostOut_bits_dat = _io_devOut_1_valid_T ? io_devIn_1_bits_dat : _GEN_1; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  assign io_hostOut_bits_err = _io_devOut_1_valid_T ? io_devIn_1_bits_err : _GEN_0; // @[Switch1toN.scala 39:35 Switch1toN.scala 40:23]
  assign io_devOut_0_valid = io_hostIn_valid & io_devSel == 2'h0; // @[Switch1toN.scala 33:43]
  assign io_devOut_0_bits_cyc = io_hostIn_bits_cyc; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_stb = io_hostIn_bits_stb; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_we = io_hostIn_bits_we; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_adr = io_hostIn_bits_adr; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_dat = io_hostIn_bits_dat; // @[Switch1toN.scala 31:33]
  assign io_devOut_0_bits_sel = io_hostIn_bits_sel; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_valid = io_hostIn_valid & io_devSel == 2'h1; // @[Switch1toN.scala 33:43]
  assign io_devOut_1_bits_cyc = io_hostIn_bits_cyc; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_stb = io_hostIn_bits_stb; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_we = io_hostIn_bits_we; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_adr = io_hostIn_bits_adr; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_dat = io_hostIn_bits_dat; // @[Switch1toN.scala 31:33]
  assign io_devOut_1_bits_sel = io_hostIn_bits_sel; // @[Switch1toN.scala 31:33]
  assign io_devOut_2_valid = io_hostIn_valid & io_devSel == 2'h2; // @[Switch1toN.scala 23:41]
  assign io_devOut_2_bits_cyc = io_hostIn_bits_cyc; // @[Switch1toN.scala 31:33]
  assign io_devOut_2_bits_stb = io_hostIn_bits_stb; // @[Switch1toN.scala 31:33]
endmodule
module Generator(
  input        clock,
  input        reset,
  output [3:0] io_gpio_o,
  output [3:0] io_gpio_en_o,
  input  [3:0] io_gpio_i
);
  wire  gen_imem_host_clock; // @[Generator.scala 122:31]
  wire  gen_imem_host_reset; // @[Generator.scala 122:31]
  wire  gen_imem_host_io_wbMasterTransmitter_ready; // @[Generator.scala 122:31]
  wire  gen_imem_host_io_wbMasterTransmitter_valid; // @[Generator.scala 122:31]
  wire  gen_imem_host_io_wbMasterTransmitter_bits_cyc; // @[Generator.scala 122:31]
  wire  gen_imem_host_io_wbMasterTransmitter_bits_stb; // @[Generator.scala 122:31]
  wire  gen_imem_host_io_wbMasterTransmitter_bits_we; // @[Generator.scala 122:31]
  wire [31:0] gen_imem_host_io_wbMasterTransmitter_bits_adr; // @[Generator.scala 122:31]
  wire [31:0] gen_imem_host_io_wbMasterTransmitter_bits_dat; // @[Generator.scala 122:31]
  wire [3:0] gen_imem_host_io_wbMasterTransmitter_bits_sel; // @[Generator.scala 122:31]
  wire  gen_imem_host_io_wbSlaveReceiver_ready; // @[Generator.scala 122:31]
  wire  gen_imem_host_io_wbSlaveReceiver_bits_ack; // @[Generator.scala 122:31]
  wire [31:0] gen_imem_host_io_wbSlaveReceiver_bits_dat; // @[Generator.scala 122:31]
  wire  gen_imem_host_io_wbSlaveReceiver_bits_err; // @[Generator.scala 122:31]
  wire  gen_imem_host_io_reqIn_ready; // @[Generator.scala 122:31]
  wire  gen_imem_host_io_reqIn_valid; // @[Generator.scala 122:31]
  wire [31:0] gen_imem_host_io_reqIn_bits_addrRequest; // @[Generator.scala 122:31]
  wire [31:0] gen_imem_host_io_reqIn_bits_dataRequest; // @[Generator.scala 122:31]
  wire  gen_imem_host_io_reqIn_bits_isWrite; // @[Generator.scala 122:31]
  wire  gen_imem_host_io_rspOut_valid; // @[Generator.scala 122:31]
  wire [31:0] gen_imem_host_io_rspOut_bits_dataResponse; // @[Generator.scala 122:31]
  wire  gen_imem_slave_io_wbSlaveTransmitter_ready; // @[Generator.scala 123:32]
  wire  gen_imem_slave_io_wbSlaveTransmitter_bits_ack; // @[Generator.scala 123:32]
  wire [31:0] gen_imem_slave_io_wbSlaveTransmitter_bits_dat; // @[Generator.scala 123:32]
  wire  gen_imem_slave_io_wbSlaveTransmitter_bits_err; // @[Generator.scala 123:32]
  wire  gen_imem_slave_io_wbMasterReceiver_ready; // @[Generator.scala 123:32]
  wire  gen_imem_slave_io_wbMasterReceiver_valid; // @[Generator.scala 123:32]
  wire  gen_imem_slave_io_wbMasterReceiver_bits_cyc; // @[Generator.scala 123:32]
  wire  gen_imem_slave_io_wbMasterReceiver_bits_stb; // @[Generator.scala 123:32]
  wire  gen_imem_slave_io_wbMasterReceiver_bits_we; // @[Generator.scala 123:32]
  wire [31:0] gen_imem_slave_io_wbMasterReceiver_bits_adr; // @[Generator.scala 123:32]
  wire [31:0] gen_imem_slave_io_wbMasterReceiver_bits_dat; // @[Generator.scala 123:32]
  wire [3:0] gen_imem_slave_io_wbMasterReceiver_bits_sel; // @[Generator.scala 123:32]
  wire  gen_imem_slave_io_reqOut_valid; // @[Generator.scala 123:32]
  wire [31:0] gen_imem_slave_io_reqOut_bits_addrRequest; // @[Generator.scala 123:32]
  wire [31:0] gen_imem_slave_io_reqOut_bits_dataRequest; // @[Generator.scala 123:32]
  wire [3:0] gen_imem_slave_io_reqOut_bits_activeByteLane; // @[Generator.scala 123:32]
  wire  gen_imem_slave_io_reqOut_bits_isWrite; // @[Generator.scala 123:32]
  wire  gen_imem_slave_io_rspIn_valid; // @[Generator.scala 123:32]
  wire [31:0] gen_imem_slave_io_rspIn_bits_dataResponse; // @[Generator.scala 123:32]
  wire  gen_imem_slave_io_rspIn_bits_error; // @[Generator.scala 123:32]
  wire  gen_dmem_host_clock; // @[Generator.scala 124:31]
  wire  gen_dmem_host_reset; // @[Generator.scala 124:31]
  wire  gen_dmem_host_io_wbMasterTransmitter_ready; // @[Generator.scala 124:31]
  wire  gen_dmem_host_io_wbMasterTransmitter_valid; // @[Generator.scala 124:31]
  wire  gen_dmem_host_io_wbMasterTransmitter_bits_cyc; // @[Generator.scala 124:31]
  wire  gen_dmem_host_io_wbMasterTransmitter_bits_stb; // @[Generator.scala 124:31]
  wire  gen_dmem_host_io_wbMasterTransmitter_bits_we; // @[Generator.scala 124:31]
  wire [31:0] gen_dmem_host_io_wbMasterTransmitter_bits_adr; // @[Generator.scala 124:31]
  wire [31:0] gen_dmem_host_io_wbMasterTransmitter_bits_dat; // @[Generator.scala 124:31]
  wire [3:0] gen_dmem_host_io_wbMasterTransmitter_bits_sel; // @[Generator.scala 124:31]
  wire  gen_dmem_host_io_wbSlaveReceiver_ready; // @[Generator.scala 124:31]
  wire  gen_dmem_host_io_wbSlaveReceiver_bits_ack; // @[Generator.scala 124:31]
  wire [31:0] gen_dmem_host_io_wbSlaveReceiver_bits_dat; // @[Generator.scala 124:31]
  wire  gen_dmem_host_io_wbSlaveReceiver_bits_err; // @[Generator.scala 124:31]
  wire  gen_dmem_host_io_reqIn_ready; // @[Generator.scala 124:31]
  wire  gen_dmem_host_io_reqIn_valid; // @[Generator.scala 124:31]
  wire [31:0] gen_dmem_host_io_reqIn_bits_addrRequest; // @[Generator.scala 124:31]
  wire [31:0] gen_dmem_host_io_reqIn_bits_dataRequest; // @[Generator.scala 124:31]
  wire  gen_dmem_host_io_reqIn_bits_isWrite; // @[Generator.scala 124:31]
  wire  gen_dmem_host_io_rspOut_valid; // @[Generator.scala 124:31]
  wire [31:0] gen_dmem_host_io_rspOut_bits_dataResponse; // @[Generator.scala 124:31]
  wire  gen_dmem_slave_io_wbSlaveTransmitter_ready; // @[Generator.scala 125:32]
  wire  gen_dmem_slave_io_wbSlaveTransmitter_bits_ack; // @[Generator.scala 125:32]
  wire [31:0] gen_dmem_slave_io_wbSlaveTransmitter_bits_dat; // @[Generator.scala 125:32]
  wire  gen_dmem_slave_io_wbSlaveTransmitter_bits_err; // @[Generator.scala 125:32]
  wire  gen_dmem_slave_io_wbMasterReceiver_ready; // @[Generator.scala 125:32]
  wire  gen_dmem_slave_io_wbMasterReceiver_valid; // @[Generator.scala 125:32]
  wire  gen_dmem_slave_io_wbMasterReceiver_bits_cyc; // @[Generator.scala 125:32]
  wire  gen_dmem_slave_io_wbMasterReceiver_bits_stb; // @[Generator.scala 125:32]
  wire  gen_dmem_slave_io_wbMasterReceiver_bits_we; // @[Generator.scala 125:32]
  wire [31:0] gen_dmem_slave_io_wbMasterReceiver_bits_adr; // @[Generator.scala 125:32]
  wire [31:0] gen_dmem_slave_io_wbMasterReceiver_bits_dat; // @[Generator.scala 125:32]
  wire [3:0] gen_dmem_slave_io_wbMasterReceiver_bits_sel; // @[Generator.scala 125:32]
  wire  gen_dmem_slave_io_reqOut_valid; // @[Generator.scala 125:32]
  wire [31:0] gen_dmem_slave_io_reqOut_bits_addrRequest; // @[Generator.scala 125:32]
  wire [31:0] gen_dmem_slave_io_reqOut_bits_dataRequest; // @[Generator.scala 125:32]
  wire [3:0] gen_dmem_slave_io_reqOut_bits_activeByteLane; // @[Generator.scala 125:32]
  wire  gen_dmem_slave_io_reqOut_bits_isWrite; // @[Generator.scala 125:32]
  wire  gen_dmem_slave_io_rspIn_valid; // @[Generator.scala 125:32]
  wire [31:0] gen_dmem_slave_io_rspIn_bits_dataResponse; // @[Generator.scala 125:32]
  wire  gen_dmem_slave_io_rspIn_bits_error; // @[Generator.scala 125:32]
  wire  gpio_clock; // @[Generator.scala 133:26]
  wire  gpio_reset; // @[Generator.scala 133:26]
  wire  gpio_io_req_valid; // @[Generator.scala 133:26]
  wire [31:0] gpio_io_req_bits_addrRequest; // @[Generator.scala 133:26]
  wire [31:0] gpio_io_req_bits_dataRequest; // @[Generator.scala 133:26]
  wire [3:0] gpio_io_req_bits_activeByteLane; // @[Generator.scala 133:26]
  wire  gpio_io_req_bits_isWrite; // @[Generator.scala 133:26]
  wire  gpio_io_rsp_valid; // @[Generator.scala 133:26]
  wire [31:0] gpio_io_rsp_bits_dataResponse; // @[Generator.scala 133:26]
  wire  gpio_io_rsp_bits_error; // @[Generator.scala 133:26]
  wire [31:0] gpio_io_cio_gpio_i; // @[Generator.scala 133:26]
  wire [31:0] gpio_io_cio_gpio_o; // @[Generator.scala 133:26]
  wire [31:0] gpio_io_cio_gpio_en_o; // @[Generator.scala 133:26]
  wire  gen_gpio_slave_io_wbSlaveTransmitter_ready; // @[Generator.scala 134:36]
  wire  gen_gpio_slave_io_wbSlaveTransmitter_bits_ack; // @[Generator.scala 134:36]
  wire [31:0] gen_gpio_slave_io_wbSlaveTransmitter_bits_dat; // @[Generator.scala 134:36]
  wire  gen_gpio_slave_io_wbSlaveTransmitter_bits_err; // @[Generator.scala 134:36]
  wire  gen_gpio_slave_io_wbMasterReceiver_ready; // @[Generator.scala 134:36]
  wire  gen_gpio_slave_io_wbMasterReceiver_valid; // @[Generator.scala 134:36]
  wire  gen_gpio_slave_io_wbMasterReceiver_bits_cyc; // @[Generator.scala 134:36]
  wire  gen_gpio_slave_io_wbMasterReceiver_bits_stb; // @[Generator.scala 134:36]
  wire  gen_gpio_slave_io_wbMasterReceiver_bits_we; // @[Generator.scala 134:36]
  wire [31:0] gen_gpio_slave_io_wbMasterReceiver_bits_adr; // @[Generator.scala 134:36]
  wire [31:0] gen_gpio_slave_io_wbMasterReceiver_bits_dat; // @[Generator.scala 134:36]
  wire [3:0] gen_gpio_slave_io_wbMasterReceiver_bits_sel; // @[Generator.scala 134:36]
  wire  gen_gpio_slave_io_reqOut_valid; // @[Generator.scala 134:36]
  wire [31:0] gen_gpio_slave_io_reqOut_bits_addrRequest; // @[Generator.scala 134:36]
  wire [31:0] gen_gpio_slave_io_reqOut_bits_dataRequest; // @[Generator.scala 134:36]
  wire [3:0] gen_gpio_slave_io_reqOut_bits_activeByteLane; // @[Generator.scala 134:36]
  wire  gen_gpio_slave_io_reqOut_bits_isWrite; // @[Generator.scala 134:36]
  wire  gen_gpio_slave_io_rspIn_valid; // @[Generator.scala 134:36]
  wire [31:0] gen_gpio_slave_io_rspIn_bits_dataResponse; // @[Generator.scala 134:36]
  wire  gen_gpio_slave_io_rspIn_bits_error; // @[Generator.scala 134:36]
  wire  imem_clock; // @[Generator.scala 215:22]
  wire  imem_reset; // @[Generator.scala 215:22]
  wire  imem_io_req_ready; // @[Generator.scala 215:22]
  wire  imem_io_req_valid; // @[Generator.scala 215:22]
  wire [31:0] imem_io_req_bits_addrRequest; // @[Generator.scala 215:22]
  wire [31:0] imem_io_req_bits_dataRequest; // @[Generator.scala 215:22]
  wire  imem_io_req_bits_isWrite; // @[Generator.scala 215:22]
  wire  imem_io_rsp_valid; // @[Generator.scala 215:22]
  wire [31:0] imem_io_rsp_bits_dataResponse; // @[Generator.scala 215:22]
  wire  imem_io_rsp_bits_error; // @[Generator.scala 215:22]
  wire  dmem_clock; // @[Generator.scala 216:22]
  wire  dmem_reset; // @[Generator.scala 216:22]
  wire  dmem_io_req_ready; // @[Generator.scala 216:22]
  wire  dmem_io_req_valid; // @[Generator.scala 216:22]
  wire [31:0] dmem_io_req_bits_addrRequest; // @[Generator.scala 216:22]
  wire [31:0] dmem_io_req_bits_dataRequest; // @[Generator.scala 216:22]
  wire [3:0] dmem_io_req_bits_activeByteLane; // @[Generator.scala 216:22]
  wire  dmem_io_req_bits_isWrite; // @[Generator.scala 216:22]
  wire  dmem_io_rsp_valid; // @[Generator.scala 216:22]
  wire [31:0] dmem_io_rsp_bits_dataResponse; // @[Generator.scala 216:22]
  wire  wbErr_clock; // @[Generator.scala 218:23]
  wire  wbErr_reset; // @[Generator.scala 218:23]
  wire [31:0] wbErr_io_wbSlaveTransmitter_bits_dat; // @[Generator.scala 218:23]
  wire  wbErr_io_wbSlaveTransmitter_bits_err; // @[Generator.scala 218:23]
  wire  wbErr_io_wbMasterReceiver_valid; // @[Generator.scala 218:23]
  wire  wbErr_io_wbMasterReceiver_bits_cyc; // @[Generator.scala 218:23]
  wire  wbErr_io_wbMasterReceiver_bits_stb; // @[Generator.scala 218:23]
  wire  core_clock; // @[Generator.scala 219:22]
  wire  core_reset; // @[Generator.scala 219:22]
  wire  core_io_dmemReq_valid; // @[Generator.scala 219:22]
  wire [31:0] core_io_dmemReq_bits_addrRequest; // @[Generator.scala 219:22]
  wire [31:0] core_io_dmemReq_bits_dataRequest; // @[Generator.scala 219:22]
  wire  core_io_dmemReq_bits_isWrite; // @[Generator.scala 219:22]
  wire  core_io_dmemRsp_valid; // @[Generator.scala 219:22]
  wire [31:0] core_io_dmemRsp_bits_dataResponse; // @[Generator.scala 219:22]
  wire  core_io_imemReq_ready; // @[Generator.scala 219:22]
  wire  core_io_imemReq_valid; // @[Generator.scala 219:22]
  wire [31:0] core_io_imemReq_bits_addrRequest; // @[Generator.scala 219:22]
  wire  core_io_imemRsp_valid; // @[Generator.scala 219:22]
  wire [31:0] core_io_imemRsp_bits_dataResponse; // @[Generator.scala 219:22]
  wire  switch_io_hostIn_valid; // @[Generator.scala 224:24]
  wire  switch_io_hostIn_bits_cyc; // @[Generator.scala 224:24]
  wire  switch_io_hostIn_bits_stb; // @[Generator.scala 224:24]
  wire  switch_io_hostIn_bits_we; // @[Generator.scala 224:24]
  wire [31:0] switch_io_hostIn_bits_adr; // @[Generator.scala 224:24]
  wire [31:0] switch_io_hostIn_bits_dat; // @[Generator.scala 224:24]
  wire [3:0] switch_io_hostIn_bits_sel; // @[Generator.scala 224:24]
  wire  switch_io_hostOut_bits_ack; // @[Generator.scala 224:24]
  wire [31:0] switch_io_hostOut_bits_dat; // @[Generator.scala 224:24]
  wire  switch_io_hostOut_bits_err; // @[Generator.scala 224:24]
  wire  switch_io_devOut_0_valid; // @[Generator.scala 224:24]
  wire  switch_io_devOut_0_bits_cyc; // @[Generator.scala 224:24]
  wire  switch_io_devOut_0_bits_stb; // @[Generator.scala 224:24]
  wire  switch_io_devOut_0_bits_we; // @[Generator.scala 224:24]
  wire [31:0] switch_io_devOut_0_bits_adr; // @[Generator.scala 224:24]
  wire [31:0] switch_io_devOut_0_bits_dat; // @[Generator.scala 224:24]
  wire [3:0] switch_io_devOut_0_bits_sel; // @[Generator.scala 224:24]
  wire  switch_io_devOut_1_valid; // @[Generator.scala 224:24]
  wire  switch_io_devOut_1_bits_cyc; // @[Generator.scala 224:24]
  wire  switch_io_devOut_1_bits_stb; // @[Generator.scala 224:24]
  wire  switch_io_devOut_1_bits_we; // @[Generator.scala 224:24]
  wire [31:0] switch_io_devOut_1_bits_adr; // @[Generator.scala 224:24]
  wire [31:0] switch_io_devOut_1_bits_dat; // @[Generator.scala 224:24]
  wire [3:0] switch_io_devOut_1_bits_sel; // @[Generator.scala 224:24]
  wire  switch_io_devOut_2_valid; // @[Generator.scala 224:24]
  wire  switch_io_devOut_2_bits_cyc; // @[Generator.scala 224:24]
  wire  switch_io_devOut_2_bits_stb; // @[Generator.scala 224:24]
  wire  switch_io_devIn_0_bits_ack; // @[Generator.scala 224:24]
  wire [31:0] switch_io_devIn_0_bits_dat; // @[Generator.scala 224:24]
  wire  switch_io_devIn_0_bits_err; // @[Generator.scala 224:24]
  wire  switch_io_devIn_1_bits_ack; // @[Generator.scala 224:24]
  wire [31:0] switch_io_devIn_1_bits_dat; // @[Generator.scala 224:24]
  wire  switch_io_devIn_1_bits_err; // @[Generator.scala 224:24]
  wire [31:0] switch_io_devIn_2_bits_dat; // @[Generator.scala 224:24]
  wire  switch_io_devIn_2_bits_err; // @[Generator.scala 224:24]
  wire [1:0] switch_io_devSel; // @[Generator.scala 224:24]
  wire [31:0] _switch_io_devSel_addr_hit_0_T_1 = 32'hfffff000 & gen_dmem_host_io_wbMasterTransmitter_bits_adr; // @[BusDecoder.scala 45:60]
  wire  switch_io_devSel_addr_hit_0 = _switch_io_devSel_addr_hit_0_T_1 == 32'h40001000; // @[BusDecoder.scala 45:68]
  wire [1:0] switch_io_devSel_id_0 = switch_io_devSel_addr_hit_0 ? 2'h1 : 2'h2; // @[BusDecoder.scala 46:19]
  wire  switch_io_devSel_addr_hit_1 = _switch_io_devSel_addr_hit_0_T_1 == 32'h40000000; // @[BusDecoder.scala 45:68]
  wire [1:0] switch_io_devSel_id_1 = switch_io_devSel_addr_hit_1 ? 2'h0 : 2'h2; // @[BusDecoder.scala 46:19]
  wire [1:0] _switch_io_devSel_T = switch_io_devSel_addr_hit_1 ? switch_io_devSel_id_1 : 2'h2; // @[Mux.scala 98:16]
  WishboneHost gen_imem_host ( // @[Generator.scala 122:31]
    .clock(gen_imem_host_clock),
    .reset(gen_imem_host_reset),
    .io_wbMasterTransmitter_ready(gen_imem_host_io_wbMasterTransmitter_ready),
    .io_wbMasterTransmitter_valid(gen_imem_host_io_wbMasterTransmitter_valid),
    .io_wbMasterTransmitter_bits_cyc(gen_imem_host_io_wbMasterTransmitter_bits_cyc),
    .io_wbMasterTransmitter_bits_stb(gen_imem_host_io_wbMasterTransmitter_bits_stb),
    .io_wbMasterTransmitter_bits_we(gen_imem_host_io_wbMasterTransmitter_bits_we),
    .io_wbMasterTransmitter_bits_adr(gen_imem_host_io_wbMasterTransmitter_bits_adr),
    .io_wbMasterTransmitter_bits_dat(gen_imem_host_io_wbMasterTransmitter_bits_dat),
    .io_wbMasterTransmitter_bits_sel(gen_imem_host_io_wbMasterTransmitter_bits_sel),
    .io_wbSlaveReceiver_ready(gen_imem_host_io_wbSlaveReceiver_ready),
    .io_wbSlaveReceiver_bits_ack(gen_imem_host_io_wbSlaveReceiver_bits_ack),
    .io_wbSlaveReceiver_bits_dat(gen_imem_host_io_wbSlaveReceiver_bits_dat),
    .io_wbSlaveReceiver_bits_err(gen_imem_host_io_wbSlaveReceiver_bits_err),
    .io_reqIn_ready(gen_imem_host_io_reqIn_ready),
    .io_reqIn_valid(gen_imem_host_io_reqIn_valid),
    .io_reqIn_bits_addrRequest(gen_imem_host_io_reqIn_bits_addrRequest),
    .io_reqIn_bits_dataRequest(gen_imem_host_io_reqIn_bits_dataRequest),
    .io_reqIn_bits_isWrite(gen_imem_host_io_reqIn_bits_isWrite),
    .io_rspOut_valid(gen_imem_host_io_rspOut_valid),
    .io_rspOut_bits_dataResponse(gen_imem_host_io_rspOut_bits_dataResponse)
  );
  WishboneDevice gen_imem_slave ( // @[Generator.scala 123:32]
    .io_wbSlaveTransmitter_ready(gen_imem_slave_io_wbSlaveTransmitter_ready),
    .io_wbSlaveTransmitter_bits_ack(gen_imem_slave_io_wbSlaveTransmitter_bits_ack),
    .io_wbSlaveTransmitter_bits_dat(gen_imem_slave_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(gen_imem_slave_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_ready(gen_imem_slave_io_wbMasterReceiver_ready),
    .io_wbMasterReceiver_valid(gen_imem_slave_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(gen_imem_slave_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(gen_imem_slave_io_wbMasterReceiver_bits_stb),
    .io_wbMasterReceiver_bits_we(gen_imem_slave_io_wbMasterReceiver_bits_we),
    .io_wbMasterReceiver_bits_adr(gen_imem_slave_io_wbMasterReceiver_bits_adr),
    .io_wbMasterReceiver_bits_dat(gen_imem_slave_io_wbMasterReceiver_bits_dat),
    .io_wbMasterReceiver_bits_sel(gen_imem_slave_io_wbMasterReceiver_bits_sel),
    .io_reqOut_valid(gen_imem_slave_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(gen_imem_slave_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(gen_imem_slave_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(gen_imem_slave_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(gen_imem_slave_io_reqOut_bits_isWrite),
    .io_rspIn_valid(gen_imem_slave_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(gen_imem_slave_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(gen_imem_slave_io_rspIn_bits_error)
  );
  WishboneHost gen_dmem_host ( // @[Generator.scala 124:31]
    .clock(gen_dmem_host_clock),
    .reset(gen_dmem_host_reset),
    .io_wbMasterTransmitter_ready(gen_dmem_host_io_wbMasterTransmitter_ready),
    .io_wbMasterTransmitter_valid(gen_dmem_host_io_wbMasterTransmitter_valid),
    .io_wbMasterTransmitter_bits_cyc(gen_dmem_host_io_wbMasterTransmitter_bits_cyc),
    .io_wbMasterTransmitter_bits_stb(gen_dmem_host_io_wbMasterTransmitter_bits_stb),
    .io_wbMasterTransmitter_bits_we(gen_dmem_host_io_wbMasterTransmitter_bits_we),
    .io_wbMasterTransmitter_bits_adr(gen_dmem_host_io_wbMasterTransmitter_bits_adr),
    .io_wbMasterTransmitter_bits_dat(gen_dmem_host_io_wbMasterTransmitter_bits_dat),
    .io_wbMasterTransmitter_bits_sel(gen_dmem_host_io_wbMasterTransmitter_bits_sel),
    .io_wbSlaveReceiver_ready(gen_dmem_host_io_wbSlaveReceiver_ready),
    .io_wbSlaveReceiver_bits_ack(gen_dmem_host_io_wbSlaveReceiver_bits_ack),
    .io_wbSlaveReceiver_bits_dat(gen_dmem_host_io_wbSlaveReceiver_bits_dat),
    .io_wbSlaveReceiver_bits_err(gen_dmem_host_io_wbSlaveReceiver_bits_err),
    .io_reqIn_ready(gen_dmem_host_io_reqIn_ready),
    .io_reqIn_valid(gen_dmem_host_io_reqIn_valid),
    .io_reqIn_bits_addrRequest(gen_dmem_host_io_reqIn_bits_addrRequest),
    .io_reqIn_bits_dataRequest(gen_dmem_host_io_reqIn_bits_dataRequest),
    .io_reqIn_bits_isWrite(gen_dmem_host_io_reqIn_bits_isWrite),
    .io_rspOut_valid(gen_dmem_host_io_rspOut_valid),
    .io_rspOut_bits_dataResponse(gen_dmem_host_io_rspOut_bits_dataResponse)
  );
  WishboneDevice gen_dmem_slave ( // @[Generator.scala 125:32]
    .io_wbSlaveTransmitter_ready(gen_dmem_slave_io_wbSlaveTransmitter_ready),
    .io_wbSlaveTransmitter_bits_ack(gen_dmem_slave_io_wbSlaveTransmitter_bits_ack),
    .io_wbSlaveTransmitter_bits_dat(gen_dmem_slave_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(gen_dmem_slave_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_ready(gen_dmem_slave_io_wbMasterReceiver_ready),
    .io_wbMasterReceiver_valid(gen_dmem_slave_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(gen_dmem_slave_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(gen_dmem_slave_io_wbMasterReceiver_bits_stb),
    .io_wbMasterReceiver_bits_we(gen_dmem_slave_io_wbMasterReceiver_bits_we),
    .io_wbMasterReceiver_bits_adr(gen_dmem_slave_io_wbMasterReceiver_bits_adr),
    .io_wbMasterReceiver_bits_dat(gen_dmem_slave_io_wbMasterReceiver_bits_dat),
    .io_wbMasterReceiver_bits_sel(gen_dmem_slave_io_wbMasterReceiver_bits_sel),
    .io_reqOut_valid(gen_dmem_slave_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(gen_dmem_slave_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(gen_dmem_slave_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(gen_dmem_slave_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(gen_dmem_slave_io_reqOut_bits_isWrite),
    .io_rspIn_valid(gen_dmem_slave_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(gen_dmem_slave_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(gen_dmem_slave_io_rspIn_bits_error)
  );
  Gpio gpio ( // @[Generator.scala 133:26]
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
    .io_cio_gpio_en_o(gpio_io_cio_gpio_en_o)
  );
  WishboneDevice gen_gpio_slave ( // @[Generator.scala 134:36]
    .io_wbSlaveTransmitter_ready(gen_gpio_slave_io_wbSlaveTransmitter_ready),
    .io_wbSlaveTransmitter_bits_ack(gen_gpio_slave_io_wbSlaveTransmitter_bits_ack),
    .io_wbSlaveTransmitter_bits_dat(gen_gpio_slave_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(gen_gpio_slave_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_ready(gen_gpio_slave_io_wbMasterReceiver_ready),
    .io_wbMasterReceiver_valid(gen_gpio_slave_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(gen_gpio_slave_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(gen_gpio_slave_io_wbMasterReceiver_bits_stb),
    .io_wbMasterReceiver_bits_we(gen_gpio_slave_io_wbMasterReceiver_bits_we),
    .io_wbMasterReceiver_bits_adr(gen_gpio_slave_io_wbMasterReceiver_bits_adr),
    .io_wbMasterReceiver_bits_dat(gen_gpio_slave_io_wbMasterReceiver_bits_dat),
    .io_wbMasterReceiver_bits_sel(gen_gpio_slave_io_wbMasterReceiver_bits_sel),
    .io_reqOut_valid(gen_gpio_slave_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(gen_gpio_slave_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(gen_gpio_slave_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(gen_gpio_slave_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(gen_gpio_slave_io_reqOut_bits_isWrite),
    .io_rspIn_valid(gen_gpio_slave_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(gen_gpio_slave_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(gen_gpio_slave_io_rspIn_bits_error)
  );
  BlockRamWithoutMasking imem ( // @[Generator.scala 215:22]
    .clock(imem_clock),
    .reset(imem_reset),
    .io_req_ready(imem_io_req_ready),
    .io_req_valid(imem_io_req_valid),
    .io_req_bits_addrRequest(imem_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(imem_io_req_bits_dataRequest),
    .io_req_bits_isWrite(imem_io_req_bits_isWrite),
    .io_rsp_valid(imem_io_rsp_valid),
    .io_rsp_bits_dataResponse(imem_io_rsp_bits_dataResponse),
    .io_rsp_bits_error(imem_io_rsp_bits_error)
  );
  BlockRamWithMasking dmem ( // @[Generator.scala 216:22]
    .clock(dmem_clock),
    .reset(dmem_reset),
    .io_req_ready(dmem_io_req_ready),
    .io_req_valid(dmem_io_req_valid),
    .io_req_bits_addrRequest(dmem_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(dmem_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(dmem_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(dmem_io_req_bits_isWrite),
    .io_rsp_valid(dmem_io_rsp_valid),
    .io_rsp_bits_dataResponse(dmem_io_rsp_bits_dataResponse)
  );
  WishboneErr wbErr ( // @[Generator.scala 218:23]
    .clock(wbErr_clock),
    .reset(wbErr_reset),
    .io_wbSlaveTransmitter_bits_dat(wbErr_io_wbSlaveTransmitter_bits_dat),
    .io_wbSlaveTransmitter_bits_err(wbErr_io_wbSlaveTransmitter_bits_err),
    .io_wbMasterReceiver_valid(wbErr_io_wbMasterReceiver_valid),
    .io_wbMasterReceiver_bits_cyc(wbErr_io_wbMasterReceiver_bits_cyc),
    .io_wbMasterReceiver_bits_stb(wbErr_io_wbMasterReceiver_bits_stb)
  );
  Core core ( // @[Generator.scala 219:22]
    .clock(core_clock),
    .reset(core_reset),
    .io_dmemReq_valid(core_io_dmemReq_valid),
    .io_dmemReq_bits_addrRequest(core_io_dmemReq_bits_addrRequest),
    .io_dmemReq_bits_dataRequest(core_io_dmemReq_bits_dataRequest),
    .io_dmemReq_bits_isWrite(core_io_dmemReq_bits_isWrite),
    .io_dmemRsp_valid(core_io_dmemRsp_valid),
    .io_dmemRsp_bits_dataResponse(core_io_dmemRsp_bits_dataResponse),
    .io_imemReq_ready(core_io_imemReq_ready),
    .io_imemReq_valid(core_io_imemReq_valid),
    .io_imemReq_bits_addrRequest(core_io_imemReq_bits_addrRequest),
    .io_imemRsp_valid(core_io_imemRsp_valid),
    .io_imemRsp_bits_dataResponse(core_io_imemRsp_bits_dataResponse)
  );
  Switch1toN switch ( // @[Generator.scala 224:24]
    .io_hostIn_valid(switch_io_hostIn_valid),
    .io_hostIn_bits_cyc(switch_io_hostIn_bits_cyc),
    .io_hostIn_bits_stb(switch_io_hostIn_bits_stb),
    .io_hostIn_bits_we(switch_io_hostIn_bits_we),
    .io_hostIn_bits_adr(switch_io_hostIn_bits_adr),
    .io_hostIn_bits_dat(switch_io_hostIn_bits_dat),
    .io_hostIn_bits_sel(switch_io_hostIn_bits_sel),
    .io_hostOut_bits_ack(switch_io_hostOut_bits_ack),
    .io_hostOut_bits_dat(switch_io_hostOut_bits_dat),
    .io_hostOut_bits_err(switch_io_hostOut_bits_err),
    .io_devOut_0_valid(switch_io_devOut_0_valid),
    .io_devOut_0_bits_cyc(switch_io_devOut_0_bits_cyc),
    .io_devOut_0_bits_stb(switch_io_devOut_0_bits_stb),
    .io_devOut_0_bits_we(switch_io_devOut_0_bits_we),
    .io_devOut_0_bits_adr(switch_io_devOut_0_bits_adr),
    .io_devOut_0_bits_dat(switch_io_devOut_0_bits_dat),
    .io_devOut_0_bits_sel(switch_io_devOut_0_bits_sel),
    .io_devOut_1_valid(switch_io_devOut_1_valid),
    .io_devOut_1_bits_cyc(switch_io_devOut_1_bits_cyc),
    .io_devOut_1_bits_stb(switch_io_devOut_1_bits_stb),
    .io_devOut_1_bits_we(switch_io_devOut_1_bits_we),
    .io_devOut_1_bits_adr(switch_io_devOut_1_bits_adr),
    .io_devOut_1_bits_dat(switch_io_devOut_1_bits_dat),
    .io_devOut_1_bits_sel(switch_io_devOut_1_bits_sel),
    .io_devOut_2_valid(switch_io_devOut_2_valid),
    .io_devOut_2_bits_cyc(switch_io_devOut_2_bits_cyc),
    .io_devOut_2_bits_stb(switch_io_devOut_2_bits_stb),
    .io_devIn_0_bits_ack(switch_io_devIn_0_bits_ack),
    .io_devIn_0_bits_dat(switch_io_devIn_0_bits_dat),
    .io_devIn_0_bits_err(switch_io_devIn_0_bits_err),
    .io_devIn_1_bits_ack(switch_io_devIn_1_bits_ack),
    .io_devIn_1_bits_dat(switch_io_devIn_1_bits_dat),
    .io_devIn_1_bits_err(switch_io_devIn_1_bits_err),
    .io_devIn_2_bits_dat(switch_io_devIn_2_bits_dat),
    .io_devIn_2_bits_err(switch_io_devIn_2_bits_err),
    .io_devSel(switch_io_devSel)
  );
  assign io_gpio_o = gpio_io_cio_gpio_o[3:0]; // @[Generator.scala 139:44]
  assign io_gpio_en_o = gpio_io_cio_gpio_en_o[3:0]; // @[Generator.scala 140:50]
  assign gen_imem_host_clock = clock;
  assign gen_imem_host_reset = reset;
  assign gen_imem_host_io_wbMasterTransmitter_ready = gen_imem_slave_io_wbMasterReceiver_ready; // @[Generator.scala 233:42]
  assign gen_imem_host_io_wbSlaveReceiver_bits_ack = gen_imem_slave_io_wbSlaveTransmitter_bits_ack; // @[Generator.scala 234:42]
  assign gen_imem_host_io_wbSlaveReceiver_bits_dat = gen_imem_slave_io_wbSlaveTransmitter_bits_dat; // @[Generator.scala 234:42]
  assign gen_imem_host_io_wbSlaveReceiver_bits_err = gen_imem_slave_io_wbSlaveTransmitter_bits_err; // @[Generator.scala 234:42]
  assign gen_imem_host_io_reqIn_valid = core_io_imemReq_valid; // @[Generator.scala 227:28]
  assign gen_imem_host_io_reqIn_bits_addrRequest = core_io_imemReq_bits_addrRequest; // @[Generator.scala 227:28]
  assign gen_imem_host_io_reqIn_bits_dataRequest = 32'h0; // @[Generator.scala 227:28]
  assign gen_imem_host_io_reqIn_bits_isWrite = 1'h0; // @[Generator.scala 227:28]
  assign gen_imem_slave_io_wbSlaveTransmitter_ready = gen_imem_host_io_wbSlaveReceiver_ready; // @[Generator.scala 234:42]
  assign gen_imem_slave_io_wbMasterReceiver_valid = gen_imem_host_io_wbMasterTransmitter_valid; // @[Generator.scala 233:42]
  assign gen_imem_slave_io_wbMasterReceiver_bits_cyc = gen_imem_host_io_wbMasterTransmitter_bits_cyc; // @[Generator.scala 233:42]
  assign gen_imem_slave_io_wbMasterReceiver_bits_stb = gen_imem_host_io_wbMasterTransmitter_bits_stb; // @[Generator.scala 233:42]
  assign gen_imem_slave_io_wbMasterReceiver_bits_we = gen_imem_host_io_wbMasterTransmitter_bits_we; // @[Generator.scala 233:42]
  assign gen_imem_slave_io_wbMasterReceiver_bits_adr = gen_imem_host_io_wbMasterTransmitter_bits_adr; // @[Generator.scala 233:42]
  assign gen_imem_slave_io_wbMasterReceiver_bits_dat = gen_imem_host_io_wbMasterTransmitter_bits_dat; // @[Generator.scala 233:42]
  assign gen_imem_slave_io_wbMasterReceiver_bits_sel = gen_imem_host_io_wbMasterTransmitter_bits_sel; // @[Generator.scala 233:42]
  assign gen_imem_slave_io_rspIn_valid = imem_io_rsp_valid; // @[Generator.scala 230:29]
  assign gen_imem_slave_io_rspIn_bits_dataResponse = imem_io_rsp_bits_dataResponse; // @[Generator.scala 230:29]
  assign gen_imem_slave_io_rspIn_bits_error = imem_io_rsp_bits_error; // @[Generator.scala 230:29]
  assign gen_dmem_host_clock = clock;
  assign gen_dmem_host_reset = reset;
  assign gen_dmem_host_io_wbMasterTransmitter_ready = 1'h1; // @[Generator.scala 244:22]
  assign gen_dmem_host_io_wbSlaveReceiver_bits_ack = switch_io_hostOut_bits_ack; // @[Generator.scala 245:23]
  assign gen_dmem_host_io_wbSlaveReceiver_bits_dat = switch_io_hostOut_bits_dat; // @[Generator.scala 245:23]
  assign gen_dmem_host_io_wbSlaveReceiver_bits_err = switch_io_hostOut_bits_err; // @[Generator.scala 245:23]
  assign gen_dmem_host_io_reqIn_valid = core_io_dmemReq_valid; // @[Generator.scala 237:28]
  assign gen_dmem_host_io_reqIn_bits_addrRequest = core_io_dmemReq_bits_addrRequest; // @[Generator.scala 237:28]
  assign gen_dmem_host_io_reqIn_bits_dataRequest = core_io_dmemReq_bits_dataRequest; // @[Generator.scala 237:28]
  assign gen_dmem_host_io_reqIn_bits_isWrite = core_io_dmemReq_bits_isWrite; // @[Generator.scala 237:28]
  assign gen_dmem_slave_io_wbSlaveTransmitter_ready = 1'h1; // @[Generator.scala 247:55]
  assign gen_dmem_slave_io_wbMasterReceiver_valid = switch_io_devOut_0_valid; // @[Generator.scala 248:56]
  assign gen_dmem_slave_io_wbMasterReceiver_bits_cyc = switch_io_devOut_0_bits_cyc; // @[Generator.scala 248:56]
  assign gen_dmem_slave_io_wbMasterReceiver_bits_stb = switch_io_devOut_0_bits_stb; // @[Generator.scala 248:56]
  assign gen_dmem_slave_io_wbMasterReceiver_bits_we = switch_io_devOut_0_bits_we; // @[Generator.scala 248:56]
  assign gen_dmem_slave_io_wbMasterReceiver_bits_adr = switch_io_devOut_0_bits_adr; // @[Generator.scala 248:56]
  assign gen_dmem_slave_io_wbMasterReceiver_bits_dat = switch_io_devOut_0_bits_dat; // @[Generator.scala 248:56]
  assign gen_dmem_slave_io_wbMasterReceiver_bits_sel = switch_io_devOut_0_bits_sel; // @[Generator.scala 248:56]
  assign gen_dmem_slave_io_rspIn_valid = dmem_io_rsp_valid; // @[Generator.scala 240:29]
  assign gen_dmem_slave_io_rspIn_bits_dataResponse = dmem_io_rsp_bits_dataResponse; // @[Generator.scala 240:29]
  assign gen_dmem_slave_io_rspIn_bits_error = 1'h0; // @[Generator.scala 240:29]
  assign gpio_clock = clock;
  assign gpio_reset = reset;
  assign gpio_io_req_valid = gen_gpio_slave_io_reqOut_valid; // @[Generator.scala 136:34]
  assign gpio_io_req_bits_addrRequest = gen_gpio_slave_io_reqOut_bits_addrRequest; // @[Generator.scala 136:34]
  assign gpio_io_req_bits_dataRequest = gen_gpio_slave_io_reqOut_bits_dataRequest; // @[Generator.scala 136:34]
  assign gpio_io_req_bits_activeByteLane = gen_gpio_slave_io_reqOut_bits_activeByteLane; // @[Generator.scala 136:34]
  assign gpio_io_req_bits_isWrite = gen_gpio_slave_io_reqOut_bits_isWrite; // @[Generator.scala 136:34]
  assign gpio_io_cio_gpio_i = {{28'd0}, io_gpio_i}; // @[Generator.scala 141:28]
  assign gen_gpio_slave_io_wbSlaveTransmitter_ready = 1'h1; // @[Generator.scala 247:55]
  assign gen_gpio_slave_io_wbMasterReceiver_valid = switch_io_devOut_1_valid; // @[Generator.scala 248:56]
  assign gen_gpio_slave_io_wbMasterReceiver_bits_cyc = switch_io_devOut_1_bits_cyc; // @[Generator.scala 248:56]
  assign gen_gpio_slave_io_wbMasterReceiver_bits_stb = switch_io_devOut_1_bits_stb; // @[Generator.scala 248:56]
  assign gen_gpio_slave_io_wbMasterReceiver_bits_we = switch_io_devOut_1_bits_we; // @[Generator.scala 248:56]
  assign gen_gpio_slave_io_wbMasterReceiver_bits_adr = switch_io_devOut_1_bits_adr; // @[Generator.scala 248:56]
  assign gen_gpio_slave_io_wbMasterReceiver_bits_dat = switch_io_devOut_1_bits_dat; // @[Generator.scala 248:56]
  assign gen_gpio_slave_io_wbMasterReceiver_bits_sel = switch_io_devOut_1_bits_sel; // @[Generator.scala 248:56]
  assign gen_gpio_slave_io_rspIn_valid = gpio_io_rsp_valid; // @[Generator.scala 137:33]
  assign gen_gpio_slave_io_rspIn_bits_dataResponse = gpio_io_rsp_bits_dataResponse; // @[Generator.scala 137:33]
  assign gen_gpio_slave_io_rspIn_bits_error = gpio_io_rsp_bits_error; // @[Generator.scala 137:33]
  assign imem_clock = clock;
  assign imem_reset = reset;
  assign imem_io_req_valid = gen_imem_slave_io_reqOut_valid; // @[Generator.scala 229:30]
  assign imem_io_req_bits_addrRequest = gen_imem_slave_io_reqOut_bits_addrRequest; // @[Generator.scala 229:30]
  assign imem_io_req_bits_dataRequest = gen_imem_slave_io_reqOut_bits_dataRequest; // @[Generator.scala 229:30]
  assign imem_io_req_bits_isWrite = gen_imem_slave_io_reqOut_bits_isWrite; // @[Generator.scala 229:30]
  assign dmem_clock = clock;
  assign dmem_reset = reset;
  assign dmem_io_req_valid = gen_dmem_slave_io_reqOut_valid; // @[Generator.scala 239:30]
  assign dmem_io_req_bits_addrRequest = gen_dmem_slave_io_reqOut_bits_addrRequest; // @[Generator.scala 239:30]
  assign dmem_io_req_bits_dataRequest = gen_dmem_slave_io_reqOut_bits_dataRequest; // @[Generator.scala 239:30]
  assign dmem_io_req_bits_activeByteLane = gen_dmem_slave_io_reqOut_bits_activeByteLane; // @[Generator.scala 239:30]
  assign dmem_io_req_bits_isWrite = gen_dmem_slave_io_reqOut_bits_isWrite; // @[Generator.scala 239:30]
  assign wbErr_clock = clock;
  assign wbErr_reset = reset;
  assign wbErr_io_wbMasterReceiver_valid = switch_io_devOut_2_valid; // @[Generator.scala 251:36]
  assign wbErr_io_wbMasterReceiver_bits_cyc = switch_io_devOut_2_bits_cyc; // @[Generator.scala 251:36]
  assign wbErr_io_wbMasterReceiver_bits_stb = switch_io_devOut_2_bits_stb; // @[Generator.scala 251:36]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_dmemRsp_valid = gen_dmem_host_io_rspOut_valid; // @[Generator.scala 238:21]
  assign core_io_dmemRsp_bits_dataResponse = gen_dmem_host_io_rspOut_bits_dataResponse; // @[Generator.scala 238:21]
  assign core_io_imemReq_ready = gen_imem_host_io_reqIn_ready; // @[Generator.scala 227:28]
  assign core_io_imemRsp_valid = gen_imem_host_io_rspOut_valid; // @[Generator.scala 228:21]
  assign core_io_imemRsp_bits_dataResponse = gen_imem_host_io_rspOut_bits_dataResponse; // @[Generator.scala 228:21]
  assign switch_io_hostIn_valid = gen_dmem_host_io_wbMasterTransmitter_valid; // @[Generator.scala 244:22]
  assign switch_io_hostIn_bits_cyc = gen_dmem_host_io_wbMasterTransmitter_bits_cyc; // @[Generator.scala 244:22]
  assign switch_io_hostIn_bits_stb = gen_dmem_host_io_wbMasterTransmitter_bits_stb; // @[Generator.scala 244:22]
  assign switch_io_hostIn_bits_we = gen_dmem_host_io_wbMasterTransmitter_bits_we; // @[Generator.scala 244:22]
  assign switch_io_hostIn_bits_adr = gen_dmem_host_io_wbMasterTransmitter_bits_adr; // @[Generator.scala 244:22]
  assign switch_io_hostIn_bits_dat = gen_dmem_host_io_wbMasterTransmitter_bits_dat; // @[Generator.scala 244:22]
  assign switch_io_hostIn_bits_sel = gen_dmem_host_io_wbMasterTransmitter_bits_sel; // @[Generator.scala 244:22]
  assign switch_io_devIn_0_bits_ack = gen_dmem_slave_io_wbSlaveTransmitter_bits_ack; // @[Generator.scala 247:55]
  assign switch_io_devIn_0_bits_dat = gen_dmem_slave_io_wbSlaveTransmitter_bits_dat; // @[Generator.scala 247:55]
  assign switch_io_devIn_0_bits_err = gen_dmem_slave_io_wbSlaveTransmitter_bits_err; // @[Generator.scala 247:55]
  assign switch_io_devIn_1_bits_ack = gen_gpio_slave_io_wbSlaveTransmitter_bits_ack; // @[Generator.scala 247:55]
  assign switch_io_devIn_1_bits_dat = gen_gpio_slave_io_wbSlaveTransmitter_bits_dat; // @[Generator.scala 247:55]
  assign switch_io_devIn_1_bits_err = gen_gpio_slave_io_wbSlaveTransmitter_bits_err; // @[Generator.scala 247:55]
  assign switch_io_devIn_2_bits_dat = wbErr_io_wbSlaveTransmitter_bits_dat; // @[Generator.scala 250:35]
  assign switch_io_devIn_2_bits_err = wbErr_io_wbSlaveTransmitter_bits_err; // @[Generator.scala 250:35]
  assign switch_io_devSel = switch_io_devSel_addr_hit_0 ? switch_io_devSel_id_0 : _switch_io_devSel_T; // @[Mux.scala 98:16]
endmodule
module SoCNow(
  input   clock,
  input   reset,
  inout   io_gpio_io_0,
  inout   io_gpio_io_1,
  inout   io_gpio_io_2,
  inout   io_gpio_io_3
);
  wire  gen_clock; // @[Generator.scala 27:21]
  wire  gen_reset; // @[Generator.scala 27:21]
  wire [3:0] gen_io_gpio_o; // @[Generator.scala 27:21]
  wire [3:0] gen_io_gpio_en_o; // @[Generator.scala 27:21]
  wire [3:0] gen_io_gpio_i; // @[Generator.scala 27:21]
  wire  pll_clk_in1; // @[Generator.scala 28:21]
  wire  pll_clk_out1; // @[Generator.scala 28:21]
  wire  gpioPads_0_O; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_0_I; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_0_T; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_1_O; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_1_I; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_1_T; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_2_O; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_2_I; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_2_T; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_3_O; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_3_I; // @[TriStateBuffer.scala 21:81]
  wire  gpioPads_3_T; // @[TriStateBuffer.scala 21:81]
  wire  gpioEnableWires_0 = gen_io_gpio_en_o[0]; // @[Generator.scala 49:54]
  wire  gpioEnableWires_1 = gen_io_gpio_en_o[1]; // @[Generator.scala 49:54]
  wire  gpioEnableWires_2 = gen_io_gpio_en_o[2]; // @[Generator.scala 49:54]
  wire  gpioEnableWires_3 = gen_io_gpio_en_o[3]; // @[Generator.scala 49:54]
  wire  gpioInputWires_1 = gpioPads_1_O; // @[Generator.scala 34:32 TriStateBuffer.scala 16:11]
  wire  gpioInputWires_0 = gpioPads_0_O; // @[Generator.scala 34:32 TriStateBuffer.scala 16:11]
  wire [1:0] gen_io_gpio_i_lo = {gpioInputWires_1,gpioInputWires_0}; // @[Generator.scala 47:49]
  wire  gpioInputWires_3 = gpioPads_3_O; // @[Generator.scala 34:32 TriStateBuffer.scala 16:11]
  wire  gpioInputWires_2 = gpioPads_2_O; // @[Generator.scala 34:32 TriStateBuffer.scala 16:11]
  wire [1:0] gen_io_gpio_i_hi = {gpioInputWires_3,gpioInputWires_2}; // @[Generator.scala 47:49]
  Generator gen ( // @[Generator.scala 27:21]
    .clock(gen_clock),
    .reset(gen_reset),
    .io_gpio_o(gen_io_gpio_o),
    .io_gpio_en_o(gen_io_gpio_en_o),
    .io_gpio_i(gen_io_gpio_i)
  );
  PLL_8MHz pll ( // @[Generator.scala 28:21]
    .clk_in1(pll_clk_in1),
    .clk_out1(pll_clk_out1)
  );
  IOBUF gpioPads_0 ( // @[TriStateBuffer.scala 21:81]
    .O(gpioPads_0_O),
    .IO(io_gpio_io_0),
    .I(gpioPads_0_I),
    .T(gpioPads_0_T)
  );
  IOBUF gpioPads_1 ( // @[TriStateBuffer.scala 21:81]
    .O(gpioPads_1_O),
    .IO(io_gpio_io_1),
    .I(gpioPads_1_I),
    .T(gpioPads_1_T)
  );
  IOBUF gpioPads_2 ( // @[TriStateBuffer.scala 21:81]
    .O(gpioPads_2_O),
    .IO(io_gpio_io_2),
    .I(gpioPads_2_I),
    .T(gpioPads_2_T)
  );
  IOBUF gpioPads_3 ( // @[TriStateBuffer.scala 21:81]
    .O(gpioPads_3_O),
    .IO(io_gpio_io_3),
    .I(gpioPads_3_I),
    .T(gpioPads_3_T)
  );
  assign gen_clock = pll_clk_out1; // @[Generator.scala 31:15]
  assign gen_reset = reset;
  assign gen_io_gpio_i = {gen_io_gpio_i_hi,gen_io_gpio_i_lo}; // @[Generator.scala 47:49]
  assign pll_clk_in1 = clock; // @[Generator.scala 30:20]
  assign gpioPads_0_I = gen_io_gpio_o[0]; // @[Generator.scala 48:51]
  assign gpioPads_0_T = ~gpioEnableWires_0; // @[TriStateBuffer.scala 15:10]
  assign gpioPads_1_I = gen_io_gpio_o[1]; // @[Generator.scala 48:51]
  assign gpioPads_1_T = ~gpioEnableWires_1; // @[TriStateBuffer.scala 15:10]
  assign gpioPads_2_I = gen_io_gpio_o[2]; // @[Generator.scala 48:51]
  assign gpioPads_2_T = ~gpioEnableWires_2; // @[TriStateBuffer.scala 15:10]
  assign gpioPads_3_I = gen_io_gpio_o[3]; // @[Generator.scala 48:51]
  assign gpioPads_3_T = ~gpioEnableWires_3; // @[TriStateBuffer.scala 15:10]
endmodule
