`timescale 1ns/100ps

module compareTop;

wire [3:0]  b1,c1,b2,c2;
reg  [3:0]  a;
reg         clk;

//Dump waveform
`ifdef VPD_ON
initial begin
    $vcdpluson();
end
`endif

initial begin
    $fsdbDumpfile("compareTop.fsdb");
    $fsdbDumpvars("+all");
end

initial begin
    clk = 0;
    forever #50 clk = ~clk;
end

initial begin
    $dumpvars(2,compareTop);
end

initial begin
    a = 4'h3;
    $display("_____________________________________");
   
    # 100 a = 4'h7;
    $display("_____________________________________");
   
    # 100 a = 4'hf;
    $display("_____________________________________");
   
    # 100 a = 4'ha;
    $display("_____________________________________");
   
    # 100 a = 4'h2;
    $display("_____________________________________");
   
    # 100; 
    $display("_____________________________________");
    
    $finish;
end

non_blocking    u_non_blocking(b2,c2,a,clk);

blocking        u_blocking(b1,c1,a,clk);

endmodule
