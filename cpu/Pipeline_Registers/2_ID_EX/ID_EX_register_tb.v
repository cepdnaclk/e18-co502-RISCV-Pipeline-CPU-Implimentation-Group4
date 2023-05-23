`include "ID_EX_register.v"

`define assert(signal, value) \
    if (signal !== value) begin \
        $display("ASSERTION FAILED in %m: sig != %b [original value %b] in line %0d", signal, value, `__LINE__); \
        $finish; \
    end

module ID_EX_register_tb;

	reg CLK, RESET, WRITE_ENABLE_IN, MUXDATAMEM_SELECT_IN, MEM_READ_IN, MEM_WRITE_IN, MUXJAL_SELECT_IN, MUXIMM_SELECT_IN, MUXPC_SELECT_IN, BRANCH_IN, JUMP_IN, BUSYWAIT;
	reg [2:0] FUNCT3_IN;
	reg [4:0] ALUOP_IN, RD_IN;
	reg [31:0] PC_DIRECT_OUT_IN, SIGN_ZERO_EXTEND, PC_PLUS_4_OUT_IN, OUT1_IN, OUT2_IN;
	
	wire WRITE_ENABLE_OUT, MUXDATAMEM_SELECT_OUT, MEM_READ_OUT, MEM_WRITE_OUT, MUXJAL_SELECT_OUT, MUXIMM_SELECT_OUT, MUXPC_SELECT_OUT, BRANCH_OUT, JUMP_OUT;
	wire [2:0] FUNCT3_OUT;
	wire [4:0] ALUOP_OUT, RD_OUT;
	wire [31:0] PC_DIRECT_OUT_OUT, SIGN_ZERO_EXTEND_OUT, PC_PLUS_4_OUT_OUT, OUT1_OUT, OUT2_OUT;
	
	ID_EX_register id_ex_register(
		CLK,
		RESET,
		WRITE_ENABLE_IN,
		MUXDATAMEM_SELECT_IN,
		MEM_READ_IN,
		MEM_WRITE_IN,
		MUXJAL_SELECT_IN,
		ALUOP_IN,
		MUXIMM_SELECT_IN,
		MUXPC_SELECT_IN,
		BRANCH_IN,
		JUMP_IN,
		PC_DIRECT_OUT_IN,
		SIGN_ZERO_EXTEND,
		PC_PLUS_4_OUT_IN,
		OUT1_IN,
		OUT2_IN,
		RD_IN,
		FUNCT3_IN,
		WRITE_ENABLE_OUT,
		MUXDATAMEM_SELECT_OUT,
		MEM_READ_OUT,
		MEM_WRITE_OUT,
		MUXJAL_SELECT_OUT,
		ALUOP_OUT,
		MUXIMM_SELECT_OUT,
		MUXPC_SELECT_OUT,
		BRANCH_OUT,
		JUMP_OUT,
		PC_DIRECT_OUT_OUT,
		SIGN_ZERO_EXTEND_OUT,
		PC_PLUS_4_OUT_OUT,
		OUT1_OUT,
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
		MUXJAL_SELECT_IN = 1'd1;
		ALUOP_IN = 5'd15;
		MUXIMM_SELECT_IN = 1'd1;
		MUXPC_SELECT_IN = 1'd1;
		BRANCH_IN = 1'd1;
		JUMP_IN = 1'd1;
		PC_DIRECT_OUT_IN = 32'd120;
		SIGN_ZERO_EXTEND = 32'd345;
		PC_PLUS_4_OUT_IN = 32'd124;
		OUT1_IN = 32'd550;
		OUT2_IN = 32'd890;
		RD_IN = 5'd20;
		FUNCT3_IN = 3'd6;
		
		$dumpfile("ID_EX_register_tb.vcd");
		$dumpvars(0, ID_EX_register_tb);
		
		// test 1
		#1
		RESET = 1'b1;

		#4
		RESET = 1'b0;
		
		`assert(WRITE_ENABLE_OUT,1'dx);
		`assert(MUXDATAMEM_SELECT_OUT,1'dx);
		`assert(MEM_READ_OUT,1'dx);
		`assert(MEM_WRITE_OUT,1'dx);
		`assert(MUXJAL_SELECT_OUT,1'dx);
		`assert(MUXIMM_SELECT_OUT,1'dx);
		`assert(MUXPC_SELECT_OUT,1'dx);
		`assert(BRANCH_OUT,1'dx);
		`assert(JUMP_OUT,1'dx);
		
		`assert(FUNCT3_OUT,3'dx);
		
		`assert(ALUOP_OUT,5'dx);
		`assert(RD_OUT,5'dx);
		
		`assert(PC_DIRECT_OUT_OUT,32'dx);
		`assert(SIGN_ZERO_EXTEND_OUT,32'dx);
		`assert(PC_PLUS_4_OUT_OUT,32'dx);
		`assert(OUT1_OUT,32'dx);
		`assert(OUT2_OUT,32'dx);
		
		$display("Test 01 : Passed!");
		
		// test 2
		WRITE_ENABLE_IN = 1'd1;
		MUXDATAMEM_SELECT_IN = 1'd1;
		MEM_READ_IN = 1'd1;
		MEM_WRITE_IN = 1'd1;
		MUXJAL_SELECT_IN = 1'd1;
		ALUOP_IN = 5'd15;
		MUXIMM_SELECT_IN = 1'd1;
		MUXPC_SELECT_IN = 1'd1;
		BRANCH_IN = 1'd1;
		JUMP_IN = 1'd1;
		PC_DIRECT_OUT_IN = 32'd120;
		SIGN_ZERO_EXTEND = 32'd345;
		PC_PLUS_4_OUT_IN = 32'd124;
		OUT1_IN = 32'd550;
		OUT2_IN = 32'd890;
		RD_IN = 5'd20;
		FUNCT3_IN = 3'd6;
		
		@(posedge CLK) begin
		
			#4 
			
			`assert(WRITE_ENABLE_OUT,1'd1);
			`assert(MUXDATAMEM_SELECT_OUT,1'd1);
			`assert(MEM_READ_OUT,1'd1);
			`assert(MEM_WRITE_OUT,1'd1);
			`assert(MUXJAL_SELECT_OUT,1'd1);
			`assert(MUXIMM_SELECT_OUT,1'd1);
			`assert(MUXPC_SELECT_OUT,1'd1);
			`assert(BRANCH_OUT,1'd1);
			`assert(JUMP_OUT,1'd1);
			
			`assert(FUNCT3_OUT,3'd6);
			
			`assert(ALUOP_OUT,5'd15);
			`assert(RD_OUT,5'd20);
			
			`assert(PC_DIRECT_OUT_OUT,32'd120);
			`assert(SIGN_ZERO_EXTEND_OUT,32'd345);
			`assert(PC_PLUS_4_OUT_OUT,32'd124);
			`assert(OUT1_OUT,32'd550);
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
		MUXJAL_SELECT_IN = 1'd0;
		ALUOP_IN = 5'd5;
		MUXIMM_SELECT_IN = 1'd0;
		MUXPC_SELECT_IN = 1'd0;
		BRANCH_IN = 1'd0;
		JUMP_IN = 1'd0;
		PC_DIRECT_OUT_IN = 32'd20;
		SIGN_ZERO_EXTEND = 32'd45;
		PC_PLUS_4_OUT_IN = 32'd24;
		OUT1_IN = 32'd50;
		OUT2_IN = 32'd90;
		RD_IN = 5'd2;
		FUNCT3_IN = 3'd5;
		
		@(posedge CLK) begin
		
			#4 
			
			`assert(WRITE_ENABLE_OUT,1'd1);
			`assert(MUXDATAMEM_SELECT_OUT,1'd1);
			`assert(MEM_READ_OUT,1'd1);
			`assert(MEM_WRITE_OUT,1'd1);
			`assert(MUXJAL_SELECT_OUT,1'd1);
			`assert(MUXIMM_SELECT_OUT,1'd1);
			`assert(MUXPC_SELECT_OUT,1'd1);
			`assert(BRANCH_OUT,1'd1);
			`assert(JUMP_OUT,1'd1);
			
			`assert(FUNCT3_OUT,3'd6);
			
			`assert(ALUOP_OUT,5'd15);
			`assert(RD_OUT,5'd20);
			
			`assert(PC_DIRECT_OUT_OUT,32'd120);
			`assert(SIGN_ZERO_EXTEND_OUT,32'd345);
			`assert(PC_PLUS_4_OUT_OUT,32'd124);
			`assert(OUT1_OUT,32'd550);
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
	
	