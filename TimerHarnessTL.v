module TilelinkHost(
  input         clock,
  input         reset,
  output        io_tlMasterTransmitter_valid,
  output [2:0]  io_tlMasterTransmitter_bits_a_opcode,
  output [31:0] io_tlMasterTransmitter_bits_a_address,
  output [3:0]  io_tlMasterTransmitter_bits_a_mask,
  output [31:0] io_tlMasterTransmitter_bits_a_data,
  input         io_tlSlaveReceiver_valid,
  input         io_tlSlaveReceiver_bits_d_denied,
  input  [31:0] io_tlSlaveReceiver_bits_d_data,
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
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[TilelinkHost.scala 19:27]
  reg [31:0] addrReg; // @[TilelinkHost.scala 20:27]
  wire  _io_tlMasterTransmitter_bits_a_opcode_T_1 = io_reqIn_bits_activeByteLane == 4'hf ? 1'h0 : 1'h1; // @[TilelinkHost.scala 62:86]
  wire [2:0] _io_tlMasterTransmitter_bits_a_opcode_T_2 = io_reqIn_bits_isWrite ? {{2'd0},
    _io_tlMasterTransmitter_bits_a_opcode_T_1} : 3'h4; // @[TilelinkHost.scala 62:59]
  wire [2:0] _GEN_0 = io_reqIn_valid ? _io_tlMasterTransmitter_bits_a_opcode_T_2 : 3'h0; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 62:53 TilelinkHost.scala 40:45]
  wire [31:0] _GEN_1 = io_reqIn_valid ? io_reqIn_bits_dataRequest : 32'h0; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 63:53 TilelinkHost.scala 41:45]
  wire [31:0] _GEN_2 = io_reqIn_valid ? io_reqIn_bits_addrRequest : addrReg; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 64:53 TilelinkHost.scala 42:45]
  wire [3:0] _GEN_6 = io_reqIn_valid ? io_reqIn_bits_activeByteLane : 4'h0; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 73:53 TilelinkHost.scala 46:45]
  wire  _GEN_8 = io_reqIn_valid | stateReg; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 77:22 TilelinkHost.scala 19:27]
  wire [31:0] _GEN_10 = io_tlSlaveReceiver_valid ? io_tlSlaveReceiver_bits_d_data : 32'h0; // @[TilelinkHost.scala 89:39 TilelinkHost.scala 91:41 TilelinkHost.scala 50:45]
  wire  _GEN_11 = io_tlSlaveReceiver_valid & io_tlSlaveReceiver_bits_d_denied; // @[TilelinkHost.scala 89:39 TilelinkHost.scala 92:34 TilelinkHost.scala 51:45]
  wire  _GEN_15 = stateReg ? 1'h0 : 1'h1; // @[TilelinkHost.scala 84:43 TilelinkHost.scala 87:34 TilelinkHost.scala 33:33]
  wire [31:0] _GEN_16 = stateReg ? _GEN_10 : 32'h0; // @[TilelinkHost.scala 84:43 TilelinkHost.scala 50:45]
  wire  _GEN_17 = stateReg & _GEN_11; // @[TilelinkHost.scala 84:43 TilelinkHost.scala 51:45]
  wire  _GEN_18 = stateReg & io_tlSlaveReceiver_valid; // @[TilelinkHost.scala 84:43 TilelinkHost.scala 53:45]
  assign io_tlMasterTransmitter_valid = ~stateReg & io_reqIn_valid; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 48:45]
  assign io_tlMasterTransmitter_bits_a_opcode = ~stateReg ? _GEN_0 : 3'h0; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 40:45]
  assign io_tlMasterTransmitter_bits_a_address = ~stateReg ? _GEN_2 : addrReg; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 42:45]
  assign io_tlMasterTransmitter_bits_a_mask = ~stateReg ? _GEN_6 : 4'h0; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 46:45]
  assign io_tlMasterTransmitter_bits_a_data = ~stateReg ? _GEN_1 : 32'h0; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 41:45]
  assign io_reqIn_ready = ~stateReg | _GEN_15; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 33:33]
  assign io_rspOut_valid = ~stateReg ? 1'h0 : _GEN_18; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 53:45]
  assign io_rspOut_bits_dataResponse = ~stateReg ? 32'h0 : _GEN_16; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 50:45]
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
  output [31:0] io_tlSlaveTransmitter_bits_d_data,
  input         io_tlMasterReceiver_valid,
  input  [2:0]  io_tlMasterReceiver_bits_a_opcode,
  input  [31:0] io_tlMasterReceiver_bits_a_address,
  input  [3:0]  io_tlMasterReceiver_bits_a_mask,
  input  [31:0] io_tlMasterReceiver_bits_a_data,
  output        io_reqOut_valid,
  output [31:0] io_reqOut_bits_addrRequest,
  output [31:0] io_reqOut_bits_dataRequest,
  output [3:0]  io_reqOut_bits_activeByteLane,
  output        io_reqOut_bits_isWrite,
  output        io_rspIn_ready,
  input         io_rspIn_valid,
  input  [31:0] io_rspIn_bits_dataResponse,
  input         io_rspIn_bits_error
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[TilelinkDevice.scala 17:27]
  wire [31:0] _GEN_0 = io_tlMasterReceiver_valid ? io_tlMasterReceiver_bits_a_address : 32'h0; // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 45:40 TilelinkDevice.scala 23:37]
  wire [31:0] _GEN_1 = io_tlMasterReceiver_valid ? io_tlMasterReceiver_bits_a_data : 32'h0; // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 46:40 TilelinkDevice.scala 24:37]
  wire [3:0] _GEN_2 = io_tlMasterReceiver_valid ? io_tlMasterReceiver_bits_a_mask : 4'h0; // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 47:43 TilelinkDevice.scala 25:37]
  wire  _GEN_3 = io_tlMasterReceiver_valid & (io_tlMasterReceiver_bits_a_opcode == 3'h0 |
    io_tlMasterReceiver_bits_a_opcode == 3'h1); // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 48:36 TilelinkDevice.scala 26:37]
  wire  _GEN_5 = io_tlMasterReceiver_valid | stateReg; // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 51:22 TilelinkDevice.scala 17:27]
  wire [31:0] _GEN_7 = io_rspIn_valid ? io_rspIn_bits_dataResponse : 32'h0; // @[TilelinkDevice.scala 60:29 TilelinkDevice.scala 63:47 TilelinkDevice.scala 30:45]
  wire  _GEN_11 = io_rspIn_valid & io_rspIn_bits_error; // @[TilelinkDevice.scala 60:29 TilelinkDevice.scala 68:49 TilelinkDevice.scala 35:45]
  wire  _GEN_15 = stateReg & io_rspIn_valid; // @[TilelinkDevice.scala 56:43 TilelinkDevice.scala 29:45]
  wire [31:0] _GEN_16 = stateReg ? _GEN_7 : 32'h0; // @[TilelinkDevice.scala 56:43 TilelinkDevice.scala 30:45]
  wire  _GEN_20 = stateReg & _GEN_11; // @[TilelinkDevice.scala 56:43 TilelinkDevice.scala 35:45]
  assign io_tlSlaveTransmitter_valid = ~stateReg ? 1'h0 : _GEN_15; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 37:45]
  assign io_tlSlaveTransmitter_bits_d_denied = ~stateReg ? 1'h0 : _GEN_20; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 35:45]
  assign io_tlSlaveTransmitter_bits_d_data = ~stateReg ? 32'h0 : _GEN_16; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 30:45]
  assign io_reqOut_valid = ~stateReg & io_tlMasterReceiver_valid; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 27:37]
  assign io_reqOut_bits_addrRequest = ~stateReg ? _GEN_0 : 32'h0; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 23:37]
  assign io_reqOut_bits_dataRequest = ~stateReg ? _GEN_1 : 32'h0; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 24:37]
  assign io_reqOut_bits_activeByteLane = ~stateReg ? _GEN_2 : 4'h0; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 25:37]
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
module Timer(
  input         clock,
  input         reset,
  input         io_req_valid,
  input  [31:0] io_req_bits_addrRequest,
  input  [31:0] io_req_bits_dataRequest,
  input  [3:0]  io_req_bits_activeByteLane,
  input         io_req_bits_isWrite,
  input         io_rsp_ready,
  output        io_rsp_valid,
  output [31:0] io_rsp_bits_dataResponse,
  output        io_rsp_bits_error,
  output        io_cio_timer_intr_cmp,
  output        io_cio_timer_intr_ovf
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
`endif // RANDOMIZE_REG_INIT
  reg [31:0] TimerReg; // @[Timer.scala 23:29]
  reg [31:0] ControlReg; // @[Timer.scala 24:29]
  reg [31:0] CompareReg; // @[Timer.scala 25:29]
  reg [31:0] PreCountReg; // @[Timer.scala 26:29]
  wire [7:0] maskedData_0 = io_req_bits_activeByteLane[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] maskedData_1 = io_req_bits_activeByteLane[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] maskedData_2 = io_req_bits_activeByteLane[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] maskedData_3 = io_req_bits_activeByteLane[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire  _T_13 = io_req_bits_addrRequest[3:0] == 4'h0; // @[Timer.scala 36:40]
  wire  _T_14 = ~io_req_bits_isWrite; // @[Timer.scala 36:71]
  reg [31:0] io_rsp_bits_dataResponse_REG; // @[Timer.scala 37:44]
  reg  io_rsp_valid_REG; // @[Timer.scala 38:32]
  wire  _T_17 = io_req_bits_addrRequest[3:0] == 4'h4; // @[Timer.scala 40:45]
  wire [31:0] _ControlReg_T = {maskedData_3,maskedData_2,maskedData_1,maskedData_0}; // @[Timer.scala 41:78]
  wire [31:0] _ControlReg_T_1 = io_req_bits_dataRequest & _ControlReg_T; // @[Timer.scala 41:65]
  reg [31:0] io_rsp_bits_dataResponse_REG_1; // @[Timer.scala 43:44]
  reg  io_rsp_valid_REG_1; // @[Timer.scala 44:32]
  reg [31:0] io_rsp_bits_dataResponse_REG_2; // @[Timer.scala 47:44]
  reg  io_rsp_valid_REG_2; // @[Timer.scala 48:32]
  wire  _T_25 = io_req_bits_addrRequest[3:0] == 4'h8; // @[Timer.scala 50:45]
  wire [31:0] _CompareReg_T_2 = io_req_valid ? _ControlReg_T_1 : CompareReg; // @[Timer.scala 51:26]
  reg [31:0] io_rsp_bits_dataResponse_REG_3; // @[Timer.scala 53:44]
  reg  io_rsp_valid_REG_3; // @[Timer.scala 54:32]
  wire  _T_31 = _T_25 & _T_14; // @[Timer.scala 56:53]
  reg [31:0] io_rsp_bits_dataResponse_REG_4; // @[Timer.scala 57:44]
  reg  io_rsp_valid_REG_4; // @[Timer.scala 58:32]
  reg [31:0] io_rsp_bits_dataResponse_REG_5; // @[Timer.scala 61:44]
  reg  io_rsp_valid_REG_5; // @[Timer.scala 62:32]
  reg [31:0] io_rsp_bits_dataResponse_REG_6; // @[Timer.scala 66:44]
  wire [31:0] _GEN_0 = _T_31 ? io_rsp_bits_dataResponse_REG_5 : io_rsp_bits_dataResponse_REG_6; // @[Timer.scala 60:84 Timer.scala 61:34 Timer.scala 66:34]
  wire [31:0] _GEN_2 = _T_25 & _T_14 ? io_rsp_bits_dataResponse_REG_4 : _GEN_0; // @[Timer.scala 56:84 Timer.scala 57:34]
  wire  _GEN_3 = _T_25 & _T_14 ? io_rsp_valid_REG_4 : io_rsp_valid_REG_5; // @[Timer.scala 56:84 Timer.scala 58:22]
  wire [31:0] _GEN_4 = io_req_bits_addrRequest[3:0] == 4'h8 & io_req_bits_isWrite ? _CompareReg_T_2 : CompareReg; // @[Timer.scala 50:84 Timer.scala 51:20 Timer.scala 25:29]
  wire [31:0] _GEN_5 = io_req_bits_addrRequest[3:0] == 4'h8 & io_req_bits_isWrite ? io_rsp_bits_dataResponse_REG_3 :
    _GEN_2; // @[Timer.scala 50:84 Timer.scala 53:34]
  wire  _GEN_6 = io_req_bits_addrRequest[3:0] == 4'h8 & io_req_bits_isWrite ? io_rsp_valid_REG_3 : _GEN_3; // @[Timer.scala 50:84 Timer.scala 54:22]
  wire [31:0] _GEN_7 = _T_17 & _T_14 ? io_rsp_bits_dataResponse_REG_2 : _GEN_5; // @[Timer.scala 46:84 Timer.scala 47:34]
  wire  _GEN_8 = _T_17 & _T_14 ? io_rsp_valid_REG_2 : _GEN_6; // @[Timer.scala 46:84 Timer.scala 48:22]
  wire [31:0] _GEN_11 = io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite ? io_rsp_bits_dataResponse_REG_1 :
    _GEN_7; // @[Timer.scala 40:84 Timer.scala 43:34]
  wire  _GEN_12 = io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite ? io_rsp_valid_REG_1 : _GEN_8; // @[Timer.scala 40:84 Timer.scala 44:22]
  wire  enable = ControlReg[0]; // @[Timer.scala 69:37]
  wire [30:0] prescalar = ControlReg[31:1]; // @[Timer.scala 70:40]
  wire [31:0] _PreCountReg_T_1 = PreCountReg + 32'h1; // @[Timer.scala 74:36]
  wire  _T_38 = TimerReg == CompareReg; // @[Timer.scala 76:24]
  wire  _T_39 = TimerReg == 32'hffffffff; // @[Timer.scala 76:51]
  wire [31:0] _GEN_27 = {{1'd0}, prescalar}; // @[Timer.scala 79:27]
  wire [31:0] _TimerReg_T_1 = TimerReg + 32'h1; // @[Timer.scala 80:30]
  wire [31:0] _GEN_18 = PreCountReg < _GEN_27 ? _PreCountReg_T_1 : PreCountReg; // @[Timer.scala 82:40 Timer.scala 83:21 Timer.scala 26:29]
  wire  addr_hit_3 = io_req_bits_addrRequest[3:0] == 4'hc; // @[Timer.scala 102:39]
  wire  addr_miss = ~(_T_13 | _T_17 | _T_25 | addr_hit_3); // @[Timer.scala 110:18]
  reg  io_rsp_bits_error_REG; // @[Timer.scala 111:78]
  reg  io_rsp_bits_error_REG_1; // @[Timer.scala 112:84]
  reg  io_rsp_bits_error_REG_2; // @[Timer.scala 113:44]
  wire  _GEN_25 = addr_hit_3 & io_req_bits_isWrite ? io_rsp_bits_error_REG_1 : io_rsp_bits_error_REG_2; // @[Timer.scala 112:55 Timer.scala 112:74 Timer.scala 113:34]
  assign io_rsp_valid = io_req_bits_addrRequest[3:0] == 4'h0 & ~io_req_bits_isWrite ? io_rsp_valid_REG : _GEN_12; // @[Timer.scala 36:79 Timer.scala 38:22]
  assign io_rsp_bits_dataResponse = io_req_bits_addrRequest[3:0] == 4'h0 & ~io_req_bits_isWrite ?
    io_rsp_bits_dataResponse_REG : _GEN_11; // @[Timer.scala 36:79 Timer.scala 37:34]
  assign io_rsp_bits_error = _T_13 & io_req_bits_isWrite ? io_rsp_bits_error_REG : _GEN_25; // @[Timer.scala 111:49 Timer.scala 111:68]
  assign io_cio_timer_intr_cmp = enable & _T_38; // @[Timer.scala 87:33]
  assign io_cio_timer_intr_ovf = enable & _T_39; // @[Timer.scala 88:33]
  always @(posedge clock) begin
    if (reset) begin // @[Timer.scala 23:29]
      TimerReg <= 32'h0; // @[Timer.scala 23:29]
    end else if (!(PreCountReg == 32'h0 & enable)) begin // @[Timer.scala 73:40]
      if (TimerReg == CompareReg | TimerReg == 32'hffffffff) begin // @[Timer.scala 76:69]
        TimerReg <= 32'h0; // @[Timer.scala 77:18]
      end else if (PreCountReg == _GEN_27 & enable) begin // @[Timer.scala 79:51]
        TimerReg <= _TimerReg_T_1; // @[Timer.scala 80:18]
      end
    end
    if (reset) begin // @[Timer.scala 24:29]
      ControlReg <= 32'h0; // @[Timer.scala 24:29]
    end else if (!(io_req_bits_addrRequest[3:0] == 4'h0 & ~io_req_bits_isWrite)) begin // @[Timer.scala 36:79]
      if (io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite) begin // @[Timer.scala 40:84]
        if (io_req_valid) begin // @[Timer.scala 41:26]
          ControlReg <= _ControlReg_T_1;
        end
      end
    end
    if (reset) begin // @[Timer.scala 25:29]
      CompareReg <= 32'h0; // @[Timer.scala 25:29]
    end else if (!(io_req_bits_addrRequest[3:0] == 4'h0 & ~io_req_bits_isWrite)) begin // @[Timer.scala 36:79]
      if (!(io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite)) begin // @[Timer.scala 40:84]
        if (!(_T_17 & _T_14)) begin // @[Timer.scala 46:84]
          CompareReg <= _GEN_4;
        end
      end
    end
    if (reset) begin // @[Timer.scala 26:29]
      PreCountReg <= 32'h0; // @[Timer.scala 26:29]
    end else if (PreCountReg == 32'h0 & enable) begin // @[Timer.scala 73:40]
      PreCountReg <= _PreCountReg_T_1; // @[Timer.scala 74:21]
    end else if (!(TimerReg == CompareReg | TimerReg == 32'hffffffff)) begin // @[Timer.scala 76:69]
      if (PreCountReg == _GEN_27 & enable) begin // @[Timer.scala 79:51]
        PreCountReg <= 32'h0; // @[Timer.scala 81:21]
      end else begin
        PreCountReg <= _GEN_18;
      end
    end
    if (io_rsp_ready) begin // @[Timer.scala 37:48]
      io_rsp_bits_dataResponse_REG <= TimerReg;
    end else begin
      io_rsp_bits_dataResponse_REG <= 32'h0;
    end
    io_rsp_valid_REG <= io_req_valid; // @[Timer.scala 38:32]
    if (io_rsp_ready) begin // @[Timer.scala 43:48]
      io_rsp_bits_dataResponse_REG_1 <= io_req_bits_dataRequest;
    end else begin
      io_rsp_bits_dataResponse_REG_1 <= 32'h0;
    end
    io_rsp_valid_REG_1 <= io_req_valid; // @[Timer.scala 44:32]
    if (io_rsp_ready) begin // @[Timer.scala 47:48]
      io_rsp_bits_dataResponse_REG_2 <= ControlReg;
    end else begin
      io_rsp_bits_dataResponse_REG_2 <= 32'h0;
    end
    io_rsp_valid_REG_2 <= io_req_valid; // @[Timer.scala 48:32]
    if (io_rsp_ready) begin // @[Timer.scala 53:48]
      io_rsp_bits_dataResponse_REG_3 <= io_req_bits_dataRequest;
    end else begin
      io_rsp_bits_dataResponse_REG_3 <= 32'h0;
    end
    io_rsp_valid_REG_3 <= io_req_valid; // @[Timer.scala 54:32]
    if (io_rsp_ready) begin // @[Timer.scala 57:48]
      io_rsp_bits_dataResponse_REG_4 <= CompareReg;
    end else begin
      io_rsp_bits_dataResponse_REG_4 <= 32'h0;
    end
    io_rsp_valid_REG_4 <= io_req_valid; // @[Timer.scala 58:32]
    if (io_rsp_ready) begin // @[Timer.scala 61:48]
      io_rsp_bits_dataResponse_REG_5 <= PreCountReg;
    end else begin
      io_rsp_bits_dataResponse_REG_5 <= 32'h0;
    end
    io_rsp_valid_REG_5 <= io_req_valid; // @[Timer.scala 62:32]
    io_rsp_bits_dataResponse_REG_6 <= io_req_bits_addrRequest; // @[Timer.scala 66:44]
    io_rsp_bits_error_REG <= io_req_valid; // @[Timer.scala 111:78]
    io_rsp_bits_error_REG_1 <= io_req_valid; // @[Timer.scala 112:84]
    io_rsp_bits_error_REG_2 <= io_req_valid & addr_miss; // @[Timer.scala 113:58]
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
  TimerReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  ControlReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  CompareReg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  PreCountReg = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  io_rsp_valid_REG = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_1 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  io_rsp_valid_REG_1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_2 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  io_rsp_valid_REG_2 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_3 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  io_rsp_valid_REG_3 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_4 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  io_rsp_valid_REG_4 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_5 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  io_rsp_valid_REG_5 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  io_rsp_bits_dataResponse_REG_6 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  io_rsp_bits_error_REG = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  io_rsp_bits_error_REG_1 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  io_rsp_bits_error_REG_2 = _RAND_19[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TimerHarnessTL(
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
  output        io_cio_timer_intr_cmp,
  output        io_cio_timer_intr_ovf
);
  wire  hostAdapter_clock; // @[TimerHarness.scala 57:27]
  wire  hostAdapter_reset; // @[TimerHarness.scala 57:27]
  wire  hostAdapter_io_tlMasterTransmitter_valid; // @[TimerHarness.scala 57:27]
  wire [2:0] hostAdapter_io_tlMasterTransmitter_bits_a_opcode; // @[TimerHarness.scala 57:27]
  wire [31:0] hostAdapter_io_tlMasterTransmitter_bits_a_address; // @[TimerHarness.scala 57:27]
  wire [3:0] hostAdapter_io_tlMasterTransmitter_bits_a_mask; // @[TimerHarness.scala 57:27]
  wire [31:0] hostAdapter_io_tlMasterTransmitter_bits_a_data; // @[TimerHarness.scala 57:27]
  wire  hostAdapter_io_tlSlaveReceiver_valid; // @[TimerHarness.scala 57:27]
  wire  hostAdapter_io_tlSlaveReceiver_bits_d_denied; // @[TimerHarness.scala 57:27]
  wire [31:0] hostAdapter_io_tlSlaveReceiver_bits_d_data; // @[TimerHarness.scala 57:27]
  wire  hostAdapter_io_reqIn_ready; // @[TimerHarness.scala 57:27]
  wire  hostAdapter_io_reqIn_valid; // @[TimerHarness.scala 57:27]
  wire [31:0] hostAdapter_io_reqIn_bits_addrRequest; // @[TimerHarness.scala 57:27]
  wire [31:0] hostAdapter_io_reqIn_bits_dataRequest; // @[TimerHarness.scala 57:27]
  wire [3:0] hostAdapter_io_reqIn_bits_activeByteLane; // @[TimerHarness.scala 57:27]
  wire  hostAdapter_io_reqIn_bits_isWrite; // @[TimerHarness.scala 57:27]
  wire  hostAdapter_io_rspOut_valid; // @[TimerHarness.scala 57:27]
  wire [31:0] hostAdapter_io_rspOut_bits_dataResponse; // @[TimerHarness.scala 57:27]
  wire  hostAdapter_io_rspOut_bits_error; // @[TimerHarness.scala 57:27]
  wire  deviceAdapter_clock; // @[TimerHarness.scala 58:29]
  wire  deviceAdapter_reset; // @[TimerHarness.scala 58:29]
  wire  deviceAdapter_io_tlSlaveTransmitter_valid; // @[TimerHarness.scala 58:29]
  wire  deviceAdapter_io_tlSlaveTransmitter_bits_d_denied; // @[TimerHarness.scala 58:29]
  wire [31:0] deviceAdapter_io_tlSlaveTransmitter_bits_d_data; // @[TimerHarness.scala 58:29]
  wire  deviceAdapter_io_tlMasterReceiver_valid; // @[TimerHarness.scala 58:29]
  wire [2:0] deviceAdapter_io_tlMasterReceiver_bits_a_opcode; // @[TimerHarness.scala 58:29]
  wire [31:0] deviceAdapter_io_tlMasterReceiver_bits_a_address; // @[TimerHarness.scala 58:29]
  wire [3:0] deviceAdapter_io_tlMasterReceiver_bits_a_mask; // @[TimerHarness.scala 58:29]
  wire [31:0] deviceAdapter_io_tlMasterReceiver_bits_a_data; // @[TimerHarness.scala 58:29]
  wire  deviceAdapter_io_reqOut_valid; // @[TimerHarness.scala 58:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_addrRequest; // @[TimerHarness.scala 58:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_dataRequest; // @[TimerHarness.scala 58:29]
  wire [3:0] deviceAdapter_io_reqOut_bits_activeByteLane; // @[TimerHarness.scala 58:29]
  wire  deviceAdapter_io_reqOut_bits_isWrite; // @[TimerHarness.scala 58:29]
  wire  deviceAdapter_io_rspIn_ready; // @[TimerHarness.scala 58:29]
  wire  deviceAdapter_io_rspIn_valid; // @[TimerHarness.scala 58:29]
  wire [31:0] deviceAdapter_io_rspIn_bits_dataResponse; // @[TimerHarness.scala 58:29]
  wire  deviceAdapter_io_rspIn_bits_error; // @[TimerHarness.scala 58:29]
  wire  timer_clock; // @[TimerHarness.scala 59:21]
  wire  timer_reset; // @[TimerHarness.scala 59:21]
  wire  timer_io_req_valid; // @[TimerHarness.scala 59:21]
  wire [31:0] timer_io_req_bits_addrRequest; // @[TimerHarness.scala 59:21]
  wire [31:0] timer_io_req_bits_dataRequest; // @[TimerHarness.scala 59:21]
  wire [3:0] timer_io_req_bits_activeByteLane; // @[TimerHarness.scala 59:21]
  wire  timer_io_req_bits_isWrite; // @[TimerHarness.scala 59:21]
  wire  timer_io_rsp_ready; // @[TimerHarness.scala 59:21]
  wire  timer_io_rsp_valid; // @[TimerHarness.scala 59:21]
  wire [31:0] timer_io_rsp_bits_dataResponse; // @[TimerHarness.scala 59:21]
  wire  timer_io_rsp_bits_error; // @[TimerHarness.scala 59:21]
  wire  timer_io_cio_timer_intr_cmp; // @[TimerHarness.scala 59:21]
  wire  timer_io_cio_timer_intr_ovf; // @[TimerHarness.scala 59:21]
  TilelinkHost hostAdapter ( // @[TimerHarness.scala 57:27]
    .clock(hostAdapter_clock),
    .reset(hostAdapter_reset),
    .io_tlMasterTransmitter_valid(hostAdapter_io_tlMasterTransmitter_valid),
    .io_tlMasterTransmitter_bits_a_opcode(hostAdapter_io_tlMasterTransmitter_bits_a_opcode),
    .io_tlMasterTransmitter_bits_a_address(hostAdapter_io_tlMasterTransmitter_bits_a_address),
    .io_tlMasterTransmitter_bits_a_mask(hostAdapter_io_tlMasterTransmitter_bits_a_mask),
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
  TilelinkDevice deviceAdapter ( // @[TimerHarness.scala 58:29]
    .clock(deviceAdapter_clock),
    .reset(deviceAdapter_reset),
    .io_tlSlaveTransmitter_valid(deviceAdapter_io_tlSlaveTransmitter_valid),
    .io_tlSlaveTransmitter_bits_d_denied(deviceAdapter_io_tlSlaveTransmitter_bits_d_denied),
    .io_tlSlaveTransmitter_bits_d_data(deviceAdapter_io_tlSlaveTransmitter_bits_d_data),
    .io_tlMasterReceiver_valid(deviceAdapter_io_tlMasterReceiver_valid),
    .io_tlMasterReceiver_bits_a_opcode(deviceAdapter_io_tlMasterReceiver_bits_a_opcode),
    .io_tlMasterReceiver_bits_a_address(deviceAdapter_io_tlMasterReceiver_bits_a_address),
    .io_tlMasterReceiver_bits_a_mask(deviceAdapter_io_tlMasterReceiver_bits_a_mask),
    .io_tlMasterReceiver_bits_a_data(deviceAdapter_io_tlMasterReceiver_bits_a_data),
    .io_reqOut_valid(deviceAdapter_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(deviceAdapter_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(deviceAdapter_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(deviceAdapter_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(deviceAdapter_io_reqOut_bits_isWrite),
    .io_rspIn_ready(deviceAdapter_io_rspIn_ready),
    .io_rspIn_valid(deviceAdapter_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(deviceAdapter_io_rspIn_bits_dataResponse),
    .io_rspIn_bits_error(deviceAdapter_io_rspIn_bits_error)
  );
  Timer timer ( // @[TimerHarness.scala 59:21]
    .clock(timer_clock),
    .reset(timer_reset),
    .io_req_valid(timer_io_req_valid),
    .io_req_bits_addrRequest(timer_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(timer_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(timer_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(timer_io_req_bits_isWrite),
    .io_rsp_ready(timer_io_rsp_ready),
    .io_rsp_valid(timer_io_rsp_valid),
    .io_rsp_bits_dataResponse(timer_io_rsp_bits_dataResponse),
    .io_rsp_bits_error(timer_io_rsp_bits_error),
    .io_cio_timer_intr_cmp(timer_io_cio_timer_intr_cmp),
    .io_cio_timer_intr_ovf(timer_io_cio_timer_intr_ovf)
  );
  assign io_req_ready = hostAdapter_io_reqIn_ready; // @[TimerHarness.scala 61:24]
  assign io_rsp_valid = hostAdapter_io_rspOut_valid; // @[TimerHarness.scala 62:10]
  assign io_rsp_bits_dataResponse = hostAdapter_io_rspOut_bits_dataResponse; // @[TimerHarness.scala 62:10]
  assign io_rsp_bits_error = hostAdapter_io_rspOut_bits_error; // @[TimerHarness.scala 62:10]
  assign io_cio_timer_intr_cmp = timer_io_cio_timer_intr_cmp; // @[TimerHarness.scala 69:25]
  assign io_cio_timer_intr_ovf = timer_io_cio_timer_intr_ovf; // @[TimerHarness.scala 70:25]
  assign hostAdapter_clock = clock;
  assign hostAdapter_reset = reset;
  assign hostAdapter_io_tlSlaveReceiver_valid = deviceAdapter_io_tlSlaveTransmitter_valid; // @[TimerHarness.scala 64:34]
  assign hostAdapter_io_tlSlaveReceiver_bits_d_denied = deviceAdapter_io_tlSlaveTransmitter_bits_d_denied; // @[TimerHarness.scala 64:34]
  assign hostAdapter_io_tlSlaveReceiver_bits_d_data = deviceAdapter_io_tlSlaveTransmitter_bits_d_data; // @[TimerHarness.scala 64:34]
  assign hostAdapter_io_reqIn_valid = io_req_valid; // @[TimerHarness.scala 61:24]
  assign hostAdapter_io_reqIn_bits_addrRequest = io_req_bits_addrRequest; // @[TimerHarness.scala 61:24]
  assign hostAdapter_io_reqIn_bits_dataRequest = io_req_bits_dataRequest; // @[TimerHarness.scala 61:24]
  assign hostAdapter_io_reqIn_bits_activeByteLane = io_req_bits_activeByteLane; // @[TimerHarness.scala 61:24]
  assign hostAdapter_io_reqIn_bits_isWrite = io_req_bits_isWrite; // @[TimerHarness.scala 61:24]
  assign deviceAdapter_clock = clock;
  assign deviceAdapter_reset = reset;
  assign deviceAdapter_io_tlMasterReceiver_valid = hostAdapter_io_tlMasterTransmitter_valid; // @[TimerHarness.scala 63:38]
  assign deviceAdapter_io_tlMasterReceiver_bits_a_opcode = hostAdapter_io_tlMasterTransmitter_bits_a_opcode; // @[TimerHarness.scala 63:38]
  assign deviceAdapter_io_tlMasterReceiver_bits_a_address = hostAdapter_io_tlMasterTransmitter_bits_a_address; // @[TimerHarness.scala 63:38]
  assign deviceAdapter_io_tlMasterReceiver_bits_a_mask = hostAdapter_io_tlMasterTransmitter_bits_a_mask; // @[TimerHarness.scala 63:38]
  assign deviceAdapter_io_tlMasterReceiver_bits_a_data = hostAdapter_io_tlMasterTransmitter_bits_a_data; // @[TimerHarness.scala 63:38]
  assign deviceAdapter_io_rspIn_valid = timer_io_rsp_valid; // @[TimerHarness.scala 67:16]
  assign deviceAdapter_io_rspIn_bits_dataResponse = timer_io_rsp_bits_dataResponse; // @[TimerHarness.scala 67:16]
  assign deviceAdapter_io_rspIn_bits_error = timer_io_rsp_bits_error; // @[TimerHarness.scala 67:16]
  assign timer_clock = clock;
  assign timer_reset = reset;
  assign timer_io_req_valid = deviceAdapter_io_reqOut_valid; // @[TimerHarness.scala 66:16]
  assign timer_io_req_bits_addrRequest = deviceAdapter_io_reqOut_bits_addrRequest; // @[TimerHarness.scala 66:16]
  assign timer_io_req_bits_dataRequest = deviceAdapter_io_reqOut_bits_dataRequest; // @[TimerHarness.scala 66:16]
  assign timer_io_req_bits_activeByteLane = deviceAdapter_io_reqOut_bits_activeByteLane; // @[TimerHarness.scala 66:16]
  assign timer_io_req_bits_isWrite = deviceAdapter_io_reqOut_bits_isWrite; // @[TimerHarness.scala 66:16]
  assign timer_io_rsp_ready = deviceAdapter_io_rspIn_ready; // @[TimerHarness.scala 67:16]
endmodule
