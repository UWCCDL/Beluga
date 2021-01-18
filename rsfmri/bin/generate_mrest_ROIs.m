% --------------------- %
% MREST DCM VOI Creator %
% --------------------- %

clc; clear all;

% List of open inputs
folders = dir('/mnt/praxic/pdnetworks2/subjects');

numRuns= 0;
subjs = {};
for j = folders'
    if numel(j.name) == 6
        numRuns= numRuns + 1; 
        subjs(numRuns,:) = {j.name};
    end
end

failedDirect = {};
numFail = 0;
nrun = numRuns;
for crun = 1:nrun
    curSub = subjs{crun,:};
    %disp(curSub)
    currentDir = strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/mrest_results/SPM.mat');
    if exist(currentDir, 'file') == 2       


        % EXTRACTING TIME SERIES: ﻿ActionL
        %---------------------------------------------------------------------
        clear matlabbatch
        disp(['Creating ROI ActionL for subject ' curSub])
        matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2', '/subjects/', curSub, '/session1/', 'mrest_results', '/SPM.mat'));
        matlabbatch{1}.spm.util.voi.adjust = 13;  % Effects of Interest
        matlabbatch{1}.spm.util.voi.session = 1; % Session 1 (no others)
        matlabbatch{1}.spm.util.voi.name = 'ActionL';
        matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
        matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 13;  % The contrast used to identify the VOI
        matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none'; % Uncorrected
        matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.99; % The threshold
        matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0; % No voxel limit
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [-38 -22 60]; % Seed point
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 8;
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 1; % Move to local max
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.global.mask = ''; % none
        matlabbatch{1}.spm.util.voi.expression = 'i1 & i2'; % Not sure why but it's needed
        spm_jobman('run',matlabbatch);
        % EXTRACTING TIME SERIES: ActionR
        %---------------------------------------------------------------------
        clear matlabbatch
        disp(['Creating ROI ActionR for subject ' curSub])
        matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2', '/subjects/', curSub, '/session1/', 'mrest_results', '/SPM.mat'));
        matlabbatch{1}.spm.util.voi.adjust = 13;  % Effects of Interest
        matlabbatch{1}.spm.util.voi.session = 1; % Session 1 (no others)
        matlabbatch{1}.spm.util.voi.name = 'ActionR';
        matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
        matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 13;  % The contrast used to identify the VOI
        matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none'; % Uncorrected
        matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.99; % The threshold
        matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0; % No voxel limit
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [-38 -22 60]; % Seed point
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 8;
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 1; % Move to local max
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.global.mask = ''; % none
        matlabbatch{1}.spm.util.voi.expression = 'i1 & i2'; % Not sure why but it's needed
        spm_jobman('run',matlabbatch);
        % EXTRACTING TIME SERIES: PerceptionR
        %---------------------------------------------------------------------
        clear matlabbatch
        disp(['Creating ROI PerceptionR for subject ' curSub])
        matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2', '/subjects/', curSub, '/session1/', 'mrest_results', '/SPM.mat'));
        matlabbatch{1}.spm.util.voi.adjust = 13;  % Effects of Interest
        matlabbatch{1}.spm.util.voi.session = 1; % Session 1 (no others)
        matlabbatch{1}.spm.util.voi.name = 'PerceptionR';
        matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
        matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 13;  % The contrast used to identify the VOI
        matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none'; % Uncorrected
        matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.99; % The threshold
        matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0; % No voxel limit
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [34 -92 -2]; % Seed point
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 8;
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 1; % Move to local max
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.global.mask = ''; % none
        matlabbatch{1}.spm.util.voi.expression = 'i1 & i2'; % Not sure why but it's needed
        spm_jobman('run',matlabbatch);
        % EXTRACTING TIME SERIES: PerceptionL
        %---------------------------------------------------------------------
        clear matlabbatch
        disp(['Creating ROI PerceptionL for subject ' curSub])
        matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2', '/subjects/', curSub, '/session1/', 'mrest_results', '/SPM.mat'));
        matlabbatch{1}.spm.util.voi.adjust = 13;  % Effects of Interest
        matlabbatch{1}.spm.util.voi.session = 1; % Session 1 (no others)
        matlabbatch{1}.spm.util.voi.name = 'PerceptionL';
        matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
        matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 13;  % The contrast used to identify the VOI
        matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none'; % Uncorrected
        matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.99; % The threshold
        matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0; % No voxel limit
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [-34 -92 -2]; % Seed point
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 8;
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 1; % Move to local max
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.global.mask = ''; % none
        matlabbatch{1}.spm.util.voi.expression = 'i1 & i2'; % Not sure why but it's needed
        spm_jobman('run',matlabbatch);
        % EXTRACTING TIME SERIES: WMR
        %---------------------------------------------------------------------
        clear matlabbatch
        disp(['Creating ROI WMR for subject ' curSub])
        matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2', '/subjects/', curSub, '/session1/', 'mrest_results', '/SPM.mat'));
        matlabbatch{1}.spm.util.voi.adjust = 13;  % Effects of Interest
        matlabbatch{1}.spm.util.voi.session = 1; % Session 1 (no others)
        matlabbatch{1}.spm.util.voi.name = 'WMR';
        matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
        matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 13;  % The contrast used to identify the VOI
        matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none'; % Uncorrected
        matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = .99; % The threshold
        matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0; % No voxel limit
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [44 16 44]; % Seed point
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 8;
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 1; % Move to local max
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.global.mask = ''; % none
        matlabbatch{1}.spm.util.voi.expression = 'i1 & i2'; % Not sure why but it's needed
        spm_jobman('run',matlabbatch);
        % EXTRACTING TIME SERIES: WML
        %---------------------------------------------------------------------
        clear matlabbatch
        disp(['Creating ROI WML for subject ' curSub])
        matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2', '/subjects/', curSub, '/session1/', 'mrest_results', '/SPM.mat'));
        matlabbatch{1}.spm.util.voi.adjust = 13;  % Effects of Interest
        matlabbatch{1}.spm.util.voi.session = 1; % Session 1 (no others)
        matlabbatch{1}.spm.util.voi.name = 'WML';
        matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
        matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 13;  % The contrast used to identify the VOI
        matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none'; % Uncorrected
        matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = .99; % The threshold
        matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0; % No voxel limit
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [-44 16 44]; % Seed point
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 8;
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 1; % Move to local max
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.global.mask = ''; % none
        matlabbatch{1}.spm.util.voi.expression = 'i1 & i2'; % Not sure why but it's needed
        spm_jobman('run',matlabbatch);
        % EXTRACTING TIME SERIES: ProceduralR
        %---------------------------------------------------------------------
        clear matlabbatch
        disp(['Creating ROI ProceduralR for subject ' curSub])
        matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2', '/subjects/', curSub, '/session1/', 'mrest_results', '/SPM.mat'));
        matlabbatch{1}.spm.util.voi.adjust = 13;  % Effects of Interest
        matlabbatch{1}.spm.util.voi.session = 1; % Session 1 (no others)
        matlabbatch{1}.spm.util.voi.name = 'ProceduralR';
        matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
        matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 13;  % The contrast used to identify the VOI
        matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none'; % Uncorrected
        matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.99; % The threshold
        matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0; % No voxel limit
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [16 2 18]; % Seed point
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 6;
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 1; % Move to local max
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.global.mask = ''; % none
        matlabbatch{1}.spm.util.voi.expression = 'i1 & i2'; % Not sure why but it's needed
        spm_jobman('run',matlabbatch);
        % EXTRACTING TIME SERIES: ProceduralL
        %---------------------------------------------------------------------
        clear matlabbatch
        disp(['Creating ROI ProceduralL for subject ' curSub])
        matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2', '/subjects/', curSub, '/session1/', 'mrest_results', '/SPM.mat'));
        matlabbatch{1}.spm.util.voi.adjust = 13;  % Effects of Interest
        matlabbatch{1}.spm.util.voi.session = 1; % Session 1 (no others)
        matlabbatch{1}.spm.util.voi.name = 'ProceduralL';
        matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
        matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 13;  % The contrast used to identify the VOI
        matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none'; % Uncorrected
        matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.99; % The threshold
        matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0; % No voxel limit
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [-16 2 18]; % Seed point
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 6;
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 1; % Move to local max
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.global.mask = ''; % none
        matlabbatch{1}.spm.util.voi.expression = 'i1 & i2'; % Not sure why but it's needed
        spm_jobman('run',matlabbatch);
        % EXTRACTING TIME SERIES: LTMR
        %---------------------------------------------------------------------
        clear matlabbatch
        disp(['Creating ROI LTMR for subject ' curSub])
        matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2', '/subjects/', curSub, '/session1/', 'mrest_results', '/SPM.mat'));
        matlabbatch{1}.spm.util.voi.adjust = 13;  % Effects of Interest
        matlabbatch{1}.spm.util.voi.session = 1; % Session 1 (no others)
        matlabbatch{1}.spm.util.voi.name = 'LTMR';
        matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
        matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 13;  % The contrast used to identify the VOI
        matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none'; % Uncorrected
        matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.99; % The threshold
        matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0; % No voxel limit
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [48 -56 -14]; % Seed point
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 8;
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 1; % Move to local max
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.global.mask = ''; % none
        matlabbatch{1}.spm.util.voi.expression = 'i1 & i2'; % Not sure why but it's needed
        spm_jobman('run',matlabbatch);
        % EXTRACTING TIME SERIES: LTML
        %---------------------------------------------------------------------
        clear matlabbatch
        disp(['Creating ROI LTML for subject ' curSub])
        matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2', '/subjects/', curSub, '/session1/', 'mrest_results', '/SPM.mat'));
        matlabbatch{1}.spm.util.voi.adjust = 13;  % Effects of Interest
        matlabbatch{1}.spm.util.voi.session = 1; % Session 1 (no others)
        matlabbatch{1}.spm.util.voi.name = 'LTML';
        matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
        matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 13;  % The contrast used to identify the VOI
        matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none'; % Uncorrected
        matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.99; % The threshold
        matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0; % No voxel limit
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [-48 -56 -14]; % Seed point
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 8;
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 1; % Move to local max
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.global.mask = ''; % none
        matlabbatch{1}.spm.util.voi.expression = 'i1 & i2'; % Not sure why but it's needed
        spm_jobman('run',matlabbatch);
        % EXTRACTING TIME SERIES: ErrorMaxR
        %---------------------------------------------------------------------
        clear matlabbatch
        disp(['Creating ROI ErrorMaxR for subject ' curSub])
        matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2', '/subjects/', curSub, '/session1/', 'mrest_results', '/SPM.mat'));
        matlabbatch{1}.spm.util.voi.adjust = 13;  % Effects of Interest
        matlabbatch{1}.spm.util.voi.session = 1; % Session 1 (no others)
        matlabbatch{1}.spm.util.voi.name = 'ErrorMaxR';
        matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
        matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 13;  % The contrast used to identify the VOI
        matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none'; % Uncorrected
        matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.99; % The threshold
        matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0; % No voxel limit
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [26 0 54]; % Seed point
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 8;
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 1; % Move to local max
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.global.mask = ''; % none
        matlabbatch{1}.spm.util.voi.expression = 'i1 & i2'; % Not sure why but it's needed
        spm_jobman('run',matlabbatch);
        % EXTRACTING TIME SERIES: ErrorMaxL
        %---------------------------------------------------------------------
        clear matlabbatch
        disp(['Creating ROI ErrorMaxL for subject ' curSub])
        matlabbatch{1}.spm.util.voi.spmmat = cellstr(fullfile('/mnt/praxic/pdnetworks2', '/subjects/', curSub, '/session1/', 'mrest_results', '/SPM.mat'));
        matlabbatch{1}.spm.util.voi.adjust = 13;  % Effects of Interest
        matlabbatch{1}.spm.util.voi.session = 1; % Session 1 (no others)
        matlabbatch{1}.spm.util.voi.name = 'ErrorMaxL';
        matlabbatch{1}.spm.util.voi.roi{1}.spm.spmmat = {''}; % using SPM.mat above
        matlabbatch{1}.spm.util.voi.roi{1}.spm.contrast = 13;  % The contrast used to identify the VOI
        matlabbatch{1}.spm.util.voi.roi{1}.spm.threshdesc = 'none'; % Uncorrected
        matlabbatch{1}.spm.util.voi.roi{1}.spm.thresh = 0.99; % The threshold
        matlabbatch{1}.spm.util.voi.roi{1}.spm.extent = 0; % No voxel limit
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.centre = [-26 0 54]; % Seed point
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.radius = 8;
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.local.spm = 1; % Move to local max
        matlabbatch{1}.spm.util.voi.roi{2}.sphere.move.global.mask = ''; % none
        matlabbatch{1}.spm.util.voi.expression = 'i1 & i2'; % Not sure why but it's needed
        spm_jobman('run',matlabbatch);
        
    else
        
        numFail = numFail + 1;
        disp(['No SPM.mat for ', curSub])
        failed(numFail,:) = cellstr(curSub);
    end
end