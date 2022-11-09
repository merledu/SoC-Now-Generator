module TilelinkHost(
  input         clock,
  input         reset,
  output        io_tlMasterTransmitter_valid,
  output [2:0]  io_tlMasterTransmitter_bits_a_opcode,
  output [31:0] io_tlMasterTransmitter_bits_a_address,
  output [79:0] io_tlMasterTransmitter_bits_a_data,
  input         io_tlSlaveReceiver_valid,
  input         io_tlSlaveReceiver_bits_d_denied,
  input  [79:0] io_tlSlaveReceiver_bits_d_data,
  output        io_reqIn_ready,
  input         io_reqIn_valid,
  input  [31:0] io_reqIn_bits_addrRequest,
  input  [79:0] io_reqIn_bits_dataRequest,
  input  [9:0]  io_reqIn_bits_activeByteLane,
  input         io_reqIn_bits_isWrite,
  output        io_rspOut_valid,
  output [79:0] io_rspOut_bits_dataResponse,
  output        io_rspOut_bits_error
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[TilelinkHost.scala 19:27]
  reg [31:0] addrReg; // @[TilelinkHost.scala 20:27]
  wire  _io_tlMasterTransmitter_bits_a_opcode_T_1 = io_reqIn_bits_activeByteLane == 10'hf ? 1'h0 : 1'h1; // @[TilelinkHost.scala 62:86]
  wire [2:0] _io_tlMasterTransmitter_bits_a_opcode_T_2 = io_reqIn_bits_isWrite ? {{2'd0},
    _io_tlMasterTransmitter_bits_a_opcode_T_1} : 3'h4; // @[TilelinkHost.scala 62:59]
  wire [2:0] _GEN_0 = io_reqIn_valid ? _io_tlMasterTransmitter_bits_a_opcode_T_2 : 3'h0; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 62:53 TilelinkHost.scala 40:45]
  wire [79:0] _GEN_1 = io_reqIn_valid ? io_reqIn_bits_dataRequest : 80'h0; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 63:53 TilelinkHost.scala 41:45]
  wire [31:0] _GEN_2 = io_reqIn_valid ? io_reqIn_bits_addrRequest : addrReg; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 64:53 TilelinkHost.scala 42:45]
  wire  _GEN_8 = io_reqIn_valid | stateReg; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 77:22 TilelinkHost.scala 19:27]
  wire [79:0] _GEN_10 = io_tlSlaveReceiver_valid ? io_tlSlaveReceiver_bits_d_data : 80'h0; // @[TilelinkHost.scala 89:39 TilelinkHost.scala 91:41 TilelinkHost.scala 50:45]
  wire  _GEN_11 = io_tlSlaveReceiver_valid & io_tlSlaveReceiver_bits_d_denied; // @[TilelinkHost.scala 89:39 TilelinkHost.scala 92:34 TilelinkHost.scala 51:45]
  wire  _GEN_15 = stateReg ? 1'h0 : 1'h1; // @[TilelinkHost.scala 84:43 TilelinkHost.scala 87:34 TilelinkHost.scala 33:33]
  wire [79:0] _GEN_16 = stateReg ? _GEN_10 : 80'h0; // @[TilelinkHost.scala 84:43 TilelinkHost.scala 50:45]
  wire  _GEN_17 = stateReg & _GEN_11; // @[TilelinkHost.scala 84:43 TilelinkHost.scala 51:45]
  wire  _GEN_18 = stateReg & io_tlSlaveReceiver_valid; // @[TilelinkHost.scala 84:43 TilelinkHost.scala 53:45]
  assign io_tlMasterTransmitter_valid = ~stateReg & io_reqIn_valid; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 48:45]
  assign io_tlMasterTransmitter_bits_a_opcode = ~stateReg ? _GEN_0 : 3'h0; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 40:45]
  assign io_tlMasterTransmitter_bits_a_address = ~stateReg ? _GEN_2 : addrReg; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 42:45]
  assign io_tlMasterTransmitter_bits_a_data = ~stateReg ? _GEN_1 : 80'h0; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 41:45]
  assign io_reqIn_ready = ~stateReg | _GEN_15; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 33:33]
  assign io_rspOut_valid = ~stateReg ? 1'h0 : _GEN_18; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 53:45]
  assign io_rspOut_bits_dataResponse = ~stateReg ? 80'h0 : _GEN_16; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 50:45]
  assign io_rspOut_bits_error = ~stateReg ? 1'h0 : _GEN_17; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 51:45]
  always @(posedge clock) begin
    if (reset) begin // @[TilelinkHost.scala 19:27]
      stateReg <= 1'h0; // @[TilelinkHost.scala 19:27]
    end else if (~stateReg) begin // @[TilelinkHost.scala 56:28]
      stateReg <= _GEN_8;
    end else if (stateReg) begin // @[TilelinkHost.scala 84:43]
      if (io_tlSlaveReceiver_valid) begin // @[TilelinkHost.scala 89:39]
        stateReg <= 1'h0; // @[TilelinkHost.scala 95:22]
      end
    end
    if (reset) begin // @[TilelinkHost.scala 20:27]
      addrReg <= 32'h0; // @[TilelinkHost.scala 20:27]
    end else if (~stateReg) begin // @[TilelinkHost.scala 56:28]
      if (io_reqIn_valid) begin // @[TilelinkHost.scala 60:29]
        addrReg <= io_reqIn_bits_addrRequest; // @[TilelinkHost.scala 64:53]
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
  stateReg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  addrReg = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TilelinkDevice(
  input         clock,
  input         reset,
  output        io_tlSlaveTransmitter_valid,
  output        io_tlSlaveTransmitter_bits_d_denied,
  output [79:0] io_tlSlaveTransmitter_bits_d_data,
  input         io_tlMasterReceiver_valid,
  input  [2:0]  io_tlMasterReceiver_bits_a_opcode,
  input  [31:0] io_tlMasterReceiver_bits_a_address,
  input  [79:0] io_tlMasterReceiver_bits_a_data,
  output        io_reqOut_valid,
  output [31:0] io_reqOut_bits_addrRequest,
  output [79:0] io_reqOut_bits_dataRequest,
  output        io_reqOut_bits_isWrite,
  output        io_rspIn_ready,
  input         io_rspIn_valid,
  input  [79:0] io_rspIn_bits_dataResponse,
  input         io_rspIn_bits_error
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[TilelinkDevice.scala 17:27]
  wire [31:0] _GEN_0 = io_tlMasterReceiver_valid ? io_tlMasterReceiver_bits_a_address : 32'h0; // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 45:40 TilelinkDevice.scala 23:37]
  wire [79:0] _GEN_1 = io_tlMasterReceiver_valid ? io_tlMasterReceiver_bits_a_data : 80'h0; // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 46:40 TilelinkDevice.scala 24:37]
  wire  _GEN_3 = io_tlMasterReceiver_valid & (io_tlMasterReceiver_bits_a_opcode == 3'h0 |
    io_tlMasterReceiver_bits_a_opcode == 3'h1); // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 48:36 TilelinkDevice.scala 26:37]
  wire  _GEN_5 = io_tlMasterReceiver_valid | stateReg; // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 51:22 TilelinkDevice.scala 17:27]
  wire [79:0] _GEN_7 = io_rspIn_valid ? io_rspIn_bits_dataResponse : 80'h0; // @[TilelinkDevice.scala 60:29 TilelinkDevice.scala 63:47 TilelinkDevice.scala 30:45]
  wire  _GEN_11 = io_rspIn_valid & io_rspIn_bits_error; // @[TilelinkDevice.scala 60:29 TilelinkDevice.scala 68:49 TilelinkDevice.scala 35:45]
  wire  _GEN_15 = stateReg & io_rspIn_valid; // @[TilelinkDevice.scala 56:43 TilelinkDevice.scala 29:45]
  wire [79:0] _GEN_16 = stateReg ? _GEN_7 : 80'h0; // @[TilelinkDevice.scala 56:43 TilelinkDevice.scala 30:45]
  wire  _GEN_20 = stateReg & _GEN_11; // @[TilelinkDevice.scala 56:43 TilelinkDevice.scala 35:45]
  assign io_tlSlaveTransmitter_valid = ~stateReg ? 1'h0 : _GEN_15; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 37:45]
  assign io_tlSlaveTransmitter_bits_d_denied = ~stateReg ? 1'h0 : _GEN_20; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 35:45]
  assign io_tlSlaveTransmitter_bits_d_data = ~stateReg ? 80'h0 : _GEN_16; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 30:45]
  assign io_reqOut_valid = ~stateReg & io_tlMasterReceiver_valid; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 27:37]
  assign io_reqOut_bits_addrRequest = ~stateReg ? _GEN_0 : 32'h0; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 23:37]
  assign io_reqOut_bits_dataRequest = ~stateReg ? _GEN_1 : 80'h0; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 24:37]
  assign io_reqOut_bits_isWrite = ~stateReg & _GEN_3; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 26:37]
  assign io_rspIn_ready = ~stateReg ? io_tlMasterReceiver_valid : stateReg; // @[TilelinkDevice.scala 41:28]
  always @(posedge clock) begin
    if (reset) begin // @[TilelinkDevice.scala 17:27]
      stateReg <= 1'h0; // @[TilelinkDevice.scala 17:27]
    end else if (~stateReg) begin // @[TilelinkDevice.scala 41:28]
      stateReg <= _GEN_5;
    end else if (stateReg) begin // @[TilelinkDevice.scala 56:43]
      if (io_rspIn_valid) begin // @[TilelinkDevice.scala 60:29]
        stateReg <= 1'h0; // @[TilelinkDevice.scala 72:22]
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
  stateReg = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
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
  input  [79:0] io_request_bits_dataRequest,
  input         io_request_bits_isWrite,
  input         io_response_ready,
  output        io_response_valid,
  output [79:0] io_response_bits_dataResponse,
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
  assign io_response_bits_dataResponse = {{48'd0}, io_response_bits_dataResponse_REG}; // @[i2c.scala 35:35]
  assign io_response_bits_error = io_response_bits_error_REG; // @[i2c.scala 37:28]
  assign io_cio_i2c_sda = i2c_top_io_sda; // @[i2c.scala 41:20]
  assign io_cio_i2c_scl = i2c_top_io_scl; // @[i2c.scala 42:20]
  assign io_cio_i2c_intr = i2c_top_io_intr; // @[i2c.scala 43:21]
  assign i2c_top_clock = clock;
  assign i2c_top_reset = reset;
  assign i2c_top_io_wdata = io_request_bits_dataRequest[31:0]; // @[i2c.scala 23:24 i2c.scala 28:14]
  assign i2c_top_io_addr = addr_reg[6:0]; // @[i2c.scala 31:21]
  assign i2c_top_io_ren = _write_register_T & ~io_request_bits_isWrite; // @[i2c.scala 27:25]
  assign i2c_top_io_we = _write_register_T & io_request_bits_isWrite; // @[i2c.scala 26:26]
  always @(posedge clock) begin
    if (io_response_ready) begin // @[i2c.scala 35:49]
      io_response_bits_dataResponse_REG <= i2c_top_io_wdata;
    end else begin
      io_response_bits_dataResponse_REG <= 32'h0;
    end
    io_response_valid_REG <= write_register | read_register; // @[i2c.scala 36:53]
    io_response_bits_error_REG <= io_response_ready & i2c_top_io_intr; // @[i2c.scala 37:42]
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
module I2CHarnessTL(
  input         clock,
  input         reset,
  output        io_req_ready,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [79:0] io_req_bits_dataRequest,
  input  [9:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  input         io_rsp_ready,
  output        io_rsp_valid,
  output [79:0] io_rsp_bits_dataResponse,
  output        io_rsp_bits_error,
  input         io_cio_i2c_sda_in,
  output        io_cio_i2c_sda,
  output        io_cio_i2c_scl,
  output        io_cio_i2c_intr
);
  wire  hostAdapter_clock; // @[Harness.scala 125:27]
  wire  hostAdapter_reset; // @[Harness.scala 125:27]
  wire  hostAdapter_io_tlMasterTransmitter_valid; // @[Harness.scala 125:27]
  wire [2:0] hostAdapter_io_tlMasterTransmitter_bits_a_opcode; // @[Harness.scala 125:27]
  wire [31:0] hostAdapter_io_tlMasterTransmitter_bits_a_address; // @[Harness.scala 125:27]
  wire [79:0] hostAdapter_io_tlMasterTransmitter_bits_a_data; // @[Harness.scala 125:27]
  wire  hostAdapter_io_tlSlaveReceiver_valid; // @[Harness.scala 125:27]
  wire  hostAdapter_io_tlSlaveReceiver_bits_d_denied; // @[Harness.scala 125:27]
  wire [79:0] hostAdapter_io_tlSlaveReceiver_bits_d_data; // @[Harness.scala 125:27]
  wire  hostAdapter_io_reqIn_ready; // @[Harness.scala 125:27]
  wire  hostAdapter_io_reqIn_valid; // @[Harness.scala 125:27]
  wire [31:0] hostAdapter_io_reqIn_bits_addrRequest; // @[Harness.scala 125:27]
  wire [79:0] hostAdapter_io_reqIn_bits_dataRequest; // @[Harness.scala 125:27]
  wire [9:0] hostAdapter_io_reqIn_bits_activeByteLane; // @[Harness.scala 125:27]
  wire  hostAdapter_io_reqIn_bits_isWrite; // @[Harness.scala 125:27]
  wire  hostAdapter_io_rspOut_valid; // @[Harness.scala 125:27]
  wire [79:0] hostAdapter_io_rspOut_bits_dataResponse; // @[Harness.scala 125:27]
  wire  hostAdapter_io_rspOut_bits_error; // @[Harness.scala 125:27]
  wire  deviceAdapter_clock; // @[Harness.scala 126:29]
  wire  deviceAdapter_reset; // @[Harness.scala 126:29]
  wire  deviceAdapter_io_tlSlaveTransmitter_valid; // @[Harness.scala 126:29]
  wire  deviceAdapter_io_tlSlaveTransmitter_bits_d_denied; // @[Harness.scala 126:29]
  wire [79:0] deviceAdapter_io_tlSlaveTransmitter_bits_d_data; // @[Harness.scala 126:29]
  wire  deviceAdapter_io_tlMasterReceiver_valid; // @[Harness.scala 126:29]
  wire [2:0] deviceAdapter_io_tlMasterReceiver_bits_a_opcode; // @[Harness.scala 126:29]
  wire [31:0] deviceAdapter_io_tlMasterReceiver_bits_a_address; // @[Harness.scala 126:29]
  wire [79:0] deviceAdapter_io_tlMasterReceiver_bits_a_data; // @[Harness.scala 126:29]
  wire  deviceAdapter_io_reqOut_valid; // @[Harness.scala 126:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_addrRequest; // @[Harness.scala 126:29]
  wire [79:0] deviceAdapter_io_reqOut_bits_dataRequest; // @[Harness.scala 126:29]
  wire  deviceAdapter_io_reqOut_bits_isWrite; // @[Harness.scala 126:29]
  wire  deviceAdapter_io_rspIn_ready; // @[Harness.scala 126:29]
  wire  deviceAdapter_io_rspIn_valid; // @[Harness.scala 126:29]
  wire [79:0] deviceAdapter_io_rspIn_bits_dataResponse; // @[Harness.scala 126:29]
  wire  deviceAdapter_io_rspIn_bits_error; // @[Harness.scala 126:29]
  wire  i2c_clock; // @[Harness.scala 127:19]
  wire  i2c_reset; // @[Harness.scala 127:19]
  wire  i2c_io_request_ready; // @[Harness.scala 127:19]
  wire  i2c_io_request_valid; // @[Harness.scala 127:19]
  wire [31:0] i2c_io_request_bits_addrRequest; // @[Harness.scala 127:19]
  wire [79:0] i2c_io_request_bits_dataRequest; // @[Harness.scala 127:19]
  wire  i2c_io_request_bits_isWrite; // @[Harness.scala 127:19]
  wire  i2c_io_response_ready; // @[Harness.scala 127:19]
  wire  i2c_io_response_valid; // @[Harness.scala 127:19]
  wire [79:0] i2c_io_response_bits_dataResponse; // @[Harness.scala 127:19]
  wire  i2c_io_response_bits_error; // @[Harness.scala 127:19]
  wire  i2c_io_cio_i2c_sda; // @[Harness.scala 127:19]
  wire  i2c_io_cio_i2c_scl; // @[Harness.scala 127:19]
  wire  i2c_io_cio_i2c_intr; // @[Harness.scala 127:19]
  TilelinkHost hostAdapter ( // @[Harness.scala 125:27]
    .clock(hostAdapter_clock),
    .reset(hostAdapter_reset),
    .io_tlMasterTransmitter_valid(hostAdapter_io_tlMasterTransmitter_valid),
    .io_tlMasterTransmitter_bits_a_opcode(hostAdapter_io_tlMasterTransmitter_bits_a_opcode),
    .io_tlMasterTransmitter_bits_a_address(hostAdapter_io_tlMasterTransmitter_bits_a_address),
    .io_tlMasterTransmitter_bits_a_data(hostAdapter_io_tlMasterTransmitter_bits_a_data),
    .io_tlSlaveReceiver_valid(hostAdapter_io_tlSlaveReceiver_valid),
    .io_tlSlaveReceiver_bits_d_denied(hostAdapter_io_tlSlaveReceiver_bits_d_denied),
    .io_tlSlaveReceiver_bits_d_data(hostAdapter_io_tlSlaveReceiver_bits_d_data),
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
  TilelinkDevice deviceAdapter ( // @[Harness.scala 126:29]
    .clock(deviceAdapter_clock),
    .reset(deviceAdapter_reset),
    .io_tlSlaveTransmitter_valid(deviceAdapter_io_tlSlaveTransmitter_valid),
    .io_tlSlaveTransmitter_bits_d_denied(deviceAdapter_io_tlSlaveTransmitter_bits_d_denied),
    .io_tlSlaveTransmitter_bits_d_data(deviceAdapter_io_tlSlaveTransmitter_bits_d_data),
    .io_tlMasterReceiver_valid(deviceAdapter_io_tlMasterReceiver_valid),
    .io_tlMasterReceiver_bits_a_opcode(deviceAdapter_io_tlMasterReceiver_bits_a_opcode),
    .io_tlMasterReceiver_bits_a_address(deviceAdapter_io_tlMasterReceiver_bits_a_address),
    .io_tlMasterReceiver_bits_a_data(deviceAdapter_io_tlMasterReceiver_bits_a_data),
    .io_reqOut_valid(deviceAdapter_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(deviceAdapter_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(deviceAdapter_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_isWrite(deviceAdapter_io_reqOut_bits_isWrite),
    .io_rspIn_ready(deviceAdapter_io_rspIn_ready),
    .io_rspIn_valid(deviceAdapter_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(deviceAdapter_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(deviceAdapter_io_rspIn_bits_error)
  );
  i2c i2c ( // @[Harness.scala 127:19]
    .clock(i2c_clock),
    .reset(i2c_reset),
    .io_request_ready(i2c_io_request_ready),
    .io_request_valid(i2c_io_request_valid),
    .io_request_bits_addrRequest(i2c_io_request_bits_addrRequest),
    .io_request_bits_dataRequest(i2c_io_request_bits_dataRequest),
    .io_request_bits_isWrite(i2c_io_request_bits_isWrite),
    .io_response_ready(i2c_io_response_ready),
    .io_response_valid(i2c_io_response_valid),
    .io_response_bits_dataResponse(i2c_io_response_bits_dataResponse),
    .io_response_bits_error(i2c_io_response_bits_error),
    .io_cio_i2c_sda(i2c_io_cio_i2c_sda),
    .io_cio_i2c_scl(i2c_io_cio_i2c_scl),
    .io_cio_i2c_intr(i2c_io_cio_i2c_intr)
  );
  assign io_req_ready = hostAdapter_io_reqIn_ready; // @[Harness.scala 129:24]
  assign io_rsp_valid = hostAdapter_io_rspOut_valid; // @[Harness.scala 130:10]
  assign io_rsp_bits_dataResponse = hostAdapter_io_rspOut_bits_dataResponse; // @[Harness.scala 130:10]
  assign io_rsp_bits_error = hostAdapter_io_rspOut_bits_error; // @[Harness.scala 130:10]
  assign io_cio_i2c_sda = i2c_io_cio_i2c_sda; // @[Harness.scala 139:18]
  assign io_cio_i2c_scl = i2c_io_cio_i2c_scl; // @[Harness.scala 140:18]
  assign io_cio_i2c_intr = i2c_io_cio_i2c_intr; // @[Harness.scala 141:19]
  assign hostAdapter_clock = clock;
  assign hostAdapter_reset = reset;
  assign hostAdapter_io_tlSlaveReceiver_valid = deviceAdapter_io_tlSlaveTransmitter_valid; // @[Harness.scala 133:34]
  assign hostAdapter_io_tlSlaveReceiver_bits_d_denied = deviceAdapter_io_tlSlaveTransmitter_bits_d_denied; // @[Harness.scala 133:34]
  assign hostAdapter_io_tlSlaveReceiver_bits_d_data = deviceAdapter_io_tlSlaveTransmitter_bits_d_data; // @[Harness.scala 133:34]
  assign hostAdapter_io_reqIn_valid = io_req_valid; // @[Harness.scala 129:24]
  assign hostAdapter_io_reqIn_bits_addrRequest = io_req_bits_addrRequest; // @[Harness.scala 129:24]
  assign hostAdapter_io_reqIn_bits_dataRequest = io_req_bits_dataRequest; // @[Harness.scala 129:24]
  assign hostAdapter_io_reqIn_bits_activeByteLane = io_req_bits_activeByteLane; // @[Harness.scala 129:24]
  assign hostAdapter_io_reqIn_bits_isWrite = io_req_bits_isWrite; // @[Harness.scala 129:24]
  assign deviceAdapter_clock = clock;
  assign deviceAdapter_reset = reset;
  assign deviceAdapter_io_tlMasterReceiver_valid = hostAdapter_io_tlMasterTransmitter_valid; // @[Harness.scala 132:38]
  assign deviceAdapter_io_tlMasterReceiver_bits_a_opcode = hostAdapter_io_tlMasterTransmitter_bits_a_opcode; // @[Harness.scala 132:38]
  assign deviceAdapter_io_tlMasterReceiver_bits_a_address = hostAdapter_io_tlMasterTransmitter_bits_a_address; // @[Harness.scala 132:38]
  assign deviceAdapter_io_tlMasterReceiver_bits_a_data = hostAdapter_io_tlMasterTransmitter_bits_a_data; // @[Harness.scala 132:38]
  assign deviceAdapter_io_rspIn_valid = i2c_io_response_valid; // @[Harness.scala 136:19]
  assign deviceAdapter_io_rspIn_bits_dataResponse = i2c_io_response_bits_dataResponse; // @[Harness.scala 136:19]
  assign deviceAdapter_io_rspIn_bits_error = i2c_io_response_bits_error; // @[Harness.scala 136:19]
  assign i2c_clock = clock;
  assign i2c_reset = reset;
  assign i2c_io_request_valid = deviceAdapter_io_reqOut_valid; // @[Harness.scala 135:18]
  assign i2c_io_request_bits_addrRequest = deviceAdapter_io_reqOut_bits_addrRequest; // @[Harness.scala 135:18]
  assign i2c_io_request_bits_dataRequest = deviceAdapter_io_reqOut_bits_dataRequest; // @[Harness.scala 135:18]
  assign i2c_io_request_bits_isWrite = deviceAdapter_io_reqOut_bits_isWrite; // @[Harness.scala 135:18]
  assign i2c_io_response_ready = deviceAdapter_io_rspIn_ready; // @[Harness.scala 136:19]
endmodule
