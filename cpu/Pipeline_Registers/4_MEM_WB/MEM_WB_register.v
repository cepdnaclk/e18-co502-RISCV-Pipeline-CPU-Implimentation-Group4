// Advanced Computer Architecture (CO502)
// Design: MEM_WB Pipeline Register
// Group Number: 4
// E Numbers: E/18/077, E/18/397, E/18/402
// Names: Nipun Dharmarathne, Shamod Wijerathne, Chatura Wimalasiri

`timescale  1ns/100ps

module MEM_WB_register(
	CLK,
	RESET,
	WRITE_ENABLE_IN,
	MUXDATAMEM_SELECT_IN,
	DATA_OUT_IN,
	ALU_OUT_IN,
	RD_IN,
	WRITE_ENABLE_OUT,
	MUXDATAMEM_SELECT_OUT,
	DATA_OUT_OUT,
	ALU_OUT_OUT,
	RD_OUT,
	BUSYWAIT
);

	//port declarations
	input CLK, RESET, WRITE_ENABLE_IN, MUXDATAMEM_SELECT_IN, BUSYWAIT;
	input [4:0] RD_IN;
	input [31:0] DATA_OUT_IN, ALU_OUT_IN;
	
	output reg WRITE_ENABLE_OUT, MUXDATAMEM_SELECT_OUT;
	output reg [4:0] RD_OUT;
	output reg [31:0] DATA_OUT_OUT, ALU_OUT_OUT; 
	
	
	// reset the registers
	always @ (*) begin
        if(RESET) begin
			#1
			WRITE_ENABLE_OUT = 1'dx;
			MUXDATAMEM_SELECT_OUT = 1'dx;
			RD_OUT = 5'dx;
			ALU_OUT_OUT = 32'dx;
			DATA_OUT_OUT = 32'dx;
		end
	end
	
	// input data tranmits to outputs at the positive edge of the clock
	// Assignments to outputs happen simultaneously
	always @ (posedge CLK) begin
        if(!BUSYWAIT && !RESET) begin  
		// need to consider busywait to handle cache miss
            #1;
            WRITE_ENABLE_OUT <= WRITE_ENABLE_IN;
			MUXDATAMEM_SELECT_OUT <= MUXDATAMEM_SELECT_IN;
			RD_OUT <= RD_IN;
			ALU_OUT_OUT <= ALU_OUT_IN;
			DATA_OUT_OUT <= DATA_OUT_IN;
        end
    end

endmodule