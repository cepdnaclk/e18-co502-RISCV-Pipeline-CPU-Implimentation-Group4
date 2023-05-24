// Advanced Computer Architecture (CO502)
// Design: Register File
// Group Number: 4
// E Numbers: E/18/077, E/18/397, E/18/402
// Names: Nipun Dharmarathne, Shamod Wijerathne, Chatura Wimalasiri

`timescale  1ns/100ps

module reg_file(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET);
    //Port declarations
    input [31:0] IN;                                    //Define 32bit input
    output [31:0] OUT1, OUT2;                           //Define 32bit outputs
    input [4:0] INADDRESS, OUT1ADDRESS, OUT2ADDRESS;    //Define 5 bit addresses
	input WRITE, CLK, RESET;                            //Define input signals

    reg [31:0] register [0:31];     //32 element array of 32 bit registers	             
    integer i;                      //Counter variable 
	
    //Register read
    //These assign statements are executed asynchrnously    
	assign #2 OUT1 = register[OUT1ADDRESS];
	assign #2 OUT2 = register[OUT2ADDRESS];

    //The always block triggeres (synchronously) only for the positive edge of the clock pulse
	always @(posedge CLK) begin
        if (RESET) begin
            //Resetting all register values to zero when RESET signal is high
            #1
            for (i=0; i<32; i=i+1) begin
                register[i] <= 0;
            end
        end

        else begin
            //Write data to the register when write signal is high
            if (WRITE) #1 register[INADDRESS] <= IN;
        end
	end 

    initial
    begin
        $dumpfile("cpu_wavedata.vcd");
        for(i=0;i<32;i++)
            $dumpvars(1,register[i]);
    end    
endmodule


        
