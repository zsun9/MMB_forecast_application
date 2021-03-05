% The file is used for estimating models and generating forecasts
% Two structs: p - high-level parameters, t - temporary parameters in a loop
% Last updated: Zexi Sun, 2020-06-10

%% settings
% pick a dynare path
if 0
    addpath C:\dynare\4.5.7\matlab
    addpath C:\dynare\4.2.4\matlab
    rmpath('C:\dynare\4.5.7\matlab')
    rmpath('C:\dynare\4.2.4\matlab')
end

% navigate to the root folder (if exists)
try
    cd(p.path.root)
end

% housekeeping
close all; fclose all; clear; clc;

% user-specified parameters
% Please use double quotes here!
% cell array format---------- Format: {' ', ' ', ' '}
p.vintages = {'2021-02-09'}; 
p.scenarios = {'s1', 's2', 's3', 's4'};
p.models = {'KR15_HH'};% "DS04", "WW11", "NKBGG", "DNGS15", "SW07", "QPM08", "KR15_FF"
% text format -------------- Format: ' '
p.executor = 'Zexi';
p.comment = '_matlab2011a_dy424';
p.ExcelColumnUntil = 'AY';


% hyper-parameters
p.chainLen = 1000000;
p.chainLenBVAR = 500000;
p.subDraws = 5000;
p.forecastHorizon = 40;
p.chainNum = 1;
p.burnIn = 0.3;
p.scalingParam =  0.3;
p.presample = 4;
p.nobs = 100;
p.mode_compute_order = [4, 7, 1, 3, 5, 6];

% locate main folders (stored as char type)
p.path.root = pwd; %p.path.root = convertCharsToStrings(pwd);
p.path.models = [p.path.root, '\\models'];
p.path.glp_algorithm = [p.path.models, '\\GLP_algorithm'];
p.path.estimations = [p.path.root, '\\estimations'];
p.path.vintage_data = [p.path.root, '\\data\\vintage_data'];
%assert(isfolder(p.path.root) && isfolder(p.path.models) && isfolder(p.path.glp_algorithm) && isfolder(p.path.estimations) && isfolder(p.path.vintage_data));
assert(isequal(exist(p.path.root, 'dir'),7) && isequal(exist(p.path.models, 'dir'),7) && isequal(exist(p.path.glp_algorithm, 'dir'),7) && isequal(exist(p.path.vintage_data, 'dir'),7))

%% DSGE estimation

p.dynareVersion = dynare_version;
if ~isequal(p.dynareVersion, '4.5.7') 
   warning(sprintf('You are about to estimate models using Dynare %s.', p.dynareVersion));
   warning('Please make sure this is the version you need!');
   pause(5);
end

clear t;


for ind_model = 1:length(p.models) ;%model = p.models
    model = p.models{ind_model}
    
    if ~isempty(strfind(model,'GLP'))     %contains(model, 'GLP')
        continue
    end
    
    t.path.model = strcat(p.path.models, '\\' , model);

    if isequal(exist(t.path.model, 'dir'),7) %%isfolder(t.path.model) 
        
        for ind_vintage = 1: length(p.vintages); %vintage = p.vintages
            vintage = p.vintages{ind_vintage};
            for ind_scenario = 1:length(p.scenarios);% scenario = p.scenarios
                scenario = p.scenarios{ind_scenario};
                clc;
                
                t.name.modfile = strcat(model, '.mod');
                
                tStart = tic;
                
                % create folder and copy model files
                cd(p.path.root);
                t.name.workingpath = strcat(model , '_' , strrep(vintage, '-', '') , '_' , scenario, p.comment);
                t.path.working = strcat(p.path.estimations , '\\' , t.name.workingpath);
                
                if isequal(exist(t.path.working, 'dir'),7)
                    warning(sprintf('Folder %s already exists!', t.name.workingpath{1}))
                    warning('Enter Y to delete existing files and continue.');
                    warning('Enter C to keep existing files and continue.');
                    warning('Enter N to keep existing files and skip this estimation.');
                    t.choice = '';
                    while ~ismember(lower(t.choice), ['y', 'c', 'n'])
                        beep;
                        t.choice = input('', 's');
                    end
                    t.choice = lower(t.choice);
                    
                    switch t.choice
                        case 'y'
                            rmdir(t.path.working, 's');
                            copyfile(t.path.model, t.path.working);
                        case 'c'
                            copyfile(t.path.model, t.path.working);
                        case 'n'
                            continue;
                    end
                    
                else
                    warning(sprintf('Folder %s does not exist, will be created.', t.name.workingpath));
                    copyfile(t.path.model, t.path.working);
                end
                
                % retreive Dynare scripts and varobs
                cd(t.path.working);
                t.script.modfile = fileread(t.name.modfile);
                t.script.modfile = strrep(t.script.modfile, '%', '%%');
                t.script.modfile = strrep(t.script.modfile, '\', '\\');
%                 t.varobs = convertCharsToStrings(regexp(t.modfileScript, "varobs[ _a-z0-9\n]{1,};", 'match'));
%                 if isempty(t.varobs)
%                     fprintf('varobs not found in the mod file, and the estimation will be skipped.\n');
%                 else
%                     for replace = ["varobs", "\n", ";"]
%                         t.varobs = strrep(t.varobs, replace, " ");
%                     end
%                     t.varobs = strsplit(t.varobs);
%                 end

                % copy data to the folder
                cd(p.path.root);
                t.name.datafile = strcat('data_', strrep(vintage, '-', ''), '.xlsx');
                t.path.data = strcat(p.path.vintage_data, '\\', t.name.datafile);
                if isequal(exist(t.path.data,'file'),2) %isfile(t.path.data{1})
                    copyfile(t.path.data, t.path.working);
                else
                    fprintf('Data file %s not found, and the estimation will be skipped.\n', t.name.datafile);
                end
                
                % build up the estimation command
                t.dataFile = strcat('data_', strrep(vintage, '-', ''));
                t.xlsRange = strcat('B1:', p.ExcelColumnUntil, num2str(p.nobs + (~any(strcmp(scenario,'s1')))));
                if isequal(p.dynareVersion,'4.2.4')   
                    p.optionString.subDraws = '';
                    p.optionString.nodisplay = 'nograph';
                else
                    p.optionString.subDraws = sprintf('sub_draws=%s, ', num2str(p.subDraws));
                    p.optionString.nodisplay = 'nodisplay';
                end
                t.script.estimation = ['\nestimation(' ...
                    p.optionString.nodisplay    ...
                    ', smoother, order=1, prefilter=0, mode_check, bayesian_irf, '  ...
                    sprintf('datafile=%s, ', t.dataFile)  ...
                    sprintf('xls_sheet=%s, ', scenario)  ...
                    sprintf('xls_range=%s, ', t.xlsRange)  ...
                    sprintf('presample=%s, ', num2str(p.presample))  ...
                    sprintf('mh_replic=%s, ', num2str(p.chainLen))  ...
                    sprintf('mh_nblocks=%s, ', num2str(p.chainNum))  ...
                    sprintf('mh_jscale=%s, ', num2str(p.scalingParam))  ...
                    sprintf('mh_drop=%s, ', num2str(p.burnIn))  ...
                    p.optionString.subDraws  ...
                    sprintf('forecast=%s, ', num2str(p.forecastHorizon))  ...
                    sprintf('mode_compute=%s', num2str(p.mode_compute_order(1)))  ...
                    ') gdp_rgd_obs;'];
                
                if isequal(model,'QPM08')
                    t.script.estimation = strrep(t.script.estimation, ') gdp_rgd_obs;', ') gdpl_rgd_obs;');
                end
                
                cd(t.path.working);
                
                % save means of observables
               [t.data.table,t.data.name,~] = xlsread(t.path.data, scenario);
                t.data.name = t.data.name(1,:);
                t.data.mean = nanmean(t.data.table,1);
                t.script.obsMean = '';
                for i = 1:length(t.data.mean)
                    t.script.obsMean = [t.script.obsMean  sprintf('%s_mean = %.10f;\n', t.data.name{i+1}, t.data.mean(i))];
                end
                obsMeanFile = fopen('obsMean.m', 'w');
                fprintf(obsMeanFile, t.script.obsMean);
                fclose(obsMeanFile);
                
                % change xlsx format to xls =======
                if isequal(p.dynareVersion,'4.2.4')
                   tmp.readxlsx = strcat(t.dataFile,'.xlsx');
                   [~,~,tmp.xlsx] = xlsread(tmp.readxlsx, scenario);
                   xlswrite(t.dataFile, tmp.xlsx, scenario)
                end    
                % =================================
                % loop through different mode compute routines
                t.name.modefile = [model  '_mode.mat'];  
                if isequal(exist(t.name.modefile,'file'),2) 
                    fprintf('Mode file exists, and the ML estimation will be skipped.\n');
                    % if mode file exists, then skip ML estimation
                    t.mode_compute = 0;
                    t.script.estimation = strrep(t.script.estimation, ...
                        sprintf('mode_compute=%s', num2str(p.mode_compute_order(1))), ...
                        sprintf('mode_compute=%s, mode_file=%s', num2str(t.mode_compute), strrep(t.name.modefile, '.mat', '')));
                    
                    DynareFile = fopen(char(t.name.modfile),'w');
                    fprintf(DynareFile, [t.script.modfile   t.script.estimation]);
                    fclose(DynareFile);
                    
                    pause(5);
                    dy.exp = ['dynare '  char(t.name.modfile) ' noclearall'];
                    eval(dy.exp)

                else
                    fprintf('Mode file not exists, and mode computation will be started.\n');
                    % else loop through all mode compute routines
                    for i = 1:length(p.mode_compute_order)
                        t.mode_compute = p.mode_compute_order(i);
                        if i>1
                            t.script.estimation = strrep(t.script.estimation, ...
                                sprintf('mode_compute=%s', num2str(p.mode_compute_order(i-1))), ...
                                sprintf('mode_compute=%s', num2str(p.mode_compute_order(i))));
                        end
                        
                        DynareFile = fopen(char(t.name.modfile),'w');
                        fprintf(DynareFile, [t.script.modfile   t.script.estimation]);
                        fclose(DynareFile);
                        
                        try
                            pause(5);
                            dy.exp = ['dynare '  char(t.name.modfile) ' noclearall'];
                            eval(dy.exp)
                            %dynare(char(t.name.modfile));
                            break
                        end
                    end
                end
                
                % save results and remove MH samples
                cd(t.path.working);
                
                pause(5);
                save('workspace');
                
                pause(5);
                
                % delete output folder ===================
               
                if isequal(p.dynareVersion,'4.2.4')
                    try
                    p.path.todelete = strcat(t.path.working,'\\', model);
                    rmdir(p.path.todelete,'s')
                    catch
                    fprintf('Seems that folder storing MH samples cannot be deleted. Please delete it by hand.\n');
                    end
                else              
                    try
                    rmdir(model, 's');
                    catch
                    fprintf('Seems that folder storing MH samples cannot be deleted. Please delete it by hand.\n');
                    end
                end
               
                % ==================
                % save GDP forecasts (start from the last in-sample obs)
                if any(strcmp(scenario,'s1')); %scenario == "s1" % in scenario 1, first GDP forecast is nowcast
                    t.output.forecast.gdp = [oo_.SmoothedVariables.Mean.gdp_rgd_obs(end:end)', oo_.MeanForecast.Mean.gdp_rgd_obs(2:end)'];
                    t.output.forecast.inflation = [oo_.SmoothedVariables.Mean.gdpdef_obs(end:end)', oo_.MeanForecast.Mean.gdpdef_obs(2:end)'];
                else % in other scenarios, first GDP forecast is one step ahead forecast, while nowcast from smoothed variables
                    t.output.forecast.gdp = [oo_.SmoothedVariables.Mean.gdp_rgd_obs(end-1:end)', oo_.MeanForecast.Mean.gdp_rgd_obs(2:end-1)'];
                    t.output.forecast.inflation = [oo_.SmoothedVariables.Mean.gdpdef_obs(end-1:end)', oo_.MeanForecast.Mean.gdpdef_obs(2:end-1)'];
                end
                %=================
                
                %assert(length(t.output.forecast.gdp) == p.forecastHorizon + 1); % not convert
                
                % from quarter-on-quarter to year-on-year growth
                t.output.forecast.gdp = t.output.forecast.gdp * 4;
                t.output.forecast.inflation = t.output.forecast.inflation*4;
                
                tEnd = toc(tStart);
                % save other outputs
                t.output.model = model;
                t.output.vintage = vintage;
                t.output.scenario = scenario;
                t.output.nobs = options_.nobs;
                t.output.modeCompute = t.mode_compute;
                t.output.mhDraws = p.chainLen;
                t.output.subDraws = p.subDraws;
                t.output.executor = p.executor;
                t.output.timeElapsed = tEnd;
                t.output.timeStamp = datestr(now);
                t.output.dynareVersion = p.dynareVersion;
                t.output.matlabVersion = version;
                             
                
                % write to JSON file
                addpath(p.path.root);
                JSONOutput = mat2json(t.output);  %bookmark
                JSONFile = fopen(strcat(model,'.json'),'w'); %fopen(char(t.name.modfile),'w')
                fwrite(JSONFile, JSONOutput, 'char');
                fclose(JSONFile);
                
                %only for testing purpose ==========
                % JSONOutputtesting = mat2json(testing);  %bookmark
                % JSONFiletesting = fopen(strcat(model,'testing.json'),'w'); %fopen(char(t.name.modfile),'w')
                % fwrite(JSONFiletesting, JSONOutputtesting, 'char');
                % fclose(JSONFiletesting);
                
                %=================================
                
                display(t.output)
                

                clearvars -except model vintage scenario p
                t.path.model = strcat(p.path.models, '\\' , model);

                pause(5);
                cd(p.path.root);
            end
        end
        
    else
        fprintf('Model %s does not exist, will be skipped.\n', model);
    end
    
end