<!---
/*******************************************************************************
// Project name   : LSI Design Contet
// File name      : REAME.md
// Created date   : Wed 22 Mar 2017
// Author         : Huy Hung Ho
// Last modified  : Wed 22 Mar 2017
// Desc           :
*******************************************************************************/
-->
Human detection by Histogram of Oriented Gradients
==================================================

# Introduction
In this project I using HOG (Histogram of Oriented Gradients) algorithm to
get feature desciptor and use SVM algorithm to detect human in a image. This
code build on gcc 5.4.0.


# Algorithm
## Resize image use imagemagick of shell
* Scale: 1; 1/1.25; 1/1.25^2; 1/1.25^3; 1/1.25^4

## Read/Write PNG image use [lodepng](http://lodev.org/lodepng/) library

## Convert RGB to Gray image

## Scan extend image windows of 130x66 from 128x64

## Calculate HOG feature of image window
* Get block cell of 16x16
* Divide block into cells 8x8
* Calculate gradient magnitude and anle of each pixells in cell
* Calculate HOG in each cell of block
* Normalize each block
* Integreate all of HOG into matrix HOG of window image

## Detect object by SVM
* Convolution between HOG matrix and SVM trained matrix
* Result convolution calculate determine whenther the object in window image
* Integrate all of true object

## Draw the bounding box(es) around true object


# Features
* File/Folder structure:
	* png/lodepng.c:		librabry read/write PNG imge
	* lsi_2017.c:			main code
	* png/helper.c:			auxiliary fuctions
	* png/human_detection.c:	convert RGB2Y, ccan, get block cell
	* png/Cal_HOG_block.c:		calculate HOG of each block
	* png/SVMclassification.c:	detect object and store

# Requirements
* [**gcc**](https://gcc.gnu.org/)
* [**makefile**](https://www.gnu.org/software/make/manual/make.html)
* [**cmake**](https://cmake.org/)


# Installation
* Compile and Run:
	* Go to "install" directory
	* Run "cmake path/to/CMakeList.txt"
	* Run "make"
	* Run "./hog -i <file>.png"

* Example comple and run in linux:
	* sislab$ cd install/
	* sislab$ cmake ../
	* sislab$ make
	* sislab$ ./hog -i src.png


# Tips


