#include "ws2812.h"
#include <iostream>
using namespace std;
void ws2812 (
  bool *y,
  bool x
  ) {
  

  int i;
  if(x){
	  loop1: for (i=0;i<= T0H;i++) {
		  *y = true;
          cout << i;
	  }
      loop1L: for (i=0;i<= TBIT-T1H;i++) {
		  *y = false;
          cout << i;
	  }
  }
  
}

int main() {
  bool y;
  ws2812(&y, true);
  
}
