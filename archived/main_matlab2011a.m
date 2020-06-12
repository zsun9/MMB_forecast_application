% housekeeping
close all; fclose all; clear; clc;

% hyper parameters for Bayesian estimation
basics.chainslength = 1000000;
basics.forecasthorizon = 6;
basics.numchains = 1;
basics.burnin = 0.3;
basics.acceptance =  0.1;
basics.presample = 4;

% estimation and forecasting specifications
basics.years = [8,8,9,9];
basics.quarters = [3,4,1,2];
basics.scenarios = [1,2,3,4];
assert(length(basics.years) == length(basics.quarters))

for i = 1:length(basics.years)
    for scenario = basics.scenarios
            
        comb = strcat('0',num2str(basics.years(i)),'q',num2str(basics.quarters(i)),'s',num2str(scenario));
        nobs = 179 + (basics.years(i)>8)*2 + (mod(basics.quarters(i),2) == 0) + (scenario>1);
        
        mkdir(comb);
        copyfile('dssw_hh.mod',comb);
        copyfile('dssw_hh_steadystate.m',comb);
        copyfile('data.xls',comb);

        cd(comb);

        dynare dssw_hh.mod noclearall

        options_.datafile = 'data';
        options_.xls_sheet = comb;
        options_.xls_range = ['A1:AB', num2str(nobs)];

        options_.mh_replic = basics.chainslength;
        options_.subdraws = round(basics.chainslength/20);
        options_.forecast = basics.forecasthorizon;
        options_.mh_nblck = basics.numchains;
        options_.mh_drop = basics.burnin;
        options_.mh_jscale = basics.acceptance;

        options_.nograph = 1;
        options_.presample = 4; % drop first few observations, to be comparable with VAR
        options_.smoother = 1; % if 1, get the posterior distribution of smoothed endogenous variables and shocks
        options_.filetered_vars = 0; % if 1, get the posterior distribution of filtered endogenous variables/one-step ahead forecasts
        options_.prefilter = 0; % if 1, demean each series by its mean
        options_.order = 1; % if 1, likelihood evaluted with a standard Kalman filter; if 2, evaluted with a particle filter

        options_.mode_compute = 6;

        try
            options_.mode_file = 'dssw_hh_mode';
            options_.mode_compute = 0;
            dynare_estimation('xgdp_q_obs');
            success = 1;
        catch
            success = 0;
        end

        if success == 0
            options_.mode_file = '';
            options_.mode_compute = 6;
            dynare_estimation('xgdp_q_obs');
        end

        assert(oo_.PointForecast.Mean.xgdp_q_obs(1) == oo_.SmoothedVariables.Mean.xgdp_q_obs(end));

        if scenario == 1
            gdpforecast = oo_.PointForecast.Mean.xgdp_q_obs(2:end);
        else
            gdpforecast = oo_.PointForecast.Mean.xgdp_q_obs(1:end);
        end

        gdpforecast = gdpforecast*4; 

        save(['DSSW_HH' '_oo.mat'], 'oo_')

        xlswrite('gdpforecast_obs.xlsx', [length(oo_.SmoothedVariables.Mean.xgdp_q_obs), gdpforecast']);

        pause(30);
        try
            rmdir('dssw_hh', 's');
        catch
            disp('Seems that model files cannot be deleted automatically.')
        end

        cd('..');

        clearvars -except i scenario basics
            
    end
end