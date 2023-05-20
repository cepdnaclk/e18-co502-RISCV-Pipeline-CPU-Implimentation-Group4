`include "Instruction_Memory.v"

`timescale 1ns/100ps
module instruction_memory_tb;
    
    reg [31:0] PC;
    wire [31:0] INSTRUCTION;

    instruction_memory DUT(
      
        .PC(PC),
        .INSTRUCTION(INSTRUCTION)
    );

    initial begin
        //CLK = 0;
        
        PC = 0;
        #10;
        $display("Instruction at address %0d:  %b", PC, INSTRUCTION);
    
        
        PC = 4;
        #10;
        $display("Instruction at address %0d:  %b", PC, INSTRUCTION);

        PC = 8;
        #10;
        $display("Instruction at address %0d:  %b", PC, INSTRUCTION);

        PC = 12;
        #10;
        $display("Instruction at address %0d: %b", PC, INSTRUCTION);

        $finish;
    end

   // always #5 CLK = ~CLK;

    initial begin
        $dumpfile("instruction_memory_tb.vcd");
        $dumpvars;
    end
endmodule

