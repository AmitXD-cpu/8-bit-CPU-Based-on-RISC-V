`timescale 1ns/1ps

module CPU_tb;
  
  reg clk,reset;
  
  CPU DUT(
    .clk(clk),
    .reset(reset)
  );
  
  initial
    begin
      clk=0;
      forever #5 clk=~clk;
    end
  
  initial
    begin
      reset=1'b1;
      #10;
      reset=1'b0;
    end
  
  integer i;
  
  initial
    begin
      #1000;
      $display("---Output of Data Memory Block---");
      
      for(i=0;i<15;i=i+1)
        begin
          $display("RAM[%0d]=%0d",i,DUT.DM.RAM[i]);
        end
      $finish;
    end
endmodule
          
    
    