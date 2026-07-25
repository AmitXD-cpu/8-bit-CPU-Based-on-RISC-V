`timescale 1ns / 1ps

module flags(
  	
  input clk,
  input reset,
  input FlagSet,
  input Z_in,
  input C_in,
  input N_in,
  input O_in,
  
  output reg Z,
  output reg C,
  output reg N,
  output reg O,
  output Flag
  
);
 
  always @(posedge clk)
    begin
      
      if(reset)
      begin
        Z<= 1'b0;
        C<= 1'b0;
        N<= 1'b0;
        O<= 1'b0;
      end
      
    else if(FlagSet)
      begin
        
      Z<= Z_in;
      C<= C_in;
      N<= N_in;
      O<= O_in;
        
      end
    end
  
  assign Flag=Z;
  
endmodule