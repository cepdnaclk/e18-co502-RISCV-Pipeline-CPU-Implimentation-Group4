// Advanced Computer Architecture (CO502)
// Design: Load Use Hazard Unit
// Group Number: 4
// E Numbers: E/18/077, E/18/397, E/18/402
// Names: Nipun Dharmarathne, Shamod Wijerathne, Chatura Wimalasiri

`timescale  1ns/100ps

module load_use_hazard_unit (
    clk,
    reset,
    load_signal,
    rd_mem_stage,
    rs1_alu_stage,
    rs2_alu_stage,
    forward_from_wb_stage_to_rs1,
    forward_from_wb_stage_to_rs2,
    bubble_enable
);

    //port declaration
    input clk,reset,load_signal;
    input [4:0] rd_mem_stage,IFstage_Rs1,IFstage_Rs2,rs1_alu_stage,rs2_alu_stage;
    output reg forward_from_wb_stage_to_rs1,forward_from_wb_stage_to_rs2,bubble_enable;

    wire [4:0] alu_rs1_xnor_wire,alu_rs2_xnor_wire;
    wire alu_rs1comparing,alu_rs2comparing,buble;

    //identify hazards
    //compare sourse registers with destination registers
    assign #1 alu_rs1_xnor_wire=(rd_mem_stage~^rs1_alu_stage);   //bitwise xnor
    assign #1 alu_rs2_xnor_wire=(rd_mem_stage~^rs2_alu_stage);   //bitwise xnor
    assign #1 alu_rs1comparing= (&alu_rs1_xnor_wire);          
    assign #1 alu_rs2comparing= (&alu_rs2_xnor_wire);          
    assign #1 buble=alu_rs1comparing | alu_rs2comparing;   //adding bubbles

    always @(posedge clk) begin
        #1  //combinational logic delay
        //setting the signals
        if (load_signal) begin
            forward_from_wb_stage_to_rs1=alu_rs1comparing;
            forward_from_wb_stage_to_rs2=alu_rs2comparing;
            bubble_enable=buble;
        end
        else begin
            forward_from_wb_stage_to_rs1=1'b0;
            forward_from_wb_stage_to_rs2=1'b0;
            bubble_enable=1'b0;    
        end
    end

    always @(reset) begin
        if (reset) begin
            //reset all signals to zero
            forward_from_wb_stage_to_rs1=1'b0;
            forward_from_wb_stage_to_rs2=1'b0;
            bubble_enable=1'b0;
        end
    end
endmodule