`include "ARF.v"

module ArchitectureRegisterFile_TB;

  reg [3:0] read_reg1, read_reg2, write_reg;
  reg write_enable;
  reg [31:0] write_data;
  wire [31:0] read_data1, read_data2;

  ArchitectureRegisterFile ARF (
	read_reg1, read_reg2, write_reg, write_enable, write_data, read_data1, read_data2
  );

  initial begin
    // Initialize inputs
    read_reg1 = 4'b0000;
    read_reg2 = 4'b0001;
    write_reg = 4'b0010;
    write_enable = 1'b1;
    write_data = 32'hABCDEFAB;

    // Perform a read operation
    #10;
    read_reg1 = 4'b0000;
    read_reg2 = 4'b0010;
    write_enable = 1'b0;
    $display("Read Data 1: %h", read_data1);
    $display("Read Data 2: %h", read_data2);

    // Perform a write operation
    #10;
    read_reg1 = 4'b0010;
    read_reg2 = 4'b0001;
    write_reg = 4'b0100;
    write_enable = 1'b1;
    write_data = 32'h12345678;
    $display("Write operation performed.");

    // Perform another read operation
    #10;
    read_reg1 = 4'b0100;
    read_reg2 = 4'b0001;
    write_enable = 1'b0;
    $display("Read Data 1: %h", read_data1);
    $display("Read Data 2: %h", read_data2);

    // Add more test cases as needed

    // End the simulation
    #10;
    $finish;
  end

endmodule

