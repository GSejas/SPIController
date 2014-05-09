`timescale 1ns / 1ps

module ShiftRegSIPOIzq(clk, rst, ena, DatIn, DatOut);

	parameter LARGO = 8;
	input clk, rst, ena, DatIn;
	output reg[LARGO-1:0]DatOut;

always @(negedge clk, posedge rst)
	if(rst)
		DatOut 	= 0;
	else if(ena)
		DatOut = {DatOut[LARGO-2:0], DatIn};
	else
		DatOut = DatOut;

endmodule
