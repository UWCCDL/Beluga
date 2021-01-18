%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------------------------------------------------------------------ %
% DCM Model Extractor ---------------------------------------------- %
% ------------------------------------------------------------------ %
% ------------- Can switch between 'CONTROL', 'PD', and 'All' ------ %
% -------------------------------- 'mcvsa', 'mcvsm', and 'mrest' --- %
% -------------------------------- 'direct' and 'modulatory' ------- %
% ------------------------------------------------------------------ %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%% Set up

CURRENTGROUP = 'Healthy';
CURRENTTASK  = 'mrest';
CURRENTMODEL = 'modulatory';

%% Extract data

% Initialize files
clear DCM;
load(strcat('/mnt/praxic/pdnetworks2/subjects/100023/session1/', CURRENTTASK, '_results/DCM_results/DCM_smm_', CURRENTMODEL, '.mat'));
vois={DCM.xY.name};
inputs=DCM.U.name;
nv = DCM.n;
ni = length(inputs);
namesA=cell(nv, nv);
namesB=cell(nv, nv, ni);
namesC=cell(nv, ni);
namesD=cell(nv, nv, nv);
for i=1:nv,
    for j=1:ni,
        namesC{i,j}=strcat(inputs{j},'-to-',vois{i});
    end
    for j=1:nv,
        namesA{i,j}=strcat(vois{j},'-to-',vois{i});
        for k=1:ni,
            namesB{i,j,k}=strcat(vois{j},'-to-',vois{i}, '-by-', inputs{k});
        end
        for k=1:nv,
            namesD{i,j,k}=strcat(vois{j},'-to-',vois{i}, '-by-', vois{k});
        end
    end
end
res_file  = fopen(strcat('/mnt/praxic/pdnetworks2/bin/DCM/Models/', CURRENTTASK, '/', CURRENTGROUP, '/smm_', CURRENTMODEL, '_data_A.txt'), 'w');
c=cumprod(size(namesA));
n=c(end);
vals=reshape(namesA,1,n);
fprintf(res_file, '%s\t', 'Subject');
fprintf(res_file, '%s\t', vals{:});
fprintf(res_file, '\n');
res_file  = fopen(strcat('/mnt/praxic/pdnetworks2/bin/DCM/Models/', CURRENTTASK, '/', CURRENTGROUP, '/smm_', CURRENTMODEL, '_data_B.txt'), 'w');
c=cumprod(size(namesB));
n=c(end);
vals=reshape(namesB,1,n);
fprintf(res_file, '%s\t', 'Subject');
fprintf(res_file, '%s\t', vals{:});
fprintf(res_file, '\n');
res_file  = fopen(strcat('/mnt/praxic/pdnetworks2/bin/DCM/Models/', CURRENTTASK, '/', CURRENTGROUP, '/smm_', CURRENTMODEL, '_data_C.txt'), 'w');
c=cumprod(size(namesC));
n=c(end);
vals=reshape(namesC,1,n);
fprintf(res_file, '%s\t', 'Subject');
fprintf(res_file, '%s\t', vals{:});
fprintf(res_file, '\n');
res_file  = fopen(strcat('/mnt/praxic/pdnetworks2/bin/DCM/Models/', CURRENTTASK, '/', CURRENTGROUP, '/smm_', CURRENTMODEL, '_data_D.txt'), 'w');
c=cumprod(size(namesD));
n=c(end);
vals=reshape(namesD,1,n);
fprintf(res_file, '%s\t', 'Subject');
fprintf(res_file, '%s\t', vals{:});
fprintf(res_file, '\n');

% Loop through subjects and add to said file

failed = {};
numFail = 0;
nrun = numRuns;
for crun = 1:nrun
    curSub = subjs{crun,:};

    currentDir = strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/', CURRENTTASK, '_results/DCM_results/DCM_smm_', CURRENTMODEL, '.mat');
    if exist(currentDir, 'file') == 2 && crun ~= 119 && ~(strcmp(CURRENTTASK, 'mcvsm') && crun == 38)
        
        diseaseFile = strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/0_group');
        if exist(diseaseFile, 'file') == 2
            
            fileID = fopen(diseaseFile, 'r');
            designation = fscanf(fileID, '%s');
            if strcmp(designation, CURRENTGROUP) || strcmp('All', CURRENTGROUP)
                
                if crun ~= 1
                    clear DCM
                    load(strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/', CURRENTTASK, '_results/DCM_results/', 'DCM_smm_', CURRENTMODEL, '.mat'));
                end
                
                %------------------------------------
                disp(['Extracting model smm_' CURRENTMODEL ' data for ' curSub]);

                %------------------------------------

                disp('    Extracting matrix A');
                subj_file = fopen(strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/', CURRENTTASK, '_results/DCM_results/', curSub, '_smm_', CURRENTMODEL, '_data_A.txt'), 'w');
                res_file  = fopen(strcat('/mnt/praxic/pdnetworks2/bin/DCM/Models/', CURRENTTASK, '/', CURRENTGROUP, '/smm_', CURRENTMODEL, '_data_A.txt'), 'a');
                c = cumprod(size(DCM.Ep.A));
                n = c(end);
                fprintf('        (Size: %d)\n', n);
                if n ~= 0
                    vals = reshape(namesA,1,n);
                    fprintf(subj_file, '%s\t', vals{:});
                    fprintf(subj_file, '%f\t', reshape(DCM.Ep.A, 1, n)');
                    fprintf(res_file, '%s\t', curSub);
                    fprintf(res_file, '%f\t', reshape(DCM.Ep.A, 1, n)');
                else
                    display('    Array of size 0 detected');
                end
                fprintf(subj_file, '\n');
                fprintf(res_file, '\n');

                %------------------------------------

                disp('    Extracting matrix B');
                subj_file = fopen(strcat('/mnt/praxic/pdnetworks2/subjects/', curSub,'/session1/', CURRENTTASK, '_results/DCM_results/', curSub, '_smm_', CURRENTMODEL, '_data_B.txt'), 'w');
                res_file  = fopen(strcat('/mnt/praxic/pdnetworks2/bin/DCM/Models/', CURRENTTASK, '/', CURRENTGROUP, '/smm_', CURRENTMODEL, '_data_B.txt'), 'a');
                c = cumprod(size(DCM.Ep.B));
                n = c(end);
                fprintf('        (Size: %d)\n', n);
                if n ~= 0
                    vals = reshape(namesB,1,n);
                    fprintf(subj_file, '%s\t', vals{:});
                    fprintf(subj_file, '%f\t', reshape(DCM.Ep.B, 1, n)');
                    fprintf(res_file, '%s\t', curSub);
                    fprintf(res_file, '%f\t', reshape(DCM.Ep.B, 1, n)');
                else
                    display('    Array of size 0 detected');
                end
                fprintf(subj_file, '\n');
                fprintf(res_file, '\n');

                %------------------------------------

                disp('    Extracting matrix C');
                subj_file = fopen(strcat('/mnt/praxic/pdnetworks2/subjects/', curSub,'/session1/', CURRENTTASK, '_results/DCM_results/', curSub, '_smm_', CURRENTMODEL, '_data_C.txt'), 'w');
                res_file  = fopen(strcat('/mnt/praxic/pdnetworks2/bin/DCM/Models/', CURRENTTASK, '/', CURRENTGROUP, '/smm_', CURRENTMODEL, '_data_C.txt'), 'a');
                c = cumprod(size(DCM.Ep.C));
                n = c(end);
                fprintf('        (Size: %d)\n', n);
                if n ~= 0
                    vals = reshape(namesC,1,n);
                    fprintf(subj_file, '%s\t', vals{:});
                    fprintf(subj_file, '%f\t', reshape(DCM.Ep.C, 1, n)');
                    fprintf(res_file, '%s\t', curSub);
                    fprintf(res_file, '%f\t', reshape(DCM.Ep.C, 1, n)');
                else
                    display('    Array of size 0 detected');
                end
                fprintf(subj_file, '\n');
                fprintf(res_file, '\n');

                %------------------------------------

                disp('    Extracting matrix D');
                subj_file = fopen(strcat('/mnt/praxic/pdnetworks2/subjects/', curSub,'/session1/', CURRENTTASK, '_results/DCM_results/', curSub, '_smm_', CURRENTMODEL, '_data_D.txt'), 'w');
                res_file  = fopen(strcat('/mnt/praxic/pdnetworks2/bin/DCM/Models/', CURRENTTASK, '/', CURRENTGROUP, '/smm_', CURRENTMODEL, '_data_D.txt'), 'a');
                c = cumprod(size(DCM.Ep.D));
                n = c(end);
                fprintf('        (Size: %d)\n', n);
                if n ~= 0
                    vals = reshape(namesD,1,n);
                    fprintf(subj_file, '%s\t', vals{:});
                    fprintf(subj_file, '%f\t', reshape(DCM.Ep.D, 1, n)');
                    fprintf(res_file, '%s\t', curSub');
                    fprintf(res_file, '%f\t', reshape(DCM.Ep.D, 1, n)');
                else
                    display('    Array of size 0 detected');
                end
                fprintf(subj_file, '\n');
                fprintf(res_file, '\n');
                %------------------------------------
            else
                numFail = numFail + 1;
                disp(['No Direct Model for ', curSub])
                failed(numFail,:) = cellstr(curSub);
            end
        end
    end
end

