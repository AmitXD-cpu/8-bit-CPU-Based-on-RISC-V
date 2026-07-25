`timescale 1ns / 1ps

module 	CPU(
  input clk,
  input reset
);
  //Program Counter
  wire[7:0] InstrAddr,RetAddr,PopOutAddr;
  
  //Instruction Memory
  wire[15:0] Instruction;
  
  //Decoding the Instruction
  wire[3:0] opcode;
  wire[2:0] RD_Addr,RA_Addr,RB_Addr;
  wire[7:0] ImmediateData,JumpBranchAddr;
  
  assign opcode= Instruction[15:12];
  assign RD_Addr= Instruction[11:9];
  assign RA_Addr= Instruction[5:3];
  assign RB_Addr= Instruction[2:0];
  assign ImmediateData= Instruction[7:0];
  assign JumpBranchAddr= Instruction[7:0];
  
  //Register File
  wire[7:0]A,B,MemAddr;
  
  //ALU
  wire[7:0] Result;
  wire Z_in,C_in,N_in,O_in;
  
  //Flags
  wire Z,C,N,O,Flag;
  
  //Data Memory
  wire[7:0] ReadData;
  
  //Write Back to Regsiter
  reg[7:0] WriteData;
  
  //Control Signals
  wire RegWr, MemWr, MemRd, FlagSet, Push, Pop;
  wire[2:0] ALU_Ctrl;
  wire[1:0] PC_Ctrl, WBSel;
  
  //Write Back 4x1 MUx
  always @(*)
    begin
      case(WBSel)
        2'b00:
          WriteData=Result;
        2'b01:
          WriteData=ImmediateData;
        2'b10:
          WriteData=ReadData;
        default:
          WriteData=8'b0;
      endcase
    end
  
  //program counter
  program_counter PC(
    .clk(clk),
    .reset(reset),
    .PC_ctrl(PC_Ctrl),
    .PopOutAddr(PopOutAddr),
    .JumpBranchAddr(JumpBranchAddr),
    .RetAddr(RetAddr),
    
    .InstrAddr(InstrAddr)
  );
  
  //Instruction memory
  instruction_memory IM(
    .InstrAddr(InstrAddr),
    
    .Instruction(Instruction)
  );
  
  //Control Unit
  control_unit CU(
    .opcode(opcode),
    .flag(Flag),
    
    .RegWr(RegWr),
    .MemWr(MemWr),
    .MemRd(MemRd),
    .Flagset(FlagSet),
    .Push(Push),
    .Pop(Pop),
    .ALU_Ctrl(ALU_Ctrl),
    .PC_Ctrl(PC_Ctrl),
    .WBSel(WBSel)
  );
  
  //Register file
  register_file RF(
    .clk(clk),
    .reset(reset),
    .RegWr(RegWr),
    .RA_Addr(RA_Addr),
    .RB_Addr(RB_Addr),
    .RD_Addr(RD_Addr),
    
    .WriteData(WriteData),
    .A(A),
    .B(B),
    .MemAddr(MemAddr)
  );
  
  //ALU
  ALU ALU1(
    .A(A),
    .B(B),
    .Aluctrl(ALU_Ctrl),
    
    .Result(Result),
    .Z(Z_in),
    .C(C_in),
    .N(N_in),
    .O(O_in)
  );
  
  //Flag Register
  flags FLAGS(
    .clk(clk),
    .reset(reset),
    .FlagSet(FlagSet),
    .Z_in(Z_in),
    .C_in(C_in),
    .N_in(N_in),
    .O_in(O_in),
    
    .Z(Z),
    .C(C),
    .N(N),
    .O(O),
    .Flag(Flag)
  );
  
  //Data Memory Block
  data_memory DM(
    .clk(clk),
    .clear(reset),
    .MemAddr(MemAddr),
    .WriteData(A),
    .MemWr(MemWr),
    .MemRd(MemRd),
    .ReadData(ReadData)
  );
  
  //Call Stack
  Call_Stack STACK(
    .RetAddr(RetAddr),
    .Pop(Pop),
    .Push(Push),
    .clk(clk),
    .reset(reset),
    .PopOutAddr(PopOutAddr)
  );

endmodule
