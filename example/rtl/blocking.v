// ------------- blocking.v ---------------
module blocking(
    output reg  [3:0]   b,c,
    input       [3:0]   a  ,
    input               clk
);

//always @(posedge clk)
//begin
//    b = a;
//    c = b;
//    $display("Blocking:     a = %d, b = %d, c = %d.",a,b,c);
//end

always @(posedge clk)
begin
    b = a;
end

always @(posedge clk)
begin
    c = b;
end

endmodule
