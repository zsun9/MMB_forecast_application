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
M_.fname = 'DS04';
M_.dynare_version = '4.6.1';
oo_.dynare_version = '4.6.1';
options_.dynare_version = '4.6.1';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('DS04.log');
M_.exo_names = cell(3,1);
M_.exo_names_tex = cell(3,1);
M_.exo_names_long = cell(3,1);
M_.exo_names(1) = {'epsilon_R'};
M_.exo_names_tex(1) = {'epsilon\_R'};
M_.exo_names_long(1) = {'epsilon_R'};
M_.exo_names(2) = {'epsilon_g'};
M_.exo_names_tex(2) = {'epsilon\_g'};
M_.exo_names_long(2) = {'epsilon_g'};
M_.exo_names(3) = {'epsilon_z'};
M_.exo_names_tex(3) = {'epsilon\_z'};
M_.exo_names_long(3) = {'epsilon_z'};
M_.endo_names = cell(13,1);
M_.endo_names_tex = cell(13,1);
M_.endo_names_long = cell(13,1);
M_.endo_names(1) = {'y'};
M_.endo_names_tex(1) = {'y'};
M_.endo_names_long(1) = {'y'};
M_.endo_names(2) = {'pie'};
M_.endo_names_tex(2) = {'pie'};
M_.endo_names_long(2) = {'pie'};
M_.endo_names(3) = {'R'};
M_.endo_names_tex(3) = {'R'};
M_.endo_names_long(3) = {'R'};
M_.endo_names(4) = {'g'};
M_.endo_names_tex(4) = {'g'};
M_.endo_names_long(4) = {'g'};
M_.endo_names(5) = {'z'};
M_.endo_names_tex(5) = {'z'};
M_.endo_names_long(5) = {'z'};
M_.endo_names(6) = {'interest'};
M_.endo_names_tex(6) = {'interest'};
M_.endo_names_long(6) = {'interest'};
M_.endo_names(7) = {'ffr_obs'};
M_.endo_names_tex(7) = {'ffr\_obs'};
M_.endo_names_long(7) = {'ffr_obs'};
M_.endo_names(8) = {'inflation'};
M_.endo_names_tex(8) = {'inflation'};
M_.endo_names_long(8) = {'inflation'};
M_.endo_names(9) = {'gdpdef_obs'};
M_.endo_names_tex(9) = {'gdpdef\_obs'};
M_.endo_names_long(9) = {'gdpdef_obs'};
M_.endo_names(10) = {'outputgap'};
M_.endo_names_tex(10) = {'outputgap'};
M_.endo_names_long(10) = {'outputgap'};
M_.endo_names(11) = {'gdp_rgd_obs'};
M_.endo_names_tex(11) = {'gdp\_rgd\_obs'};
M_.endo_names_long(11) = {'gdp_rgd_obs'};
M_.endo_names(12) = {'AUX_ENDO_LAG_1_1'};
M_.endo_names_tex(12) = {'AUX\_ENDO\_LAG\_1\_1'};
M_.endo_names_long(12) = {'AUX_ENDO_LAG_1_1'};
M_.endo_names(13) = {'AUX_ENDO_LAG_1_2'};
M_.endo_names_tex(13) = {'AUX\_ENDO\_LAG\_1\_2'};
M_.endo_names_long(13) = {'AUX_ENDO_LAG_1_2'};
M_.endo_partitions = struct();
M_.param_names = cell(10,1);
M_.param_names_tex = cell(10,1);
M_.param_names_long = cell(10,1);
M_.param_names(1) = {'tau'};
M_.param_names_tex(1) = {'tau'};
M_.param_names_long(1) = {'tau'};
M_.param_names(2) = {'kappa'};
M_.param_names_tex(2) = {'kappa'};
M_.param_names_long(2) = {'kappa'};
M_.param_names(3) = {'psi1'};
M_.param_names_tex(3) = {'psi1'};
M_.param_names_long(3) = {'psi1'};
M_.param_names(4) = {'psi2'};
M_.param_names_tex(4) = {'psi2'};
M_.param_names_long(4) = {'psi2'};
M_.param_names(5) = {'rhoR'};
M_.param_names_tex(5) = {'rhoR'};
M_.param_names_long(5) = {'rhoR'};
M_.param_names(6) = {'rhog'};
M_.param_names_tex(6) = {'rhog'};
M_.param_names_long(6) = {'rhog'};
M_.param_names(7) = {'rhoz'};
M_.param_names_tex(7) = {'rhoz'};
M_.param_names_long(7) = {'rhoz'};
M_.param_names(8) = {'trend'};
M_.param_names_tex(8) = {'trend'};
M_.param_names_long(8) = {'trend'};
M_.param_names(9) = {'inflationqstar'};
M_.param_names_tex(9) = {'inflationqstar'};
M_.param_names_long(9) = {'inflationqstar'};
M_.param_names(10) = {'rstar'};
M_.param_names_tex(10) = {'rstar'};
M_.param_names_long(10) = {'rstar'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 3;
M_.endo_nbr = 13;
M_.param_nbr = 10;
M_.orig_endo_nbr = 11;
M_.aux_vars(1).endo_index = 12;
M_.aux_vars(1).type = 1;
M_.aux_vars(1).orig_index = 2;
M_.aux_vars(1).orig_lead_lag = -1;
M_.aux_vars(1).orig_expr = 'pie(-1)';
M_.aux_vars(2).endo_index = 13;
M_.aux_vars(2).type = 1;
M_.aux_vars(2).orig_index = 2;
M_.aux_vars(2).orig_lead_lag = -2;
M_.aux_vars(2).orig_expr = 'AUX_ENDO_LAG_1_1(-1)';
options_.varobs = cell(3, 1);
options_.varobs(1)  = {'gdp_rgd_obs'};
options_.varobs(2)  = {'gdpdef_obs'};
options_.varobs(3)  = {'ffr_obs'};
options_.varobs_id = [ 11 9 7  ];
M_.Sigma_e = zeros(3, 3);
M_.Correlation_matrix = eye(3, 3);
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
M_.orig_eq_nbr = 11;
M_.eq_nbr = 13;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./+' M_.fname '/set_auxiliary_variables.m'], 'file') == 2;
M_.epilogue_names = {};
M_.epilogue_var_list_ = {};
M_.orig_maximum_endo_lag = 3;
M_.orig_maximum_endo_lead = 1;
M_.orig_maximum_exo_lag = 0;
M_.orig_maximum_exo_lead = 0;
M_.orig_maximum_exo_det_lag = 0;
M_.orig_maximum_exo_det_lead = 0;
M_.orig_maximum_lag = 3;
M_.orig_maximum_lead = 1;
M_.orig_maximum_lag_with_diffs_expanded = 3;
M_.lead_lag_incidence = [
 1 8 21;
 2 9 22;
 3 10 0;
 4 11 0;
 5 12 0;
 0 13 0;
 0 14 0;
 0 15 0;
 0 16 0;
 0 17 0;
 0 18 0;
 6 19 0;
 7 20 0;]';
M_.nstatic = 6;
M_.nfwrd   = 0;
M_.npred   = 5;
M_.nboth   = 2;
M_.nsfwrd   = 2;
M_.nspred   = 7;
M_.ndynamic   = 7;
M_.dynamic_tmp_nbr = [2; 0; 0; 0; ];
M_.equations_tags = {
  1 , 'name' , 'inflation' ;
  2 , 'name' , 'outputgap' ;
  3 , 'name' , 'interest' ;
  4 , 'name' , 'gdp_rgd_obs' ;
  5 , 'name' , 'gdpdef_obs' ;
  6 , 'name' , 'ffr_obs' ;
  7 , 'name' , 'y' ;
  8 , 'name' , 'pie' ;
  9 , 'name' , 'R' ;
  10 , 'name' , 'z' ;
  11 , 'name' , 'g' ;
};
M_.mapping.y.eqidx = [2 4 7 8 9 ];
M_.mapping.pie.eqidx = [1 5 7 8 9 ];
M_.mapping.R.eqidx = [6 7 9 ];
M_.mapping.g.eqidx = [7 8 11 ];
M_.mapping.z.eqidx = [4 7 10 ];
M_.mapping.interest.eqidx = [3 ];
M_.mapping.ffr_obs.eqidx = [3 6 ];
M_.mapping.inflation.eqidx = [1 ];
M_.mapping.gdpdef_obs.eqidx = [5 ];
M_.mapping.outputgap.eqidx = [2 ];
M_.mapping.gdp_rgd_obs.eqidx = [4 ];
M_.mapping.epsilon_R.eqidx = [9 ];
M_.mapping.epsilon_g.eqidx = [11 ];
M_.mapping.epsilon_z.eqidx = [10 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [1 2 3 4 5 12 13 ];
M_.exo_names_orig_ord = [1:3];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(13, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(3, 1);
M_.params = NaN(10, 1);
M_.endo_trends = struct('deflator', cell(13, 1), 'log_deflator', cell(13, 1), 'growth_factor', cell(13, 1), 'log_growth_factor', cell(13, 1));
M_.NNZDerivatives = [42; 0; -1; ];
M_.static_tmp_nbr = [1; 0; 0; 0; ];
M_.params(8) = 0.500;
trend = M_.params(8);
M_.params(9) = 1.000;
inflationqstar = M_.params(9);
M_.params(10) = 0.125;
rstar = M_.params(10);
M_.params(2) = 0.300;
kappa = M_.params(2);
M_.params(1) = 2.000;
tau = M_.params(1);
M_.params(3) = 1.500;
psi1 = M_.params(3);
M_.params(4) = 0.125;
psi2 = M_.params(4);
M_.params(5) = 0.500;
rhoR = M_.params(5);
M_.params(6) = 0.800;
rhog = M_.params(6);
M_.params(7) = 0.300;
rhoz = M_.params(7);
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (0.01)^2;
M_.Sigma_e(2, 2) = (0.01)^2;
M_.Sigma_e(3, 3) = (0.01)^2;
estim_params_.var_exo = zeros(0, 10);
estim_params_.var_endo = zeros(0, 10);
estim_params_.corrx = zeros(0, 11);
estim_params_.corrn = zeros(0, 11);
estim_params_.param_vals = zeros(0, 10);
estim_params_.param_vals = [estim_params_.param_vals; 8, NaN, (-Inf), Inf, 3, 0.5, 0.25, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 9, NaN, (-Inf), Inf, 3, 1.0, 0.50, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 10, NaN, (-Inf), Inf, 2, 0.5, 0.25, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 2, NaN, (-Inf), Inf, 2, 0.3, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 1, NaN, (-Inf), Inf, 2, 2.0, 0.50, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 3, NaN, (-Inf), Inf, 2, 1.5, 0.25, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 4, NaN, (-Inf), Inf, 2, 0.125, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 5, NaN, (-Inf), Inf, 1, 0.5, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 6, NaN, (-Inf), Inf, 1, 0.8, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 7, NaN, (-Inf), Inf, 1, 0.3, 0.10, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 1, NaN, (-Inf), Inf, 4, 0.0025, 0.0014, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, NaN, (-Inf), Inf, 4, 0.0063, 0.0032, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 3, NaN, (-Inf), Inf, 4, 0.0088, 0.0043, NaN, NaN, NaN ];
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
options_.datafile = 'data_20010512';
options_.xls_range = 'B1:J100';
options_.xls_sheet = 's1';
var_list_ = {'gdp_rgd_obs'};
oo_recursive_=dynare_estimation(var_list_);
save('DS04_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('DS04_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('DS04_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('DS04_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('DS04_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('DS04_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('DS04_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
