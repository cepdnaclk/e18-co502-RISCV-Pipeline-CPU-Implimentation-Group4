`include "RRF.v"

module RenamingRegisterFile_TB;

  reg [3:0] read_reg1, read_reg2, write_reg;
  reg write_enable, valid_bit;
  wire [31:0] read_data1, read_data2;
  wire valid_out;

  RenamingRegisterFile RRF (
    read_reg1, read_reg2, write_reg, write_enable, valid_bit, read_data1, read_data2, valid_out
  );

  initial begin
    // Initialize inputs
    read_reg1 = 4'b0000;
    read_reg2 = 4'b0001;
    write_reg = 4'b0010;
    write_enable = 1'b1;
    valid_bit = 1'b1;

    // Perform a read operation
    #10;
    read_reg1 = 4'b0000;
    read_reg2 = 4'b0010;
    write_enable = 1'b0;
    valid_bit = 1'b1;
    $display("Read Data 1: %h, Valid: %b", read_data1, valid_out);
    $display("Read Data 2: %h, Valid: %b", read_data2, valid_out);

    // Perform a write operation
    #10;
    read_reg1 = 4'b0010;
    read_reg2 = 4'b0001;
    write_reg = 4'b0100;
    write_enable = 1'b1;
    valid_bit = 1'b1;
    $display("Write operation performed.");

    // Perform another read operation
    #10;
    read_reg1 = 4'b0100;
    read_reg2 = 4'b0001;
    write_enable = 1'b0;
    valid_bit = 1'b1;
    $display("Read Data 1: %h, Valid: %b", read_data1, valid_out);
    $display("Read Data 2: %h, Valid: %b", read_data2, valid_out);

    // Add more test cases as needed

    // End the simulation
    #10;
    $finish;
  end

endmodule

