// -----------------------------------------------------------------------------
// Copyright (c) 2014-2020 All rights reserved
// -----------------------------------------------------------------------------
// Author 	 : WCC 1530604142@qq.com
// File   	 : ad9363_test.v
// Create 	 : 2020-11-23 09:16:52
// Revise 	 : 2020-11-23 09:16:52
// Editor 	 : sublime text3, tab size (4)
// Functions : ad9363 loop test module, generate sin wave, and recieve data from 
// 			   ad9363
// -----------------------------------------------------------------------------
module ad9363_test (
	input 	wire 		clk			,// Clock
	input 	wire 		rst			,// Asynchronous reset active high
	input 	wire 		rx_status 	,
	input 	wire 		adc_valid	,
	input 	wire [11:0]	adc_data_i0	,
	input 	wire [11:0]	adc_data_q0	,
	input 	wire [31:0]	phase_inc 	,
	input 	wire 		dds_en 		,
	output 	wire 		dac_valid	,
	output	wire [11:0]	dac_data_i0	,
	output	wire [11:0]	dac_data_q0	
);

//====================================================
//parameters define
//====================================================
parameter 	PHASE_INCREMENT = 32'h20C49B;

//====================================================
//internal signals and registers
//====================================================
wire 			phase_vld 	;
reg 	[31:0]	phase_inc_r	;

wire 			dds_vld 	;
wire 	[31:0]	dds_data	;

reg 	signed [11:0]	counter1 	;
reg 	signed [11:0]	counter2 	;

assign dac_valid   = dds_en ? dds_vld : 1'b0;
assign dac_data_i0 = dds_en ? dds_data[11:0] : 'd0;
assign dac_data_q0 = dds_en ? dds_data[27:16] : 'd0;

always @(posedge clk) begin
	phase_inc_r <= phase_inc;
end

assign phase_vld = phase_inc_r != phase_inc;

always @(posedge clk) begin
	if (rst==1'b1) begin
		counter1 <= -2048;
	end
	else if (counter1 == 2047) begin
		counter1 <= -2048;
	end
	else begin
		counter1 <= counter1 + 1'b1;
	end
end

always @(posedge clk) begin
	if (rst==1'b1) begin
		counter2 <= 2047;
	end
	else if (counter2 == -2048) begin
		counter2 <= 2047;
	end
	else begin
		counter2 <= counter1 - 1'b1;
	end
end





dds_compiler_0 inst_dds (
  	.aclk(clk),                       	// input wire aclk
  	.s_axis_config_tvalid(phase_vld), 	// input wire s_axis_config_tvalid
  	.s_axis_config_tdata(phase_inc), 	// input wire [31 : 0] s_axis_config_tdata
  	.m_axis_data_tvalid(dds_vld),		// output wire m_axis_data_tvalid
  	.m_axis_data_tdata(dds_data)   		// output wire [31 : 0] m_axis_data_tdata
);

wire [63:0]	probe0;

assign probe0 = {
	adc_valid,
	rx_status,
	adc_data_q0,
	adc_data_i0,
	dac_valid,
	dac_data_q0,
	dac_data_i0
};


ila_dds inst_dds_ila (
	.clk(clk), // input wire clk


	.probe0(probe0) // input wire [63:0] probe0
);

endmodule