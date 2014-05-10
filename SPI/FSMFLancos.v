`timescale 1ns / 1ps

module FSMFLancos(rst, clk, Init, EdgDone, AMP_ADC, ADC_Conv, SPI_CLK, Init_Done, Reg_Rst);

input rst,clk, Init, EdgDone, AMP_ADC;
output ADC_Conv, SPI_CLK, Init_Done, Reg_Rst;

parameter[2:0] 

	S0 = 3'b000,
	S1 = 3'b001,
	S2 = 3'b010,
	S3 = 3'b011,
	S4 = 3'b100,
	S5 = 3'b101,
	S6 = 3'b110,
	S7 = 3'b111;


reg [2:0] E_Presente, E_Siguiente;

//Logica Combinacional de entrada a la secuencial.

assign ADC_Conv = (E_Presente == S5);
assign SPI_CLK = (E_Presente == S1);
//assign Init_Done = (E_Presente == S4)||(E_Siguiente == S4);
assign Init_Done = (E_Presente == S4)||(E_Presente==S7);
assign Reg_Rst = (E_Presente == S3);

//Logica Secuencial de la Maquina
always @(posedge clk, posedge rst)
	if (rst)
		E_Presente <= S0;
	else
		E_Presente <= E_Siguiente;
	
always @*
	begin
		case (E_Presente)
			S0: begin
					if (Init)
						E_Siguiente <= S1;
					else
						E_Siguiente <= S0;
				end
			S1: begin
					E_Siguiente <= S2;
				end
			S2: begin
					if (EdgDone)
							E_Siguiente <= S3;
					else
							E_Siguiente <= S1;
				end
			S3: begin
					if (AMP_ADC)
							E_Siguiente <= S5;
					else
							E_Siguiente <= S4;
				 end
			S4: begin
					E_Siguiente <= S7;
				end
			S5: begin
					E_Siguiente <= S6;
				end
			S6: begin
					E_Siguiente <= S1;
				end
			S7: begin
					E_Siguiente <= S0;
				end
		endcase
	end


endmodule
