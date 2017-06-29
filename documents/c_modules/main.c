/*******************************************************************************
// Project name   :
// File name      : lsi_2017.c
// Created date   : Fri 02 Dec 2016 04:44:17 PM ICT
// Author         : Ngoc-Sinh Nguyen, Huy-Hung Ho
// Last modified  : Fri 02 Dec 2016 06:14:17 PM ICT
// Desc           : Human detection by Histogram of Oriented Gradient
*******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pack.h>
#include "rwpng.h"

#define  header 1923

int main(int argc, char *argv[])
{

	unsigned char	*iF = "test_pos_1.png";
	unsigned char 	oF[100];
	struct raw_img 	img;

	int c	= 0;
	while( (c = getopt(argc, argv, "i:")) != -1 )
		switch (c){
		case 'i':
			iF = optarg;
		default:
			break;
		}
	if(optind > argc){
		fprintf(stderr, "Expect argument after option\n");
		return 1;
	}

	/* Read file PNG */
	read_PNG(iF, &img);
	printf("Loaded PNG: %s \n", iF);

    /* MY TODO */
    uint32  width   = img.width;
    uint32  height  = img.height;
    uint8   *src    = malloc(sizeof(uint8) * width * height);
    uint32  *object = malloc(sizeof(uint32) * 100);

   /* Conver rgb to y */
    RGB2Y_img(src, img.data, width, height);

    /* Calculate HOG of image */
    scan_window(object, src, width, height);
    printf("%d \n", object[0]);

    /* Drawing the rectange of position object */
    drawing_object(object, img.data, width, height);

	/* Write file PNG */
	sprintf(&oF, "hog_%s", iF);
	write_PNG(oF, &img);
	printf("Saved PNG: %s \n", oF);
	return 0;
}

