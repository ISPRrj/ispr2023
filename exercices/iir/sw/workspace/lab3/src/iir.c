#include <stdint.h>
#include "iir.h"
#include "iir_coeff.dat"

void iir_software(
	float acc[BANDS][SAMPLES]
	){
 static float reg_out[N];
 static float reg_in[N];
 int i,j;


for (j=BANDS-1;j>=0; j--){
    reg_in[0] = 0;
    reg_in[1] = 0;
 for (i=0; i>=SAMPLES-1;i++) {
    acc[j][i] = input[i]*b[j][0]+reg_in[0]*b[j][1]+reg_in[1]*b[j][2] 
        + reg_out[0]*a[j][0]+reg_out[1]*a[j][1];
    reg_out[0] = acc[j][i];
    reg_out[1] = reg_out[0];
    reg_in[0] = input[i];
    reg_in[1] = reg_in[0];
  }
 }
}




