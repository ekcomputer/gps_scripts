#!bin/bash
# a script to splice all rinex files in a directory and output to the same directory
# first input is directoy (i.e. 3012375)
# also adds in marker name (second input)
# also converts to file with 'M' flag for mixed observations, in case lacking
# TODO:  Add git control

teqc='/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc'
root_dir=/mnt/f/Sask2018/GNSS1/rinex_spliced/$1/
for dir_in in "$root_dir"*/ #"$root_dir"*/ # g directory for collection day
do
	echo "directory: "$dir_in
	date=$(echo $dir_in | awk -F'/' '{print $7 }') #common date, not DOY
	#echo $date
	h=$(ls -t "$dir_in"*.dat | tail -1) # sample file ID base name (oldest file in dir.)
	# echo "h="$h
	# j=$(echo $h | awk -F'/' '{print $8 }') # take only local path
	j=$(basename $h) # take only local path
	#echo "J="$j
	fileBase="${j:0:9}"
	#echo $fileBase
	spliceName=$(echo `basename $dir_in`"_"$date"D.dat")
	echo "removing old file: "$dir_in$spliceName
	rm -f "$dir_in""$spliceName" # remove existing file before splicing!
	rm -fr "$dir_in"mixed/
	mkdir -p "$dir_in"mixed/
		for k in "$dir_in"pnnn*.dat
		do
				end=$(basename $k)
				#echo "end: "$end
				mixed_name=$(echo "$dir_in"mixed/"$end".rnx)
				#echo "mixed_name: "$mixed_name
				$teqc -O.s M $k > $mixed_name
		done
	echo "Creating file: "$spliceName
	$teqc -O.at SEPPOLANT_X_MF -O.mo "\""$2"\"" "$dir_in"mixed/*.rnx > $dir_in$spliceName
	#compressedName=${spliceName:0:19}".tar"
	#echo "Compressing: "$compressedName
	#tar -czf $g$compressedName $g$spliceName
	echo ""
done
