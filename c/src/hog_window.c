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
const int32 d10 = 11;
const int32 d30 = 37;
const int32 d50 = 76;
const int32 d70 = 176;

unsigned hog_window(uint32 *object, uint8 *src, uint32 w, uint32 h)
{
    struct HOG_window *hog;
    init_hog_window(&hog);
    object[0] = 0; // first element stores the number of detected

    int32  head, i;
    int32  tail = w * (h - window_h);
    uint8  *is_detected = malloc(sizeof(uint8));

    for (head = 0; head <= tail; head += w << 3) {
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
        head    += w << 3;
    }
    return 0;
}

unsigned hog_next_window(struct HOG_window *hog_column, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    uint8   i;
    for (i = 0; i < columns; i++) {
        hog_next_row(hog_column[i].hog_row, head, src, w, h);
        head    += w << 3;
    }
    return 0;
}

unsigned hog_prime_row(struct HOG_row *hog_row, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    int32   *hog_8x8_1    = malloc(sizeof(int32) * 9);
    int32   *hog_8x8_2    = malloc(sizeof(int32) * 9);
    int32   *hog_8x8_3    = malloc(sizeof(int32) * 9);
    int32   *hog_8x8_4    = malloc(sizeof(int32) * 9);

    /* Precalcultion */
    hog_block_8x8(hog_8x8_1,  head,         src, w, h);
    hog_block_8x8(hog_8x8_2,  head + 8 * w, src, w, h);

    int32  i;
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
    int32   *hog_8x8_1  = malloc(sizeof(int32) * 9);
    int32   *hog_8x8_2  = malloc(sizeof(int32) * 9);
    int32   *hog_8x8_3  = malloc(sizeof(int32) * 9);
    int32   *hog_8x8_4  = malloc(sizeof(int32) * 9);

    hog_block_8x8(hog_8x8_1, head,             src, w, h);
    hog_block_8x8(hog_8x8_2, head + 8 * w,     src, w, h);
    hog_block_8x8(hog_8x8_3, head + 8,         src, w, h);
    hog_block_8x8(hog_8x8_4, head + 8 * w + 8, src, w, h);

    norm_block_16x16(result, hog_8x8_1, hog_8x8_2, hog_8x8_3, hog_8x8_4);

    return 0;
}

unsigned norm_block_16x16(float *result, int32 *block1, int32 *block2, int32 *block3, int32 *block4)
{
    float   sum = 0.0;
    uint8   i;
    for (i = 0; i < 36; i++) {
        if (i < 9)
            sum += ((block1[i] * block1[i])  >> 20);
        else if (i < 18)
            sum += ((block2[i - 9] * block2[i - 9]) >> 20);
        else if (i < 27)
            sum += ((block3[i - 18] * block3[i - 18]) >> 20);
        else
            sum += ((block4[i - 27] * block4[i - 27]) >> 20);
    }
    sum = sqrt(sum);
    for (i = 0; i < 36; i++) {
        if (i < 9)
            result[i] = block1[i] / (1024 * sum + 1);
        else if (i < 18)
            result[i] = block2[i - 9] / (1024 * sum + 1);
        else if (i < 27)
            result[i] = block3[i - 18] / (1024 * sum + 1);
        else
            result[i] = block4[i - 27] / (1024 * sum + 1);
    }
    return 0;
}

unsigned hog_block_8x8(int32 *hist_9bin, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    /* Calculate derivative with respect to x */
    int8    *dx    = malloc(sizeof(int8) * 64);
    dx_block_8x8(dx, head, src, w);

    /* Calculate derivative with respect to y */
    int8    *dy    = malloc(sizeof(int8) * 64);
    dy_block_8x8(dy, head, src, w, h);

    /* Vote vector gradient to 9 bin hog feature */
    calculate_hist_9bin(hist_9bin, dx, dy);

	return 0;
}

unsigned dx_block_8x8(int8 *result, uint32 head, uint8 *src, uint32 w)
{
    uint8 top = 0;
    uint8 tail = 8;
    uint8 i;
    if  (head % w == 0) {
        top = 1;
        for (i = 0; i < 64; i += 8)
            result[i] = 0;
    }
    else if (head % w + 1 == w) {
        tail = 7;
        for (i = 7; i < 64; i += 8)
            result[i] = 0;
    }
    else {
        for (i = top; i < tail; i++) {
            result[i]       = dx_pixel(head + i, src, w);
            result[i + 8]   = dx_pixel(head + w + i, src, w);
            result[i + 16]  = dx_pixel(head + 2 * w + i, src, w);
            result[i + 24]  = dx_pixel(head + 3 * w + i, src, w);
            result[i + 32]  = dx_pixel(head + 4 * w + i, src, w);
            result[i + 40]  = dx_pixel(head + 5 * w + i, src, w);
            result[i + 48]  = dx_pixel(head + 6 * w + i, src, w);
            result[i + 56]  = dx_pixel(head + 7 * w + i, src, w);
        }
    }
    return 0;
}

unsigned dy_block_8x8(int8 *result, uint32 head, uint8 *src, uint32 w, uint32 h)
{
    uint8 i;
    if  (head < w) {
        for (i = 0; i < 8; i++)
            result[i] = 0;
    }
    else if (head >= w * (h - 1)) {
        for (i = 56; i < 64; i++)
            result[i] = 0;
    }
    else {
        for (i = 0; i < 8; i++) {
           result[i]       = dy_pixel(head + i, src, w, h);
           result[i + 56]  = dy_pixel(head + 7 * w + i, src, w, h);
        }
    }
    for (i = 0; i < 8; i++) {
            result[i + 8]   = dy_pixel(head + w + i, src, w, h);
            result[i + 16]  = dy_pixel(head + 2 * w + i, src, w, h);
            result[i + 24]  = dy_pixel(head + 3 * w + i, src, w, h);
            result[i + 32]  = dy_pixel(head + 4 * w + i, src, w, h);
            result[i + 40]  = dy_pixel(head + 5 * w + i, src, w, h);
            result[i + 48]  = dy_pixel(head + 6 * w + i, src, w, h);
    }
    return 0;
}

unsigned calculate_hist_9bin(int32 *hist_9bin, int8 *dx, int8 *dy)
{
    uint8 i;
    for (i = 0; i < 9; i++)
        hist_9bin[i] = 0;

    int8 *bin_select  = malloc(sizeof(uint8));
    int32 *magnit1 = malloc(sizeof(int32));
    int32 *magnit2 = malloc(sizeof(int32));
    
    for (i = 0; i < 64; i++) {
        hist_pixel(dx[i], dy[i], bin_select, magnit1, magnit2);
        hist_9bin[*bin_select % 9]       += *magnit1;
        hist_9bin[(*bin_select + 1) % 9] += *magnit2;
    }
}

unsigned hist_pixel(int8 dx, int8 dy, int8 *bin_select, int32 *magnit1, int32 *magnit2)
{
 
    int32 m1, m2;
    int8  bin;
    int8  is_same_sign = (dx * dy >= 0);

    dx = abs(dx);
    dy = abs(dy);
    int32 dy_shifted = dy << 6; 

    int32 bin1_dx;
    int32 bin2_dx;
    int32 bin3_dx;
    int32 bin4_dx;

    bin1_dx = d10 * abs(dx);
    bin2_dx = d30 * abs(dx);
    bin3_dx = d50 * abs(dx);
    bin4_dx = d70 * abs(dx);

    if (dy != 0) {
            if (dx != 0) {
                if (dy_shifted < bin1_dx) {
                    bin = 0;
                    m1 = 520 * dx - 2948 * dy;
                    m2 = 2948 * dy + 520 * dx;
                }
                else if (dy_shifted < bin2_dx) {
                    bin = 1;
                    m1 = 1497 * dx - 2593 * dy;
                    m2 = 2948 * dy - 520 * dx;
                }
                else if (dy_shifted < bin3_dx) {
                    bin = 2;
                    m1 = 2294 * dx - 1924 * dy;
                    m2 = 2593 * dy - 1497 * dx;
                }
                else if (dy_shifted < bin4_dx) {
                    bin = 3;
                    m1 = 2813 * dx - 1024 * dy;
                    m2 = 1924 * dy - 2294 * dx;
                }
                else {
                    bin = 4;
                    m1 = 2994 * dx;
                    m2 = 1024 * dy - 2813 * dx;
                }
                if (is_same_sign == 1) {
                    bin = 8 - bin;
                    int32 tmp = m1;
                    m1 = m2;
                    m2 = tmp;
                }
            }
            else  {
                bin = 4;
                m1 = dy << 10;
                m2 = 0;
            }
    }
    else {
        if (dx != 0) {
            bin = 8;
            m1 = dx * 1040;
            m2 = m1;
        }
        else {
            bin = 0;
            m1 = 0;
            m2 = 0;
        }
    }

    *bin_select = bin; 
    *magnit1    = m1;
    *magnit2    = m2;
}

int8 dx_pixel(uint32 head, uint8 *src, uint32 w)
{
    int8    value   = src[head + 1] - src[head - 1];
    return value > 0 ? value : 0; 
}

int8 dy_pixel(uint32 head, uint8 *src, uint32 w, uint32 h)
{
    int8   value   = src[head + w] - src[head - w];
    return value > 0 ? value : 0;
}

