`timescale  1ns/100ps

module mux_5x1_32bit(IN0, IN1, IN2, IN3, IN4, OUT, SELECT);

    //declare the ports
    input [31:0] IN0, IN1, IN2, IN3, IN4;
    input [2:0] SELECT;
    output reg [31:0] OUT;

    //connect the relevent input to the output depending depending on the select
    // TODO: Add delay to mux

    always @ (*) begin
        case (SELECT)
			3'b100: OUT = IN4;
            3'b011: OUT = IN3;
            3'b010: OUT = IN2;
            3'b001: OUT = IN1;
            default: OUT = IN0;
        endcase
    end

endmodule
