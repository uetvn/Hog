/*
 * Project name   :
 * File name      : approximatedDivision.cpp
 * Created date   : Fri 15 Sep 2017 11:24:19 AM ICT
 * Author         : Huy-Hung Ho
 * Last modified  : Fri 15 Sep 2017 11:28:40 AM ICT
 * Desc           :
 */
#include "approximatedDivision.h"
#include <cmath>

uint32 checkLeftMostBit(uint32 n)
{
	n |= (n >>  1);
    n |= (n >>  2);
    n |= (n >>  4);
    n |= (n >>  8);
    n |= (n >> 16);
    return n - (n >> 1);
}


uint32 approximatedDivision(uint32 num, uint32 den)
{
    uint32 scaleNum;
    uint32 result;
    uint32 leftMostSquareNum;
    uint32 leftBit, bits0, bits1, bits2;

    scaleNum = num * 1024;
    leftMostSquareNum = checkLeftMostBit(den);
    leftBit = (uint32)log2((double)leftMostSquareNum);
    bits0 = leftBit + 1;
    bits1 = leftBit + 2;
    bits2 = leftBit + 3;
    cout << "den = " << den << endl;
    cout << "leftMostSquareNum = " << leftMostSquareNum << endl;

    if (den <= (leftMostSquareNum + (leftMostSquareNum >> 2))) {
        cout << "TH1 " << bits0 << endl;
        result = (scaleNum >> bits0)
               + (scaleNum >> bits1)
               + (scaleNum >> bits2);
    }
    else if (den <= (leftMostSquareNum + (leftMostSquareNum >> 1))) {
        cout << "TH2" << endl;
        result = (scaleNum >> bits0)
               + (scaleNum >> bits1);
    }
    else if (den <= (leftMostSquareNum + (3 * leftMostSquareNum >> 2)))
    {
        cout << "TH3" << endl;
        result = (scaleNum >> bits0)
               + (scaleNum >> bits2);
    }
    else {
        cout << "TH4" << endl;
        result = scaleNum >> bits0;
    }

	return result;
}
