module PC_Select_Module (
    PC_PLUS_4,
    ID_BRANCH_ADDR,
    BRANCH_ADDR,
    ALU_PC_PLUS_4,
    FLUSH,
    EARLY_PREDICTION,
    TAKE_BRANCH,
    PC_SELECT_OUT
);

input [31:0] PC_PLUS_4,ID_BRANCH_ADDR,BRANCH_ADDR,ALU_PC_PLUS_4;
input FLUSH,EARLY_PREDICTION,TAKE_BRANCH;

output reg [31:0] PC_SELECT_OUT;

wire PC_PLUS_4_WIRE,ID_BRANCH_ADDR_WIRE,BRANCH_ADDR_WIRE,ALU_PC_PLUS_4_WIRE;


// assigning wire values for module
assign PC_PLUS_4_WIRE = (~TAKE_BRANCH) & (~FLUSH);
assign ID_BRANCH_ADDR_WIRE = (TAKE_BRANCH) & (~FLUSH);
assign BRANCH_ADDR_WIRE = (~EARLY_PREDICTION) & (FLUSH);
assign ALU_PC_PLUS_4_WIRE = (EARLY_PREDICTION) & (FLUSH);


// getting correct output values according to control signal
always @(*) begin
    if (PC_PLUS_4_WIRE == 1'b1) begin
        PC_SELECT_OUT = PC_PLUS_4;
    end
     if (ID_BRANCH_ADDR_WIRE == 1'b1) begin
        ID_BRANCH_ADDR = PC_PLUS_4;
    end
      if (BRANCH_ADDR_WIRE == 1'b1) begin
        BRANCH_ADDR = PC_PLUS_4;
    end
     if (ALU_PC_PLUS_4_WIRE == 1'b1) begin
        ALU_PC_PLUS_4 = PC_PLUS_4;
    end
end

endmodule