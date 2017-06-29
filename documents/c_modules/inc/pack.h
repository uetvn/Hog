/*
 * Project name   : Human detection by HOG
 * File name      : pack.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Thu 13 Apr 2017
 * Desc           :
 */
#ifndef PACK_H
#define PACK_H

#include <stdio.h>
#include <stdlib.h>
#include <mytypes.h>

#define FAIL() printf("\nfailure in %s() line %d\n", __func__, __LINE__)
#define _assert(test) do { if (!(test)) { FAIL(); return 1; } } while(0)
#define _verify(test) do { int r=test(); tests_run++; if(r) return r; } while(0)

//const char* func;
//int line;
//#define _() func=__func__; line=__LINE__;
//#define ok(test) do { _(); if (!(test)) { fail(); return 1; } } while(0)
//#define run(test) do { reset_state(); tests_run++; test(); } while(0)
//void fail() { printf("test failure in %s() line %d\n", func, line); }

#define PI			3.1416
#define PI_DEGREE	180
#define BIAS		-3.35
#define window_h	128
#define window_w	64
#define rows        7
#define columns     15
#define HOG_number	3780

const float LUT_magnit[];
const float LUT_angle[];

struct HOG_row {
        float   *hog_block_16x16;
};

struct HOG_window {
        struct HOG_row  *hog_row;
};

struct Detecter {
    uint32  *object;
    uint8   *scale;
};

unsigned saving_object(uint32 *object, uint32 head);

unsigned readFileFloats(float *result, const char *name, int N);

unsigned init_hog_row(struct HOG_row **hog_row);

unsigned init_hog_window(struct HOG_window **hog_column);

unsigned free_hog_row(struct HOG_row *hog_row);

unsigned free_hog_window(struct HOG_window *hog_column);

unsigned store_matrix_uint8(uint8 *data, uint32 width, uint32 height, char *filename);

unsigned store_matrix_int8(int8 *data, uint32 width, uint32 height, char *filename);

unsigned store_matrix_float(float *data, uint32 width, uint32 height, char *filename);

unsigned store_hog_row(struct HOG_row *hog_row, char *filename);

unsigned store_hog_window(struct HOG_window *hog_column, char *filename);

#endif
