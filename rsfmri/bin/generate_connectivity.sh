# Sketch of code to generate all ROIs and dump the timeseries of all voxels
# into corresponding files

# Would need to loop for all subjects 

AFNI_DIR=`/home/stocco/abin/`

while read line; do
    coords=$line
    region=$((region+1))
    network=1

    # This creates a mask in subject space
    echo "$coords" | ~/abin/3dUndump -orient LPI -srad 5 -master ./func/swasub-032_task-rest_bold.nii -xyz -prefix region_${region}_${network}.nii -

    # This dumps the timeseries for each voxel in the mask into a text file
    ~/abin/3dmaskdump -mask region_cau.nii \
		      -o region_cau.txt    \
		      -noijk               \
		      func/swasub-032_task-rest_bold.nii 

    # The text file would need to be rotated
done < power_2010.txt
