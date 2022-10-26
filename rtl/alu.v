`timescale 1ns/100ps
module alu(
    input   [7:0]       data    ,
    input   [7:0]       accum   ,
    input   [2:0]       opcode  ,
    output              zero    ,
    output reg  [7:0]   out
);

parameter   PASS0   =  3'b000,  
            PASS1   =  3'b001, 
            ADD     =  3'b010,     
            AND     =  3'b011,     
            XOR     =  3'b100,     
            PASSD   =  3'b101, 
            PASS6   =  3'b110, 
            PASS7   =  3'b111; 
always  @(data or accum or opcode)
begin
    case(opcode)
        PASS0:  out = #3 accum       ;
        PASS1:  out = #3 accum       ;
        ADD  :  out = #3 data + accum;
        AND  :  out = #3 data & accum;
        XOR  :  out = #3 data ^ accum;    
        PASSD:  out = #3 data        ;
        PASS6:  out = #3 accum       ;
        PASS7:  out = #3 accum       ;
        default:out = #3 accum       ;
    endcase
end

assign  #1 zero = (accum == 8'b0) ? 1'b1 : 1'b0;

endmodule
