/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xgpio.h"

int main()
{

    XGpio_Config* p_sw_config;
    XGpio_Config* p_LED_config;
    XGpio sw, led;
    int result, result2;
    p_sw_config = XGpio_LookupConfig(XPAR_SWITCHES_DEVICE_ID);
    if (p_sw_config == NULL) {
    xil_printf("LookupConfig Switches failed\r\n");
    while (1);
    }
    result = XGpio_CfgInitialize(&sw, p_sw_config, p_sw_config->BaseAddress);
    if (result != XST_SUCCESS) {
    xil_printf("CfgInitilize Switches failed %d\r\n", result);
    while (1);
    }


    p_LED_config = XGpio_LookupConfig(XPAR_LEDS_DEVICE_ID);
    if (p_LED_config == NULL) {
    	xil_printf("LookupConfig LEDS failed\r\n");
    	while (1);
       }
       result2 = XGpio_CfgInitialize(&led, p_LED_config, p_LED_config->BaseAddress);
       if (result2 != XST_SUCCESS) {
       xil_printf("CfgInitilize LEDS failed %d\r\n", result);
       while (1);
       }

    XGpio_SetDataDirection(&led, 1, 0x00000000);

    XGpio_SetDataDirection(&sw, 1, 0xFFFFFFFF); //Set GPIO in channel 1 as inputs

    //result = XGpio_Initialize(&sw, XPAR_SWITCHES_DEVICE_ID);
    while (1) {
    	u32 switches = XGpio_DiscreteRead(&sw, 1); //Read switches value
    	XGpio_DiscreteWrite(&led, 1, switches&0x000F);
    	//xil_printf("\nSwitches value is 0x%04X\r\n", switches&0x000F); //Only 4 bits
    	for (int i = 0; i < 9999999; i++);
    }

}
