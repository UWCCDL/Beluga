#!/bin/bash

AFNI_DIR=/home/stocco/abin/

while read line; do
    roi=`echo $line | cut -f1 -d,`
    x=`echo $line | cut -f2 -d,`
    y=`echo $line | cut -f3 -d,`
    z=`echo $line | cut -f4 -d,`
    network=`echo $line | cut -f5 -d,`

    if [ $network -eq "-1" ]; then
       network=0
    fi

    roi=`printf "%03d" $roi`
    network=`printf "%02d" $network`
       
       
    # This creates a mask in subject space
    echo "$x $y $z" | $AFNI_DIR/3dUndump -orient LPI \
					 -srad 5 \
					 -master ../test/func/swasub-032_task-rest_bold.nii \
					 -xyz -prefix region_${roi}_network_${network}.nii -

done < power_2011_list.csv

