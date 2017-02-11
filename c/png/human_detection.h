/*******************************************************************************
// Project name   : LSI contest 2017
// File name      : human_detection.h
// Created date   : Wed 07 Dec 2016
// Author         : Huy Hung Ho
// Last modified  : Sun 18 Dec 2016
// Desc           : Main algorithm human detection
******************************************************************************/

#ifndef HUMAN_DETECTION_H
#define HUMAN_DETECTION_H

#include "mytypes.h"

/*
 * Main process fuction of human detection
 * - img                is RGB data of image
 * - nDetects           is number of position
 * - save_detects       is the info of position
 */
void Human_detection(struct raw_img *img,uint8 *nDetects,struct Object *save_detects);

/*
 * Calculate HOG feature of extend window image
 *
 */
float *Cal_HOG_window(uint8 *ex_window);

/*
 * Compare between HOG feature and SVM feature to detect
 * - nDetects           is number of position
 * - save_detects       is the info of position
 */
void SVM_Classification(float *HOG_Feature, uint8 *nDetects, struct Object *save_detects, uint32 i);

/*
 * Get extend window image data from gray image data
 * - data               is gray image data
 * - width              is width of gray image data
 * - start_point        is place start count window image
 */
uint8 *Get_extend_window_data(uint8 *data, uint32 width, uint32 start_point);

/*
 * Get cell data  from window data
 * The second quardrant of block data
 * - data  	is extend cell data
 * - start_point	is location where start get cell of window image
 */
uint8 *Get_cell_data(uint8 *data, uint32 start_point);

/*
 * Calculate HOG feature of block from four cells
 */
float *Cal_HOG_block(float *HOG_cell_1, float *HOG_cell_2, float *HOG_cell_3, float *HOG_cell_4);

/*
 * Normalization HOG block feature
 */
void L2_Norm(float *HOG_block);

#endif
