############################
# Zybo On-board BTN3 Push-button#
############################
set_property PACKAGE_PIN Y16 [get_ports btn_tri_io]
set_property IOSTANDARD LVCMOS33 [get_ports btn_tri_io]

set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property PACKAGE_PIN M14 [get_ports {leds[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property PACKAGE_PIN M15 [get_ports {leds[1]}]

set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property PACKAGE_PIN G14 [get_ports {leds[2]}]

set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property PACKAGE_PIN D18 [get_ports {leds[3]}]