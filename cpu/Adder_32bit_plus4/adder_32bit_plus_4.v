`timescale  1ns/100ps

module adder_32bit_plus_4(IN1, OUT);

    //declare ports
    input [31:0] IN1;
    output [31:0] OUT;

    //add the input values and assign to output
    //TODO: adding a delay
    //added 1 unit delay
    assign #1 OUT = IN1 + 32'd4;

endmodule
