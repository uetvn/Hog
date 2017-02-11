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
	//TEST_DriverIntMatrix(ex_cell, 100, 10, "Ex_cell_8x8.txt");

	int	*dx;
	dx = Cal_dx(ex_cell);

	int	*dy;
	dy = Cal_dy(ex_cell);

	float	*magnit;
	magnit = Cal_magnit(dx, dy);

	float	*angle;
	angle = Cal_angle(dx, dy);
	//TEST_DriverFloatMatrix(angle, 64, 8, "Angle_cell_8x8.txt");

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
	uint8	left;
	uint8	mid;
	uint8	right;
	uint8	counter	= 0;
        uint8	i;
        for (i = 1; i <= cellSize; i++) {
		mid	= cellSize_extend*i + 1;
		left	= mid - 1;
		right	= mid + 1;
                result[counter++] = ex_cell[right] - ex_cell[left];

		mid	= cellSize_extend*i + 2;
		left	= mid - 1;
		right	= mid + 1;
                result[counter++] = ex_cell[right] - ex_cell[left];

		mid	= cellSize_extend*i + 3;
		left	= mid - 1;
		right	= mid + 1;
                result[counter++] = ex_cell[right] - ex_cell[left];

		mid	= cellSize_extend*i + 4;
		left	= mid - 1;
		right	= mid + 1;
                result[counter++] = ex_cell[right] - ex_cell[left];

		mid	= cellSize_extend*i + 5;
		left	= mid - 1;
		right	= mid + 1;
                result[counter++] = ex_cell[right] - ex_cell[left];

		mid	= cellSize_extend*i + 6;
		left	= mid - 1;
		right	= mid + 1;
                result[counter++] = ex_cell[right] - ex_cell[left];

		mid	= cellSize_extend*i + 7;
		left	= mid - 1;
		right	= mid + 1;
                result[counter++] = ex_cell[right] - ex_cell[left];

		mid	= cellSize_extend*i + 8;
		left	= mid - 1;
		right	= mid + 1;
                result[counter++] = ex_cell[right] - ex_cell[left];
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
	uint8	up;
	uint8	mid;
	uint8	down;
	uint8	counter	= 0;
        uint8	i;
        for (i = 1; i <= cellSize; i++) {
		mid	= cellSize_extend*i + 1;
		up	= mid - cellSize_extend;
                down	= mid + cellSize_extend;
		result[counter++] = ex_cell[down] - ex_cell[up];

		mid	= cellSize_extend*i + 2;
		up	= mid - cellSize_extend;
                down	= mid + cellSize_extend;
                result[counter++] = ex_cell[down] - ex_cell[up];

		mid	= cellSize_extend*i + 3;
		up	= mid - cellSize_extend;
                down	= mid + cellSize_extend;
                result[counter++] = ex_cell[down] - ex_cell[up];

		mid	= cellSize_extend*i + 4;
		up	= mid - cellSize_extend;
                down	= mid + cellSize_extend;
                result[counter++] = ex_cell[down] - ex_cell[up];

		mid	= cellSize_extend*i + 5;
		up	= mid - cellSize_extend;
                down	= mid + cellSize_extend;
                result[counter++] = ex_cell[down] - ex_cell[up];

		mid	= cellSize_extend*i + 6;
		up	= mid - cellSize_extend;
                down	= mid + cellSize_extend;
                result[counter++] = ex_cell[down] - ex_cell[up];

		mid	= cellSize_extend*i + 7;
		up	= mid - cellSize_extend;
                down	= mid + cellSize_extend;
                result[counter++] = ex_cell[down] - ex_cell[up];

		mid	= cellSize_extend*i + 8;
		up	= mid - cellSize_extend;
                down	= mid + cellSize_extend;
                result[counter++] = ex_cell[down] - ex_cell[up];
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
	uint8 	i;
	uint8 	p;
	for (i = 0; i < cellSize; i++)
	{
		p = i;
		result[p] = dx[p] * dx[p] + dy[p] * dy[p];
		result[p] = sqrt(result[p]);

		p = cellSize + i;
		result[p] = dx[p] * dx[p] + dy[p] * dy[p];
		result[p] = sqrt(result[p]);

		p = 2*cellSize + i;
		result[p] = dx[p] * dx[p] + dy[p] * dy[p];
		result[p] = sqrt(result[p]);

		p = 3*cellSize + i;
		result[p] = dx[p] * dx[p] + dy[p] * dy[p];
		result[p] = sqrt(result[p]);

		p = 4*cellSize + i;
		result[p] = dx[p] * dx[p] + dy[p] * dy[p];
		result[p] = sqrt(result[p]);

		p = 5*cellSize + i;
		result[p] = dx[p] * dx[p] + dy[p] * dy[p];
		result[p] = sqrt(result[p]);

		p = 6*cellSize + i;
		result[p] = dx[p] * dx[p] + dy[p] * dy[p];
		result[p] = sqrt(result[p]);

		p = 7*cellSize + i;
		result[p] = dx[p] * dx[p] + dy[p] * dy[p];
		result[p] = sqrt(result[p]);
/* Using LUT
		float	*LUT	= readFileFloat("LUT.txt", 16*16);
		p = j*cellSize + i;
		if (dx[p] < 16 && dy[p] < 16) {
			uint8	pointer	= dx[p]*16 + dy[p];
			result[p] = LUT[pointer];
		}
		else {
			result[p] = dx[p] * dx[p] + dy[p] * dy[p];
			result[p] = sqrt(result[p]);
		}
*/
	}
/*
	float	*Gauss_mask	= readFileFloats("mask_matrix.txt", 4 * length_cell);
	uint8	start_pointer;
	switch (serial) {
	case 1:
		start_pointer = 0;
		break;
	case 2:
		start_pointer = cellSize;
		break;
	case 3:
		start_pointer = cellSize * sizeBlock;
		break;
	case 4:
		start_pointer = cellSize * sizeBlock + cellSize;
		break;
	default:
		printf("Error mult Gauss matrix.\n");
		return NULL;
	}

	uint8	shift;
	for (i = 0; i < length_cell; i++) {
		shift	= i / cellSize * sizeBlock + i % cellSize;
		result[i] *= Gauss_mask[start_pointer + shift];
	}

	free(Gauss_mask);
*/
	return result;
}



/*
 * Calculate angle of gradient vector's cell
 */
float *Cal_angle(int *dx, int *dy)
{
	float	*result	= malloc(sizeof(float) * length_cell);
	uint8 	i;
	uint8 	p;
	for (i = 0; i < cellSize; i++)
	{
		p = i;
		result[p] = (float) dy[p] / (dx[p] + TINY_INT);
		result[p] = PI_DEGREE * atan(result[p]) / PI;

		p = cellSize + i;
		result[p] = (float) dy[p] / (dx[p] + TINY_INT);
		result[p] = PI_DEGREE * atan(result[p]) / PI;

		p = 2*cellSize + i;
		result[p] = (float) dy[p] / (dx[p] + TINY_INT);
		result[p] = PI_DEGREE * atan(result[p]) / PI;
		p = 3*cellSize + i;

		result[p] = (float) dy[p] / (dx[p] + TINY_INT);
		result[p] = PI_DEGREE * atan(result[p]) / PI;

		p = 4*cellSize + i;
		result[p] = (float) dy[p] / (dx[p] + TINY_INT);
		result[p] = PI_DEGREE * atan(result[p]) / PI;

		p = 5*cellSize + i;
		result[p] = (float) dy[p] / (dx[p] + TINY_INT);
		result[p] = PI_DEGREE * atan(result[p]) / PI;

		p = 6*cellSize + i;
		result[p] = (float) dy[p] / (dx[p] + TINY_INT);
		result[p] = PI_DEGREE * atan(result[p]) / PI;

		p = 7*cellSize + i;
		result[p] = (float) dy[p] / (dx[p] + TINY_INT);
		result[p] = PI_DEGREE * atan(result[p]) / PI;
	}

	for (i = 0; i < length_cell; i++)
		if (result[i] < 0)
			result[i] += PI_DEGREE;

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

		p = cellSize + i;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p = 2*cellSize + i;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p = 3*cellSize + i;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p = 4*cellSize + i;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p = 5*cellSize + i;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p = 6*cellSize + i;
		Add_HOG_pixel(result, magnit[p], angle[p]);

		p = 7*cellSize + i;
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

