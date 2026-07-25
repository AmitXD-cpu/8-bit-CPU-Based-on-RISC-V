`timescale 1ns / 1ps

module ALU(
  
  input[7:0] A,
  input[7:0] B,
  input[2:0] Aluctrl,
  
  output reg[7:0] Result,
  output reg Z,
  output reg C,
  output reg N,
  output reg O
);
  
  reg[8:0] temp;
  
  always @(*)
    begin
      
      Result=8'd0;
      Z=1'd0;
      C=1'd0;
      N=1'd0;
      O=1'd0;
      temp=9'd0;
      
      case(Aluctrl)
        
        3'b000://ADD
          begin
            temp=A+B;
            Result=temp[7:0];
            C=temp[8];
            O=(~(A[7] ^ B[7])) & (A[7] ^ Result[7]);
          end
        
        3'b001://SUB
          begin
            temp=A-B;
            Result=temp[7:0];
            C=temp[8];
            O=(A[7] ^ B[7]) & (A[7] ^ Result[7]);
          end
        
        3'b010://NOR
          begin
            Result= ~(A|B);
          end
        
        3'b011://AND
          begin
            Result=A&B;
          end
        
        3'b100://INC
          begin
            temp=A+1;
            Result=temp[7:0];
            C=temp[8];
          end
        
        3'b101://DEC
          begin
           temp=A-1;
            Result=temp[7:0];
            C=temp[8];
          end
        
        3'b110://RSH
          begin
            Result=A>>1;
          end
        
        default:
          begin
            Result=8'd0;
          end
      endcase
      
      Z=(Result==8'd0);
      N=Result[7];
    end
endmodule
