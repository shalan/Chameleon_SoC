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

package require openlane
set script_dir [file dirname [file normalize [info script]]]

prep -design $script_dir -tag user_project_wrapper -overwrite
set save_path $script_dir/../..

run_synthesis

init_floorplan

place_io_ol

global_placement_or

set margin_x 200
set margin_y 150

add_macro_placement _5518_ 200 150 N
add_macro_placement _5519_ 1600 150 N
add_macro_placement _5520_  200 1950 S

add_macro_placement core.ahb_sys_0_uut.S0.CACHE 2100 2650 N
# CPU
add_macro_placement core.ibex_core  2150 1700 N
# APB
add_macro_placement core.ahb_sys_0_uut.apb_sys_inst_0  1480 2650 N

manual_macro_placement f

tap_decap_or

global_placement_or

set ::env(_VDD_NET_NAME) vccd1
set ::env(_GND_NET_NAME) vssd1
set ::env(_V_OFFSET) 14
set ::env(_H_OFFSET) $::env(_V_OFFSET)
set ::env(_V_PITCH) 180
set ::env(_H_PITCH) 180
set ::env(_V_PDN_OFFSET) 0
set ::env(_H_PDN_OFFSET) 0
set ::env(_SPACING) 1.7
set ::env(_WIDTH) 3

set power_domains [list {vccd1 vssd1} {vccd2 vssd2} {vdda1 vssa1} {vdda2 vssa2}]

set ::env(CONNECT_GRIDS) 1
foreach domain $power_domains {
	set ::env(_VDD_NET_NAME) [lindex $domain 0]
	set ::env(_GND_NET_NAME) [lindex $domain 1]
	gen_pdn

	set ::env(CONNECT_GRIDS) 0
	set ::env(_V_OFFSET) \
	[expr $::env(_V_OFFSET) + 2*($::env(_WIDTH)+$::env(_SPACING))]
	set ::env(_H_OFFSET) \
	[expr $::env(_H_OFFSET) + 2*($::env(_WIDTH)+$::env(_SPACING))]
	set ::env(_V_PDN_OFFSET) [expr $::env(_V_PDN_OFFSET)+6*$::env(_WIDTH)]
	set ::env(_H_PDN_OFFSET) [expr $::env(_H_PDN_OFFSET)+6*$::env(_WIDTH)]
}

detailed_placement

run_cts

detailed_placement

run_routing

write_powered_verilog -power vccd1 -ground vssd1
set_netlist $::env(lvs_result_file_tag).powered.v

run_magic
run_magic_spice_export

save_views       -lef_path $::env(magic_result_file_tag).lef \
                 -def_path $::env(tritonRoute_result_file_tag).def \
                 -gds_path $::env(magic_result_file_tag).gds \
                 -mag_path $::env(magic_result_file_tag).mag \
                 -save_path $save_path \
                 -tag $::env(RUN_TAG)

run_magic_drc

run_lvs; # requires run_magic_spice_export

run_antenna_check
