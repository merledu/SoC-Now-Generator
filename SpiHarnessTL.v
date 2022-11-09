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
module Spi(
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
  wire  spiProtocol_clock; // @[Spi.scala 127:29]
  wire  spiProtocol_reset; // @[Spi.scala 127:29]
  wire  spiProtocol_io_miso; // @[Spi.scala 127:29]
  wire  spiProtocol_io_mosi; // @[Spi.scala 127:29]
  wire  spiProtocol_io_ss; // @[Spi.scala 127:29]
  wire  spiProtocol_io_sck; // @[Spi.scala 127:29]
  wire  spiProtocol_io_data_in_valid; // @[Spi.scala 127:29]
  wire [31:0] spiProtocol_io_data_in_bits; // @[Spi.scala 127:29]
  wire  spiProtocol_io_data_out_valid; // @[Spi.scala 127:29]
  wire [31:0] spiProtocol_io_data_out_bits; // @[Spi.scala 127:29]
  wire  spiProtocol_io_CPOL; // @[Spi.scala 127:29]
  reg [31:0] ControlReg; // @[Spi.scala 28:29]
  reg [31:0] TxDataReg; // @[Spi.scala 29:31]
  reg  TxDataValidReg; // @[Spi.scala 30:33]
  reg [31:0] RxDataReg; // @[Spi.scala 31:31]
  reg  RxDataValidReg; // @[Spi.scala 32:33]
  wire [7:0] maskedData_0 = io_req_bits_activeByteLane[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] maskedData_1 = io_req_bits_activeByteLane[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] maskedData_2 = io_req_bits_activeByteLane[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] maskedData_3 = io_req_bits_activeByteLane[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire  _T_13 = io_req_bits_addrRequest[3:0] == 4'h0; // @[Spi.scala 41:40]
  wire [31:0] _ControlReg_T = {maskedData_3,maskedData_2,maskedData_1,maskedData_0}; // @[Spi.scala 42:78]
  wire [31:0] _ControlReg_T_1 = io_req_bits_dataRequest & _ControlReg_T; // @[Spi.scala 42:65]
  reg [31:0] io_rsp_bits_dataResponse_REG; // @[Spi.scala 44:44]
  reg  io_rsp_valid_REG; // @[Spi.scala 45:32]
  wire  _T_18 = ~io_req_bits_isWrite; // @[Spi.scala 51:75]
  reg [31:0] io_rsp_bits_dataResponse_REG_1; // @[Spi.scala 52:44]
  reg  io_rsp_valid_REG_1; // @[Spi.scala 53:32]
  wire  _T_21 = io_req_bits_addrRequest[3:0] == 4'h4; // @[Spi.scala 59:44]
  wire [31:0] _TxDataReg_T_2 = io_req_valid ? _ControlReg_T_1 : 32'h0; // @[Spi.scala 80:25]
  reg [31:0] io_rsp_bits_dataResponse_REG_2; // @[Spi.scala 83:44]
  reg [31:0] io_rsp_bits_dataResponse_REG_3; // @[Spi.scala 90:44]
  reg  io_rsp_valid_REG_3; // @[Spi.scala 91:32]
  wire  _T_29 = io_req_bits_addrRequest[3:0] == 4'h8; // @[Spi.scala 96:44]
  reg [31:0] io_rsp_bits_dataResponse_REG_4; // @[Spi.scala 97:44]
  reg [31:0] io_rsp_bits_dataResponse_REG_5; // @[Spi.scala 108:44]
  wire [31:0] _GEN_0 = io_req_bits_addrRequest[3:0] == 4'h8 & _T_18 ? io_rsp_bits_dataResponse_REG_4 :
    io_rsp_bits_dataResponse_REG_5; // @[Spi.scala 96:83 Spi.scala 97:34 Spi.scala 108:34]
  wire [31:0] _GEN_2 = _T_21 & _T_18 ? io_rsp_bits_dataResponse_REG_3 : _GEN_0; // @[Spi.scala 89:83 Spi.scala 90:34]
  wire  _GEN_3 = _T_21 & _T_18 ? io_rsp_valid_REG_3 : RxDataValidReg; // @[Spi.scala 89:83 Spi.scala 91:22]
  wire [31:0] _GEN_6 = io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite ? io_rsp_bits_dataResponse_REG_2 :
    _GEN_2; // @[Spi.scala 59:83 Spi.scala 83:34]
  wire  _GEN_7 = io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite | _GEN_3; // @[Spi.scala 59:83 Spi.scala 84:22]
  wire [31:0] _GEN_8 = _T_13 & ~io_req_bits_isWrite ? io_rsp_bits_dataResponse_REG_1 : _GEN_6; // @[Spi.scala 51:83 Spi.scala 52:34]
  wire  _GEN_9 = _T_13 & ~io_req_bits_isWrite ? io_rsp_valid_REG_1 : _GEN_7; // @[Spi.scala 51:83 Spi.scala 53:22]
  wire [25:0] _spiProtocol_clock_T_3 = ControlReg[31:6] - 26'h1; // @[Spi.scala 117:36]
  reg [25:0] spiProtocol_clock_x; // @[Spi.scala 113:24]
  wire [25:0] _spiProtocol_clock_x_T_2 = spiProtocol_clock_x + 26'h1; // @[Spi.scala 114:36]
  wire  _spiProtocol_clock_T_4 = spiProtocol_clock_x == 26'h0; // @[Spi.scala 117:43]
  reg  spiProtocol_clock_x_1; // @[Spi.scala 119:24]
  wire  _GEN_18 = spiProtocol_io_data_out_valid | RxDataValidReg; // @[Spi.scala 137:40 Spi.scala 139:24 Spi.scala 32:33]
  wire  addr_miss = ~(_T_13 | _T_21 | _T_29); // @[Spi.scala 161:18]
  reg  io_rsp_bits_error_REG; // @[Spi.scala 162:78]
  reg  io_rsp_bits_error_REG_1; // @[Spi.scala 163:44]
  Protocol spiProtocol ( // @[Spi.scala 127:29]
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
  assign io_rsp_valid = io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite ? io_rsp_valid_REG : _GEN_9; // @[Spi.scala 41:79 Spi.scala 45:22]
  assign io_rsp_bits_dataResponse = io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite ?
    io_rsp_bits_dataResponse_REG : _GEN_8; // @[Spi.scala 41:79 Spi.scala 44:34]
  assign io_rsp_bits_error = _T_29 & io_req_bits_isWrite ? io_rsp_bits_error_REG : io_rsp_bits_error_REG_1; // @[Spi.scala 162:49 Spi.scala 162:68 Spi.scala 163:34]
  assign io_cs_n = spiProtocol_io_ss; // @[Spi.scala 136:121]
  assign io_sclk = spiProtocol_io_sck; // @[Spi.scala 136:121]
  assign io_mosi = spiProtocol_io_mosi; // @[Spi.scala 136:121]
  assign spiProtocol_clock = spiProtocol_clock_x_1; // @[Spi.scala 129:53]
  assign spiProtocol_reset = reset;
  assign spiProtocol_io_miso = io_miso; // @[Spi.scala 134:25]
  assign spiProtocol_io_data_in_valid = TxDataValidReg; // @[Spi.scala 131:34]
  assign spiProtocol_io_data_in_bits = TxDataReg; // @[Spi.scala 130:34]
  assign spiProtocol_io_CPOL = ControlReg[1]; // @[Spi.scala 132:38]
  always @(posedge clock) begin
    if (reset) begin // @[Spi.scala 28:29]
      ControlReg <= 32'h60; // @[Spi.scala 28:29]
    end else if (io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite) begin // @[Spi.scala 41:79]
      if (io_req_valid) begin // @[Spi.scala 42:26]
        ControlReg <= _ControlReg_T_1;
      end
    end
    if (reset) begin // @[Spi.scala 29:31]
      TxDataReg <= 32'h0; // @[Spi.scala 29:31]
    end else if (!(io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite)) begin // @[Spi.scala 41:79]
      if (!(_T_13 & ~io_req_bits_isWrite)) begin // @[Spi.scala 51:83]
        if (io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite) begin // @[Spi.scala 59:83]
          TxDataReg <= _TxDataReg_T_2; // @[Spi.scala 80:19]
        end
      end
    end
    if (reset) begin // @[Spi.scala 30:33]
      TxDataValidReg <= 1'h0; // @[Spi.scala 30:33]
    end else if (!(io_req_bits_addrRequest[3:0] == 4'h0 & io_req_bits_isWrite)) begin // @[Spi.scala 41:79]
      if (!(_T_13 & ~io_req_bits_isWrite)) begin // @[Spi.scala 51:83]
        if (io_req_bits_addrRequest[3:0] == 4'h4 & io_req_bits_isWrite) begin // @[Spi.scala 59:83]
          TxDataValidReg <= io_req_valid; // @[Spi.scala 81:24]
        end
      end
    end
    if (reset) begin // @[Spi.scala 31:31]
      RxDataReg <= 32'h0; // @[Spi.scala 31:31]
    end else if (spiProtocol_io_data_out_valid) begin // @[Spi.scala 137:40]
      RxDataReg <= spiProtocol_io_data_out_bits; // @[Spi.scala 138:19]
    end
    if (reset) begin // @[Spi.scala 32:33]
      RxDataValidReg <= 1'h0; // @[Spi.scala 32:33]
    end else begin
      RxDataValidReg <= _GEN_18;
    end
    if (io_rsp_ready) begin // @[Spi.scala 44:48]
      io_rsp_bits_dataResponse_REG <= io_req_bits_dataRequest;
    end else begin
      io_rsp_bits_dataResponse_REG <= 32'h0;
    end
    io_rsp_valid_REG <= io_req_valid; // @[Spi.scala 45:32]
    if (io_rsp_ready) begin // @[Spi.scala 52:48]
      io_rsp_bits_dataResponse_REG_1 <= ControlReg;
    end else begin
      io_rsp_bits_dataResponse_REG_1 <= 32'h0;
    end
    io_rsp_valid_REG_1 <= io_req_valid; // @[Spi.scala 53:36]
    if (io_rsp_ready) begin // @[Spi.scala 83:48]
      io_rsp_bits_dataResponse_REG_2 <= io_req_bits_addrRequest;
    end else begin
      io_rsp_bits_dataResponse_REG_2 <= 32'h0;
    end
    if (io_rsp_ready) begin // @[Spi.scala 90:48]
      io_rsp_bits_dataResponse_REG_3 <= TxDataReg;
    end else begin
      io_rsp_bits_dataResponse_REG_3 <= 32'h0;
    end
    io_rsp_valid_REG_3 <= io_req_valid; // @[Spi.scala 91:32]
    if (io_rsp_ready) begin // @[Spi.scala 97:48]
      io_rsp_bits_dataResponse_REG_4 <= RxDataReg;
    end else begin
      io_rsp_bits_dataResponse_REG_4 <= 32'h0;
    end
    io_rsp_bits_dataResponse_REG_5 <= io_req_bits_addrRequest; // @[Spi.scala 108:44]
    if (reset) begin // @[Spi.scala 113:24]
      spiProtocol_clock_x <= 26'h0; // @[Spi.scala 113:24]
    end else if (spiProtocol_clock_x == _spiProtocol_clock_T_3) begin // @[Spi.scala 114:17]
      spiProtocol_clock_x <= 26'h0;
    end else begin
      spiProtocol_clock_x <= _spiProtocol_clock_x_T_2;
    end
    if (reset) begin // @[Spi.scala 119:24]
      spiProtocol_clock_x_1 <= 1'h0; // @[Spi.scala 119:24]
    end else if (_spiProtocol_clock_T_4) begin // @[Spi.scala 120:17]
      spiProtocol_clock_x_1 <= ~spiProtocol_clock_x_1;
    end
    io_rsp_bits_error_REG <= io_req_valid; // @[Spi.scala 162:78]
    io_rsp_bits_error_REG_1 <= io_req_valid & addr_miss; // @[Spi.scala 163:58]
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
module SpiHarnessTL(
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
  wire  hostAdapter_clock; // @[SpiHarness.scala 66:27]
  wire  hostAdapter_reset; // @[SpiHarness.scala 66:27]
  wire  hostAdapter_io_tlMasterTransmitter_valid; // @[SpiHarness.scala 66:27]
  wire [2:0] hostAdapter_io_tlMasterTransmitter_bits_a_opcode; // @[SpiHarness.scala 66:27]
  wire [31:0] hostAdapter_io_tlMasterTransmitter_bits_a_address; // @[SpiHarness.scala 66:27]
  wire [3:0] hostAdapter_io_tlMasterTransmitter_bits_a_mask; // @[SpiHarness.scala 66:27]
  wire [31:0] hostAdapter_io_tlMasterTransmitter_bits_a_data; // @[SpiHarness.scala 66:27]
  wire  hostAdapter_io_tlSlaveReceiver_valid; // @[SpiHarness.scala 66:27]
  wire  hostAdapter_io_tlSlaveReceiver_bits_d_denied; // @[SpiHarness.scala 66:27]
  wire [31:0] hostAdapter_io_tlSlaveReceiver_bits_d_data; // @[SpiHarness.scala 66:27]
  wire  hostAdapter_io_reqIn_ready; // @[SpiHarness.scala 66:27]
  wire  hostAdapter_io_reqIn_valid; // @[SpiHarness.scala 66:27]
  wire [31:0] hostAdapter_io_reqIn_bits_addrRequest; // @[SpiHarness.scala 66:27]
  wire [31:0] hostAdapter_io_reqIn_bits_dataRequest; // @[SpiHarness.scala 66:27]
  wire [3:0] hostAdapter_io_reqIn_bits_activeByteLane; // @[SpiHarness.scala 66:27]
  wire  hostAdapter_io_reqIn_bits_isWrite; // @[SpiHarness.scala 66:27]
  wire  hostAdapter_io_rspOut_valid; // @[SpiHarness.scala 66:27]
  wire [31:0] hostAdapter_io_rspOut_bits_dataResponse; // @[SpiHarness.scala 66:27]
  wire  hostAdapter_io_rspOut_bits_error; // @[SpiHarness.scala 66:27]
  wire  deviceAdapter_clock; // @[SpiHarness.scala 67:29]
  wire  deviceAdapter_reset; // @[SpiHarness.scala 67:29]
  wire  deviceAdapter_io_tlSlaveTransmitter_valid; // @[SpiHarness.scala 67:29]
  wire  deviceAdapter_io_tlSlaveTransmitter_bits_d_denied; // @[SpiHarness.scala 67:29]
  wire [31:0] deviceAdapter_io_tlSlaveTransmitter_bits_d_data; // @[SpiHarness.scala 67:29]
  wire  deviceAdapter_io_tlMasterReceiver_valid; // @[SpiHarness.scala 67:29]
  wire [2:0] deviceAdapter_io_tlMasterReceiver_bits_a_opcode; // @[SpiHarness.scala 67:29]
  wire [31:0] deviceAdapter_io_tlMasterReceiver_bits_a_address; // @[SpiHarness.scala 67:29]
  wire [3:0] deviceAdapter_io_tlMasterReceiver_bits_a_mask; // @[SpiHarness.scala 67:29]
  wire [31:0] deviceAdapter_io_tlMasterReceiver_bits_a_data; // @[SpiHarness.scala 67:29]
  wire  deviceAdapter_io_reqOut_valid; // @[SpiHarness.scala 67:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_addrRequest; // @[SpiHarness.scala 67:29]
  wire [31:0] deviceAdapter_io_reqOut_bits_dataRequest; // @[SpiHarness.scala 67:29]
  wire [3:0] deviceAdapter_io_reqOut_bits_activeByteLane; // @[SpiHarness.scala 67:29]
  wire  deviceAdapter_io_reqOut_bits_isWrite; // @[SpiHarness.scala 67:29]
  wire  deviceAdapter_io_rspIn_ready; // @[SpiHarness.scala 67:29]
  wire  deviceAdapter_io_rspIn_valid; // @[SpiHarness.scala 67:29]
  wire [31:0] deviceAdapter_io_rspIn_bits_dataResponse; // @[SpiHarness.scala 67:29]
  wire  deviceAdapter_io_rspIn_bits_error; // @[SpiHarness.scala 67:29]
  wire  spi_clock; // @[SpiHarness.scala 68:19]
  wire  spi_reset; // @[SpiHarness.scala 68:19]
  wire  spi_io_req_valid; // @[SpiHarness.scala 68:19]
  wire [31:0] spi_io_req_bits_addrRequest; // @[SpiHarness.scala 68:19]
  wire [31:0] spi_io_req_bits_dataRequest; // @[SpiHarness.scala 68:19]
  wire [3:0] spi_io_req_bits_activeByteLane; // @[SpiHarness.scala 68:19]
  wire  spi_io_req_bits_isWrite; // @[SpiHarness.scala 68:19]
  wire  spi_io_rsp_ready; // @[SpiHarness.scala 68:19]
  wire  spi_io_rsp_valid; // @[SpiHarness.scala 68:19]
  wire [31:0] spi_io_rsp_bits_dataResponse; // @[SpiHarness.scala 68:19]
  wire  spi_io_rsp_bits_error; // @[SpiHarness.scala 68:19]
  wire  spi_io_cs_n; // @[SpiHarness.scala 68:19]
  wire  spi_io_sclk; // @[SpiHarness.scala 68:19]
  wire  spi_io_mosi; // @[SpiHarness.scala 68:19]
  wire  spi_io_miso; // @[SpiHarness.scala 68:19]
  TilelinkHost hostAdapter ( // @[SpiHarness.scala 66:27]
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
  TilelinkDevice deviceAdapter ( // @[SpiHarness.scala 67:29]
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
  Spi spi ( // @[SpiHarness.scala 68:19]
    .clock(spi_clock),
    .reset(spi_reset),
    .io_req_valid(spi_io_req_valid),
    .io_req_bits_addrRequest(spi_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(spi_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(spi_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(spi_io_req_bits_isWrite),
    .io_rsp_ready(spi_io_rsp_ready),
    .io_rsp_valid(spi_io_rsp_valid),
    .io_rsp_bits_dataResponse(spi_io_rsp_bits_dataResponse),
    .io_rsp_bits_error(spi_io_rsp_bits_error),
    .io_cs_n(spi_io_cs_n),
    .io_sclk(spi_io_sclk),
    .io_mosi(spi_io_mosi),
    .io_miso(spi_io_miso)
  );
  assign io_req_ready = hostAdapter_io_reqIn_ready; // @[SpiHarness.scala 70:24]
  assign io_rsp_valid = hostAdapter_io_rspOut_valid; // @[SpiHarness.scala 71:10]
  assign io_rsp_bits_dataResponse = hostAdapter_io_rspOut_bits_dataResponse; // @[SpiHarness.scala 71:10]
  assign io_rsp_bits_error = hostAdapter_io_rspOut_bits_error; // @[SpiHarness.scala 71:10]
  assign io_cs_n = spi_io_cs_n; // @[SpiHarness.scala 79:13]
  assign io_sclk = spi_io_sclk; // @[SpiHarness.scala 80:13]
  assign io_mosi = spi_io_mosi; // @[SpiHarness.scala 81:13]
  assign hostAdapter_clock = clock;
  assign hostAdapter_reset = reset;
  assign hostAdapter_io_tlSlaveReceiver_valid = deviceAdapter_io_tlSlaveTransmitter_valid; // @[SpiHarness.scala 73:34]
  assign hostAdapter_io_tlSlaveReceiver_bits_d_denied = deviceAdapter_io_tlSlaveTransmitter_bits_d_denied; // @[SpiHarness.scala 73:34]
  assign hostAdapter_io_tlSlaveReceiver_bits_d_data = deviceAdapter_io_tlSlaveTransmitter_bits_d_data; // @[SpiHarness.scala 73:34]
  assign hostAdapter_io_reqIn_valid = io_req_valid; // @[SpiHarness.scala 70:24]
  assign hostAdapter_io_reqIn_bits_addrRequest = io_req_bits_addrRequest; // @[SpiHarness.scala 70:24]
  assign hostAdapter_io_reqIn_bits_dataRequest = io_req_bits_dataRequest; // @[SpiHarness.scala 70:24]
  assign hostAdapter_io_reqIn_bits_activeByteLane = io_req_bits_activeByteLane; // @[SpiHarness.scala 70:24]
  assign hostAdapter_io_reqIn_bits_isWrite = io_req_bits_isWrite; // @[SpiHarness.scala 70:24]
  assign deviceAdapter_clock = clock;
  assign deviceAdapter_reset = reset;
  assign deviceAdapter_io_tlMasterReceiver_valid = hostAdapter_io_tlMasterTransmitter_valid; // @[SpiHarness.scala 72:38]
  assign deviceAdapter_io_tlMasterReceiver_bits_a_opcode = hostAdapter_io_tlMasterTransmitter_bits_a_opcode; // @[SpiHarness.scala 72:38]
  assign deviceAdapter_io_tlMasterReceiver_bits_a_address = hostAdapter_io_tlMasterTransmitter_bits_a_address; // @[SpiHarness.scala 72:38]
  assign deviceAdapter_io_tlMasterReceiver_bits_a_mask = hostAdapter_io_tlMasterTransmitter_bits_a_mask; // @[SpiHarness.scala 72:38]
  assign deviceAdapter_io_tlMasterReceiver_bits_a_data = hostAdapter_io_tlMasterTransmitter_bits_a_data; // @[SpiHarness.scala 72:38]
  assign deviceAdapter_io_rspIn_valid = spi_io_rsp_valid; // @[SpiHarness.scala 76:14]
  assign deviceAdapter_io_rspIn_bits_dataResponse = spi_io_rsp_bits_dataResponse; // @[SpiHarness.scala 76:14]
  assign deviceAdapter_io_rspIn_bits_error = spi_io_rsp_bits_error; // @[SpiHarness.scala 76:14]
  assign spi_clock = clock;
  assign spi_reset = reset;
  assign spi_io_req_valid = deviceAdapter_io_reqOut_valid; // @[SpiHarness.scala 75:14]
  assign spi_io_req_bits_addrRequest = deviceAdapter_io_reqOut_bits_addrRequest; // @[SpiHarness.scala 75:14]
  assign spi_io_req_bits_dataRequest = deviceAdapter_io_reqOut_bits_dataRequest; // @[SpiHarness.scala 75:14]
  assign spi_io_req_bits_activeByteLane = deviceAdapter_io_reqOut_bits_activeByteLane; // @[SpiHarness.scala 75:14]
  assign spi_io_req_bits_isWrite = deviceAdapter_io_reqOut_bits_isWrite; // @[SpiHarness.scala 75:14]
  assign spi_io_rsp_ready = deviceAdapter_io_rspIn_ready; // @[SpiHarness.scala 76:14]
  assign spi_io_miso = io_miso; // @[SpiHarness.scala 83:17]
endmodule
