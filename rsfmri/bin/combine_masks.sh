#!/bin/bash

# Combines masks using fsl

HOME=/mnt/praxic/pdnetworks2/subjects
SUBJ_FOLDERS=${HOME}/[0-9][0-9][0-9][0-9][0-9][0-9]
FSL_DIR=/usr/share/fsl/5.0/bin

for s in ${SUBJ_FOLDERS[@]}; do
	SUBJS+=("${s: -6}")
done


DIR_NAMES=('mrest_results')

MASK_NAMES=('VOI_Action'
	    'VOI_Perception'
	    'VOI_WM'
	    'VOI_Procedural'
	    'VOI_LTM')

# for each subject 
for curSUB in ${SUBJS[@]}; do

    for curDIR in ${DIR_NAMES[@]}; do

	for curFile in ${MASK_NAMES[@]}; do
	    FOLDER_PATH=${HOME}/${curSUB}/session1/${curDIR}
	    cd $FOLDER_PATH/
	    	    
	    if [ -e ${FOLDER_PATH}/${curFile}L_mask.nii.gz ]; then
	       ${FSL_DIR}/fslmaths ${FOLDER_PATH}/${curFile}L_mask.nii.gz -add ${FOLDER_PATH}/${curFile}R_mask.nii.gz ${FOLDER_PATH}/${curFile}_combined_mask.nii.gz
	       echo input 1: ${FOLDER_PATH}/${curFile}L_mask.nii.gz
	       echo input 2: ${FOLDER_PATH}/${curFile}R_mask.nii.gz
	       echo output : ${FOLDER_PATH}/${curFile}_combined_mask.nii.gz
	    elif [ -e  ${FOLDER_PATH}/${curFile}L_mask.nii ]; then
		gzip ${FOLDER_PATH}/${curFile}L_mask.nii
		gzip ${FOLDER_PATH}/${curFile}R_mask.nii
	    else
	       echo No file found for subject ${curSUB}
	    fi

	    if [ -e ${FOLDER_PATH}/${curFile}_combined_mask.nii.gz ]; then
		gunzip ${FOLDER_PATH}/${curFile}_combined_mask.nii.gz
	    fi
	done
    done
done

	

