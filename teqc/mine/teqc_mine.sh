#!bin/bash
# a script to mine  filename, size, start/stop, sample interval, possible missing epochs, station name, station code, lat/long/elev, sats

searchpath="$1" # name of directory w data
echo -e "Starting mining script for: ""$1""\n\n"
for f in "$searchpath"/rinex/*/*/*/*.dat
do
	echo "Processing: ""$f"
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" | grep filename | awk -F':' '{print $2}' 
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" | grep bytes | awk -F':' '{print $2}'
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" | grep start | awk -F':' '{print $2" "$3}'
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" | grep stop | awk -F':' '{print $2" "$3}'
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" | grep sample | awk -F':' '{print $2}'
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" | grep possible | awk -F':' '{print $2}'
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" | grep name | awk -F':' '{print $2}'
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" | grep code | awk -F':' '{print $2}'
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" | grep latitude | awk -F':' '{print $2}'
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" | grep longitude | awk -F':' '{print $2}'
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +meta "$f" | grep elevation | awk -F':' '{print $2}'
	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc +qc "$f" | grep "satellites w/ obs" | awk -F':' '{print $2}'



done



