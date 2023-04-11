

module Jump_Controller (

    BRANCH_ADDR,
    JUMP_I,
    FUNC3,
    BRANCH,
    JUMP,
    ZERO,
    SIGN,
    UNSIGNED,
    BRANCH_OR_JUMP_ADDR,
    PC_MUX_CONTROL,
    REG_FLUSH
);

input [31:0] BRANCH_ADDR,JUMP_I;
input [2:0] FUNC3;
input BRANCH,JUMP,ZERO,SIGN,UNSIGNED;

output reg PC_MUX_CONTROL, REG_FLUSH;
output reg [31:0] BRANCH_OR_JUMP_ADDR;

wire BEQ,BGE,BNE,BLT,BLTU,BGEU;

//CREATING SUITABLE CONTROLL SIGNALS FOR EACH INSTRUCTION
assign #1 BEQ = (~FUNC3[2]) & (~FUNC3[1]) &  (~FUNC3[0]) & ZERO;
assign #1 BGE = (FUNC3[2]) & (~FUNC3[1]) &  (FUNC3[0]) & (~SIGN);
assign #1 BNE = (~FUNC3[2]) & (~FUNC3[1]) &  (FUNC3[0]) & (~ZERO);
assign #1 BLT = (FUNC3[2]) & (~FUNC3[1]) &  (~FUNC3[0]) & (~ZERO) & SIGN;
assign #1 BLTU = (FUNC3[2]) & (FUNC3[1]) &  (~FUNC3[0]) & (~ZERO) & UNSIGNED;
assign #1 BGEU = (FUNC3[2]) & (FUNC3[1]) &  (FUNC3[0]) & (~UNSIGNED);

always @(BRANCH,JUMP)begin
    PC_MUX_CONTROL=(BRANCH &(BEQ|BGE|BNE|BLT|BLTU|BGEU)) | (JUMP);
    REG_FLUSH = PC_MUX_CONTROL;
end



always @(*) begin
    
    if (JUMP==1'b1) begin
        BRANCH_OR_JUMP_ADDR=JUMP_I;
    end
    else begin
                                          
        BRANCH_OR_JUMP_ADDR=BRANCH_ADDR;
    end
end


    
endmodule