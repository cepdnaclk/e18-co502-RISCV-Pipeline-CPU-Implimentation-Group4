`include "Jump_Controller.v"

`timescale 1ns/100ps
module Jump_Controller_tb;

    // Inputs
    reg [31:0] BRANCH_ADDR;
    reg [31:0] JUMP_I;
    reg [2:0] FUNC3;
    reg BRANCH;
    reg JUMP;
    reg EQ_FLAG;
    reg LT_FLAG;
    reg LTU_FLAG;

    // Outputs
    wire [31:0] BRANCH_OR_JUMP_ADDR;
    wire PC_MUX_CONTROL;
    wire REG_FLUSH;

    // Instantiate the module
    Jump_Controller dut (
        .BRANCH_ADDR(BRANCH_ADDR),
        .JUMP_I(JUMP_I),
        .FUNC3(FUNC3),
        .BRANCH(BRANCH),
        .JUMP(JUMP),
        .EQ_FLAG(EQ_FLAG),
        .LT_FLAG(LT_FLAG),
        .LTU_FLAG(LTU_FLAG),
        .BRANCH_OR_JUMP_ADDR(BRANCH_OR_JUMP_ADDR),
        .PC_MUX_CONTROL(PC_MUX_CONTROL),
        .REG_FLUSH(REG_FLUSH)
    );

    // Test LT_FLAGals
    initial begin
        // Test 1 -Jump
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'bXXX;
        #10 BRANCH = 1'b0;
        #10 JUMP = 1'b1;
        #10 EQ_FLAG = 1'bx;
        #10 LT_FLAG = 1'bx;
        #10 LTU_FLAG = 1'bx;
        #10 $display("Test  1 ( JUMP ): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);


        // Test 2 - BEQ TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b000;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'b1;
        #10 LT_FLAG = 1'bx;
        #10 LTU_FLAG = 1'bx;
        #10 $display("Test  2 (BEQ -T): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);
       
        // Test 3 - BEQ NOT TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b000;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'b0;
        #10 LT_FLAG = 1'bx;
        #10 LTU_FLAG = 1'bx;
        #10 $display("Test  3 (BEQ -F): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

        // Test 4 - BNE TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b001;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'b0;
        #10 LT_FLAG = 1'bx;
        #10 LTU_FLAG = 1'bx;
        #10 $display("Test  4 (BNE -T): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

        // Test 5 - BNE NOT TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b001;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'b1;
        #10 LT_FLAG = 1'bx;
        #10 LTU_FLAG = 1'bx;
        #10 $display("Test  5 (BNE -F): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

         // Test 6 - BLT TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b100;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'b0;
        #10 LT_FLAG = 1'b1;
        #10 LTU_FLAG = 1'bx;
        #10 $display("Test  6 (BLT -T): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

        // Test 7 - BLT NOT TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b100;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'b1;
        #10 LT_FLAG = 1'b1;
        #10 LTU_FLAG = 1'bx;
        #10 $display("Test  7 (BLT -F): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

          // Test 8 - BLT NOT TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b100;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'b1;
        #10 LT_FLAG = 1'b0;
        #10 LTU_FLAG = 1'bx;
        #10 $display("Test  8 (BLT -F): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

         // Test 9 - BGE TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b101;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'bX;
        #10 LT_FLAG = 1'b0;
        #10 LTU_FLAG = 1'bx;
        #10 $display("Test  9 (BGE -T): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

        // Test 10 - BGE NOT TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b101;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'bX;
        #10 LT_FLAG = 1'b1;
        #10 LTU_FLAG = 1'bx;
        #10 $display("Test 10 (BGE -F): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

         // Test 11 - BLTU TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b110;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'b0;
        #10 LT_FLAG = 1'bx;
        #10 LTU_FLAG = 1'b1;
        #10 $display("Test 11 (BLTU-T): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

        // Test 12 - BLTU NOT TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b110;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'b0;
        #10 LT_FLAG = 1'bx;
        #10 LTU_FLAG = 1'b0;
        #10 $display("Test 12 (BLTU-F): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

        // Test 13 - BLTU NOT TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b110;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'b1;
        #10 LT_FLAG = 1'bx;
        #10 LTU_FLAG = 1'b1;
        #10 $display("Test 13 (BLTU-F): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

         // Test 14 - BGEU TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b111;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'b0;
        #10 LT_FLAG = 1'bx;
        #10 LTU_FLAG = 1'b0;
        #10 $display("Test 14 (BGEU-T): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

        // Test 15 - BGEU NOT TAKEN
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'b111;
        #10 BRANCH = 1'b1;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'b0;
        #10 LT_FLAG = 1'bx;
        #10 LTU_FLAG = 1'b1;
        #10 $display("Test 15 (BGEU-F): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

       // Test 16 - Other type instructions (Not branch or jump)
        #10 BRANCH_ADDR = 32'h1000;
        #10 JUMP_I = 32'h2000;
        #10 FUNC3 = 3'bxxx;
        #10 BRANCH = 1'b0;
        #10 JUMP = 1'b0;
        #10 EQ_FLAG = 1'bx;
        #10 LT_FLAG = 1'bx;
        #10 LTU_FLAG = 1'bx;
        #10 $display("Test 16 (OTHERS): BRANCH_ADDR = %h, JUMP_I = %H, BRANCH = %b, JUMP = %b, EQ_FLAG = %b, LT_FLAG = %b, LTU_FLAG = %b, BRANCH_OR_JUMP_ADDR = %h, PC_MUX_CONTROL = %b, REG_FLUSH = %b", BRANCH_ADDR, JUMP_I, BRANCH, JUMP, EQ_FLAG, LT_FLAG, LTU_FLAG, BRANCH_OR_JUMP_ADDR, PC_MUX_CONTROL, REG_FLUSH);

    end

endmodule
