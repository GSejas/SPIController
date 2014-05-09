`timescale 1ns / 1ps

module SPISegmentoControlado(clk, rst, Init, AMP_ADC, MISO, Init_Done, SPI_CLK, MOSI, ADC_Conv, Data);
input clk, rst, Init, AMP_ADC, MISO;
output Init_Done, MOSI, ADC_Conv;
output [7:0] Data;
output reg SPI_CLK;
wire EdgDone, Ena_Reg_MISO, Ena_Reg_MOSI, Ld_Reg_MOSI, SPI_CLK_ADC, Reg_Rst;
reg Ena_Co2;
reg [5:0]Val_Flancos;
wire [5:0]cuenta2;
wire [2:0]cuenta1;

FSMFLancos  FSMEdge(rst, clk, Init, EdgDone, AMP_ADC, ADC_Conv, SPI_CLK_ADC, Init_Done, Reg_Rst);

DetectorFlancos EdgeLD(clk, rst, AMP_ADC, Ld_Reg_MOSI);
DetectorFlancos EdgeENA(clk, rst, cuenta1[2], Ena_Reg_MOSI);

Conta3b  Cont1(Reg_Rst||rst, clk, SPI_CLK_ADC, cuenta1);
Conta6b  Cont2(Reg_Rst||rst, clk, Ena_Co2, cuenta2);

ShiftRegPISOIzq Amp_Reg(clk, rst, Ena_Reg_MOSI, Ld_Reg_MOSI, 8'b00010001, MOSI);
ShiftRegSIPOIzq ADC_Reg(clk, rst, Ena_Reg_MISO, MISO, Data);

always @*
	if (AMP_ADC)
		Val_Flancos = 6'd34;
	else
		Val_Flancos = 6'd8;
	
always @*
	if (AMP_ADC)
		Ena_Co2 = SPI_CLK_ADC;
	else
		Ena_Co2 = Ena_Reg_MOSI;
	
always @*
	if (AMP_ADC)
		SPI_CLK = SPI_CLK_ADC;
	else
		SPI_CLK = cuenta1[2];
	
	
assign EdgDone = (cuenta2 ==Val_Flancos);
assign Ena_Reg_MISO = (cuenta2<15)&&SPI_CLK_ADC;
 
 
endmodule
