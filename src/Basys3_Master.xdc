## Clock Signal
set_property PACKAGE_PIN W5 [get_ports clk]							
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Reset Button (BTN0)
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PULLUP true [get_ports reset]

## Traffic Light Outputs (LEDs)
set_property PACKAGE_PIN U16 [get_ports red]
set_property IOSTANDARD LVCMOS33 [get_ports red]

set_property PACKAGE_PIN V16 [get_ports yellow]
set_property IOSTANDARD LVCMOS33 [get_ports yellow]

set_property PACKAGE_PIN W16 [get_ports green]
set_property IOSTANDARD LVCMOS33 [get_ports green]

## Car Sensor Input (BTN1)
set_property PACKAGE_PIN T18 [get_ports car]
set_property IOSTANDARD LVCMOS33 [get_ports car]
set_property PULLUP true [get_ports car]

## Pedestrian Button Input (BTN2)
set_property PACKAGE_PIN W19 [get_ports pedestrian]
set_property IOSTANDARD LVCMOS33 [get_ports pedestrian]
set_property PULLUP true [get_ports pedestrian]
