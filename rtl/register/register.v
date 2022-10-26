/*****************
* 8_bit REGISTER *
*****************/
`timescale 1ns/1ns

module  register(
    input           clk     ,
    input           rstn    ,
    input           load    ,
    input   [7:0]   wdata   ,
    output  [7:0]   out
);

wire    [7:0]   mux_out,dffr_out;

genvar  i;

//Generate for loop to instanciate 8 times
generate
    for(i = 0; i < 8; i=i+1) begin:register
        mux          mux_inst_i(
            .sel        ( load          ),
            .a          ( dffr_out[i]   ),
            .b          ( wdata[i]      ),
            .out        ( mux_out[i]    )
        );        
        
        dffr         dffr_inst_i(
            .clk        ( clk           ),
            .rstn       ( rstn          ),
            .d          ( mux_out[i]    ),
            .q          ( dffr_out[i]   ),
            .q_         (               )
        );
    end
endgenerate

assign  out = dffr_out;

endmodule
