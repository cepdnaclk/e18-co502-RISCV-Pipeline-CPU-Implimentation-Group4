//Testbench 2 of ALU
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
        OPERAND1 = 32'd20;
        OPERAND2 = 32'd2;
        
        ALUOP = 5'b00000;   //FORWARD
        #5
        $display("Test case 1: Forward operation");
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);
        
        ALUOP = 5'b00001;   //ADD
        #5
        $display("\nTest case 2: OPERAND1 + OPERAND2");     
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);        
     
        ALUOP = 5'b00010;   //SUB
        #5
        $display("\nTest case 3: OPERAND1 - OPERAND2");     
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);      

        ALUOP = 5'b00011;   //SLL
        #5
        $display("\nTest case 4: OPERAND1 << OPERAND2");      
        $display("OPERAND1   : %b", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %b", ALURESULT);
        
        ALUOP = 5'b00100;   //SLT
        #5
        $display("\nTest case 5: Set less than (When OPERAND1 > OPERAND2)");    
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);

        OPERAND1 = 32'd2;
        OPERAND2 = 32'd20;
        
        ALUOP = 5'b00100;   //SLT
        #5
        $display("\nTest case 6: Set less than (When OPERAND1 < OPERAND2)");    
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);     

        OPERAND1 = 32'd20;
        OPERAND2 = 32'd2;

        ALUOP = 5'b00101;   //SLTU
        #5
        $display("\nTest case 7: Set less than unsigned (When unsigned(OPERAND1) > unsigned(OPERAND2))");   
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);

        OPERAND1 = 32'd2;
        OPERAND2 = 32'd20;
        
        ALUOP = 5'b00101;   //SLTU
        #5
        $display("\nTest case 8: Set less than unsigned(When unsigned(OPERAND1) < unsigned(OPERAND2))");    
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);

        OPERAND1 = 32'd15;
        OPERAND2 = 32'd20;

        ALUOP = 5'b00110;   //XOR
        #5
        $display("\nTest case 9: OPERAND1 ^ OPERAND2");
        $display("OPERAND1   : %b", OPERAND1);
        $display("OPERAND2   : %b", OPERAND2);
        $display("ALURESULT  : %b", ALURESULT);

        OPERAND1 = 32'd20;
        OPERAND2 = 32'd2;

        ALUOP = 5'b00111;   //SRL
        #5
        $display("\nTest case 10: OPERAND1 >> OPERAND2");
        $display("OPERAND1   : %b", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %b", ALURESULT);

        OPERAND1 = 32'b00000000_00000000_00000000_11110000;
        OPERAND2 = 32'd2;

        ALUOP = 5'b01000;   //SRA
        #5
        $display("\nTest case 11: OPERAND1 >>> OPERAND2");
        $display("OPERAND1   : %b", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %b", ALURESULT);

        OPERAND1 = 32'd15;
        OPERAND2 = 32'd20;

        ALUOP = 5'b01001;   //OR
        #5
        $display("\nTest case 12: OPERAND1 | OPERAND2");
        $display("OPERAND1   : %b", OPERAND1);
        $display("OPERAND2   : %b", OPERAND2);
        $display("ALURESULT  : %b", ALURESULT);

        ALUOP = 5'b01010;   //AND
        #5
        $display("\nTest case 13: OPERAND1 & OPERAND2");
        $display("OPERAND1   : %b", OPERAND1);
        $display("OPERAND2   : %b", OPERAND2);
        $display("ALURESULT  : %b", ALURESULT);

        OPERAND1 = 32'd10;
        OPERAND2 = 32'd20;
        
        ALUOP = 5'b01011;   //MUL
        #5
        $display("\nTest case 14: MUL");
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);   
        $display("ALURESULT  : %b", ALURESULT); 
 
        OPERAND1 = 32'd1;
        OPERAND2 = 32'd4294967295;
        
        ALUOP = 5'b01011;   //MUL
        #5
        $display("\nTest case 15: MUL");
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);   
        $display("ALURESULT  : %b", ALURESULT); 
 
        OPERAND1 = 32'd10;
        OPERAND2 = 32'd20;
        
        ALUOP = 5'b01100;   //MULH
        #5
        $display("\nTest case 16: MULH");
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);   
        $display("ALURESULT  : %b", ALURESULT);     

        OPERAND1 = 32'd4;
        OPERAND2 = 32'd4294967295;
        
        ALUOP = 5'b01100;   //MULH
        #5
        $display("\nTest case 17: MULH");
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);   
        $display("ALURESULT  : %b", ALURESULT);     

        OPERAND1 = 32'd10;
        OPERAND2 = 32'd20;
        
        ALUOP = 5'b01101;   //MULHSU
        #5
        $display("\nTest case 18: MULHSU");
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);   
        $display("ALURESULT  : %b", ALURESULT);     

        OPERAND1 = 32'd4;
        OPERAND2 = 32'd4294967295;
        
        ALUOP = 5'b01101;   //MULHSU
        #5
        $display("\nTest case 19: MULHSU");
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);   
        $display("ALURESULT  : %b", ALURESULT);

        OPERAND1 = 32'd10;
        OPERAND2 = 32'd20;
        
        ALUOP = 5'b01110;   //MULHU
        #5
        $display("\nTest case 20: MULHU");
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);   
        $display("ALURESULT  : %b", ALURESULT);     

        OPERAND1 = 32'd4;
        OPERAND2 = 32'd4294967295;
        
        ALUOP = 5'b01110;   //MULHU
        #5
        $display("\nTest case 21: MULHU");
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);   
        $display("ALURESULT  : %b", ALURESULT);
        
        OPERAND1 = 32'd20;
        OPERAND2 = 32'd10;
        
        ALUOP = 5'b01111;   //DIV
        #5
        $display("\nTest case 22: DIV");
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);   
        $display("ALURESULT  : %b", ALURESULT);     
        
        ALUOP = 5'b10000;   //DIVU
        #5
        $display("\nTest case 23: DIVU");
        $display("OPERAND1   : %d", OPERAND1);
        $display("OPERAND2   : %d", OPERAND2);
        $display("ALURESULT  : %d", ALURESULT);   
        $display("ALURESULT  : %b", ALURESULT);             
    end		
endmodule