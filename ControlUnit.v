`timescale 1ns / 1ps

module control_unit(
  input[3:0] opcode,
  input flag,
  
  output reg RegWr,
  output reg MemWr,
  output reg MemRd,
  output reg Flagset,
  output reg Push,
  output reg Pop,
  output reg[2:0] ALU_Ctrl,
  output reg[1:0] PC_Ctrl,
  output reg[1:0] WBSel
);
  
  always @(*)
    begin
      
      RegWr=1'b0;
      MemWr=1'b0;
      MemRd=1'b0;
      Flagset=1'b0;
      Push=1'b0;
      Pop=1'b0;
      ALU_Ctrl=3'b000;
      PC_Ctrl=2'b00;
      WBSel=2'b00;
      
      
      case(opcode)
        
        4'b0001:
          PC_Ctrl=2'b11;
        
        4'b0010:
          begin
            ALU_Ctrl=3'b000;
            Flagset=1'b1;
            RegWr=1'b1;
            WBSel=2'b00;
          end
        
        4'b0011:
          begin
            ALU_Ctrl=3'b001;
            Flagset=1'b1;
            RegWr=1'b1;
            WBSel=2'b00;
          end
        
        4'b0100:
          begin
            Pop=1'b1;
            PC_Ctrl=2'b10;
          end
        
        4'b0101:
          begin
            ALU_Ctrl=3'b010;
            Flagset=1'b1;
            RegWr=1'b1;
            WBSel=2'b00;
          end
        
        4'b0110:
          begin
            ALU_Ctrl=3'b011;
            Flagset=1'b1;
            RegWr=1'b1;
            WBSel=2'b00;
          end
        
        4'b1000:
          begin
            ALU_Ctrl=3'b100;
            Flagset=1'b1;
            RegWr=1'b1;
            WBSel=2'b00;
          end
        
        4'b1001:
          begin
            ALU_Ctrl=3'b101;
            Flagset=1'b1;
            RegWr=1'b1;
            WBSel=2'b00;
          end
        
         
        4'b1010:
          begin
            ALU_Ctrl=3'b110;
            Flagset=1'b1;
            RegWr=1'b1;
            WBSel=2'b00;
          end
        
        4'b1011:
          begin
            RegWr=1'b1;
            WBSel=2'b01;
          end
        
        4'b1100:
          begin
            MemRd=1'b1;
            RegWr=1'b1;
            WBSel=2'b10;
          end
        
        4'b1101:
          MemWr=1'b1;
        
        4'b1110:
          begin
            PC_Ctrl=2'b01;
            Push=1'b1;
          end
        
        4'b1111:
          begin
            if(flag)
              begin
                PC_Ctrl=2'b01;
                Push=1'b1;
              end
            
            else
              PC_Ctrl=2'b00;
          end
        
      endcase
    end
endmodule
