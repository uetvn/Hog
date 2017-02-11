/*******************************************************************************
// Project name   : LSI contest 2017
// File name      : human_detection.c
// Created date   : Wed 07 Dec 2016
// Author         : Huy Hung Ho
// Last modified  : Sun 18 Dec 2016
// Desc           : Main algorithm human detection
******************************************************************************/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "rwpng.h"
#include "helper.h"
#include "human_detection.h"
#include "Cal_HOG_block.h"


/*
 * Main process fuction of human detection
 * - img		is RGB data of image
 * - nDetects		is number of position
 * - save_detects	is the info of position
 */
void Human_detection(struct raw_img *img, uint8 *nDetects, struct Object *save_detects) {
	/* Declare variable in main */
	uint32  img_size        = img->height * img->width;
	float   *magnit         = malloc(sizeof(float) * length_window);
	float   *angles         = malloc(sizeof(float) * length_window);
	float   *HOG_window     = malloc(sizeof(float) * SVMnumber);

	/* Convert image data from RGB to Gray  */
	uint8   *Gray_data;
	Gray_data = RGB_to_Gray_img(img->data, img->width, img->height);

	/* Scan each extend window image overlap */
	uint32	i		= 0;
	uint32	end_point	= img->width * (extend_h - 1);
	while (i < img_size - end_point) {

		uint8   *ex_window;
		ex_window = Get_extend_window_data(Gray_data, img->width, i);

		float 	*HOG_Feature;
		HOG_Feature = Cal_HOG_window(ex_window);

		SVM_Classification(HOG_Feature, nDetects, save_detects, i);

		/* Check down the next row extend window */
			i += cellSize;
		if (i % img->width > img->width - extend_w) {
			uint32	curRow	= i / img->width;
			i = (curRow + cellSize) * img->width;
		}
	}

	free(magnit);
	free(angles);
	free(HOG_window);

	return;
}


/*
 * Compare between HOG feature and SVM feature to detect
 * - nDetects		is number of position
 * - save_detects	is the info of position
 * - pointer		is extend window pointer
 */
void SVM_Classification(float *HOG_Feature, uint8 *nDetects, struct Object *save_detects, uint32 pointer)
{
	float   *trainSVM       = readFileFloats("trainSVM_matrix.txt", SVMnumber);
	float	score		= BIAS;

	uint32	i;
	for (i = 0; i < SVMnumber; i++) {
		score += HOG_Feature[i] * trainSVM[i];
	}
	if (score > 0.0) {
		save_detects[*nDetects].nWindows = pointer;
		save_detects[*nDetects].resizeSize = 1;
		save_detects[*nDetects].score = score;
		(*nDetects)++;
	}

	free(trainSVM);

	return;
}

/*
 * Calculate HOG feature of extend window image
 *
 */
float *Cal_HOG_window(uint8 *ex_window)
{
	float 	*result;
	result = malloc(sizeof(float) * SVMnumber);
	uint32	HOG_pointer	= 0;
	uint32	start_point;
	uint32  i		= 0;

	/* Cell 1 */
	uint8	*ex_cell_1;
	uint8	*ex_cell_2;
	uint8	*ex_cell_3;
	uint8	*ex_cell_4;
	start_point = i;
	ex_cell_1 = Get_cell_data(ex_window, start_point);
	float 	*HOG_cell_1;
	HOG_cell_1 = Cal_HOG_cell(ex_cell_1);

	/* Cell 3 */
	start_point = i + cellSize  * extend_w;
	ex_cell_3 = Get_cell_data(ex_window, start_point);
	float 	*HOG_cell_3;
	HOG_cell_3 = Cal_HOG_cell(ex_cell_3);

	while (HOG_pointer < SVMnumber) {
		/* Cell 4 */
		start_point = i + cellSize * (extend_w + 1);
		ex_cell_4 = Get_cell_data(ex_window, start_point);
		float 	*HOG_cell_4;
		HOG_cell_4 = Cal_HOG_cell(ex_cell_4);

		/* Cell 2 */
		start_point = i + cellSize;
		ex_cell_2 = Get_cell_data(ex_window, start_point);
		float 	*HOG_cell_2;
		HOG_cell_2 = Cal_HOG_cell(ex_cell_2);

		float *HOG_block;
		HOG_block = Cal_HOG_block(HOG_cell_1, HOG_cell_2, HOG_cell_3, HOG_cell_4);

		L2_Norm(HOG_block);

		free(HOG_cell_1);
		free(HOG_cell_3);

		HOG_cell_1 = HOG_cell_2;
		HOG_cell_3 = HOG_cell_4;


		Add_HOG_Feature(result, HOG_block, &HOG_pointer);


		/* Check down the next row extend cell */
			i += cellSize;
		if (i % extend_w > extend_w - sizeBlock) {
			uint32	curRow	= i / extend_w;
			i = (curRow + cellSize) * extend_w;
		}
	}

	//TEST_DriverFloatMatrix(result, 3780, 1, "HOG_3780.txt");
	return result;
}


/*
 * Normalization HOG block feature
 */
void L2_Norm(float *HOG_block)
{
	float	norm	= 0;
	uint8	i;
	for(i = 0; i < numBins_block; i++)
		norm += HOG_block[i] * HOG_block[i];
	for(i = 0; i < numBins_block; i++)
		HOG_block[i] /= sqrt(norm) + TINY_INT;

	return;
}


/*
 * Add HOG block into HOG Feature
 * - HOG_pointer	is location start add HOG feature
 */
void Add_HOG_Feature(float *HOG_Feature, float *HOG_block, uint32 *HOG_pointer)
{
	uint32	i;
	for (i = 0; i < numBins_block; i++) {
		HOG_Feature[*HOG_pointer + i] = HOG_block[i];
	}
	*HOG_pointer += numBins_block;

	return;
}


/*
 * Calculate HOG feature of a block from four cells
 */
float *Cal_HOG_block(float *HOG_cell_1, float *HOG_cell_2, float *HOG_cell_3, float *HOG_cell_4)
{
	float 	*result		= malloc(sizeof(float) * numBins_block);
	uint8	i;

	for (i = 0; i < numBins; i++)
		result[i] = HOG_cell_1[i % numBins];
	//getchar();

        for (i = numBins; i < 2*numBins; i++)
                result[i] = HOG_cell_2[i % numBins];

        for (i = 2*numBins; i < 3*numBins; i++)
                result[i] = HOG_cell_3[i % numBins];

        for (i = 3*numBins; i < 4*numBins; i++)
                result[i] = HOG_cell_4[i % numBins];

	return result;
}


/*
 * Get extend window image data from gray image data
 * - data		is gray image data
 * - width		is width of gray image data
 * - start_point	is place start count window image
 */
uint8 *Get_extend_window_data(uint8 *data, uint32 width, uint32 start_point)
{
	uint8	*result	= malloc(sizeof(uint8) * length_extend);

	uint32	counter	= 0;
	uint32  i;
	for (i = start_point; counter < length_extend; i++) {
		result[counter++] = data[i];
		if (counter % extend_w == 0)
			i += width - extend_w;
	}
	return result;
}

/*
 * Get cell data from window data
 * The second quardrant of block data
 * - data		is extend cell data
 * - start_point        is location where start get cell of window image
 */
uint8 *Get_cell_data(uint8 *data, uint32 start_point)
{
	uint8	*result	= malloc(sizeof(uint8) * length_cell_extend);

	uint32 counter	= 0;
	uint32 i;
	for (i = start_point; counter < length_cell_extend; i++) {
		result[counter++] = data[i];
		if (counter % cellSize_extend == 0)
			i += window_w - cellSize;
	}

	return result;
}

