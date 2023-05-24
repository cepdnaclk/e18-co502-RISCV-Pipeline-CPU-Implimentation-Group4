
`timescale 1ns/100ps
`include "cpu.v"


module cpu_tb;

    reg CLK, RESET;

	
    cpu mycpu(CLK, RESET );
	
	

    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
	    $dumpvars(0, cpu_tb);
        
        CLK = 1'b0;
        RESET = 1'b0;
        
        // TODO: Reset the CPU (by giving a pulse to RESET signal) to start the program execution
        
	RESET = 1'b1;
	#5

	RESET = 1'b0;
        // finish simulation after some time
        #5000
        $finish;
        
    end
    
    // clock signal generation
    always #8 CLK = ~CLK;


    

    
 

endmodule
