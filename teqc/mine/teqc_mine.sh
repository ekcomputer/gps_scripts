#!bin/bash
# a script to mine  filename, size, start/stop, sample interval, possible missing epochs, station name, station code, lat/long/elev, sats

searchpath="$1" # name of directory w data
echo -e "Starting mining script for: ""$1""\n\n"
logs="$searchpath"/rinex/stats
rm "$logs"/*.txt
echo $logs
for f in "$searchpath"/rinex/*/*/*/*.dat
do
	echo "Processing: ""$f"
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null | grep filename | awk -F':' '{gsub(/ /, "", $2); print $2}' >> "$logs"/filename.txt
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null | grep bytes | awk -F':' '{gsub(/ /, "", $2); print $2}' >> "$logs"/bytes.txt
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null | grep start | awk -F' ' '{gsub(/ /, "", $5); gsub(/ /, "", $6); print $5" "$6}' >> "$logs"/start.txt
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep final | awk -F' ' '{gsub(/ /, "", $5); print $5" "$6}' >> "$logs"/stop.txt
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep sample | awk -F':' '{gsub(/ /, "", $2); print $2}' >> "$logs"/sample.txt
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep possible | awk -F':' '{gsub(/ /, "", $2); print $2}' >> "$logs"/possibleMissingEpochs.txt
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep "station name:" | awk -F':' '{gsub(/ /, "", $2); print $2}' >> "$logs"/stationName.txt
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep code | awk -F':' '{gsub(/ /, "", $2); print $2}' >> "$logs"/stationCode.txt
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep latitude | awk -F':' '{gsub(/ /, "", $2); print $2}' >> "$logs"/lat.txt
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep longitude | awk -F':' '{gsub(/ /, "", $2); print $2}' >> "$logs"/long.txt
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep elevation | awk -F':' '{gsub(/ /, "", $2); print $2}' >> "$logs"/elev.txt
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +qc "$f" 2> /dev/null| grep "satellites w/ obs" | awk -F':' '{gsub(/ /, "", $2); print $2}' >> "$logs"/sats.txt
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +qc "$f" 2> /dev/null| grep "Complete observations" | awk -F':' '{gsub(/ /, "", $2); print $2}' >> "$logs"/completeObs.txt


done
echo "Finished batch mining."


