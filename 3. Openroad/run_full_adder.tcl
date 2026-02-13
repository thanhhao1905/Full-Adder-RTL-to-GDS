#############################################################
# OpenROAD MANUAL FLOW - FULL ADDER
#############################################################


puts "\n========================================="
puts "        OpenROAD - FULL ADDER "
puts "=========================================\n"


set ciel_version "0fe599b2afb6708d281543108caf8310912f54af"
set ::env(PDK_ROOT) "~/openlane/pdks/$ciel_version"
set ::env(PDK) "sky130A"
set pdk "$::env(PDK_ROOT)/$::env(PDK)"


read_lef "$pdk/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef"
read_lef "$pdk/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef"
read_liberty "$pdk/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"


read_verilog "./full_adder_synth.v"
link_design full_adder


report_design_area


if {[file exists constraints.sdc]} {
    read_sdc constraints.sdc
}


initialize_floorplan \
    -die_area  {0 0 80 80} \
    -core_area {5 5 75 75} \
    -site unithd


tapcell


make_tracks li1  -x_offset 0.17 -x_pitch 0.34 -y_offset 0.17 -y_pitch 0.34
make_tracks met1 -x_offset 0.17 -x_pitch 0.34 -y_offset 0.17 -y_pitch 0.34
make_tracks met2 -x_offset 0.23 -x_pitch 0.46 -y_offset 0.23 -y_pitch 0.46
make_tracks met3 -x_offset 0.34 -x_pitch 0.68 -y_offset 0.34 -y_pitch 0.68
make_tracks met4 -x_offset 0.46 -x_pitch 0.92 -y_offset 0.46 -y_pitch 0.92
make_tracks met5 -x_offset 1.70 -x_pitch 3.40 -y_offset 1.70 -y_pitch 3.40


place_pins \
    -hor_layers {met3} \
    -ver_layers {met4} \
    -corner_avoidance 10 \
    -min_distance 3


set_wire_rc -layer met2


global_placement
detailed_placement


global_route
detailed_route


write_def fulladder.def
write_verilog fulladder_preroute.v


puts "\n======= DONE FULL ADDER PnR =======\n"
exit
