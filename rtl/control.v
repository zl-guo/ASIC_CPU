/**************
* CONTROLLER *
**************/

`timescale 1ns/1ns

`define HLT 3'b000
`define SKZ 3'b001
`define ADD 3'b010
`define AND 3'b011
`define XOR 3'b100
`define LDA 3'b101
`define STO 3'b110
`define JMP 3'b111

module  control(
    input                clk     ,
    input                rstn    ,
    input                zero    ,
    input       [2:0]    opcode  ,

    output reg           rd      ,
    output reg           wr      ,
    output reg           ld_ir   ,
    output reg           ld_ac   ,
    output reg           ld_pc   ,
    output reg           inc_pc  ,
    output reg           halt    ,
    output reg           data_e  ,
    output reg           sel
);

reg [2:0] curr_state;
reg [2:0] next_state;

always @(posedge clk or negedge rstn)
    if(!rstn)
        curr_state <= 3'b000;
    else
        curr_state <= next_state;

always @(opcode or curr_state or zero) begin
    case(curr_state)
        3'b000:next_state <= 3'b001;
        3'b001:next_state <= 3'b011;
        3'b011:next_state <= 3'b010;
        3'b010:next_state <= 3'b110;
        3'b110:next_state <= 3'b111;
        3'b111:next_state <= 3'b101;
        3'b101:next_state <= 3'b100;
        3'b100:next_state <= 3'b000;
        default:next_state <= 3'b000;
    endcase
end

/**********************
********* sel ********/
wire    _sel_0 = (curr_state == 3'b000) || (curr_state == 3'b111) || (curr_state == 3'b101) || (curr_state == 3'b100);
always @(posedge clk or negedge rstn)
    if(!rstn)
        sel <= 1'b0;
    else if(_sel_0)
        sel <= 1'b0;
    else
        sel <= 1'b1;

/**********************
********* rd *********/
wire    alu_op;
assign  alu_op = (opcode == `ADD) 
               || (opcode == `AND) 
               || (opcode == `XOR) 
               || (opcode == `LDA);

wire    _rd_0 = (curr_state == 3'b001) || (curr_state == 3'b111);
wire    _rd_1 = (curr_state == 3'b011) || (curr_state == 3'b010) || (curr_state == 3'b110);
always @(posedge clk or negedge rstn)
    if(!rstn)
        rd <= alu_op;
    else if(_rd_0)
        rd <= 1'b0;
    else if(_rd_1)
        rd <= 1'b1;
    else
        rd <= alu_op;

/**********************
********* wr *********/
wire    _wr_1 = (curr_state == 3'b000) && (opcode == `STO);
always @(posedge clk or negedge rstn)
    if(!rstn)
        wr <= 1'b0;
    else if(_wr_1)
        wr <= 1'b1;
    else
        wr <= 1'b0;

/*************************
********* ld_ir *********/
wire    _ld_ir_1 = (curr_state == 3'b010) || (curr_state == 3'b110);
always @(posedge clk or negedge rstn)
    if(!rstn)
        ld_ir <= 1'b0;
    else if(_ld_ir_1)
        ld_ir <= 1'b1;
    else
        ld_ir <= 1'b0;

/*************************
********* halt *********/
wire    _halt_1 = (curr_state == 3'b111) && (opcode == `HLT);
always @(posedge clk or negedge rstn)
    if(!rstn)
        halt <= 1'b0;
    else if(_halt_1)
        halt <= 1'b1;
    else
        halt <= 1'b0;

/*************************
********* ld_pc *********/
wire    _ld_pc_1 = (((curr_state == 3'b100) && (opcode == `JMP)) || ((curr_state == 3'b000) && (opcode == `JMP)));
always @(posedge clk or negedge rstn)
    if(!rstn)
        ld_pc <= 1'b0;
    else if(_ld_pc_1)
        ld_pc <= 1'b1;
    else
        ld_pc <= 1'b0;

/*************************
********* ld_ac *********/
wire    _ld_ac_ = curr_state == 3'b000;
always @(posedge clk or negedge rstn)
    if(!rstn)
        ld_ac <= alu_op;
    else if(_ld_ac_)
        ld_ac <= alu_op;
    else
        ld_ac <= 1'b0;

/*************************
********* data_e *********/
wire    _data_e_ = ((curr_state == 3'b100) || (curr_state == 3'b000));
always @(posedge clk or negedge rstn)
    if(!rstn)
        data_e <= !alu_op;
    else if(_data_e_)
        data_e <= !alu_op;
    else
        data_e <= 1'b0;

/*************************
********* inc_pc *********/
wire    _inc_pc_1 = ((curr_state == 3'b111) || ((curr_state == 3'b100) && (opcode == `SKZ & zero)) || ((curr_state == 3'b000) && ((opcode==`SKZ & zero) || (opcode==`JMP))));
always @(posedge clk or negedge rstn)
    if(!rstn)
        inc_pc <= 1'b1;
    else if(_inc_pc_1)
        inc_pc <= 1'b1;
    else
        inc_pc <= 1'b0;

endmodule
