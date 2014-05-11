`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:18:57 05/09/2014
// Design Name:   ShiftRegPISOIzq
// Module Name:   C:/Users/GSejas/SPIController/SPI/Test_RegPISO.v
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

module Test_RegPISO;

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
	
	//Se hace el procedimineto estandart, este modulos es muy basico y se excitan las entradas acordemente
	
	
	initial forever
		#10 clk = !clk;
		
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		ena = 1;
		load = 0;
		DatIn = 8'b101110010;
		#35 rst = 0;
		#35 load = 1;
		#35 load = 0;
		
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

