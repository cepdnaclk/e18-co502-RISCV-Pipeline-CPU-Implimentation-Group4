`include "MEM_WB_register.v"

`define assert(signal, value) \
    if (signal !== value) begin \
        $display("ASSERTION FAILED in %m: sig != %b [original value %b] in line %0d", signal, value, `__LINE__); \
        $finish; \
    end

module MEM_WB_register_tb;

	reg CLK, RESET, WRITE_ENABLE_IN, MUXDATAMEM_SELECT_IN, BUSYWAIT;
	reg [4:0] RD_IN;
	reg [31:0] DATA_OUT_IN, ALU_OUT_IN; 
	
	wire WRITE_ENABLE_OUT, MUXDATAMEM_SELECT_OUT;
	wire [4:0] RD_OUT;
	wire [31:0] DATA_OUT_OUT, ALU_OUT_OUT; 
	
	MEM_WB_register mem_wb_register(
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
	
	initial begin
	
		CLK = 1'b0;
		RESET = 1'b0;
		BUSYWAIT = 1'b0;
		
		// initial values
		WRITE_ENABLE_IN = 1'd1;
		MUXDATAMEM_SELECT_IN = 1'd1;
		DATA_OUT_IN = 32'd456;
		ALU_OUT_IN = 32'd159;
		RD_IN = 5'd20;
		
		$dumpfile("MEM_WB_register_tb.vcd");
		$dumpvars(0, MEM_WB_register_tb);
		
		#1 
		RESET = 1'b1;
		
		#4
		RESET = 1'b0;
		
		// test 01
		
		`assert(WRITE_ENABLE_OUT,1'dx);
		`assert(MUXDATAMEM_SELECT_OUT,1'dx);
		`assert(DATA_OUT_OUT,32'dx);
		`assert(ALU_OUT_OUT,32'dx);
		`assert(RD_OUT,5'dx);
			
		$display("Test 01 : Passed!");
		
		
		// test 02
		
		WRITE_ENABLE_IN = 1'd1;
		MUXDATAMEM_SELECT_IN = 1'd1;
		DATA_OUT_IN = 32'd456;
		ALU_OUT_IN = 32'd159;
		RD_IN = 5'd20;
		
		@(posedge CLK) begin
		
			#4 
			
			`assert(WRITE_ENABLE_OUT,1'd1);
			`assert(MUXDATAMEM_SELECT_OUT,1'd1);
			`assert(DATA_OUT_OUT,32'd456);
			`assert(ALU_OUT_OUT,32'd159);
			`assert(RD_OUT,5'd20);
			
			$display("Test 02 : Passed!");
		end
		
		// test 03
		
		#1
		BUSYWAIT = 1'd1;
		
		WRITE_ENABLE_IN = 1'd0;
		MUXDATAMEM_SELECT_IN = 1'd0;
		DATA_OUT_IN = 32'd406;
		ALU_OUT_IN = 32'd15;
		RD_IN = 5'd24;
		
		@(posedge CLK) begin
		
			#4 
			
			`assert(WRITE_ENABLE_OUT,1'd1);
			`assert(MUXDATAMEM_SELECT_OUT,1'd1);
			`assert(DATA_OUT_OUT,32'd456);
			`assert(ALU_OUT_OUT,32'd159);
			`assert(RD_OUT,5'd20);
			
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