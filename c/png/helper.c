/*******************************************************************************
// Project name   : LSI contest 2017
// File name      : helper.c
// Created date   : Wed 07 Dec 2016
// Author         : Huy Hung Ho
// Last modified  : Thu 19 Jan 2017
// Desc           : Implementation auxiliary functions
******************************************************************************/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "rwpng.h"
#include "helper.h"

/*
 * Convert image data from RGB to Gray
 * - width 	is width of img_data
 * - height 	is height of img_data
 */
uint8 *RGB_to_Gray_img (uint8 *img_data, uint32 width, uint32 height)
{
        uint32  length          = width * height;
        uint8   *result         = malloc(length * sizeof(uint8));

        uint32  i;
        for (i = 0; i < length; i++)
                result[i] = RGB_to_Y(img_data[3 * i], img_data[3 * i + 1], img_data[3 * i + 2]);

        return result;
}

/*
 * Convert a image pixel to white colour
 * - i 	is location of image pixel
 */
void RGB_to_White(uint8 *data, uint32 i)
{
        data[3 * i] = data[3 * i + 1] = data[3 * i + 2] = 255;
}


/*
 * Draw the rectange at position
 * - nDetects 		is number of position
 * - save_detects	is the info of position
 */
void Draw (struct raw_img *img, uint8 *nDetects, struct Object *save_detects)
{
	uint counter;
	for (counter = 0; counter < *nDetects; counter++) {
                uint32  start_point     = save_detects[counter].nWindows;
                uint32  i;
                for (i = 0; i < window_h; i++) {
                        RGB_to_White(img->data, start_point + i * img->width);
                        RGB_to_White(img->data, start_point + (window_w-1) + i * img->width);
                }

                uint32 last_row = start_point + img->width * window_h;
                for (i = 0; i < window_w; i++) {
                        RGB_to_White(img->data, start_point + i);
                        RGB_to_White(img->data, last_row + i);
                }
        }
}

/*
 * Detect position from SVM classifition
 * - nDetects 		is number of position
 * - save_detects 	is the info of position
 * - loc 		is location of position
 * - score		is reusult of SVM classification
 */
void Detect(struct Object *save_detects, uint8 *nDetects, uint32 loc, float score)
{
        if (score > 0.0) {
                save_detects[*nDetects].nWindows = loc;
                save_detects[*nDetects].resizeSize = 1;
                save_detects[*nDetects].score = score;
                (*nDetects)++;
        }
}

/*
 * Read a float file to array
 * - N	is number of floats in file
 *
 * Result: float array
 */
float *readFileFloats(const char *name, int N)
{
        FILE *myFile;
        myFile = fopen(name, "r");

        float *numberArray = malloc(sizeof(float) * N);

        if (myFile == NULL) {
        printf("Error Reading File %s\n", name);
        return  NULL;
        }

        int i;
        for (i = 0; i < N; i++)
        fscanf(myFile, "%f ", &numberArray[i] );

        fclose(myFile);
        return numberArray;
}

/*
 * Creat a file save matrix input
 * - data	is store matrix
 * - length	is length of matrix
 * - width	is length of width
 * - filename	is name of file save matrix
 */
uint8 TEST_DriverIntMatrix(uint8 *data, uint32 length, uint32 width, char *filename)
{
	printf("Save matrix: %s (%d, %d) ", filename, length, width);
	FILE	*output	= fopen(filename, "w");
	uint32 i;
	if (data == NULL || length == 0) {
		printf("Error: Cannot print matrix to file \n");
		return 1;
	}

	for (i = 0; i < length; i++) {
		if (i % width == 0)
			fprintf(output, "\n");
		fprintf(output, "%d ", data[i]);
	}
	fclose(output);

	printf("-> Success. \n");
	return 0;
}
uint8 TEST_DriverFloatMatrix(float *data, uint32 length, uint32 width, char *filename)
{
	printf("Save matrix: %s (%d, %d) ", filename, length, width);
	FILE	*output	= fopen(filename, "w");
	uint32 i;
	if (data == NULL || length == 0) {
		printf("Error: Cannot print matrix to file \n");
		return 1;
	}

	for (i = 0; i < length; i++) {
		fprintf(output, "%.4f ", data[i]);
		if (i % width == 0)
			fprintf(output, "\n");
	}
	fclose(output);

	printf("-> Success. \n");
	return 0;
}
