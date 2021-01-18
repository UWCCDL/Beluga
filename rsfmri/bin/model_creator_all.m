%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to make all of the models for MCVSM %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% ------------------------------------------------------------------ %
% Direct DCM Model Creator
% ------------------------------------------------------------------ %


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

%% Direct Model

failedDirect = {};
numFail = 0;
nrun = numRuns;
for crun = 1:nrun
    curSub = subjs{crun,:};
    %disp(curSub)
    currentDir = strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/mcvsm_results/VOI_ActionL_1.mat');
    if exist(currentDir, 'file') == 2



        clear DCM;
        load(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', 'SPM.mat'));

        % --- The VOIs ----------------------------------------------------- %
        load(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', 'VOI_ActionL_1.mat'), 'xY');
        DCM.xY(1) = xY;

        load(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', 'VOI_LTM_combined_1.mat'), 'xY');
        DCM.xY(2) = xY;

        load(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', 'VOI_Perception_combined_1.mat'), 'xY');
        DCM.xY(3) = xY;

        load(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', 'VOI_Procedural_combined_1.mat'), 'xY');
        DCM.xY(4) = xY;

        load(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', 'VOI_WM_combined_1.mat'), 'xY');
        DCM.xY(5) = xY;

        DCM.n = length(DCM.xY); % Num of regions
        DCM.v = length(DCM.xY(1).u); % Num of time points
        DCM.Y.dt  = SPM.xY.RT;
        DCM.Y.X0  = DCM.xY(1).X0;
        for i = 1:DCM.n
            DCM.Y.y(:,i)  = DCM.xY(i).u;
            DCM.Y.name{i} = DCM.xY(i).name;
        end

        DCM.Y.Q    = spm_Ce(ones(1,DCM.n)*DCM.v);
        DCM.U.dt   = SPM.Sess.U(1).dt;
        DCM.U.name = [SPM.Sess.U(1).name ...
                      SPM.Sess.U(2).name];

        % --- The Inputs --------------------------------------------------- %

        DCM.U.u    = [SPM.Sess.U(1).u(33:end,1) ...
                      SPM.Sess.U(2).u(33:end,1)];

        % Set delays and TE (TE should be gotten from SPM?)

        DCM.delays = repmat(SPM.xY.RT,5,1);
        DCM.TE     = 0.0275;
        DCM.options.nonlinear  = 0;
        DCM.options.two_state  = 0;
        DCM.options.stochastic = 0;
        DCM.options.centre = 0;
        DCM.options.nograph    = 1;

        % --- The Matrices ------------------------------------------------- %

        DCM.a = eye(5,5);
        DCM.a(1,3) = 1 % Perception -> Action
        DCM.a(3,1) = 1 % Action -> Perception
        DCM.a(5,2) = 1 % LTM -> WM
        DCM.a(2,5) = 1 % WM -> LTM
        DCM.a(5,3) = 1 % Perception -> WM
        DCM.a(3,5) = 1 % WM -> Perception
        DCM.a(1,5) = 1 % WM -> Action
        DCM.a(4,5) = 1 % WM -> Procedural
        DCM.a(5,4) = 1 % Procedural -> WM

        DCM.b = zeros(5,5,2);

        DCM.c = zeros(5,2);
        DCM.c(3,1) = 1 % cue -> Perception
        DCM.c(3,2) = 1 % shift -> Perception
        DCM.c(5,1) = 4 % twoback -> WM

        DCM.d = zeros(5,5,5);

        % --- Saving and estimating ---------------------------------------- %

        save(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', '/DCM_results', 'DCM_smm_direct.mat'));
        disp(['Estimating model smm_direct for subject ' curSub]);
        spm_dcm_estimate(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', '/DCM_results', 'DCM_smm_direct.mat'));

    end
end


% ------------------------------------------------------------------ %
% Modulatory DCM Model Creator
% ------------------------------------------------------------------ %
% ------ ONLY NEED TO REPLACE mcvsm with mcvsm and vice versa ------ %
% ------------------------------------------------------------------ %

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

%% Modulatory Model

failedMod = {};
numFail = 0;
nrun = numRuns;
for crun = 1:nrun
    curSub = subjs{crun,:};
    %disp(curSub)
    currentDir = strcat('/mnt/praxic/pdnetworks2/subjects/', curSub, '/session1/mcvsm_results/VOI_ActionL_1.mat');
    if exist(currentDir, 'file') == 2

        clear DCM;
        load(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', 'SPM.mat'));

        % --- The VOIs ----------------------------------------------------- %
        load(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', 'VOI_ActionL_1.mat'), 'xY');
        DCM.xY(1) = xY;

        load(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', 'VOI_LTM_combined_1.mat'), 'xY');
        DCM.xY(2) = xY;

        load(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', 'VOI_Perception_combined_1.mat'), 'xY');
        DCM.xY(3) = xY;

        load(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', 'VOI_Procedural_combined_1.mat'), 'xY');
        DCM.xY(4) = xY;

        load(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', 'VOI_WM_combined_1.mat'), 'xY');
        DCM.xY(5) = xY;

        DCM.n = length(DCM.xY); % Num of regions
        DCM.v = length(DCM.xY(1).u); % Num of time points
        DCM.Y.dt  = SPM.xY.RT;
        DCM.Y.X0  = DCM.xY(1).X0;
        for i = 1:DCM.n
            DCM.Y.y(:,i)  = DCM.xY(i).u;
            DCM.Y.name{i} = DCM.xY(i).name;
        end

        DCM.Y.Q    = spm_Ce(ones(1,DCM.n)*DCM.v);
        DCM.U.dt   = SPM.Sess.U(1).dt;
        DCM.U.name = [SPM.Sess.U(1).name ...
                      SPM.Sess.U(2).name];

        % --- The Inputs --------------------------------------------------- %

        DCM.U.u    = [SPM.Sess.U(1).u(33:end,1) ...
                      SPM.Sess.U(2).u(33:end,1)];

        % Set delays and TE (TE should be gotten from SPM?)

        DCM.delays = repmat(SPM.xY.RT,5,1);
        DCM.TE     = 0.0275;
        DCM.options.nonlinear  = 1;
        DCM.options.two_state  = 0;
        DCM.options.stochastic = 0;
        DCM.options.centre = 0;
        DCM.options.nograph    = 1;

        % --- The Matrices ------------------------------------------------- %

        DCM.a = eye(5,5);
        DCM.a(1,3) = 1 % Perception_combined -> Action_combined
        DCM.a(3,1) = 1 % Action_combined -> Perception_combined
        DCM.a(5,2) = 1 % LTM_combined -> WM_combined
        DCM.a(2,5) = 1 % WM_combined -> LTM_combined
        DCM.a(5,3) = 1 % Perception_combined -> WM_combined
        DCM.a(3,5) = 1 % WM_combined -> Perception_combined
        DCM.a(1,5) = 1 % WM_combined -> Action_combined
        DCM.a(4,5) = 1 % WM_combined -> Procedural_combined

        DCM.b = zeros(5,5,2);

        DCM.c = zeros(5,2);
        DCM.c(3,1) = 1 % cue -> Perception_combined
        DCM.c(3,2) = 1 % shift -> Perception_combined
        DCM.c(5,1) = 4 % twoback -> WM_combined

        DCM.d = zeros(5,5,5);
        DCM.d(5,3,4) = 1 % Procedural_combined -> Perception_combined -> WM_combined
        DCM.d(5,2,4) = 1 % Procedural_combined -> LTM_combined -> WM_combined

        % --- Saving and estimating ---------------------------------------- %

        save(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', '/DCM_results', 'DCM_smm_modulatory.mat'));
        disp(['Estimating model smm_modulatory for subject ' curSub]);
        spm_dcm_estimate(fullfile('/mnt/praxic/pdnetworks2/subjects', curSub, 'session1', 'mcvsm_results', '/DCM_results', 'DCM_smm_modulatory.mat'));
            
    end
end