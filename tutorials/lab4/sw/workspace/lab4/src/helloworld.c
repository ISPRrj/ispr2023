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
#include "xgpiops.h"
#include "xscutimer.h"
#include "xscugic.h"
#include "xaxicdma.h"

#define LENGTH 16384 //buffer lengths in number of bytes
#define PROCESSOR_BRAM_MEMORY 0x80008000 // BRAM Controller 0
#define CDMA_BRAM_MEMORY 0xC0008000 // BRAM Controller 1
#define DDR_MEMORY 0x01000000

XScuTimer timer;
XScuTimer_Config *pScuTimerCfg;

void mem_setup (u8* mem) {
	int i;
	for (i=0; i<LENGTH; i++) {
		*(mem+i) = i;
	}
}

void mem_clear (u8* mem) {
	int i;
	for (i=0; i<LENGTH; i++) {
		*(mem+i) = 0;
	}
}

void cpu_move (u8* src, u8* dst, XScuTimer* pTimer) {
	u32 i, cnt;
	mem_setup(src);
	mem_clear(dst);
	XScuTimer_RestartTimer(pTimer);
	for (i=0; i<LENGTH; i++) {
		*(dst+i) = *(src+i);
	}
	cnt = XScuTimer_GetCounterValue(pTimer);
	xil_printf("Moving %d bytes with CPU took %d clock cycles\r\n",
	LENGTH, 0xFFFFFFFF-cnt);
}

void cdma_move_polling (XAxiCdma * pCDMA,
	u8* src, u8* dst,
	u32 cdma_src, u32 cdma_dst,
	XScuTimer* pTimer) {
	u32 i, cnt;
	mem_setup(src);
	mem_clear(dst);
	XAxiCdma_IntrDisable(pCDMA, XAXICDMA_XR_IRQ_ALL_MASK);
	XScuTimer_RestartTimer(pTimer);
	XAxiCdma_SimpleTransfer(pCDMA, cdma_src, cdma_dst,
	LENGTH, NULL, NULL);
	while (XAxiCdma_IsBusy(pCDMA));
	cnt = XScuTimer_GetCounterValue(pTimer);
	xil_printf("Moving %d bytes with polling CDMA took %d clock cycles\r\n", LENGTH, 0xFFFFFFFF-cnt);
}
static void xcdma_callback(void *CallBackRef,
	u32 IrqMask,
	int *IgnorePtr)
	{
	if (IrqMask & XAXICDMA_XR_IRQ_ERROR_MASK) {
		while (1);
	}
	if (IrqMask & XAXICDMA_XR_IRQ_IOC_MASK) {
		volatile u32* p_cnt = (volatile u32*)CallBackRef;
		*p_cnt = XScuTimer_GetCounterValue(&timer);
}
}

void cdma_move_isr (XAxiCdma * pCDMA,
	u8* src, u8* dst,
	u32 cdma_src, u32 cdma_dst,
	XScuTimer* pTimer) {
	u32 i;
	volatile u32 cnt;
	mem_setup(src);
	mem_clear(dst);
	cnt = 0;
	XAxiCdma_IntrEnable(pCDMA, XAXICDMA_XR_IRQ_ALL_MASK);
	XScuTimer_RestartTimer(pTimer);
	XAxiCdma_SimpleTransfer(pCDMA, cdma_src, cdma_dst, LENGTH, xcdma_callback, (void*)(&cnt));
	while(cnt == 0) {
		usleep(1000);
	}
	xil_printf("Moving %d bytes with ISR CDMA took %d clock cycles\r\n", LENGTH, 0xFFFFFFFF-cnt);
	}

int main()
{
	Xil_DCacheDisable();
	Xil_ExceptionEnable();

	pScuTimerCfg = XScuTimer_LookupConfig(XPAR_SCUTIMER_DEVICE_ID);
	XScuTimer_CfgInitialize(&timer, pScuTimerCfg, pScuTimerCfg->BaseAddr);
	XScuTimer_LoadTimer(&timer, 0xFFFFFFFF);
	XScuTimer_Start(&timer);


    XGpio_Config* p_sw_config;
    XGpio_Config* p_LED_config;
    XGpioPs_Config* p_btn_config;
    XGpio sw, led;
    XGpioPs gpiops;

    int result, result2, result3;
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

    p_btn_config = XGpioPs_LookupConfig(XPAR_PS7_GPIO_0_DEVICE_ID);
        if (p_btn_config == NULL) {
        xil_printf("LookupConfig btn failed\r\n");
        while (1);
        }
        result3 = XGpioPs_CfgInitialize(&gpiops, p_btn_config, p_btn_config->BaseAddr);
        if (result != XST_SUCCESS) {
        xil_printf("CfgInitilize btn failed %d\r\n", result3);
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


    XGpioPs_SetDirectionPin(&gpiops, 54, 0);
    XGpioPs_SetDirectionPin(&gpiops, 7 , 1);


    XGpio_SetDataDirection(&led, 1, 0x00000000);
    XGpio_SetDataDirection(&sw, 1, 0xFFFFFFFF); //Set GPIO in channel 1 as inputs
    XGpioPs_SetOutputEnablePin(&gpiops, 7, 1);
    //result = XGpio_Initialize(&sw, XPAR_SWITCHES_DEVICE_ID);
    u8 * source, * destination;
    u8 * cdma_source, * cdma_destination;
    u32 ps_led = 0;

    while (1) {

    	volatile u32 cnt1 = 0;

    	u32 btn = XGpioPs_ReadPin(&gpiops, 54);






    	//xil_printf("\nSwitches value is 0x%04X\r\n", switches&0x000F); //Only 4 bits



    	//Configuración
    	XScuGic Gic;
    	XScuGic_Config * pGicCfg;
    	pGicCfg = XScuGic_LookupConfig(XPAR_SCUGIC_SINGLE_DEVICE_ID);
    	XScuGic_CfgInitialize(&Gic, pGicCfg, pGicCfg->CpuBaseAddress);

    	XAxiCdma xcdma;
    	XAxiCdma_Config * CdmaCfgPtr;
    	CdmaCfgPtr = XAxiCdma_LookupConfig(XPAR_AXI_CDMA_0_DEVICE_ID);
    	XAxiCdma_CfgInitialize(&xcdma , CdmaCfgPtr, CdmaCfgPtr->BaseAddress);


    	Xil_ExceptionInit();

    	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_IRQ_INT,(Xil_ExceptionHandler)XScuGic_InterruptHandler, &Gic);

    	XScuGic_Connect(&Gic,XPAR_FABRIC_AXI_CDMA_0_CDMA_INTROUT_INTR, (Xil_InterruptHandler)XAxiCdma_IntrHandler, (void *)&xcdma);
    	XScuGic_Enable(&Gic, XPAR_FABRIC_AXI_CDMA_0_CDMA_INTROUT_INTR);
    	//-----------------------------------------------------

    	XScuTimer_RestartTimer(&timer);
    	for (int i=0; i<9999999; i++);
    	cnt1 = XScuTimer_GetCounterValue(&timer);
    	xil_printf("Delay took %d clock cycles\r\n", 0xFFFFFFFF-cnt1);
    	ps_led=!ps_led;

    	while (!btn){
    		btn = XGpioPs_ReadPin(&gpiops, 54);

    	}
    		u32 switches = XGpio_DiscreteRead(&sw, 1); //Read switches value

    		 if(switches==1){
    			 source = (u8 *)PROCESSOR_BRAM_MEMORY;
    			 cdma_source = (u8 *)CDMA_BRAM_MEMORY;
    			 destination = (u8 *)DDR_MEMORY;
    			 cdma_destination = (u8 *)DDR_MEMORY;
    		 }
    		 else if(switches==2){
    			 source = (u8 *)DDR_MEMORY;
    			 cdma_source = (u8 *)DDR_MEMORY;
    			 destination = (u8 *)PROCESSOR_BRAM_MEMORY;
    			 cdma_destination = (u8 *)CDMA_BRAM_MEMORY;
    		 }
    		 else if (switches==3){
    			 source = (u8 *)PROCESSOR_BRAM_MEMORY;
    			 cdma_source = (u8 *)CDMA_BRAM_MEMORY;
    			 destination = (u8 *) PROCESSOR_BRAM_MEMORY+LENGTH;
    			 cdma_destination = (u8 *)CDMA_BRAM_MEMORY+LENGTH;


    		 }
    		 else{
    			 source = (u8 *)DDR_MEMORY;
    			 cdma_source = (u8 *)DDR_MEMORY;
    			 destination = (u8 *)DDR_MEMORY+LENGTH;
    			 cdma_destination = (u8 *)DDR_MEMORY+LENGTH;
    		 }

    		 cpu_move(source, destination, &timer);
    		 cdma_move_polling (&xcdma, source, destination,cdma_source, cdma_destination,&timer);
    		 cdma_move_isr (&xcdma, source, destination,cdma_source, cdma_destination,&timer);
    		 XGpio_DiscreteWrite(&led, 1, switches&0x000F);








    }

}
