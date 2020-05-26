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
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'DS04';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('DS04.log');
M_.exo_names = 'epsilon_R';
M_.exo_names_tex = 'epsilon\_R';
M_.exo_names_long = 'epsilon_R';
M_.exo_names = char(M_.exo_names, 'epsilon_g');
M_.exo_names_tex = char(M_.exo_names_tex, 'epsilon\_g');
M_.exo_names_long = char(M_.exo_names_long, 'epsilon_g');
M_.exo_names = char(M_.exo_names, 'epsilon_z');
M_.exo_names_tex = char(M_.exo_names_tex, 'epsilon\_z');
M_.exo_names_long = char(M_.exo_names_long, 'epsilon_z');
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names_long = 'y';
M_.endo_names = char(M_.endo_names, 'pie');
M_.endo_names_tex = char(M_.endo_names_tex, 'pie');
M_.endo_names_long = char(M_.endo_names_long, 'pie');
M_.endo_names = char(M_.endo_names, 'R');
M_.endo_names_tex = char(M_.endo_names_tex, 'R');
M_.endo_names_long = char(M_.endo_names_long, 'R');
M_.endo_names = char(M_.endo_names, 'g');
M_.endo_names_tex = char(M_.endo_names_tex, 'g');
M_.endo_names_long = char(M_.endo_names_long, 'g');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.endo_names_long = char(M_.endo_names_long, 'z');
M_.endo_names = char(M_.endo_names, 'interest');
M_.endo_names_tex = char(M_.endo_names_tex, 'interest');
M_.endo_names_long = char(M_.endo_names_long, 'interest');
M_.endo_names = char(M_.endo_names, 'ffr_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'ffr\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'ffr_obs');
M_.endo_names = char(M_.endo_names, 'inflation');
M_.endo_names_tex = char(M_.endo_names_tex, 'inflation');
M_.endo_names_long = char(M_.endo_names_long, 'inflation');
M_.endo_names = char(M_.endo_names, 'gdpdef_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'gdpdef\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'gdpdef_obs');
M_.endo_names = char(M_.endo_names, 'outputgap');
M_.endo_names_tex = char(M_.endo_names_tex, 'outputgap');
M_.endo_names_long = char(M_.endo_names_long, 'outputgap');
M_.endo_names = char(M_.endo_names, 'gdp_rgd_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'gdp\_rgd\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'gdp_rgd_obs');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_1_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_1\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_1_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_1_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_1\_2');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_1_2');
M_.endo_partitions = struct();
M_.param_names = 'tau';
M_.param_names_tex = 'tau';
M_.param_names_long = 'tau';
M_.param_names = char(M_.param_names, 'kappa');
M_.param_names_tex = char(M_.param_names_tex, 'kappa');
M_.param_names_long = char(M_.param_names_long, 'kappa');
M_.param_names = char(M_.param_names, 'psi1');
M_.param_names_tex = char(M_.param_names_tex, 'psi1');
M_.param_names_long = char(M_.param_names_long, 'psi1');
M_.param_names = char(M_.param_names, 'psi2');
M_.param_names_tex = char(M_.param_names_tex, 'psi2');
M_.param_names_long = char(M_.param_names_long, 'psi2');
M_.param_names = char(M_.param_names, 'rhoR');
M_.param_names_tex = char(M_.param_names_tex, 'rhoR');
M_.param_names_long = char(M_.param_names_long, 'rhoR');
M_.param_names = char(M_.param_names, 'rhog');
M_.param_names_tex = char(M_.param_names_tex, 'rhog');
M_.param_names_long = char(M_.param_names_long, 'rhog');
M_.param_names = char(M_.param_names, 'rhoz');
M_.param_names_tex = char(M_.param_names_tex, 'rhoz');
M_.param_names_long = char(M_.param_names_long, 'rhoz');
M_.param_names = char(M_.param_names, 'trend');
M_.param_names_tex = char(M_.param_names_tex, 'trend');
M_.param_names_long = char(M_.param_names_long, 'trend');
M_.param_names = char(M_.param_names, 'inflationqstar');
M_.param_names_tex = char(M_.param_names_tex, 'inflationqstar');
M_.param_names_long = char(M_.param_names_long, 'inflationqstar');
M_.param_names = char(M_.param_names, 'rstar');
M_.param_names_tex = char(M_.param_names_tex, 'rstar');
M_.param_names_long = char(M_.param_names_long, 'rstar');
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
M_.aux_vars(2).endo_index = 13;
M_.aux_vars(2).type = 1;
M_.aux_vars(2).orig_index = 2;
M_.aux_vars(2).orig_lead_lag = -2;
options_.varobs = cell(1);
options_.varobs(1)  = {'gdp_rgd_obs'};
options_.varobs(2)  = {'gdpdef_obs'};
options_.varobs(3)  = {'ffr_obs'};
options_.varobs_id = [ 11 9 7  ];
M_.Sigma_e = zeros(3, 3);
M_.Correlation_matrix = eye(3, 3);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.linear = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('DS04_static');
erase_compiled_function('DS04_dynamic');
M_.orig_eq_nbr = 11;
M_.eq_nbr = 13;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
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
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
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
M_.NNZDerivatives = [42; -1; -1];
M_.params( 8 ) = 0.500;
trend = M_.params( 8 );
M_.params( 9 ) = 1.000;
inflationqstar = M_.params( 9 );
M_.params( 10 ) = 0.125;
rstar = M_.params( 10 );
M_.params( 2 ) = 0.300;
kappa = M_.params( 2 );
M_.params( 1 ) = 2.000;
tau = M_.params( 1 );
M_.params( 3 ) = 1.500;
psi1 = M_.params( 3 );
M_.params( 4 ) = 0.125;
psi2 = M_.params( 4 );
M_.params( 5 ) = 0.500;
rhoR = M_.params( 5 );
M_.params( 6 ) = 0.800;
rhog = M_.params( 6 );
M_.params( 7 ) = 0.300;
rhoz = M_.params( 7 );
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
options_.bayesian_irf = 1;
options_.forecast = 40;
options_.mh_drop = 0.3;
options_.mh_jscale = 0.3;
options_.mh_nblck = 1;
options_.mh_replic = 1000000;
options_.mode_check.status = 1;
options_.mode_compute = 4;
options_.nodisplay = 1;
options_.order = 1;
options_.prefilter = 0;
options_.presample = 4;
options_.smoother = 1;
options_.sub_draws = 5000;
options_.datafile = 'data_20080807';
options_.xls_range = 'B1:J101';
options_.xls_sheet = 's3';
var_list_ = char('gdp_rgd_obs');
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
