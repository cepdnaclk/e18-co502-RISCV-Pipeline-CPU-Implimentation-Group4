module ArchitectureRegisterFile (
  READ_REG1, READ_REG2, WRITE_REG, WRITE_ENABLE, WRITE_DATA, READ_DATA1, READ_DATA2
);
  
  input [3:0] READ_REG1, READ_REG2, WRITE_REG;
  input WRITE_ENABLE;
  input [31:0] WRITE_DATA;
  output reg [31:0] READ_DATA1, READ_DATA2;
  
  reg [31:0] registers [0:15];
  reg [3:0] tags [0:15];
  reg [0:15] busy_bits;

  // Read data from register file
  always @(*)
  begin
    READ_DATA1 = registers[READ_REG1];
    READ_DATA2 = registers[READ_REG2];
  end

  // Write data to register file
  always @(*)
  begin
    if (WRITE_ENABLE)
    begin
      registers[WRITE_REG] <= WRITE_DATA;
      tags[WRITE_REG] <= WRITE_REG;
      busy_bits[WRITE_REG] <= 0;
    end
  end

endmodule

