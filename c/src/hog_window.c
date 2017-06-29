/*
 * Project name   : Human detection by HOG
 * File name      : hog_window.c
 * Created date   : Wed 12 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Fri 14 Apr 2017
 * Desc           :
 */

#include <math.h>
#include "hog_window.h"

unsigned hog_window(uint32 *object, uint8 *src, uint32 w, uint32 h)
{
    struct HOG_window *hog;
    init_hog_window(&hog);
    object[0] = 0; // first element stores the number of detected

    uint32  head, i;
    uint32  tail = w * (h - window_h);
    uint8  *is_detected = malloc(sizeof(uint8));

    for (head = 0; head <= tail; head += 8 * w) {
        hog_prime_window(hog, head, src, w, h);

        svm_window(is_detected, hog);

        if (*is_detected)
            saving_object(object, head);

        for (i = head; i <=  head + w - window_w; i += 8) {
            hog_next_window(hog, i, src, w, h);

            svm_window(is_detected, hog);

            if (*is_detected)
                saving_object(object, i);
        }
    }

    free_hog_window(hog);
    return 0;
}

unsigned hog_prime_window(struct HOG_window *hog_column, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    uint8   i;
    for (i = 0; i < columns; i++) {
        hog_prime_row(hog_column[i].hog_row, head, src, w, h);
        head    += 8 * w;
    }
    return 0;
}

unsigned hog_next_window(struct HOG_window *hog_column, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    uint8   i;
    for (i = 0; i < columns; i++) {
        hog_next_row(hog_column[i].hog_row, head, src, w, h);
        head    += 8 * w;
    }
    return 0;
}

unsigned hog_prime_row(struct HOG_row *hog_row, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    float   *hog_8x8_1    = malloc(sizeof(float) * 9);
    float   *hog_8x8_2    = malloc(sizeof(float) * 9);
    float   *hog_8x8_3    = malloc(sizeof(float) * 9);
    float   *hog_8x8_4    = malloc(sizeof(float) * 9);

    /* Precalcultion */
    hog_block_8x8(hog_8x8_1,  head,         src, w, h);
    hog_block_8x8(hog_8x8_2,  head + 8 * w, src, w, h);

    uint32  i;
    for (i = 0; i < rows; i++) {
        head    += 8;
        hog_block_8x8(hog_8x8_3,  head, src, w, h);
        hog_block_8x8(hog_8x8_4,  head + 8 * w, src, w, h);

        norm_block_16x16(hog_row[i].hog_block_16x16, hog_8x8_1, hog_8x8_2, hog_8x8_3, hog_8x8_4);
        i++;
        if (i == rows)
            break;

        head    += 8;
        hog_block_8x8(hog_8x8_1,  head, src, w, h);
        hog_block_8x8(hog_8x8_2,  head + 8 * w, src, w, h);

        norm_block_16x16(hog_row[i].hog_block_16x16, hog_8x8_3, hog_8x8_4, hog_8x8_1, hog_8x8_2);
    }

    return 0;
}

unsigned hog_next_row(struct HOG_row *hog_row, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    float *next_row = malloc(sizeof(float) * 36);
    head    += window_w - 16;
    hog_block_16x16(next_row, head, src, w, h);
    free(hog_row[0].hog_block_16x16);

    uint8   i;
    for (i = 0; i < rows - 1; i++) {
        hog_row[i].hog_block_16x16 = hog_row[i + 1].hog_block_16x16;
    }
    hog_row[rows - 1].hog_block_16x16 = next_row;

    return 0;
}

unsigned hog_block_16x16(float *result, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    float   *hog_8x8_1  = malloc(sizeof(float) * 9);
    float   *hog_8x8_2  = malloc(sizeof(float) * 9);
    float   *hog_8x8_3  = malloc(sizeof(float) * 9);
    float   *hog_8x8_4  = malloc(sizeof(float) * 9);

    hog_block_8x8(hog_8x8_1, head,             src, w, h);
    hog_block_8x8(hog_8x8_2, head + 8 * w,     src, w, h);
    hog_block_8x8(hog_8x8_3, head + 8,         src, w, h);
    hog_block_8x8(hog_8x8_4, head + 8 * w + 8, src, w, h);

    norm_block_16x16(result, hog_8x8_1, hog_8x8_2, hog_8x8_3, hog_8x8_4);

    return 0;
}

unsigned norm_block_16x16(float *result, float *block1, float *block2, float *block3, float *block4)
{
    float   sum = 0;
    uint8   i;
    for (i = 0; i < 36; i++) {
        if (i < 9)
            sum += block1[i] * block1[i];
        else if (i < 18)
            sum += block2[i - 9] * block2[i - 9];
        else if (i < 27)
            sum += block3[i - 18] * block3[i - 18];
        else
            sum += block4[i - 27] * block4[i - 27];
    }

    for (i = 0; i < 36; i++) {
        if (i < 9)
            result[i] = block1[i] / (sqrt(sum) + 0.001);
        else if (i < 18)
            result[i] = block2[i - 9] / (sqrt(sum) + 0.001);
        else if (i < 27)
            result[i] = block3[i - 18] / (sqrt(sum) + 0.001);
        else
            result[i] = block4[i - 27] / (sqrt(sum) + 0.001);
    }
    return 0;
}

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

unsigned dx_block_8x8(int8 *result, uint32 head, uint8 *src, uint32 w)
{
    uint8   i;
    for (i = 0; i < 8; i++) {
        result[i]       = dx_pixel(head + i, src, w);
        result[i + 8]   = dx_pixel(head + w + i, src, w);
        result[i + 16]  = dx_pixel(head + 2 * w + i, src, w);
        result[i + 24]  = dx_pixel(head + 3 * w + i, src, w);
        result[i + 32]  = dx_pixel(head + 4 * w + i, src, w);
        result[i + 40]  = dx_pixel(head + 5 * w + i, src, w);
        result[i + 48]  = dx_pixel(head + 6 * w + i, src, w);
        result[i + 56]  = dx_pixel(head + 7 * w + i, src, w);
    }
    return 0;
}

unsigned dy_block_8x8(int8 *result, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    uint8   i;
    for (i = 0; i < 8; i++) {
        result[i]       = dy_pixel(head + i, src, w, h);
        result[i + 8]   = dy_pixel(head + w + i, src, w, h);
        result[i + 16]  = dy_pixel(head + 2 * w + i, src, w, h);
        result[i + 24]  = dy_pixel(head + 3 * w + i, src, w, h);
        result[i + 32]  = dy_pixel(head + 4 * w + i, src, w, h);
        result[i + 40]  = dy_pixel(head + 5 * w + i, src, w, h);
        result[i + 48]  = dy_pixel(head + 6 * w + i, src, w, h);
        result[i + 56]  = dy_pixel(head + 7 * w + i, src, w, h);
    }
    return 0;
}

unsigned magnit_block(float *result, int8 *dx, int8 *dy, uint32 w, uint32 h)
{
    uint32  i;
    for (i = 0; i < w * h; i++)
        result[i] = magnit_pixel(dx[i], dy[i]);
}

unsigned angle_block(float *result, int8 *dx, int8 *dy, uint32 w, uint32 h)
{
    uint32  i;
    for (i = 0; i < w * h; i++)
        result[i] = angle_pixel(dx[i], dy[i]);
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

int8 dx_pixel(uint32 head, uint8 *src, uint32 w)
{
    if  (head % w == 0 || head % w + 1 == w)
        return 0;

    int8    value   = src[head + 1] - src[head - 1];

    return value > 0 ? value : 0;
}

int8 dy_pixel(uint32 head, uint8 *src, uint32 w, uint32 h)
{
    _assert(head < w * h);

    if  (head < w  || head >= w * (h - 1))
        return 0;

    int8    value   = src[head + w] - src[head - w];

    return value > 0 ? value : 0;
}

float magnit_pixel(int8 dx, int8 dy)
{
    float   result;
    if (dx == 0)
        result = (float)dy;
    else if (dy == 0)
        result = (float)dx;
    else if (dx <= 16 && dy <= 16)
        result = LUT_magnit[(dx - 1) * 16 + dy - 1];
    else
        result = sqrt(dx * dx + dy * dy);

    return result;
}

float angle_pixel(int8 dx, int8 dy)
{
    float   result;
    if (dy == 0)
        result = 0;
    else if (dx == 0)
        result = PI/2;
    else if (dx <= 16 && dy <= 16)
        result = LUT_angle[(dy - 1) * 16 + dx - 1];
    else
        result = atan((float)dy / dx);// / PI * PI_DEGREE;

    return result;
}
