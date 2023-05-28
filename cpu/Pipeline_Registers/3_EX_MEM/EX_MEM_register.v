// Advanced Computer Architecture (CO502)
// Design: EX_MEM Pipeline Register
// Group Number: 4
// E Numbers: E/18/077, E/18/397, E/18/402
// Names: Nipun Dharmarathne, Shamod Wijerathne, Chatura Wimalasiri

`timescale  1ns/100ps

module EX_MEM_register(
	CLK,
	RESET,
	WRITE_ENABLE_IN,
	MUXDATAMEM_SELECT_IN,
	MEM_READ_IN,
	MEM_WRITE_IN,
	ALU_OUT_IN,
	OUT2_IN,
	RD_IN,
	FUNCT3_IN,
	WRITE_ENABLE_OUT,
	MUXDATAMEM_SELECT_OUT,
	MEM_READ_OUT,
	MEM_WRITE_OUT,
	ALU_OUT_OUT,
	OUT2_OUT,
	RD_OUT,
	FUNCT3_OUT,
	BUSYWAIT
);
	//port declarations
	
	input CLK, RESET, WRITE_ENABLE_IN, MUXDATAMEM_SELECT_IN, MEM_READ_IN, MEM_WRITE_IN, BUSYWAIT;
	input [2:0] FUNCT3_IN;
	input [4:0] RD_IN;
	input [31:0] ALU_OUT_IN, OUT2_IN;
	
	output reg WRITE_ENABLE_OUT, MUXDATAMEM_SELECT_OUT, MEM_READ_OUT, MEM_WRITE_OUT;
	output reg [2:0] FUNCT3_OUT;
	output reg [4:0] RD_OUT;
	output reg [31:0] ALU_OUT_OUT, OUT2_OUT;
	
	
	
	// reset the registers
    always @ (*) begin
        if (RESET) begin
            #1;
            WRITE_ENABLE_OUT = 1'd0;
			MUXDATAMEM_SELECT_OUT = 1'd0;
			MEM_READ_OUT = 1'd0;
			MEM_WRITE_OUT = 1'd0;
			FUNCT3_OUT = 3'd0;
			RD_OUT = 5'd0;
			ALU_OUT_OUT = 32'd0;
			OUT2_OUT = 32'd0;
        end
    end
	
	// input data tranmits to outputs at the positive edge of the clock
	// Assignments to outputs happen simultaneously
		always @ (*) begin
        if (BUSYWAIT == 1'b0 ) begin
			#2
            WRITE_ENABLE_OUT <= WRITE_ENABLE_IN;
			MUXDATAMEM_SELECT_OUT <= MUXDATAMEM_SELECT_IN;
			MEM_READ_OUT <= MEM_READ_IN;
			MEM_WRITE_OUT <= MEM_WRITE_IN;
			FUNCT3_OUT <= FUNCT3_IN;
			RD_OUT <= RD_IN;
			ALU_OUT_OUT <= ALU_OUT_IN;
			OUT2_OUT <= OUT2_IN;
        end
    end

endmodule