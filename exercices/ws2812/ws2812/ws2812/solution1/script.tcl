############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
############################################################
open_project ws2812
set_top ws2812
add_files ws2812.cpp
add_files -tb ws2812_test.c
open_solution "solution1"
set_part {xc7z010clg400-1} -tool vivado
create_clock -period 8 -name default
#source "./ws2812/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -format ip_catalog
