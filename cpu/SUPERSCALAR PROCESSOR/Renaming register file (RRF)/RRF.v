module RenamingRegisterFile (
  READ_REG1, READ_REG2, WRITE_REG, WRITE_ENABLE, VALID_BIT, READ_DATA1, READ_DATA2, VALID_OUT
);

  input [3:0] READ_REG1, READ_REG2;
  input [3:0] WRITE_REG;
  input WRITE_ENABLE;
  input VALID_BIT;
  output reg [31:0] READ_DATA1, READ_DATA2;
  output reg VALID_OUT;

  reg [31:0] registers [0:15];
  reg [3:0] busy_bits [0:15];

  // Read data from register file
  always @(*)
  begin
    READ_DATA1 = registers[READ_REG1];
    READ_DATA2 = registers[READ_REG2];
    VALID_OUT = VALID_BIT;
  end

  // Write data to register file
  always @(*)
  begin
    if (WRITE_ENABLE)
    begin
      registers[WRITE_REG] <= READ_DATA1;
      busy_bits[WRITE_REG] <= 1'b1;
    end
  end

endmodule

