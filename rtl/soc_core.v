
`timescale 1ns/1ns

module soc_core (
	input HCLK, 
	input HRESETn,
	
	//input [7: 0] Input_DATA,
	//input [0: 0] Input_irq,
	//output Output_DATA,

	input wire [3: 0] fdi_Sys0_S0,
	output wire [3: 0] fdo_Sys0_S0,
	output wire [0: 0] fdoe_Sys0_S0,
	output wire [0: 0] fsclk_Sys0_S0,
	output wire [0: 0] fcen_Sys0_S0,

	input wire [15: 0] GPIOIN_Sys0_S2,
	output wire [15: 0] GPIOOUT_Sys0_S2,
	output wire [15: 0] GPIOPU_Sys0_S2,
	output wire [15: 0] GPIOPD_Sys0_S2,
	output wire [15: 0] GPIOOEN_Sys0_S2,
	
	//output [3:0] db_reg_Sys0,
		
	input wire [0: 0] RsRx_Sys0_SS0_S0,
	output wire [0: 0] RsTx_Sys0_SS0_S0,
	//output wire [0: 0] uart_irq_Sys0_SS0_S0,
	input wire [0: 0] RsRx_Sys0_SS0_S1,
	output wire [0: 0] RsTx_Sys0_SS0_S1,
	//output wire [0: 0] uart_irq_Sys0_SS0_S1,
	input wire [0: 0] MSI_Sys0_SS0_S2,
	output wire [0: 0] MSO_Sys0_SS0_S2,
	output wire [0: 0] SSn_Sys0_SS0_S2,
	output wire [0: 0] SCLK_Sys0_SS0_S2,
	input wire [0: 0] MSI_Sys0_SS0_S3,
	output wire [0: 0] MSO_Sys0_SS0_S3,
	output wire [0: 0] SSn_Sys0_SS0_S3,
	output wire [0: 0] SCLK_Sys0_SS0_S3,
	input wire [0: 0] scl_i_Sys0_SS0_S4,
	output wire [0: 0] scl_o_Sys0_SS0_S4,
	output wire [0: 0] scl_oen_o_Sys0_SS0_S4,
	input wire [0: 0] sda_i_Sys0_SS0_S4,
	output wire [0: 0] sda_o_Sys0_SS0_S4,
	output wire [0: 0] sda_oen_o_Sys0_SS0_S4,
	input wire [0: 0] scl_i_Sys0_SS0_S5,
	output wire [0: 0] scl_o_Sys0_SS0_S5,
	output wire [0: 0] scl_oen_o_Sys0_SS0_S5,
	input wire [0: 0] sda_i_Sys0_SS0_S5,
	output wire [0: 0] sda_o_Sys0_SS0_S5,
	output wire [0: 0] sda_oen_o_Sys0_SS0_S5,
	output wire [0: 0] pwm_Sys0_SS0_S6,
	output wire [0: 0] pwm_Sys0_SS0_S7
    );


	// wire HCLK_Sys0;
	// wire HRESETn_Sys0;

	wire [31: 0] HADDR_Sys0;
	wire [31: 0] HWDATA_Sys0;
	wire HWRITE_Sys0;
	wire [1: 0] HTRANS_Sys0;
	wire [2:0] HSIZE_Sys0;

	wire HREADY_Sys0;
	wire [31: 0] HRDATA_Sys0;
/*
	wire IRQ_Sys0_SS0_S8;
	wire IRQ_Sys0_SS0_S9;
	wire IRQ_Sys0_SS0_S10;
	wire IRQ_Sys0_SS0_S11;
	wire IRQ_Sys0_SS0_S12;
	wire IRQ_Sys0_SS0_S13;
*/
	wire [31: 0] SRAMRDATA_Sys0_S1;
	wire [3: 0] SRAMWEN_Sys0_S1;
	wire [31: 0] SRAMWDATA_Sys0_S1;
	wire [0: 0] SRAMCS0_Sys0_S1;
	wire [0: 0] SRAMCS1_Sys0_S1;
	wire [0: 0] SRAMCS2_Sys0_S1;
	wire [0: 0] SRAMCS3_Sys0_S1;
	wire [14: 0] SRAMADDR_Sys0_S1;
	// AHB LITE Master2 Signals
	wire [31:0] M2_HADDR;
	wire [0:0] M2_HREADY;
	wire [0:0] M2_HWRITE;
	wire [1:0] M2_HTRANS;
	wire [2:0] M2_HSIZE;
	wire [31:0] M2_HWDATA;
	wire [31:0] M2_HRDATA;
	
	wire [31: 0] M2_IRQ;

	wire [3:0] M2_HPROT;
	wire [2:0] M2_HBURST;
	wire M2_HBUSREQ;
	wire M2_HLOCK;
	wire M2_HGRANT;
	assign M2_HREADY = HREADY_Sys0; 
	assign M2_HRDATA = HRDATA_Sys0;

	assign HADDR_Sys0 = M2_HADDR; 
	assign HWDATA_Sys0 = M2_HWDATA; 
	assign HWRITE_Sys0 = M2_HWRITE; 
	assign HTRANS_Sys0 = M2_HTRANS; 
	assign HSIZE_Sys0 = M2_HSIZE;
	assign M2_HGRANT = 1'b1;
	assign M2_HBUSREQ = 1'b1;


	//assign M2_IRQ = 1'b0;

  

	//AHBlite_SYS0 instantiation

	AHBlite_sys_0 ahb_sys_0_uut(
		// .HCLK(HCLK_Sys0),
		// .HRESETn(HRESETn_Sys0),
    
		.HCLK(HCLK),
		.HRESETn(HRESETn),
         
		.HADDR(HADDR_Sys0),
		.HWDATA(HWDATA_Sys0),
		.HWRITE(HWRITE_Sys0),
		.HTRANS(HTRANS_Sys0),
		.HSIZE(HSIZE_Sys0),
    
		.HREADY(HREADY_Sys0),
		.HRDATA(HRDATA_Sys0),
		
		//.Input_irq(Input_irq),
		//.Input_DATA(Input_DATA),
		//.Output_DATA(Output_DATA),
		
		// QSPI Interface
		.fdi_S0(fdi_Sys0_S0),
		.fdo_S0(fdo_Sys0_S0),
		.fdoe_S0(fdoe_Sys0_S0),
		.fsclk_S0(fsclk_Sys0_S0),
		.fcen_S0(fcen_Sys0_S0),

		// SRAM Interface
		.SRAMRDATA_S1(SRAMRDATA_Sys0_S1),
		.SRAMWEN_S1(SRAMWEN_Sys0_S1),
		.SRAMWDATA_S1(SRAMWDATA_Sys0_S1),
		.SRAMCS0_S1(SRAMCS0_Sys0_S1),
		//.SRAMCS1_S1(SRAMCS1_Sys0_S1),
		//.SRAMCS2_S1(SRAMCS2_Sys0_S1),
		//.SRAMCS3_S1(SRAMCS3_Sys0_S1),
		.SRAMADDR_S1(SRAMADDR_Sys0_S1),

		// GPIO Interface
		.GPIOIN_S2(GPIOIN_Sys0_S2),
		.GPIOOUT_S2(GPIOOUT_Sys0_S2),
		.GPIOPU_S2(GPIOPU_Sys0_S2),
		.GPIOPD_S2(GPIOPD_Sys0_S2),
		.GPIOOEN_S2(GPIOOEN_Sys0_S2),

		//.db_reg(db_reg_Sys0),
		
		// APB Bus
		// UART 0
		.RsRx_SS0_S0(RsRx_Sys0_SS0_S0),
		.RsTx_SS0_S0(RsTx_Sys0_SS0_S0),
		//.uart_irq_SS0_S0(uart_irq_Sys0_SS0_S0),
		
		// UART 1
		.RsRx_SS0_S1(RsRx_Sys0_SS0_S1),
		.RsTx_SS0_S1(RsTx_Sys0_SS0_S1),
		//.uart_irq_SS0_S1(uart_irq_Sys0_SS0_S1),

		// SPI 0 Interface
		.MSI_SS0_S2(MSI_Sys0_SS0_S2),
		.MSO_SS0_S2(MSO_Sys0_SS0_S2),
		.SSn_SS0_S2(SSn_Sys0_SS0_S2),
		.SCLK_SS0_S2(SCLK_Sys0_SS0_S2),

		// SPI 1 Interface
		.MSI_SS0_S3(MSI_Sys0_SS0_S3),
		.MSO_SS0_S3(MSO_Sys0_SS0_S3),
		.SSn_SS0_S3(SSn_Sys0_SS0_S3),
		.SCLK_SS0_S3(SCLK_Sys0_SS0_S3),

		// I2C 0 Interface
		.scl_i_SS0_S4(scl_i_Sys0_SS0_S4),
		.scl_o_SS0_S4(scl_o_Sys0_SS0_S4),
		.scl_oen_o_SS0_S4(scl_oen_o_Sys0_SS0_S4),
		.sda_i_SS0_S4(sda_i_Sys0_SS0_S4),
		.sda_o_SS0_S4(sda_o_Sys0_SS0_S4),
		.sda_oen_o_SS0_S4(sda_oen_o_Sys0_SS0_S4),

		// I2C 1 Interface
		.scl_i_SS0_S5(scl_i_Sys0_SS0_S5),
		.scl_o_SS0_S5(scl_o_Sys0_SS0_S5),
		.scl_oen_o_SS0_S5(scl_oen_o_Sys0_SS0_S5),
		.sda_i_SS0_S5(sda_i_Sys0_SS0_S5),
		.sda_o_SS0_S5(sda_o_Sys0_SS0_S5),
		.sda_oen_o_SS0_S5(sda_oen_o_Sys0_SS0_S5),

		// PMW 0 & 1 Interfaces
		.pwm_SS0_S6(pwm_Sys0_SS0_S6),
		.pwm_SS0_S7(pwm_Sys0_SS0_S7),

		.IRQ(M2_IRQ)
/*
		// IRQ Lines
		.IRQ_SS0_S8(IRQ_Sys0_SS0_S8),
		.IRQ_SS0_S9(IRQ_Sys0_SS0_S9),
		.IRQ_SS0_S10(IRQ_Sys0_SS0_S10),
		.IRQ_SS0_S11(IRQ_Sys0_SS0_S11),
		.IRQ_SS0_S12(IRQ_Sys0_SS0_S12),
		.IRQ_SS0_S13(IRQ_Sys0_SS0_S13)
		*/
		);
        

	DFFRAM #( .COLS(4) ) soc_sram (
		.CLK(HCLK),
		.WE(SRAMWEN_Sys0_S1),
		.EN(SRAMCS0_Sys0_S1),
		.Di(SRAMWDATA_Sys0_S1),
		.Do(SRAMRDATA_Sys0_S1),
		.A(SRAMADDR_Sys0_S1)
	);    
	
	// Instantiation of NfiVe32
	//NfiVe32 N5(
	NfiVe32_SYS CPU (
		.HCLK(HCLK),
		.HRESETn(HRESETn),

		.HADDR(M2_HADDR),
		.HREADY(M2_HREADY),
		.HWRITE(M2_HWRITE),
		.HTRANS(M2_HTRANS),
		.HSIZE(M2_HSIZE),
		.HWDATA(M2_HWDATA),
		.HRDATA(M2_HRDATA),

		//NMI
		.NMI(1'b0),

		//Interrupts
		.IRQ(M2_IRQ),

		// SYSTICK Divisor
		.SYSTICKCLKDIV(8'd100)
	);
  endmodule
  