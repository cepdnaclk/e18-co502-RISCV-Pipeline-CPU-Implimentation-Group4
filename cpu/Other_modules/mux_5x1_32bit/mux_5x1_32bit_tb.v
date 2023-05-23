`include "mux_5x1_32bit.v"
module mux_5x1_32bit_tb;

reg [31:0] IN0, IN1, IN2, IN3, IN4;
reg [2:0] SELECT;

wire [31:0] OUT;

mux_5x1_32bit mux(IN0, IN1, IN2, IN3, IN4, OUT, SELECT);

initial begin
    $monitor("Time :%t\tIN0 : %h\tIN1 : %h\tIN2 : %h\tIN3 : %h\tIN4 : %h\tSELECT : %b\tOUT : %h", $time,IN0, IN1, IN2, IN3, IN4, SELECT, OUT);

    IN0 = 32'h00000000;
    IN1 = 32'h00000001;
    IN2 = 32'h00000010;
    IN3 = 32'h00000011;
    IN4 = 32'h00000100;
    SELECT = 3'b000;
    #1;
    SELECT = 3'b001;
    #1;
    SELECT = 3'b010;
    #1;
    SELECT = 3'b011;
    #1;
    SELECT = 3'b100;
    #1;
    SELECT = 3'bxxx;
end

endmodule
