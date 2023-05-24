#include "ap_axi_sdata.h"
#include "hls_stream.h" 
#define T 0.00000001
#define T1H 85
#define T0H 40
#define TBIT 125
#define TRESET 5000

typedef ap_axiu<256, 1, 1, 1> axicol_t;
typedef hls::stream<axicol_t> mystream_t;
typedef ap_uint<32> led_t;
typedef ap_uint<256> datacol_t;
typedef ap_uint<1> out_t;


extern void ws2812(mystream_t &A, out_t* y);
