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
#include "xgpiops.h"
#include "xaxidma.h"
#include "xscugic.h"

typedef struct {
	XAxiDma* p_dma;
	unsigned int done;
} dma_t;

#define LONGITUD	0x0200

//void XAxiDma_IntrHandler(XAxiDma* p_xdma){
void XAxiDma_IntrHandler(dma_t* p_dma_intr){
	u32 mask;
	mask = XAxiDma_IntrGetIrq(p_dma_intr->p_dma, XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrAckIrq(p_dma_intr->p_dma, mask, XAXIDMA_DEVICE_TO_DMA);

	if (mask & XAXIDMA_IRQ_ERROR_MASK) {
		while(1);
	}

	if (mask & XAXIDMA_IRQ_IOC_MASK) {
		p_dma_intr->done = 1;
	}
}


int main()
{
	Xil_ExceptionEnable();
	u16 dataReserva[256];
	u16 *RxBufferPtr;

	RxBufferPtr = &dataReserva[0];
    //Configuramos el Boton
	XGpioPs_Config* p_btn_config;
	XGpioPs gpiops;
	int result;
    p_btn_config = XGpioPs_LookupConfig(XPAR_PS7_GPIO_0_DEVICE_ID);
    if (p_btn_config == NULL) {
      xil_printf("LookupConfig btn failed\r\n");
      while (1);
    }
    result = XGpioPs_CfgInitialize(&gpiops, p_btn_config, p_btn_config->BaseAddr);
    if (result != XST_SUCCESS) {
      xil_printf("CfgInitilize btn failed %d\r\n", result);
      while (1);
    }
    //Configuración del DMA
    XAxiDma xdma;
    XAxiDma_Config * DmaCfgPtr;
    DmaCfgPtr = XAxiDma_LookupConfig(XPAR_AXIDMA_0_DEVICE_ID);
    XAxiDma_CfgInitialize(&xdma , DmaCfgPtr);

    XScuGic Gic;
    XScuGic_Config * pGicCfg;
    pGicCfg = XScuGic_LookupConfig(XPAR_SCUGIC_SINGLE_DEVICE_ID);
    XScuGic_CfgInitialize(&Gic, pGicCfg, pGicCfg->CpuBaseAddress);

    dma_t dma_intr;
    dma_intr.p_dma = &xdma;
    dma_intr.done = 0;

    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_IRQ_INT,(Xil_ExceptionHandler)XScuGic_InterruptHandler, &Gic);
    //XScuGic_Connect(&Gic,XPAR_FABRIC_AXI_DMA_0_S2MM_INTROUT_INTR, (Xil_InterruptHandler)XAxiDma_IntrHandler, (void *)&xdma);
    XScuGic_Connect(&Gic,XPAR_FABRIC_AXI_DMA_0_S2MM_INTROUT_INTR, (Xil_InterruptHandler)XAxiDma_IntrHandler, (void *)&dma_intr);
    XScuGic_Enable(&Gic, XPAR_FABRIC_AXI_DMA_0_S2MM_INTROUT_INTR);

    XAxiDma_IntrEnable(&xdma,XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
    XGpioPs_SetDirectionPin(&gpiops, 54, 0);
    XGpioPs_SetDirectionPin(&gpiops, 7 , 1);
    XGpioPs_SetOutputEnablePin(&gpiops, 7, 1);


    while(1){

    	XAxiDma_Reset(&xdma);
    	if(XAxiDma_ResetIsDone(&xdma)){
			u32 btn = XGpioPs_ReadPin(&gpiops, 54);
			if (btn){

				XAxiDma_SimpleTransfer(&xdma,(UINTPTR) RxBufferPtr, LONGITUD, XAXIDMA_DEVICE_TO_DMA);
				while (dma_intr.done == 0) {

				}

			}
			XGpioPs_WritePin(&gpiops, 7, btn&0x000F);


    	}
    }

}
