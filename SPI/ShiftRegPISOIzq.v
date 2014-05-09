`timescale 1ns / 1ps

module ShiftRegPISOIzq(clk, rst, ena, load, DatIn, DatOut);

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

//
//   parameter piso_shift = <shift_width>;
//   
//   reg [piso_shift-2:0] <reg_name>;
//   reg                  <output>;
//
//   always @(posedge <clock>)
//      if (<load_signal>) begin
//         <reg_name> <= <input>[piso_shift-1:1];
//         <output>    <= <input>[0];
//      end
//      else begin
//         <reg_name> <= {1'b0, <reg_name>[piso_shift-2:1]};
//         <output>   <= <reg_name>[0];
//      end
//					