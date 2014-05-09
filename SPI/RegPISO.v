`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:17:39 05/09/2014
// Design Name:   ShiftRegPISOIzq
// Module Name:   C:/Users/GSejas/SPIController/SPI/RegPISO.v
// Project Name:  SPI
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ShiftRegPISOIzq
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RegPISO;

	// Inputs
	reg clk;
	reg rst;
	reg ena;
	reg load;
	reg [7:0] DatIn;

	// Outputs
	wire DatOut;

	// Instantiate the Unit Under Test (UUT)
	ShiftRegPISOIzq uut (
		.clk(clk), 
		.rst(rst), 
		.ena(ena), 
		.load(load), 
		.DatIn(DatIn), 
		.DatOut(DatOut)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		ena = 0;
		load = 0;
		DatIn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

