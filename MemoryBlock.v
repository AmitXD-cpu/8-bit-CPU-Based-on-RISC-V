`timescale 1ns / 1ps

module data_memory(
  
  input[7:0] MemAddr,
  input[7:0] WriteData,
  input clear,
  input clk,
  input MemWr,
  input MemRd,
  
  output[7:0] ReadData
);
  
  reg [7:0] RAM[255:0];
  
  integer i;
  
  always @(posedge clk)
    
    begin
        
      if(clear)
        
        begin 
          
        for(i=0;i<256;i=i+1)
          RAM[i]<= 8'd0;
        end
   
      else if(MemWr)
        begin
          
        RAM[MemAddr]<= WriteData;
        
        end
    end
 
  assign ReadData=(MemRd)?RAM[MemAddr]:8'd0;
  

endmodule
