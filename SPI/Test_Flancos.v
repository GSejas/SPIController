`timescale 1ns / 1ps

module Test_Flancos;

	// Inputs
	reg clk;
	reg rst;
	reg nivel;

	// Outputs
	wire tick;

	// Instantiate the Unit Under Test (UUT)
	DetectorFlancos uut (
		.clk(clk), 
		.rst(rst), 
		.nivel(nivel), 
		.tick(tick)
	);

	initial forever
		#10 clk = !clk;
	
	//Se hace que la senal nivel cambie asincronamente por un tiempo indefinido para acabar con las
	//posibilidades de fallos.
	
	initial forever
		#81 nivel = !nivel;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		nivel = 0;
		#30 rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

