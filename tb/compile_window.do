vcom ../rtl/appx_div.vhd
vcom ../rtl/sqrt32.vhd
vcom ../rtl/config_pkg.vhd
vcom ../rtl/window_norm_comp.vhd
vcom ./tb_module/tb_window_norm_comp.vhd

vsim tb_window_norm_comp
layout load Simulate
add wave -radix unsigned *
config wave -signalnamewidth 1
run 1000 ns
