
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

set ::env(DESIGN_NAME) ibex_wrapper
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 600 800"
set ::env(GLB_RT_OBS) "met5 $::env(DIE_AREA)"

set ::env(CLOCK_PORT) "HCLK"
set ::env(CLOCK_NET) "HCLK"

set ::env(CLOCK_PERIOD) "8"

set ::env(ROUTING_CORES) 10

set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0

set ::env(SYNTH_STRATEGY) 3

set ::env(PL_TARGET_DENSITY) 0.7
set ::env(CELL_PAD) 0

set ::env(DESIGN_IS_CORE) 0
# Need to fix a FastRoute bug for this to work, but it's good
# for a sense of "isolation"
set ::env(MAGIC_ZEROIZE_ORIGIN) 0
set ::env(MAGIC_WRITE_FULL_LEF) 0
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

set ::env(VERILOG_FILES) "\
   $script_dir/../../verilog/rtl/ibex/ibex_core.v
   $script_dir/../../verilog/rtl/ibex/ibex_pmp.v
   $script_dir/../../verilog/rtl/ibex/ibex_controller.v
   $script_dir/../../verilog/rtl/ibex/ibex_decoder.v
   $script_dir/../../verilog/rtl/ibex/ibex_id_stage.v
   $script_dir/../../verilog/rtl/ibex/ibex_wb_stage.v
   $script_dir/../../verilog/rtl/ibex/ibex_ex_block.v
   $script_dir/../../verilog/rtl/ibex/ibex_branch_predict.v
   $script_dir/../../verilog/rtl/ibex/ibex_icache.v
   $script_dir/../../verilog/rtl/ibex/ibex_compressed_decoder.v
   $script_dir/../../verilog/rtl/ibex/ibex_prefetch_buffer.v
   $script_dir/../../verilog/rtl/ibex/ibex_if_stage.v
   $script_dir/../../verilog/rtl/ibex/ibex_register_file_latch.v
   $script_dir/../../verilog/rtl/ibex/ibex_cs_registers.v
   $script_dir/../../verilog/rtl/ibex/ibex_csr.v
   $script_dir/../../verilog/rtl/ibex/ibex_register_file_ff.v
   $script_dir/../../verilog/rtl/ibex/ibex_load_store_unit.v
   $script_dir/../../verilog/rtl/ibex/ibex_alu.v
   $script_dir/../../verilog/rtl/ibex/ibex_counter.v
   $script_dir/../../verilog/rtl/ibex/ibex_dummy_instr.v
   $script_dir/../../verilog/rtl/ibex/ibex_multdiv_fast.v
   $script_dir/../../verilog/rtl/ibex/ibex_multdiv_slow.v
   $script_dir/../../verilog/rtl/ibex/prim_clock_gating.v 
   $script_dir/../../verilog/rtl/ibex/ibex_fetch_fifo.v
   $script_dir/../../verilog/rtl/ibex/ibex_wrapper.v"

#set ::env(VERILOG_FILES_BLACKBOX) "$script_dir/../../verilog/rtl/ibex/ibex_fetch_fifo.v"
    
set ::env(GLB_RT_MAXLAYER) 5
set ::env(GLB_RT_ADJUSTMENT) 0.25

set ::env(PDN_CFG) $script_dir/pdn.tcl
 	
set ::env(DIODE_INSERTION_STRATEGY) "4"
