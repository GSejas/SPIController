`timescale 1ns / 1ps

module SPISegmentoControlado(clk, rst, Init, AMP_ADC, MISO, Init_Done, SPI_CLK, MOSI, ADC_Conv, Data);

//El diagrama de este nivel se puede revisar en el siguiente link
//Link:https://www.dropbox.com/s/k5derdq2okpj7l5/Control%20SPI%20-%20ControlSPIFlancosII.jpeg

//*Entradas
//*MISO; senal del protocolo SPI, master in, slave out
//*AMP_ADC; senal proveida por la maquina principal, selecciona entre el ADC y el Amplificador
//*Init; Senal proveniente del bloque Controlador(FSMGeneralSPI), inicia el procedimiento

input clk, rst, Init, AMP_ADC, MISO;

//salidas
//*Init_Done; Senal proveniente del bloque Controlado (SPISegmentoControlado), termino el proceso de inicializacion del PreAmplificador
//*Ena_RegBuff; Habilita el registro que guarda el valor enviado por el ADC, se realiza si
//la senal externa ena esta en ALTO y si el ADC_Conv esta en ALTO
//*Cont; Valor del contador, se esperan 4 ciclos de clock para habilitar la maquina y el procedimiento
//en general
//*MOSI; senal del protocolo SPI, Master out, slave in
//*Data; Bus de datos correspondiente a los recibidos por el adc, cada vez que hay un pulso del ADC_Conv hay dato nuevo
//*SPI_CLK; senal del protocolo SPI, Clk de los dispositivos a controlar
//*CS_AMP, ADC_Conv senales de seleccion del dispositivo
//*ADC_Conv; senal que va hacia el ADC, inicia el proceso de analizacion del mismo ADC

output Init_Done, MOSI, ADC_Conv;
output [7:0] Data;
output wire SPI_CLK;

//temporales
//*EdgDone;Senal temporal que avisa el termino del ciclo de clockeo, en el diagrama de segundo nivel
//se puede apreciar como la salida del unico comparador que se tiene
//*Ena_Reg_Miso; Habilita la operacion del registro de entrada del ADC, viene de la desigualdad y el SPI_CLK_ADC
//*Ena_Reg_MOSI; Habilita la operacion del 	registro de corrimientos que necesita el Amplificador, es producto de el detector de flancos en tener de entrada a el divisor
//de frecuencia,
//*Ld_Reg_MOSI; Habilita la carga que necesita el registro MOSI, proviene de un detector de flancos
//*SPI_CLK_ADC; Salida que genera un clk, que es mas adelante dividido
//*Reg_Rst, resetea el valor del contador que cuenta los flancos para reiniciar la operacion
//*Ena_Co2; Habilita la operacion del contador2, proviene de la deteccion del flanco del divisor de frecuencia de la senal SPI_CLK_ADC
//*Val_Flancos, senal temporal que representa el numero de veces que se tiene que generar flancos
//*cuenta2; cuenta el contador2
//*cuenta 1; cuenta del contador1

wire EdgDone, Ena_Reg_MISO, Ena_Reg_MOSI, Ld_Reg_MOSI, SPI_CLK_ADC, Reg_Rst;
wire Ena_Co2;
reg [5:0]Val_Flancos;
wire [5:0]cuenta2;
wire [2:0]cuenta1;

//Maquina que genera la senal que genera flancos de reloj para el SPI por medio del SPI_CLK_ADC
//Ademas, controla el resto de dispositivos en esta seccion, que en conjunto generan las senales MISO y MOSI

FSMFLancos  FSMEdge(rst, clk, Init, EdgDone, AMP_ADC, ADC_Conv, SPI_CLK_ADC, Init_Done, Reg_Rst);

//Al generar senales con frecuencias altas, que tienen que ser utilizadas para habilitar, se necesita algo que sincronice esas senales a la frecuencia
//del sistema, para habilitar una sola vez, estos detectores de flancos cumplen con ese trabajo para la mayoria de dispositivos, como contadores y registros
//en este sistema.

DetectorFlancos EdgeLD(clk, rst, AMP_ADC, Ld_Reg_MOSI);
DetectorFlancos EdgeENA(clk, rst, cuenta1[2], Ena_Reg_MOSI);

//Contadores utilzados para mantener el numero de flancos a generar, 8 o 34, para saber cuando dejar de generar y producir
//el adc_conv y para dividir la frecuencia del SPI_CLK_ADC y que este a los parametros de los dispositivos como el ADC y el AMP

Conta3b  Cont1(Reg_Rst||rst, clk, SPI_CLK_ADC, cuenta1);
Conta6b  Cont2(Reg_Rst||rst, clk, Ena_Co2, cuenta2);

//Registros de corrimiento controlados por la MaquinaFlancos, generan la senal MISO de inicializacion y ingresan los datos enviados por el ADC//
//Unicamente se permiten que ingresen 8 bits del adc por medio de la comprarcion que viene a continuacion
//Tambien, se envia una amplificacion de 1 para inicializacion del amplificador, en los dos canales, por aquello.

ShiftRegPISOIzq Amp_Reg(clk, rst, Ena_Reg_MOSI, Ld_Reg_MOSI, 8'b00010001, MOSI);
ShiftRegSIPOIzq ADC_Reg(clk, rst, Ena_Reg_MISO, MISO, Data);

//Segun el estado de AMP_ADC, enviado por la maquina, se van a comparar para generar 34 ciclos(adc) o 8 ciclos(amp)
always @*
	if (AMP_ADC)
		Val_Flancos = 6'd34;
	else
		Val_Flancos = 6'd8;
	

// asignacion del alias de Ena_Co2 a la senal Ena_Reg_Mosi, por convecion

assign Ena_Co2 = Ena_Reg_MOSI;

//Division de la senal SPI_CLK_ADC por medio del contador2 para finalmente ser sacada al exterior como SPI_CLK

assign	SPI_CLK = cuenta1[2];
	
//Senal hacia la maquina de que se termino el procemiento actual
	
assign EdgDone = (cuenta2 ==Val_Flancos);

//Con esto se asigna el numero de bits que se pueden ingresar, 2 de estado de alta impedancia que siempre envia el ADC
//Y los primeros 8 bits del resto de lo que envia el ADC

assign Ena_Reg_MISO = (cuenta2<10)&&Ena_Reg_MOSI;
 
 
endmodule
