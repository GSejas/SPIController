`timescale 1ns / 1ps


module Test_FSMFlancos;

	// Inputs
	reg rst;
	reg clk;
	reg Init;
	reg EdgDone;
	reg AMP_ADC;

	// Outputs
	wire ADC_Conv;
	wire SPI_CLK;
	wire Init_Done;
	wire Reg_Rst;

	// Instantiate the Unit Under Test (UUT)
	FSMFLancos uut (
		.rst(rst), 
		.clk(clk), 
		.Init(Init), 
		.EdgDone(EdgDone), 
		.AMP_ADC(AMP_ADC), 
		.ADC_Conv(ADC_Conv), 
		.SPI_CLK(SPI_CLK), 
		.Init_Done(Init_Done), 
		.Reg_Rst(Reg_Rst)
	);

	
	initial forever
		#10 clk = !clk;
		

//always @*
//	begin
//		if(EdgDone)
//			AMP_ADC = 1;
//			Init = 0;
//			#20;
//			Init = 1;
//	end

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;
		Init = 0;
		EdgDone = 0;
		//Inicializacion del AMP
		AMP_ADC = 0;
		#20 rst = 0;
		AMP_ADC = 1;
		#20 AMP_ADC = 0;
		Init = 1;
		#50 Init = 0;
		//Se va por el lado de la inicializacion del ADC
		#70  EdgDone = 1;
		#60 Init = 1;
		AMP_ADC = 1;
		
		
		
		end
      
endmodule

