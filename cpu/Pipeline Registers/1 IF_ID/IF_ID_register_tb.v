`include "IF_ID_register.v"

`define assert(signal, value) \
    if (signal !== value) begin \
        $display("ASSERTION FAILED in %m: sig != %b [original value %b] in line %0d", signal, value, `__LINE__); \
        $finish; \
    end


module IF_ID_register_tb;

	reg CLK, RESET, BUSYWAIT;
	reg [31:0] INSTRUCTION_IN, PC_PLUS_4_IN, PC_DIRECT_IN;
	
	wire [31:0] INSTRUCTION_OUT, PC_PLUS_4_OUT, PC_DIRECT_OUT;
	
	IF_ID_register if_id_register(CLK, RESET, INSTRUCTION_IN, PC_PLUS_4_IN, PC_DIRECT_IN, INSTRUCTION_OUT, PC_PLUS_4_OUT, PC_DIRECT_OUT, BUSYWAIT);
	
	initial begin
	
	CLK = 1'b0;
    RESET = 1'b0;
	BUSYWAIT = 1'b0;
	
	// initial values
	INSTRUCTION_IN = 32'd20;
	PC_DIRECT_IN = 32'd52;
	PC_PLUS_4_IN = 32'd56;
	
	$dumpfile("IF_ID_register_tb.vcd");
    $dumpvars(0, IF_ID_register_tb);
	
	// test 1
	#1
	RESET = 1'b1;

    #5
	RESET = 1'b0;
	
	`assert(INSTRUCTION_OUT, 32'dx);
    `assert(PC_PLUS_4_OUT, 32'dx);
	`assert(PC_DIRECT_OUT, 32'dx);

    $display("Test 01 : Passed!");
	
	// test 2
	
	INSTRUCTION_IN = 32'd20;
	PC_DIRECT_IN = 32'd52;
	PC_PLUS_4_IN = 32'd56;
	
	@(posedge CLK) begin    
        #4 
        `assert(INSTRUCTION_OUT, 32'd20);
        `assert(PC_PLUS_4_OUT, 32'd56);
		`assert(PC_DIRECT_OUT, 32'd52);

        $display("Test 02 : Passed!");
	end
	
	// test 3
	#1
	BUSYWAIT = 1'b1;
	
	INSTRUCTION_IN = 32'd30;
	PC_DIRECT_IN = 32'd60;
	PC_PLUS_4_IN = 32'd64;
	
	@(posedge CLK) begin    
        #4 
        `assert(INSTRUCTION_OUT, 32'd20);
        `assert(PC_PLUS_4_OUT, 32'd56);
		`assert(PC_DIRECT_OUT, 32'd52);

        $display("Test 03 : Passed!");
	end
	
		
	#40
	$finish;

	end
	
	//random clock generation
	always begin
        #4 CLK = ~CLK;
    end

endmodule
	
	