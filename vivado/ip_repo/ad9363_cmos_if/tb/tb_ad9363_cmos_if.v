
`timescale 1ns/1ps

module tb_ad9363_cmos_if (); /* this is automatically generated */


	// (*NOTE*) replace reset, clock, others

	reg        	ref_clk;
	reg        	rst;
	reg        	rx_clk_in;
	wire         rx_frame_in;
	wire [11:0]  rx_data_in;
	wire        tx_clk_out;
	wire        tx_frame_out;
	wire [11:0] tx_data_out;
	wire        adc_valid;
	wire [11:0] adc_data_i1;
	wire [11:0] adc_data_q1;
	wire        rx_status;
	reg        	dac_valid;
	reg [11:0] 	dac_data_i1;
	reg [11:0] 	dac_data_q1;
	wire        user_rx_clk;
	wire        user_tx_clk;
	reg  [4:0] 	rx_delay_value;
	reg  [4:0] 	tx_delay_value;
	reg 	 	rx_delay_load_en;
	reg 		tx_delay_load_en;
	reg        	data_clk_ce;

	ad9363_cmos_if inst_ad9363_cmos_if
		(
			.ref_clk          (ref_clk),
			.rst              (rst),
			.rx_clk_in        (rx_clk_in),
			.rx_frame_in      (rx_frame_in),
			.rx_data_in       (rx_data_in),
			.tx_clk_out       (tx_clk_out),
			.tx_frame_out     (tx_frame_out),
			.tx_data_out      (tx_data_out),
			.adc_valid        (adc_valid),
			.adc_data_i1      (adc_data_i1),
			.adc_data_q1      (adc_data_q1),
			.rx_status        (rx_status),
			.dac_valid        (dac_valid),
			.dac_data_i1      (dac_data_i1),
			.dac_data_q1      (dac_data_q1),
			.user_rx_clk      (user_rx_clk),
			.user_tx_clk      (user_tx_clk),
			.rx_delay_value   (rx_delay_value),
			.tx_delay_value   (tx_delay_value),
			.rx_delay_load_en (rx_delay_load_en),
			.tx_delay_load_en (tx_delay_load_en),
			.data_clk_ce      (data_clk_ce)
		);


	initial begin
		ref_clk        	= 0;
		rst            	= 0;
		rx_clk_in      	= 0;
		dac_valid      	= 0;
		dac_data_i1    	= 0;
		dac_data_q1    	= 0;
		rx_delay_value 	= 'd5;
		tx_delay_value 	= 'd16;
		rx_delay_load_en= 1'h0;
		tx_delay_load_en= 1'h0;
		data_clk_ce    	= 'd1;
	end

    initial begin
        ref_clk = 0;
        forever #(2.5) ref_clk = ~ref_clk;
    end

    initial begin
        rx_clk_in = 0;
        forever #(12.5) rx_clk_in = ~rx_clk_in;
    end


	initial begin
		rst <= 1;
		repeat(100)@(posedge rx_clk_in)
		rst <= 0;
	end

	assign 	rx_frame_in = tx_frame_out;
	assign	rx_data_in  = tx_data_out;


	

	task drive();
		integer it; begin 
			dac_valid = #2 1'b1;
			for(it = 0; it < 1024; it = it + 1) begin
				dac_data_i1    <= it[11:0];
				dac_data_q1    <= 1024 - it[11:0];
				@(posedge user_tx_clk);
			end
			dac_valid = 1'b0;
		end
	endtask



	initial begin
		@(negedge rst);
		repeat(100)@(negedge ref_clk); 

		rx_delay_load_en = 1'h1;
		tx_delay_load_en = 1'h1;
		@(negedge ref_clk);
		rx_delay_load_en = 1'h0;
		tx_delay_load_en = 1'h0;
		repeat(10)@(posedge ref_clk);
		drive();
	end

endmodule
