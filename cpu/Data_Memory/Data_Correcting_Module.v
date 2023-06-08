`timescale  1ns/100ps

module Data_Correcting_Module (
    FUNC3,
    FROM_DATA_MEM,
    DATA_OUT,
    TO_DATA_MEM,
    DATA2
);


input [2:0] FUNC3;
input [31:0] FROM_DATA_MEM,DATA2;
output reg [31:0] DATA_OUT,TO_DATA_MEM;
wire [31:0] lb,lbu,lh,lhu,sh,sb;


assign lb ={{24{FROM_DATA_MEM[7]}},FROM_DATA_MEM[7:0]};
assign lbu ={{24{1'b0}},FROM_DATA_MEM[7:0]};
assign lh ={{16{FROM_DATA_MEM[15]}},FROM_DATA_MEM[15:0]};
assign lhu ={{16{1'b0}},FROM_DATA_MEM[15:0]};


assign sb ={{24{1'b0}},DATA2[7:0]};
assign sh ={{16{1'b0}},DATA2[15:0]};

always @(*) begin
    case(FUNC3)
        // Byte
        3'b000:begin
            DATA_OUT<=lb;
        end
        // HAlf word
        3'b001:begin
            DATA_OUT<=lh;
        end

        3'b010:begin
            DATA_OUT<=FROM_DATA_MEM;
        end
        // Byte unsignned
        3'b100:begin
            DATA_OUT<=lbu;
        end
        // Half word unsignned
        3'b101:begin
            DATA_OUT<=lhu;
        end
    endcase
end

always @(*)begin
    case(FUNC3)
        // Byte
        3'b000: begin    
            TO_DATA_MEM <= sb;
        end
        // Half Word
        3'b001: begin   
            TO_DATA_MEM <= sh;
        end
        3'b010:begin      
            TO_DATA_MEM <= DATA2;
        end
        endcase
end


endmodule