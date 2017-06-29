################################################################################
# Project name   :
# File name      : !!FILE
# Created date   : !!DATE
# Author         : Ngoc-Sinh Nguyen
# Last modified  : !!DATE
# Guide          :
###############################################################################
#!/bin/bash

#$1 is file name
#$ other  is scale
scale="10 20 30 50"
img=""
if [[ $# -eq 0 ]]; then
	echo "$0 input-file scale(optional)"
	exit 1;
else
	img=$1
	if [[ $# -gt 1 ]]; then
		shift;
		scale=$@
	fi
fi

fname=${img%.*}
ext=${img##*.}

for i in $scale
do
	convert "${img}" -resize "$i%" "${fname}_scale$i%.${ext}"
done
