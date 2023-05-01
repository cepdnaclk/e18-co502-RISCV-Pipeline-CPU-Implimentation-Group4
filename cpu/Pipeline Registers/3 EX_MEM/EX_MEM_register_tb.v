`include "EX_MEM_register.v"

`define assert(signal, value) \
    if (signal !== value) begin \
        $display("ASSERTION FAILED in %m: sig != %b [original value %b] in line %0d", signal, value, `__LINE__); \
        $finish; \
    end
	
module EX_MEM_register_tb;

	reg CLK, RESET, WRITE_ENABLE_IN, MUXDATAMEM_SELECT_IN, MEM_READ_IN, MEM_WRITE_IN, BUSYWAIT;
	reg [2:0] FUNCT3_IN;
	reg [4:0] RD_IN;
	reg [31:0] ALU_OUT_IN, OUT2_IN;
	
	wire WRITE_ENABLE_OUT, MUXDATAMEM_SELECT_OUT, MEM_READ_OUT, MEM_WRITE_OUT;
	wire [2:0] FUNCT3_OUT;
	wire [4:0] RD_OUT;
	wire [31:0] ALU_OUT_OUT, OUT2_OUT;
	
	EX_MEM_register ex_mem_register(
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
	
	initial begin
		
		CLK = 1'b0;
		RESET = 1'b0;
		BUSYWAIT = 1'b0;
		
		// initial values
		WRITE_ENABLE_IN = 1'd1;
		MUXDATAMEM_SELECT_IN = 1'd1;
		MEM_READ_IN = 1'd1;
		MEM_WRITE_IN = 1'd1;
		ALU_OUT_IN = 32'd159;
		OUT2_IN = 32'd890;
		RD_IN = 5'd20;
		FUNCT3_IN = 3'd6; 
		
		$dumpfile("EX_MEM_register_tb.vcd");
		$dumpvars(0, EX_MEM_register_tb);
		
		#1
		RESET = 1'b1;
		
		#4
		RESET = 1'b0;
		
		// Test 01
		
		`assert(WRITE_ENABLE_OUT,1'dx);
		`assert(MUXDATAMEM_SELECT_OUT,1'dx);
		`assert(MEM_READ_OUT,1'dx);
		`assert(MEM_WRITE_OUT,1'dx);
			
		`assert(FUNCT3_OUT,3'dx);
			
		`assert(RD_OUT,5'dx);
			
		`assert(ALU_OUT_OUT,32'dx);
		`assert(OUT2_OUT,32'dx);
		
		$display("Test 01 : Passed!");
		
		// Test 02
		WRITE_ENABLE_IN = 1'd1;
		MUXDATAMEM_SELECT_IN = 1'd1;
		MEM_READ_IN = 1'd1;
		MEM_WRITE_IN = 1'd1;
		ALU_OUT_IN = 32'd159;
		OUT2_IN = 32'd890;
		RD_IN = 5'd20;
		FUNCT3_IN = 3'd6; 
		
		
		@(posedge CLK) begin
		
			#4 
			
			`assert(WRITE_ENABLE_OUT,1'd1);
			`assert(MUXDATAMEM_SELECT_OUT,1'd1);
			`assert(MEM_READ_OUT,1'd1);
			`assert(MEM_WRITE_OUT,1'd1);
			
			`assert(FUNCT3_OUT,3'd6);
			
			`assert(RD_OUT,5'd20);
			
			`assert(ALU_OUT_OUT,32'd159);
			`assert(OUT2_OUT,32'd890);
			
			$display("Test 02 : Passed!");
		end
		
		// test 3
		#1
		BUSYWAIT = 1'd1;
		
		WRITE_ENABLE_IN = 1'd0;
		MUXDATAMEM_SELECT_IN = 1'd0;
		MEM_READ_IN = 1'd0;
		MEM_WRITE_IN = 1'd0;
		ALU_OUT_IN = 32'd19;
		OUT2_IN = 32'd80;
		RD_IN = 5'd2;
		FUNCT3_IN = 3'd7; 
		
		@(posedge CLK) begin
		
			#4 
			
			`assert(WRITE_ENABLE_OUT,1'd1);
			`assert(MUXDATAMEM_SELECT_OUT,1'd1);
			`assert(MEM_READ_OUT,1'd1);
			`assert(MEM_WRITE_OUT,1'd1);
			
			`assert(FUNCT3_OUT,3'd6);
			
			`assert(RD_OUT,5'd20);
			
			`assert(ALU_OUT_OUT,32'd159);
			`assert(OUT2_OUT,32'd890);
			
			$display("Test 03 : Passed!");
		end
		
		#100
		$finish;
	end
		
	//random clock generation
	always begin
        #4 CLK = ~CLK;
    end
	
endmodule