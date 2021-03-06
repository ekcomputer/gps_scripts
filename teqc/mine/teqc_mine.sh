#!bin/bash
# a script to mine  filename, size, start/stop, sample interval, possible missing epochs, station name, station code, lat/long/elev, sats

# V7 reads from SBF format, not rinex.
# V6 includes receiver SSID and DOY
# V5 saves to vars 

searchpath="$1" # name of directory w data
echo -e "Starting mining script for: ""$1""\n\n"
logs="$searchpath"/rinex/stats
#rm "$logs"/*.txt
echo $logs
echo "RinexFilename,Bytes,ReceiverSSID,StartDateTime,StopDateTime,CommonDate,DOY,SamplePeriod,PossMissEpochs,StationName,StationCode,Latitude,Longitude,Elevation,NumSats,CompleteObs,SBF_Filename, SBF_bytes" > $logs/stats.csv
for g in "$searchpath"/rinex/*/*/*/*.dat # g is rinex filename, f is SBF file
do
	pathBase=$(echo $g | awk -F'rinex/' '{print $1 }')
	pathEnd=$(echo $g | awk -F'rinex/' '{print $2 }')
	pathEndSBF=$(awk -v var="$pathEnd" 'BEGIN {gsub(".dat", ".18_", var); print var }')
	f="$pathBase""$pathEndSBF"
	echo "Processing: ""$f"
	filename=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null | grep filename | awk -F':' '{gsub(/ /, "", $2); print $2}')
#	echo "Filename: "$filename
	bytes=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$g" 2> /dev/null | grep bytes | awk -F':' '{gsub(/ /, "", $2); print $2}')
	SBF_bytes=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null | grep bytes | awk -F':' '{gsub(/ /, "", $2); print $2}')
	start=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null | grep start | awk -F' ' '{gsub(/ /, "", $5); gsub(/ /, "", $6); print $5" "$6}')
	stop=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep final | awk -F' ' '{gsub(/ /, "", $5); print $5" "$6}')
	sample=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep sample | awk -F':' '{gsub(/ /, "", $2); print $2}')
	possMissEpochs=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep possible | awk -F':' '{gsub(/ /, "", $2); print $2}')
	stationName=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep "station name:" | awk -F':' '{gsub(/ /, "", $2); print $2}')
	stationCode=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep code | awk -F':' '{gsub(/ /, "", $2); print $2}')
	lat=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep latitude | awk -F':' '{gsub(/ /, "", $2); print $2}')
	long=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep longitude | awk -F':' '{gsub(/ /, "", $2); print $2}')
	elev=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep elevation | awk -F':' '{gsub(/ /, "", $2); print $2}')
	sats=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +qc "$g" 2> /dev/null| grep "satellites w/ obs" | awk -F':' '{gsub(/ /, "", $2); print $2}')
	completeObs=$(/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +qc "$g" 2> /dev/null| grep "Complete observations" | awk -F':' '{gsub(/ /, "", $2); print $2}')
	receiver=$(echo $pathEnd | awk -F'/' '{print $1}')
	doyLong=$(echo $pathEnd | awk -F'/' '{print $3}')
	#echo $pathEnd
	#echo "Daylong: ""$dayLong"
	doy=$(($doyLong - 18000))
	commonDate=$(echo $start |  awk -F' ' '{print $1}')
	echo $g,$bytes,$receiver,$start,$stop,$commonDate,$doy,$sample,$possMissEpochs,$stationName,$stationCode,$lat,$long,$elev,$sats,$completeObs,$filename,$SBF_bytes >> $logs/stats.csv

done
echo "Finished batch mining."
echo "Time: ";date

