
#include "ws2812.h" 

void ctrl_bit (
  out_t *y,
  ap_uint<1> x
  ) {

  int i;
  if(x){
	  loop_1: for (i=0;i< TBIT;i++) {
		  *y = 0;
		  if (i<T1H) {
			  *y = 1;
		  }
	  }

	  //loop1H: for (i=0;i< T1H;i++) {
		//  *y = 1;
	  //}
	  //loop1L: for (i=0;i< TBIT-T1H;i++) {
		//  *y = 0;
	  //}
  }
  else{
	  loop_0: for (i=0;i< TBIT;i++) {
		  *y = 0;
		  if (i<T0H) {
			  *y = 1;
		  }
	  }

	  //loop0H: for (i=0;i< T0H;i++) {
	//	  *y = 1;
	 // }
	  //loop0L: for (i=0;i< TBIT-T0H;i++) {
	//	  *y = 0;
	 // }
  }
}
void reset (
  out_t *y
  ) {
	 int i;
	 loopRESET: for (i=0;i< TRESET;i++) {
		*y = 0;
	 }
}



void ws2812(
  mystream_t &A,
  out_t *y
){
#pragma HLS INTERFACE ap_none port=y
#pragma HLS INTERFACE axis register both port=A
#pragma HLS INTERFACE ap_ctrl_hs port=return


static int cont_col =1; //si es par o impar // para recorrer despues los bits de forma creciente o decreciente dependiendo
ap_uint<1> tlast;
last_loop: do{
	  axicol_t stream = A.read();
	  datacol_t columna = stream.data;
	  tlast = stream.last;
	  ap_uint<1> bit;
	  int i;
	  int j;
	  led_t led;

	  column_loop: for ( i = 0; i < 8; i++)
	  {
		if(!(cont_col%2==0)){

			led=columna.range(31,0);
			columna = columna >> 32;
		}
		else{
			led=columna.range(255,255-31);
			columna = columna << 32;
		}

		led_loop: for ( j = 0; j < 24; j++)
		{
		  bit = led[23-j];
		  ctrl_bit(y, bit);
		}


	  }
	  cont_col++;

} while(!(tlast));

reset(y);


}
  // A.read() (256BITS) & 0XFFFFFFFF (Nos quedamos con 32 y desplazamos 32 bits) >>
  // con cada paquete de 32 los enviamos mediante un bucle para que ejecute 
  // el protocolo led.range[0] y una vez se haya transmitido todos los leds enviamos RESET
  // Al final se escribe en la salida de un bit
  // https://github.com/Xilinx/Vitis-HLS-Introductory-Examples/blob/master/Interface/Streaming/using_axi_stream_with_struct/example.cpp





