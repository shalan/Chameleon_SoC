# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) user_project_wrapper
set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(PDN_CFG) $script_dir/pdn.tcl
set ::env(FP_PDN_CORE_RING) 1
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 2920 3520"

set ::unit 2.4
set ::env(FP_IO_VEXTEND) [expr 2*$::unit]
set ::env(FP_IO_HEXTEND) [expr 2*$::unit]
set ::env(FP_IO_VLENGTH) $::unit
set ::env(FP_IO_HLENGTH) $::unit

set ::env(FP_IO_VTHICKNESS_MULT) 4
set ::env(FP_IO_HTHICKNESS_MULT) 4

set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_NET) "wb_clk_i"

set ::env(CLOCK_PERIOD) "10"

set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0
set ::env(DIODE_INSERTION_STRATEGY) 0

set ::env(PL_TARGET_DENSITY) 0.4

# Need to fix a FastRoute bug for this to work, but it's good
# for a sense of "isolation"
set ::env(MAGIC_ZEROIZE_ORIGIN) 0
set ::env(MAGIC_WRITE_FULL_LEF) 1
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

set ::env(VERILOG_FILES) "\
    $script_dir/../../rtl/acc/AHB_SPM.v
    $script_dir/../../rtl/IPs/AHBSRAM.v
    $script_dir/../../rtl/IPs/DFFRAMBB.v
    $script_dir/../../rtl/IPs/GPIO.v
    $script_dir/../../rtl/IPs/APB_I2C.v
    $script_dir/../../rtl/IPs/APB_SPI.v
    $script_dir/../../rtl/IPs/APB_UART.v
    $script_dir/../../rtl/IPs/DMC_32x16HC.v
    $script_dir/../../rtl/IPs/i2c_master.v
    $script_dir/../../rtl/IPs/PWM32.v
    $script_dir/../../rtl/IPs/QSPI_XIP_CTRL.v
    $script_dir/../../rtl/IPs/spi_master.v
    $script_dir/../../rtl/IPs/TIMER32.v
    $script_dir/../../rtl/IPs/WDT32.v
    $script_dir/../../rtl/AHB_sys_0/APB_sys_0/*.v
    $script_dir/../../rtl/AHB_sys_0/*.v
    $script_dir/../../rtl/NfiVe32.v
    $script_dir/../../rtl/DFFRFile.v
	$script_dir/../../rtl/soc_core.v
    $script_dir/../../rtl/user_project_wrapper.v"

set ::env(VERILOG_FILES_BLACKBOX) "\
	$script_dir/../../rtl/IPs/DFFRAM.v
	$script_dir/../../rtl/IPs/RAM_4Kx32.v"

set ::env(EXTRA_LEFS) "\
	$script_dir/../../lef/RAM_4Kx32.lef"

# set ::env(EXTRA_GDS_FILES) "\
# 	$script_dir/../../gds/RAM_5Kx32.gds"
