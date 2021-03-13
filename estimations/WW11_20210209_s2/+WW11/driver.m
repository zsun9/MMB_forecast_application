%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'WW11';
M_.dynare_version = '4.6.2';
oo_.dynare_version = '4.6.2';
options_.dynare_version = '4.6.2';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('WW11.log');
M_.exo_names = cell(5,1);
M_.exo_names_tex = cell(5,1);
M_.exo_names_long = cell(5,1);
M_.exo_names(1) = {'eR'};
M_.exo_names_tex(1) = {'eR'};
M_.exo_names_long(1) = {'eR'};
M_.exo_names(2) = {'eg'};
M_.exo_names_tex(2) = {'eg'};
M_.exo_names_long(2) = {'eg'};
M_.exo_names(3) = {'ez'};
M_.exo_names_tex(3) = {'ez'};
M_.exo_names_long(3) = {'ez'};
M_.exo_names(4) = {'exi'};
M_.exo_names_tex(4) = {'exi'};
M_.exo_names_long(4) = {'exi'};
M_.exo_names(5) = {'ephi'};
M_.exo_names_tex(5) = {'ephi'};
M_.exo_names_long(5) = {'ephi'};
M_.endo_names = cell(16,1);
M_.endo_names_tex = cell(16,1);
M_.endo_names_long = cell(16,1);
M_.endo_names(1) = {'y'};
M_.endo_names_tex(1) = {'y'};
M_.endo_names_long(1) = {'y'};
M_.endo_names(2) = {'yf'};
M_.endo_names_tex(2) = {'yf'};
M_.endo_names_long(2) = {'yf'};
M_.endo_names(3) = {'c'};
M_.endo_names_tex(3) = {'c'};
M_.endo_names_long(3) = {'c'};
M_.endo_names(4) = {'pie'};
M_.endo_names_tex(4) = {'pie'};
M_.endo_names_long(4) = {'pie'};
M_.endo_names(5) = {'R'};
M_.endo_names_tex(5) = {'R'};
M_.endo_names_long(5) = {'R'};
M_.endo_names(6) = {'g'};
M_.endo_names_tex(6) = {'g'};
M_.endo_names_long(6) = {'g'};
M_.endo_names(7) = {'z'};
M_.endo_names_tex(7) = {'z'};
M_.endo_names_long(7) = {'z'};
M_.endo_names(8) = {'Rf'};
M_.endo_names_tex(8) = {'Rf'};
M_.endo_names_long(8) = {'Rf'};
M_.endo_names(9) = {'rf'};
M_.endo_names_tex(9) = {'rf'};
M_.endo_names_long(9) = {'rf'};
M_.endo_names(10) = {'phi'};
M_.endo_names_tex(10) = {'phi'};
M_.endo_names_long(10) = {'phi'};
M_.endo_names(11) = {'xi'};
M_.endo_names_tex(11) = {'xi'};
M_.endo_names_long(11) = {'xi'};
M_.endo_names(12) = {'outputgapn'};
M_.endo_names_tex(12) = {'outputgapn'};
M_.endo_names_long(12) = {'outputgapn'};
M_.endo_names(13) = {'ffr_obs'};
M_.endo_names_tex(13) = {'ffr\_obs'};
M_.endo_names_long(13) = {'ffr_obs'};
M_.endo_names(14) = {'gdpdef_obs'};
M_.endo_names_tex(14) = {'gdpdef\_obs'};
M_.endo_names_long(14) = {'gdpdef_obs'};
M_.endo_names(15) = {'gdp_rgd_obs'};
M_.endo_names_tex(15) = {'gdp\_rgd\_obs'};
M_.endo_names_long(15) = {'gdp_rgd_obs'};
M_.endo_names(16) = {'outputgap'};
M_.endo_names_tex(16) = {'outputgap'};
M_.endo_names_long(16) = {'outputgap'};
M_.endo_partitions = struct();
M_.param_names = cell(12,1);
M_.param_names_tex = cell(12,1);
M_.param_names_long = cell(12,1);
M_.param_names(1) = {'sigma'};
M_.param_names_tex(1) = {'sigma'};
M_.param_names_long(1) = {'sigma'};
M_.param_names(2) = {'trend'};
M_.param_names_tex(2) = {'trend'};
M_.param_names_long(2) = {'trend'};
M_.param_names(3) = {'piestarobs'};
M_.param_names_tex(3) = {'piestarobs'};
M_.param_names_long(3) = {'piestarobs'};
M_.param_names(4) = {'rstarobs'};
M_.param_names_tex(4) = {'rstarobs'};
M_.param_names_long(4) = {'rstarobs'};
M_.param_names(5) = {'psi1'};
M_.param_names_tex(5) = {'psi1'};
M_.param_names_long(5) = {'psi1'};
M_.param_names(6) = {'psi2'};
M_.param_names_tex(6) = {'psi2'};
M_.param_names_long(6) = {'psi2'};
M_.param_names(7) = {'rhoR'};
M_.param_names_tex(7) = {'rhoR'};
M_.param_names_long(7) = {'rhoR'};
M_.param_names(8) = {'rhog'};
M_.param_names_tex(8) = {'rhog'};
M_.param_names_long(8) = {'rhog'};
M_.param_names(9) = {'rhoz'};
M_.param_names_tex(9) = {'rhoz'};
M_.param_names_long(9) = {'rhoz'};
M_.param_names(10) = {'rhoxi'};
M_.param_names_tex(10) = {'rhoxi'};
M_.param_names_long(10) = {'rhoxi'};
M_.param_names(11) = {'rhophi'};
M_.param_names_tex(11) = {'rhophi'};
M_.param_names_long(11) = {'rhophi'};
M_.param_names(12) = {'kappa'};
M_.param_names_tex(12) = {'kappa'};
M_.param_names_long(12) = {'kappa'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 5;
M_.endo_nbr = 16;
M_.param_nbr = 12;
M_.orig_endo_nbr = 16;
M_.aux_vars = [];
options_.varobs = cell(3, 1);
options_.varobs(1)  = {'gdp_rgd_obs'};
options_.varobs(2)  = {'gdpdef_obs'};
options_.varobs(3)  = {'ffr_obs'};
options_.varobs_id = [ 15 14 13  ];
M_.Sigma_e = zeros(5, 5);
M_.Correlation_matrix = eye(5, 5);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
options_.linear = true;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
options_.linear_decomposition = false;
M_.nonzero_hessian_eqs = [];
M_.hessian_eq_zero = isempty(M_.nonzero_hessian_eqs);
M_.orig_eq_nbr = 16;
M_.eq_nbr = 16;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./+' M_.fname '/set_auxiliary_variables.m'], 'file') == 2;
M_.epilogue_names = {};
M_.epilogue_var_list_ = {};
M_.orig_maximum_endo_lag = 1;
M_.orig_maximum_endo_lead = 1;
M_.orig_maximum_exo_lag = 0;
M_.orig_maximum_exo_lead = 0;
M_.orig_maximum_exo_det_lag = 0;
M_.orig_maximum_exo_det_lead = 0;
M_.orig_maximum_lag = 1;
M_.orig_maximum_lead = 1;
M_.orig_maximum_lag_with_diffs_expanded = 1;
M_.lead_lag_incidence = [
 1 7 0;
 0 8 23;
 0 9 0;
 0 10 24;
 2 11 0;
 3 12 25;
 4 13 26;
 0 14 0;
 0 15 0;
 5 16 0;
 6 17 27;
 0 18 0;
 0 19 0;
 0 20 0;
 0 21 0;
 0 22 28;]';
M_.nstatic = 7;
M_.nfwrd   = 3;
M_.npred   = 3;
M_.nboth   = 3;
M_.nsfwrd   = 6;
M_.nspred   = 6;
M_.ndynamic   = 9;
M_.dynamic_tmp_nbr = [2; 0; 0; 0; ];
M_.model_local_variables_dynamic_tt_idxs = {
  'beta', 1;
};
M_.equations_tags = {
  1 , 'name' , 'gdp_rgd_obs' ;
  2 , 'name' , 'gdpdef_obs' ;
  3 , 'name' , 'ffr_obs' ;
  4 , 'name' , 'outputgap' ;
  5 , 'name' , 'Rf' ;
  6 , 'name' , 'rf' ;
  7 , 'name' , 'pie' ;
  8 , 'name' , 'outputgapn' ;
  9 , 'name' , 'yf' ;
  10 , 'name' , 'R' ;
  11 , 'name' , 'c' ;
  12 , 'name' , '12' ;
  13 , 'name' , 'z' ;
  14 , 'name' , 'g' ;
  15 , 'name' , 'xi' ;
  16 , 'name' , 'phi' ;
};
M_.mapping.y.eqidx = [1 11 12 ];
M_.mapping.yf.eqidx = [5 9 12 ];
M_.mapping.c.eqidx = [11 ];
M_.mapping.pie.eqidx = [2 4 5 6 7 10 ];
M_.mapping.R.eqidx = [3 4 10 ];
M_.mapping.g.eqidx = [5 9 11 14 ];
M_.mapping.z.eqidx = [1 5 13 ];
M_.mapping.Rf.eqidx = [5 6 ];
M_.mapping.rf.eqidx = [4 6 ];
M_.mapping.phi.eqidx = [8 16 ];
M_.mapping.xi.eqidx = [5 9 15 ];
M_.mapping.outputgapn.eqidx = [7 8 ];
M_.mapping.ffr_obs.eqidx = [3 ];
M_.mapping.gdpdef_obs.eqidx = [2 ];
M_.mapping.gdp_rgd_obs.eqidx = [1 ];
M_.mapping.outputgap.eqidx = [4 8 10 12 ];
M_.mapping.eR.eqidx = [10 ];
M_.mapping.eg.eqidx = [14 ];
M_.mapping.ez.eqidx = [13 ];
M_.mapping.exi.eqidx = [15 ];
M_.mapping.ephi.eqidx = [16 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [1 5 6 7 10 11 ];
M_.exo_names_orig_ord = [1:5];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(16, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(5, 1);
M_.params = NaN(12, 1);
M_.endo_trends = struct('deflator', cell(16, 1), 'log_deflator', cell(16, 1), 'growth_factor', cell(16, 1), 'log_growth_factor', cell(16, 1));
M_.NNZDerivatives = [57; 0; -1; ];
M_.static_tmp_nbr = [1; 0; 0; 0; ];
M_.model_local_variables_static_tt_idxs = {
  'beta', 1;
};
M_.params(2) = 0.500;
trend = M_.params(2);
M_.params(3) = 1.000;
piestarobs = M_.params(3);
M_.params(4) = 0.125;
rstarobs = M_.params(4);
M_.params(12) = 0.300;
kappa = M_.params(12);
M_.params(1) = 2.000;
sigma = M_.params(1);
M_.params(5) = 1.500;
psi1 = M_.params(5);
M_.params(6) = 0.125;
psi2 = M_.params(6);
M_.params(7) = 0.500;
rhoR = M_.params(7);
M_.params(8) = 0.800;
rhog = M_.params(8);
M_.params(9) = 0.300;
rhoz = M_.params(9);
M_.params(10) = 0.500;
rhoxi = M_.params(10);
M_.params(11) = 0.500;
rhophi = M_.params(11);
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (0.01)^2;
M_.Sigma_e(2, 2) = (0.01)^2;
M_.Sigma_e(3, 3) = (0.01)^2;
M_.Sigma_e(4, 4) = (0.01)^2;
M_.Sigma_e(5, 5) = (0.01)^2;
estim_params_.var_exo = zeros(0, 10);
estim_params_.var_endo = zeros(0, 10);
estim_params_.corrx = zeros(0, 11);
estim_params_.corrn = zeros(0, 11);
estim_params_.param_vals = zeros(0, 10);
estim_params_.param_vals = [estim_params_.param_vals; 2, NaN, (-Inf), Inf, 3, 0.5, 0.25, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 3, NaN, (-Inf), Inf, 3, 1.0, 0.50, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 4, NaN, (-Inf), Inf, 2, 0.125, 0.0625, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 12, NaN, (-Inf), Inf, 2, 0.3, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 1, NaN, (-Inf), Inf, 2, 2.0, 0.50, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 5, NaN, (-Inf), Inf, 2, 1.5, 0.25, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 6, NaN, (-Inf), Inf, 2, 0.125, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 7, NaN, (-Inf), Inf, 1, 0.5, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 8, NaN, (-Inf), Inf, 1, 0.8, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 9, NaN, (-Inf), Inf, 1, 0.3, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 10, NaN, (-Inf), Inf, 1, 0.500, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 11, NaN, (-Inf), Inf, 1, 0.500, 0.20, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 1, NaN, (-Inf), Inf, 4, 0.0025, 0.0014, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, NaN, (-Inf), Inf, 4, 0.0063, 0.0032, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 3, NaN, (-Inf), Inf, 4, 0.0088, 0.0043, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 4, NaN, (-Inf), Inf, 4, 0.005, 0.004, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 5, NaN, (-Inf), Inf, 4, 0.005, 0.004, NaN, NaN, NaN ];
options_.bayesian_irf = true;
options_.forecast = 40;
options_.mh_drop = 0.3;
options_.mh_jscale = 0.3;
options_.mh_nblck = 1;
options_.mh_replic = 1000000;
options_.mode_check.status = true;
options_.mode_compute = 4;
options_.nodisplay = true;
options_.order = 1;
options_.prefilter = 0;
options_.presample = 4;
options_.smoother = true;
options_.sub_draws = 5000;
options_.datafile = 'data_20210209';
options_.xls_range = 'B1:AY101';
options_.xls_sheet = 's2';
var_list_ = {'gdp_rgd_obs';'gdpdef_obs'};
oo_recursive_=dynare_estimation(var_list_);
save('WW11_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('WW11_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('WW11_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('WW11_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('WW11_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('WW11_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('WW11_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
