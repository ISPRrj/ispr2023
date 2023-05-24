
#include "ws2812.h"

int main () {
  axicol_t col;
  ap_uint<256> data;
  data.range(63,0) = 0x0077777700888888;
  data.range(63+1*64,0+1*64) = 0x0055555500666666;
  data.range(63+2*64,0+2*64) = 0x0033333300444444;
  data.range(63+3*64,0+3*64) = 0x0011111100222222;
  col.data = data;
  col.keep = 0xffffffff;
  col.strb = 0xffffffff;
  col.last = 0;

  //col.data.range()
/*
  ap_uint<D>       data;
  ap_uint<(D+7)/8> keep;
  ap_uint<(D+7)/8> strb;
  ap_uint<U>       user;
  ap_uint<1>       last;
  ap_uint<TI>      id;
  ap_uint<TD>      dest;
*/
  mystream_t A;
  out_t y;

  A.write(col);
  col.last = 1;
  A << col;
  ws2812(A, &y);



  printf("Finished\r\n");
  return 0;
}
