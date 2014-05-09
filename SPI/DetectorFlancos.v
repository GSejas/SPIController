`timescale 1ns / 1ps


module DetectorFlancos(clk, rst, nivel, tick);
input clk, rst, nivel;
output tick;
reg [1:0] filter_reg;
wire [1:0] next_filter;
wire edge_c_next;
reg edge_c;


always @(posedge clk or posedge rst)
		if (rst)
			begin
				filter_reg <= 0;
				edge_c <= 0;
			end 
		else 
			begin
				filter_reg <= next_filter;
				edge_c <= edge_c_next;
			end
			
assign next_filter = {nivel,filter_reg[1]};

assign edge_c_next = (filter_reg == 2'b11) ? 1'b1 :
							(filter_reg == 2'b00) ? 1'b0 :	
							edge_c;
							
assign tick = edge_c & !edge_c_next;
endmodule
