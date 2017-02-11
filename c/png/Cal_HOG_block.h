/*******************************************************************************
// Project name   : LSI contest 2017
// File name      : Cal_HOG_block.h
// Created date   : Wed 07 Dec 2016
// Author         : Huy Hung Ho
// Last modified  : Thu 19 Jan 2017
// Desc           :
******************************************************************************/

#ifndef CAL_HOG_BLOCK_H
#define CAL_HOG_BLOCK_H

#include "mytypes.h"

/*
 * Calculate HOG feature of a cell
 */
float *Cal_HOG_cell(uint8 *ex_cell);

/*
 * Calulate derivative x of a cell
 */
int *Cal_dx(uint8 *ex_cell);

/*
 * Calulate derivative y of a cell
 */
int *Cal_dy(uint8 *ex_cell);

/*
 * Calculate magnitude of gradient vector's cell
 */
float *Cal_magnit(int *dx, int *dy);

/*
 * Calculate angle of gradient vector's cell
 */
float *Cal_angle(int *dx, int *dy);

/*
 * Calulate 9 bins HOG from gradient vector's cell
 */
float *HOG(float *magnit, float *angle);

/*
 * Add HOG feature into array store
 * - HOG_cell   is array store HOG feature of a cell
 * - magnit_i   is magnitude at i point
 * - angle_i    is angle at i point
 */
void Add_HOG_pixel(float *HOG_cell, float magnit_i, float angle_i);

#endif
