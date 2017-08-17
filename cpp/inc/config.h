/*
 * Project name   : Human detection by HOG
 * File name      : config.h
 * Created date   : Thu 13 Apr 2017
 * Author         : Huy Hung Ho
 * Last modified  : Wed 16 Aug 2017 02:57:49 PM ICT
 * Desc           :
 */
#include <stdio.h>
#include <stdlib.h>

#ifndef CONFIG_H
#define CONFIG_H

/* my type */
typedef int                  int32;
typedef unsigned int         uint32;
typedef unsigned int         uint;
typedef short                int16;
typedef unsigned short       uint16;
typedef char                 int8;
typedef unsigned char        uint8;

/* print foramt */
#define VHDL_FORMAT     0
#define ONLY_BASIC_CASE 0

/* all of them are mult 1024 */
#define SIN10_MULT_1024   178
#define SIN30_MULT_1024   512
#define SIN50_MULT_1024   784
#define SIN70_MULT_1024   962
#define SIN90_MULT_1024   1024
#define COS10_MULT_1024   1008
#define COS30_MULT_1024   887
#define COS50_MULT_1024   658
#define COS70_MULT_1024   350
#define COS90_MULT_1024   0

/* prameters for hog */
#define PI              3.1416
#define PI_DEGREE       180
#define BIAS            -3.35
#define window_h        128
#define window_w        64
#define rows            7
#define columns         15
#define HOG_number	    3780
#define block_num_bin   36
#define cell_num_bin    9


#endif /* ifndef CONFIG_H */
