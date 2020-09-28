clear all
%-----------------------Make your choices here------------------%
nsims  = 1; %number of samples
ndraws = 1000; %number of parameter draws;
outdir = '';
modelname = 'Ajello_JMP_notax';

%------------------------------SETUP----------------------------%
global M_ options_ oo_ 
%addpath /mq/home/dynare/dynare-4.4.2/matlab/;
%addpath \\mqlx1\mq-home\dynare-4.4.2_win\matlab;
addpath C:\Remote_Work\Research\dynare-4.4.2_win

%rng('shuffle')

load([modelname '_results.mat']);
var_list_ = char('d_GDP', 'd_Ihat', 'd_chat', 'dlnwhat', 'pi_ob_t', ...
                 'i_ob_t', 'l_ob_t', 'Spread_ob_t', 'FGS_obs', 'chi_k', 'chi_s','FGSgap_t', 'd_FGS_num');

try
    draws = load([modelname '\metropolis\' modelname '_posterior_draws1.mat']);
catch
     draws = load([modelname '/metropolis/' modelname '_posterior_draws1.mat']);
end

SD_all = NaN(size(var_list_,1), ndraws); %1 for 5%, 2 for median, 3 for 95%
AC_all = NaN(size(var_list_,1), ndraws); %1 for 5%, 2 for median, 3 for 95%
SD_stand_all = SD_all;
frac_exp_all = NaN(1,ndraws);
err_s_add    = frac_exp_all;
err_k_add    = frac_exp_all;
%------------------------------SIMULATIONS----------------------------%
tic
for d = 1:ndraws
    linee = 1; 
    % From dsge_simulated_theoretical_variance_decomposition.m
    set_parameters(draws.pdraws{d,1});
    M_.Sigma_e(10,10) = 0;
    [dr,info,M_,options_,oo_] = resol(0,M_,options_,oo_);
    
    % From stoch_simul
    options_.periods = 128; 
    options_.drop    = 50;
    y0 = oo_.dr.ys;
    

    SD = NaN(size(var_list_,1),nsims);
    SD_stand = SD;
    AC = NaN(size(var_list_,1),nsims);
    frac_exp = NaN(1,nsims);
    err_k    = frac_exp;
    err_s    = frac_exp;
    for s = 1:nsims
        [ys, oo_] = simult(y0,oo_.dr,M_,options_,oo_);
        chi_k     = exp(ys(31,options_.drop+1:options_.periods));
        chi_s     = exp(ys(28,options_.drop+1:options_.periods));
        QA        = exp(ys(86,options_.drop+1:options_.periods));
        QB        = exp(ys(27,options_.drop+1:options_.periods));
        mu = M_.params(end-3);
        sg = M_.params(end-4);
        chi_k_nl = (1/2 + 1/2*erf((log(QA) - mu)/(sqrt(2)*sg)) - (1/2 + 1/2*erf((log(QB) - mu)/(sqrt(2)*sg))));
        chi_s_nl = (1 - (1/2 + 1/2*erf((log(QA) - mu)/(sqrt(2)*sg))));
        frac_exp(s) = (sum(chi_k > 1)/(options_.periods - options_.drop)) + (sum(chi_s > 1)/(options_.periods - options_.drop)) - sum(chi_k > 1 & chi_s >1)/(options_.periods - options_.drop);
        err_k(s)    = mean(abs((chi_k - chi_k_nl)/chi_k_nl));
        err_s(s)    = mean(abs((chi_s - chi_s_nl)/chi_s_nl));
        options_.hp_filter = 0;
        %ys(74,:) = 100*exp(ys(74,:));
        [sd, ac] = disp_moments_extraction(ys,var_list_);
        SD(:,s)       = sd;
        SD_stand(:,s) = sd/sd(1);
        AC(:,s) = ac;
    end
    SD_all(:,d) = SD;
    SD_stand_all(:,d) = SD_stand;
    AC_all(:,d) = AC; 
    frac_exp_all(d) = mean(frac_exp);
    err_k_add(d)    = mean(err_k);
    err_s_add(d)    = mean(err_s);
    
    if mod(d,50) == 0
        fprintf(['We are at draw ' int2str(d) ' of ' int2str(ndraws) '\n']);
        toc 
        tic
     end
end
toc

SD_all_means = [prctile(SD_all,5,2), prctile(SD_all,50,2), prctile(SD_all,95,2)];
SD_all_stand_means = [prctile(SD_stand_all,5,2), prctile(SD_stand_all,50,2), prctile(SD_stand_all,95,2)];
AC_all_means = [prctile(AC_all,5,2), prctile(AC_all,50,2), prctile(AC_all,95,2)];

error_sw = 0;

if error_sw == 1
    % Compute average errors for chi_k and chi_s at the mode

    %%% ergodic simulation and mean approximation errors
    load Ajello_JMP_notax_results.mat
    options_.periods = 10000;
    options_.drop    =  1000;
    y0 = oo_.dr.ys;
    [ys, oo_] = simult(y0,oo_.dr,M_,options_,oo_);
    chi_k     = exp(ys(31,:));
    chi_s     = exp(ys(28,:));
    QA        = exp(ys(86,:));
    QB        = exp(ys(27,:));
    mu = M_.params(end-3);
    sg = M_.params(end-4);
    chi_k_nl = (1/2 + 1/2*erf((log(QA) - mu)/(sqrt(2)*sg)) - (1/2 + 1/2*erf((log(QB) - mu)/(sqrt(2)*sg))));
    chi_s_nl = (1 - (1/2 + 1/2*erf((log(QA) - mu)/(sqrt(2)*sg))));
    err_k    = abs((chi_k - chi_k_nl)./chi_k_nl);
    err_s    = abs((chi_s - chi_s_nl)./chi_s_nl);
    
    mean_err_k = mean(log10(err_k))
    mean_err_s = mean(log10(err_s))
    
end

%SD_all_means = [mean(SD_all(:,:,2),2), mean(SD_all(:,:,1),2), mean(SD_all(:,:,3),2)];
%AC_all_means = [mean(AC_all(:,:,2),2), mean(AC_all(:,:,1),2), mean(AC_all(:,:,3),2)];
%save(['estim_moments' strrep(datestr(now), ' ', '') '.mat'],'SD_all_means','AC_all_means', 'SD_all', 'AC_all');
%save estim_moments SD_all_means AC_all_means SD_all AC_all
%---------------------------------IMPORT DATA----------------------%
data = load('MYDATA');
options_.drop = -1; % Need this to prevent disp_moment_extraction from trimming (burning?)
%store where Spread and FGS are in the short variable list so that we can use them

data = [data.d_GDP, data.d_Ihat, data.d_chat, data.dlnwhat, data.pi_ob_t, ...
                 data.i_ob_t, data.l_ob_t, data.Spread_ob_t, data.FGS_obs, data.d_FGS_num];
             
%FGSloc = find((ismember(cellstr(var_list_),'FGS_obs')));
%SpreadLoc = find((ismember(cellstr(var_list_),'Spread_ob_t')));
%Scale
%data.data(SpreadLoc,:) = 400*exp(data.data(SpreadLoc,:));
%data.data(FGSloc, :) = 100*exp(data.data(FGSloc,:)); 
[dataSD, dataAC] = disp_moments_extraction(data,var_list_);

%---------------------------------PRINT TO TEX----------------------%
varTex = {'$(\\Delta \\log GDP_{t})$', ...  
	  '$(\\Delta \\log I_{t})$', ...    
	  '$(\\Delta \\log C_{t})$', ...    
	  '$(\\Delta \\log w_{t})$', ...    
	  '$(\\pi _{t})$', ...             
	  '$(R_{t}^{B})$', ...            
	  '$(\\log L_{t})$', ...           
	  '$(Sp_{t})$', ...               
	  '$(FGS_{t})$'...
      '$(\Delta \log FGS_{t})^1$'};

SDfile =  fopen([outdir 'modelfitSD.tex' ], 'w');
ACfile =  fopen([outdir 'modelfitAC.tex' ], 'w');

for r = 1:10
    if r == 1
        fprintf(SDfile, [ 'Stdev' varTex{r} ]);
        fprintf(SDfile, ['& %4.2f & %4.2f & ${[}$' ...
                             '& %4.2f & ${-}$ & %4.2f ' ...
                             '& ${]}$ '] ,[dataSD(r) SD_all_means(r,:)]);
        fprintf(SDfile, '\\\\  \n ', []);   
    else
        fprintf(SDfile, [ 'Stdev' varTex{r} ]);
        fprintf(SDfile, ['& %4.2f & %4.2f & ${[}$' ...
                             '& %4.2f & ${-}$ & %4.2f ' ...
                             '& ${]}$ '] ,[dataSD(r)/dataSD(1) SD_all_stand_means(r,:)]);
        fprintf(SDfile, '\\\\  \n ', []);
    end
        fprintf(ACfile, [ 'AC(1)' varTex{r}]);
        fprintf(ACfile, ['& %4.2f & %4.2f & ${[}$' ...
                             '& %4.2f & ${-}$ & %4.2f ' ...
                             '& ${]}$ '] ,[dataAC(r) AC_all_means(r,:)]);
        fprintf(ACfile, '\\\\  \n ', []);   
end
        
fclose(SDfile);
fclose(ACfile);

