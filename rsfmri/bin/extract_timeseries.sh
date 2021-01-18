#!/bin/bash
# ------------------------------------------------------------------ #
# Dumps the timeseries of all the voxels of a mask into a text file
# ------------------------------------------------------------------ #

AFNI_DIR=/home/stocco/abin

for subj in `ls -d sub-*`; do
    cd ${subj}/func
    for mask in `ls ../../ROIs/*.nii`; do
	# Removes the leading '../../'
	roi_name=`echo $mask | cut -f4 -d/`
	
	# Removes the trailing '.nii'
	roi_name=`echo $roi_name | cut -f1 -d.`

	# Dumps to text file
	$AFNI_DIR/3dmaskdump -mask $mask          \
			     -o ${roi_name}.txt   \
			     -noijk               \
			     swa${subj}_task-rest_bold.nii 
    done
    cd ../..
done
