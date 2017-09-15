/*
 * Project name   :
 * File name      : main.cpp
 * Created date   : Wed 16 Aug 2017 09:27:01 AM ICT
 * Author         : Huy-Hung Ho
 * Last modified  : Wed 16 Aug 2017 09:27:01 AM ICT
 * Desc           :
 */

#include <iostream>
#include <string.h>
#include <fstream>
#include "config.h"
#include "HOGProcessor.h"
using namespace std;


int main(int argc, char *argv[])
{
	int m_wcell		= 8;
	int m_hcell		= 8;
	int m_wblock	= 2;
	int m_hblock	= 2;
	int m_wwindow	= 64;
	int m_hwindow	= 128;
	int m_overlap	= 1; // 0.5


    const char* imgname = "people.png";
    char fileFeaturesName[400];
    strcpy(fileFeaturesName, imgname);
    strcat(fileFeaturesName,"_features.txt");
    ofstream fileFeatures(fileFeaturesName);
    HOGProcessor hog;
    hog.setParams(cvSize(m_wcell,m_hcell),cvSize(m_wblock,m_hblock),m_overlap);
    CvMat* features;
    features = hog.calcHOGFromImage(imgname,cvSize(m_wwindow,m_hwindow),1);
    hog.writeFeatureVector(features, fileFeatures);

	return 0;
}

