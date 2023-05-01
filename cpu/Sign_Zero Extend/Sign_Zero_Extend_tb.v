`include "Sign_Zero_Extend.v"

module Sign_Zero_Extend_tb;

    // Instantiate the module under test
    Sign_Zero_Extend sign_zero_extend(INSTRUCTION, U_TYPE, J_TYPE, I_TYPE, S_TYPE, B_TYPE);

    // Declare the input and output signals
    reg [31:0] INSTRUCTION;
    wire [31:0] U_TYPE, J_TYPE, I_TYPE, S_TYPE, B_TYPE;

    // Stimulus generation
    initial begin
        // Set initial value
		$dumpfile("sign_zero_extend.vcd");
		$dumpvars(0, Sign_Zero_Extend_tb);
        INSTRUCTION = 32'b10101110010101110101010101111010;

        // Wait a few time units for the output to stabilize
        #10;

        // Print the input and output values
        $display("INSTRUCTION = %b\n", INSTRUCTION);
        $display("The U_TYPE  = %b", U_TYPE);
		$display("The J_TYPE  = %b", J_TYPE);
		$display("The I_TYPE  = %b", I_TYPE);
		$display("The S_TYPE  = %b", S_TYPE);
		$display("The B_TYPE  = %b\n\n", B_TYPE);
		
		
		// Set another value
		INSTRUCTION = 32'b01010100100101000110111110111011;
		
		// Wait a few time units for the output to stabilize
        #10;
		
		// Print the input and output values
        $display("INSTRUCTION = %b\n", INSTRUCTION);
        $display("The U_TYPE  = %b", U_TYPE);
		$display("The J_TYPE  = %b", J_TYPE);
		$display("The I_TYPE  = %b", I_TYPE);
		$display("The S_TYPE  = %b", S_TYPE);
		$display("The B_TYPE  = %b\n\n", B_TYPE);
		
		// Set another value
		INSTRUCTION = 32'b01111011111011010101010100010011;
		
		// Wait a few time units for the output to stabilize
        #10;
		
		// Print the input and output values
        $display("INSTRUCTION = %b\n", INSTRUCTION);
        $display("The U_TYPE  = %b", U_TYPE);
		$display("The J_TYPE  = %b", J_TYPE);
		$display("The I_TYPE  = %b", I_TYPE);
		$display("The S_TYPE  = %b", S_TYPE);
		$display("The B_TYPE  = %b", B_TYPE);
		
    end

endmodule

