% This file create the variance decomposition table. 
% You just have to make sure that the median, 
% upper bound (ub), and lower bound (lb) matrices are
% set properly, and that the variables in the rows of
% these matrices correspond to the variable names in 
% varnames. 
%--------------------- Setup --------------------%

% This program loads the BC Freq Variance Decomposition Draws and displays
% matrices with their quantiles

% Load final draws for baseline model
%load ('U:\m1axa04\Research\Ajello 2011\Ajello_Code_Dynare\estim2\Ajello_JMP\metropolis\Ajello_JMP_PosteriorVarianceDecomposition1.mat')
%clear all
%load Ajello_JMP_ZLB_results

shocks = {'eps_z', 'eps_g', 'eps_i', 'eps_tau', 'eps_tau_trans', 'eps_beta', 'eps_p', 'eps_w', 'eps_meas', 'eps_meas_sp'};

vars = {'d_GDP', 'd_Ihat', 'd_chat', 'dlnwhat', 'pi_ob_t', 'i_ob_t', 'l_ob_t', 'Spread_ob_t', 'FGS_obs'};

for v = 1:length(vars)
    for s = 1:length(shocks)
        SUP = oo_.PosteriorTheoreticalMoments.dsge.VarianceDecomposition.HPDsup.(vars{v}).(shocks{s});
        MED = oo_.PosteriorTheoreticalMoments.dsge.VarianceDecomposition.Median.(vars{v}).(shocks{s});
        INF = oo_.PosteriorTheoreticalMoments.dsge.VarianceDecomposition.HPDinf.(vars{v}).(shocks{s});                
        
        lb(v,s)  = round(1000*INF)/10;
        med(v,s) = round(1000*MED)/10;
        ub(v,s)  = round(1000*SUP)/10; 
    end
end

med = [         16.70           2.57          12.73          22.37           1.63       13.96          18.99          11.05           0.00           0.00         
         10.93           0.02          17.12          29.94           2.39        0.89          26.02          12.68           0.00           0.00         
         15.66           0.74           1.22           2.28           0.08       75.53           1.81           2.68           0.00           0.00         
          9.45           0.00           0.13           0.25           0.01        0.08          10.44          79.64           0.00           0.00         
          3.12           0.05           5.55          44.40           0.39        2.68          30.71          13.09           0.00           0.00         
          0.62           0.08          39.76          43.12           0.66        2.93           8.38           4.46           0.00           0.00         
          3.63           0.59          11.24          20.85           1.29        6.34          33.12          22.93           0.00           0.00         
          1.98           0.04           2.72          23.26          56.35        0.25          12.66           2.50           0.00           0.23         
          0.72           0.20           1.40          32.61          19.30        0.10           7.30           1.36          37.02           0.00];

% Define Tex Fields

%filename = '/msu/res1/m1axa04/Research/Ajello 2011/Runs_Submission_3/lowindexprior_output/vardecomp_baseline.tex';
filename = 'vardecomp_baseline.tex';

varnames = {'$\\Delta\\log GDP_{t}$', '$\\Delta\\log I_{t} $', ...
            '$\\Delta\\log C_{t} $', '$\\Delta\\log w_{t}$', ...
            '$\\pi_{t}$', '$R_{t}^{B}$', '$\\log L_{t}$',  ...
            '$Spread_{t}$', '$FGS_{t}$'}; 

%------------------- End Setup -------------------%

%Interweave the upper and lower bound matrices
lbub = NaN(size(lb,1), size(lb,2)*2);
lbub(:,1:2:end) =lb;
lbub(:,2:2:end) =ub;

%Print things out
f = fopen(filename, 'w');
fprintf(f, ['&\\textbf{TFP} & \\textbf{Gov''t} & \\textbf{MP} & \\textbf{Fin.(pers.)} & \\textbf{Fin.(trans.)} & \\textbf{Preference} & ' ...
            '\\textbf{Price Mark up} & \\textbf{Wage Mark up} & \\textbf{ME FGS} & \\textbf{ME Spread}  \\\\ \\hline \\hline\n']);
for v = 1:length(varnames)
    fprintf(f,varnames{v});
    fprintf(f,['& \\textbf{%3.1f}'],med(v,:));
    fprintf(f,'\\\\ \n ');    
    fprintf(f,['& [%3.1f - %3.1f] '],lbub(v,:));    
    fprintf(f,'\\\\ \n ');    
end
fclose(f);

clean = strrep(fileread(filename), 'NaN', '0');
clean = strrep(clean, '\', '\\'); 
f = fopen(filename, 'w');
fprintf(f, clean);
fclose(f);
