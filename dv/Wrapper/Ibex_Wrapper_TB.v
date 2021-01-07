`timescale 1ns/1ns

`define   TEST_FILE   "../../sw/test.hex" 
`define   SIM_TIME    2000_000
`define   SIM_LEVEL   0

module Ibex_Wrapper_TB;

    // Ibex Wrapper
    wire [127:0] la_data_in;
    wire [127:0] la_data_out;
    wire [127:0] la_oen;

    wire  [`MPRJ_IO_PADS-1:0] io_in;
    wire  [`MPRJ_IO_PADS-1:0] io_out;
    wire  [`MPRJ_IO_PADS-1:0] io_oeb;

    // Ibex SoC
    reg HCLK, HRESETn;

    wire [3:0]		fdi;
    wire [3:0]    	fdo;
    wire [3:0]      fdio;
    wire     	    fdoe;
    wire          	fsclk;
    wire          	fcen;

    wire [15: 0] GPIOIN_Sys0_S2;
    wire [15: 0] GPIOOUT_Sys0_S2;
    wire [15: 0] GPIOPU_Sys0_S2;
    wire [15: 0] GPIOPD_Sys0_S2;
    wire [15: 0] GPIOOEN_Sys0_S2;
    wire [3:0] db_reg_Sys0;

    wire [0: 0] RsRx_Sys0_SS0_S0;
    wire [0: 0] RsTx_Sys0_SS0_S0;
    
    wire [0: 0] RsRx_Sys0_SS0_S1;
    wire [0: 0] RsTx_Sys0_SS0_S1;

    wire [0: 0] MSI_Sys0_SS0_S2;
    wire [0: 0] MSO_Sys0_SS0_S2;
    wire [0: 0] SSn_Sys0_SS0_S2;
    wire [0: 0] SCLK_Sys0_SS0_S2;

    wire [0: 0] MSI_Sys0_SS0_S3;
    wire [0: 0] MSO_Sys0_SS0_S3;
    wire [0: 0] SSn_Sys0_SS0_S3;
    wire [0: 0] SCLK_Sys0_SS0_S3;

    wire [0: 0] scl_i_Sys0_SS0_S4;
    wire [0: 0] scl_o_Sys0_SS0_S4;
    wire [0: 0] scl_oen_o_Sys0_SS0_S4;
    wire [0: 0] sda_i_Sys0_SS0_S4;
    wire [0: 0] sda_o_Sys0_SS0_S4;
    wire [0: 0] sda_oen_o_Sys0_SS0_S4;

    wire [0: 0] scl_i_Sys0_SS0_S5;
    wire [0: 0] scl_o_Sys0_SS0_S5;
    wire [0: 0] scl_oen_o_Sys0_SS0_S5;
    wire [0: 0] sda_i_Sys0_SS0_S5;
    wire [0: 0] sda_o_Sys0_SS0_S5;
    wire [0: 0] sda_oen_o_Sys0_SS0_S5;

    wire [0: 0] pwm_Sys0_SS0_S6;
    wire [0: 0] pwm_Sys0_SS0_S7;

    /* Ibex SoC - Wrapper Mapping */
    assign la_data_in[26] = HRESETn;
    assign la_data_in[24] = 1'b0;     // NMI
    assign la_data_in[23:0] = 8'd100; // CLK_DIV
    assign la_data_in[25] = 1'b0;     // IRQ
    
    
    assign io_in[13:0] = GPIOIN_Sys0_S2;
    assign GPIOOUT_Sys0_S2 = io_out[13:0];
    assign GPIOOEN_Sys0_S2 = ~io_oeb[13:0];

    assign io_in[17:14] = fdi;
    assign fdo = io_out[17:14];
    assign fdoe = ~io_oeb[17];
    assign fsclk = io_out[18];
    assign fcen = io_out[19];

    assign io_in[20] = RsRx_Sys0_SS0_S0;
    assign RsTx_Sys0_SS0_S0 = io_out[21];

    assign io_in[22] = RsRx_Sys0_SS0_S1;
    assign RsTx_Sys0_SS0_S1 = io_out[23];

    assign io_in[24] = MSI_Sys0_SS0_S2;
    assign MSO_Sys0_SS0_S2 = io_out[25];
    assign SSn_Sys0_SS0_S2 = io_out[26];
    assign SCLK_Sys0_SS0_S2 = io_out[27];

    assign io_in[28] = MSI_Sys0_SS0_S3;
    assign MSO_Sys0_SS0_S3 = io_out[29];
    assign SSn_Sys0_SS0_S3 = io_out[30];
    assign SCLK_Sys0_SS0_S3 = io_out[31];

    assign io_in[32] = scl_i_Sys0_SS0_S4;
    assign scl_o_Sys0_SS0_S4 = io_out[32];
    assign scl_oen_o_Sys0_SS0_S4 = io_oeb[32];
    assign sda_i_Sys0_SS0_S4 = io_in[33];
    assign sda_o_Sys0_SS0_S4 = io_out[33];
    assign sda_oen_o_Sys0_SS0_S4 = io_oeb[33];

    assign io_in[34] = scl_i_Sys0_SS0_S5;
    assign scl_o_Sys0_SS0_S5 = io_out[34];
    assign scl_oen_o_Sys0_SS0_S5 = io_oeb[34];
    assign sda_i_Sys0_SS0_S5 = io_in[35];
    assign sda_o_Sys0_SS0_S5 = io_out[35];
    assign sda_oen_o_Sys0_SS0_S5 = io_oeb[35];

    assign pwm_Sys0_SS0_S6 = io_out[36];
    assign pwm_Sys0_SS0_S7 = io_out[37];

    /* Program Flash */
    assign fdio = fdoe ? fdo : 4'bzzzz;
    assign fdi = fdio;

    sst26wf080b flash(
        .SCK(fsclk),
        .SIO(fdio),
        .CEb(fcen)
    );

    /* N5 Wrapper */
    user_project_wrapper UUT (
        `ifdef USE_POWER_PINS
            .vdda1(),	// User area 1 3.3V supply
            .vdda2(),	// User area 2 3.3V supply
            .vssa1(),	// User area 1 analog ground
            .vssa2(),	// User area 2 analog ground
            .vccd1(1'b1),	// User area 1 1.8V supply
            .vccd2(),	// User area 2 1.8v supply
            .vssd1(1'b0),	// User area 1 digital ground
            .vssd2(),
        `endif

        .wb_clk_i(HCLK),
        .wb_rst_i(HRESETn),
        // unconnected
        .wbs_stb_i(),
        .wbs_cyc_i(),
        .wbs_we_i(),
        .wbs_sel_i(),
        .wbs_dat_i(),
        .wbs_adr_i(),
        .wbs_ack_o(),
        .wbs_dat_o(),

    // Logic Analyzer Signals
        .la_data_in(la_data_in),
        .la_data_out(la_data_out),
        .la_oen(la_oen),

    // IOs
        .io_in(io_in),
        .io_out(io_out),
        .io_oeb(io_oeb)
    );

    // GPIO Loopback!
    wire [13:0] GPIO_PINS;
    generate
        genvar i;
        for(i=0; i<14; i=i+1)
            assign GPIO_PINS[i] = GPIOOEN_Sys0_S2[i] ? GPIOOUT_Sys0_S2[i] : 1'bz;
    endgenerate
    assign GPIO_PINS[13:8] = GPIO_PINS[7:0];
    assign GPIOIN_Sys0_S2 = GPIO_PINS;

// Serial Terminal connected to UART0 TX*/
    terminal term(.rx(RsTx_Sys0_SS0_S0));

    // SPI SRAM connected to SPI0
    wire SPI_HOLD = 1'b1;
    M23LC512 SPI_SRAM(
        .RESET(~HRESETn),
        .SO_SIO1(MSI_Sys0_SS0_S2),
        .SI_SIO0(MSO_Sys0_SS0_S2),
        .CS_N(SSn_Sys0_SS0_S2),
        .SCK(SCLK_Sys0_SS0_S2),
        .HOLD_N_SIO3(SPI_HOLD)
	);

    // Load the application into the flash memory
    initial begin
        #1  $readmemh(`TEST_FILE, flash.I0.memory);
    end

    // Clock and Rest Generation
    initial begin
        //Inputs initialization
        HCLK = 0;
        HRESETn = 1'bx;        
        #50;
        HRESETn = 0;
        #100;
        @(posedge HCLK);
        HRESETn <= 1;
    end

    always #5 HCLK = ~ HCLK;

    // Dump file
    initial begin
        $dumpfile("Ibex_Wrapper_TB.vcd");
        $dumpvars(`SIM_LEVEL, Ibex_Wrapper_TB);
        #`SIM_TIME;
        $finish;
    end

    // Terminate the smulation with ebreak instruction.
    // Calculate the CPI using the CSRs
    /*
    always @ (posedge HCLK) 
        if(MUV.CPU.N5.instr_ebreak) begin
        //$display("CPI=%d.%0d", MUV.N5.CSR_CYCLE/MUV.N5.CSR_INSTRET,(MUV.N5.CSR_CYCLE%MUV.N5.CSR_INSTRET)*10/MUV.N5.CSR_INSTRET );
        $finish;
        end
    */

    // Monitor Flash memory reads
    //always @(posedge HCLK)
    //    if(MUV.N5.HTRANS[1] & MUV.N5.HREADY & MUV.N5.HSEL_FLASH)
    //    $display("Flash Read A:%X (%0t)", HADDR, $time);


    
endmodule

module terminal #(parameter bit_time = 160) (input rx);

    integer i;
    reg [7:0] char;
    initial begin
        forever begin
            @(negedge rx);
            i = 0;
            char = 0;
            #(3*bit_time/2);
            for(i=0; i<8; i=i+1) begin
                char[i] = rx;
                #bit_time;
            end
            $write("%c", char);
        end
    end


endmodule
