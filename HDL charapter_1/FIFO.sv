`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2025 22:00:39
// Design Name: 
// Module Name: FIFO
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


module FIFO #(parameter M = 5, parameter fifo_DEPTH = 8)(
    input logic clk,
    input logic srst,
    input logic write_enable,
    input logic read_enable,
    input logic [M:0] data_i,
    output logic [M:0] data_o,
    output logic full,
    output logic empty
);
(* ram_style = "block" *) logic [M:0] fifo [fifo_DEPTH-1:0];

logic [fifo_DEPTH/2 - 1:0] write_point = 0;         // указатель записи
logic [fifo_DEPTH/2 - 1:0] read_point = 0;          // указатель чтения
logic [fifo_DEPTH/2 - 1:0] count = 0;                 // счетчик элементов
logic empty_reg, full_reg;  

always_ff @(posedge clk) begin
    if (srst) begin
        write_point <= '0;
        read_point <= '0;
        count <= '0;
        full_reg <= '0;
        empty_reg <= '1;
    end else begin
        if (write_enable && !full_reg) begin
           fifo[write_point] <= data_i;
            write_point <= write_point + 1;
            count <= count + 1;
            empty_reg <= 0;
            if (count == fifo_DEPTH - 1)
                full_reg <= '1;
        end
        if (read_enable && !empty_reg) begin
           data_o <= fifo[read_point];
           read_point <= read_point + 1;
           count <= count - 1;
           full_reg <= 0;
           if (count == '0)
               empty_reg <= '1;
       end
   end
end

assign empty = empty_reg;
assign full = full_reg;

endmodule
