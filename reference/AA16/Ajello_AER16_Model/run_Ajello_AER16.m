function check = run_Ajello_JMP_notax(optim_ind)

% Run file for "Financial Intermediation, Investment Dynamics, and
% Business Cycle Fluctuations" by Andrea Ajello

% Code written by Andrea Ajello, 2015

delete Ajello_AER16.m
set(0,'defaultlinelinewidth',2)

% Add Dynare path

addpath C:\Remote_Work\Research\dynare-4.4.2_win\matlab

% Then add path for folder with modified Dynare files (e.g., compute Variance
% Decomposition at Business Cycle Frequencies):

addpath('C:\Remote_Work\Ajello_Replication_Files\To_Send\Ajello_AER16_Model\misc','-begin')

save optim_ind optim_ind;
global save_results_dsge_likelihood
save_results_dsge_likelihood = 1;

if optim_ind == 1
    
    dynare Ajello_AER16 noclearall
    
else

    dynare Ajello_AER16 noclearall
    
end

check = 1;