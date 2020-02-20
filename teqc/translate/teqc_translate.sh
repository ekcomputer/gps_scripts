#!/bin/bash
# first arg is Receiver SSID, second arg is log: (LOG2_B or LOG5_hi)

wd="$(pwd)"
c=1
for f in ls /mnt/f/SWOT2018/GNSS1/"$1"/"$2"/*/*.18_
do
	echo $f | awk -F'/' '{print $8"/"$9}' > name.txt
	filepath="$(cat name.txt)"
	echo $f | awk -F'/' '{print $8}' > folder.txt
	dirpath="$(cat folder.txt)"
	#cd $f
	#filepath=
	#filepath="$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$(f)" | grep filename | awk -F'/' '{print $3"/"$4}')"
	#dirpath="$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$(f)" | grep filename | awk -F'/' '{print $3}')"
	mkdir -p /mnt/f/SWOT2018/GNSS1/"$1"/"$2"/rinex/"$dirpath"
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc "$f" > /mnt/f/SWOT2018/GNSS1/"$1"/"$2"/rinex/"$filepath".dat
	#echo $filepath
#	touch /mnt/f/SWOT2018/GNSS1/"$1"/"$2"//rinex/"$filepath".test
#	echo /mnt/f/SWOT2018/GNSS1/"$1"/"$2"/rinex/"$filepath".test
done
cd $wd
