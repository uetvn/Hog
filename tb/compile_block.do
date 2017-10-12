vcom ../rtl/approx_div.vhd
vcom ../rtl/block_norm_comp.vhd
vcom ./tb_module/tb_block_norm_comp.vhd

vsim tb_block_norm_comp
layout load Simulate
add wave -radix unsigned *
config wave -signalnamewidth 1
run 10 ns
