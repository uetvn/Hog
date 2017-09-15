/*
 * Project name   :
 * File name      : HOGProcessor.h
 * Created date   : Thu 17 Aug 2017 10:56:17 AM ICT
 * Author         : Huy-Hung Ho
 * Last modified  : Thu 17 Aug 2017 03:38:14 PM ICT
 * Desc           :
 */

#ifndef HOG_PROCESSOR_H
#define HOG_PROCESSOR_H

#include <iostream>
#include <fstream>
#include "cxcore.h"
#include "cv.h"
#include "highgui.h"

using namespace cv;

class HOGProcessor {
private:
    /* default 9 - 8x8 - 2x2 - 1 */
    static const int numOfBins = 9;
    CvSize m_cell;
    CvSize m_block;
    float  m_fStepOverlap;

public:
    HOGProcessor();
    ~HOGProcessor();

    void setParams(CvSize cell, CvSize block, float stepOverlap);
    int getWindowFeatureVectorSize(CvSize window);
    int getWindowFeatureVectorSize(CvSize window, CvSize block, CvSize cell, float stepOverlap);

    /* Ham tinh gradient theo phuong x, y*/
    IplImage *doSobel(IplImage* in,int xorder, int yorder, int apertureSize);

    /* Ham tinh integral image cho cac bin image */
    IplImage **calculateIntegralHOG(IplImage *in);

    /* Ham tinh dac trung HOG tai moi cell */
    void calcHOGForCell(CvRect cell, CvMat *hogCell, IplImage **integrals, int normalization);

    /* Ham tinh dac trung HOG tai moi block */
    void calcHOGForBlock(CvRect block, CvMat *hogBlock, IplImage **integrals, int normalization);

    // Ham tinh dac trung HOG tai moi block
    void calcHOGForBlock(CvRect block, CvMat* hogBlock, IplImage** integrals,CvSize cell, int normalization);

    /* Ham tinh vector dac trung cho cua so HOG */
    CvMat *calcHOGWindow(IplImage **integrals, CvRect window, int normalization);

    CvMat* calcHOGWindow(IplImage *img, IplImage** integrals, CvRect window, int normalization);

    CvMat *calcHOGFromImage(const char *filename, CvSize window, int normalization);

    void writeFeatureVector(CvMat *mat, std::ofstream &fout);
};

#endif /* ifndef HOG_PROCESSOR_H */
