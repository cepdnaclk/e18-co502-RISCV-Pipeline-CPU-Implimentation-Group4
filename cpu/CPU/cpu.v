`include "../RegisterFile/reg_file.v"
`include "../Sign_Zero_Extend/Sign_Zero_Extend.v"
`include "../ControlUnit/control_unit.v"






module cpu (
    CLK, RESET, PC
);
// port declaration
  input RESET, CLK ; 


wire WRITE_REG, MUXPC_SELECT, MUXIMM_SELECT, MUXJAL_SELECT, MUXDATAMEM_SELECT, WRITE_ENABLE, MEM_READ, MEM_WRITE, BRANCH, JUMP;
wire [31:0] INSTRUCTION, IN_REG, OUT1_REG, OUT2_REG,PC_NEXT, U_TYPE, J_TYPE, I_TYPE, S_TYPE, B_TYPE;
wire [4:0] MEM_WB_INADDRESS, ALUOP;
wire[2:0] MUXIMMTYPE_SELECT;

output reg[31:0] PC;


// initiating modules
reg_file myreg(IN_REG, OUT1_REG, OUT2_REG, MEM_WB_INADDRESS, INSTRUCTION[19:15], INSTRUCTION[24:20], WRITE_REG, CLK, RESET); 
control_unit mycu(INSTRUCTION, ALUOP,  MUXIMMTYPE_SELECT, MUXPC_SELECT, MUXIMM_SELECT, MUXJAL_SELECT, MUXDATAMEM_SELECT, WRITE_ENABLE, MEM_READ, MEM_WRITE, BRANCH, JUMP);
Sign_Zero_Extend signZeroExtend(INSTRUCTION, U_TYPE, J_TYPE, I_TYPE, S_TYPE, B_TYPE);

always @ ( posedge CLK ) begin
		
		if( RESET )	
			PC = 0 ;						// reset the PC
		else 
		begin
		
			PC = #1 PC_NEXT ;
		end

	end	
endmodule