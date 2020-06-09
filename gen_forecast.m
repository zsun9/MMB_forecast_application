% The file is used for estimating models and generating forecasts
% Two structs: p - high-level parameters, t - temporary parameters in a loop
% Last updated: Zexi Sun, 2020-06-02

%% settings

% navigate to the root folder (if exists)
try
    cd(p.path.root)
end

% housekeeping
close all; fclose all; clear; clc;

% user-specified parameters
% Please use double quotes here!
p.vintages = ["2020-05-12"]; %
p.scenarios = ["s1"];
p.models = ["WW11"]; % "DS04", "WW11", "NKBGG", "DNGS15", "SW07", "QPM08", "KR15_FF"
p.executor = "Zexi Sun";

p.ExcelColumnUntil = "X";

% hyper-parameters
p.chainLen = 1000000;
p.subDraws = 5000;
p.forecastHorizon = 40;
p.chainNum = 1;
p.burnin = 0.3;
p.scalingParam =  0.3;
p.presample = 4;
p.nobs = 100;
p.mode_compute_order = [4, 4, 7, 7, 1, 1, 3, 3, 5, 5, 6];

% locate main folders (stored as char type)
p.path.root = convertCharsToStrings(pwd);
p.path.models = p.path.root + "\\models";
p.path.estimations = p.path.root + "\\estimations";
p.path.vintage_data = p.path.root + "\\data\\vintage_data";
assert(isfolder(p.path.root) && isfolder(p.path.models) && isfolder(p.path.estimations) && isfolder(p.path.vintage_data));

% save results to these arrays
% p.table.model = []; p.table.vintageDate = []; p.table.scenario = []; p.table.nobs = []; p.table.ndraws = []; p.table.forecasts = [];
% p.table.variable_names = {'model','vintageDate','scenario','nobs','ndraws', 'forecasts'};

%% DSGE estimation

p.dynareVersion = convertCharsToStrings(dynare_version);
if p.dynareVersion ~= "4.5.7"
    warning(sprintf("You are about to estimate models using Dynare %s.", p.dynareVersion));
    warning("Please make sure this is the version you need!");
    pause(5);
end

clear t;
for model = p.models
    
    t.path.model = p.path.models + "\\" + model;
    if isfolder(t.path.model)
        
        for vintage = p.vintages
            for scenario = p.scenarios
                
                clc;
                
                t.name.modfile = model + ".mod";
                
                tStart = tic;
                
                % create folder and copy model files
                cd(p.path.root);
                t.name.workingpath = model + "_" + strrep(vintage, "-", "") + "_" + scenario;
                t.path.working = p.path.estimations + "\\" + t.name.workingpath;
                
                if isfolder(t.path.working)
                    warning('Folder %s already exists!', t.name.workingpath)
                    warning('Enter Y to delete existing files and continue.');
                    warning('Enter C to keep existing files and continue.');
                    warning('Enter N to keep existing files and skip this estimation.');
                    t.choice = "";
                    while ~ismember(lower(t.choice), ["y", "c", "n"])
                        beep;
                        t.choice = input('', 's');
                    end
                    t = lower(t);
                    
                    switch t.choice
                        case "y"
                            rmdir(t.path.working, 's');
                            copyfile(t.path.model, t.path.working);
                        case "c"
                            copyfile(t.path.model, t.path.working);
                        case "n"
                            continue;
                    end
                    
                else
                    warning('Folder %s does not exist, will be created.', t.name.workingpath);
                    copyfile(t.path.model, t.path.working);
                end
                
                % retreive varobs and data by calling Python scripts
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

                % directly copy data to the folder
                cd(p.path.root);
                t.name.datafile = "data_" + strrep(vintage, "-", "") + ".xlsx";
                t.path.data = p.path.vintage_data + "\\" + t.name.datafile;
                if isfile(t.path.data)
                    copyfile(t.path.data, t.path.working);
                else
                    fprinf('Data file %s not found, and the estimation will be skipped.\n', t.name.datafile);
                end
                
                % build up the estimation command
                t.dataFile = "data_" + strrep(vintage, "-", "");
                t.xlsRange = "B1:" + p.ExcelColumnUntil + string(p.nobs + (scenario ~= "s1"));
                if p.dynareVersion == "4.2.4"
                    p.optionString.subDraws = "";
                else
                    p.optionString.subDraws = sprintf("sub_draws=%s, ", string(p.subDraws));
                end
                t.script.estimation = "\nestimation(nodisplay, smoother, order=1, prefilter=0, mode_check, bayesian_irf, " + ...
                    sprintf("datafile=%s, ", t.dataFile) + ...
                    sprintf("xls_sheet=%s, ", scenario) + ...
                    sprintf("xls_range=%s, ", t.xlsRange) + ...
                    sprintf("presample=%s, ", string(p.presample)) + ...
                    sprintf("mh_replic=%s, ", string(p.chainLen)) + ...
                    sprintf("mh_nblocks=%s, ", string(p.chainNum)) + ...
                    sprintf("mh_jscale=%s, ", string(p.scalingParam)) + ...
                    sprintf("mh_drop=%s, ", string(p.burnin)) + ...
                    p.optionString.subDraws + ...
                    sprintf("forecast=%s, ", string(p.forecastHorizon)) + ...
                    sprintf("mode_compute=%s", string(p.mode_compute_order(1))) + ...
                    ") gdp_rgd_obs;";
                
                if model == "QPM08"
                    t.script.estimation = strrep(t.script.estimation, ") gdp_rgd_obs;", ") gdpl_rgd_obs;");
                end
                
                cd(t.path.working);
                
                % save means of observables
                t.data.table = readtable(t.dataFile + ".xlsx", 'Sheet', scenario);
                t.data.name = t.data.table.Properties.VariableNames;
                t.data.mean = nanmean(t.data.table{:,2:end},1);
                t.script.obsMean = "";
                for i = 1:length(t.data.mean)
                    t.script.obsMean = t.script.obsMean + sprintf("%s_mean = %.10f;\n", t.data.name{i+1}, t.data.mean(i));
                end
                obsMeanFile = fopen('obsMean.m', 'w');
                fprintf(obsMeanFile, t.script.obsMean);
                fclose(obsMeanFile);
                
                % loop through different mode compute routines
                t.name.modefile = model + "_mode.mat";
                if exist(t.name.modefile, 'file')
                    fprintf('Mode file exists, and the ML estimation will be skipped.\n');
                    % if mode file exists, then skip ML estimation
                    t.mode_compute = 0;
                    t.script.estimation = strrep(t.script.estimation, ...
                        sprintf("mode_compute=%s", string(p.mode_compute_order(1))), ...
                        sprintf("mode_compute=%s, mode_file=%s", string(t.mode_compute), strrep(t.name.modefile, ".mat", "")));
                    
                    DynareFile = fopen(t.name.modfile,'w');
                    fprintf(DynareFile, t.script.modfile + t.script.estimation);
                    fclose(DynareFile);
                    
                    % pause(5);
                    % dynare(convertStringsToChars(t.name.modfile));
                else
                    fprintf('Mode file not exists, and mode computation will be started.\n');
                    % else loop through all mode compute routines
                    for i = 1:length(p.mode_compute_order)
                        t.mode_compute = p.mode_compute_order(i);
                        if i>1
                            t.script.estimation = strrep(t.script.estimation, ...
                                sprintf("mode_compute=%s", string(p.mode_compute_order(i-1))), ...
                                sprintf("mode_compute=%s", string(p.mode_compute_order(i))));
                        end
                        
                        DynareFile = fopen(t.name.modfile,'w');
                        fprintf(DynareFile, t.script.modfile + t.script.estimation);
                        fclose(DynareFile);
                        
                        try
                            pause(5);
                            dynare(convertStringsToChars(t.name.modfile));
                            break
                        end
                    end
                end
                
                % save results and remove MH samples
                cd(t.path.working);
                
                pause(5);
                save('workspace');
                
                pause(5);
                try
                    rmdir(model, 's');
                catch
                    fprintf('Seems that folder storing MH samples cannot be deleted. Please delete it by hand.\n');
                end
                
                % save GDP forecasts (start from the last in-sample obs)
                if model == "QPM08"
                    if scenario == "s1" % in scenario 1, first GDP forecast is nowcast
                        t.output.forecast.gdp = diff([oo_.SmoothedVariables.Mean.gdpl_rgd_obs(end-1:end)', oo_.MeanForecast.Mean.gdpl_rgd_obs(1:end)']);
                    else % in other scenarios, first GDP forecast is one step ahead forecast, while nowcast from smoothed variables
                        t.output.forecast.gdp = diff([oo_.SmoothedVariables.Mean.gdpl_rgd_obs(end-2:end)', oo_.MeanForecast.Mean.gdpl_rgd_obs(1:end-1)']);
                    end
                else
                    if scenario == "s1" % in scenario 1, first GDP forecast is nowcast
                        t.output.forecast.gdp = [oo_.SmoothedVariables.Mean.gdp_rgd_obs(end:end)', oo_.MeanForecast.Mean.gdp_rgd_obs(1:end)'];
                    else % in other scenarios, first GDP forecast is one step ahead forecast, while nowcast from smoothed variables
                        t.output.forecast.gdp = [oo_.SmoothedVariables.Mean.gdp_rgd_obs(end-1:end)', oo_.MeanForecast.Mean.gdp_rgd_obs(1:end-1)'];
                    end
                end
                
                assert(length(t.output.forecast.gdp) == p.forecastHorizon + 1);
                
                % from quarter-on-quarter to year-on-year growth
                t.output.forecast.gdp = t.output.forecast.gdp * 4;
                
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
                t.output.timeStamp = datestr(datetime('now'));
                t.output.dynareVersion = p.dynareVersion;
                t.output.matlabVersion = convertCharsToStrings(version);
                
                % write to JSON file
                JSONOutput = jsonencode(t.output);
                JSONFile = fopen(model + ".json",'w');
                fwrite(JSONFile, JSONOutput, 'char');
                fclose(JSONFile);
                
                clearvars -except model vintage scenario p
                t.path.model = p.path.models + "\\" + model;
                
                pause(5);
                cd(p.path.root);
            end
        end
        
    else
        fprintf('Model %s does not exist, will be skipped.\n', model);
    end
    
end