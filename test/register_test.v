/********************************
* TEST BENCH FOR 8_BIT REGISTER *
********************************/

`timescale  1ns/1ns

module  register_test;

wire [7:0]  out     ;
reg  [7:0]  wdata   ;
reg         load    ;
reg         rstn    ;
reg         clk     ;

register    u_register(
    .clk        (clk    ) ,
    .rstn       (rstn   ) ,
    .load       (load   ) ,
    .wdata      (wdata  ) ,
    .out        (out    )
);

initial begin
    clk = 1'b0;
    forever begin
        #10 clk = ~clk;
    end
end

//Dump waveform
`ifdef VPD_ON
initial begin
    $vcdpluson();
end
`endif

initial begin
    $fsdbDumpfile("register_test.fsdb");
    $fsdbDumpvars("+all");
end

//Monitor signals
initial begin
    $timeformat(-9, 1, "ns ", 9);
    $monitor("time = %t, wdata = %h, clk = %b, rstn = %b, load = %b, out = %h", $stime, wdata, clk, rstn, load, out);
    $dumpvars(2,register_test);
end

//Apply stimulus
initial begin
    /*To prevent clock/data races, ensure that you do not transition the stimulus on the active(positive)edge of the clock*/
    @(negedge clk)  //Initialize signals
        rstn    =   1'b0;
        wdata   =   8'b0;
        load    =   1'b0;

    @(negedge clk)  //Release reset
        rstn    =   1'b1;

    @(negedge clk)  //Load hex 55
        wdata   =   8'h55;
        load    =   1'b1;

    @(negedge clk)  //Load hex a5
        wdata   =   8'ha5;
        load    =   1'b1;

    @(negedge clk)  //Load hex 66
        wdata   =   8'h66;
        load    =   1'b1;

    @(negedge clk)  //Load hex 88
        wdata   =   8'h88;
        load    =   1'b1;

    @(negedge clk)  //Load hex ff
        wdata   =   8'hff;
        load    =   1'b1;

    @(negedge clk)  //Disable load but register
        wdata   =   8'hcc;
        load    =   1'b1;

    @(negedge clk)  //Terminate simulation
        $finish;
end
endmodule
