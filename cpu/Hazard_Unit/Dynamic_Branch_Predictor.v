`timescale  1ns/100ps

module Dynamic_Branch_Prdictor (
    ID_PC,ALU_PC,
    RESET,
    ID_STAGE_BRANCH,
    ALU_STAGE_BRANCH,
    ALU_STAGE_BRANCH_RESULT,
    FLUSH,
    EARLY_PREDICTION,
    TAKE_BRANCH
);

input [2:0] ID_PC,ALU_PC;
input RESET,ID_STAGE_BRANCH,ALU_STAGE_BRANCH,ALU_STAGE_BRANCH_RESULT;
output reg FLUSH,EARLY_PREDICTION,TAKE_BRANCH;

reg  [1:0] prediction[0:7];                 //branch target buffer


parameter BRANCH_TAKEN_STRONG = 2'b00, BRANCH_TAKEN_WEAK =2'b01, BRANCH_NOTTAKEN_WEAK =2'b10, BRANCH_NOTTAKEN_STRONG =2'b11;

//checking weather the prediction is correct by using ALU_STAGE_BRANCH Signal
always @(*) begin
    if (ALU_STAGE_BRANCH) begin    //"branch control signal" getting from alu to check wether our prediction is correct
        case (prediction[ALU_PC])
            BRANCH_TAKEN_STRONG:
                if (ALU_STAGE_BRANCH_RESULT) begin                //prediction correct
                    prediction[ALU_PC]=2'b00;
                    FLUSH=1'b0;                                   //do not need to FLUSH pipeline
                end
                else begin                                       //prediction incorrect
                    prediction[ALU_PC]=2'b01;
                    FLUSH=1'b1;                                   //pipelines should be FLUSHed 
                    EARLY_PREDICTION=1'b1;       // PC should be given PC+4 value that got from alu stage
                end
            BRANCH_TAKEN_WEAK:
                if (ALU_STAGE_BRANCH_RESULT) begin               //prediction correct
                    prediction[ALU_PC]=2'b00;
                    FLUSH=1'b0;
                end
                else begin                                       //prediction incorrect
                    prediction[ALU_PC]=2'b10;
                    FLUSH=1'b1;
                    EARLY_PREDICTION=1'b1;
                end
            BRANCH_NOTTAKEN_WEAK:
                if (ALU_STAGE_BRANCH_RESULT) begin               //prediction incorrect
                    prediction[ALU_PC]=2'b01;
                    FLUSH=1'b1;
                    EARLY_PREDICTION=1'b0;      // PC should be given the (b_imm + PC) from ALU stage(ALU stage should have the calculaed value from the dedicated adder)
                end
                else begin                                       //prediction correct
                    prediction[ALU_PC]=2'b11;
                    FLUSH=1'b0;
                end
            BRANCH_NOTTAKEN_STRONG:
                if (ALU_STAGE_BRANCH_RESULT) begin               //prediction incorrect
                    prediction[ALU_PC]=2'b10;
                    FLUSH=1'b1;
                    EARLY_PREDICTION=1'b0;
                end
                else begin                                        //prediction incorrect
                    prediction[ALU_PC]=2'b11;
                    FLUSH=1'b0;
                end
        endcase   
    end
    else begin
        FLUSH = 1'b0;
    end

    
end

//prediction - looking for STATE and sending proper signal
always @(*) begin
    if (ID_STAGE_BRANCH) begin
        case (prediction[ID_PC])
            BRANCH_TAKEN_STRONG:
                TAKE_BRANCH=1'b1;   //when this signal is set to 1  two functionalities should be done (i) update PC with the calculated value from the adder in ID stage (ii) FLUSH the pipeline reg 1
            BRANCH_TAKEN_WEAK:
                TAKE_BRANCH=1'b1;
            BRANCH_NOTTAKEN_WEAK:
                TAKE_BRANCH=1'b0;   //when this signal is set to 0, no problem regular operation happen in PC
            BRANCH_NOTTAKEN_STRONG:
                TAKE_BRANCH=1'b0;
        endcase   
    end
    else begin
        TAKE_BRANCH=1'b0;
    end
end



integer i;

// Making all branch decissions to BRANCH_TAKEN_STRONG State
always @(RESET) begin
    FLUSH=1'b0;
    for (i =0 ;i<8 ;i++ ) begin
        prediction[i]=2'b00;
    end
end

    
endmodule