`timescale 1ns/100ps
`include "cpu.v"


module cpu_tb;

    reg CLK, RESET;

    cpu mycpu(CLK, RESET);
	
    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
	    $dumpvars(0, cpu_tb);
        
        CLK = 1'b0;
		RESET = 1'b0;
		RESET = 1'b1;
		#4;
		RESET = 1'b0;
		
		#5000;
		$finish;
        
    end
    

// clock genaration.
always begin
    #8 CLK = ~CLK;
end

endmodule
