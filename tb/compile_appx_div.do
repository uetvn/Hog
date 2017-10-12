vcom ../rtl/appx_div.vhd
vcom ./tb_module/tb_appx_div.vhd

vsim tb_appx_div
layout load Simulate
add wave -radix unsigned *
config wave -signalnamewidth 1
run 105676700 ns
