/*********************************
* 2_TO_1 N_BIT WIDE SCALABLE MUX *
**********************************/
`timescale 1ns/1ns

module  scale_mux
#(
    parameter       size    =   1)
(
    input   wire [size-1:0] a   ,
    input   wire [size-1:0] b   ,
    input   wire            sel ,

    output  wire [size-1:0] out
);

assign  out = (!sel) ? a :
                        (sel) ? b :
                        {size{1'bx}};

endmodule
