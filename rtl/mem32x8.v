/***************
* 32X8 MEMORY *
***************/

`timescale 1ns/1ns

module  mem32x8(
    inout [7:0] data ,

    input [4:0] addr ,

    input       read ,
    input       write
);

reg [7:0] memory [0:31];

always @(posedge write) begin
   memory[addr] = data;
end

assign data = (read) ? memory[addr] : 8'bZ;

endmodule
