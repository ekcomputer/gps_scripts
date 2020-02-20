#!/bin/bash
# first arg is Receiver SSID, second arg is log: (LOG2_B or LOG5_hi)
# version 3 includes stderr output file; also puts rinex in sep folder

wd="$(pwd)"
c=1
basepath="/mnt/f/Sask2018/GNSS1/"
#basepath= "/mnt/f/PAD_GNSS"
for f in "$basepath""$1"/"$2"/*/*.18_
do
	echo $f | awk -F'/' '{print $8"/"$9}'>>filepath_var.txt
	filepath=cat filepath_var.txt
	mkdir -p "$basepath"rinex/"$1"/"$2"/"$dirpath1"
	#/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc "$f" > /mnt/f/SWOT2018/GNSS1/"$1"/"$2"/rinex/"$filepath".dat
	#echo $filepath
done
#rm filepath_var.txt
cd $wd
