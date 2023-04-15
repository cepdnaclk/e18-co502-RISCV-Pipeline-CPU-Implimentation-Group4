// Advanced Computer Architecture (CO502)
// Design: Control Unit
// Group Number: 4
// E Numbers: E/18/077, E/18/397, E/18/402
// Names: Nipun Dharmarathne, Shamod Wijerathne, Chatura Wimalasiri

module control_unit(INSTRUCTION, ALUOP, MUXIMMTYPE_SELECT, MUXPC_SELECT, MUXIMM_SELECT, MUXJAL_SELECT, MUXDATAMEM_SELECT, WRITE_ENABLE, MEM_READ, MEM_WRITE, BRANCH, JUMP);
    //port declaration
    input  [31:0] INSTRUCTION;
    output reg [4:0] ALUOP;
    output reg [2:0] MUXIMMTYPE_SELECT;
	output reg MUXPC_SELECT, MUXIMM_SELECT, MUXJAL_SELECT, MUXDATAMEM_SELECT, WRITE_ENABLE, MEM_READ, MEM_WRITE, BRANCH, JUMP;
        
	wire [6:0] OPCODE;
    wire [2:0] FUNCT3;
    wire [6:0] FUNCT7;
    
    assign OPCODE = INSTRUCTION[6:0];       //opcode
    assign FUNCT3 = INSTRUCTION[14:12];     //FUNCT3 field
    assign FUNCT7 = INSTRUCTION[31:25];

	always @(OPCODE, FUNCT3, FUNCT7) begin     
		case(OPCODE)
            7'b0110011: begin #1		            //R type instructions
                MUXIMMTYPE_SELECT = 3'bxxx;
                MUXPC_SELECT = 1'b0;
                MUXIMM_SELECT = 1'b0;
                MUXJAL_SELECT = 1'b0;
                MUXDATAMEM_SELECT = 1'b0;
                WRITE_ENABLE = 1'b1;
                MEM_READ = 1'b0;
                MEM_WRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0; 
                
                case({FUNCT7, FUNCT3})
                    10'b0000000_000: ALUOP = 5'b00001;      //ADD   
                    10'b0100000_000: ALUOP = 5'b00010;      //SUB       
                    10'b0000000_001: ALUOP = 5'b00011;      //SLL     
                    10'b0000000_010: ALUOP = 5'b00100;      //SLT    
                    10'b0000000_011: ALUOP = 5'b00101;      //SLTU        
                    10'b0000000_100: ALUOP = 5'b00110;      //XOR          
                    10'b0000000_101: ALUOP = 5'b00111;      //SRL     
                    10'b0100000_101: ALUOP = 5'b01000;      //SRA     
                    10'b0000000_110: ALUOP = 5'b01001;      //OR         
                    10'b0000000_111: ALUOP = 5'b01010;      //AND     
                    10'b0000001_000: ALUOP = 5'b01011;      //MUL     
                    10'b0000001_001: ALUOP = 5'b01100;      //MULH          
                    10'b0000001_010: ALUOP = 5'b01101;      //MULHSU   
                    10'b0000001_011: ALUOP = 5'b01110;      //MULHU           
                    10'b0000001_100: ALUOP = 5'b01111;      //DIV      
                    10'b0000001_101: ALUOP = 5'b10000;      //DIVU          
                    10'b0000001_110: ALUOP = 5'b10001;      //REM        
                    10'b0000001_111: ALUOP = 5'b10010;      //REMU     
                endcase
            end
            
            7'b0000011: begin #1		            //Load instructions (LB, LH, LW, LBU, LHU)
                ALUOP = 5'b00001;
                MUXIMMTYPE_SELECT = 3'bxxx;
                MUXPC_SELECT = 1'b0;
                MUXIMM_SELECT = 1'b1;
                MUXJAL_SELECT = 1'b0;
                MUXDATAMEM_SELECT = 1'b1;
                WRITE_ENABLE = 1'b1;
                MEM_READ = 1'b1;
                MEM_WRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;                    
            end
 
            7'b0010011: begin #1
                MUXIMMTYPE_SELECT = 3'bxxx;
                MUXPC_SELECT = 1'b0;
                MUXIMM_SELECT = 1'b1;
                MUXJAL_SELECT = 1'b0;
                MUXDATAMEM_SELECT = 1'b0;
                WRITE_ENABLE = 1'b1;
                MEM_READ = 1'b0;
                MEM_WRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;
                
                case(FUNCT3)
                    3'b000: ALUOP = 5'b00001;                    //ADDI
                    3'b001: begin                                //SLLI
                        case(FUNCT7)
                            7'b0000000: ALUOP = 5'b00011;
                        endcase
                    end
                    
                    3'b010: ALUOP = 5'b00100;                    //SLTI
                    3'b011: ALUOP = 5'b00101;                    //SLTIU
                    3'b100: ALUOP = 5'b00110;                    //XORI
                    3'b101: begin                                //SLRI, SRAI
                        case(FUNCT7)
                            7'b0000000: ALUOP = 5'b00111;       //SRLI 
                            7'b0100000: ALUOP = 5'b01000;       //SRAI     
                        endcase                        
                    end
                    
                    3'b110: ALUOP = 5'b01001;                    //ORI
                    3'b111: ALUOP = 5'b01010;                    //ANDI
                endcase      
            end
            
            7'b1100111: begin #1                //JALR
                ALUOP = 5'b00001;
                MUXIMMTYPE_SELECT = 3'bxxx;
                MUXPC_SELECT = 1'b0;
                MUXIMM_SELECT = 1'b1;
                MUXJAL_SELECT = 1'b1;
                MUXDATAMEM_SELECT = 1'b0;
                WRITE_ENABLE = 1'b1;
                MEM_READ = 1'b0;
                MEM_WRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b1;             
            end
            
            7'b0100011: begin #1                //Store instructions (SB, SH, SW, SBU, SHU)
                ALUOP = 5'b00001;
                MUXIMMTYPE_SELECT = 3'bxxx;
                MUXPC_SELECT = 1'b0;
                MUXIMM_SELECT = 1'b1;
                MUXJAL_SELECT = 1'b0;
                MUXDATAMEM_SELECT = 1'bx;
                WRITE_ENABLE = 1'b0;
                MEM_READ = 1'b0;
                MEM_WRITE = 1'b1;
                BRANCH = 1'b0;
                JUMP = 1'b0;             
            end
            
            7'b0010111: begin #1                //AUIPC
                ALUOP = 5'b00001;
                MUXIMMTYPE_SELECT = 3'bxxx;
                MUXPC_SELECT = 1'b1;
                MUXIMM_SELECT = 1'b1;
                MUXJAL_SELECT = 1'b0;
                MUXDATAMEM_SELECT = 1'b0;
                WRITE_ENABLE = 1'b1;
                MEM_READ = 1'b0;
                MEM_WRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;             
            end            
            
            7'b0110111: begin #1                //LUI
                ALUOP = 5'b00000;
                MUXIMMTYPE_SELECT = 3'bxxx;
                MUXPC_SELECT = 1'bx;
                MUXIMM_SELECT = 1'b1;
                MUXJAL_SELECT = 1'b0;
                MUXDATAMEM_SELECT = 1'b0;
                WRITE_ENABLE = 1'b1;
                MEM_READ = 1'b0;
                MEM_WRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;             
            end             
            
            7'b1100011: begin #1                //Branch instructions
                ALUOP = 5'b00010;
                MUXIMMTYPE_SELECT = 3'bxxx;
                MUXPC_SELECT = 1'b1;
                MUXIMM_SELECT = 1'b1;
                MUXJAL_SELECT = 1'b0;
                MUXDATAMEM_SELECT = 1'bx;
                WRITE_ENABLE = 1'b0;
                MEM_READ = 1'b0;
                MEM_WRITE = 1'b0;
                BRANCH = 1'b1;
                JUMP = 1'b0;             
            end  

            7'b1101111: begin #1                //JAl
                ALUOP = 5'b00001;
                MUXIMMTYPE_SELECT = 3'bxxx;
                MUXPC_SELECT = 1'b1;
                MUXIMM_SELECT = 1'b1;
                MUXJAL_SELECT = 1'b1;
                MUXDATAMEM_SELECT = 1'b0;
                WRITE_ENABLE = 1'b1;
                MEM_READ = 1'b0;
                MEM_WRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b1;             
            end       
		endcase
    end
endmodule