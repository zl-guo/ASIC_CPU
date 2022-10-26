// 5_bit counter
`timescale 1ns/1ns

module counter  #(parameter width = 5)
(
    input                      clk   ,
    input                      rstn  ,
    input                      load  ,
    input       [width-1:0]    wdata ,
    
    output reg  [width-1:0]    cnt
);

always  @(posedge clk or negedge rstn) begin
    if(!rstn)
        cnt <=  5'd0;
    else if(load)
        cnt <=  wdata;
    else
        cnt <=  cnt + 1'b1;
end

endmodule
