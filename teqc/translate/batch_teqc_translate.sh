#!/bin/bash

# batch runs teqctranslate6pad
echo "Starting batch job."
ids=( 3012258 3012267 3012283 3012291 3012375 )
for i in "${ids[@]}"
do
#	echo "i: "$i
	echo -e "\tReceiver SSID: $i (batch call)"
	bash teqc_translate6_PAD.sh $i LOG1_A
	bash teqc_translate6_PAD.sh $i LOG2_B
	bash teqc_translate6_PAD.sh $i LOG8_STATUS
done
echo "Finished batch job."
