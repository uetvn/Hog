/*
 * Project name   : Human detection by HOG
 * File name      : hog_window.h
 * Created date   : Wed 19 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Wed 19 Apr 2017
 * Desc           :
 */

#ifndef HOG_WINDOW_H
#define HOG_WINDOW_H

#include "pack.h"

/*
 * object     : array stored detected object coordinates
 * w		  : width of the image window
 * h		  : height of the image window
 * Description: raster scan in row each image window and calculating hog feature.
 */
unsigned hog_window(uint32 *object, uint8 *src, uint32 w, uint32 h);

/*
 * Desciption: with first window in each row, raster scan in row each block 16x16 and calculating hog feature.
 */
unsigned hog_prime_window(struct HOG_window *hog_column, uint32 head, uint8 *src, uint32 w, uint32 h);

/*
 * head		 : head coordinates of image window
 * Desciption: with following windows in each row, reausing a part of hog feature of previous window and calculate the rest.
 */
unsigned hog_next_window(struct HOG_window *hog_column, uint32 head, uint8 *src, uint32 w, uint32 h);

/*
 * head		 : head corrdinates of first block in row
 * Desciption: calculating hog feature of first block of each row
 */
unsigned hog_prime_row(struct HOG_row *hog_row, uint32 head, uint8 *src, uint32 w, uint32 h);

/*
 * head		 : head coordinates of following block in row
 * Desciption: calculating hog feature of following block of each row by reausing of previous block
 */
unsigned hog_next_row(struct HOG_row *hog_row, uint32 head, uint8 *src, uint32 w, uint32 h);

/*
 * head		 : head coordinate of block 16x16
 * Desciption: calculating hog feature of block 16x16
 */
unsigned hog_block_16x16(float *result, uint32 head, uint8 *src, uint32 w, uint32 h);

/*
 * Desciption: normalizating hog feature's neighboring 8x8 pixel blocks to increase rebustness to texture and illumination variation
 */
unsigned norm_block_16x16(float *result, int32 *block1, int32 *block2, int32 *block3, int32 *block4);

/*
 * head		 : head coordinate of block 8x8
 * Desciption: the image window is divied into non-overlapping 8x8 pixels to calculating smallest hog feature unit
 */
unsigned hog_block_8x8(int32 *hist_9bin, uint32 head, uint8 *src, uint32 w, uint32 h);

/*
 * Desciption: calculating dervavite with respect to x of block
 */
unsigned dx_block_8x8(int8 *result, uint32 head, uint8 *src, uint32 w);

/*
 * Desciption: calculating dervavite with respect to x of block
 */
unsigned dy_block_8x8(int8 *result, uint32 head, uint8 *src, uint32 w, uint32 h);

/*
 * Desciption: calculating a histogram of the gradient orientations with 9 bins is generated of each 8x8 pixel block
 */
unsigned calculate_hist_9bin(int32 *hist_9bin, int8 *dx, int8 *dy);


unsigned hist_pixel(int8 dx, int8 dy, int8 *bin_select, int32 *magnit1, int32 *magnit2);

/*
 * Desciption: calculating dervavite with respect to x of pixel
 */
int8 dx_pixel(uint32 head, uint8 *src, uint32 w);

/*
 * Desciption: calculating dervavite with respect to y of pixel
 *
 */
int8 dy_pixel(uint32 head, uint8 *src, uint32 w, uint32 h);

#endif
