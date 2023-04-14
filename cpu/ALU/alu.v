// Advanced Computer Architecture (CO502)
// Design: ALU
// Group Number: 4
// E Numbers: E/18/077, E/18/397, E/18/402
// Names: Nipun Dharmarathne, Shamod Wijerathne, Chatura Wimalasiri

//ALU 32-bit module
module alu(DATA1, DATA2, RESULT, SELECT, EQ_FLAG, LT_FLAG, LTU_FLAG);
    //Port declarations, Declarations of wire & reg
    input [31:0] DATA1, DATA2;               //Define 32bit inputs DATA1 and DATA2
	input [4:0] SELECT;                      //Define 5bit SELECT port
	output reg [31:0] RESULT;                //Define 32bit output port (output is declared as reg type, as it is used in procedural block)
	output EQ_FLAG, LT_FLAG, LTU_FLAG;       //Define output signals
    
	wire[31:0] ADD, SUB,
               SLL, 
               SLT, SLTU,
               XOR,
               SRL, SRA,
               OR, AND,
               MUL, MULH, MULHSU, MULHU,
			   DIV, DIVU,
               REM, REMU;                                       
	
    //Instructions
    assign #1 FORWARD = DATA2;          //Forward
    assign #2 ADD = DATA1 + DATA2;      //Addition
	assign #2 SUB = DATA1 - DATA2;      //Substraction
    
    assign #1 SLL = DATA1 << DATA2;     //Shift left logical
	
    assign #1 SLT = ($signed(DATA1) < $signed(DATA2)) ? 32'd1 : 32'd0;         //Set less than
    assign #1 SLTU = ($unsigned(DATA1) < $unsigned(DATA2)) ? 32'd1 : 32'd0;    //Set less than usigned    
    
    assign #1 XOR = DATA1 ^ DATA2;      //Bitwise XOR
    
    assign #1 SRL = DATA1 >> DATA2;	    //Shift right logical
    assign #1 SRA = DATA1 >>> DATA2;    //Shift rIght arithmetic
    
    assign #1 OR = DATA1 | DATA2;       //Bitwise OR
    assign #1 AND = DATA1 & DATA2;      //Bitwise AND
    
	assign #3 MUL = DATA1 * DATA2;                           //Multiplication
    assign #3 MULH = DATA1 * DATA2;                          //Multiplication (Signed)
    assign #3 MULHSU = $signed(DATA1) * $unsigned(DATA2);    //Multiplication (Signed x UnSigned)
    assign #3 MULHU = $unsigned(DATA1) * $unsigned(DATA2);   //Multiplication (UnSigned)
    
	assign #3 DIV = DATA1 / DATA2;                           //Division
    assign #3 DIVU = $unsigned(DATA1) / $unsigned(DATA2);    //Division Unsigned
    assign #3 REM = DATA1 % DATA2;                           //Remainder
    assign #3 REMU = DATA1 % DATA2;                          //Remainder Unsigned
    
    //Always block calls whenever a signal changes
	always @(*)                          
	begin
        //Select the function to implement using a case structure
		case(SELECT)
			5'b00000: RESULT = FORWARD;                                                  
			5'b00001: RESULT = ADD;		         
			5'b00010: RESULT = SUB;          
            5'b00011: RESULT = SLL;        
            5'b00100: RESULT = SLT;	             							
   			5'b00101: RESULT = SLTU;                   
            5'b00110: RESULT = XOR;                 			            							
            5'b00111: RESULT = SRL;                 			            							
            5'b01000: RESULT = SRA;                 			            							
            5'b01001: RESULT = OR;                 			            							
			5'b01010: RESULT = AND;                 			            							
			5'b01011: RESULT = MUL;                 			            							
			5'b01100: RESULT = MULH;                 			            							
			5'b01101: RESULT = MULHSU;                 			            							                                             			  
			5'b01110: RESULT = MULHU;                 			            							
			5'b01111: RESULT = DIV;                 			            							
			5'b10000: RESULT = DIVU;                 			            							
			5'b10001: RESULT = REM; 
            5'b10010: RESULT = REMU;
		    default: RESULT = 31'd0;		//Default value=0 (For unused select combinations)
		endcase
    end    
    
    //Generating signals
	assign EQ_FLAG = ~(|RESULT);    //Equal flag is used to check whether DATA1=DATA2
	assign LT_FLAG = RESULT[31];    //Less than flag is used to check whether DATA1<DATA2
	assign LTU_FLAG = SLTU[0];	    //Less than unsigned flag is used to check whether |DATA1|<|DATA2|          
endmodule

//Testbench of ALU
module alu_tb();
    //Declarations of reg & wire
   	reg [31:0] OPERAND1, OPERAND2;
	reg [4:0] ALUOP;
	wire [31:0] ALURESULT;
	wire EQ_FLAG, LT_FLAG, LTU_FLAG;
	 
    //Instantiate ALU module
	alu myalu(OPERAND1, OPERAND2, ALURESULT, ALUOP, EQ_FLAG, LT_FLAG, LTU_FLAG);	
		
    initial
    begin
        //To display the results
        $monitor($time, " OPERAND1: %b, OPERAND2: %b, ALUOP: %b, ALURESULT: %b", OPERAND1, OPERAND2, ALUOP, ALURESULT);
        //$dumpfile("alu_wavedata.vcd");
        //$dumpvars(0,myalu);
    end
    
    initial
    begin
        OPERAND1 = 32'd20;
        OPERAND2 = 32'd10;
        
        $display("OPERAND1 + OPERAND2");
        ALUOP = 5'b00001;
        #5 
        
        $display("OPERAND1 - OPERAND2");
        ALUOP = 5'b00010;
        #5
        
        $display("OPERAND1 | OPERAND2");        
        ALUOP = 5'b01001;
        #5
        
        $display("OPERAND1 & OPERAND2"); 
        ALUOP = 5'b01010;
    end		
endmodule
