#!bin/bash a script to splice all rinex files in a directory and output to the
#same directory first input is directoy (i.e. 3012375) second input is marker
#name (i.e. "Lake A2") also converts to file with 'M' flag for mixed
#observations, in case lacking.  Otherwise, teqc sometimes returns an error.
#assumes a directory structure that looks like:
#ParentDirectory/InputDirectoryFromArgument1/FolderNamedByDate/RinexFiles.dat
#Create directories as such and manually drag in the ones you want to splice.  I
#use this to combine all files from the same local calendar day, rather Rinex
#Files have filename structure: XXXX###Y.dat, where XXXX is prefix, ### is day
#of year, and Y is suffix indicating hour of day.  # i.e. pnnn167q.dat   output:
#one spliced rinex file with filename structure "YYYYMMDD_#######D.dat", where ######
#is InputDirectoryFromArgument1. # i.e. 20180616_3012258D.dat
teqc='/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc'
root_dir=/mnt/f/Sask2018/GNSS1/rinex_spliced/$1/
for dir_in in "$root_dir"*/ #"$root_dir"*/ # g directory for collection day
do
	echo "directory: "$dir_in
	date=$(echo $dir_in | awk -F'/' '{print $7 }') #common date, not DOY # NEED to update this if using in a directory structure without exactly 7 levels
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
