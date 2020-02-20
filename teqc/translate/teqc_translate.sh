#!/bin/bash
# first arg is Receiver SSID, second arg is log: (LOG2_B or LOG5_hi)
# version 3 includes stderr output file; also puts rinex in sep folder

wd="$(pwd)"
c=1
basepath="/mnt/f/Sask2018/GNSS1/"
#basepath= "/mnt/f/PAD_GNSS"
for f in "$basepath""$1"/"$2"/*/*.18_
do
	echo "Processing: "$f
        echo $f | awk -F'/' '{print $8"/"$9}' > name.txt
        filepath="$(cat name.txt)"
	echo $filepath | awk -F'.' '{print $1}' > filepath2.txt
        filepath2="$(cat filepath2.txt)"
	#echo $filepath2
	echo $f | awk -F'/' '{print $8}' > folder.txt
        dirpath="$(cat folder.txt)"
        mkdir -p "$basepath"rinex/"$1"/"$2"/"$dirpath"
	mkdir -p "$basepath"rinex/log/"$1"/"$2"/"$dirpath"
        /mnt/d/wslhome/teqc_CentOSLx86_64d/teqc "$f" > "$basepath"rinex/"$1"/"$2"/"$filepath2".dat 2> "$basepath"rinex/log/"$1"/"$2"/"$filepath2".txt
        #echo $filepath
done
rm name.txt folder.txt filepath2.txt
cd $wd
