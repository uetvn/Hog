/*
 * Project name   :
 * File name      :
 * Created date   : !!DATE
 * Author         : Huy Hung Ho
 * Last modified  : !!DATE
 * Desc           :
 */

#include <stdio.h>
#include <stdlib.h>

typedef char int8;
typedef int  int32;
typedef unsigned int uint32;

const int32 d10 = 11;
const int32 d30 = 37;
const int32 d50 = 76;
const int32 d70 = 176;


unsigned hist_pixel(int32 dx, int32 dy, int32 *bin_select, int32 *magnit1, int32 *magnit2)
{
 
    int32 m1, m2;
    int32  bin;
    int32  is_same_sign = (dx * dy >= 0);

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
                if (!is_same_sign) {
                    bin = 8 - bin;
                    int32 tmp = m1;
                    m1 = m2;
                    m2 = tmp;
                }
            }
            else {
                bin = 4;
                m1 = dy * 1024;
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

    printf("%3d %3d | %3d %3d | %.3f %.3f \n", dx, dy, bin, (bin+1) % 9, m1/1024.0, m2/1024.0);
}
int main ()
{
    int32 dx, dy;
    int32 *bin = malloc(sizeof(int32));
    int32 *m1 = malloc(sizeof(int32));
    int32 *m2 = malloc(sizeof(int32));
    scanf("%d %d", &dx, &dy);
    hist_pixel(dx, dy, bin, m1, m2);
	return 0;
}

