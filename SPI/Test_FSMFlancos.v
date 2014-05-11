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
		
  reg [(8*12)-1:0] state_string = "?????UNKNOWN??";
  
  //Se presenta una variable con la que se puede apreciar lo que realiza la maquina
  //Esta maquina emula el diagrama de tiempos requerido para el ADC_Conv, y el SPI_CLK
  //Que necesita el adc, ademas inicialiaza registros que son utilizados como MOSI
  
  always @(uut.E_Presente)
    case (uut.E_Presente)
      3'b000 : begin
        $display("%t: STATE is now: Estado 0, No se encuentra haciendo nada", $realtime);
        state_string = "EP 0";
      end
      3'b001 : begin
        $display("%t: Estado 1, Se inicia el procedimiento", $realtime);
        state_string = "EP 1";
      end
      3'b010 : begin
        $display("%t: Estado 2, Se prosigue el procedimiento", $realtime);
        state_string = "EP 2";
      end
      3'b011 : begin
        $display("%t: Se termino el procedimiento", $realtime);
        state_string = "EP3";
      end
      3'b100 : begin
        $display("%t: Se se termina la inicializacion del amplificador", $realtime);
        state_string = "EP4";
      end
      3'b101 : begin
        if(ADC_Conv)
		  begin
			  $display("%t: ADC CONVERTIR", $realtime);
			  state_string = "EP5";
		  end
      end
      3'b110: begin
				$display("%t: ADC Not True", $realtime);
			  state_string = "EP6";
      end
      3'b111 : begin
        $display("%t: STATE is now: 7 Se ha comprobado el funcionamiento de la maquina", $realtime);
        state_string = "EP7";
      end
      default : begin
        $display("%t: ERROR: STATE is now: UNKNOWN !!!!", $realtime);
        state_string = "??UNKNOWN??";
      end       
    endcase

	initial begin
	
	//La presente exitacion de los estados es para hacer la presente maquina pasar por todos los estaods
	//necesarios, y la variables state_string es utilizada para presentar una senal
	//de tipo string que ejemplifique en que estado me encuentro.
	
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

