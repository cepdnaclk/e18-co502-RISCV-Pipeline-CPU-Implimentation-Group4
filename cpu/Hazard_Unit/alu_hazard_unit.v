// Advanced Computer Architecture (CO502)
// Design: ALU Hazard Unit
// Group Number: 4
// E Numbers: E/18/077, E/18/397, E/18/402
// Names: Nipun Dharmarathne, Shamod Wijerathne, Chatura Wimalasiri

`timescale  1ns/100ps

module alu_hazard_unit (
    clk,
    reset,
    rd_address_mem_stage,
    rd_address_alu_stage,
    rs1_address_id_stage,
    rs2_address_id_stage,
    forward_from_mem_stage_to_rs1_signal,
    forward_from_mem_stage_to_rs2_signal,
    forward_from_wb_stage_to_rs1_signal,
    forward_from_wb_stage_to_rs2_signal
);
    
    //port declaration
    input clk,reset;
    input [4:0] rd_address_mem_stage, rd_address_alu_stage, rs1_address_id_stage, rs2_address_id_stage;
    output reg forward_from_mem_stage_to_rs1_signal, forward_from_mem_stage_to_rs2_signal, forward_from_wb_stage_to_rs1_signal, forward_from_wb_stage_to_rs2_signal;

    wire [4:0] rdAlu_rs1Id_xnor_wire,rdAlu_rs2Id_xnor_wire,rdMem_rs1Id_xnor_wire,rdMem_rs2Id_xnor_wire;
    wire rdAlu_rs1Id_compare,rdAlu_rs2Id_compare,rdMem_rs1Id_compare,rdMem_rs2Id_compare;

    // identify hazards
    // compare destination address of alu stage with sourse register address of id stage
    assign #1 rdAlu_rs1Id_xnor_wire=(rd_address_alu_stage~^rs1_address_id_stage);    //bitwise xnor
    assign #1 rdAlu_rs2Id_xnor_wire=(rd_address_alu_stage~^rs2_address_id_stage);    //bitwise xnor
    assign #1 rdAlu_rs1Id_compare= (&rdAlu_rs1Id_xnor_wire);                         
    assign #1 rdAlu_rs2Id_compare= (&rdAlu_rs2Id_xnor_wire);                         

    // identify hazards
    // compare destination address of mem stage and sourse register address of id stage
    assign #1 rdMem_rs1Id_xnor_wire=(rd_address_mem_stage~^rs1_address_id_stage);    //bitwise xnor
    assign #1 rdMem_rs2Id_xnor_wire=(rd_address_mem_stage~^rs2_address_id_stage);    //bitwise xnor
    assign #1 rdMem_rs1Id_compare= (&rdMem_rs1Id_xnor_wire);                            
    assign #1 rdMem_rs2Id_compare= (&rdMem_rs2Id_xnor_wire);                            

    always @(posedge clk) begin
        #1  // combinational logic delay
        //setting the signals
        forward_from_mem_stage_to_rs1_signal=rdAlu_rs1Id_compare;
        forward_from_mem_stage_to_rs2_signal=rdAlu_rs2Id_compare;
        forward_from_wb_stage_to_rs1_signal=rdMem_rs1Id_compare;
        forward_from_wb_stage_to_rs2_signal=rdMem_rs2Id_compare;
    end

    always @(reset) begin
        if(reset==1'b1) begin
            #1  //reset for delay
            //reset all signals to zero
            forward_from_mem_stage_to_rs1_signal=1'b0;
            forward_from_mem_stage_to_rs2_signal=1'b0;
            forward_from_wb_stage_to_rs1_signal=1'b0;
            forward_from_wb_stage_to_rs2_signal=1'b0;	                        
        end
    end
endmodule