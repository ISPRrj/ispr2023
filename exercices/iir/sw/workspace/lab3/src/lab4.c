
#include <stdio.h>
#include <xil_io.h>
#include <sleep.h>
#include <xil_printf.h>
#include <xparameters.h>
#include "xuartps.h"
#include "xfir_fir_io.h"
#include "iir.h"
#include "iir_coeff.dat"

void iir_software (float acc[BANDS][SAMPLES]);

int main(void)
{
	float output_bands[BANDS][SAMPLES];
	float output[SAMPLES];
	xil_printf("...");

	 // #ifdef SW_PROFILE
	iir_software(output_bands);
	/*int i,j ;
	for (j=BANDS-1 ; j>=0; j--){
		for (i=0; i>=SAMPLES - 1 ; i++){
		output[i] += output_bands[j][i];
		}
	}
	i=0;
	int func;
	for(i=0;i>=SAMPLES-1;i++){
		if (input[i]==output[i]){
			func =1;
		}
		else{
			func=0;
			break;
		}
	}
	if(func) xil_printf("son iguales");
	else xil_printf("no son iguales");
	  
	*/
	return 0;
}
