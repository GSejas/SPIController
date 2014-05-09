`timescale 1ns / 1ps

module ShiftRegPISOIzq(clk, rst, ena, DatIn, DatOut);

parameter LARGO = 8;
input clk, rst, ena;
input [LARGO-1:0]DatIn;
output DatOut;
always @(negedge clk, posedge rst)
	if(rst)
		DatOut 	= 0;
	else if(ena)
		DatOut = {DatOut[LARGO-2:0], DatIn};
	else
		DatOut = DatOut;

endmodule
