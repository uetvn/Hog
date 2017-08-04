<!---
/*******************************************************************************
// Project name   :
// File name      : README.md
// Created date   : Wed 19 Jul 2017 10:57:04 AM +07
// Author         : Ngoc-Sinh Nguyen
// Last modified  : Wed 19 Jul 2017 10:57:04 AM +07
// Desc           :
*******************************************************************************/
-->
# Introduction

Reference CPP source code for VHDL modules

    src/pix_bin_comp.{cpp,h}        Implementation of modules: calculate magnitute and angle of a pixel (HOG)
    src/config.h                    Config
    tests/main_pix_bin_comp.cpp     Main program of pix_bin_comp, which generates reference testcases
    Makefile

# Generate testcases for HDL modules

```
    make
    cd build/ && ./pix_bin_comp > inf.txt
```
