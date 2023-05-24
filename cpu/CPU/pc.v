module pc_module(IN, OUT, RESET, CLK, BUSYWAIT);

    //declare the ports
    input [31:0] IN;
    input RESET, CLK, BUSYWAIT;
    output reg [31:0] OUT;

    //reset the register to -4 whenever the reset signal changes from low to high
    always @ (RESET) begin
		#1
        if(RESET)  
			OUT = -32'd4;
    end

    //write the input value to the register when the reset is low and when the clock is at a positive edge and busywait is low 
    always @ (posedge CLK) begin
        #1
        if(!RESET & !BUSYWAIT)  
			OUT = IN;
    end

endmodule