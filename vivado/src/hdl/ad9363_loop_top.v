// -----------------------------------------------------------------------------
// Copyright (c) 2014-2020 All rights reserved
// -----------------------------------------------------------------------------
// Author 	 : WCC 1530604142@qq.com
// File   	 : ad9363_loop_top.v
// Create 	 : 2020-11-23 10:17:39
// Revise 	 : 2020-11-23 10:17:39
// Editor 	 : sublime text3, tab size (4)
// Functions : ad9363 top module
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps

module ad9363_loop_top(
	inout [14:0]	DDR_addr,
	inout [2:0]		DDR_ba,
	inout 			DDR_cas_n,
	inout 			DDR_ck_n,
	inout 			DDR_ck_p,
	inout 			DDR_cke,
	inout 			DDR_cs_n,
	inout [1:0]		DDR_dm,
	inout [15:0]	DDR_dq,
	inout [1:0]		DDR_dqs_n,
	inout [1:0]		DDR_dqs_p,
	inout 			DDR_odt,
	inout 			DDR_ras_n,
	inout 			DDR_reset_n,
	inout 			DDR_we_n,
	inout 			FIXED_IO_ddr_vrn,
	inout 			FIXED_IO_ddr_vrp,
	inout [31:0]	FIXED_IO_mio,
	inout 			FIXED_IO_ps_clk,
	inout 			FIXED_IO_ps_porb,
	inout 			FIXED_IO_ps_srstb,
	// ad9363 rx
	input 			rx_clk_in,
	input [11:0]	rx_data_in,
	input 			rx_frame_in,
	// spi
	output 			spi_clk,
	output 			spi_csn,
	input 			spi_miso,
	output 			spi_mosi,
	// ad9363 tx
	output 			tx_clk_out,
	output [11:0]	tx_data_out,
	output 			tx_frame_out,
	//ad936x ctrl signals
	output 			en_agc,    
	output 			enable,    
	output 			resetb,
	output 			txnrx ,  
	output [3:0] 	ctrl_in
);


wire [31:0]gpio;

assign txnrx		=	gpio[2];
assign enable		=	gpio[3];
assign resetb		=	gpio[4];
assign en_agc		=	gpio[6];
assign ctrl_in		=	gpio[10:7];





		design_1_wrapper inst_design_1_wrapper
		(
			.DDR_addr          (DDR_addr),
			.DDR_ba            (DDR_ba),
			.DDR_cas_n         (DDR_cas_n),
			.DDR_ck_n          (DDR_ck_n),
			.DDR_ck_p          (DDR_ck_p),
			.DDR_cke           (DDR_cke),
			.DDR_cs_n          (DDR_cs_n),
			.DDR_dm            (DDR_dm),
			.DDR_dq            (DDR_dq),
			.DDR_dqs_n         (DDR_dqs_n),
			.DDR_dqs_p         (DDR_dqs_p),
			.DDR_odt           (DDR_odt),
			.DDR_ras_n         (DDR_ras_n),
			.DDR_reset_n       (DDR_reset_n),
			.DDR_we_n          (DDR_we_n),
			.FIXED_IO_ddr_vrn  (FIXED_IO_ddr_vrn),
			.FIXED_IO_ddr_vrp  (FIXED_IO_ddr_vrp),
			.FIXED_IO_mio      (FIXED_IO_mio),
			.FIXED_IO_ps_clk   (FIXED_IO_ps_clk),
			.FIXED_IO_ps_porb  (FIXED_IO_ps_porb),
			.FIXED_IO_ps_srstb (FIXED_IO_ps_srstb),
			.gpio              (gpio),
			.rx_clk_in         (rx_clk_in),
			.rx_data_in        (rx_data_in),
			.rx_frame_in       (rx_frame_in),
			.spi_clk           (spi_clk),
			.spi_csn           (spi_csn),
			.spi_miso          (spi_miso),
			.spi_mosi          (spi_mosi),
			.tx_clk_out        (tx_clk_out),
			.tx_data_out       (tx_data_out),
			.tx_frame_out      (tx_frame_out)
		);

endmodule
