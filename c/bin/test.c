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

unsigned hist_pixel(float dx, float dy, float bin, float m1, float m2)
{
    float   d20         = 23;
    float   d40         = 53;
    float   d60         = 110;
    float   d80         = 363;

    float bin1_dx;
    float bin2_dx;
    float bin3_dx;
    float bin4_dx;

    bin1_dx = d20 * abs(dx);
    bin2_dx = d40 * abs(dx);
    bin3_dx = d60 * abs(dx);
    bin4_dx = d80 * abs(dx);
    float dy_shifted = dy * 64; 

    if (dy == 0 && dx > 0) {
        bin = 0;
        m1 = dx;
        m2 = 0;
    }
    else if (dy == 0 && dx < 0) {
        bin = 0;
        m1 = -dx;
        m2 = 0;
    }
    else if (dy != 0 && dx == 0) {
        bin = 4;
        m1 = abs(dy) * 1.014326;
        m2 = m1;
    }
    else if (dy == 0 && dx == 0) {
        bin = 0;
        m1 = 0;
        m2 = 0;
    }
    else if (dx * dy > 0) {
        dx = abs(dx);
        dy = abs(dy);
        if (dy_shifted < bin1_dx) {
                bin = 0;
                m1 = 1.000000*dx - 2.747477*dy;
                m2 = 2.923804*dy - 0.000000*dx;
        }
        else if (dy_shifted >= bin1_dx && dy_shifted < bin2_dx) {
                bin = 1;
                m1 = 1.879385*dx - 2.239764*dy;
                m2 = 2.747477*dy - 1.000000*dx;
        }
        else if (dy_shifted >= bin2_dx && dy_shifted < bin3_dx) {
                bin = 2;
                m1 = 2.532089*dx - 1.461902*dy;
                m2 = 2.239764*dy - 1.879385*dx;
        }
        else if (dy_shifted >= bin3_dx && dy_shifted < bin4_dx) {
                bin = 3;
                m1 = 2.879385*dx - 0.507713*dy;
                m2 = 1.461902*dy - 2.532089*dx;
        }
        else {
                bin = 4;
                m1 = 2.879385*dx - -0.507713*dy;
                m2 = 0.507713*dy - 2.879385*dx;
        }
    }
    else if (dx * dy < 0) {
        dx = abs(dx);
        dy = abs(dy);
        if (dy_shifted < bin1_dx) {
                bin = 8;
                m2 = 1.000000*dx - 2.747477*dy;
                m1 = 2.923804*dy - 0.000000*dx;
        }
        else if (dy_shifted >= bin1_dx && dy_shifted < bin2_dx) {
                bin = 7;
                m2 = 1.879385*dx - 2.239764*dy;
                m1 = 2.747477*dy - 1.000000*dx;
        }
        else if (dy_shifted >= bin2_dx && dy_shifted < bin3_dx) {
                bin = 6;
                m2 = 2.532089*dx - 1.461902*dy;
                m1 = 2.239764*dy - 1.879385*dx;
        }
        else if (dy_shifted >= bin3_dx && dy_shifted < bin4_dx) {
                bin = 5;
                m2 = 2.879385*dx - 0.507713*dy;
                m1 = 1.461902*dy - 2.532089*dx;
        }
        else  {
                bin = 4;
                m2 = 2.879385*dx - -0.507713*dy;
                m1 = 0.507713*dy - 2.879385*dx;
        }
    }

    printf("bin = %f \n", bin);
    printf("m1 = %f \n", m1);
    printf("m2 = %f \n", m2);
}
int main ()
{
    float dx, dy, bin;
    float m1, m2;
    scanf("%f %f", &dx, &dy);
    hist_pixel(dx, dy, bin, m1, m2);
	return 0;
}

