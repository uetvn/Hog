/*******************************************************************************
// Project name   : Read/Write PNG
// File name      : rwpng.c
// Created date   : Fri 02 Dec 2016
// Author         : Ngoc-Sinh Nguyen
// Last modified  : Thu 19 Jan 2017
// Desc           :
*******************************************************************************/


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "lodepng.h"
#include "rwpng.h"

static const int YR = 19595, YB = 7471, YG = 38470;

#define GRAY_IMAGE 	1
#define MAX_PIXVALUE 	255

/*
 * Convert from RGB to Gray pixel image
 * r	is red ingredient
 * g	is green ingredient
 * b	is blue ingredient
 */
uint8 RGB_to_Y(uint8 r, uint8 g, uint8 b)
{
        uint tmp = ((r * YR  + g * YG + b * YB + 32768) >> 16);
        return tmp > 255 ? 255 : (tmp & 0xFF);
}


/*
 * Read PNG image to array
 */
void read_PNG(const char *iF, struct raw_img *img)
{
	img->color_space = LCT_RGB;
	img->bit_depth = 8;
	img->data = NULL;

	/* READ PNG */
	uint er;
	er = lodepng_decode_file(&img->data, &img->width, &img->height, iF, \
		img->color_space, img->bit_depth);
	if(er){
		printf("Err %u : %s\n", er, lodepng_error_text(er));
		exit(1);
	}

	return;
}

/*
 * Write array to RGB image
 */
void write_PNG(const char *oF, struct raw_img *img)
{
        lodepng_encode_file(oF, img->data, img->width, img->height, \
                        img->color_space, img->bit_depth);
        return;
}
