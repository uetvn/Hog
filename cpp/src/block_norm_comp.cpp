/*
 * Project name   :
 * File name      : block_norm_comp.cpp
 * Created date   : Thu 21 Sep 2017 10:01:44 AM ICT
 * Author         : Huy-Hung Ho
 * Last modified  : Fri 29 Sep 2017 09:34:23 PM ICT
 * Desc           :
 */
#include <cstdlib>
#include <cmath>
#include "approximatedDivision.h"
#include "block_norm_comp.h"

#define     MAX         1000
#define     BIN_NUM     9
#define     BLOCK_NUM   36

unsigned block_norm_comp(void)
{
    FILE *inFile  = fopen("cpp_block_inf.txt", "w");
    FILE *outFile = fopen("cpp_block_ouf.txt", "w");

    uint32 *bin     = (uint32 *)malloc(sizeof(uint32) * BLOCK_NUM);
    uint32 *cb      = (uint32 *)calloc(sizeof(uint32), 5);
    uint32 *output  = (uint32 *)malloc(sizeof(uint32) * BLOCK_NUM);

    uint32 i, k;
    uint32 counter = 0;

    while (counter < 1000) {
        for (k = 0; k < 4; k++) {
            for (i = 9 * k; i < 9 * k + 9; i++) {
                bin[i] = counter++;
                cb[k]  += bin[i] * bin[i];
            }
        }

        for (k = 0; k < 4; k++) {
            for (i = 9 * k; i < 9 * k + 8; i+=2) {
                fprintf(inFile, "%10d\n", (bin[i+1] << 16) + bin[i]);
            }
            fprintf(inFile, "%10d\n", bin[9 * k + 8]);
            fprintf(inFile, "%10d\n", cb[k]);
        }

        cb[4] = cb[0] + cb[1] + cb[2] + cb[3];

        for (i = 0; i < 36; i++) {
            output[i] = approximatedDivision(bin[i], cb[4]);
        }
        for (k = 0; k < 4; k++) {
            for (i = 9 * k; i < 9 * k + 8; i+=2) {
                fprintf(outFile, "%10d\n", (output[i+1] << 16) + output[i]);
            }
            fprintf(outFile, "%10d\n", output[9 * k + 8]);
        }
    }

    return 0;
}
