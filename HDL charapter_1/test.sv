`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2025 22:15:58
// Design Name: 
// Module Name: test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test();
parameter M = 5;
logic clk;
logic srst;
logic write_enable;
logic read_enable;
logic [M:0] data_i;
logic [M:0] data_o;
logic full;
logic empty;
localparam int clk_PERIOD = 10;

initial begin
    clk = 1;
    srst = 1;
    write_enable = 1;
    read_enable = 1;
    #20
    srst = 0;
    #130
    srst = 1;
    #20
    srst = 0;
    #60
    write_enable = 0;
    #50
    write_enable = 1;
    #30
    read_enable = 0;
    #190
    read_enable = 1;
    #110
    srst = 1;
    #20
    srst = 0;
end

always #(clk_PERIOD) clk = ~clk;
always_ff @(posedge clk) data_i = $random;

FIFO fifo(
    .clk(clk),
    .srst(srst),
    .write_enable(write_enable),
    .read_enable(read_enable),
    .data_i(data_i),
    .data_o(data_o),
    .empty(empty),
    .full(full)
);

endmodule
