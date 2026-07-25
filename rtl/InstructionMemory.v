`timescale 1ns / 1ps

module instruction_memory(
  input[7:0] InstrAddr,
  output[15:0] Instruction
);
  reg[15:0] ROM[255:0];
  
  initial
    begin
       // Fibonacci Code for 1st 15 Numbers( But this cpu can print only 1st 14 numbers, as the 15th number exceeds the value of 255.

        ROM[0]  = 16'Hb80e;
        ROM[1]  = 16'h8410;
        ROM[2]  = 16'h8e38;
        ROM[3]  = 16'hD010;
        ROM[4]  = 16'h2611;
        ROM[5]  = 16'h8e38;
        ROM[6]  = 16'hD018;
        ROM[7]  = 16'h2210;
        ROM[8]  = 16'h2418;
        ROM[9]  = 16'h9820;
        ROM[10] = 16'hf00c;
        ROM[11] = 16'he004;
        ROM[12] = 16'h1000;
    end
  
  assign Instruction=ROM[InstrAddr];
  
endmodule
