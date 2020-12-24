
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
    $script_dir/../../verilog/rtl/ibex/*.v"

set ::env(GLB_RT_MAXLAYER) 5
set ::env(GLB_RT_ADJUSTMENT) 0.25

set ::env(PDN_CFG) $script_dir/pdn.tcl
 	
set ::env(DIODE_INSERTION_STRATEGY) "4"
