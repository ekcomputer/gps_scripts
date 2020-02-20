# converts gpx files to one shpfile using ogr2ogr
# first input is dir of gpx files
# version 2 is for PAD 2018!
# bs_dir_out="/mnt/d/AboveData/Shorelines/shp/"
# bs_dir_in="/mnt/d/AboveData/Shorelines/"

bs_dir_in="/mnt/f/PAD2018/etrex_data/raw/"
bs_dir_out="/mnt/f/PAD2018/etrex_data/shp/"
echo Yo $bs_dir_in$1/*/Track*.gpx
for file in $bs_dir_in$1/*/*.gpx
do 
	echo file: $file
	filebase="$(echo $file | awk -F'.' '{print $1 }' | awk -F'/' '{print $NF}' | awk '{gsub(/ /, "", $1); print $1$2$3$4}')"
	echo filebase: $filebase
	pth_out="$bs_dir_out$1/$filebase.shp"
	echo pth_out: $pth_out
	mkdir -p $bs_dir_out$1
	ogr2ogr -fieldTypeToString DateTime "$pth_out" "$file" track_points
done