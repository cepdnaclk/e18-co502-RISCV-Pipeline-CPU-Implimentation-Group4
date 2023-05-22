// This encoding is for U_TYPE, J_TYPE, I_TYPE, S_TYPE, B_TYPE instructions


module Sign_Zero_Extend(INSTRUCTION, U_TYPE, J_TYPE, I_TYPE, S_TYPE, B_TYPE);

	//port declaration
	input [31:0] INSTRUCTION;
	output reg [31:0] U_TYPE, J_TYPE, S_TYPE, B_TYPE, I_TYPE;
	
	// U_TYPE Encoding
	//assign U_TYPE = {INSTRUCTION[31:12],{12{1'b0}}};
	
	// J_TYPE Encoding
	//assign J_TYPE = {{12{INSTRUCTION[31]}},INSTRUCTION[19:12],INSTRUCTION[20],INSTRUCTION[30:21],1'b0};
	 
	// S_TYPE Encoding
	//assign S_TYPE = {{21{INSTRUCTION[31]}},INSTRUCTION[30:25],INSTRUCTION[11:7]};
	
	// B_TYPE Encoding
	//assign B_TYPE = {{20{INSTRUCTION[31]}},INSTRUCTION[7],INSTRUCTION[30:25],INSTRUCTION[11:8],1'b0};
	
	// I_TYPE Encoding
	
	/*
		There are two types of I type instructions which are I-type Shift Instruction and other instructions 
	*/
	//assign I_TYPE = (INSTRUCTION[7:0] == 8'b0010011 && INSTRUCTION[14:12] == 3'b101 ) ? {27'b0, INSTRUCTION[24:20]} : {{21{INSTRUCTION[31]}}, INSTRUCTION[30:20]};
	
	
	always @(*) begin
		#1
		
		U_TYPE <= {INSTRUCTION[31:12],{12{1'b0}}};
		J_TYPE <= {{12{INSTRUCTION[31]}},INSTRUCTION[19:12],INSTRUCTION[20],INSTRUCTION[30:21],1'b0};
		S_TYPE <= {{21{INSTRUCTION[31]}},INSTRUCTION[30:25],INSTRUCTION[11:7]};
		B_TYPE <= {{20{INSTRUCTION[31]}},INSTRUCTION[7],INSTRUCTION[30:25],INSTRUCTION[11:8],1'b0};
		I_TYPE <= (INSTRUCTION[7:0] == 8'b0010011 && INSTRUCTION[14:12] == 3'b101 ) ? {27'b0, INSTRUCTION[24:20]} : {{21{INSTRUCTION[31]}}, INSTRUCTION[30:20]};
		
	end


endmodule
 