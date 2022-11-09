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
module i2c_master(
  input        clock,
  input        reset,
  input        io_start,
  input  [6:0] io_addr,
  input  [7:0] io_data,
  input        io_read_write,
  input        io_i2c_sda_in,
  output       io_i2c_sda,
  output       io_i2c_scl,
  output       io_i2c_intr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] state; // @[i2c_master.scala 25:24]
  reg [14:0] count; // @[i2c_master.scala 26:24]
  reg [6:0] saved_addr; // @[i2c_master.scala 27:29]
  reg  i2c_scl_enable; // @[i2c_master.scala 29:33]
  reg  intr_done; // @[i2c_master.scala 30:28]
  wire  _GEN_0 = state == 8'h0 | state == 8'h1 | state == 8'h7 ? 1'h0 : 1'h1; // @[i2c_master.scala 46:87 i2c_master.scala 47:28 i2c_master.scala 49:29]
  wire  _GEN_1 = reset ? 1'h0 : _GEN_0; // @[i2c_master.scala 43:22 i2c_master.scala 44:24]
  wire  _T_7 = 8'h0 == state; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_2 = io_start ? 3'h1 : 3'h0; // @[i2c_master.scala 61:39 i2c_master.scala 62:27 i2c_master.scala 66:27]
  wire  _T_9 = 8'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_10 = 8'h2 == state; // @[Conditional.scala 37:30]
  wire [6:0] _io_i2c_sda_T = saved_addr >> count; // @[i2c_master.scala 82:41]
  wire  _T_11 = count == 15'h0; // @[i2c_master.scala 85:28]
  wire [14:0] _count_T_1 = count - 15'h1; // @[i2c_master.scala 88:36]
  wire [2:0] _GEN_4 = count == 15'h0 ? 3'h3 : 3'h2; // @[i2c_master.scala 85:36 i2c_master.scala 86:27 i2c_master.scala 89:27]
  wire [14:0] _GEN_5 = count == 15'h0 ? count : _count_T_1; // @[i2c_master.scala 85:36 i2c_master.scala 26:24 i2c_master.scala 88:27]
  wire  _T_12 = 8'h3 == state; // @[Conditional.scala 37:30]
  wire  _T_13 = 8'h4 == state; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_6 = ~io_i2c_sda_in ? 3'h5 : 3'h7; // @[i2c_master.scala 105:48 i2c_master.scala 106:31 i2c_master.scala 111:31]
  wire [14:0] _GEN_7 = ~io_i2c_sda_in ? 15'h7 : count; // @[i2c_master.scala 105:48 i2c_master.scala 107:31 i2c_master.scala 26:24]
  wire  _T_15 = 8'h5 == state; // @[Conditional.scala 37:30]
  wire [7:0] _io_i2c_sda_T_2 = io_data >> count; // @[i2c_master.scala 120:38]
  wire [2:0] _GEN_9 = _T_11 ? 3'h6 : 3'h5; // @[i2c_master.scala 123:36 i2c_master.scala 124:27 i2c_master.scala 127:27]
  wire  _T_17 = 8'h6 == state; // @[Conditional.scala 37:30]
  wire  _T_18 = 8'h7 == state; // @[Conditional.scala 37:30]
  wire  _GEN_12 = _T_18 | intr_done; // @[Conditional.scala 39:67 i2c_master.scala 141:27 i2c_master.scala 30:28]
  wire  _GEN_16 = _T_17 ? io_i2c_sda_in : 1'h1; // @[Conditional.scala 39:67 i2c_master.scala 133:28]
  wire [2:0] _GEN_19 = _T_17 ? 3'h7 : 3'h0; // @[Conditional.scala 39:67 i2c_master.scala 136:23]
  wire  _GEN_20 = _T_17 ? intr_done : _GEN_12; // @[Conditional.scala 39:67 i2c_master.scala 30:28]
  wire  _GEN_21 = _T_15 ? _io_i2c_sda_T_2[0] : _GEN_16; // @[Conditional.scala 39:67 i2c_master.scala 120:28]
  wire [2:0] _GEN_24 = _T_15 ? _GEN_9 : _GEN_19; // @[Conditional.scala 39:67]
  wire [14:0] _GEN_25 = _T_15 ? _GEN_5 : count; // @[Conditional.scala 39:67 i2c_master.scala 26:24]
  wire  _GEN_26 = _T_15 ? intr_done : _GEN_20; // @[Conditional.scala 39:67 i2c_master.scala 30:28]
  wire  _GEN_27 = _T_13 ? io_i2c_sda_in : _GEN_21; // @[Conditional.scala 39:67 i2c_master.scala 104:32]
  wire [2:0] _GEN_28 = _T_13 ? _GEN_6 : _GEN_24; // @[Conditional.scala 39:67]
  wire [14:0] _GEN_29 = _T_13 ? _GEN_7 : _GEN_25; // @[Conditional.scala 39:67]
  wire  _GEN_32 = _T_13 ? intr_done : _GEN_26; // @[Conditional.scala 39:67 i2c_master.scala 30:28]
  wire  _GEN_33 = _T_12 ? io_read_write : _GEN_27; // @[Conditional.scala 39:67 i2c_master.scala 95:28]
  wire [2:0] _GEN_36 = _T_12 ? 3'h4 : _GEN_28; // @[Conditional.scala 39:67 i2c_master.scala 98:23]
  wire [14:0] _GEN_37 = _T_12 ? count : _GEN_29; // @[Conditional.scala 39:67 i2c_master.scala 26:24]
  wire  _GEN_38 = _T_12 ? intr_done : _GEN_32; // @[Conditional.scala 39:67 i2c_master.scala 30:28]
  wire  _GEN_39 = _T_10 ? _io_i2c_sda_T[0] : _GEN_33; // @[Conditional.scala 39:67 i2c_master.scala 82:28]
  wire [2:0] _GEN_42 = _T_10 ? _GEN_4 : _GEN_36; // @[Conditional.scala 39:67]
  wire [14:0] _GEN_43 = _T_10 ? _GEN_5 : _GEN_37; // @[Conditional.scala 39:67]
  wire  _GEN_44 = _T_10 ? intr_done : _GEN_38; // @[Conditional.scala 39:67 i2c_master.scala 30:28]
  wire  _GEN_45 = _T_9 ? 1'h0 : _GEN_39; // @[Conditional.scala 39:67 i2c_master.scala 72:28]
  wire [2:0] _GEN_50 = _T_9 ? 3'h2 : _GEN_42; // @[Conditional.scala 39:67 i2c_master.scala 77:23]
  wire  _GEN_53 = _T_7 | _GEN_45; // @[Conditional.scala 40:58 i2c_master.scala 59:28]
  wire [2:0] _GEN_55 = _T_7 ? _GEN_2 : _GEN_50; // @[Conditional.scala 40:58]
  wire [2:0] _GEN_61 = reset ? 3'h0 : _GEN_55; // @[i2c_master.scala 53:22 i2c_master.scala 54:15]
  assign io_i2c_sda = reset | _GEN_53; // @[i2c_master.scala 53:22 i2c_master.scala 55:20]
  assign io_i2c_scl = ~i2c_scl_enable | ~clock; // @[i2c_master.scala 41:22]
  assign io_i2c_intr = intr_done; // @[i2c_master.scala 149:17]
  always @(posedge clock) begin
    if (reset) begin // @[i2c_master.scala 25:24]
      state <= 8'h0; // @[i2c_master.scala 25:24]
    end else begin
      state <= {{5'd0}, _GEN_61};
    end
    if (reset) begin // @[i2c_master.scala 26:24]
      count <= 15'h0; // @[i2c_master.scala 26:24]
    end else if (!(reset)) begin // @[i2c_master.scala 53:22]
      if (!(_T_7)) begin // @[Conditional.scala 40:58]
        if (_T_9) begin // @[Conditional.scala 39:67]
          count <= 15'h6; // @[i2c_master.scala 78:23]
        end else begin
          count <= _GEN_43;
        end
      end
    end
    if (reset) begin // @[i2c_master.scala 27:29]
      saved_addr <= 7'h0; // @[i2c_master.scala 27:29]
    end else if (!(reset)) begin // @[i2c_master.scala 53:22]
      if (!(_T_7)) begin // @[Conditional.scala 40:58]
        if (_T_9) begin // @[Conditional.scala 39:67]
          saved_addr <= io_addr; // @[i2c_master.scala 73:28]
        end
      end
    end
    i2c_scl_enable <= reset | _GEN_1; // @[i2c_master.scala 29:33 i2c_master.scala 29:33]
    if (reset) begin // @[i2c_master.scala 30:28]
      intr_done <= 1'h0; // @[i2c_master.scala 30:28]
    end else if (!(reset)) begin // @[i2c_master.scala 53:22]
      if (_T_7) begin // @[Conditional.scala 40:58]
        intr_done <= 1'h0; // @[i2c_master.scala 60:27]
      end else if (!(_T_9)) begin // @[Conditional.scala 39:67]
        intr_done <= _GEN_44;
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
  state = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  count = _RAND_1[14:0];
  _RAND_2 = {1{`RANDOM}};
  saved_addr = _RAND_2[6:0];
  _RAND_3 = {1{`RANDOM}};
  i2c_scl_enable = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  intr_done = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module I2C_Top(
  input         clock,
  input         reset,
  input  [31:0] io_wdata,
  input  [6:0]  io_addr,
  input         io_ren,
  input         io_we,
  output        io_sda,
  output        io_scl,
  output        io_intr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire  i2c_master_clock; // @[I2C_Top.scala 63:28]
  wire  i2c_master_reset; // @[I2C_Top.scala 63:28]
  wire  i2c_master_io_start; // @[I2C_Top.scala 63:28]
  wire [6:0] i2c_master_io_addr; // @[I2C_Top.scala 63:28]
  wire [7:0] i2c_master_io_data; // @[I2C_Top.scala 63:28]
  wire  i2c_master_io_read_write; // @[I2C_Top.scala 63:28]
  wire  i2c_master_io_i2c_sda_in; // @[I2C_Top.scala 63:28]
  wire  i2c_master_io_i2c_sda; // @[I2C_Top.scala 63:28]
  wire  i2c_master_io_i2c_scl; // @[I2C_Top.scala 63:28]
  wire  i2c_master_io_i2c_intr; // @[I2C_Top.scala 63:28]
  reg  addr_start_bit; // @[I2C_Top.scala 31:33]
  reg [6:0] addr_slave_addr; // @[I2C_Top.scala 32:34]
  reg [7:0] addr_data; // @[I2C_Top.scala 33:28]
  reg  addr_read_write_bit; // @[I2C_Top.scala 34:38]
  reg  addr_sda_in; // @[I2C_Top.scala 35:30]
  wire  _GEN_0 = io_addr == 7'hc ? io_wdata[0] : addr_sda_in; // @[I2C_Top.scala 49:40 I2C_Top.scala 50:22 I2C_Top.scala 35:30]
  wire  _GEN_1 = io_addr == 7'hc & addr_start_bit; // @[I2C_Top.scala 49:40 I2C_Top.scala 31:33 I2C_Top.scala 54:24]
  wire [6:0] _GEN_2 = io_addr == 7'hc ? addr_slave_addr : 7'h0; // @[I2C_Top.scala 49:40 I2C_Top.scala 32:34 I2C_Top.scala 55:25]
  wire [7:0] _GEN_3 = io_addr == 7'hc ? addr_data : 8'h0; // @[I2C_Top.scala 49:40 I2C_Top.scala 33:28 I2C_Top.scala 56:19]
  wire  _GEN_4 = io_addr == 7'h8 ? io_wdata[0] : addr_read_write_bit; // @[I2C_Top.scala 47:48 I2C_Top.scala 48:29 I2C_Top.scala 34:38]
  wire  _GEN_5 = io_addr == 7'h8 ? addr_sda_in : _GEN_0; // @[I2C_Top.scala 47:48 I2C_Top.scala 35:30]
  wire  _GEN_6 = io_addr == 7'h8 ? addr_start_bit : _GEN_1; // @[I2C_Top.scala 47:48 I2C_Top.scala 31:33]
  wire [6:0] _GEN_7 = io_addr == 7'h8 ? addr_slave_addr : _GEN_2; // @[I2C_Top.scala 47:48 I2C_Top.scala 32:34]
  wire [7:0] _GEN_8 = io_addr == 7'h8 ? addr_data : _GEN_3; // @[I2C_Top.scala 47:48 I2C_Top.scala 33:28]
  wire [7:0] _GEN_9 = io_addr == 7'h10 ? io_wdata[7:0] : _GEN_8; // @[I2C_Top.scala 45:38 I2C_Top.scala 46:19]
  wire  _GEN_10 = io_addr == 7'h10 ? addr_read_write_bit : _GEN_4; // @[I2C_Top.scala 45:38 I2C_Top.scala 34:38]
  wire  _GEN_11 = io_addr == 7'h10 ? addr_sda_in : _GEN_5; // @[I2C_Top.scala 45:38 I2C_Top.scala 35:30]
  wire  _GEN_12 = io_addr == 7'h10 ? addr_start_bit : _GEN_6; // @[I2C_Top.scala 45:38 I2C_Top.scala 31:33]
  wire [6:0] _GEN_13 = io_addr == 7'h10 ? addr_slave_addr : _GEN_7; // @[I2C_Top.scala 45:38 I2C_Top.scala 32:34]
  wire  _GEN_17 = io_addr == 7'h4 ? addr_sda_in : _GEN_11; // @[I2C_Top.scala 43:44 I2C_Top.scala 35:30]
  wire  _GEN_23 = io_addr == 7'h0 ? addr_sda_in : _GEN_17; // @[I2C_Top.scala 41:37 I2C_Top.scala 35:30]
  wire  _GEN_28 = ~io_ren & io_we ? _GEN_23 : addr_sda_in; // @[I2C_Top.scala 40:29 I2C_Top.scala 35:30]
  i2c_master i2c_master ( // @[I2C_Top.scala 63:28]
    .clock(i2c_master_clock),
    .reset(i2c_master_reset),
    .io_start(i2c_master_io_start),
    .io_addr(i2c_master_io_addr),
    .io_data(i2c_master_io_data),
    .io_read_write(i2c_master_io_read_write),
    .io_i2c_sda_in(i2c_master_io_i2c_sda_in),
    .io_i2c_sda(i2c_master_io_i2c_sda),
    .io_i2c_scl(i2c_master_io_i2c_scl),
    .io_i2c_intr(i2c_master_io_i2c_intr)
  );
  assign io_sda = i2c_master_io_i2c_sda; // @[I2C_Top.scala 70:12]
  assign io_scl = i2c_master_io_i2c_scl; // @[I2C_Top.scala 71:12]
  assign io_intr = i2c_master_io_i2c_intr; // @[I2C_Top.scala 72:13]
  assign i2c_master_clock = clock;
  assign i2c_master_reset = reset;
  assign i2c_master_io_start = addr_start_bit; // @[I2C_Top.scala 64:25]
  assign i2c_master_io_addr = addr_slave_addr; // @[I2C_Top.scala 65:24]
  assign i2c_master_io_data = addr_data; // @[I2C_Top.scala 66:24]
  assign i2c_master_io_read_write = addr_read_write_bit; // @[I2C_Top.scala 67:30]
  assign i2c_master_io_i2c_sda_in = addr_sda_in; // @[I2C_Top.scala 68:30]
  always @(posedge clock) begin
    if (reset) begin // @[I2C_Top.scala 31:33]
      addr_start_bit <= 1'h0; // @[I2C_Top.scala 31:33]
    end else if (~io_ren & io_we) begin // @[I2C_Top.scala 40:29]
      if (io_addr == 7'h0) begin // @[I2C_Top.scala 41:37]
        addr_start_bit <= io_wdata[0]; // @[I2C_Top.scala 42:24]
      end else if (!(io_addr == 7'h4)) begin // @[I2C_Top.scala 43:44]
        addr_start_bit <= _GEN_12;
      end
    end
    if (reset) begin // @[I2C_Top.scala 32:34]
      addr_slave_addr <= 7'h0; // @[I2C_Top.scala 32:34]
    end else if (~io_ren & io_we) begin // @[I2C_Top.scala 40:29]
      if (!(io_addr == 7'h0)) begin // @[I2C_Top.scala 41:37]
        if (io_addr == 7'h4) begin // @[I2C_Top.scala 43:44]
          addr_slave_addr <= io_wdata[6:0]; // @[I2C_Top.scala 44:25]
        end else begin
          addr_slave_addr <= _GEN_13;
        end
      end
    end
    if (reset) begin // @[I2C_Top.scala 33:28]
      addr_data <= 8'h0; // @[I2C_Top.scala 33:28]
    end else if (~io_ren & io_we) begin // @[I2C_Top.scala 40:29]
      if (!(io_addr == 7'h0)) begin // @[I2C_Top.scala 41:37]
        if (!(io_addr == 7'h4)) begin // @[I2C_Top.scala 43:44]
          addr_data <= _GEN_9;
        end
      end
    end
    if (reset) begin // @[I2C_Top.scala 34:38]
      addr_read_write_bit <= 1'h0; // @[I2C_Top.scala 34:38]
    end else if (~io_ren & io_we) begin // @[I2C_Top.scala 40:29]
      if (!(io_addr == 7'h0)) begin // @[I2C_Top.scala 41:37]
        if (!(io_addr == 7'h4)) begin // @[I2C_Top.scala 43:44]
          addr_read_write_bit <= _GEN_10;
        end
      end
    end
    addr_sda_in <= reset | _GEN_28; // @[I2C_Top.scala 35:30 I2C_Top.scala 35:30]
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
  addr_start_bit = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  addr_slave_addr = _RAND_1[6:0];
  _RAND_2 = {1{`RANDOM}};
  addr_data = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  addr_read_write_bit = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  addr_sda_in = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module i2c(
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
  output        io_cio_i2c_sda,
  output        io_cio_i2c_scl,
  output        io_cio_i2c_intr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  i2c_top_clock; // @[i2c.scala 19:26]
  wire  i2c_top_reset; // @[i2c.scala 19:26]
  wire [31:0] i2c_top_io_wdata; // @[i2c.scala 19:26]
  wire [6:0] i2c_top_io_addr; // @[i2c.scala 19:26]
  wire  i2c_top_io_ren; // @[i2c.scala 19:26]
  wire  i2c_top_io_we; // @[i2c.scala 19:26]
  wire  i2c_top_io_sda; // @[i2c.scala 19:26]
  wire  i2c_top_io_scl; // @[i2c.scala 19:26]
  wire  i2c_top_io_intr; // @[i2c.scala 19:26]
  wire  _write_register_T = io_request_ready & io_request_valid; // @[Decoupled.scala 40:37]
  wire  write_register = _write_register_T & io_request_bits_isWrite; // @[i2c.scala 26:26]
  wire  read_register = _write_register_T & ~io_request_bits_isWrite; // @[i2c.scala 27:25]
  reg [31:0] io_response_bits_dataResponse_REG; // @[i2c.scala 35:45]
  reg  io_response_valid_REG; // @[i2c.scala 36:33]
  reg  io_response_bits_error_REG; // @[i2c.scala 37:38]
  wire [7:0] addr_reg = {{1'd0}, io_request_bits_addrRequest[6:0]}; // @[i2c.scala 24:24 i2c.scala 29:14]
  I2C_Top i2c_top ( // @[i2c.scala 19:26]
    .clock(i2c_top_clock),
    .reset(i2c_top_reset),
    .io_wdata(i2c_top_io_wdata),
    .io_addr(i2c_top_io_addr),
    .io_ren(i2c_top_io_ren),
    .io_we(i2c_top_io_we),
    .io_sda(i2c_top_io_sda),
    .io_scl(i2c_top_io_scl),
    .io_intr(i2c_top_io_intr)
  );
  assign io_request_ready = 1'h1; // @[i2c.scala 17:22]
  assign io_response_valid = io_response_valid_REG; // @[i2c.scala 36:23]
  assign io_response_bits_dataResponse = io_response_bits_dataResponse_REG; // @[i2c.scala 35:35]
  assign io_response_bits_error = io_response_bits_error_REG; // @[i2c.scala 37:28]
  assign io_cio_i2c_sda = i2c_top_io_sda; // @[i2c.scala 41:20]
  assign io_cio_i2c_scl = i2c_top_io_scl; // @[i2c.scala 42:20]
  assign io_cio_i2c_intr = i2c_top_io_intr; // @[i2c.scala 43:21]
  assign i2c_top_clock = clock;
  assign i2c_top_reset = reset;
  assign i2c_top_io_wdata = io_request_bits_dataRequest; // @[i2c.scala 23:24 i2c.scala 28:14]
  assign i2c_top_io_addr = addr_reg[6:0]; // @[i2c.scala 31:21]
  assign i2c_top_io_ren = _write_register_T & ~io_request_bits_isWrite; // @[i2c.scala 27:25]
  assign i2c_top_io_we = _write_register_T & io_request_bits_isWrite; // @[i2c.scala 26:26]
  always @(posedge clock) begin
    io_response_bits_dataResponse_REG <= i2c_top_io_wdata; // @[i2c.scala 35:49]
    io_response_valid_REG <= write_register | read_register; // @[i2c.scala 36:53]
    io_response_bits_error_REG <= i2c_top_io_intr; // @[i2c.scala 37:42]
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
module I2CHarnessWB(
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
  input         io_cio_i2c_sda_in,
  output        io_cio_i2c_sda,
  output        io_cio_i2c_scl,
  output        io_cio_i2c_intr
);
  wire  hostAdapter_clock; // @[Harness.scala 90:27]
  wire  hostAdapter_reset; // @[Harness.scala 90:27]
  wire  hostAdapter_io_wbMasterTransmitter_ready; // @[Harness.scala 90:27]
  wire  hostAdapter_io_wbMasterTransmitter_valid; // @[Harness.scala 90:27]
  wire  hostAdapter_io_wbMasterTransmitter_bits_cyc; // @[Harness.scala 90:27]
  wire  hostAdapter_io_wbMasterTransmitter_bits_stb; // @[Harness.scala 90:27]
  wire  hostAdapter_io_wbMasterTransmitter_bits_we; // @[Harness.scala 90:27]
  wire [31:0] hostAdapter_io_wbMasterTransmitter_bits_adr; // @[Harness.scala 90:27]
  wire [31:0] hostAdapter_io_wbMasterTransmitter_bits_dat; // @[Harness.scala 90:27]
  wire  hostAdapter_io_wbSlaveReceiver_ready; // @[Harness.scala 90:27]
  wire  hostAdapter_io_wbSlaveReceiver_bits_ack; // @[Harness.scala 90:27]
  wire [31:0] hostAdapter_io_wbSlaveReceiver_bits_dat; // @[Harness.scala 90:27]
  wire  hostAdapter_io_wbSlaveReceiver_bits_err; // @[Harness.scala 90:27]
  wire  hostAdapter_io_reqIn_ready; // @[Harness.scala 90:27]
  wire  hostAdapter_io_reqIn_valid; // @[Harness.scala 90:27]
  wire [31:0] hostAdapter_io_reqIn_bits_addrRequest; // @[Harness.scala 90:27]
  wire [31:0] hostAdapter_io_reqIn_bits_dataRequest; // @[Harness.scala 90:27]
  wire  hostAdapter_io_reqIn_bits_isWrite; // @[Harness.scala 90:27]
  wire  hostAdapter_io_rspOut_valid; // @[Harness.scala 90:27]
  wire [31:0] hostAdapter_io_rspOut_bits_dataResponse; // @[Harness.scala 90:27]
  wire  hostAdapter_io_rspOut_bits_error; // @[Harness.scala 90:27]
  wire  deviceAdapter_io_wbSlaveTransmitter_ready; // @[Harness.scala 91:29]
  wire  deviceAdapter_io_wbSlaveTransmitter_bits_ack; // @[Harness.scala 91:29]
  wire [31:0] deviceAdapter_io_wbSlaveTransmitter_bits_dat; // @[Harness.scala 91:29]
  wire  deviceAdapter_io_wbSlaveTransmitter_bits_err; // @[Harness.scala 91:29]
  wire  deviceAdapter_io_wbMasterReceiver_ready; // @[Harness.scala 91:29]
  wire  deviceAdapter_io_wbMasterReceiver_valid; // @[Harness.scala 91:29]
  wire  deviceAdapter_io_wbMasterReceiver_bits_cyc; // @[Harness.scala 91:29]
  wire  deviceAdapter_io_wbMasterReceiver_bits_stb; // @[Harness.scala 91:29]
  wire  deviceAdapter_io_wbMasterReceiver_bits_we; // @[Harness.scala 91:29]
  wire [31:0] deviceAdapter_io_wbMasterReceiver_bits_adr; // @[Harness.scala 91:29]
  wire [31:0] deviceAdapter_io_wbMasterReceiver_bits_dat; // @[Harness.scala 91:29]
  wire  deviceAdapter_io_reqOut_valid; // @[Harness.scala 91:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_addrRequest; // @[Harness.scala 91:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_dataRequest; // @[Harness.scala 91:29]
  wire  deviceAdapter_io_reqOut_bits_isWrite; // @[Harness.scala 91:29]
  wire  deviceAdapter_io_rspIn_valid; // @[Harness.scala 91:29]
  wire [31:0] deviceAdapter_io_rspIn_bits_dataResponse; // @[Harness.scala 91:29]
  wire  deviceAdapter_io_rspIn_bits_error; // @[Harness.scala 91:29]
  wire  i2c_clock; // @[Harness.scala 92:19]
  wire  i2c_reset; // @[Harness.scala 92:19]
  wire  i2c_io_request_ready; // @[Harness.scala 92:19]
  wire  i2c_io_request_valid; // @[Harness.scala 92:19]
  wire [31:0] i2c_io_request_bits_addrRequest; // @[Harness.scala 92:19]
  wire [31:0] i2c_io_request_bits_dataRequest; // @[Harness.scala 92:19]
  wire  i2c_io_request_bits_isWrite; // @[Harness.scala 92:19]
  wire  i2c_io_response_valid; // @[Harness.scala 92:19]
  wire [31:0] i2c_io_response_bits_dataResponse; // @[Harness.scala 92:19]
  wire  i2c_io_response_bits_error; // @[Harness.scala 92:19]
  wire  i2c_io_cio_i2c_sda; // @[Harness.scala 92:19]
  wire  i2c_io_cio_i2c_scl; // @[Harness.scala 92:19]
  wire  i2c_io_cio_i2c_intr; // @[Harness.scala 92:19]
  WishboneHost hostAdapter ( // @[Harness.scala 90:27]
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
  WishboneDevice deviceAdapter ( // @[Harness.scala 91:29]
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
  i2c i2c ( // @[Harness.scala 92:19]
    .clock(i2c_clock),
    .reset(i2c_reset),
    .io_request_ready(i2c_io_request_ready),
    .io_request_valid(i2c_io_request_valid),
    .io_request_bits_addrRequest(i2c_io_request_bits_addrRequest),
    .io_request_bits_dataRequest(i2c_io_request_bits_dataRequest),
    .io_request_bits_isWrite(i2c_io_request_bits_isWrite),
    .io_response_valid(i2c_io_response_valid),
    .io_response_bits_dataResponse(i2c_io_response_bits_dataResponse),
    .io_response_bits_error(i2c_io_response_bits_error),
    .io_cio_i2c_sda(i2c_io_cio_i2c_sda),
    .io_cio_i2c_scl(i2c_io_cio_i2c_scl),
    .io_cio_i2c_intr(i2c_io_cio_i2c_intr)
  );
  assign io_req_ready = hostAdapter_io_reqIn_ready; // @[Harness.scala 94:24]
  assign io_rsp_valid = hostAdapter_io_rspOut_valid; // @[Harness.scala 95:10]
  assign io_rsp_bits_dataResponse = hostAdapter_io_rspOut_bits_dataResponse; // @[Harness.scala 95:10]
  assign io_rsp_bits_error = hostAdapter_io_rspOut_bits_error; // @[Harness.scala 95:10]
  assign io_cio_i2c_sda = i2c_io_cio_i2c_sda; // @[Harness.scala 104:18]
  assign io_cio_i2c_scl = i2c_io_cio_i2c_scl; // @[Harness.scala 105:18]
  assign io_cio_i2c_intr = i2c_io_cio_i2c_intr; // @[Harness.scala 106:19]
  assign hostAdapter_clock = clock;
  assign hostAdapter_reset = reset;
  assign hostAdapter_io_wbMasterTransmitter_ready = deviceAdapter_io_wbMasterReceiver_ready; // @[Harness.scala 97:38]
  assign hostAdapter_io_wbSlaveReceiver_bits_ack = deviceAdapter_io_wbSlaveTransmitter_bits_ack; // @[Harness.scala 98:34]
  assign hostAdapter_io_wbSlaveReceiver_bits_dat = deviceAdapter_io_wbSlaveTransmitter_bits_dat; // @[Harness.scala 98:34]
  assign hostAdapter_io_wbSlaveReceiver_bits_err = deviceAdapter_io_wbSlaveTransmitter_bits_err; // @[Harness.scala 98:34]
  assign hostAdapter_io_reqIn_valid = io_req_valid; // @[Harness.scala 94:24]
  assign hostAdapter_io_reqIn_bits_addrRequest = io_req_bits_addrRequest; // @[Harness.scala 94:24]
  assign hostAdapter_io_reqIn_bits_dataRequest = io_req_bits_dataRequest; // @[Harness.scala 94:24]
  assign hostAdapter_io_reqIn_bits_isWrite = io_req_bits_isWrite; // @[Harness.scala 94:24]
  assign deviceAdapter_io_wbSlaveTransmitter_ready = hostAdapter_io_wbSlaveReceiver_ready; // @[Harness.scala 98:34]
  assign deviceAdapter_io_wbMasterReceiver_valid = hostAdapter_io_wbMasterTransmitter_valid; // @[Harness.scala 97:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_cyc = hostAdapter_io_wbMasterTransmitter_bits_cyc; // @[Harness.scala 97:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_stb = hostAdapter_io_wbMasterTransmitter_bits_stb; // @[Harness.scala 97:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_we = hostAdapter_io_wbMasterTransmitter_bits_we; // @[Harness.scala 97:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_adr = hostAdapter_io_wbMasterTransmitter_bits_adr; // @[Harness.scala 97:38]
  assign deviceAdapter_io_wbMasterReceiver_bits_dat = hostAdapter_io_wbMasterTransmitter_bits_dat; // @[Harness.scala 97:38]
  assign deviceAdapter_io_rspIn_valid = i2c_io_response_valid; // @[Harness.scala 101:19]
  assign deviceAdapter_io_rspIn_bits_dataResponse = i2c_io_response_bits_dataResponse; // @[Harness.scala 101:19]
  assign deviceAdapter_io_rspIn_bits_error = i2c_io_response_bits_error; // @[Harness.scala 101:19]
  assign i2c_clock = clock;
  assign i2c_reset = reset;
  assign i2c_io_request_valid = deviceAdapter_io_reqOut_valid; // @[Harness.scala 100:18]
  assign i2c_io_request_bits_addrRequest = deviceAdapter_io_reqOut_bits_addrRequest; // @[Harness.scala 100:18]
  assign i2c_io_request_bits_dataRequest = deviceAdapter_io_reqOut_bits_dataRequest; // @[Harness.scala 100:18]
  assign i2c_io_request_bits_isWrite = deviceAdapter_io_reqOut_bits_isWrite; // @[Harness.scala 100:18]
endmodule
