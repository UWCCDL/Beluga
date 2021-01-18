%-----------------------------------------------------------------------
% Created 27-Nov-2019 13:26:20
% spm SPM - SPM12 (7487)
% Micah Ketola combine right and left ROIs
%-----------------------------------------------------------------------
% Just change mcvsa to mcvsm and voi.adjust from 10 to 16
clc; clear all;

% List of open inputs
folders = dir('/mnt/praxic/pdnetworks2/subjects');

% initialize error log
errorlog = {}; ctr=1;
conditions = ['mrest'];

numRuns= 0;
subjs = {};
for j = folders'
    if numel(j.name) == 6
        numRuns= numRuns + 1; 
        subjs(numRuns,:) = {j.name};
    end
end

allVOIs = {'Action', 'LTM', 'Perception', 'Procedural', 'WM'};
failed = {};
numFail = 0;
nrun = numRuns;
for crun = 1:nrun
    curSub = subjs{crun,:};
    %disp(curSub)
    currentDir = strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/mrest_results/VOI_Action_combined_mask.nii');
    if exist(currentDir, 'file') == 2
        for curVOI = allVOIs
            clear matlabbatch
            disp(['Creating ROI ' curVOI ' for subject ' curSub])
            namingStuff = strcat(curVOI, '_combined');
            matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/mrest_results/SPM.mat'));
            matlabbatch{1}.spm.util.voi.adjust = 13;
            matlabbatch{1}.spm.util.voi.session = 1;
            matlabbatch{1}.spm.util.voi.name = namingStuff{1};
            matlabbatch{1}.spm.util.voi.roi{1}.mask.image = cellstr(strcat('/mnt/praxic/pdnetworks2/subjects/', curSub,'/session1/mrest_results/VOI_', curVOI,'_combined_mask.nii,1'));
            matlabbatch{1}.spm.util.voi.roi{1}.mask.threshold = 0.99;
            matlabbatch{1}.spm.util.voi.expression = 'i1';
            spm_jobman('run',matlabbatch);
        end
    else
        numFail = numFail + 1;
        disp(['No SPM.mat for ', curSub])
        failed(numFail,:) = cellstr(curSub);
    end
end
