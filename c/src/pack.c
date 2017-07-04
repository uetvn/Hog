/*
 * Project name   : Human detection by HOG
 * File name      : pack.c
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#include <stdio.h>
#include <stdlib.h>
#include <pack.h>

/* Convert RGB to Y of an image */
unsigned RGB2Y_img(uint8 *result, uint8 *rgb, uint32 w, uint32 h)
{
    uint32	i;
    for (i = 0; i < w * h; i++)
        result[i] = RGB_to_Y(rgb[3 * i], rgb[3 * i + 1], rgb[3 * i + 2]);
	return 0;
}

unsigned saving_object(uint32 *object, uint32 head)
{
    uint32  n_object = object[0];
    object[n_object + 1] = head;
    object[0]++;
}

unsigned readFileFloats(float *result, const char *name, int N)
{
        FILE *myFile;
        myFile = fopen(name, "r");

        if (myFile == NULL) {
            printf("Error Reading File %s\n", name);
            return  1;
        }

        int i;
        for (i = 0; i < N; i++)
        fscanf(myFile, "%f ", &result[i]);

        fclose(myFile);
        return 0;
}

unsigned init_hog_row(struct HOG_row **hog_row)
{
    *hog_row	= malloc(sizeof(struct HOG_row) * rows);
	uint8	i;
    for (i = 0; i < rows; i++)
        (*hog_row)[i].hog_block_16x16 = malloc(sizeof(float) * 37);
}

unsigned init_hog_window(struct HOG_window **hog_column)
{
	*hog_column	= malloc(sizeof(struct HOG_window) * columns);
	uint8	i;
    for (i = 0; i < columns; i++) {
        (*hog_column)[i].hog_row = malloc(sizeof(struct HOG_row) * rows);
		init_hog_row(&(*hog_column)[i].hog_row);
	}
}

unsigned free_hog_row(struct HOG_row *hog_row)
{
    uint8   i;
    for (i = 0; i < rows; i++)
        free(hog_row[i].hog_block_16x16);
    free(hog_row);
    return 0;
}

unsigned free_hog_window(struct HOG_window *hog_column)
{
    uint8 i;
    for (i = 0; i < columns; i++)
        free_hog_row(hog_column[i].hog_row);
    free(hog_column);
    return 0;
}

unsigned store_matrix_uint8(uint8 *data, uint32 width, uint32 height, char *filename)
{
	printf("Store matrix: %s (%d, %d).\n", filename, width, height);

    FILE    *output = fopen(filename, "w");
    if (data == NULL || height * width <= 0) {
        printf("Error: Cannot print matrix to file \n");
        return 1;
    }

    uint32  i, j;
    for (i = 0; i < height; i++) {
        for (j = 0; j < width; j++)
            fprintf(output, "%d ", data[i * width + j]);
        fprintf(output, "\n");
    }
    fclose(output);

    printf("Success.\n");
    return 0;
}

unsigned store_matrix_int8(int8 *data, uint32 width, uint32 height, char *filename)
{
	printf("Matrix: %s (%d, %d).\n", filename, width, height);
    FILE    *output = fopen(filename, "w");
    if (data == NULL || width * height == 0) {
        printf("Error: Cannot print matrix to file \n");
        return 1;
    }

    uint32  i, j;
    for (i = 0; i < height; i++) {
        for (j = 0; j < width; j++)
            fprintf(output, "%d ", data[i * width + j]);
        fprintf(output, "\n");
    }
    fclose(output);

    printf("Success.\n");
    return 0;
}

unsigned store_matrix_float(float *data, uint32 width, uint32 height, char *filename)
{
    printf("Save matrix: %s (%d, %d). \n", filename, width, height);
    FILE    *output = fopen(filename, "w");
    if (data == NULL || width * height == 0) {
        printf("Error: Cannot print matrix to file \n");
        return 1;
    }

    uint32  i, j;
    for (i = 0; i < height; i++) {
        for (j = 0; j < width; j++)
            fprintf(output, "%.3f ", data[i * width + j]);
        fprintf(output, "\n");
    }
    fclose(output);

    printf("Success.\n");
    return 0;
}

unsigned store_hog_row(struct HOG_row *hog_row, char *filename)
{
    printf("Save HOG row: %s (%d). \n", filename, rows * 36);
    FILE    *output = fopen(filename, "w");
    if (hog_row == NULL) {
        printf("Error: Cannot print hog to file \n");
        return 1;
    }

    uint32 i, j;
    for (i = 0; i < rows; i++)
    for (j = 0; j < 36; j++)
        fprintf(output, "%.4f \n", hog_row[i].hog_block_16x16[j]);
    fclose(output);

    printf("Success. \n");
}

unsigned store_hog_window(struct HOG_window *hog_column, char *filename)
{
    printf("Save HOG window: %s (%d). \n", filename, rows * columns * 36);
    FILE    *output = fopen(filename, "w");
    if (hog_column == NULL) {
        printf("Error: Cannot print hog to file \n");
        return 1;
    }

    uint32 i, j, k;
    for (k = 0; k < columns; k++)
    for (i = 0; i < rows; i++)
    for (j = 0; j < 36; j++)
        fprintf(output, "%.4f \n", hog_column[k].hog_row[i].hog_block_16x16[j]);
    fclose(output);

    printf("Success. \n");
}

unsigned drawing_object(uint32 *object, uint8 *rgb_src, uint32 w, uint32 h)
{
    uint32  i;
    uint32  head;
    for (i = 0; i < object[0]; i++) {
        head    = object[i + 1];
        drawing_rectange(head, rgb_src, w, h);
    }
}

unsigned drawing_rectange(uint32 head, uint8 *rgb_src, uint32 w, uint32 h)
{
    uint32   i;
    for(i = 0; i < window_w; i++) {
        convert_color(head + i, rgb_src);
        convert_color(head + w * window_h + i, rgb_src);
    }
    for(i = 0; i < window_h; i++) {
        convert_color(head + i * w, rgb_src);
        convert_color(head + i * w + window_w, rgb_src);
    }


}

unsigned convert_color(uint32 head, uint8 *rgb_rc)
{
    rgb_rc[3 * head]     = 255;
    rgb_rc[3 * head + 1] = 255;
    rgb_rc[3 * head + 2] = 255;
    return 0;
}

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

const float LUT_angle[]  = {0.7854,0.46365,0.32175,0.24498,0.1974,0.16515,0.1419,0.12435,0.11066,0.099669,0.09066,0.083141,0.076772,0.071307,0.066568,0.062419,
1.1071,0.7854,0.588,0.46365,0.38051,0.32175,0.2783,0.24498,0.21867,0.1974,0.17985,0.16515,0.15265,0.1419,0.13255,0.12435,
1.249,0.98279,0.7854,0.6435,0.54042,0.46365,0.40489,0.35877,0.32175,0.29146,0.26625,0.24498,0.2268,0.21109,0.1974,0.18535,
1.3258,1.1071,0.9273,0.7854,0.67474,0.588,0.51915,0.46365,0.41822,0.38051,0.34877,0.32175,0.2985,0.2783,0.2606,0.24498,
1.3734,1.1903,1.0304,0.89606,0.7854,0.69474,0.62025,0.5586,0.5071,0.46365,0.42663,0.39479,0.36717,0.34302,0.32175,0.30288,
1.4056,1.249,1.1071,0.98279,0.87606,0.7854,0.70863,0.6435,0.588,0.54042,0.49935,0.46365,0.43241,0.40489,0.38051,0.35877,
1.4289,1.2925,1.1659,1.0517,0.95055,0.86217,0.7854,0.71883,0.66104,0.61073,0.56673,0.52807,0.49394,0.46365,0.43663,0.41241,
1.4464,1.3258,1.212,1.1071,1.0122,0.9273,0.85197,0.7854,0.72664,0.67474,0.6288,0.588,0.55165,0.51915,0.48996,0.46365,
1.4601,1.3521,1.249,1.1526,1.0637,0.98279,0.90975,0.84415,0.7854,0.73282,0.68573,0.6435,0.60554,0.57134,0.54042,0.51239,
1.4711,1.3734,1.2793,1.1903,1.1071,1.0304,0.96007,0.89606,0.83798,0.7854,0.73782,0.69474,0.6557,0.62025,0.588,0.5586,
1.4801,1.3909,1.3045,1.222,1.1442,1.0714,1.0041,0.942,0.88507,0.83298,0.7854,0.74195,0.70226,0.66597,0.63275,0.60229,
1.4877,1.4056,1.3258,1.249,1.176,1.1071,1.0427,0.98279,0.9273,0.87606,0.82885,0.7854,0.74542,0.70863,0.67474,0.6435,
1.494,1.4181,1.344,1.2723,1.2036,1.1384,1.0769,1.0191,0.96525,0.9151,0.86854,0.82538,0.7854,0.74838,0.71409,0.68232,
1.4995,1.4289,1.3597,1.2925,1.2278,1.1659,1.1071,1.0517,0.99946,0.95055,0.90483,0.86217,0.82242,0.7854,0.75093,0.71883,
1.5042,1.4382,1.3734,1.3102,1.249,1.1903,1.1342,1.0808,1.0304,0.98279,0.93805,0.89606,0.85671,0.81987,0.7854,0.75315,
1.5084,1.4464,1.3854,1.3258,1.2679,1.212,1.1584,1.1071,1.0584,1.0122,0.96851,0.9273,0.88848,0.85197,0.81765,0.7854};


