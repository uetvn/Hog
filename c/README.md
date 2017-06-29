<!---
/*******************************************************************************
// Project name   : LSI Design Contet
// File name      : README.md
// Created date   : Wed 22 Mar 2017
// Author         : Huy Hung Ho
// Last modified  : Mon 17 Apr 2017
// Desc           :
*******************************************************************************/
-->
Human detection by Histogram of Oriented Gradients
==================================================

# Features
* File/Folder structure:
    * main.c : main code
    * lib/   : 3rd libraries
    * inc/   : include files
    * src/   : source files
    * build/ : excute files
    * build/sourceImages:   source images
    * build/sclaeImages:    stored result images

# Requirements
* [**gcc**](https://gcc.gnu.org/)
* [**makefile**](https://www.gnu.org/software/make/manual/make.html)
* [**cmake**](https://cmake.org/)


# Installation
* Compile and Run:
    * Go to "build" directory
    * Run "cmake path/to/CMakeList.txt"
    * Run "make"
    * Move an image to "build" directory
    * Run "./auto.sh <file>.png"

* Example comple and run in linux:
    * sislab$ cd build/
    * sislab$ cmake ../
    * sislab$ make
    * sislab$ mv sourceImages/test_pos_1.png
    * sislab$ ./auto test_pos_1.png

* Ps: Result stored in "scaleImages" directory

# Tips


