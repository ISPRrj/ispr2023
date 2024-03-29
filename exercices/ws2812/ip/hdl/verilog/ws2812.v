// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2017.2
// Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="ws2812,hls_ip_2017_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7z010clg400-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=3.878000,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=1470,HLS_SYN_LUT=694}" *)

module ws2812 (
        ap_clk,
        ap_rst_n,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        A_TDATA,
        A_TVALID,
        A_TREADY,
        A_TKEEP,
        A_TSTRB,
        A_TUSER,
        A_TLAST,
        A_TID,
        A_TDEST,
        y_V
);

parameter    ap_ST_fsm_state1 = 6'd1;
parameter    ap_ST_fsm_state2 = 6'd2;
parameter    ap_ST_fsm_state3 = 6'd4;
parameter    ap_ST_fsm_state4 = 6'd8;
parameter    ap_ST_fsm_state5 = 6'd16;
parameter    ap_ST_fsm_state6 = 6'd32;

input   ap_clk;
input   ap_rst_n;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [255:0] A_TDATA;
input   A_TVALID;
output   A_TREADY;
input  [31:0] A_TKEEP;
input  [31:0] A_TSTRB;
input  [0:0] A_TUSER;
input  [0:0] A_TLAST;
input  [0:0] A_TID;
input  [0:0] A_TDEST;
output  [0:0] y_V;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg[0:0] y_V;

reg    ap_rst_n_inv;
(* fsm_encoding = "none" *) reg   [5:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg   [255:0] A_V_data_V_0_data_out;
wire    A_V_data_V_0_vld_in;
wire    A_V_data_V_0_vld_out;
wire    A_V_data_V_0_ack_in;
reg    A_V_data_V_0_ack_out;
reg   [255:0] A_V_data_V_0_payload_A;
reg   [255:0] A_V_data_V_0_payload_B;
reg    A_V_data_V_0_sel_rd;
reg    A_V_data_V_0_sel_wr;
wire    A_V_data_V_0_sel;
wire    A_V_data_V_0_load_A;
wire    A_V_data_V_0_load_B;
reg   [1:0] A_V_data_V_0_state;
wire    A_V_data_V_0_state_cmp_full;
reg   [0:0] A_V_last_V_0_data_out;
wire    A_V_last_V_0_vld_in;
wire    A_V_last_V_0_vld_out;
wire    A_V_last_V_0_ack_in;
reg    A_V_last_V_0_ack_out;
reg   [0:0] A_V_last_V_0_payload_A;
reg   [0:0] A_V_last_V_0_payload_B;
reg    A_V_last_V_0_sel_rd;
reg    A_V_last_V_0_sel_wr;
wire    A_V_last_V_0_sel;
wire    A_V_last_V_0_load_A;
wire    A_V_last_V_0_load_B;
reg   [1:0] A_V_last_V_0_state;
wire    A_V_last_V_0_state_cmp_full;
wire    A_V_dest_V_0_vld_in;
reg    A_V_dest_V_0_ack_out;
reg   [1:0] A_V_dest_V_0_state;
reg   [31:0] cont_col;
reg    A_TDATA_blk_n;
wire    ap_CS_fsm_state2;
reg   [0:0] tmp_last_V_reg_316;
wire   [3:0] i_1_fu_197_p2;
reg   [3:0] i_1_reg_323;
wire    ap_CS_fsm_state3;
wire   [31:0] led_V_fu_241_p3;
reg   [31:0] led_V_reg_328;
wire   [0:0] exitcond1_fu_191_p2;
wire   [255:0] columna_V_3_fu_249_p3;
reg   [255:0] columna_V_3_reg_333;
wire   [4:0] j_1_fu_275_p2;
reg   [4:0] j_1_reg_341;
wire    ap_CS_fsm_state4;
wire   [0:0] bit_V_fu_291_p3;
reg   [0:0] bit_V_reg_346;
wire   [0:0] exitcond_fu_269_p2;
wire   [12:0] i_2_fu_305_p2;
wire    ap_CS_fsm_state6;
wire    grp_ctrl_bit_fu_172_ap_start;
wire    grp_ctrl_bit_fu_172_ap_done;
wire    grp_ctrl_bit_fu_172_ap_idle;
wire    grp_ctrl_bit_fu_172_ap_ready;
wire   [0:0] grp_ctrl_bit_fu_172_y_V;
wire    grp_ctrl_bit_fu_172_y_V_ap_vld;
reg   [255:0] p_Val2_s_reg_130;
reg   [3:0] i_reg_139;
reg   [4:0] j_reg_150;
wire    ap_CS_fsm_state5;
reg   [12:0] i_i_reg_161;
wire   [0:0] exitcond_i_fu_299_p2;
reg    ap_reg_grp_ctrl_bit_fu_172_ap_start;
wire   [31:0] cont_col_assign_fu_257_p2;
wire   [223:0] r_V_2_fu_227_p4;
wire   [0:0] tmp_fu_203_p1;
wire   [31:0] tmp_4_fu_223_p1;
wire   [31:0] p_Result_4_fu_207_p4;
wire   [255:0] r_V_1_fu_237_p1;
wire   [255:0] r_V_fu_217_p2;
wire   [4:0] bvh_d_index_fu_281_p2;
wire   [31:0] index_assign_cast_fu_287_p1;
reg   [5:0] ap_NS_fsm;

// power-on initialization
initial begin
#0 ap_CS_fsm = 6'd1;
#0 A_V_data_V_0_sel_rd = 1'b0;
#0 A_V_data_V_0_sel_wr = 1'b0;
#0 A_V_data_V_0_state = 2'd0;
#0 A_V_last_V_0_sel_rd = 1'b0;
#0 A_V_last_V_0_sel_wr = 1'b0;
#0 A_V_last_V_0_state = 2'd0;
#0 A_V_dest_V_0_state = 2'd0;
#0 cont_col = 32'd1;
#0 ap_reg_grp_ctrl_bit_fu_172_ap_start = 1'b0;
end

ctrl_bit grp_ctrl_bit_fu_172(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_ctrl_bit_fu_172_ap_start),
    .ap_done(grp_ctrl_bit_fu_172_ap_done),
    .ap_idle(grp_ctrl_bit_fu_172_ap_idle),
    .ap_ready(grp_ctrl_bit_fu_172_ap_ready),
    .y_V(grp_ctrl_bit_fu_172_y_V),
    .y_V_ap_vld(grp_ctrl_bit_fu_172_y_V_ap_vld),
    .x_V(bit_V_reg_346)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        A_V_data_V_0_sel_rd <= 1'b0;
    end else begin
        if (((1'b1 == A_V_data_V_0_ack_out) & (1'b1 == A_V_data_V_0_vld_out))) begin
            A_V_data_V_0_sel_rd <= ~A_V_data_V_0_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        A_V_data_V_0_sel_wr <= 1'b0;
    end else begin
        if (((1'b1 == A_V_data_V_0_vld_in) & (1'b1 == A_V_data_V_0_ack_in))) begin
            A_V_data_V_0_sel_wr <= ~A_V_data_V_0_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        A_V_data_V_0_state <= 2'd0;
    end else begin
        if ((((1'b0 == A_V_data_V_0_vld_in) & (1'b1 == A_V_data_V_0_ack_out) & (A_V_data_V_0_state == 2'd3)) | ((1'b0 == A_V_data_V_0_vld_in) & (A_V_data_V_0_state == 2'd2)))) begin
            A_V_data_V_0_state <= 2'd2;
        end else if ((((1'b1 == A_V_data_V_0_vld_in) & (1'b0 == A_V_data_V_0_ack_out) & (A_V_data_V_0_state == 2'd3)) | ((1'b0 == A_V_data_V_0_ack_out) & (A_V_data_V_0_state == 2'd1)))) begin
            A_V_data_V_0_state <= 2'd1;
        end else if ((((1'b1 == A_V_data_V_0_vld_in) & (A_V_data_V_0_state == 2'd2)) | ((1'b1 == A_V_data_V_0_ack_out) & (A_V_data_V_0_state == 2'd1)) | ((A_V_data_V_0_state == 2'd3) & ~((1'b1 == A_V_data_V_0_vld_in) & (1'b0 == A_V_data_V_0_ack_out)) & ~((1'b0 == A_V_data_V_0_vld_in) & (1'b1 == A_V_data_V_0_ack_out))))) begin
            A_V_data_V_0_state <= 2'd3;
        end else begin
            A_V_data_V_0_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        A_V_dest_V_0_state <= 2'd0;
    end else begin
        if ((((1'b0 == A_V_dest_V_0_vld_in) & (1'b1 == A_V_dest_V_0_ack_out) & (2'd3 == A_V_dest_V_0_state)) | ((1'b0 == A_V_dest_V_0_vld_in) & (2'd2 == A_V_dest_V_0_state)))) begin
            A_V_dest_V_0_state <= 2'd2;
        end else if ((((1'b1 == A_V_dest_V_0_vld_in) & (1'b0 == A_V_dest_V_0_ack_out) & (2'd3 == A_V_dest_V_0_state)) | ((1'b0 == A_V_dest_V_0_ack_out) & (2'd1 == A_V_dest_V_0_state)))) begin
            A_V_dest_V_0_state <= 2'd1;
        end else if ((((1'b1 == A_V_dest_V_0_vld_in) & (2'd2 == A_V_dest_V_0_state)) | ((1'b1 == A_V_dest_V_0_ack_out) & (2'd1 == A_V_dest_V_0_state)) | ((2'd3 == A_V_dest_V_0_state) & ~((1'b1 == A_V_dest_V_0_vld_in) & (1'b0 == A_V_dest_V_0_ack_out)) & ~((1'b0 == A_V_dest_V_0_vld_in) & (1'b1 == A_V_dest_V_0_ack_out))))) begin
            A_V_dest_V_0_state <= 2'd3;
        end else begin
            A_V_dest_V_0_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        A_V_last_V_0_sel_rd <= 1'b0;
    end else begin
        if (((1'b1 == A_V_last_V_0_ack_out) & (1'b1 == A_V_last_V_0_vld_out))) begin
            A_V_last_V_0_sel_rd <= ~A_V_last_V_0_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        A_V_last_V_0_sel_wr <= 1'b0;
    end else begin
        if (((1'b1 == A_V_last_V_0_vld_in) & (1'b1 == A_V_last_V_0_ack_in))) begin
            A_V_last_V_0_sel_wr <= ~A_V_last_V_0_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        A_V_last_V_0_state <= 2'd0;
    end else begin
        if ((((1'b0 == A_V_last_V_0_vld_in) & (1'b1 == A_V_last_V_0_ack_out) & (2'd3 == A_V_last_V_0_state)) | ((1'b0 == A_V_last_V_0_vld_in) & (2'd2 == A_V_last_V_0_state)))) begin
            A_V_last_V_0_state <= 2'd2;
        end else if ((((1'b1 == A_V_last_V_0_vld_in) & (1'b0 == A_V_last_V_0_ack_out) & (2'd3 == A_V_last_V_0_state)) | ((1'b0 == A_V_last_V_0_ack_out) & (2'd1 == A_V_last_V_0_state)))) begin
            A_V_last_V_0_state <= 2'd1;
        end else if ((((1'b1 == A_V_last_V_0_vld_in) & (2'd2 == A_V_last_V_0_state)) | ((1'b1 == A_V_last_V_0_ack_out) & (2'd1 == A_V_last_V_0_state)) | ((2'd3 == A_V_last_V_0_state) & ~((1'b1 == A_V_last_V_0_vld_in) & (1'b0 == A_V_last_V_0_ack_out)) & ~((1'b0 == A_V_last_V_0_vld_in) & (1'b1 == A_V_last_V_0_ack_out))))) begin
            A_V_last_V_0_state <= 2'd3;
        end else begin
            A_V_last_V_0_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_reg_grp_ctrl_bit_fu_172_ap_start <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state4) & (1'd0 == exitcond_fu_269_p2))) begin
            ap_reg_grp_ctrl_bit_fu_172_ap_start <= 1'b1;
        end else if ((1'b1 == grp_ctrl_bit_fu_172_ap_ready)) begin
            ap_reg_grp_ctrl_bit_fu_172_ap_start <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state3) & (1'd1 == exitcond1_fu_191_p2) & (1'd1 == tmp_last_V_reg_316))) begin
        i_i_reg_161 <= 13'd0;
    end else if (((1'b1 == ap_CS_fsm_state6) & (1'd0 == exitcond_i_fu_299_p2))) begin
        i_i_reg_161 <= i_2_fu_305_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state4) & (1'd1 == exitcond_fu_269_p2))) begin
        i_reg_139 <= i_1_reg_323;
    end else if (((1'b1 == ap_CS_fsm_state2) & (A_V_data_V_0_vld_out == 1'b1))) begin
        i_reg_139 <= 4'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state5) & (grp_ctrl_bit_fu_172_ap_done == 1'b1))) begin
        j_reg_150 <= j_1_reg_341;
    end else if (((1'b1 == ap_CS_fsm_state3) & (1'd0 == exitcond1_fu_191_p2))) begin
        j_reg_150 <= 5'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state4) & (1'd1 == exitcond_fu_269_p2))) begin
        p_Val2_s_reg_130 <= columna_V_3_reg_333;
    end else if (((1'b1 == ap_CS_fsm_state2) & (A_V_data_V_0_vld_out == 1'b1))) begin
        p_Val2_s_reg_130 <= A_V_data_V_0_data_out;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == A_V_data_V_0_load_A)) begin
        A_V_data_V_0_payload_A <= A_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == A_V_data_V_0_load_B)) begin
        A_V_data_V_0_payload_B <= A_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == A_V_last_V_0_load_A)) begin
        A_V_last_V_0_payload_A <= A_TLAST;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == A_V_last_V_0_load_B)) begin
        A_V_last_V_0_payload_B <= A_TLAST;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state4) & (1'd0 == exitcond_fu_269_p2))) begin
        bit_V_reg_346 <= bit_V_fu_291_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state3) & (1'd0 == exitcond1_fu_191_p2))) begin
        columna_V_3_reg_333 <= columna_V_3_fu_249_p3;
        led_V_reg_328 <= led_V_fu_241_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state3) & (1'd1 == exitcond1_fu_191_p2))) begin
        cont_col <= cont_col_assign_fu_257_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        i_1_reg_323 <= i_1_fu_197_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        j_1_reg_341 <= j_1_fu_275_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state2) & (A_V_data_V_0_vld_out == 1'b1))) begin
        tmp_last_V_reg_316 <= A_V_last_V_0_data_out;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        A_TDATA_blk_n = A_V_data_V_0_state[1'd0];
    end else begin
        A_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & (A_V_data_V_0_vld_out == 1'b1))) begin
        A_V_data_V_0_ack_out = 1'b1;
    end else begin
        A_V_data_V_0_ack_out = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == A_V_data_V_0_sel)) begin
        A_V_data_V_0_data_out = A_V_data_V_0_payload_B;
    end else begin
        A_V_data_V_0_data_out = A_V_data_V_0_payload_A;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & (A_V_data_V_0_vld_out == 1'b1))) begin
        A_V_dest_V_0_ack_out = 1'b1;
    end else begin
        A_V_dest_V_0_ack_out = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & (A_V_data_V_0_vld_out == 1'b1))) begin
        A_V_last_V_0_ack_out = 1'b1;
    end else begin
        A_V_last_V_0_ack_out = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == A_V_last_V_0_sel)) begin
        A_V_last_V_0_data_out = A_V_last_V_0_payload_B;
    end else begin
        A_V_last_V_0_data_out = A_V_last_V_0_payload_A;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) & (1'd1 == exitcond_i_fu_299_p2))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_start) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) & (1'd1 == exitcond_i_fu_299_p2))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) & (1'd0 == exitcond_i_fu_299_p2))) begin
        y_V = 1'd0;
    end else if (((1'b1 == ap_CS_fsm_state5) & (1'b1 == grp_ctrl_bit_fu_172_y_V_ap_vld))) begin
        y_V = grp_ctrl_bit_fu_172_y_V;
    end else begin
        y_V = 'bx;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((1'b1 == ap_CS_fsm_state2) & (A_V_data_V_0_vld_out == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        ap_ST_fsm_state3 : begin
            if (((1'b1 == ap_CS_fsm_state3) & (1'd1 == exitcond1_fu_191_p2) & (1'd1 == tmp_last_V_reg_316))) begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end else if (((1'b1 == ap_CS_fsm_state3) & (1'd1 == exitcond1_fu_191_p2) & (1'd0 == tmp_last_V_reg_316))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((1'b1 == ap_CS_fsm_state4) & (1'd1 == exitcond_fu_269_p2))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end
        end
        ap_ST_fsm_state5 : begin
            if (((1'b1 == ap_CS_fsm_state5) & (grp_ctrl_bit_fu_172_ap_done == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end
        end
        ap_ST_fsm_state6 : begin
            if (((1'b1 == ap_CS_fsm_state6) & (1'd1 == exitcond_i_fu_299_p2))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign A_TREADY = A_V_dest_V_0_state[1'd1];

assign A_V_data_V_0_ack_in = A_V_data_V_0_state[1'd1];

assign A_V_data_V_0_load_A = (A_V_data_V_0_state_cmp_full & ~A_V_data_V_0_sel_wr);

assign A_V_data_V_0_load_B = (A_V_data_V_0_sel_wr & A_V_data_V_0_state_cmp_full);

assign A_V_data_V_0_sel = A_V_data_V_0_sel_rd;

assign A_V_data_V_0_state_cmp_full = ((A_V_data_V_0_state != 2'd1) ? 1'b1 : 1'b0);

assign A_V_data_V_0_vld_in = A_TVALID;

assign A_V_data_V_0_vld_out = A_V_data_V_0_state[1'd0];

assign A_V_dest_V_0_vld_in = A_TVALID;

assign A_V_last_V_0_ack_in = A_V_last_V_0_state[1'd1];

assign A_V_last_V_0_load_A = (A_V_last_V_0_state_cmp_full & ~A_V_last_V_0_sel_wr);

assign A_V_last_V_0_load_B = (A_V_last_V_0_sel_wr & A_V_last_V_0_state_cmp_full);

assign A_V_last_V_0_sel = A_V_last_V_0_sel_rd;

assign A_V_last_V_0_state_cmp_full = ((A_V_last_V_0_state != 2'd1) ? 1'b1 : 1'b0);

assign A_V_last_V_0_vld_in = A_TVALID;

assign A_V_last_V_0_vld_out = A_V_last_V_0_state[1'd0];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];

assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign bit_V_fu_291_p3 = led_V_reg_328[index_assign_cast_fu_287_p1];

assign bvh_d_index_fu_281_p2 = ($signed(5'd23) - $signed(j_reg_150));

assign columna_V_3_fu_249_p3 = ((tmp_fu_203_p1[0:0] === 1'b1) ? r_V_1_fu_237_p1 : r_V_fu_217_p2);

assign cont_col_assign_fu_257_p2 = (cont_col + 32'd1);

assign exitcond1_fu_191_p2 = ((i_reg_139 == 4'd8) ? 1'b1 : 1'b0);

assign exitcond_fu_269_p2 = ((j_reg_150 == 5'd24) ? 1'b1 : 1'b0);

assign exitcond_i_fu_299_p2 = ((i_i_reg_161 == 13'd5000) ? 1'b1 : 1'b0);

assign grp_ctrl_bit_fu_172_ap_start = ap_reg_grp_ctrl_bit_fu_172_ap_start;

assign i_1_fu_197_p2 = (i_reg_139 + 4'd1);

assign i_2_fu_305_p2 = (i_i_reg_161 + 13'd1);

assign index_assign_cast_fu_287_p1 = bvh_d_index_fu_281_p2;

assign j_1_fu_275_p2 = (j_reg_150 + 5'd1);

assign led_V_fu_241_p3 = ((tmp_fu_203_p1[0:0] === 1'b1) ? tmp_4_fu_223_p1 : p_Result_4_fu_207_p4);

assign p_Result_4_fu_207_p4 = {{p_Val2_s_reg_130[255:224]}};

assign r_V_1_fu_237_p1 = r_V_2_fu_227_p4;

assign r_V_2_fu_227_p4 = {{p_Val2_s_reg_130[255:32]}};

assign r_V_fu_217_p2 = p_Val2_s_reg_130 << 256'd32;

assign tmp_4_fu_223_p1 = p_Val2_s_reg_130[31:0];

assign tmp_fu_203_p1 = cont_col[0:0];

endmodule //ws2812
