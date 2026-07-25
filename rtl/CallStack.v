`timescale 1ns / 1ps

module Call_Stack(
  input[7:0] RetAddr,
  input Pop,
  input Push,
  input clk,
  input reset,
  
  output reg[7:0] PopOutAddr
);
  
  reg[7:0] Stack[15:0];
  reg[3:0] SP;
  
  integer i;
  
  always @(posedge clk)
    begin
  
  if(reset)
    begin
      
      SP<= 4'd0;
      PopOutAddr<=8'd0;
      
      for(i=0;i<16;i=i+1)
        begin
        Stack[i]<= 8'd0;
        end
    end
  
      else if(Push && SP<4'd15)
    begin
      
      Stack[SP]<=RetAddr;
      SP<=SP+1;
    end
  
      else if(Pop && SP>4'd0)
    begin
      SP<=SP-1;
      PopOutAddr<=Stack[SP-1];
    end
    end
endmodule
