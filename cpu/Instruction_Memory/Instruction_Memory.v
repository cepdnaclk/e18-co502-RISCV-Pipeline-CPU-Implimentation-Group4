/*
Module	: 1024x8-bit instruction memory (4-Byte blocks)



This memory allows instructions to be read as 4-Byte blocks
*/
`timescale 1ns/100ps
module instruction_memory(
	CLK,
    PC,
    INSTRUCTION,
);
input				CLK;
input[31:0]			PC;
output reg [31:0]	INSTRUCTION;


//Declare memory array 1024x8-bits 
reg [7:0] memory_array [1023:0];

//Initialize instruction memory
initial
begin
	
	
    // Sample program given below. You may hardcode your software program here, or load it from a file:
    {memory_array[10'd3],  memory_array[10'd2],  memory_array[10'd1],  memory_array[10'd0]}  = 32'b00000001000000010000000000010011; // addi x1, x0, 10
	{memory_array[10'd7],  memory_array[10'd6],  memory_array[10'd5],  memory_array[10'd4]}  = 32'b00000010000000100000000000010011; // addi x2, x0, 20
    {memory_array[10'd11], memory_array[10'd10], memory_array[10'd9],  memory_array[10'd8]}  = 32'b00000011000100010000000000110011; // add  x3, x1, x2
    {memory_array[10'd15], memory_array[10'd14], memory_array[10'd13], memory_array[10'd12]} = 32'b00000000000000110000000000100011; // sw   x3, 0(x0)

    // this code effectively adds the values 10 and 20 together, and stores the result (30) in memory address 0.
   

	// loading instr_mem content from instr_mem.mem file
	// $readmemb("instr_mem.mem", memory_array);
end


//Reading
// 3 TIME UNITS OF READING DEALY
always @( posedge CLK )
begin
#2
		INSTRUCTION[7:0]     =  memory_array[{PC+32'b00000000}];
		INSTRUCTION[15:8]    =  memory_array[{PC+32'b00000001}];
		INSTRUCTION[23:16]   =  memory_array[{PC+32'b00000010}];
		INSTRUCTION[31:24]   =  memory_array[{PC+32'b00000011}];
		
	
end


 
endmodule