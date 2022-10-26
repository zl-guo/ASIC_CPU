`timescale 1ns/1ns

module fsm_test;

wire   out;
reg    clk,rstn,in;

//Dump waveform
`ifdef VPD_ON
initial begin
    $vcdpluson();
end
`endif

initial begin
    $fsdbDumpfile("fsm.fsdb");
    $fsdbDumpvars("+all");
end

initial begin
    clk = 0;
    forever #50 clk = ~clk;
end

initial begin
    $dumpvars(2,fsm);
end

initial begin
    $display("    TIME       IN       OUT");
    $timeformat(-9, 1, "ns", 9);
    $display("____________________________");

    in = 1'b0;
    $display("%t       %b       %b", $time, in, out);
    $display("____________________________");
   
    # 100  in = 1'b1;
    $display("%t       %b       %b", $time, in, out);
    $display("____________________________");
   
    # 100  in = 1'b1;
    $display("%t       %b       %b", $time, in, out);
    $display("____________________________");
   
    # 100  in = 1'b1;
    $display("%t       %b       %b", $time, in, out);
    $display("____________________________");
   
    # 100  in = 1'b0;
    $display("%t       %b       %b", $time, in, out);
    $display("____________________________");
   
    # 200; 
    $display("%t       %b       %b", $time, in, out);
    $display("____________________________");
    
    $finish;
end

fsm u_fsm(clk,rstn,in,out);

endmodule
