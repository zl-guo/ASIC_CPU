/*********************************
*  TEST BENCH FOR SCALABLE MUX   *
**********************************/
`define width 8
`timescale 1ns/1ns

module  mux_test;

reg  [`width:1] a,b;
reg             sel;

wire [`width:1] out;

scale_mux   #(`width)   
            u_scale_mux
(   
    .a          ( a      ) ,
    .b          ( b      ) ,
    .sel        ( sel    ) ,

    .out        ( out    )
);

//dump waveform
`ifdef VPD_ON
initial begin
    $vcdpluson();
end
`endif

initial begin
    $fsdbDumpfile("scale_mux.fsdb");
    $fsdbDumpvars("+all");
end


initial begin
    //  Display results to the screen, and store them in an SHM database
    $monitor($stime,,"sel=%b a=%b b=%b out=%b",sel,a,b,out);

    // Provide stimulus for the design
    sel = 1'b0;
    b   = {`width{1'b0}};
    a   = {`width{1'b1}};

    #5;
    sel = 1'b0;
    b   = {`width{1'b1}};
    a   = {`width{1'b0}};

    #5;
    sel = 1'b1;
    b   = {`width{1'b0}};
    a   = {`width{1'b1}};

    #5;
    sel = 1'b1;
    b   = {`width{1'b1}};
    a   = {`width{1'b0}};

    #5 $finish;
end

endmodule
