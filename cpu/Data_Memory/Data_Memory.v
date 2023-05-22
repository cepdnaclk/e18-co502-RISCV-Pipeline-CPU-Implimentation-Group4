/*
256x8-bit data memory (4-Byte blocks)

Description	:

This memory allows data to be read and written as 4-Byte blocks
*/
`timescale  1ns/100ps
module data_memory(
	CLK,
    RESET,
    MEM_READ,
    MEM_WRITE,
    //FUNCT3,
    MEM_ADDRESS,
    DATA_IN,
    DATA_OUT,
	BUSYWAIT
);
input				CLK;
input           	RESET;
input           	MEM_READ;
input           	MEM_WRITE;
//input[2:0]          FUNCT3;
input[27:0]      	MEM_ADDRESS;
input[127:0]     	DATA_IN;
output reg [127:0]	DATA_OUT;
output reg      	BUSYWAIT;

//Declare memory array 1024x8-bits 
reg [127:0] memory_array [1024:0];

//Detecting an incoming memory _ACCESS
reg MEM_READ_ACCESS, MEM_WRITE_ACCESS;
always @(MEM_READ, MEM_WRITE)
begin
	BUSYWAIT = (MEM_READ || MEM_WRITE)? 1 : 0;
	MEM_READ_ACCESS = (MEM_READ && !MEM_WRITE)? 1 : 0;
	MEM_WRITE_ACCESS = (!MEM_READ && MEM_WRITE)? 1 : 0;
end

//MEM_READing & writing
always @(posedge CLK)
begin
	if(MEM_READ_ACCESS)
	begin
        DATA_OUT[7:0]     = #40 memory_array[{MEM_ADDRESS,4'b0000}];
        DATA_OUT[15:8]    = #40 memory_array[{MEM_ADDRESS,4'b0001}];
        DATA_OUT[23:16]   = #40 memory_array[{MEM_ADDRESS,4'b0010}];
        DATA_OUT[31:24]   = #40 memory_array[{MEM_ADDRESS,4'b0011}];
        DATA_OUT[39:32]   = #40 memory_array[{MEM_ADDRESS,4'b0100}];
        DATA_OUT[47:40]   = #40 memory_array[{MEM_ADDRESS,4'b0101}];
        DATA_OUT[55:48]   = #40 memory_array[{MEM_ADDRESS,4'b0110}];
        DATA_OUT[63:56]   = #40 memory_array[{MEM_ADDRESS,4'b0111}];
        DATA_OUT[71:64]   = #40 memory_array[{MEM_ADDRESS,4'b1000}];
        DATA_OUT[79:72]   = #40 memory_array[{MEM_ADDRESS,4'b1001}];
        DATA_OUT[87:80]   = #40 memory_array[{MEM_ADDRESS,4'b1010}];
        DATA_OUT[95:88]   = #40 memory_array[{MEM_ADDRESS,4'b1011}];
        DATA_OUT[103:96]  = #40 memory_array[{MEM_ADDRESS,4'b1100}];
        DATA_OUT[111:104] = #40 memory_array[{MEM_ADDRESS,4'b1101}];
        DATA_OUT[119:112] = #40 memory_array[{MEM_ADDRESS,4'b1110}];
        DATA_OUT[127:120] = #40 memory_array[{MEM_ADDRESS,4'b1111}];

        
		BUSYWAIT = 0;
		MEM_READ_ACCESS = 0;
	end
	if(MEM_WRITE_ACCESS)
	begin
        memory_array[{MEM_ADDRESS,4'b0000}] = #40 DATA_IN[7:0]    ;
        memory_array[{MEM_ADDRESS,4'b0001}] = #40 DATA_IN[15:8]   ;
        memory_array[{MEM_ADDRESS,4'b0010}] = #40 DATA_IN[23:16]  ;
        memory_array[{MEM_ADDRESS,4'b0011}] = #40 DATA_IN[31:24]  ;
        memory_array[{MEM_ADDRESS,4'b0100}] = #40 DATA_IN[39:32]  ;
        memory_array[{MEM_ADDRESS,4'b0101}] = #40 DATA_IN[47:40]  ;
        memory_array[{MEM_ADDRESS,4'b0110}] = #40 DATA_IN[55:48]  ;
        memory_array[{MEM_ADDRESS,4'b0111}] = #40 DATA_IN[63:56]  ;
        memory_array[{MEM_ADDRESS,4'b1000}] = #40 DATA_IN[71:64]  ;
        memory_array[{MEM_ADDRESS,4'b1001}] = #40 DATA_IN[79:72]  ;
        memory_array[{MEM_ADDRESS,4'b1010}] = #40 DATA_IN[87:80]  ;
        memory_array[{MEM_ADDRESS,4'b1011}] = #40 DATA_IN[95:88]  ;
        memory_array[{MEM_ADDRESS,4'b1100}] = #40 DATA_IN[103:96] ;
        memory_array[{MEM_ADDRESS,4'b1101}] = #40 DATA_IN[111:104];
        memory_array[{MEM_ADDRESS,4'b1110}] = #40 DATA_IN[119:112];
        memory_array[{MEM_ADDRESS,4'b1111}] = #40 DATA_IN[127:120];
   

		BUSYWAIT = 0;
		MEM_WRITE_ACCESS = 0;
	end
end

integer i;

//RESET memory
always @(posedge RESET)
begin
    if (RESET)
    begin
        for (i=0;i<1024; i=i+1)
            memory_array[i] = 0;
        
        BUSYWAIT = 0;
		MEM_READ_ACCESS = 0;
		MEM_WRITE_ACCESS = 0;
    end
end



initial
	begin
    $dumpfile("cpu_wavedata.vcd");
    for(i=0;i<1024;i++)
        $dumpvars(1,memory_array[i]);
end

endmodule