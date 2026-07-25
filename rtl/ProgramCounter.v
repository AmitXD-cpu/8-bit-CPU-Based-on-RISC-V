`timescale 1ns / 1ps

module program_counter(
  input clk,
  input reset,
  input [1:0] PC_ctrl,
  input [7:0] PopOutAddr,
  input [7:0] JumpBranchAddr,
  output [7:0] RetAddr,
  output [7:0] InstrAddr
);
  reg[7:0] PC;
  assign InstrAddr = PC;
  assign RetAddr = PC+1;
  always @(posedge clk)
    begin
      
      if(reset)
        PC <= 8'd0;
      
      else
       
        case(PC_ctrl)
          2'b00:
            PC <= PC+1;
          2'b01: 
            PC <= JumpBranchAddr;
          2'b10:
            PC <= PopOutAddr;
          2'b11:
            PC <= PC;
        endcase
    end
endmodule
