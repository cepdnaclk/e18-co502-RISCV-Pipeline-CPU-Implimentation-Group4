// Advanced Computer Architecture (CO502)
// Design: Register File
// Group Number: 4
// E Numbers: E/18/077, E/18/397, E/18/402
// Names: Nipun Dharmarathne, Shamod Wijerathne, Chatura Wimalasiri

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
endmodule

module reg_file_tb();
    reg [31:0] WRITEDATA;
    reg [4:0] WRITEREG, READREG1, READREG2;
    reg CLK, RESET, WRITEENABLE; 
    wire [31:0] REGOUT1, REGOUT2;    

    reg_file myregfile(WRITEDATA, REGOUT1, REGOUT2, WRITEREG, READREG1, READREG2, WRITEENABLE, CLK, RESET);

    initial
    begin
        CLK = 1'b1;
        
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("reg_file_wavedata.vcd");
		$dumpvars(0, reg_file_tb);
        
        // assign values with time to input signals to see output 
        RESET = 1'b0;
        WRITEENABLE = 1'b0;
        
        #5
        RESET = 1'b1;
        READREG1 = 5'd0;
        READREG2 = 5'd4;
        
        #7
        RESET = 1'b0;
        
        #3
        WRITEREG = 5'd2;
        WRITEDATA = 32'd95;
        WRITEENABLE = 1'b1;
        
        #9
        WRITEENABLE = 1'b0;
        
        #1
        READREG1 = 5'd2;
        
        #9
        WRITEREG = 5'd1;
        WRITEDATA = 32'd28;
        WRITEENABLE = 1'b1;
        READREG1 = 5'd1;
        
        #10
        WRITEENABLE = 1'b0;
        
        #10
        WRITEREG = 5'd4;
        WRITEDATA = 32'd6;
        WRITEENABLE = 1'b1;
        
        #10
        WRITEDATA = 32'd15;
        WRITEENABLE = 1'b1;
        
        #10
        WRITEENABLE = 1'b0;
        
        #6
        WRITEREG = 5'd1;
        WRITEDATA = 32'd50;
        WRITEENABLE = 1'b1;
        
        #5
        WRITEENABLE = 1'b0;
        
        #10
        $finish;
    end
    
    // clock signal generation
    always
        #5 CLK = ~CLK;
       
endmodule
        
