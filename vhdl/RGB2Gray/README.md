<!---
/*******************************************************************************
// Project name   : LSI Contest 2017
// File name      : README.md
// Created date   : Mon 20 Mar 2017
// Author         : Huy Hung Ho
// Last modified  : Mon 20 Mar 2017
// Desc           :
*******************************************************************************/
-->
Introduction
============
Read RGB data from RAM, convert to Gray data and store in RAM

Features
========
- Algorithm: RAM_rgb2gray.pptx

- Code C: test_RGB2Gray.c

- Code VHDL:
	+ Main src: RGBtoGrayTop.vhd
	+ Using dual-port RAM in RAM directory
	+ Using own library in Helpzer directory
	+ RGb2gray pixel block: RGB2Gray.vhd
	+ Control path: Controll.vhd

Installation:
=============
- Compile all of entity
- Simulation with file RGBtoGrayTop.vhd
- Set Clk and Start = '1'


