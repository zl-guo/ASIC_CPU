//-—-----FSMexample---------

module fsm(
    input       clk, rstn, in,
    output reg  out
);

reg [1:0] curr_state,next_state;

always @(posedge clk or posedge rstn)
    if(!rstn)  
        curr_state <= 3'd0 ;
    else 
        curr_state <= next_state;

always @(posedge clk or posedge rstn)
    if(!rstn)  
        out <= 1'b0;
    else if(curr_state == 3'd2)
        out <= 1'b1;
    else
        out <= 1'b0;

always @(*)
    case (curr_state)
        3'd0 : begin 
            next_state <= in ? 3'd1 : 3'd0; 
        end
        
        3'd1 : begin 
            next_state <= in ? 3'd2 : 3'd0; 
        end
        
        3'd2: begin 
            next_state <= in ? 3'd2 : 3'd0;
        end
        default:next_state <= 3'd0 ;
    endcase
endmodule

