`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:06:18 05/09/2014
// Design Name:   ShiftRegSIPOIzq
// Module Name:   C:/Users/GSejas/SPIController/SPI/RegSIPO.v
// Project Name:  SPI
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ShiftRegSIPOIzq
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_RegSIPO;

	// Inputs
	reg clk;
	reg rst;
	reg ena;
	reg DatIn;

	// Outputs
	wire [7:0] DatOut;

	// Instantiate the Unit Under Test (UUT)
	ShiftRegSIPOIzq uut (
		.clk(clk), 
		.rst(rst), 
		.ena(ena), 
		.DatIn(DatIn), 
		.DatOut(DatOut)
	);

	initial forever
		#10 clk = !clk;
		
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		ena = 1;
		//DatIn = 8'b01011001;
		DatIn = 0;
		#40 rst = 0;
		#21 DatIn = 0;
		#21 DatIn = 1;
		#21 DatIn = 0;
		#21 DatIn = 1;
		#21 DatIn = 1;
		#21 DatIn = 0;
		#21 DatIn = 0;
		#21 DatIn = 1;
		#21 DatIn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

