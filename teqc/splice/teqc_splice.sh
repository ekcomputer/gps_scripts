#!bin/bash
# a script to splice all rinex files in a directory and output to the same directory
# also adds in marker name (first input)
# also converts to ...

teqc='/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc'
dir_in=$(pwd)
	echo "directory: "$dir_in
	date=$(echo $dir_in | awk -F'/' '{print $7 }') #common date, not DOY
	#echo $date
	h=$(ls -t "$dir_in"/GPS_only/*.dat.rnx | tail -1) # sample file ID base name (oldest file in dir.)
	j=$(echo $h | awk -F'/' '{print $9 }') # take only local path
	#echo "J="$j
	fileBase="${j:0:9}" 
	#echo $h
	spliceName=$(echo $fileBase"_"$date"D.dat")
	echo $sp
	rm $g$spliceName # remove existing file before splicing!
	mkdir "$dir_in"/GPS_only/
        for j in LOG*.dat
        do
                $teqc -O.s G -R $j > "$dir_in"/GPS_only/$j.rnx
        done
	echo "Creating file: "$spliceName
	$teqc -O.at SEPPOLANT_X_MF -O.mo "\""$1"\"" $g*.dat > $g$spliceName
	#compressedName=${spliceName:0:19}".tar"
	#echo "Compressing: "$compressedName
	#tar -czf $g$compressedName $g$spliceName
	echo ""
