`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

`define MPRJ_IO_PADS 38

module user_project_wrapper (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oen,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7.
    inout [`MPRJ_IO_PADS-8:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2
);

    /*--------------------------------------*/
    /* User project is instantiated  here   */
    /*--------------------------------------*/
    assign io_oeb[18] = 1'b0; 
    assign io_oeb[19] = 1'b0; 

    assign io_oeb[20] = 1'b1; 
    assign io_oeb[21] = 1'b0; 
    assign io_oeb[22] = 1'b1; 
    assign io_oeb[23] = 1'b0; 

    assign io_oeb[24] = 1'b1; 
    assign io_oeb[25] = 1'b0; 
    assign io_oeb[26] = 1'b0; 
    assign io_oeb[27] = 1'b0; 

    assign io_oeb[28] = 1'b1; 
    assign io_oeb[29] = 1'b0; 
    assign io_oeb[30] = 1'b0; 
    assign io_oeb[31] = 1'b0; 

    assign io_oeb[30] = 1'b0; 
    assign io_oeb[31] = 1'b0; 

    // check csb pin -- io[3]
    wire fdoeb;
    
    assign io_oeb[17:14] = {4{~fdoeb}};

    soc_core core(
    `ifdef USE_POWER_PINS
        .VPWR(vccd1),
        .VGND(vssd1),
    `endif
        .HCLK(wb_clk_i), 
	    .HRESETn(la_data_in[26]),
	    
        .NMI(la_data_in[24]),
        .EXT_IRQ(la_data_in[25]),
	    .SYSTICKCLKDIV(la_data_in[23:0]),

        .GPIOIN_Sys0_S2(io_in[13:0]),
        .GPIOOUT_Sys0_S2(io_out[13:0]),
	    .GPIOPU_Sys0_S2(),
	    .GPIOPD_Sys0_S2(),
	    .GPIOOEN_Sys0_S2(io_oeb[13:0]),

	    .fdi_Sys0_S0(io_in[17:14]),
	    .fdo_Sys0_S0(io_out[17:14]),
		.fdoe_Sys0_S0(fdoeb),
        .fsclk_Sys0_S0(io_out[18]),
	    .fcen_Sys0_S0(io_out[19]),
		
	    .RsRx_Sys0_SS0_S0(io_in[20]),
        .RsTx_Sys0_SS0_S0(io_out[21]),

        .RsRx_Sys0_SS0_S1(io_in[22]),
        .RsTx_Sys0_SS0_S1(io_out[23]),

        .MSI_Sys0_SS0_S2(io_in[24]),
        .MSO_Sys0_SS0_S2(io_out[25]),
        .SSn_Sys0_SS0_S2(io_out[26]),
        .SCLK_Sys0_SS0_S2(io_out[27]),

        .MSI_Sys0_SS0_S3(io_in[28]),
        .MSO_Sys0_SS0_S3(io_out[29]),
        .SSn_Sys0_SS0_S3(io_out[30]),
        .SCLK_Sys0_SS0_S3(io_out[31]),

        .scl_i_Sys0_SS0_S4(io_in[32]),
        .scl_o_Sys0_SS0_S4(io_out[32]),
        .scl_oen_o_Sys0_SS0_S4(io_oeb[32]),
        .sda_i_Sys0_SS0_S4(io_in[33]),
        .sda_o_Sys0_SS0_S4(io_out[33]),
        .sda_oen_o_Sys0_SS0_S4(io_oeb[33]),

        .scl_i_Sys0_SS0_S5(io_in[34]),
        .scl_o_Sys0_SS0_S5(io_out[34]),
        .scl_oen_o_Sys0_SS0_S5(io_oeb[34]),
        .sda_i_Sys0_SS0_S5(io_in[35]),
        .sda_o_Sys0_SS0_S5(io_out[35]),
        .sda_oen_o_Sys0_SS0_S5(io_oeb[35]),

        .pwm_Sys0_SS0_S6(io_out[36]),
        .pwm_Sys0_SS0_S7(io_out[37])
    );
   

endmodule	// user_project_wrapper
`default_nettype wire
