/*
 * Project name   :
 * File name      : window_norm_comp.cpp
 * Created date   : Thu 21 Sep 2017 10:01:44 AM ICT
 * Author         : Huy-Hung Ho
 * Last modified  : Thu 12 Oct 2017 02:42:38 PM ICT
 * Desc           :
 */
#include <cstdlib>
#include <cmath>
#include "appx_div.h"
#include "window_norm_comp.h"

#define     MAX         pow(2,7)

/* The functions */
int32  floorSqrt(int x);
uint32 sqrt32(unsigned long n);


unsigned window_norm_comp(void)
{
    FILE *outFileIn = fopen("text/window_inf.txt", "w");
    FILE *outFile   = fopen("text/window_ouf.txt", "w");

    uint32 *bin     = (uint32 *)malloc(sizeof(uint32) * BLOCK_NUM);
    uint32 *cb      = (uint32 *)calloc(sizeof(uint32), 5);
    uint32 *output  = (uint32 *)malloc(sizeof(uint32) * BLOCK_NUM);

    uint32 i, k;
    uint32 counter = 0;

    while (counter < MAX) {
        for (k = 0; k < 4; k++) {
            for (i = 9 * k; i < 9 * k + 9; i++) {
                bin[i] = counter++;
                cb[k]  += bin[i] * bin[i];
            }
        }

        for (k = 0; k < 4; k++) {
            for (i = 9 * k; i < 9 * k + 8; i+=2) {
                fprintf(outFileIn, "%10d\n", (bin[i+1] << 16) + bin[i]);
            }
            fprintf(outFileIn, "%10d\n", bin[9 * k + 8]);
            fprintf(outFileIn, "%10d\n", cb[k]);
        }

        cb[4] = floorSqrt(cb[0] + cb[1] + cb[2] + cb[3]);

        for (i = 0; i < BLOCK_NUM; i++) {
            output[i] = appx_div(bin[i], cb[4]);
        }

        /* Output */
        for (i = 0; i < 8; i+=2) {
            fprintf(outFile, "%10d%10d", output[i], output[i+1]);
            fprintf(outFile, "%10d%10d   %10d\n", output[18 + i], output[18 + i + 1], cb[4]);
        }
        fprintf(outFile, "%10d%10d", output[8], 0);
        fprintf(outFile, "%10d%10d\n", output[26], 0);

        for (i = 0; i < 8; i+=2) {
            fprintf(outFile, "%10d%10d", output[9 + i], output[9 + i + 1]);
            fprintf(outFile, "%10d%10d\n", output[27 + i], output[27 + i + 1]);
        }
        fprintf(outFile, "%10d%10d", output[17], 0);
        fprintf(outFile, "%10d%10d\n", output[35], 0);

        counter = counter - 18;

        cb [4] = cb[0] = cb[1] = cb[2] = cb[3] = 0;

        // NEXT PHASE
        for (k = 0; k < 4; k++) {
            for (i = 9 * k; i < 9 * k + 9; i++) {
                bin[i] = counter++;
                cb[k]  += bin[i] * bin[i];
            }
        }

        cb[4] = floorSqrt(cb[0] + cb[1] + cb[2] + cb[3]);

        for (i = 0; i < BLOCK_NUM; i++) {
            output[i] = appx_div(bin[i], cb[4]);
        }
        //printf("CB = %d  = %d + %d + %d + %d\n", cb[4], cb[0], cb[1], cb[2], cb[3]);

        /* Output */
        for (i = 0; i < 8; i+=2) {
            fprintf(outFile, "%10d%10d", output[i], output[i+1]);
            fprintf(outFile, "%10d%10d\n", output[18 + i], output[18 + i + 1]);
        }
        fprintf(outFile, "%10d%10d", output[8], 0);
        fprintf(outFile, "%10d%10d\n", output[26], 0);

        for (i = 0; i < 8; i+=2) {
            fprintf(outFile, "%10d%10d", output[9 + i], output[9 + i + 1]);
            fprintf(outFile, "%10d%10d\n", output[27 + i], output[27 + i + 1]);
        }
        fprintf(outFile, "%10d%10d",output[17], 0);
        fprintf(outFile, "%10d%10d\n",output[35], 0);

        counter = counter - 18;

        cb[4] = cb[0] = cb[1] = cb[2] = cb[3] = 0;
    }

    return 0;
}

int32 floorSqrt(int32 x)
{
    // Base cases
    if (x == 0 || x == 1)
       return x;

    // Do Binary Search for floor(sqrt(x))
    int32 start = 1, end = x, ans;
    while (start <= end)
    {
        int mid = (start + end) / 2;

        // If x is a perfect square
        if (mid*mid == x)
            return mid;

        // Since we need floor, we update answer when mid*mid is
        // smaller than x, and move closer to sqrt(x)
        if (mid*mid < x)
        {
            start = mid + 1;
            ans = mid;
        }
        else // If mid*mid is greater than x
            end = mid - 1;
    }
    return ans;
}

uint32 sqrt32(unsigned long n)
{
    uint32 c = 0x8000;
    uint32 g = 0x8000;

    for(;;) {
        if(g*g > n)
            g ^= c;
        c >>= 1;
        if(c == 0)
            return g;
        g |= c;
    }
}
