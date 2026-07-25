`timescale 1ns / 1ps

module register_file(
  input clk,
  input reset,
  input RegWr,
  input[2:0] RA_Addr, RB_Addr, RD_Addr,
  input[7:0] WriteData,
  
  output[7:0] A,
  output[7:0] B,
  output[7:0] MemAddr
);
  reg[7:0] reg_file[7:0];
  
  integer i;
  	
  always @(posedge clk)
  
    begin
      reg_file[0]<=8'd0;
  
      if(reset)
        begin
          for(i=1;i<8;i=i+1)
            reg_file[i]<=8'd0;
        end
      
      else if(RegWr && RD_Addr!=3'd0)
        begin
            reg_file[RD_Addr] <= WriteData;
        end	
    end
  
  assign A=(RA_Addr==3'd0) ? 8'd0:reg_file[RA_Addr];
  assign B=(RB_Addr==3'd0) ? 8'd0:reg_file[RB_Addr];
  assign MemAddr=reg_file[7];
endmodule
