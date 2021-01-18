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

%% Left Side
% Extracting Action VOI
cd '/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/'
res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/ActionL_xyz.txt', 'w');
names = {'Subject', 'VOI', 'x', 'y', 'z', 'Size'};
fprintf(res_file, '%s\t', names{:});
fprintf(res_file, '\n');

for crun = 1:numRuns
    curSub = subjs{crun,:};
    fileName = fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results','VOI_ActionL_1.mat');
    if exist(fileName, 'file') > 0
        disp('Extracting VOI ActionL data for')
        disp(curSub);
        res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/ActionL_xyz.txt', 'a');

        cd(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results'))
        load('VOI_ActionL_1.mat', 'xY');
        fprintf(res_file, '%s\t', curSub);
        fprintf(res_file, '%s\t', xY.name);
        fprintf(res_file, '%f\t', xY.xyz');
        fprintf(res_file, '%f\t', length(xY.s));
        fprintf(res_file, '\n');  
    else
        display('fuck');
    end
end

% Extracting LTM VOI
cd '/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/'
res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/LTML_xyz.txt', 'w');
names = {'Subject', 'VOI', 'x', 'y', 'z', 'Size'};
fprintf(res_file, '%s\t', names{:});
fprintf(res_file, '\n');

for crun = 1:numRuns
    curSub = subjs{crun,:};
    fileName = fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results','VOI_LTML_1.mat');
    if exist(fileName, 'file') > 0
        disp('Extracting VOI LTML data for')
        disp(curSub);
        res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/LTML_xyz.txt', 'a');

        cd(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results'))
        load('VOI_LTML_1.mat', 'xY');
        fprintf(res_file, '%s\t', curSub);
        fprintf(res_file, '%s\t', xY.name);
        fprintf(res_file, '%f\t', xY.xyz');
        fprintf(res_file, '%f\t', length(xY.s));
        fprintf(res_file, '\n');  
    else
        display('fuck');
    end
end

% Extracting WM VOI
cd '/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/'
res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/WML_xyz.txt', 'w');
names = {'Subject', 'VOI', 'x', 'y', 'z', 'Size'};
fprintf(res_file, '%s\t', names{:});
fprintf(res_file, '\n');

for crun = 1:numRuns
    curSub = subjs{crun,:};
    fileName = fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results','VOI_WML_1.mat');
    if exist(fileName, 'file') > 0
        disp('Extracting VOI WML data for')
        disp(curSub);
        res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/WML_xyz.txt', 'a');

        cd(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results'))
        load('VOI_WML_1.mat', 'xY');
        fprintf(res_file, '%s\t', curSub);
        fprintf(res_file, '%s\t', xY.name);
        fprintf(res_file, '%f\t', xY.xyz');
        fprintf(res_file, '%f\t', length(xY.s));
        fprintf(res_file, '\n');  
    else
        display('fuck');
    end
end

% Extracting Perception VOI
cd '/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/'
res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/PerceptionL_xyz.txt', 'w');
names = {'Subject', 'VOI', 'x', 'y', 'z', 'Size'};
fprintf(res_file, '%s\t', names{:});
fprintf(res_file, '\n');

for crun = 1:numRuns
    curSub = subjs{crun,:};
    fileName = fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results','VOI_PerceptionL_1.mat');
    if exist(fileName, 'file') > 0
        disp('Extracting VOI PerceptionL data for')
        disp(curSub);
        res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/PerceptionL_xyz.txt', 'a');

        cd(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results'))
        load('VOI_PerceptionL_1.mat', 'xY');
        fprintf(res_file, '%s\t', curSub);
        fprintf(res_file, '%s\t', xY.name);
        fprintf(res_file, '%f\t', xY.xyz');
        fprintf(res_file, '%f\t', length(xY.s));
        fprintf(res_file, '\n');  
    else
        display('fuck');
    end
end

% Extracting Procedural VOI
cd '/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/'
res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/ProceduralL_xyz.txt', 'w');
names = {'Subject', 'VOI', 'x', 'y', 'z', 'Size'};
fprintf(res_file, '%s\t', names{:});
fprintf(res_file, '\n');

for crun = 1:numRuns
    curSub = subjs{crun,:};
    fileName = fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results','VOI_ProceduralL_1.mat');
    if exist(fileName, 'file') > 0
        disp('Extracting VOI ProceduralL data for')
        disp(curSub);
        res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/ProceduralL_xyz.txt', 'a');

        cd(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results'))
        load('VOI_ProceduralL_1.mat', 'xY');
        fprintf(res_file, '%s\t', curSub);
        fprintf(res_file, '%s\t', xY.name);
        fprintf(res_file, '%f\t', xY.xyz');
        fprintf(res_file, '%f\t', length(xY.s));
        fprintf(res_file, '\n');  
    else
        display('fuck');
    end
end


%% Right Side
% Extracting Action VOI
cd '/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/'
res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/ActionR_xyz.txt', 'w');
names = {'Subject', 'VOI', 'x', 'y', 'z', 'Size'};
fprintf(res_file, '%s\t', names{:});
fprintf(res_file, '\n');

for crun = 1:numRuns
    curSub = subjs{crun,:};
    fileName = fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results','VOI_ActionR_1.mat');
    if exist(fileName, 'file') > 0
        disp('Extracting VOI ActionR data for')
        disp(curSub);
        res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/ActionR_xyz.txt', 'a');

        cd(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results'))
        load('VOI_ActionR_1.mat', 'xY');
        fprintf(res_file, '%s\t', curSub);
        fprintf(res_file, '%s\t', xY.name);
        fprintf(res_file, '%f\t', xY.xyz');
        fprintf(res_file, '%f\t', length(xY.s));
        fprintf(res_file, '\n');  
    else
        display('fuck');
    end
end

% Extracting LTM VOI
cd '/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/'
res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/LTMR_xyz.txt', 'w');
names = {'Subject', 'VOI', 'x', 'y', 'z', 'Size'};
fprintf(res_file, '%s\t', names{:});
fprintf(res_file, '\n');

for crun = 1:numRuns
    curSub = subjs{crun,:};
    fileName = fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results','VOI_LTMR_1.mat');
    if exist(fileName, 'file') > 0
        disp('Extracting VOI LTMR data for')
        disp(curSub);
        res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/LTMR_xyz.txt', 'a');

        cd(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results'))
        load('VOI_LTMR_1.mat', 'xY');
        fprintf(res_file, '%s\t', curSub);
        fprintf(res_file, '%s\t', xY.name);
        fprintf(res_file, '%f\t', xY.xyz');
        fprintf(res_file, '%f\t', length(xY.s));
        fprintf(res_file, '\n');  
    else
        display('fuck');
    end
end

% Extracting WM VOI
cd '/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/'
res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/WMR_xyz.txt', 'w');
names = {'Subject', 'VOI', 'x', 'y', 'z', 'Size'};
fprintf(res_file, '%s\t', names{:});
fprintf(res_file, '\n');

for crun = 1:numRuns
    curSub = subjs{crun,:};
    fileName = fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results','VOI_WMR_1.mat');
    if exist(fileName, 'file') > 0
        disp('Extracting VOI WMR data for')
        disp(curSub);
        res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/WMR_xyz.txt', 'a');

        cd(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results'))
        load('VOI_WMR_1.mat', 'xY');
        fprintf(res_file, '%s\t', curSub);
        fprintf(res_file, '%s\t', xY.name);
        fprintf(res_file, '%f\t', xY.xyz');
        fprintf(res_file, '%f\t', length(xY.s));
        fprintf(res_file, '\n');  
    else
        display('fuck');
    end
end

% Extracting Perception VOI
cd '/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/'
res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/PerceptionR_xyz.txt', 'w');
names = {'Subject', 'VOI', 'x', 'y', 'z', 'Size'};
fprintf(res_file, '%s\t', names{:});
fprintf(res_file, '\n');

for crun = 1:numRuns
    curSub = subjs{crun,:};
    fileName = fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results','VOI_PerceptionR_1.mat');
    if exist(fileName, 'file') > 0
        disp('Extracting VOI PerceptionR data for')
        disp(curSub);
        res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/PerceptionR_xyz.txt', 'a');

        cd(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results'))
        load('VOI_PerceptionR_1.mat', 'xY');
        fprintf(res_file, '%s\t', curSub);
        fprintf(res_file, '%s\t', xY.name);
        fprintf(res_file, '%f\t', xY.xyz');
        fprintf(res_file, '%f\t', length(xY.s));
        fprintf(res_file, '\n');  
    else
        display('fuck');
    end
end

% Extracting Procedural VOI
cd '/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/'
res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/ProceduralR_xyz.txt', 'w');
names = {'Subject', 'VOI', 'x', 'y', 'z', 'Size'};
fprintf(res_file, '%s\t', names{:});
fprintf(res_file, '\n');

for crun = 1:numRuns
    curSub = subjs{crun,:};
    fileName = fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results','VOI_ProceduralR_1.mat');
    if exist(fileName, 'file') > 0
        disp('Extracting VOI ProceduralR data for')
        disp(curSub);
        res_file  = fopen('/mnt/praxic/pdnetworks2/bin/DCM/Extract-VOIs/ProceduralR_xyz.txt', 'a');

        cd(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mrest_results'))
        load('VOI_ProceduralR_1.mat', 'xY');
        fprintf(res_file, '%s\t', curSub);
        fprintf(res_file, '%s\t', xY.name);
        fprintf(res_file, '%f\t', xY.xyz');
        fprintf(res_file, '%f\t', length(xY.s));
        fprintf(res_file, '\n');  
    else
        display('fuck');
    end
end