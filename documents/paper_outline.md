<!---
/*******************************************************************************
// Project name   :
// File name      : paper_outline.md
// Created date   : Tuesday 07/11/17
// Author         : Huy Hung Ho
// Last modified  : Wed 12 Jul 2017 09:51:37 AM ICT
// Desc           :
*******************************************************************************/
-->
Introduction
============
- Paper: HOG generation with only shift and addition operators-based object detection


TODO
====
- Drawing the illustration picture

Outline
=======
    0.Abtract
    1.Introduction
    2.Previous work
    3.Overview of HOG-SVM algorithm
    4.Hardware architecture
    5.Detail Optimize point
    6.Simulation
    7.Conclusion

Features
========

## Abtract

## Intro
-   Intro application of object detection (illustration image)
-   Requirement:
    +   real-time (high fps)
	 Unfortunately, object detection algorithm excutes slowly and not yet
	efficient on a conntional embedded system. The reason is object detecion
	have the large number of pixel which process several times by the system to
	extract useful features, then these features need to combine, process and
	retrieve each others.  The system must handle all the above requirements
	with high speed and fast memory to apply real-time applications. Moreover,
	for energy consumption, the ADAS and portable electronics, the available
	energy is limited by the battery whose weight and size must be kept to a
	minimum. It is a daunting problem for conventional embedded systems. By
	contrast, the hardware implementation from a white chip will not be
	limited to instantaneous processing if enough available resources. With
	hardware design, the hardware source is controller the parallel calculation
	will improve power efficiention and respond processing large data in high
	speed requirement.

	 A conventional method to object detection includes two important processes:
	extract features in the imgage blocks and evaluating the coincidence
	between these features and the object features.
	HOG algorithm provides a reasonable trade-off bettwen detection accuray and
	complexity compared to a ternative richer feature. And do linear SVMs
	trained on hog features perform so well, from [].

-   Contribution:
    + Edit algorithm, faster calculation
	The most domiant part is cell histogram generation.
	 In this paper, we optimized by reducing a large number of calculations in
	algorithm. Removing complex calculations like arctan, root... will make
	hardware excutes simpler and faster. we optimized  by reducing a large
	number of calculations in algorithm. Removing complex calculations like
	arctan, root... will make hardware excutes simpler and faster.

- Overview next sections:
	 In section 2, this paper overview the state-of-the-art of object detection.
	Section 3 describes object detection by hog-svm algorithm, its advantage and
	the bottlenecks. Section 4 introduct hardware architecture of detector.
	Next, section 5 describes detail optimized architecture.
	The result simulation is showed in section 6 and conclusion in section 7.

## Previous work
-   The majority of the published implementation of HOG based object detection are CPU, GPU platforms.
	 The implementation in "Pedestrian detection at 100 frames per second"
	achieves higher throughput on a GPU at 100 fps but with a resolution of 640×480 pixels.
	 "libHOG: Energy-Efficient Histogram of Oriented Gradient Computation: are
	able to compute multiresolution HOG pyramids at 70fps for 640×480 images on
	a multicore CPU
	 The "implementation and analysis of real-time object tracking on the
	starburst mpsoc" using embbedd system for implemention with real-time
	object tracking (fps > 30);
> > > Waste of area and cost

-   Papers use Cordic, approximate magnitude
	"A Sub-100 mw Dual-Core HOG Accelerator VLSI for
	Parallel" real-time 100 mw in HDTV (1920-1080) using CORDIC for cal angle
	"An Energy-efficient Hardware Implementation of HOG-based
	Object Detection at 1080HD 60 fps with Multi-scale Support": histogram bins
	can be calculated without the actual value of the gradient angle

> > > There are no paper that really solve from pixel weight to histogram calculation bottleneck so far.
	It is the largest knot where using a lot of complex math.

## Overview of the HOG-SVM algorithm
-   Introduct about object detection:
	 Histogram of Oriented Gradients (HOG) is a feature descriptor first
	introduct by Dalal [1]. It gets quantity of strong characteristic from the
	shape change of the object by dividing a local domain into plural blocks,
	and making the incline of each the histogram.

	 The HOG algorithm will calculate the slope graph in the direction of the image,
	creating a set of characteristics specific to the object of interest.
	Another distinctive feature set with the same technique is the Scale-invariant feature transform (SIFT).
	However, SIFT describes invariant regions for translations, rotations,
	magnifications, etc., into the characteristics and combinations of the
	features of each region, so it is suitable for alignment purposes. Composite
	image or object recognition, HOG extracting features from dense "umbrella"
	overlap in each block / image area and examines the similarity between this
	feature and the characteristics of the object.

-   HOG algorithm
	+ Histogram generation
	+ Normalization
	+ Classification

	The most timing and power consumption is histogram generation domain.
-   Conclusion: the limitation

        -> Timing for calculate -> reduce number of steps


## Hardware architecture

-   General
    +   Gradient: using filter [-1 0 1] & [-1 0 1]^T
    +   Histogram calculation: using shift operator, multiplexer
    +   Block normalization: L2 norm, store cell hog in next block
    +   SVM classification:

-   Able to store overlap cell part and re-use in next block (in block norm),
    store hog for next windows

-   Using shift >> do not using float number

-   Calculate *throughput* (bin/cycle) in input, output each block

## Detail optimize
-   Neccesity, intro method
-   Pseudo-code
-   HW architecture
-

## Result simulation
-   Number of cycle
-   bit-width
-   throughout and compasion

## Conclusion
-
