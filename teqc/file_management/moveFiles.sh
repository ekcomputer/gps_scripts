# copies files to directory to be spliced with receiver as input

inBase="/mnt/f/PAD_GNSS/rinex/$1/LOG2_B/*/*.dat"
base="/mnt/f/PAD_GNSS/PAD_GNSS_Spliced/$1/"
for i in $inBase
do
cp $i $base
done
