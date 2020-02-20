#!bin/bash
# a script to splice all rinex files in a directory and output to the same directory
# first input is receiver ID (e.g. 3012375 etc)
# also adds in marker name (second input)

teqc='/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc'
dir_in='/mnt/f/PAD2019/GNSS/GNSS_ALL_PAD19_RINEX2.11'
for g in "$dir_in"*/ # g directory for collection day
do
	echo "directory: "$g
	date=$(echo $g | awk -F'/' '{print $7 }') #common date, not DOY
	#echo $date
	h=$(ls -t "$g"*.dat | tail -1) # sample file ID base name (oldest file in dir.)
	j=$(echo $h | awk -F'/' '{print $6 }') # take only local path
	#echo "J="$j
	fileBase="${j:0:9}"
	#echo $h
	spliceName=$(echo $fileBase"_"$date"D.dat")
	rm $g$spliceName # remove existing file before splicing!
	echo "Creating file: "$spliceName
	$teqc -O.at SEPPOLANT_X_MF -O.mo "\""$2"\"" $g*.dat > $g$spliceName
	#compressedName=${spliceName:0:19}".tar"
	#echo "Compressing: "$compressedName
	#tar -czf $g$compressedName $g$spliceName
	echo ""
done
