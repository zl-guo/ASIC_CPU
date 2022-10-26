`timescale 1ns/1ns
`celldefine

module mux(
    input   sel ,
    input   b   ,
    input   a   ,
    output  out
);

not (sel_, sel       );
and (selb, sel , b   );
and (sela, sel_, a   );
or  (out , selb, sela);

endmodule
`endcelldefine
