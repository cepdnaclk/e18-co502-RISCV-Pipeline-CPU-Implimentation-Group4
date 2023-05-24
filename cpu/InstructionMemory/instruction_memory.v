// Advanced Computer Architecture (CO502)
// Design: Instruction Memory
// Group Number: 4
// E Numbers: E/18/077, E/18/397, E/18/402
// Names: Nipun Dharmarathne, Shamod Wijerathne, Chatura Wimalasiri

`timescale  1ns/100ps

module instruction_memory(
    clock,
    read,
    address,
    readinst,
    busywait
);

input               clock;
input               read;
    input[27:0]          address;
output reg [127:0]  readinst;
output reg          busywait;

reg readaccess;

//Declare memory array 1024x8-bits 
reg [7:0] memory_array [1023:0];

//Initialize instruction memory
initial begin
    busywait = 0;
    readaccess = 0;

    // Sample program given below 
    // ADDI x1, x1, 0x8F1   : adds the immediate value 0x8F1 to the value in register x1 and stores the result back in x1
    // ANDI x12,x1,0x000    : bitwise logical AND operation between the value in register x12 and the immediate value 0x000, and stores the result in register x1
    // SB x1, 0x001(x12)    : stores the least significant byte of the value in register x1 to memory at the address given by the sum of the value in register x12 and the offset of 0x001
    // LB x2, 0xF23(x12)    : loads a signed byte of data from memory at the address given by the sum of the value in register x12 and the offset of 0xF23, sign-extends the byte to 32 bits, and stores the result in register x2
    // SW x12, 0xF23(x1)    : stores the value in register x12 to memory at the address given by the sum of the value in register x1 and the offset of 0xF23
    // LW x13, 0xF23(x1)    : loads a 32-bit word of data from memory at the address given by the sum of the value in register x1 and the offset of 0xF23, and stores the result in register x13
    // SW x13,0xF23(x1)     : stores the value in register x13 to memory at the address given by the sum of the value in register x1 and the offset of 0xF23
    
    {memory_array[10'd03], memory_array[10'd02], memory_array[10'd01], memory_array[10'd00]} <= 32'b100011110001_00001_000_00001_0010011;   // ADDI x1, x1, 0x8F1 (adds the immediate value 0x8F1 to the value in register x1 and stores the result back in x1)
    
    {memory_array[10'd07], memory_array[10'd06], memory_array[10'd05], memory_array[10'd04]} <= 32'b0000000_00000_00000_000_00000_0000000;  // This instruction is a no-operation (NOP) instruction, which performs no operation and simply moves to the next instruction         
    {memory_array[10'd11], memory_array[10'd10], memory_array[10'd09], memory_array[10'd08]} <= 32'b0000000_00000_00000_000_00000_0000000;  // This instruction is a no-operation (NOP) instruction, which performs no operation and simply moves to the next instruction      
    
    {memory_array[10'd15], memory_array[10'd14], memory_array[10'd13], memory_array[10'd12]} <= 32'b0000000_00000_00001_111_01100_0010011;  // ANDI x1, x12, 0x000  (bitwise logical AND operation between the value in register x12 and the immediate value 0x000, and stores the result in register x1)
    
    {memory_array[10'd19], memory_array[10'd18], memory_array[10'd17], memory_array[10'd16]} <= 32'b0000000_00000_00000_000_00000_0000000;  // This instruction is a no-operation (NOP) instruction, which performs no operation and simply moves to the next instruction     
    {memory_array[10'd23], memory_array[10'd22], memory_array[10'd21], memory_array[10'd20]} <= 32'b0000000_00000_00000_000_00000_0000000;  // This instruction is a no-operation (NOP) instruction, which performs no operation and simply moves to the next instruction     
    
    {memory_array[10'd27], memory_array[10'd26], memory_array[10'd25], memory_array[10'd24]} <= 32'b0000000_00001_01100_000_00001_0100011;  // SB x1, 0x001(x12)  (stores the least significant byte of the value in register x1 to memory at the address given by the sum of the value in register x12 and the offset of 0x001)
    
    {memory_array[10'd31], memory_array[10'd30], memory_array[10'd29], memory_array[10'd28]} <= 32'b0000000_00000_00000_000_00000_0000000;  // This instruction is a no-operation (NOP) instruction, which performs no operation and simply moves to the next instruction    
    {memory_array[10'd35], memory_array[10'd34], memory_array[10'd33], memory_array[10'd32]} <= 32'b0000000_00000_00000_000_00000_0000000;  // This instruction is a no-operation (NOP) instruction, which performs no operation and simply moves to the next instruction
    
    {memory_array[10'd39], memory_array[10'd38], memory_array[10'd37], memory_array[10'd36]} <= 32'b111100100011_01100_000_00010_0000011;   // LB x2, 0xF23(x12)  (loads a signed byte of data from memory at the address given by the sum of the value in register x12 and the offset of 0xF23, sign-extends the byte to 32 bits, and stores the result in register x2)
    
    {memory_array[10'd43], memory_array[10'd42], memory_array[10'd41], memory_array[10'd40]} <= 32'b0000000_00000_00000_000_00000_0000000;  // This instruction is a no-operation (NOP) instruction, which performs no operation and simply moves to the next instruction
    
    {memory_array[10'd47], memory_array[10'd46], memory_array[10'd45], memory_array[10'd44]} <= 32'b1111001_01100_00001_010_00011_0100011;  // SW x12, 0xF23(x1)  (stores the value in register x12 to memory at the address given by the sum of the value in register x1 and the offset of 0xF23)
    {memory_array[10'd51], memory_array[10'd50], memory_array[10'd49], memory_array[10'd48]} <= 32'b111100100011_00001_010_01101_0000011;   // LW x13, 0xF23(x1)  (loads a 32-bit word of data from memory at the address given by the sum of the value in register x1 and the offset of 0xF23, and stores the result in register x13)
    
    {memory_array[10'd55], memory_array[10'd54], memory_array[10'd53], memory_array[10'd52]} <= 32'b0000000_00000_00000_000_00000_0000000;  // This instruction is a no-operation (NOP) instruction, which performs no operation and simply moves to the next instruction
    {memory_array[10'd59], memory_array[10'd58], memory_array[10'd57], memory_array[10'd56]} <= 32'b0000000_00000_00000_000_00000_0000000;  // This instruction is a no-operation (NOP) instruction, which performs no operation and simply moves to the next instruction
    
    {memory_array[10'd63], memory_array[10'd62], memory_array[10'd61], memory_array[10'd60]} <= 32'b1111001_01101_00001_010_00011_0100011;  // SW x13, 0xF23(x1)  (stores the value in register x13 to memory at the address given by the sum of the value in register x1 and the offset of 0xF23)
end

//Detecting an incoming memory access
always @(read)
begin
    busywait = (read)? 1 : 0;
    readaccess = (read)? 1 : 0;
end

//Reading
always @(posedge clock)
begin
    if(readaccess)
    begin
        readinst[7:0]     = #40 memory_array[{address,4'b0000}];
        readinst[15:8]    = #40 memory_array[{address,4'b0001}];
        readinst[23:16]   = #40 memory_array[{address,4'b0010}];
        readinst[31:24]   = #40 memory_array[{address,4'b0011}];
        readinst[39:32]   = #40 memory_array[{address,4'b0100}];
        readinst[47:40]   = #40 memory_array[{address,4'b0101}];
        readinst[55:48]   = #40 memory_array[{address,4'b0110}];
        readinst[63:56]   = #40 memory_array[{address,4'b0111}];
        readinst[71:64]   = #40 memory_array[{address,4'b1000}];
        readinst[79:72]   = #40 memory_array[{address,4'b1001}];
        readinst[87:80]   = #40 memory_array[{address,4'b1010}];
        readinst[95:88]   = #40 memory_array[{address,4'b1011}];
        readinst[103:96]  = #40 memory_array[{address,4'b1100}];
        readinst[111:104] = #40 memory_array[{address,4'b1101}];
        readinst[119:112] = #40 memory_array[{address,4'b1110}];
        readinst[127:120] = #40 memory_array[{address,4'b1111}];
        busywait = 0;
        readaccess = 0;
    end
end
integer i = 0;
initial
    begin
        $dumpfile("cpu_wavedata.vcd");
        for(i=0;i<1024;i++)
            $dumpvars(1,memory_array[i]);
    end  
 
 
endmodule
