// This encoding is for U_TYPE, J_TYPE, I_TYPE, S_TYPE, B_TYPE instructions


module Sign_Zero_Extend(INSTRUCTION, U_TYPE, J_TYPE, I_TYPE, S_TYPE, B_TYPE);

	//port declaration
	input [31:0] INSTRUCTION;
	output [31:0] U_TYPE, J_TYPE, I_TYPE, S_TYPE, B_TYPE;
	
	// U_TYPE Encoding
	assign U_TYPE = {INSTRUCTION[31:12],{12{1'b0}}};
	
	// J_TYPE Encoding
	assign J_TYPE = {{12{INSTRUCTION[31]}},INSTRUCTION[19:12],INSTRUCTION[20],INSTRUCTION[30:21],1'b0};
	
	// I_TYPE Encoding
	assign I_TYPE = {{21{INSTRUCTION[31]}},INSTRUCTION[30:20]};
	
	// S_TYPE Encoding
	assign S_TYPE = {{21{INSTRUCTION[31]}},INSTRUCTION[30:25],INSTRUCTION[11:7]};
	
	// B_TYPE Encoding
	assign B_TYPE = {{20{INSTRUCTION[31]}},INSTRUCTION[7],INSTRUCTION[30:25],INSTRUCTION[11:5],1'b0};
	

endmodule