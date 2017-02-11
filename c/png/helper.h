/*******************************************************************************
// Project name   : LSI contest 2017
// File name      : helper.h
// Created date   : Wed 07 Dec 2016
// Author         : Huy Hung Ho
// Last modified  : implementation
// Desc           : Declare the auxiliary functions
******************************************************************************/

#ifndef HELPER_H
#define HELPER_H

#include "mytypes.h"
#include <stdlib.h>

#define PI				3.1416
#define PI_DEGREE			180
#define MAX_DETECTS			100
#define BIAS				-3.35
#define TINY_INT			0.00001
#define window_h			128
#define window_w			64
#define numBins				9
#define numBins_block			36
#define cellSize			8
#define cellSize_extend			10
#define sizeBlock			16
#define sizeBlock_extend		18
#define SVMnumber			3780
#define	extend_w			66
#define extend_h			130
#define length_extend			8580	// extend_w*extend_h
#define length_window			8192	// window_w*window_h
#define length_cell			64	// cellSize*cellSize
#define	length_cell_extend		100

/*
 * Struct store position
 * - nWindow	is location position in image
 * - resizeSize	is scale size
 * - score	is result of SVM classifition
 */
struct Object {
        uint32 nWindows, resizeSize;
        float score;
};

/*
 * Convert image data from RGB to Gray
 * - width 	is width of img_data
 * - height 	is height of img_data
 */
uint8 *RGB_to_Gray_img (uint8 *img_data, uint32 width, uint32 height);

/*
 * Convert a image pixel to white colour
 * - i 	is location of image pixel
 */
void RGB_to_White(uint8 *data, uint32 i);

/*
 * Draw the rectange at position
 * - nDetects 		is number of position
 * - save_detects	is the infor of position
 */
void Draw (struct raw_img *img, uint8 *nDetects, struct Object *save_detects);

/*
 * Detect position from SVM classifition
 * - nDetects 		is number of position
 * - save_detects 	is the info of position
 * - loc 		is location of position
 * - score		is result of SVM classification
 */
void Detect(struct Object *save_detects, uint8 *nDetects, uint32 loc, float score);

/*
 * Read a float file to array
 * N	is number of floats in file
 *
 * Result: float array
 */
float *readFileFloats(const char *name, int N);

/*
 * Creat a file save matrix input
 * - data       is store matrix
 * - length     is length of matrix
 * - width      is length of width
 * - filename   is name of file save matrix
 */
uint8 TEST_DriverIntMatrix(uint8 *data, uint32 length, uint32 width, char *filename);
uint8 TEST_DriverFloatMatrix(float *data, uint32 length, uint32 width, char *filename);

#endif
