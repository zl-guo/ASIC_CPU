//------------- non_blocking.v -------------------
module non_blocking(
    output reg  [3:0]    b,c,
    input       [3:0]    a  ,
    input                clk
);

always @(posedge clk) begin
    b <= a;
    c <= b;
    $display("Non_Blocking: a = %d, b = %d, c = %d.",a,b,c);
end

endmodule
