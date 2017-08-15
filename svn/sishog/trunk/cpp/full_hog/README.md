<!---
t:/*******************************************************************************
// Project name   : LSI Design Contest
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
	* Run "./auto.sh <img_file>"

* Example comple and run in linux:
	* sislab$ cd build/
	* sislab$ cmake ../
	* sislab$ make
	* sislab$ ./auto TEST.jpg

# Tips


