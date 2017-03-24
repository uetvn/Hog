<!---
t:/*******************************************************************************
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
* The size of a persion in the image depends on the distance from camera to the
  persion, then it needs been resized wigth other scale. We choose the scales is 1; 1/1.25; 1/1.25^2; 1/1.25^3; 1/1.25^4

## Read/Write each PNG image use [lodepng](http://lodev.org/lodepng/) library

## Convert RGB to Gray image
* Y = 0.298912 * R + 0.58611 * G + 0.114478 * B

## Scan extend image windows of 130x66 from 128x64
* This process takes a 130x66 pixel gray scale image (128x64 with a pixel each
border for computing the gradients at the edges)

## Calculate HOG feature of 128x64 image window
* Calculate HOG feature desciption for the image window, returning a 3,780 values column vector.
* The intent of this process to implement the same design choices as the original HOG descriptor for [Human detection by Dalal and Triggs](http://ieeexplore.ieee.org/document/1467360/).
* Specifically, I'm using the following parameter choices:
	* 8x8 pixel cells
	* Block of 2x2 cells
	* 50% overlap between blocks
	* 9 bin histogram each cell
* The above prameter give a final HOG desciption of each windows image is matrix
  3780 values.
* Serial:
	* Get block cell of 16x16
	* Divide block into cells of 8x8
	* Calculate gradient magnitude and angle of each pixel in cell
	* Calculate HOG in each cell of block
	* Normalize each block with L2 norm
	* Integreate all of HOG into matrix HOG of window image

## Detect object by SVM
* For detect object, this algorithm using linear SVM. Training [INRIA Person Dataset](http://pascal.inrialpes.fr/data/human/) to create SVM trained matrix.
* Convolution between HOG matrix and SVM trained matrix and determine whenther the object in window image
* Integrate all of true object

## Draw the bounding box(es) around true object


# Features
* File/Folder structure:
	* png/lodepng.c:		librabry read/write PNG imge
	* lsi_2017.c:			main code
	* png/helper.c:			auxiliary fuctions
	* png/human_detection.c:	convert RGB2Y, scan window image, get block cell
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


