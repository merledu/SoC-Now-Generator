module InstructionFetch(
  input  [31:0]  io_address,
  output [31:0]  io_instruction,
  input          io_coreInstrReq_ready,
  output         io_coreInstrReq_valid,
  output [31:0]  io_coreInstrReq_bits_addrRequest,
  input          io_coreInstrResp_valid,
  input  [255:0] io_coreInstrResp_bits_dataResponse
);
  wire [255:0] _T_1 = io_coreInstrResp_valid ? io_coreInstrResp_bits_dataResponse : 256'h0; // @[InstructionFetch.scala 26:24]
  assign io_instruction = _T_1[31:0]; // @[InstructionFetch.scala 26:18]
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
module MDU(
  input         clock,
  input         reset,
  input  [31:0] io_src_a,
  input  [31:0] io_src_b,
  input  [4:0]  io_op,
  output        io_ready,
  output        io_output_valid,
  output [31:0] io_output_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  _T = io_op == 5'h0; // @[MDU.scala 18:30]
  wire  _T_1 = io_op == 5'h1; // @[MDU.scala 18:47]
  wire  _T_2 = io_op == 5'h0 | io_op == 5'h1; // @[MDU.scala 18:38]
  wire [63:0] _T_3 = $signed(io_src_a) * $signed(io_src_b); // @[MDU.scala 18:78]
  wire  _T_4 = io_op == 5'h2; // @[MDU.scala 19:28]
  wire [63:0] _T_7 = $signed(io_src_a) * $signed(io_src_b); // @[MDU.scala 19:78]
  wire  _T_8 = io_op == 5'h3; // @[MDU.scala 20:28]
  wire [31:0] _T_9 = io_src_a; // @[MDU.scala 20:79]
  wire [63:0] _T_12 = io_src_a * io_src_b; // @[MDU.scala 20:105]
  wire [63:0] _T_13 = _T_8 ? $signed(_T_12) : $signed(64'sh0); // @[Mux.scala 98:16]
  wire [63:0] _T_14 = _T_4 ? $signed(_T_7) : $signed(_T_13); // @[Mux.scala 98:16]
  wire [63:0] out_wire = _T_2 ? $signed(_T_3) : $signed(_T_14); // @[Mux.scala 98:16]
  reg  r_ready; // @[MDU.scala 26:29]
  reg [31:0] r_dividend; // @[MDU.scala 28:29]
  reg [31:0] r_quotient; // @[MDU.scala 29:29]
  wire  _T_16 = io_op == 5'h5; // @[MDU.scala 34:16]
  wire  _T_17 = io_op == 5'h7; // @[MDU.scala 34:33]
  wire [94:0] _GEN_10 = {{63'd0}, _T_9}; // @[MDU.scala 37:32 MDU.scala 40:24]
  wire  _GEN_13 = io_op == 5'h5 | io_op == 5'h7 ? 1'h0 : r_ready; // @[MDU.scala 34:41 MDU.scala 26:29]
  wire [94:0] _GEN_15 = io_op == 5'h5 | io_op == 5'h7 ? _GEN_10 : {{63'd0}, r_dividend}; // @[MDU.scala 34:41 MDU.scala 28:29]
  wire [63:0] _GEN_16 = io_op == 5'h5 | io_op == 5'h7 ? 64'h0 : {{32'd0}, r_quotient}; // @[MDU.scala 34:41 MDU.scala 29:29]
  wire [31:0] _T_42 = out_wire[31:0]; // @[MDU.scala 54:42]
  wire  _T_49 = _T_1 & _T_1 & _T_4 & _T_8; // @[MDU.scala 56:64]
  wire [31:0] _T_51 = out_wire[63:32]; // @[MDU.scala 57:43]
  wire [31:0] _GEN_18 = _T_17 ? $signed(r_dividend) : $signed(32'sh0); // @[MDU.scala 61:30 MDU.scala 62:24 MDU.scala 64:24]
  wire [31:0] _GEN_19 = _T_16 ? $signed(r_quotient) : $signed(_GEN_18); // @[MDU.scala 59:30 MDU.scala 60:24]
  wire [31:0] _GEN_20 = _T_1 & _T_1 & _T_4 & _T_8 ? $signed(_T_51) : $signed(_GEN_19); // @[MDU.scala 56:81 MDU.scala 57:24]
  assign io_ready = r_ready; // @[MDU.scala 52:18]
  assign io_output_valid = _T | _T_49; // @[MDU.scala 53:24 MDU.scala 55:25]
  assign io_output_bits = _T ? $signed(_T_42) : $signed(_GEN_20); // @[MDU.scala 53:24 MDU.scala 54:24]
  always @(posedge clock) begin
    r_ready <= reset | _GEN_13; // @[MDU.scala 26:29 MDU.scala 26:29]
    if (reset) begin // @[MDU.scala 28:29]
      r_dividend <= 32'h0; // @[MDU.scala 28:29]
    end else begin
      r_dividend <= _GEN_15[31:0];
    end
    if (reset) begin // @[MDU.scala 29:29]
      r_quotient <= 32'h0; // @[MDU.scala 29:29]
    end else begin
      r_quotient <= _GEN_16[31:0];
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
  r_ready = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  r_dividend = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  r_quotient = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MduControl(
  input  [1:0] io_aluOp,
  input  [6:0] io_f7,
  input  [2:0] io_f3,
  output [3:0] io_op
);
  wire [2:0] _GEN_0 = io_f7 == 7'h1 & (io_f3 == 3'h0 | io_f3 == 3'h1 | io_f3 == 3'h2 | io_f3 == 3'h3 | io_f3 == 3'h4 |
    io_f3 == 3'h5 | io_f3 == 3'h6 | io_f3 == 3'h7) ? io_f3 : {{1'd0}, io_aluOp}; // @[MduControl.scala 15:160 MduControl.scala 16:13 MduControl.scala 19:13]
  assign io_op = {{1'd0}, _GEN_0}; // @[MduControl.scala 15:160 MduControl.scala 16:13 MduControl.scala 19:13]
endmodule
module Execute(
  input         clock,
  input         reset,
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
  wire  MDU_clock; // @[Execute.scala 80:22]
  wire  MDU_reset; // @[Execute.scala 80:22]
  wire [31:0] MDU_io_src_a; // @[Execute.scala 80:22]
  wire [31:0] MDU_io_src_b; // @[Execute.scala 80:22]
  wire [4:0] MDU_io_op; // @[Execute.scala 80:22]
  wire  MDU_io_ready; // @[Execute.scala 80:22]
  wire  MDU_io_output_valid; // @[Execute.scala 80:22]
  wire [31:0] MDU_io_output_bits; // @[Execute.scala 80:22]
  wire [1:0] MduControl_io_aluOp; // @[Execute.scala 81:24]
  wire [6:0] MduControl_io_f7; // @[Execute.scala 81:24]
  wire [2:0] MduControl_io_f3; // @[Execute.scala 81:24]
  wire [3:0] MduControl_io_op; // @[Execute.scala 81:24]
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
  wire [31:0] _T_23 = MDU_io_output_valid ? $signed(MDU_io_output_bits) : $signed(32'sh0); // @[Execute.scala 93:113]
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
  MDU MDU ( // @[Execute.scala 80:22]
    .clock(MDU_clock),
    .reset(MDU_reset),
    .io_src_a(MDU_io_src_a),
    .io_src_b(MDU_io_src_b),
    .io_op(MDU_io_op),
    .io_ready(MDU_io_ready),
    .io_output_valid(MDU_io_output_valid),
    .io_output_bits(MDU_io_output_bits)
  );
  MduControl MduControl ( // @[Execute.scala 81:24]
    .io_aluOp(MduControl_io_aluOp),
    .io_f7(MduControl_io_f7),
    .io_f3(MduControl_io_f3),
    .io_op(MduControl_io_op)
  );
  assign io_writeData = _T_9 ? io_readData2 : _T_13; // @[Mux.scala 98:16]
  assign io_ALUresult = io_func7 == 7'h1 & MDU_io_ready ? _T_23 : alu_io_result; // @[Execute.scala 93:44 Execute.scala 93:58 Execute.scala 94:29]
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
  assign MDU_clock = clock;
  assign MDU_reset = reset;
  assign MDU_io_src_a = _T_14 ? io_pcAddress : _T_16; // @[Execute.scala 88:28]
  assign MDU_io_src_b = io_ctl_aluSrc ? inputMux2 : io_immediate; // @[Execute.scala 89:28]
  assign MDU_io_op = {{1'd0}, MduControl_io_op}; // @[Execute.scala 90:15]
  assign MduControl_io_aluOp = io_ctl_aluOp; // @[Execute.scala 85:21]
  assign MduControl_io_f7 = io_func7; // @[Execute.scala 84:18]
  assign MduControl_io_f3 = io_func3; // @[Execute.scala 83:18]
endmodule
module MemoryFetch(
  input          clock,
  input          reset,
  input  [31:0]  io_aluResultIn,
  input  [31:0]  io_writeData,
  input          io_writeEnable,
  input          io_readEnable,
  output [31:0]  io_readData,
  output         io_stall,
  output         io_dccmReq_valid,
  output [31:0]  io_dccmReq_bits_addrRequest,
  output [255:0] io_dccmReq_bits_dataRequest,
  output         io_dccmReq_bits_isWrite,
  input          io_dccmRsp_valid,
  input  [255:0] io_dccmRsp_bits_dataResponse
);
  wire  _T = io_writeEnable | io_readEnable; // @[MemoryFetch.scala 33:42]
  wire [255:0] _T_5 = io_dccmRsp_valid ? io_dccmRsp_bits_dataResponse : 256'h0; // @[MemoryFetch.scala 40:21]
  wire  _T_8 = io_writeEnable & io_aluResultIn[31:28] == 4'h8; // @[MemoryFetch.scala 42:23]
  assign io_readData = _T_5[31:0]; // @[MemoryFetch.scala 40:15]
  assign io_stall = _T & ~io_dccmRsp_valid; // @[MemoryFetch.scala 35:49]
  assign io_dccmReq_valid = io_writeEnable | io_readEnable; // @[MemoryFetch.scala 33:42]
  assign io_dccmReq_bits_addrRequest = io_aluResultIn; // @[MemoryFetch.scala 31:31]
  assign io_dccmReq_bits_dataRequest = {{224'd0}, io_writeData}; // @[MemoryFetch.scala 30:31]
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
module RVFI(
  input         clock,
  input         reset,
  input         io_stall,
  input  [31:0] io_insn,
  input  [31:0] io_rs1_rdata,
  input  [31:0] io_rs2_rdata,
  input  [4:0]  io_rd_addr,
  input  [31:0] io_rd_wdata,
  input  [31:0] io_pc,
  input  [31:0] io_pc_offset,
  input  [31:0] io_pc_four,
  input         io_pc_src,
  output        io_rvfi_valid,
  output [63:0] io_rvfi_order,
  output [31:0] io_rvfi_insn,
  output [4:0]  io_rvfi_rs1_addr,
  output [31:0] io_rvfi_rs1_rdata,
  output [4:0]  io_rvfi_rs2_addr,
  output [31:0] io_rvfi_rs2_rdata,
  output [4:0]  io_rvfi_rd_addr,
  output [31:0] io_rvfi_rd_wdata,
  output [31:0] io_rvfi_pc_rdata,
  output [31:0] io_rvfi_pc_wdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  rvfi_valid; // @[RVFI.scala 44:27]
  reg [63:0] rvfi_order; // @[RVFI.scala 45:27]
  wire [63:0] _T_5 = rvfi_order + 64'h1; // @[RVFI.scala 53:30]
  assign io_rvfi_valid = rvfi_valid; // @[RVFI.scala 68:17]
  assign io_rvfi_order = rvfi_order; // @[RVFI.scala 69:17]
  assign io_rvfi_insn = io_insn; // @[RVFI.scala 70:16]
  assign io_rvfi_rs1_addr = io_insn[19:15]; // @[RVFI.scala 59:30]
  assign io_rvfi_rs1_rdata = io_rs1_rdata; // @[RVFI.scala 60:43]
  assign io_rvfi_rs2_addr = io_insn[24:20]; // @[RVFI.scala 61:30]
  assign io_rvfi_rs2_rdata = io_rs2_rdata; // @[RVFI.scala 62:43]
  assign io_rvfi_rd_addr = io_rd_addr; // @[RVFI.scala 64:19]
  assign io_rvfi_rd_wdata = io_rd_wdata; // @[RVFI.scala 65:41]
  assign io_rvfi_pc_rdata = io_pc; // @[RVFI.scala 56:35]
  assign io_rvfi_pc_wdata = io_pc_src ? io_pc_offset : io_pc_four; // @[RVFI.scala 57:26]
  always @(posedge clock) begin
    if (reset) begin // @[RVFI.scala 44:27]
      rvfi_valid <= 1'h0; // @[RVFI.scala 44:27]
    end else begin
      rvfi_valid <= ~reset & ~io_stall; // @[RVFI.scala 50:14]
    end
    if (reset) begin // @[RVFI.scala 45:27]
      rvfi_order <= 64'h0; // @[RVFI.scala 45:27]
    end else if (rvfi_valid) begin // @[RVFI.scala 52:19]
      rvfi_order <= _T_5; // @[RVFI.scala 53:16]
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
  rvfi_valid = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  rvfi_order = _RAND_1[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Core(
  input          clock,
  input          reset,
  output [31:0]  io_pin,
  output         io_dmemReq_valid,
  output [31:0]  io_dmemReq_bits_addrRequest,
  output [255:0] io_dmemReq_bits_dataRequest,
  output         io_dmemReq_bits_isWrite,
  input          io_dmemRsp_valid,
  input  [255:0] io_dmemRsp_bits_dataResponse,
  input          io_imemReq_ready,
  output         io_imemReq_valid,
  output [31:0]  io_imemReq_bits_addrRequest,
  input          io_imemRsp_valid,
  input  [255:0] io_imemRsp_bits_dataResponse,
  output         io_rvfi_valid,
  output [63:0]  io_rvfi_order,
  output [31:0]  io_rvfi_insn,
  output [4:0]   io_rvfi_rs1_addr,
  output [31:0]  io_rvfi_rs1_rdata,
  output [4:0]   io_rvfi_rs2_addr,
  output [31:0]  io_rvfi_rs2_rdata,
  output [4:0]   io_rvfi_rd_addr,
  output [31:0]  io_rvfi_rd_wdata,
  output [31:0]  io_rvfi_pc_rdata,
  output [31:0]  io_rvfi_pc_wdata
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
  wire [255:0] InstructionFetch_io_coreInstrResp_bits_dataResponse; // @[Core.scala 70:18]
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
  wire  Execute_clock; // @[Core.scala 72:18]
  wire  Execute_reset; // @[Core.scala 72:18]
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
  wire [255:0] MEM_io_dccmReq_bits_dataRequest; // @[Core.scala 73:19]
  wire  MEM_io_dccmReq_bits_isWrite; // @[Core.scala 73:19]
  wire  MEM_io_dccmRsp_valid; // @[Core.scala 73:19]
  wire [255:0] MEM_io_dccmRsp_bits_dataResponse; // @[Core.scala 73:19]
  wire  pc_clock; // @[Core.scala 79:18]
  wire  pc_reset; // @[Core.scala 79:18]
  wire [31:0] pc_io_in; // @[Core.scala 79:18]
  wire  pc_io_halt; // @[Core.scala 79:18]
  wire [31:0] pc_io_out; // @[Core.scala 79:18]
  wire [31:0] pc_io_pc4; // @[Core.scala 79:18]
  wire  rvfi_clock; // @[Core.scala 245:20]
  wire  rvfi_reset; // @[Core.scala 245:20]
  wire  rvfi_io_stall; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_insn; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_rs1_rdata; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_rs2_rdata; // @[Core.scala 245:20]
  wire [4:0] rvfi_io_rd_addr; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_rd_wdata; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_pc; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_pc_offset; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_pc_four; // @[Core.scala 245:20]
  wire  rvfi_io_pc_src; // @[Core.scala 245:20]
  wire  rvfi_io_rvfi_valid; // @[Core.scala 245:20]
  wire [63:0] rvfi_io_rvfi_order; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_rvfi_insn; // @[Core.scala 245:20]
  wire [4:0] rvfi_io_rvfi_rs1_addr; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_rvfi_rs1_rdata; // @[Core.scala 245:20]
  wire [4:0] rvfi_io_rvfi_rs2_addr; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_rvfi_rs2_rdata; // @[Core.scala 245:20]
  wire [4:0] rvfi_io_rvfi_rd_addr; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_rvfi_rd_wdata; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_rvfi_pc_rdata; // @[Core.scala 245:20]
  wire [31:0] rvfi_io_rvfi_pc_wdata; // @[Core.scala 245:20]
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
    .clock(Execute_clock),
    .reset(Execute_reset),
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
  RVFI rvfi ( // @[Core.scala 245:20]
    .clock(rvfi_clock),
    .reset(rvfi_reset),
    .io_stall(rvfi_io_stall),
    .io_insn(rvfi_io_insn),
    .io_rs1_rdata(rvfi_io_rs1_rdata),
    .io_rs2_rdata(rvfi_io_rs2_rdata),
    .io_rd_addr(rvfi_io_rd_addr),
    .io_rd_wdata(rvfi_io_rd_wdata),
    .io_pc(rvfi_io_pc),
    .io_pc_offset(rvfi_io_pc_offset),
    .io_pc_four(rvfi_io_pc_four),
    .io_pc_src(rvfi_io_pc_src),
    .io_rvfi_valid(rvfi_io_rvfi_valid),
    .io_rvfi_order(rvfi_io_rvfi_order),
    .io_rvfi_insn(rvfi_io_rvfi_insn),
    .io_rvfi_rs1_addr(rvfi_io_rvfi_rs1_addr),
    .io_rvfi_rs1_rdata(rvfi_io_rvfi_rs1_rdata),
    .io_rvfi_rs2_addr(rvfi_io_rvfi_rs2_addr),
    .io_rvfi_rs2_rdata(rvfi_io_rvfi_rs2_rdata),
    .io_rvfi_rd_addr(rvfi_io_rvfi_rd_addr),
    .io_rvfi_rd_wdata(rvfi_io_rvfi_rd_wdata),
    .io_rvfi_pc_rdata(rvfi_io_rvfi_pc_rdata),
    .io_rvfi_pc_wdata(rvfi_io_rvfi_pc_wdata)
  );
  assign io_pin = mem_reg_ctl_memToReg == 2'h1 ? MEM_io_readData : _GEN_14; // @[Core.scala 223:38 Core.scala 224:13]
  assign io_dmemReq_valid = MEM_io_dccmReq_valid; // @[Core.scala 177:14]
  assign io_dmemReq_bits_addrRequest = MEM_io_dccmReq_bits_addrRequest; // @[Core.scala 177:14]
  assign io_dmemReq_bits_dataRequest = MEM_io_dccmReq_bits_dataRequest; // @[Core.scala 177:14]
  assign io_dmemReq_bits_isWrite = MEM_io_dccmReq_bits_isWrite; // @[Core.scala 177:14]
  assign io_imemReq_valid = InstructionFetch_io_coreInstrReq_valid; // @[Core.scala 81:14]
  assign io_imemReq_bits_addrRequest = InstructionFetch_io_coreInstrReq_bits_addrRequest; // @[Core.scala 81:14]
  assign io_rvfi_valid = rvfi_io_rvfi_valid; // @[Core.scala 257:11]
  assign io_rvfi_order = rvfi_io_rvfi_order; // @[Core.scala 257:11]
  assign io_rvfi_insn = rvfi_io_rvfi_insn; // @[Core.scala 257:11]
  assign io_rvfi_rs1_addr = rvfi_io_rvfi_rs1_addr; // @[Core.scala 257:11]
  assign io_rvfi_rs1_rdata = rvfi_io_rvfi_rs1_rdata; // @[Core.scala 257:11]
  assign io_rvfi_rs2_addr = rvfi_io_rvfi_rs2_addr; // @[Core.scala 257:11]
  assign io_rvfi_rs2_rdata = rvfi_io_rvfi_rs2_rdata; // @[Core.scala 257:11]
  assign io_rvfi_rd_addr = rvfi_io_rvfi_rd_addr; // @[Core.scala 257:11]
  assign io_rvfi_rd_wdata = rvfi_io_rvfi_rd_wdata; // @[Core.scala 257:11]
  assign io_rvfi_pc_rdata = rvfi_io_rvfi_pc_rdata; // @[Core.scala 257:11]
  assign io_rvfi_pc_wdata = rvfi_io_rvfi_pc_wdata; // @[Core.scala 257:11]
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
  assign Execute_clock = clock;
  assign Execute_reset = reset;
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
  assign rvfi_clock = clock;
  assign rvfi_reset = reset;
  assign rvfi_io_stall = MEM_io_stall; // @[Core.scala 246:17]
  assign rvfi_io_insn = if_reg_ins; // @[Core.scala 255:16]
  assign rvfi_io_rs1_rdata = InstructionDecode_io_readData1; // @[Core.scala 253:21]
  assign rvfi_io_rs2_rdata = InstructionDecode_io_readData2; // @[Core.scala 254:21]
  assign rvfi_io_rd_addr = mem_reg_ctl_memToReg == 2'h1 ? _T_16 : mem_reg_wra; // @[Core.scala 223:38 Core.scala 225:13]
  assign rvfi_io_rd_wdata = mem_reg_ctl_memToReg == 2'h1 ? MEM_io_readData : _GEN_14; // @[Core.scala 223:38 Core.scala 224:13]
  assign rvfi_io_pc = pc_io_out; // @[Core.scala 247:14]
  assign rvfi_io_pc_offset = pc_io_in; // @[Core.scala 250:21]
  assign rvfi_io_pc_four = pc_io_pc4; // @[Core.scala 249:19]
  assign rvfi_io_pc_src = InstructionDecode_io_pcSrc; // @[Core.scala 248:18]
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
module TilelinkHost(
  input          clock,
  input          reset,
  output         io_tlMasterTransmitter_valid,
  output [2:0]   io_tlMasterTransmitter_bits_a_opcode,
  output [31:0]  io_tlMasterTransmitter_bits_a_address,
  output [31:0]  io_tlMasterTransmitter_bits_a_mask,
  output [255:0] io_tlMasterTransmitter_bits_a_data,
  input          io_tlSlaveReceiver_valid,
  input  [255:0] io_tlSlaveReceiver_bits_d_data,
  output         io_reqIn_ready,
  input          io_reqIn_valid,
  input  [31:0]  io_reqIn_bits_addrRequest,
  input  [255:0] io_reqIn_bits_dataRequest,
  input          io_reqIn_bits_isWrite,
  output         io_rspOut_valid,
  output [255:0] io_rspOut_bits_dataResponse
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[TilelinkHost.scala 19:27]
  reg [31:0] addrReg; // @[TilelinkHost.scala 20:27]
  wire [2:0] _io_tlMasterTransmitter_bits_a_opcode_T_2 = io_reqIn_bits_isWrite ? 3'h0 : 3'h4; // @[TilelinkHost.scala 62:59]
  wire [2:0] _GEN_0 = io_reqIn_valid ? _io_tlMasterTransmitter_bits_a_opcode_T_2 : 3'h0; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 62:53 TilelinkHost.scala 40:45]
  wire [255:0] _GEN_1 = io_reqIn_valid ? io_reqIn_bits_dataRequest : 256'h0; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 63:53 TilelinkHost.scala 41:45]
  wire [31:0] _GEN_2 = io_reqIn_valid ? io_reqIn_bits_addrRequest : addrReg; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 64:53 TilelinkHost.scala 42:45]
  wire [31:0] _GEN_6 = io_reqIn_valid ? 32'hf : 32'h0; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 73:53 TilelinkHost.scala 46:45]
  wire  _GEN_8 = io_reqIn_valid | stateReg; // @[TilelinkHost.scala 60:29 TilelinkHost.scala 77:22 TilelinkHost.scala 19:27]
  wire [255:0] _GEN_10 = io_tlSlaveReceiver_valid ? io_tlSlaveReceiver_bits_d_data : 256'h0; // @[TilelinkHost.scala 89:39 TilelinkHost.scala 91:41 TilelinkHost.scala 50:45]
  wire  _GEN_15 = stateReg ? 1'h0 : 1'h1; // @[TilelinkHost.scala 84:43 TilelinkHost.scala 87:34 TilelinkHost.scala 33:33]
  wire [255:0] _GEN_16 = stateReg ? _GEN_10 : 256'h0; // @[TilelinkHost.scala 84:43 TilelinkHost.scala 50:45]
  wire  _GEN_18 = stateReg & io_tlSlaveReceiver_valid; // @[TilelinkHost.scala 84:43 TilelinkHost.scala 53:45]
  assign io_tlMasterTransmitter_valid = ~stateReg & io_reqIn_valid; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 48:45]
  assign io_tlMasterTransmitter_bits_a_opcode = ~stateReg ? _GEN_0 : 3'h0; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 40:45]
  assign io_tlMasterTransmitter_bits_a_address = ~stateReg ? _GEN_2 : addrReg; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 42:45]
  assign io_tlMasterTransmitter_bits_a_mask = ~stateReg ? _GEN_6 : 32'h0; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 46:45]
  assign io_tlMasterTransmitter_bits_a_data = ~stateReg ? _GEN_1 : 256'h0; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 41:45]
  assign io_reqIn_ready = ~stateReg | _GEN_15; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 33:33]
  assign io_rspOut_valid = ~stateReg ? 1'h0 : _GEN_18; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 53:45]
  assign io_rspOut_bits_dataResponse = ~stateReg ? 256'h0 : _GEN_16; // @[TilelinkHost.scala 56:28 TilelinkHost.scala 50:45]
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
  input          clock,
  input          reset,
  output         io_tlSlaveTransmitter_valid,
  output [255:0] io_tlSlaveTransmitter_bits_d_data,
  input          io_tlMasterReceiver_valid,
  input  [2:0]   io_tlMasterReceiver_bits_a_opcode,
  input  [31:0]  io_tlMasterReceiver_bits_a_address,
  input  [31:0]  io_tlMasterReceiver_bits_a_mask,
  input  [255:0] io_tlMasterReceiver_bits_a_data,
  output         io_reqOut_valid,
  output [31:0]  io_reqOut_bits_addrRequest,
  output [255:0] io_reqOut_bits_dataRequest,
  output [31:0]  io_reqOut_bits_activeByteLane,
  output         io_reqOut_bits_isWrite,
  input          io_rspIn_valid,
  input  [255:0] io_rspIn_bits_dataResponse
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[TilelinkDevice.scala 17:27]
  wire [31:0] _GEN_0 = io_tlMasterReceiver_valid ? io_tlMasterReceiver_bits_a_address : 32'h0; // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 45:40 TilelinkDevice.scala 23:37]
  wire [255:0] _GEN_1 = io_tlMasterReceiver_valid ? io_tlMasterReceiver_bits_a_data : 256'h0; // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 46:40 TilelinkDevice.scala 24:37]
  wire [31:0] _GEN_2 = io_tlMasterReceiver_valid ? io_tlMasterReceiver_bits_a_mask : 32'h0; // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 47:43 TilelinkDevice.scala 25:37]
  wire  _GEN_3 = io_tlMasterReceiver_valid & (io_tlMasterReceiver_bits_a_opcode == 3'h0 |
    io_tlMasterReceiver_bits_a_opcode == 3'h1); // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 48:36 TilelinkDevice.scala 26:37]
  wire  _GEN_5 = io_tlMasterReceiver_valid | stateReg; // @[TilelinkDevice.scala 43:40 TilelinkDevice.scala 51:22 TilelinkDevice.scala 17:27]
  wire [255:0] _GEN_7 = io_rspIn_valid ? io_rspIn_bits_dataResponse : 256'h0; // @[TilelinkDevice.scala 60:29 TilelinkDevice.scala 63:47 TilelinkDevice.scala 30:45]
  wire  _GEN_15 = stateReg & io_rspIn_valid; // @[TilelinkDevice.scala 56:43 TilelinkDevice.scala 29:45]
  wire [255:0] _GEN_16 = stateReg ? _GEN_7 : 256'h0; // @[TilelinkDevice.scala 56:43 TilelinkDevice.scala 30:45]
  assign io_tlSlaveTransmitter_valid = ~stateReg ? 1'h0 : _GEN_15; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 37:45]
  assign io_tlSlaveTransmitter_bits_d_data = ~stateReg ? 256'h0 : _GEN_16; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 30:45]
  assign io_reqOut_valid = ~stateReg & io_tlMasterReceiver_valid; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 27:37]
  assign io_reqOut_bits_addrRequest = ~stateReg ? _GEN_0 : 32'h0; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 23:37]
  assign io_reqOut_bits_dataRequest = ~stateReg ? _GEN_1 : 256'h0; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 24:37]
  assign io_reqOut_bits_activeByteLane = ~stateReg ? _GEN_2 : 32'h0; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 25:37]
  assign io_reqOut_bits_isWrite = ~stateReg & _GEN_3; // @[TilelinkDevice.scala 41:28 TilelinkDevice.scala 26:37]
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
module TilelinkAdapter(
  input          clock,
  input          reset,
  output         io_reqIn_ready,
  input          io_reqIn_valid,
  input  [31:0]  io_reqIn_bits_addrRequest,
  input  [255:0] io_reqIn_bits_dataRequest,
  input          io_reqIn_bits_isWrite,
  output         io_rspOut_valid,
  output [255:0] io_rspOut_bits_dataResponse,
  output         io_reqOut_valid,
  output [31:0]  io_reqOut_bits_addrRequest,
  output [255:0] io_reqOut_bits_dataRequest,
  output [31:0]  io_reqOut_bits_activeByteLane,
  output         io_reqOut_bits_isWrite,
  input          io_rspIn_valid,
  input  [255:0] io_rspIn_bits_dataResponse
);
  wire  tlHost_clock; // @[Adapter.scala 54:24]
  wire  tlHost_reset; // @[Adapter.scala 54:24]
  wire  tlHost_io_tlMasterTransmitter_valid; // @[Adapter.scala 54:24]
  wire [2:0] tlHost_io_tlMasterTransmitter_bits_a_opcode; // @[Adapter.scala 54:24]
  wire [31:0] tlHost_io_tlMasterTransmitter_bits_a_address; // @[Adapter.scala 54:24]
  wire [31:0] tlHost_io_tlMasterTransmitter_bits_a_mask; // @[Adapter.scala 54:24]
  wire [255:0] tlHost_io_tlMasterTransmitter_bits_a_data; // @[Adapter.scala 54:24]
  wire  tlHost_io_tlSlaveReceiver_valid; // @[Adapter.scala 54:24]
  wire [255:0] tlHost_io_tlSlaveReceiver_bits_d_data; // @[Adapter.scala 54:24]
  wire  tlHost_io_reqIn_ready; // @[Adapter.scala 54:24]
  wire  tlHost_io_reqIn_valid; // @[Adapter.scala 54:24]
  wire [31:0] tlHost_io_reqIn_bits_addrRequest; // @[Adapter.scala 54:24]
  wire [255:0] tlHost_io_reqIn_bits_dataRequest; // @[Adapter.scala 54:24]
  wire  tlHost_io_reqIn_bits_isWrite; // @[Adapter.scala 54:24]
  wire  tlHost_io_rspOut_valid; // @[Adapter.scala 54:24]
  wire [255:0] tlHost_io_rspOut_bits_dataResponse; // @[Adapter.scala 54:24]
  wire  tlSlave_clock; // @[Adapter.scala 55:25]
  wire  tlSlave_reset; // @[Adapter.scala 55:25]
  wire  tlSlave_io_tlSlaveTransmitter_valid; // @[Adapter.scala 55:25]
  wire [255:0] tlSlave_io_tlSlaveTransmitter_bits_d_data; // @[Adapter.scala 55:25]
  wire  tlSlave_io_tlMasterReceiver_valid; // @[Adapter.scala 55:25]
  wire [2:0] tlSlave_io_tlMasterReceiver_bits_a_opcode; // @[Adapter.scala 55:25]
  wire [31:0] tlSlave_io_tlMasterReceiver_bits_a_address; // @[Adapter.scala 55:25]
  wire [31:0] tlSlave_io_tlMasterReceiver_bits_a_mask; // @[Adapter.scala 55:25]
  wire [255:0] tlSlave_io_tlMasterReceiver_bits_a_data; // @[Adapter.scala 55:25]
  wire  tlSlave_io_reqOut_valid; // @[Adapter.scala 55:25]
  wire [31:0] tlSlave_io_reqOut_bits_addrRequest; // @[Adapter.scala 55:25]
  wire [255:0] tlSlave_io_reqOut_bits_dataRequest; // @[Adapter.scala 55:25]
  wire [31:0] tlSlave_io_reqOut_bits_activeByteLane; // @[Adapter.scala 55:25]
  wire  tlSlave_io_reqOut_bits_isWrite; // @[Adapter.scala 55:25]
  wire  tlSlave_io_rspIn_valid; // @[Adapter.scala 55:25]
  wire [255:0] tlSlave_io_rspIn_bits_dataResponse; // @[Adapter.scala 55:25]
  TilelinkHost tlHost ( // @[Adapter.scala 54:24]
    .clock(tlHost_clock),
    .reset(tlHost_reset),
    .io_tlMasterTransmitter_valid(tlHost_io_tlMasterTransmitter_valid),
    .io_tlMasterTransmitter_bits_a_opcode(tlHost_io_tlMasterTransmitter_bits_a_opcode),
    .io_tlMasterTransmitter_bits_a_address(tlHost_io_tlMasterTransmitter_bits_a_address),
    .io_tlMasterTransmitter_bits_a_mask(tlHost_io_tlMasterTransmitter_bits_a_mask),
    .io_tlMasterTransmitter_bits_a_data(tlHost_io_tlMasterTransmitter_bits_a_data),
    .io_tlSlaveReceiver_valid(tlHost_io_tlSlaveReceiver_valid),
    .io_tlSlaveReceiver_bits_d_data(tlHost_io_tlSlaveReceiver_bits_d_data),
    .io_reqIn_ready(tlHost_io_reqIn_ready),
    .io_reqIn_valid(tlHost_io_reqIn_valid),
    .io_reqIn_bits_addrRequest(tlHost_io_reqIn_bits_addrRequest),
    .io_reqIn_bits_dataRequest(tlHost_io_reqIn_bits_dataRequest),
    .io_reqIn_bits_isWrite(tlHost_io_reqIn_bits_isWrite),
    .io_rspOut_valid(tlHost_io_rspOut_valid),
    .io_rspOut_bits_dataResponse(tlHost_io_rspOut_bits_dataResponse)
  );
  TilelinkDevice tlSlave ( // @[Adapter.scala 55:25]
    .clock(tlSlave_clock),
    .reset(tlSlave_reset),
    .io_tlSlaveTransmitter_valid(tlSlave_io_tlSlaveTransmitter_valid),
    .io_tlSlaveTransmitter_bits_d_data(tlSlave_io_tlSlaveTransmitter_bits_d_data),
    .io_tlMasterReceiver_valid(tlSlave_io_tlMasterReceiver_valid),
    .io_tlMasterReceiver_bits_a_opcode(tlSlave_io_tlMasterReceiver_bits_a_opcode),
    .io_tlMasterReceiver_bits_a_address(tlSlave_io_tlMasterReceiver_bits_a_address),
    .io_tlMasterReceiver_bits_a_mask(tlSlave_io_tlMasterReceiver_bits_a_mask),
    .io_tlMasterReceiver_bits_a_data(tlSlave_io_tlMasterReceiver_bits_a_data),
    .io_reqOut_valid(tlSlave_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(tlSlave_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(tlSlave_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(tlSlave_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(tlSlave_io_reqOut_bits_isWrite),
    .io_rspIn_valid(tlSlave_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(tlSlave_io_rspIn_bits_dataResponse)
  );
  assign io_reqIn_ready = tlHost_io_reqIn_ready; // @[Adapter.scala 64:21]
  assign io_rspOut_valid = tlHost_io_rspOut_valid; // @[Adapter.scala 67:15]
  assign io_rspOut_bits_dataResponse = tlHost_io_rspOut_bits_dataResponse; // @[Adapter.scala 67:15]
  assign io_reqOut_valid = tlSlave_io_reqOut_valid; // @[Adapter.scala 70:15]
  assign io_reqOut_bits_addrRequest = tlSlave_io_reqOut_bits_addrRequest; // @[Adapter.scala 70:15]
  assign io_reqOut_bits_dataRequest = tlSlave_io_reqOut_bits_dataRequest; // @[Adapter.scala 70:15]
  assign io_reqOut_bits_activeByteLane = tlSlave_io_reqOut_bits_activeByteLane; // @[Adapter.scala 70:15]
  assign io_reqOut_bits_isWrite = tlSlave_io_reqOut_bits_isWrite; // @[Adapter.scala 70:15]
  assign tlHost_clock = clock;
  assign tlHost_reset = reset;
  assign tlHost_io_tlSlaveReceiver_valid = tlSlave_io_tlSlaveTransmitter_valid; // @[Adapter.scala 61:35]
  assign tlHost_io_tlSlaveReceiver_bits_d_data = tlSlave_io_tlSlaveTransmitter_bits_d_data; // @[Adapter.scala 61:35]
  assign tlHost_io_reqIn_valid = io_reqIn_valid; // @[Adapter.scala 64:21]
  assign tlHost_io_reqIn_bits_addrRequest = io_reqIn_bits_addrRequest; // @[Adapter.scala 64:21]
  assign tlHost_io_reqIn_bits_dataRequest = io_reqIn_bits_dataRequest; // @[Adapter.scala 64:21]
  assign tlHost_io_reqIn_bits_isWrite = io_reqIn_bits_isWrite; // @[Adapter.scala 64:21]
  assign tlSlave_clock = clock;
  assign tlSlave_reset = reset;
  assign tlSlave_io_tlMasterReceiver_valid = tlHost_io_tlMasterTransmitter_valid; // @[Adapter.scala 58:35]
  assign tlSlave_io_tlMasterReceiver_bits_a_opcode = tlHost_io_tlMasterTransmitter_bits_a_opcode; // @[Adapter.scala 58:35]
  assign tlSlave_io_tlMasterReceiver_bits_a_address = tlHost_io_tlMasterTransmitter_bits_a_address; // @[Adapter.scala 58:35]
  assign tlSlave_io_tlMasterReceiver_bits_a_mask = tlHost_io_tlMasterTransmitter_bits_a_mask; // @[Adapter.scala 58:35]
  assign tlSlave_io_tlMasterReceiver_bits_a_data = tlHost_io_tlMasterTransmitter_bits_a_data; // @[Adapter.scala 58:35]
  assign tlSlave_io_rspIn_valid = io_rspIn_valid; // @[Adapter.scala 73:22]
  assign tlSlave_io_rspIn_bits_dataResponse = io_rspIn_bits_dataResponse; // @[Adapter.scala 73:22]
endmodule
module BlockRamWithoutMasking(
  input          clock,
  input          reset,
  output         io_req_ready,
  input          io_req_valid,
  input  [31:0]  io_req_bits_addrRequest,
  input  [255:0] io_req_bits_dataRequest,
  input          io_req_bits_isWrite,
  output         io_rsp_valid,
  output [255:0] io_rsp_bits_dataResponse
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:8191]; // @[BlockRam.scala 82:24]
  wire [31:0] mem_io_rsp_bits_dataResponse_MPORT_data; // @[BlockRam.scala 82:24]
  wire [12:0] mem_io_rsp_bits_dataResponse_MPORT_addr; // @[BlockRam.scala 82:24]
  wire [31:0] mem_MPORT_data; // @[BlockRam.scala 82:24]
  wire [12:0] mem_MPORT_addr; // @[BlockRam.scala 82:24]
  wire  mem_MPORT_mask; // @[BlockRam.scala 82:24]
  wire  mem_MPORT_en; // @[BlockRam.scala 82:24]
  reg  mem_io_rsp_bits_dataResponse_MPORT_en_pipe_0;
  reg [12:0] mem_io_rsp_bits_dataResponse_MPORT_addr_pipe_0;
  reg  validReg; // @[BlockRam.scala 72:25]
  wire  _addrMisaligned_T = io_req_ready & io_req_valid; // @[Decoupled.scala 40:37]
  wire [31:0] _addrOutOfBounds_T_1 = io_req_bits_addrRequest / 3'h4; // @[BlockRam.scala 79:65]
  wire  _T_1 = ~io_req_bits_isWrite; // @[BlockRam.scala 88:25]
  wire  _T_2 = _addrMisaligned_T & ~io_req_bits_isWrite; // @[BlockRam.scala 88:22]
  wire  _T_4 = _addrMisaligned_T & io_req_bits_isWrite; // @[BlockRam.scala 92:29]
  wire  _GEN_9 = _addrMisaligned_T & ~io_req_bits_isWrite | _T_4; // @[BlockRam.scala 88:47 BlockRam.scala 91:14]
  assign mem_io_rsp_bits_dataResponse_MPORT_addr = mem_io_rsp_bits_dataResponse_MPORT_addr_pipe_0;
  assign mem_io_rsp_bits_dataResponse_MPORT_data = mem[mem_io_rsp_bits_dataResponse_MPORT_addr]; // @[BlockRam.scala 82:24]
  assign mem_MPORT_data = io_req_bits_dataRequest[31:0];
  assign mem_MPORT_addr = _addrOutOfBounds_T_1[12:0];
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = _T_2 ? 1'h0 : _T_4;
  assign io_req_ready = 1'h1; // @[BlockRam.scala 76:16]
  assign io_rsp_valid = validReg; // @[BlockRam.scala 74:16]
  assign io_rsp_bits_dataResponse = {{224'd0}, mem_io_rsp_bits_dataResponse_MPORT_data}; // @[BlockRam.scala 88:47 BlockRam.scala 90:30]
  always @(posedge clock) begin
    if(mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[BlockRam.scala 82:24]
    end
    mem_io_rsp_bits_dataResponse_MPORT_en_pipe_0 <= _addrMisaligned_T & _T_1;
    if (_addrMisaligned_T & _T_1) begin
      mem_io_rsp_bits_dataResponse_MPORT_addr_pipe_0 <= _addrOutOfBounds_T_1[12:0];
    end
    if (reset) begin // @[BlockRam.scala 72:25]
      validReg <= 1'h0; // @[BlockRam.scala 72:25]
    end else begin
      validReg <= _GEN_9;
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
  for (initvar = 0; initvar < 8192; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_io_rsp_bits_dataResponse_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_io_rsp_bits_dataResponse_MPORT_addr_pipe_0 = _RAND_2[12:0];
  _RAND_3 = {1{`RANDOM}};
  validReg = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BlockRamWithMasking(
  input          clock,
  input          reset,
  output         io_req_ready,
  input          io_req_valid,
  input  [31:0]  io_req_bits_addrRequest,
  input  [255:0] io_req_bits_dataRequest,
  input  [31:0]  io_req_bits_activeByteLane,
  input          io_req_bits_isWrite,
  output         io_rsp_valid,
  output [255:0] io_rsp_bits_dataResponse
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
  wire [31:0] _io_rsp_bits_dataResponse_T = {data_3,data_2,data_1,data_0}; // @[Cat.scala 30:58]
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
  assign io_rsp_bits_dataResponse = {{224'd0}, _io_rsp_bits_dataResponse_T}; // @[Cat.scala 30:58]
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
module TopTL(
  input         clock,
  input         reset,
  output [31:0] io_pin,
  output        io_rvfi_valid,
  output [63:0] io_rvfi_order,
  output [31:0] io_rvfi_insn,
  output        io_rvfi_trap,
  output        io_rvfi_halt,
  output        io_rvfi_intr,
  output [1:0]  io_rvfi_ixl,
  output [1:0]  io_rvfi_mode,
  output [4:0]  io_rvfi_rs1_addr,
  output [31:0] io_rvfi_rs1_rdata,
  output [4:0]  io_rvfi_rs2_addr,
  output [31:0] io_rvfi_rs2_rdata,
  output [4:0]  io_rvfi_rd_addr,
  output [31:0] io_rvfi_rd_wdata,
  output [31:0] io_rvfi_pc_rdata,
  output [31:0] io_rvfi_pc_wdata
);
  wire  core_clock; // @[Top.scala 60:25]
  wire  core_reset; // @[Top.scala 60:25]
  wire [31:0] core_io_pin; // @[Top.scala 60:25]
  wire  core_io_dmemReq_valid; // @[Top.scala 60:25]
  wire [31:0] core_io_dmemReq_bits_addrRequest; // @[Top.scala 60:25]
  wire [255:0] core_io_dmemReq_bits_dataRequest; // @[Top.scala 60:25]
  wire  core_io_dmemReq_bits_isWrite; // @[Top.scala 60:25]
  wire  core_io_dmemRsp_valid; // @[Top.scala 60:25]
  wire [255:0] core_io_dmemRsp_bits_dataResponse; // @[Top.scala 60:25]
  wire  core_io_imemReq_ready; // @[Top.scala 60:25]
  wire  core_io_imemReq_valid; // @[Top.scala 60:25]
  wire [31:0] core_io_imemReq_bits_addrRequest; // @[Top.scala 60:25]
  wire  core_io_imemRsp_valid; // @[Top.scala 60:25]
  wire [255:0] core_io_imemRsp_bits_dataResponse; // @[Top.scala 60:25]
  wire  core_io_rvfi_valid; // @[Top.scala 60:25]
  wire [63:0] core_io_rvfi_order; // @[Top.scala 60:25]
  wire [31:0] core_io_rvfi_insn; // @[Top.scala 60:25]
  wire [4:0] core_io_rvfi_rs1_addr; // @[Top.scala 60:25]
  wire [31:0] core_io_rvfi_rs1_rdata; // @[Top.scala 60:25]
  wire [4:0] core_io_rvfi_rs2_addr; // @[Top.scala 60:25]
  wire [31:0] core_io_rvfi_rs2_rdata; // @[Top.scala 60:25]
  wire [4:0] core_io_rvfi_rd_addr; // @[Top.scala 60:25]
  wire [31:0] core_io_rvfi_rd_wdata; // @[Top.scala 60:25]
  wire [31:0] core_io_rvfi_pc_rdata; // @[Top.scala 60:25]
  wire [31:0] core_io_rvfi_pc_wdata; // @[Top.scala 60:25]
  wire  imemAdapter_clock; // @[Top.scala 61:26]
  wire  imemAdapter_reset; // @[Top.scala 61:26]
  wire  imemAdapter_io_reqIn_ready; // @[Top.scala 61:26]
  wire  imemAdapter_io_reqIn_valid; // @[Top.scala 61:26]
  wire [31:0] imemAdapter_io_reqIn_bits_addrRequest; // @[Top.scala 61:26]
  wire [255:0] imemAdapter_io_reqIn_bits_dataRequest; // @[Top.scala 61:26]
  wire  imemAdapter_io_reqIn_bits_isWrite; // @[Top.scala 61:26]
  wire  imemAdapter_io_rspOut_valid; // @[Top.scala 61:26]
  wire [255:0] imemAdapter_io_rspOut_bits_dataResponse; // @[Top.scala 61:26]
  wire  imemAdapter_io_reqOut_valid; // @[Top.scala 61:26]
  wire [31:0] imemAdapter_io_reqOut_bits_addrRequest; // @[Top.scala 61:26]
  wire [255:0] imemAdapter_io_reqOut_bits_dataRequest; // @[Top.scala 61:26]
  wire [31:0] imemAdapter_io_reqOut_bits_activeByteLane; // @[Top.scala 61:26]
  wire  imemAdapter_io_reqOut_bits_isWrite; // @[Top.scala 61:26]
  wire  imemAdapter_io_rspIn_valid; // @[Top.scala 61:26]
  wire [255:0] imemAdapter_io_rspIn_bits_dataResponse; // @[Top.scala 61:26]
  wire  dmemAdapter_clock; // @[Top.scala 62:26]
  wire  dmemAdapter_reset; // @[Top.scala 62:26]
  wire  dmemAdapter_io_reqIn_ready; // @[Top.scala 62:26]
  wire  dmemAdapter_io_reqIn_valid; // @[Top.scala 62:26]
  wire [31:0] dmemAdapter_io_reqIn_bits_addrRequest; // @[Top.scala 62:26]
  wire [255:0] dmemAdapter_io_reqIn_bits_dataRequest; // @[Top.scala 62:26]
  wire  dmemAdapter_io_reqIn_bits_isWrite; // @[Top.scala 62:26]
  wire  dmemAdapter_io_rspOut_valid; // @[Top.scala 62:26]
  wire [255:0] dmemAdapter_io_rspOut_bits_dataResponse; // @[Top.scala 62:26]
  wire  dmemAdapter_io_reqOut_valid; // @[Top.scala 62:26]
  wire [31:0] dmemAdapter_io_reqOut_bits_addrRequest; // @[Top.scala 62:26]
  wire [255:0] dmemAdapter_io_reqOut_bits_dataRequest; // @[Top.scala 62:26]
  wire [31:0] dmemAdapter_io_reqOut_bits_activeByteLane; // @[Top.scala 62:26]
  wire  dmemAdapter_io_reqOut_bits_isWrite; // @[Top.scala 62:26]
  wire  dmemAdapter_io_rspIn_valid; // @[Top.scala 62:26]
  wire [255:0] dmemAdapter_io_rspIn_bits_dataResponse; // @[Top.scala 62:26]
  wire  imemCtrl_clock; // @[Top.scala 65:23]
  wire  imemCtrl_reset; // @[Top.scala 65:23]
  wire  imemCtrl_io_req_ready; // @[Top.scala 65:23]
  wire  imemCtrl_io_req_valid; // @[Top.scala 65:23]
  wire [31:0] imemCtrl_io_req_bits_addrRequest; // @[Top.scala 65:23]
  wire [255:0] imemCtrl_io_req_bits_dataRequest; // @[Top.scala 65:23]
  wire  imemCtrl_io_req_bits_isWrite; // @[Top.scala 65:23]
  wire  imemCtrl_io_rsp_valid; // @[Top.scala 65:23]
  wire [255:0] imemCtrl_io_rsp_bits_dataResponse; // @[Top.scala 65:23]
  wire  dmemCtrl_clock; // @[Top.scala 66:23]
  wire  dmemCtrl_reset; // @[Top.scala 66:23]
  wire  dmemCtrl_io_req_ready; // @[Top.scala 66:23]
  wire  dmemCtrl_io_req_valid; // @[Top.scala 66:23]
  wire [31:0] dmemCtrl_io_req_bits_addrRequest; // @[Top.scala 66:23]
  wire [255:0] dmemCtrl_io_req_bits_dataRequest; // @[Top.scala 66:23]
  wire [31:0] dmemCtrl_io_req_bits_activeByteLane; // @[Top.scala 66:23]
  wire  dmemCtrl_io_req_bits_isWrite; // @[Top.scala 66:23]
  wire  dmemCtrl_io_rsp_valid; // @[Top.scala 66:23]
  wire [255:0] dmemCtrl_io_rsp_bits_dataResponse; // @[Top.scala 66:23]
  Core core ( // @[Top.scala 60:25]
    .clock(core_clock),
    .reset(core_reset),
    .io_pin(core_io_pin),
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
    .io_imemRsp_bits_dataResponse(core_io_imemRsp_bits_dataResponse),
    .io_rvfi_valid(core_io_rvfi_valid),
    .io_rvfi_order(core_io_rvfi_order),
    .io_rvfi_insn(core_io_rvfi_insn),
    .io_rvfi_rs1_addr(core_io_rvfi_rs1_addr),
    .io_rvfi_rs1_rdata(core_io_rvfi_rs1_rdata),
    .io_rvfi_rs2_addr(core_io_rvfi_rs2_addr),
    .io_rvfi_rs2_rdata(core_io_rvfi_rs2_rdata),
    .io_rvfi_rd_addr(core_io_rvfi_rd_addr),
    .io_rvfi_rd_wdata(core_io_rvfi_rd_wdata),
    .io_rvfi_pc_rdata(core_io_rvfi_pc_rdata),
    .io_rvfi_pc_wdata(core_io_rvfi_pc_wdata)
  );
  TilelinkAdapter imemAdapter ( // @[Top.scala 61:26]
    .clock(imemAdapter_clock),
    .reset(imemAdapter_reset),
    .io_reqIn_ready(imemAdapter_io_reqIn_ready),
    .io_reqIn_valid(imemAdapter_io_reqIn_valid),
    .io_reqIn_bits_addrRequest(imemAdapter_io_reqIn_bits_addrRequest),
    .io_reqIn_bits_dataRequest(imemAdapter_io_reqIn_bits_dataRequest),
    .io_reqIn_bits_isWrite(imemAdapter_io_reqIn_bits_isWrite),
    .io_rspOut_valid(imemAdapter_io_rspOut_valid),
    .io_rspOut_bits_dataResponse(imemAdapter_io_rspOut_bits_dataResponse),
    .io_reqOut_valid(imemAdapter_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(imemAdapter_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(imemAdapter_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(imemAdapter_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(imemAdapter_io_reqOut_bits_isWrite),
    .io_rspIn_valid(imemAdapter_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(imemAdapter_io_rspIn_bits_dataResponse)
  );
  TilelinkAdapter dmemAdapter ( // @[Top.scala 62:26]
    .clock(dmemAdapter_clock),
    .reset(dmemAdapter_reset),
    .io_reqIn_ready(dmemAdapter_io_reqIn_ready),
    .io_reqIn_valid(dmemAdapter_io_reqIn_valid),
    .io_reqIn_bits_addrRequest(dmemAdapter_io_reqIn_bits_addrRequest),
    .io_reqIn_bits_dataRequest(dmemAdapter_io_reqIn_bits_dataRequest),
    .io_reqIn_bits_isWrite(dmemAdapter_io_reqIn_bits_isWrite),
    .io_rspOut_valid(dmemAdapter_io_rspOut_valid),
    .io_rspOut_bits_dataResponse(dmemAdapter_io_rspOut_bits_dataResponse),
    .io_reqOut_valid(dmemAdapter_io_reqOut_valid),
    .io_reqOut_bits_addrRequest(dmemAdapter_io_reqOut_bits_addrRequest),
    .io_reqOut_bits_dataRequest(dmemAdapter_io_reqOut_bits_dataRequest),
    .io_reqOut_bits_activeByteLane(dmemAdapter_io_reqOut_bits_activeByteLane),
    .io_reqOut_bits_isWrite(dmemAdapter_io_reqOut_bits_isWrite),
    .io_rspIn_valid(dmemAdapter_io_rspIn_valid),
    .io_rspIn_bits_dataResponse(dmemAdapter_io_rspIn_bits_dataResponse)
  );
  BlockRamWithoutMasking imemCtrl ( // @[Top.scala 65:23]
    .clock(imemCtrl_clock),
    .reset(imemCtrl_reset),
    .io_req_ready(imemCtrl_io_req_ready),
    .io_req_valid(imemCtrl_io_req_valid),
    .io_req_bits_addrRequest(imemCtrl_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(imemCtrl_io_req_bits_dataRequest),
    .io_req_bits_isWrite(imemCtrl_io_req_bits_isWrite),
    .io_rsp_valid(imemCtrl_io_rsp_valid),
    .io_rsp_bits_dataResponse(imemCtrl_io_rsp_bits_dataResponse)
  );
  BlockRamWithMasking dmemCtrl ( // @[Top.scala 66:23]
    .clock(dmemCtrl_clock),
    .reset(dmemCtrl_reset),
    .io_req_ready(dmemCtrl_io_req_ready),
    .io_req_valid(dmemCtrl_io_req_valid),
    .io_req_bits_addrRequest(dmemCtrl_io_req_bits_addrRequest),
    .io_req_bits_dataRequest(dmemCtrl_io_req_bits_dataRequest),
    .io_req_bits_activeByteLane(dmemCtrl_io_req_bits_activeByteLane),
    .io_req_bits_isWrite(dmemCtrl_io_req_bits_isWrite),
    .io_rsp_valid(dmemCtrl_io_rsp_valid),
    .io_rsp_bits_dataResponse(dmemCtrl_io_rsp_bits_dataResponse)
  );
  assign io_pin = core_io_pin; // @[Top.scala 81:9]
  assign io_rvfi_valid = core_io_rvfi_valid; // @[Top.scala 80:10]
  assign io_rvfi_order = core_io_rvfi_order; // @[Top.scala 80:10]
  assign io_rvfi_insn = core_io_rvfi_insn; // @[Top.scala 80:10]
  assign io_rvfi_trap = 1'h0; // @[Top.scala 80:10]
  assign io_rvfi_halt = 1'h0; // @[Top.scala 80:10]
  assign io_rvfi_intr = 1'h0; // @[Top.scala 80:10]
  assign io_rvfi_ixl = 2'h1; // @[Top.scala 80:10]
  assign io_rvfi_mode = 2'h3; // @[Top.scala 80:10]
  assign io_rvfi_rs1_addr = core_io_rvfi_rs1_addr; // @[Top.scala 80:10]
  assign io_rvfi_rs1_rdata = core_io_rvfi_rs1_rdata; // @[Top.scala 80:10]
  assign io_rvfi_rs2_addr = core_io_rvfi_rs2_addr; // @[Top.scala 80:10]
  assign io_rvfi_rs2_rdata = core_io_rvfi_rs2_rdata; // @[Top.scala 80:10]
  assign io_rvfi_rd_addr = core_io_rvfi_rd_addr; // @[Top.scala 80:10]
  assign io_rvfi_rd_wdata = core_io_rvfi_rd_wdata; // @[Top.scala 80:10]
  assign io_rvfi_pc_rdata = core_io_rvfi_pc_rdata; // @[Top.scala 80:10]
  assign io_rvfi_pc_wdata = core_io_rvfi_pc_wdata; // @[Top.scala 80:10]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_dmemRsp_valid = dmemAdapter_io_rspOut_valid; // @[Top.scala 76:18]
  assign core_io_dmemRsp_bits_dataResponse = dmemAdapter_io_rspOut_bits_dataResponse; // @[Top.scala 76:18]
  assign core_io_imemReq_ready = imemAdapter_io_reqIn_ready; // @[Top.scala 69:23]
  assign core_io_imemRsp_valid = imemAdapter_io_rspOut_valid; // @[Top.scala 70:18]
  assign core_io_imemRsp_bits_dataResponse = imemAdapter_io_rspOut_bits_dataResponse; // @[Top.scala 70:18]
  assign imemAdapter_clock = clock;
  assign imemAdapter_reset = reset;
  assign imemAdapter_io_reqIn_valid = core_io_imemReq_valid; // @[Top.scala 69:23]
  assign imemAdapter_io_reqIn_bits_addrRequest = core_io_imemReq_bits_addrRequest; // @[Top.scala 69:23]
  assign imemAdapter_io_reqIn_bits_dataRequest = 256'h0; // @[Top.scala 69:23]
  assign imemAdapter_io_reqIn_bits_isWrite = 1'h0; // @[Top.scala 69:23]
  assign imemAdapter_io_rspIn_valid = imemCtrl_io_rsp_valid; // @[Top.scala 72:23]
  assign imemAdapter_io_rspIn_bits_dataResponse = imemCtrl_io_rsp_bits_dataResponse; // @[Top.scala 72:23]
  assign dmemAdapter_clock = clock;
  assign dmemAdapter_reset = reset;
  assign dmemAdapter_io_reqIn_valid = core_io_dmemReq_valid; // @[Top.scala 75:23]
  assign dmemAdapter_io_reqIn_bits_addrRequest = core_io_dmemReq_bits_addrRequest; // @[Top.scala 75:23]
  assign dmemAdapter_io_reqIn_bits_dataRequest = core_io_dmemReq_bits_dataRequest; // @[Top.scala 75:23]
  assign dmemAdapter_io_reqIn_bits_isWrite = core_io_dmemReq_bits_isWrite; // @[Top.scala 75:23]
  assign dmemAdapter_io_rspIn_valid = dmemCtrl_io_rsp_valid; // @[Top.scala 78:23]
  assign dmemAdapter_io_rspIn_bits_dataResponse = dmemCtrl_io_rsp_bits_dataResponse; // @[Top.scala 78:23]
  assign imemCtrl_clock = clock;
  assign imemCtrl_reset = reset;
  assign imemCtrl_io_req_valid = imemAdapter_io_reqOut_valid; // @[Top.scala 71:18]
  assign imemCtrl_io_req_bits_addrRequest = imemAdapter_io_reqOut_bits_addrRequest; // @[Top.scala 71:18]
  assign imemCtrl_io_req_bits_dataRequest = imemAdapter_io_reqOut_bits_dataRequest; // @[Top.scala 71:18]
  assign imemCtrl_io_req_bits_isWrite = imemAdapter_io_reqOut_bits_isWrite; // @[Top.scala 71:18]
  assign dmemCtrl_clock = clock;
  assign dmemCtrl_reset = reset;
  assign dmemCtrl_io_req_valid = dmemAdapter_io_reqOut_valid; // @[Top.scala 77:18]
  assign dmemCtrl_io_req_bits_addrRequest = dmemAdapter_io_reqOut_bits_addrRequest; // @[Top.scala 77:18]
  assign dmemCtrl_io_req_bits_dataRequest = dmemAdapter_io_reqOut_bits_dataRequest; // @[Top.scala 77:18]
  assign dmemCtrl_io_req_bits_activeByteLane = dmemAdapter_io_reqOut_bits_activeByteLane; // @[Top.scala 77:18]
  assign dmemCtrl_io_req_bits_isWrite = dmemAdapter_io_reqOut_bits_isWrite; // @[Top.scala 77:18]
endmodule
