/*******************************************************************************
// Project name   : LSI contest 2017
// File name      : helper.c
// Created date   : Wed 07 Dec 2016
// Author         : Huy Hung Ho
// Last modified  : Thu 19 Jan 2017
// Desc           : Implementation auxiliary functions
******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "rwpng.h"
#include "mytypes.h"
#include "helper.h"

const float LUT_magnit[]    = {1.4142,2.2361,3.1623,4.1231,5.099,6.0828,7.0711,8.0623,9.0554,10.05,11.045,12.042,13.038,14.036,15.033,16.031,
2.2361,2.8284,3.6056,4.4721,5.3852,6.3246,7.2801,8.2462,9.2195,10.198,11.18,12.166,13.153,14.142,15.133,16.125,
3.1623,3.6056,4.2426,5,5.831,6.7082,7.6158,8.544,9.4868,10.44,11.402,12.369,13.342,14.318,15.297,16.279,
4.1231,4.4721,5,5.6569,6.4031,7.2111,8.0623,8.9443,9.8489,10.77,11.705,12.649,13.601,14.56,15.524,16.492,
5.099,5.3852,5.831,6.4031,7.0711,7.8102,8.6023,9.434,10.296,11.18,12.083,13,13.928,14.866,15.811,16.763,
6.0828,6.3246,6.7082,7.2111,7.8102,8.4853,9.2195,10,10.817,11.662,12.53,13.416,14.318,15.232,16.155,17.088,
7.0711,7.2801,7.6158,8.0623,8.6023,9.2195,9.8995,10.63,11.402,12.207,13.038,13.892,14.765,15.652,16.553,17.464,
8.0623,8.2462,8.544,8.9443,9.434,10,10.63,11.314,12.042,12.806,13.601,14.422,15.264,16.125,17,17.889,
9.0554,9.2195,9.4868,9.8489,10.296,10.817,11.402,12.042,12.728,13.454,14.213,15,15.811,16.643,17.493,18.358,
10.05,10.198,10.44,10.77,11.18,11.662,12.207,12.806,13.454,14.142,14.866,15.62,16.401,17.205,18.028,18.868,
11.045,11.18,11.402,11.705,12.083,12.53,13.038,13.601,14.213,14.866,15.556,16.279,17.029,17.804,18.601,19.416,
12.042,12.166,12.369,12.649,13,13.416,13.892,14.422,15,15.62,16.279,16.971,17.692,18.439,19.209,20,
13.038,13.153,13.342,13.601,13.928,14.318,14.765,15.264,15.811,16.401,17.029,17.692,18.385,19.105,19.849,20.616,
14.036,14.142,14.318,14.56,14.866,15.232,15.652,16.125,16.643,17.205,17.804,18.439,19.105,19.799,20.518,21.26,
15.033,15.133,15.297,15.524,15.811,16.155,16.553,17,17.493,18.028,18.601,19.209,19.849,20.518,21.213,21.932,
16.031,16.125,16.279,16.492,16.763,17.088,17.464,17.889,18.358,18.868,19.416,20,20.616,21.26,21.932,22.627};

const float LUT_angle[]  = {45,26.565,18.435,14.036,11.31,9.4623,8.1301,7.125,6.3402,5.7106,5.1944,4.7636,4.3987,4.0856,3.8141,3.5763,
63.435,45,33.69,26.565,21.801,18.435,15.945,14.036,12.529,11.31,10.305,9.4623,8.7462,8.1301,7.5946,7.125,
71.565,56.31,45,36.87,30.964,26.565,23.199,20.556,18.435,16.699,15.255,14.036,12.995,12.095,11.31,10.62,
75.964,63.435,53.13,45,38.66,33.69,29.745,26.565,23.962,21.801,19.983,18.435,17.103,15.945,14.931,14.036,
78.69,68.199,59.036,51.34,45,39.806,35.538,32.005,29.055,26.565,24.444,22.62,21.038,19.654,18.435,17.354,
80.538,71.565,63.435,56.31,50.194,45,40.601,36.87,33.69,30.964,28.61,26.565,24.775,23.199,21.801,20.556,
81.87,74.055,66.801,60.255,54.462,49.399,45,41.186,37.875,34.992,32.471,30.256,28.301,26.565,25.017,23.629,
82.875,75.964,69.444,63.435,57.995,53.13,48.814,45,41.634,38.66,36.027,33.69,31.608,29.745,28.072,26.565,
83.66,77.471,71.565,66.038,60.945,56.31,52.125,48.366,45,41.987,39.289,36.87,34.695,32.735,30.964,29.358,
84.289,78.69,73.301,68.199,63.435,59.036,55.008,51.34,48.013,45,42.274,39.806,37.569,35.538,33.69,32.005,
84.806,79.695,74.745,70.017,65.556,61.39,57.529,53.973,50.711,47.726,45,42.51,40.236,38.157,36.254,34.509,
85.236,80.538,75.964,71.565,67.38,63.435,59.744,56.31,53.13,50.194,47.49,45,42.709,40.601,38.66,36.87,
85.601,81.254,77.005,72.897,68.962,65.225,61.699,58.392,55.305,52.431,49.764,47.291,45,42.879,40.914,39.094,
85.914,81.87,77.905,74.055,70.346,66.801,63.435,60.255,57.265,54.462,51.843,49.399,47.121,45,43.025,41.186,
86.186,82.405,78.69,75.069,71.565,68.199,64.983,61.928,59.036,56.31,53.746,51.34,49.086,46.975,45,43.152,
86.424,82.875,79.38,75.964,72.646,69.444,66.371,63.435,60.642,57.995,55.491,53.13,50.906,48.814,46.848,45};

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
