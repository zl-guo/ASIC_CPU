`timescale 1ns/1ns

module  counter_test;

wire [4:0] cnt;
reg  [4:0] wdata;
reg  clk,rstn,load;

counter     u_counter(
    .clk        (clk     ),
    .rstn       (rstn    ),
    .load       (load    ),
    .wdata      (wdata   ),
    .cnt        (cnt     )
);

//dump waveform
`ifdef VPD_ON
initial begin
    $vcdpluson();
end
`endif

initial begin
    $fsdbDumpfile("counter_test.fsdb");
    $fsdbDumpvars("+all");
end

initial begin
    clk = 1'b0;
    forever begin
        #10 clk = ~clk;
    end
end

initial begin
    $timeformat(-9, 1, "ns ", 9);
    $monitor("time = %t, wdata = %h, clk = %b, rstn = %b, load = %b, cnt = %b", $stime, wdata, clk, rstn, load, cnt);
    $dumpvars(2,counter_test);
end

task expect;
    input [4:0] expects;
    if(cnt !== expects) begin
        $display( "At time %t cnt is %b and should be %b", $stime,cnt,expects);
        $display( "TEST FAILED" );
        $finish;
    end
endtask

initial begin
//SYNCHRONIZE INTERFACE TO INACTIVE CLOCK EDGE
    @(negedge clk)
    //RESET
    {rstn,load,wdata} = 7'b0_X_XXXXX; @(negedge clk) expect(5'h00);
    //LOAD 1D
    {rstn,load,wdata} = 7'b1_1_11101; @(negedge clk) expect(5'h1D);
    //COUNT +5
    {rstn,load,wdata} = 7'b1_0_11101; 
    repeat(5) @(negedge clk);
    expect(5'h02);
    //LOAD 1F
    {rstn,load,wdata} = 7'b1_1_11111; @(negedge clk) expect(5'h1F);
    //RESET
    {rstn,load,wdata} = 7'b0_X_XXXXX; @(negedge clk) expect(5'h00);
    $display("TEST PASSED");
    $finish;
end

endmodule


