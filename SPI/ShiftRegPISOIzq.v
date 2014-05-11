`timescale 1ns / 1ps

module ShiftRegPISOIzq(clk, rst, ena, load, DatIn, DatOut);

//Registro de corrimientos Parallel in, Serial Out
//Se tiene que acertar un Load, para cargar el valor a correrse,
//este guardado en tmp, de ahi en adelante se va a correr hacia la izquierda


parameter LARGO = 8;
input clk, rst, ena, load;
input [LARGO-1:0]DatIn;
output reg DatOut;
reg [LARGO-2:0]tmp;
	
	always @(negedge clk, posedge rst)

		if(rst)
			DatOut 	<= 0;
		else if (load)
			begin
				tmp <= DatIn[LARGO-2:0];
				DatOut <= DatIn[LARGO-1];
			end
		else if(ena)
			begin
				tmp <= {tmp[LARGO-3:0],1'b0};
				DatOut <= tmp[LARGO-2];
			end
		else
			DatOut <= DatOut;
	
endmodule
		