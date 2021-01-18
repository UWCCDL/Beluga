%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bayesian Model Selection between modulatory and direct models %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear all;


%% Scripted version
folders = dir('/mnt/praxic/pdnetworks2/subjects');

numRuns= 0;
subjs = {};
for j = folders'
    if numel(j.name) == 6
        numRuns= numRuns + 1; 
        subjs(numRuns,:) = {j.name};
    end
end

%% BMS Comparison

failed = {};
numFail = 0;
numSucceed = 0;
nrun = numRuns;

matlabbatch{1}.spm.dcm.bms.inference.dir = {'/mnt/praxic/pdnetworks2/bin/DCM/Models/mrest/All'};
for crun = 1:nrun
    curSub = subjs{crun,:};
    %disp(curSub)
    currentDir = strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/mrest_results/DCM_results/DCM_smm_direct.mat');
    if exist(currentDir, 'file') == 2
    
        numSucceed = numSucceed + 1;  
        
        matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{numSucceed}.dcmmat = {
        strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/mrest_results/DCM_results/DCM_smm_direct.mat')
        strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/mrest_results/DCM_results/DCM_smm_modulatory.mat')
        }; 
    
        disp(['matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{', int2str(numSucceed), '}.dcmmat = {'])
        disp(strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/mrest_results/DCM_results/DCM_smm_direct.mat'))
        disp(strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/mrest_results/DCM_results/DCM_smm_modulatory.mat'))
        disp('};')
       
    else
        numFail = numFail + 1;
        disp(['Failed BMS for ', curSub])
        failed(numFail,:) = cellstr(curSub);
    end
end

matlabbatch{1}.spm.dcm.bms.inference.model_sp = {''};
matlabbatch{1}.spm.dcm.bms.inference.load_f = {''};
matlabbatch{1}.spm.dcm.bms.inference.method = 'FFX';
matlabbatch{1}.spm.dcm.bms.inference.family_level.family_file = {''};
matlabbatch{1}.spm.dcm.bms.inference.bma.bma_no = 0;
matlabbatch{1}.spm.dcm.bms.inference.verify_id = 0;
spm_jobman('run',matlabbatch);