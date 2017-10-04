vcom ../rtl/approximatedDivision.vhd
vcom ../rtl/window_norm_comp.vhd
vcom ./tb_module/tb_window_norm_comp.vhd

vsim tb_window_norm_comp
layout load simulate
add wave -radix unsigned *
config wave -signalnamewidth 1
run 3 ns
