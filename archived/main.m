% The file is used for estimating models and generating forecasts
% models: NK_DS04, NK_WW11, DSGE_TEST, US_FRBEDO08, US_DNGS14, QPM_US, DSSW_FF, DSSW_HH, US_SW07, GLP
% Last updated: Zexi Sun, 2019-11-01

%% settings

% housekeeping
close all; fclose all; clear; clc;

% hyper parameters for Bayesian estimation
basics.chainslength = 1000000;
basics.BVARchainslength = 10000;
basics.forecasthorizon = 100;
basics.numchains = 1;
basics.burnin = 0.3;
basics.scalingfactor =  0.3;
basics.presample = 4;

% estimation and forecasting specifications
basics.vintages = ["08q3"]; % 
basics.scenarios = ["s3"]; % 
basics.models = ["US_DNGS14"];

% specify all possible mode compute options
basics.mode_compute_keys = [4, 4, 7, 7, 1, 1, 3, 3, 5, 5, 6];
basics.mode_compute_values = ["Sims csminwel", "Sims csminwel", ...
                       "fminsearch", "fminsearch", ...
                       "fmincon", "fmincon", ...
                       "fminunc", "fminunc", ...
                       "Marco Ratto newrat", "Marco Ratto newrat", ...
                       "Monte-Carlo based simulation"]; % 
basics.mode_compute_dict = containers.Map(basics.mode_compute_keys, basics.mode_compute_values);

%% locate folders and create arrays to store the outcome

% locate main folders (stored as char type)
basics.folder_root = pwd;
basics.folder_models = [basics.folder_root '/models'];

% add path for the BVAR GLP algorithm
addpath([basics.folder_root '/GLP_algorithm']);

% locate subfolders for each mod file (stored as struct type)
basics.subfolders_models = dir(basics.folder_models);
basics.subfolders_models = basics.subfolders_models(~startsWith({basics.subfolders_models.name}, '.'));

% save results to these arrays
basics.table_model = []; basics.table_vintage = []; basics.table_scenario = []; basics.table_nobs = [];
basics.table_gdp1 = []; basics.table_gdp2 = []; basics.table_gdp3 = []; basics.table_gdp4 = []; basics.table_gdp5 = [];
basics.table_variable_names = {'Model','Vintage','Scenario','Nobs','Nowcast', 'Step1', 'Step2', 'Step3', 'Step4'};

%% DSGE estimations

for i = 1:length(basics.subfolders_models) % loop through all the model folders, there is one model contained in each sub-folder
        
    if ismember(string(basics.subfolders_models(i).name), basics.models) & string(basics.subfolders_models(i).name) ~= "GLP" % if this is the model we want to estimate, then continue, else go to the next folder
    
        subfolder = [basics.subfolders_models(i).folder, '/', basics.subfolders_models(i).name];

        subfolder_files = dir(subfolder); % retreive all the files in a sub-folder
        subfolder_files = subfolder_files(endsWith({subfolder_files.name}, '.m') | endsWith({subfolder_files.name}, '.mod') | endsWith({subfolder_files.name}, '.xls') | endsWith({subfolder_files.name}, '.mat') | endsWith({subfolder_files.name}, '.xlsx'));

        for vintage = basics.vintages % loop over vintages
            for scenario = basics.scenarios % loop over scenarios
                
                subsubfolder = [subfolder, '/', basics.subfolders_models(i).name, '_', char(strcat(vintage, scenario))]; % create a sub-sub-folder for each specific model, vintage and scenario
                mkdir(subsubfolder); 

                mode_file = '';
                
                % determine the data range
                v = char(vintage);
                s = char(scenario);
                nobs = 179 + (str2double(v(2))>8)*2 + (mod(str2double(v(4)), 2) == 0) + (str2double(s(2))>1);

                % copy the files from sub-folder to sub-sub-folder (mod file, steady state file, mode file, etc.)
                for j = 1:length(subfolder_files)
                    copyfile([subfolder_files(j).folder, '/', subfolder_files(j).name], subsubfolder)
                end

                cd(subsubfolder) % go to the sub-sub-folder and ready to run Dynare
                
                subsubfolder_files = dir(subsubfolder); % retreive all the files in a sub-sub-folder
                for k = 1:length(subsubfolder_files)
                    if strcmp(subsubfolder_files(k).name, [basics.subfolders_models(i).name '_mode.mat']) % if there is a mode file then don't need Dynare to compute the mode
                        mode_file = subsubfolder_files(k).name;
                    end
                end
                    
                % run Dynare to build up the environment
                dynare(basics.subfolders_models(i).name)

                % set up the dataset
                options_.datafile = '../../../data';
                options_.xls_sheet = strcat(vintage, scenario);
                options_.xls_range = ['A1:AB', num2str(nobs)];

                % set up adjustable hyper-parameters
                options_.mh_replic = basics.chainslength;
                options_.subdraws = round(basics.chainslength/4);
                options_.forecast = basics.forecasthorizon;
                options_.mh_nblck = basics.numchains;
                options_.mh_drop = basics.burnin;
                options_.mh_jscale = basics.scalingfactor;

                % set up constant hyper-parameters
                options_.nograph = 1;
                options_.presample = 4; % drop first few observations, to be comparable with VAR
                options_.smoother = 1; % if 1, get the posterior distribution of smoothed endogenous variables and shocks
                options_.filetered_vars = 0; % if 1, get the posterior distribution of filtered endogenous variables/one-step ahead forecasts
                options_.prefilter = 0; % if 1, demean each series by its mean
                options_.order = 1; % if 1, likelihood evaluted with a standard Kalman filter; if 2, evaluted with a particle filter

                % set up mode computation options
                % options_.optim_opt = '''MaxIter'',2000';
                options_.silent_optimizer = 0;
                options_.mode_file = mode_file;
                
                % determine forecast var
                if string(basics.subfolders_models(i).name) == "QPM_US"
                    forecast_var = 'LGDP_US'; % ['LGDP_US'; 'BLT_US ']
                    options_.first_obs = 121;
                else
                    forecast_var = 'xgdp_q_obs';
                end

                % run estimation
                if ~isempty(options_.mode_file) % there the mode file exists then directly estimate the model

                    options_.mode_compute = 0;
                    dynare_estimation(forecast_var);

                else % else loop through several mode compute algorithms to compute the mode and estimate the model

                    success = 0;

                    for mode = basics.mode_compute_keys

                        if success == 0 % if the last time's mode compute is failed, then switch to the new algorithm
                            options_.mode_compute = mode;
                            disp(strcat("Now computing the mode using ", basics.mode_compute_dict(mode)))
                        else % else exit the loop (sucess)
                            break
                        end

                        try % try to compute the model
                            dynare_estimation(forecast_var);
                            success = 1;
                        catch
                            success = 0;
                        end

                    end

                end

                % remove some auxillary files
                pause(30); % pause a few second as the files are being uploaded to Dropbox
                try
                    rmdir(basics.subfolders_models(i).name, 's');
                catch
                    disp('Seems that model files cannot be deleted automatically.')
                end
                
                % save the GDP forecast
                if string(basics.subfolders_models(i).name) == "QPM_US"
                    if ismember(scenario, ["s1"]) % in scenario 1, first GDP forecast is nowcast
                        gdpforecast = diff([oo_.SmoothedVariables.Mean.LGDP_US(end)', oo_.PointForecast.Mean.LGDP_US(1:end)']);
                    else % in scenario 2, 3 and 4, first GDP forecast is one step ahead forecast, while nowcast from smoothed variables
                        gdpforecast = diff([oo_.SmoothedVariables.Mean.LGDP_US(end-1:end)', oo_.PointForecast.Mean.LGDP_US(1:end-1)']);
                    end
                else
                    if ismember(scenario, ["s1"]) % in scenario 1, first GDP forecast is nowcast
                        gdpforecast = oo_.PointForecast.Mean.xgdp_q_obs;
                    else % in scenario 2, 3 and 4, first GDP forecast is one step ahead forecast, while nowcast from smoothed variables
                        gdpforecast = [oo_.SmoothedVariables.Mean.xgdp_q_obs(end), oo_.PointForecast.Mean.xgdp_q_obs(1:end-1)'];
                    end
                end

                % from quarter-on-quarter to year-on-year growth
                gdpforecast = gdpforecast*4; 
                
                % save all the results and the dataset
                save([basics.subfolders_models(i).name '_oo.mat'], 'oo_')
                save dataset dataset_
                
                obs_model = string(basics.subfolders_models(i).name);
                obs_vintage = vintage;
                obs_scenario = scenario;
                obs_nobs = options_.nobs;
                obs_gdp1 = gdpforecast(1);
                obs_gdp2 = gdpforecast(2);
                obs_gdp3 = gdpforecast(3);
                obs_gdp4 = gdpforecast(4);
                obs_gdp5 = gdpforecast(5);
                
                obs_forecast = table(obs_model, obs_vintage, obs_scenario, obs_nobs, obs_gdp1, obs_gdp2, obs_gdp3, obs_gdp4, obs_gdp5, ...
                 'VariableNames',basics.table_variable_names);
                writetable(obs_forecast, 'gdpforecast_obs.xlsx');

                % save results to tables
                basics.table_model = [basics.table_model; obs_model];
                basics.table_vintage = [basics.table_vintage; obs_vintage];
                basics.table_scenario = [basics.table_scenario; obs_scenario];
                basics.table_nobs = [basics.table_nobs; obs_nobs];
                basics.table_gdp1 = [basics.table_gdp1; obs_gdp1];
                basics.table_gdp2 = [basics.table_gdp2; obs_gdp2];
                basics.table_gdp3 = [basics.table_gdp3; obs_gdp3];
                basics.table_gdp4 = [basics.table_gdp4; obs_gdp4];
                basics.table_gdp5 = [basics.table_gdp5; obs_gdp5];
                
                clearvars -except i vintage scenario subfolder subfolder_files basics 

            end
        end
    
    end
    
end

%% BVAR-GLP estimations

if ismember("GLP", basics.models)
    
    warning('The BVAR-GLP algorithm considers the first seven observables, and return the forecast of the first observable.')
    warning('Please ensure that the first observable is the real GDP growth.')
    
    subfolder = [basics.folder_models, '/GLP'];
    cd(subfolder)
    
    for vintage = basics.vintages
        for scenario = basics.scenarios
            
            disp(['Estimating the BVAR model and generating forecasts for ', char(strcat(vintage, scenario))])
            data = xlsread(['../../data.xlsx'],char(strcat(vintage, scenario))); % divide all series by 100 to be consistent with the original algorithm
            data = data(:, 1:3)/100*4; % data(:, 29:31);
            
            if ismember(scenario, ["s1"]) % in Scenario 1 directly use the algorithm in GLP
                
                res = bvarGLP(data,basics.presample,'mcmc',1,'MCMCconst',1,'Ndraws',basics.BVARchainslength,'hz',basics.forecasthorizon,'MCMCfcast',1,'pos','[1,2]');
                
            else % in other scenarios, use the algorithm from Matyas Farkas
                
                res = bvarGLP(data(1:end-1,:),basics.presample,'mcmc',1,'MCMCconst',1,'Ndraws',basics.BVARchainslength,'hz',basics.forecasthorizon,'MCMCfcast',1,'pos','[1,2]');
                
                for i = 1:basics.BVARchainslength/2 % loop through draws 

                    if i == 100*floor(.01*i)
                        disp(['Now running the conditioning on ',num2str(i),'th mcmc iteration (out of ',num2str(basics.BVARchainslength/2),')'])
                    end

                    temp=squeeze(res.mcmc.beta(:,:,i));
                    Gamma=[temp(2:end,:);temp(1,:)];
                    Su=squeeze(res.mcmc.sigma(:,:,i));
                    datakf = [data; NaN(basics.forecasthorizon-1,size(data,2))];
                    [~,datacf(:,:,i)] = conforekf_glp(datakf,Gamma,Su,basics.forecasthorizon-1,size(datakf,1)-1,1);  % conditinoal forecasts
                    res.mcmc.Dforecast(:,:,i)= datacf(end-basics.forecasthorizon+1:end,:,i);
                    
                end
                
            end
            
            % produce the forecasts
            gdpforecast = mean(res.mcmc.Dforecast(:,1,:),3);

            % log levels to log differences
            if ismember(scenario, ["s1"])
               gdpforecast = gdpforecast'*100; % gdpforecast = diff([data(end,1) gdpforecast'])*100; 
            else
               gdpforecast = gdpforecast'*100; % gdpforecast = diff([data(end-1,1) gdpforecast'])*100; 
            end
            
            % save the results
            save(['GLP_', char(strcat(vintage, scenario)), '_res.mat'], 'res')
                
            obs_model = string('GLP');
            obs_vintage = vintage;
            obs_scenario = scenario;
            obs_nobs = size(data,1);
            obs_gdp1 = gdpforecast(1);
            obs_gdp2 = gdpforecast(2);
            obs_gdp3 = gdpforecast(3);
            obs_gdp4 = gdpforecast(4);
            obs_gdp5 = gdpforecast(5);
            
            obs_forecast = table(obs_model, obs_vintage, obs_scenario, obs_nobs, obs_gdp1, obs_gdp2, obs_gdp3, obs_gdp4, obs_gdp5, ...
             'VariableNames',basics.table_variable_names);
            writetable(obs_forecast, ['GLP_gdpforecast_', char(strcat(vintage, scenario)), '.xlsx']);

            % save results to tables
            basics.table_model = [basics.table_model; obs_model];
            basics.table_vintage = [basics.table_vintage; obs_vintage];
            basics.table_scenario = [basics.table_scenario; obs_scenario];
            basics.table_nobs = [basics.table_nobs; obs_nobs];
            basics.table_gdp1 = [basics.table_gdp1; obs_gdp1];
            basics.table_gdp2 = [basics.table_gdp2; obs_gdp2];
            basics.table_gdp3 = [basics.table_gdp3; obs_gdp3];
            basics.table_gdp4 = [basics.table_gdp4; obs_gdp4];
            basics.table_gdp5 = [basics.table_gdp5; obs_gdp5];

        end
    end
    
    end

%%

% create the table for all the forecasts
table_forecast = table(basics.table_model, basics.table_vintage, basics.table_scenario, basics.table_nobs, basics.table_gdp1, basics.table_gdp2, basics.table_gdp3, basics.table_gdp4, basics.table_gdp5, ...
                 'VariableNames',basics.table_variable_names);

% move back to the root folder and save results
cd(basics.folder_root);
writetable(table_forecast, 'gdpforecast_table_DSGETEST.xlsx');