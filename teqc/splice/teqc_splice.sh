#!bin/bash
# a script to splice all rinex files in a directory and output to the same directory
# also adds in marker name (first input)
# assumes antenna name is already in rinex (from sbf converter output)

teqc='/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc'
dir_in='/mnt/f/PAD2019/GNSS/GNSS_ALL_PAD19_RINEX2.11/'
for g in "$dir_in"*/ # g directory for collection day
do
	echo "directory: "$g
	date=$(echo $g | awk -F'/' '{print $(NF-1) }') #common date, not DOY
	#echo $date
	h=$(ls -t "$g"*.19O | tail -1) # sample file ID base name (oldest file in dir.)
	j=$(basename $h) # take only local path
	#echo "J="$j
	fileBase="${j:0:9}" # clip to just YYYYMMDD numerals
	#echo $h
	spliceName=$(echo $fileBase"_"$date"D.19O")
	rm $g$spliceName # remove existing file before splicing!
	echo "Creating file: "$spliceName
	$teqc -O.mo "\""$1"\"" $g*.19O > $g$spliceName
	#compressedName=${spliceName:0:19}".tar"
	#echo "Compressing: "$compressedName
	#tar -czf $g$compressedName $g$spliceName
	echo ""
done
