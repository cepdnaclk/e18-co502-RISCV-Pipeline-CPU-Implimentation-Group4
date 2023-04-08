`include "adder_32bit_plus_4.v"
module adder_32bit_plus_4_tb;

reg [31:0] IN1;
wire [31:0] OUT;

adder_32bit_plus_4 adder(IN1, OUT);

initial begin
    IN1 = 32'd10;
	#10;
	$display("IN1 : %d\tOUT : %d",IN1, OUT);
	IN1 = 32'd128;
	#10;
	$display("IN1 : %d\tOUT : %d",IN1, OUT);
	
end

endmodule