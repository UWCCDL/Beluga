This folder contains the scripts used to generate the Power 2011 ROIs
for the functional connectivity anaysis.

To generate the ROIs and extract the data, two scripts are needed:

* `generate_power_2011_rois.sh`: This is a shell script that generates
  264 regions based on the MNI coordinates defined by Power et al
  (2011).

* `extract_roi_timeseries.sh`: This is a shell script that loops
  through all the participant folders (named according to BIDS
  conventions), and extracts from the functional data the timeseries
  for every voxel of every ROI in the Power et al (2011)
  parcellation. The result is 264 text files for each participant,
  each of which will contain as many columns as there are volumes in
  the functional EPI series, and as many rows as there are voxels in
  the ROI. 