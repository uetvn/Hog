/*
 * Project name   : Human detection by HOG
 * File name      : HOG_block_8x8.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */

#include "hog_block_8x8.h"

unsigned hog_block_8x8(float *hog_9bin, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    /* Calculate derivative with respect to x */
    int8    *dx    = malloc(sizeof(int8) * 64);
    dx_block_8x8(dx, head, src, w);

    /* Calculate derivative with respect to y */
    int8    *dy    = malloc(sizeof(int8) * 64);
    dy_block_8x8(dy, head, src, w, h);

    /* Calculate magnitude */
    float   *magnit = malloc(sizeof(float) * 64);
    magnit_block(magnit, dx, dy, 8, 8);

    /* Calculate angle */
    float   *angle = malloc(sizeof(float) * 64);
    angle_block(angle, dx, dy, 8, 8);

    /* Vote vector gradient to 9 bin hog feature */
	calculate_hog_9bin(hog_9bin, magnit, angle);

	return 0;
}

unsigned calculate_hog_9bin(float *hog_9bin, float *magnit, float *angle)
{
    uint8   numBins     = 9;
    float   binSize     = PI / numBins;

    float   d10         = PI / 180 * 10;
    float   d30         = d10 + binSize;
    float   d50         = d30 + binSize;
    float   d70         = d50 + binSize;
    float   d90         = d70 + binSize;
    float   d110        = d90 + binSize;
    float   d130        = d110 + binSize;
    float   d150        = d130 + binSize;
    float   d170        = d150 + binSize;


    uint8   i;
    for (i = 0; i < 9; i++)
        hog_9bin[i] = 0.0;

    float   part_left, part_right;
    for (i = 0; i < 64; i++) {
        if (angle[i] < 0)
            angle[i] = angle[i] + PI;

        if (angle[i] >= 0 && angle[i] < d10) {
            part_right  = (angle[i] + d10) / binSize  * magnit[i];
            part_left   = magnit[i] - part_right;
            hog_9bin[8] += part_left;
            hog_9bin[0] += part_right;
        }
        else if (angle[i] >= d10 && angle[i] < d30) {
            part_right  = (angle[i] - d10) / binSize  * magnit[i];
            part_left   = magnit[i] - part_right;
            hog_9bin[0] += part_left;
            hog_9bin[1] += part_right;
        }
        else if (angle[i] >= d30 && angle[i] < d50) {
            part_right  = (angle[i] - d30) / binSize  * magnit[i];
            part_left   = magnit[i] - part_right;
            hog_9bin[1] += part_left;
            hog_9bin[2] += part_right;
        }
        else if (angle[i] >= d50 && angle[i] < d70) {
            part_right  = (angle[i] - d50) / binSize  * magnit[i];
            part_left   = magnit[i] - part_right;
            hog_9bin[2] += part_left;
            hog_9bin[3] += part_right;
        }
        else if (angle[i] >= d70 && angle[i] < d90) {
            part_right  = (angle[i] - d70) / binSize  * magnit[i];
            part_left   = magnit[i] - part_right;
            hog_9bin[3] += part_left;
            hog_9bin[4] += part_right;
        }
        else if (angle[i] >= d90 && angle[i] < d110) {
            part_right  = (angle[i] - d90) / binSize  * magnit[i];
            part_left   = magnit[i] - part_right;
            hog_9bin[4] += part_left;
            hog_9bin[5] += part_right;
        }
        else if (angle[i] >= d110 && angle[i] < d130) {
            part_right  = (angle[i] - d110) / binSize  * magnit[i];
            part_left   = magnit[i] - part_right;
            hog_9bin[5] += part_left;
            hog_9bin[6] += part_right;
        }
        else if (angle[i] >= d130 && angle[i] < d150) {
            part_right  = (angle[i] - d130) / binSize  * magnit[i];
            part_left   = magnit[i] - part_right;
            hog_9bin[6] += part_left;
            hog_9bin[7] += part_right;
        }
        else if (angle[i] >= d150 && angle[i] < d170) {
            part_right  = (angle[i] - d150) / binSize  * magnit[i];
            part_left   = magnit[i] - part_right;
            hog_9bin[7] += part_left;
            hog_9bin[8] += part_right;
        }
        else {
            part_right  = (angle[i] - d170) / binSize * magnit[i];
            part_left   = magnit[i] - part_right;
            hog_9bin[8] += part_left;
            hog_9bin[0] += part_right;
        }
    }
}

/*
unsigned hog_pixel(float *hog_9bin, float magnit, float angle)
{
	uint8	numBins		= 9;
	uint8   w       	= PI_DEGREE / numBins;

    uint8   bin_left	= (int) (angle / w - 0.5) % numBins;
    uint8   bin_right	= (bin_left + 1) % numBins;
    uint8   bin_center	= w * bin_left + w / 2;

    float   part_right	= magnit * (angle - bin_center) / w;
    float   part_left	= magnit - part_right;

    hog_9bin[bin_left]	+= part_left;
    hog_9bin[bin_right]	+= part_right;

    printf("%f %f | %d %d | %f %f\n", magnit, angle, bin_left, bin_right, part_left, part_right);
	return 0;
}
*/
