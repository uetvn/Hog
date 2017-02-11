/*
 * Author	: Ngoc-Sinh Nguyen, 2015
 * Description	: Image I/O functions and struct
 *
 */

#ifndef RW_PNG_H
#define RW_PNG_H

#include "mytypes.h"
#include "lodepng.h"

struct raw_img{
        uint32 width;
        uint32 height;
        uint8 *data;
        LodePNGColorType color_space;
        uint8 bit_depth;

};

/*
 * iF		: input image name
 * img		: image
 * Description	:
 */
void read_PNG(const char *iF, struct raw_img *img);


/*
 * iF           : output image name
 * img          : image
 * Description  :
 */
void write_PNG(const char *oF, struct raw_img *img);

#endif
