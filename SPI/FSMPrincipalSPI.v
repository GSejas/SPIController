`timescale 1ns / 1ps


module FSMPrincipalSPI(clk, rst, Go, Init_Done, AMP_ADC, Init);

//El funcionamiento de esta maquina es el de proveer una secuencia clara
//para la inicializacion del Amplificador, por medio de AMP_ADC(CS_AMP)
//y la seleccion del ADC
//El diagrama la maquina se puede encontrar en el siguiente link
//Link:https://www.dropbox.com/s/sutwd80sce0b2p9/Control%20SPI%20-%20MaquinaSPIGeneral.jpeg

input clk, rst, Init_Done, Go;
output AMP_ADC, Init;

//Declaracion de las entradas
parameter[1:0] 
	S0 = 2'b00,
	S1 = 2'b01,
	S2 = 2'b10,
	S3 = 2'b11;
//Parametros locales utilizados para no tener que usar siempre la notacion binaria, y que
//y para permiti


reg [1:0] E_Presente, E_Siguiente;

//Combinacional de Salida
assign AMP_ADC = !(E_Presente == S1);
assign Init = (E_Presente == S1)||(E_Presente == S3);


//Logica de la Maquina
always @(posedge clk, posedge rst)
	
	if (rst)
		E_Presente <= S0;
	else
		E_Presente <= E_Siguiente;


//Diagrama de Estados, descrito en el diagrama presentado en conjunto con el proyecto
always @*
	begin
		case (E_Presente)
		
			S0: begin
					if(Go)
						E_Siguiente <= S0;
					else
						E_Siguiente <= S1;						
				end
				
			S1: begin	
					if (Init_Done)
						E_Siguiente <= S2;
					else
						E_Siguiente <= S1;
				 end
				 
			S2: begin
					E_Siguiente <= S3;
				  end
				  
			S3: begin
					E_Siguiente <= S3;
				end
		endcase
	end


endmodule
