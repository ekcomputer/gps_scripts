# converts gpx files to one shpfile using ogr2ogr
# first input is relative path for dir of gpx files
# second and third are input and output top dirs
# version 3 takes dirs as input
# put / at end of dir pathnames!

# NOTE: you will need to delete empty files created if the .gpx only held tracks, and you set it to oupt waypoints, etc.
# NOTE 2: you need to specify "tracks" etc at end of second argument, in addition to third arg
# example: gpx2shp_3.sh all_temp /mnt/f/PAD2019/etrex/UMASS/ /mnt/f/PAD2019/etrex/UMASS/shp_tmp/waypoints/ waypoints

bs_dir_in=$2
bs_dir_out=$3
gpx_type=$4 # either track_points, tracks, waypoints, or routes (rarely used) // if using multiple, put in quotes
echo Yo $bs_dir_in$1/*/Track*.gpx
for file in $bs_dir_in$1/*.gpx
do
	echo file: $file
	filebase="$(echo $file | awk -F'.' '{print $1 }' | awk -F'/' '{print $NF}' | awk '{gsub(/ /, "", $1); print $1$2$3$4}')"
	echo filebase: $filebase
	pth_out="$bs_dir_out$1/$filebase.shp"
	echo pth_out: $pth_out
	mkdir -p $bs_dir_out$1
	ogr2ogr -fieldTypeToString DateTime "$pth_out" "$file" $gpx_type
done
