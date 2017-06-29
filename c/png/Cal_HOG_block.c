/*******************************************************************************
// Project name   : LSI contest 2017
// File name      : Cal_HOG_block.c
// Created date   : Wed 07 Dec 2016
// Author         : Huy Hung Ho
// Last modified  : Thu 19 Jan 2017
// Desc           : Calulate HOG block of window image
******************************************************************************/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "rwpng.h"
#include "helper.h"
#include "Cal_HOG_block.h"

/*
 * Calculate HOG feature of a cell
 */
float *Cal_HOG_cell(uint8 *ex_cell)
{
	float	*result;

	int	*dx;
	dx = Cal_dx(ex_cell);

	int	*dy;
	dy = Cal_dy(ex_cell);

	float	*magnit;
	magnit = Cal_magnit(dx, dy);

	float	*angle;
	angle = Cal_angle(dx, dy);
/*
	TEST_DriverIntMatrix(dx, 64, 8, "dx_cell_8x8.txt");
	TEST_DriverIntMatrix(dy, 64, 8, "dy_cell_8x8.txt");
	TEST_DriverFloatMatrix(angle, 64, 8, "angle_cell_8x8.txt");
    getchar();
*/
	result = HOG(magnit, angle);

	free(dx);
	free(dy);
	free(magnit);
	free(angle);

	return result;
}


/*
 * Calulate derivative x of a cell
 */
int *Cal_dx(uint8 *ex_cell)
{
        int	*result = malloc(sizeof(result) * length_cell);
	uint8	i;
	for (i = 0; i <= cellSize; i++) {
		result[i]	= ex_cell[i + 12] - ex_cell[i + 10];
		result[i + 8]	= ex_cell[i + 22] - ex_cell[i + 20];
		result[i + 16]	= ex_cell[i + 32] - ex_cell[i + 30];
		result[i + 24]	= ex_cell[i + 42] - ex_cell[i + 40];
		result[i + 32]	= ex_cell[i + 52] - ex_cell[i + 50];
		result[i + 40]	= ex_cell[i + 62] - ex_cell[i + 60];
		result[i + 48]	= ex_cell[i + 72] - ex_cell[i + 70];
		result[i + 56]	= ex_cell[i + 82] - ex_cell[i + 80];
	}
	for (i = 0; i < length_cell; i++)
		result[i]  = result[i] < 0 ? 0 : result[i];

        return result;
}


/*
 * Calulate derivative y of a cell
 */
int *Cal_dy(uint8 *ex_cell)
{
        int	*result = malloc(sizeof(result) * length_cell);

	uint8	i;
	for (i = 0; i < cellSize; i++) {
		result[i]	= ex_cell[i + 21] - ex_cell[i + 1];
		result[i + 8]	= ex_cell[i + 31] - ex_cell[i + 11];
		result[i + 16]	= ex_cell[i + 41] - ex_cell[i + 21];
		result[i + 24]	= ex_cell[i + 51] - ex_cell[i + 31];
		result[i + 32]	= ex_cell[i + 61] - ex_cell[i + 41];
		result[i + 40]	= ex_cell[i + 71] - ex_cell[i + 51];
		result[i + 48]	= ex_cell[i + 81] - ex_cell[i + 61];
		result[i + 56]	= ex_cell[i + 91] - ex_cell[i + 71];
	}
	for (i = 0; i < length_cell; i++)
		result[i]  = result[i] < 0 ? 0 : result[i];

        return result;
}


/*
 * Calculate magnitude of gradient vector's cell
 */
float *Cal_magnit(int *dx, int *dy)
{
	float	*result	= malloc(sizeof(float) * length_cell);
	uint8 	i, j;
	uint8 	p;
	for (i = 0; i < cellSize; i++)
	{
		p = i;
        for (j = 0; j < cellSize; j++) {
            if (dx[p] == 0)
                result[p] = dy[p];
            else if (dy[p] == 0)
                result[p] = dx[p];
            else if (dx[p] < 17 && dy[p] < 17)
                result[p] = LUT_magnit[(dx[p] - 1) * 16 + dy[p] - 1];
            else {
                result[p] = dx[p] * dx[p] + dy[p] * dy[p];
                result[p] = sqrt(result[p]);
            }
            p += cellSize;
        }
	}
	return result;
}



/*
 * Calculate angle of gradient vector's cell
 */
float *Cal_angle(int *dx, int *dy)
{
	float	*result	= malloc(sizeof(float) * length_cell);
	uint8 	i, j;
	uint8 	p;
	for (i = 0; i < cellSize; i++)
	{
		p = i;
        for (j = 0; j < cellSize; j++) {
            if (dy[p] == 0)
                result[p] = 0;
            else if (dx[p] == 0)
                result[p] = PI_DEGREE/2;
            else if (dx[p] < 17 && dy[p] < 17)
                result[p] = LUT_angle[(dy[p] - 1) * 16 + dx[p] - 1];
            else {
                result[p] = (float) dy[p] / (dx[p] + TINY_FLOAT);
                result[p] = PI_DEGREE * atan(result[p]) / PI;
            }
            if (result[i] < 0)
                result[i] += PI_DEGREE;
            p += cellSize;
        }
	}
    return result;
}


/*
 * Calulate 9 bins HOG from gradient vector's cell
 */
float *HOG(float *magnit, float *angle)
{
	float	*result	= calloc(sizeof(float), numBins);
	uint8 	i;
	uint8	p;
	for (i = 0; i < cellSize; i++)
	{
		p = i;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p += cellSize;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p += cellSize;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p += cellSize;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p += cellSize;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p += cellSize;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p += cellSize;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p += cellSize;
		Add_HOG_pixel(result, magnit[p], angle[p]);
	}


	return result;
}


/*
 * Add HOG feature into array store
 * - HOG_cell	is array store HOG feature of a cell
 * - magnit_i	is magnitude at i point
 * - angle_i	is angle at i point
 */
void Add_HOG_pixel(float *HOG_cell, float magnit_i, float angle_i)
{
	if (angle_i < 10)
		angle_i += PI_DEGREE;

	uint8	w		= PI_DEGREE/numBins;
	uint8	binLeft		= (int) (angle_i / w - 0.5) % numBins;
	uint8	binRight	= (binLeft + 1) % numBins;
	uint8	centerLeft	= w * binLeft + w / 2;

	float	rightPart	= magnit_i*(angle_i - centerLeft) / w;
	float	leftPart	= magnit_i - rightPart;

	HOG_cell[binLeft] 	+= leftPart;
	HOG_cell[binRight]	+= rightPart;


	return;
}

