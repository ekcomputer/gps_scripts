# makes directories given in text file, with receiver/folder as input

base="/mnt/f/PAD_GNSS/PAD_GNSS_Spliced/$1/"
cat "$base"dirs.txt | while read i
do
dir=$(echo "$base"$i"/" | sed 's/ //g')
echo $dir
mkdir $dir
done
