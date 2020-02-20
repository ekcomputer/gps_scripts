SSID=$1
for f in ls /mnt/f/SWOT2018/GNSS1/"$1"/LOG2_B/*/*.18_
mkdir -p /mnt/f/SWOT2018/GNSS1/"$1"/LOG2_B/rinex
filepath="$(teqc +meta 3012258/LOG2_B/18135/pnnn135u.18_ | grep filename | awk -F'/' '{print $3"/"$4}')"

do
#	/mnt/d/wslhome/teqc_CentOSLx86_64d/teqc "$f" /mnt/f/SWOT2018/GNSS1/"$1"/LOG2_B/rinex/$filepath
	touch /mnt/f/SWOT2018/GNSS1/"$1"/LOG2_B/rinex/$filepathtest
done
