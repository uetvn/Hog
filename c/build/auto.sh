################################################################################
# Project name   :
# File name      : auto.sh
# Created date   : Fri 24 Mar 2017
# Author         : Huy Hung Ho
# Last modified  : Fri 24 Mar 2017
# Guide          :
###############################################################################
#!/bin/bash
# Auto resizse and scan image
src=$1
fname=${src::-4}
scale="100 80 70 60 50 45 40 35 30"

echo	$fname
mkdir   scaleImages/$fname

for i in $scale
do
	scaleFile=${fname}_scale$i%.png
	convert $src -resize "$i%" $scaleFile
	./hog -i $scaleFile
	rm $scaleFile
	mv *_scale*%.png scaleImages/$fname
done

mv	$src sourceImages
