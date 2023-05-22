`include "../RegisterFile/reg_file.v"
`include "../Sign_Zero_Extend/Sign_Zero_Extend.v"





module cpu (
    CLK, RESET, PC
);
// port declaration
  input RESET, CLK ; 


wire WRITE_REG;
wire [31:0] INSTRUCTION, IN_REG, OUT1_REG, OUT2_REG,PC_NEXT;
wire [4:0] MEM_WB_INADDRESS;

output reg[31:0] PC;


  // initiating modules
reg_file myreg(IN_REG, OUT1_REG, OUT2_REG, MEM_WB_INADDRESS, INSTRUCTION[19:15], INSTRUCTION[24:20], WRITE_REG, CLK, RESET); 



always @ ( posedge CLK ) begin
		
		if( RESET )	
			PC = 0 ;						// reset the PC
		else 
		begin
		
			PC = #1 PC_NEXT ;
		end

	end	
endmodule