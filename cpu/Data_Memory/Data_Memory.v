
`timescale 1ns/100ps

module data_memory(
	CLK,
    RESET,
    MEM_READ,
    MEM_WRITE,
    FUNCT3,
    MEM_ADDRESS,
    DATA_IN,
    DATA_OUT,
	BUSYWAIT
);
input				CLK;
input           	RESET;
input           	MEM_READ;
input           	MEM_WRITE;
input[2:0]          FUNCT3;
input[31:0]      	MEM_ADDRESS;
input[31:0]     	DATA_IN;
output reg [31:0]	DATA_OUT;
output reg      	BUSYWAIT;


//Declare memory array 1024x8-bits 
reg [7:0] memory_array [1024:0];

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
        case (FUNCT3)
        // #4 used for tesing	
            3'b000: DATA_OUT =#4 {{24{memory_array[MEM_ADDRESS][7]}}, memory_array[MEM_ADDRESS]};    
            3'b001: DATA_OUT =#4 {{16{memory_array[MEM_ADDRESS+4'b0001][7]}},memory_array[MEM_ADDRESS+4'b0001], memory_array[MEM_ADDRESS]};
            3'b010: DATA_OUT =#4 {memory_array[MEM_ADDRESS+4'b0011], memory_array[MEM_ADDRESS+4'b0010], memory_array[MEM_ADDRESS+4'b0001], memory_array[MEM_ADDRESS]};
            3'b011: DATA_OUT =#4 {24'b0, memory_array[MEM_ADDRESS]};
            3'b100: DATA_OUT =#4 {16'b0, memory_array[MEM_ADDRESS+4'b0001], memory_array[MEM_ADDRESS]};
            
        endcase
			
		// DATA_OUT[7:0]   = #4 memory_array[{MEM_ADDRESS+4'b0000}];
		// DATA_OUT[15:8]  = #4 memory_array[{MEM_ADDRESS+4'b0001}];
		// DATA_OUT[23:16] = #4 memory_array[{MEM_ADDRESS+4'b0010}];
		// DATA_OUT[31:24] = #4 memory_array[{MEM_ADDRESS+4'b0011}];

        
		BUSYWAIT = 0;
		MEM_READ_ACCESS = 0;
	end
	if(MEM_WRITE_ACCESS)
	begin
         case (FUNCT3)
            3'b000: begin
                memory_array[{MEM_ADDRESS,4'b0000}] = #40 DATA_IN[7:0];
                memory_array[{MEM_ADDRESS,4'b0001}] = #40 8*{DATA_IN[7]};
                memory_array[{MEM_ADDRESS,4'b0010}] = #40 8*{DATA_IN[7]};
                memory_array[{MEM_ADDRESS,4'b0011}] = #40 8*{DATA_IN[7]};
            end
            3'b001: begin
                memory_array[{MEM_ADDRESS,4'b0000}] = #40 DATA_IN[7:0];
                memory_array[{MEM_ADDRESS,4'b0001}] = #40 DATA_IN[15:8];
                memory_array[{MEM_ADDRESS,4'b0010}] = #40 8*{DATA_IN[7]};
                memory_array[{MEM_ADDRESS,4'b0011}] = #40 8*{DATA_IN[7]};
            end
            3'b010: begin
                memory_array[{MEM_ADDRESS,4'b0000}] = #40 DATA_IN[7:0];
                memory_array[{MEM_ADDRESS,4'b0001}] = #40 DATA_IN[15:8];
                memory_array[{MEM_ADDRESS,4'b0010}] = #40 DATA_IN[23:16];
                memory_array[{MEM_ADDRESS,4'b0011}] = #40 DATA_IN[31:24];
            end
            3'b011:begin
                memory_array[{MEM_ADDRESS,4'b0000}] = #40 DATA_IN[7:0];
                memory_array[{MEM_ADDRESS,4'b0001}] = #40 8'b00000000;
                memory_array[{MEM_ADDRESS,4'b0010}] = #40 8'b00000000;
                memory_array[{MEM_ADDRESS,4'b0011}] = #40 8'b00000000;
            end
            3'b100:begin
                memory_array[{MEM_ADDRESS,4'b0000}] = #40 DATA_IN[7:0];
                memory_array[{MEM_ADDRESS,4'b0001}] = #40 DATA_IN[15:8];
                memory_array[{MEM_ADDRESS,4'b0010}] = #40 8'b00000000;
                memory_array[{MEM_ADDRESS,4'b0011}] = #40 8'b00000000;
            end
            
        endcase
   
		
		
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

endmodule
