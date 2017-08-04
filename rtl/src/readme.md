<!---
/*******************************************************************************
// Project name   :
// File name      : readme.md
// Created date   : Thứ ba 06/27/17
// Author         : Huy Hung Ho
// Last modified  : Thứ ba 06/27/17
// Desc           :
*******************************************************************************/
-->
Introduction
============
Information about all files in this directory.

Features
========
- line_buf.vhd
	+ input:  ser_data(8)
	+ output: Gx(8), Gy(8)
	+ TODO: throw out

- square_root_unsigned.vhd (package sqrt_pkg)

- squart.vhd (haved TB)
	+ input:  data_in(8)
	+ output: data_out(4)

- n_bits_sub.vhd
	+ input:  A(8), B(8)
	+ output: sub(1 + 7)

- cal_gradient.vhd
	+ input:  data_in(80)
	+ output: Gx_row(64), Gy_row(64)

- bin_selection.vhd
	+ input:  Gx(8), Gy(8)
	+ output: bin(4), rate(16)

- hist_generator.vhd
	+ input:  Gx_row(64), Gy_row(64)
	+ output: hist_out
	+ TODO: everything

- classification.vhd
	+ input: hist_out
	+ output: bias
