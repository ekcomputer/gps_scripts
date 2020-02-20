#!bin/bash
# a script to mine  filename, size, start/stop, sample interval, possible missing epochs, station name, station code, lat/long/elev, sats

searchpath="$1" # name of directory w data
echo -e "Starting mining script for: ""$1""\n\n"
for f in "$searchpath"/rinex/*/*/*/*.dat
do
#	echo "Processing: ""$f"
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null | grep filename | awk -F':' '{print $2}' 2> /dev/null 
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null | grep bytes | awk -F':' '{print $2}' 2> /dev/null
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null | grep start | awk -F':' '{print $2" "$3}' 2> /dev/null
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep stop | awk -F':' '{print $2" "$3}' 2> /dev/null
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep sample | awk -F':' '{print $2}' 2> /dev/null
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep possible | awk -F':' '{print $2}' 2> /dev/null
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep name | awk -F':' '{print $2}' 2> /dev/null
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep code | awk -F':' '{print $2}' 2> /dev/null
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep latitude | awk -F':' '{print $2}' 2> /dev/null
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep longitude | awk -F':' '{print $2}' 2> /dev/null
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" 2> /dev/null| grep elevation | awk -F':' '{print $2}' 2> /dev/null
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +qc "$f" 2> /dev/null| grep "satellites w/ obs" | awk -F':' '{print $2}' 2> /dev/null
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +qc "$f" 2> /dev/null| grep "Complete observations" | awk -F':' '{print $2}' 2> /dev/null


done



