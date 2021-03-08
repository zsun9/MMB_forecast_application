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
M_.fname = 'NKBGG';
M_.dynare_version = '4.6.3';
oo_.dynare_version = '4.6.3';
options_.dynare_version = '4.6.3';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('NKBGG.log');
M_.exo_names = cell(5,1);
M_.exo_names_tex = cell(5,1);
M_.exo_names_long = cell(5,1);
M_.exo_names(1) = {'e_a'};
M_.exo_names_tex(1) = {'e\_a'};
M_.exo_names_long(1) = {'e_a'};
M_.exo_names(2) = {'e_g'};
M_.exo_names_tex(2) = {'e\_g'};
M_.exo_names_long(2) = {'e_g'};
M_.exo_names(3) = {'e_rn'};
M_.exo_names_tex(3) = {'e\_rn'};
M_.exo_names_long(3) = {'e_rn'};
M_.exo_names(4) = {'e_i'};
M_.exo_names_tex(4) = {'e\_i'};
M_.exo_names_long(4) = {'e_i'};
M_.exo_names(5) = {'e_f'};
M_.exo_names_tex(5) = {'e\_f'};
M_.exo_names_long(5) = {'e_f'};
M_.endo_names = cell(34,1);
M_.endo_names_tex = cell(34,1);
M_.endo_names_long = cell(34,1);
M_.endo_names(1) = {'cH'};
M_.endo_names_tex(1) = {'cH'};
M_.endo_names_long(1) = {'cH'};
M_.endo_names(2) = {'hH'};
M_.endo_names_tex(2) = {'hH'};
M_.endo_names_long(2) = {'hH'};
M_.endo_names(3) = {'piH'};
M_.endo_names_tex(3) = {'piH'};
M_.endo_names_long(3) = {'piH'};
M_.endo_names(4) = {'rH'};
M_.endo_names_tex(4) = {'rH'};
M_.endo_names_long(4) = {'rH'};
M_.endo_names(5) = {'r_nH'};
M_.endo_names_tex(5) = {'r\_nH'};
M_.endo_names_long(5) = {'r_nH'};
M_.endo_names(6) = {'qH'};
M_.endo_names_tex(6) = {'qH'};
M_.endo_names_long(6) = {'qH'};
M_.endo_names(7) = {'kH'};
M_.endo_names_tex(7) = {'kH'};
M_.endo_names_long(7) = {'kH'};
M_.endo_names(8) = {'nH'};
M_.endo_names_tex(8) = {'nH'};
M_.endo_names_long(8) = {'nH'};
M_.endo_names(9) = {'r_kH'};
M_.endo_names_tex(9) = {'r\_kH'};
M_.endo_names_long(9) = {'r_kH'};
M_.endo_names(10) = {'yH'};
M_.endo_names_tex(10) = {'yH'};
M_.endo_names_long(10) = {'yH'};
M_.endo_names(11) = {'xH'};
M_.endo_names_tex(11) = {'xH'};
M_.endo_names_long(11) = {'xH'};
M_.endo_names(12) = {'iH'};
M_.endo_names_tex(12) = {'iH'};
M_.endo_names_long(12) = {'iH'};
M_.endo_names(13) = {'aH'};
M_.endo_names_tex(13) = {'aH'};
M_.endo_names_long(13) = {'aH'};
M_.endo_names(14) = {'c_eH'};
M_.endo_names_tex(14) = {'c\_eH'};
M_.endo_names_long(14) = {'c_eH'};
M_.endo_names(15) = {'gH'};
M_.endo_names_tex(15) = {'gH'};
M_.endo_names_long(15) = {'gH'};
M_.endo_names(16) = {'premiumH'};
M_.endo_names_tex(16) = {'premiumH'};
M_.endo_names_long(16) = {'premiumH'};
M_.endo_names(17) = {'xiH'};
M_.endo_names_tex(17) = {'xiH'};
M_.endo_names_long(17) = {'xiH'};
M_.endo_names(18) = {'fH'};
M_.endo_names_tex(18) = {'fH'};
M_.endo_names_long(18) = {'fH'};
M_.endo_names(19) = {'yHf'};
M_.endo_names_tex(19) = {'yHf'};
M_.endo_names_long(19) = {'yHf'};
M_.endo_names(20) = {'kHf'};
M_.endo_names_tex(20) = {'kHf'};
M_.endo_names_long(20) = {'kHf'};
M_.endo_names(21) = {'iHf'};
M_.endo_names_tex(21) = {'iHf'};
M_.endo_names_long(21) = {'iHf'};
M_.endo_names(22) = {'rHf'};
M_.endo_names_tex(22) = {'rHf'};
M_.endo_names_long(22) = {'rHf'};
M_.endo_names(23) = {'r_kHf'};
M_.endo_names_tex(23) = {'r\_kHf'};
M_.endo_names_long(23) = {'r_kHf'};
M_.endo_names(24) = {'nHf'};
M_.endo_names_tex(24) = {'nHf'};
M_.endo_names_long(24) = {'nHf'};
M_.endo_names(25) = {'cHf'};
M_.endo_names_tex(25) = {'cHf'};
M_.endo_names_long(25) = {'cHf'};
M_.endo_names(26) = {'qHf'};
M_.endo_names_tex(26) = {'qHf'};
M_.endo_names_long(26) = {'qHf'};
M_.endo_names(27) = {'hHf'};
M_.endo_names_tex(27) = {'hHf'};
M_.endo_names_long(27) = {'hHf'};
M_.endo_names(28) = {'c_eHf'};
M_.endo_names_tex(28) = {'c\_eHf'};
M_.endo_names_long(28) = {'c_eHf'};
M_.endo_names(29) = {'gdp_rgd_obs'};
M_.endo_names_tex(29) = {'gdp\_rgd\_obs'};
M_.endo_names_long(29) = {'gdp_rgd_obs'};
M_.endo_names(30) = {'gdpdef_obs'};
M_.endo_names_tex(30) = {'gdpdef\_obs'};
M_.endo_names_long(30) = {'gdpdef_obs'};
M_.endo_names(31) = {'ffr_obs'};
M_.endo_names_tex(31) = {'ffr\_obs'};
M_.endo_names_long(31) = {'ffr_obs'};
M_.endo_names(32) = {'ifi_rgd_obs'};
M_.endo_names_tex(32) = {'ifi\_rgd\_obs'};
M_.endo_names_long(32) = {'ifi_rgd_obs'};
M_.endo_names(33) = {'baag10_obs'};
M_.endo_names_tex(33) = {'baag10\_obs'};
M_.endo_names_long(33) = {'baag10_obs'};
M_.endo_names(34) = {'outputgap'};
M_.endo_names_tex(34) = {'outputgap'};
M_.endo_names_long(34) = {'outputgap'};
M_.endo_partitions = struct();
M_.param_names = cell(24,1);
M_.param_names_tex = cell(24,1);
M_.param_names_long = cell(24,1);
M_.param_names(1) = {'X'};
M_.param_names_tex(1) = {'X'};
M_.param_names_long(1) = {'X'};
M_.param_names(2) = {'H'};
M_.param_names_tex(2) = {'H'};
M_.param_names_long(2) = {'H'};
M_.param_names(3) = {'GY'};
M_.param_names_tex(3) = {'GY'};
M_.param_names_long(3) = {'GY'};
M_.param_names(4) = {'omegav'};
M_.param_names_tex(4) = {'omegav'};
M_.param_names_long(4) = {'omegav'};
M_.param_names(5) = {'alphav'};
M_.param_names_tex(5) = {'alphav'};
M_.param_names_long(5) = {'alphav'};
M_.param_names(6) = {'gammav'};
M_.param_names_tex(6) = {'gammav'};
M_.param_names_long(6) = {'gammav'};
M_.param_names(7) = {'deltav'};
M_.param_names_tex(7) = {'deltav'};
M_.param_names_long(7) = {'deltav'};
M_.param_names(8) = {'phiv'};
M_.param_names_tex(8) = {'phiv'};
M_.param_names_long(8) = {'phiv'};
M_.param_names(9) = {'thetav'};
M_.param_names_tex(9) = {'thetav'};
M_.param_names_long(9) = {'thetav'};
M_.param_names(10) = {'etav'};
M_.param_names_tex(10) = {'etav'};
M_.param_names_long(10) = {'etav'};
M_.param_names(11) = {'zetav'};
M_.param_names_tex(11) = {'zetav'};
M_.param_names_long(11) = {'zetav'};
M_.param_names(12) = {'zetay'};
M_.param_names_tex(12) = {'zetay'};
M_.param_names_long(12) = {'zetay'};
M_.param_names(13) = {'rhov'};
M_.param_names_tex(13) = {'rhov'};
M_.param_names_long(13) = {'rhov'};
M_.param_names(14) = {'rhov_a'};
M_.param_names_tex(14) = {'rhov\_a'};
M_.param_names_long(14) = {'rhov_a'};
M_.param_names(15) = {'rhov_g'};
M_.param_names_tex(15) = {'rhov\_g'};
M_.param_names_long(15) = {'rhov_g'};
M_.param_names(16) = {'rhov_i'};
M_.param_names_tex(16) = {'rhov\_i'};
M_.param_names_long(16) = {'rhov_i'};
M_.param_names(17) = {'rhov_f'};
M_.param_names_tex(17) = {'rhov\_f'};
M_.param_names_long(17) = {'rhov_f'};
M_.param_names(18) = {'ytrend'};
M_.param_names_tex(18) = {'ytrend'};
M_.param_names_long(18) = {'ytrend'};
M_.param_names(19) = {'pi_bar'};
M_.param_names_tex(19) = {'pi\_bar'};
M_.param_names_long(19) = {'pi_bar'};
M_.param_names(20) = {'s_bar'};
M_.param_names_tex(20) = {'s\_bar'};
M_.param_names_long(20) = {'s_bar'};
M_.param_names(21) = {'F_bar'};
M_.param_names_tex(21) = {'F\_bar'};
M_.param_names_long(21) = {'F_bar'};
M_.param_names(22) = {'para_sp_b'};
M_.param_names_tex(22) = {'para\_sp\_b'};
M_.param_names_long(22) = {'para_sp_b'};
M_.param_names(23) = {'constebeta'};
M_.param_names_tex(23) = {'constebeta'};
M_.param_names_long(23) = {'constebeta'};
M_.param_names(24) = {'iotapi'};
M_.param_names_tex(24) = {'iotapi'};
M_.param_names_long(24) = {'iotapi'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 5;
M_.endo_nbr = 34;
M_.param_nbr = 24;
M_.orig_endo_nbr = 34;
M_.aux_vars = [];
options_.varobs = cell(5, 1);
options_.varobs(1)  = {'gdp_rgd_obs'};
options_.varobs(2)  = {'ifi_rgd_obs'};
options_.varobs(3)  = {'gdpdef_obs'};
options_.varobs(4)  = {'ffr_obs'};
options_.varobs(5)  = {'baag10_obs'};
options_.varobs_id = [ 29 32 30 31 33  ];
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
M_.orig_eq_nbr = 34;
M_.eq_nbr = 34;
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
 0 16 50;
 0 17 0;
 1 18 51;
 2 19 0;
 3 20 0;
 4 21 0;
 5 22 0;
 0 23 0;
 0 24 52;
 6 25 0;
 0 26 0;
 7 27 53;
 8 28 0;
 0 29 0;
 9 30 0;
 0 31 0;
 10 32 0;
 11 33 0;
 0 34 0;
 12 35 0;
 13 36 54;
 14 37 0;
 0 38 55;
 0 39 0;
 0 40 56;
 15 41 0;
 0 42 0;
 0 43 0;
 0 44 0;
 0 45 0;
 0 46 0;
 0 47 0;
 0 48 0;
 0 49 0;]';
M_.nstatic = 15;
M_.nfwrd   = 4;
M_.npred   = 12;
M_.nboth   = 3;
M_.nsfwrd   = 7;
M_.nspred   = 15;
M_.ndynamic   = 19;
M_.dynamic_tmp_nbr = [36; 0; 0; 0; ];
M_.model_local_variables_dynamic_tt_idxs = {
};
M_.equations_tags = {
  1 , 'name' , 'yH' ;
  2 , 'name' , 'cH' ;
  3 , 'name' , 'c_eH' ;
  4 , 'name' , '4' ;
  5 , 'name' , 'r_kH' ;
  6 , 'name' , 'iH' ;
  7 , 'name' , '7' ;
  8 , 'name' , '8' ;
  9 , 'name' , 'piH' ;
  10 , 'name' , 'kH' ;
  11 , 'name' , 'nH' ;
  12 , 'name' , 'r_nH' ;
  13 , 'name' , '13' ;
  14 , 'name' , 'premiumH' ;
  15 , 'name' , 'aH' ;
  16 , 'name' , 'gH' ;
  17 , 'name' , 'xiH' ;
  18 , 'name' , 'fH' ;
  19 , 'name' , 'yHf' ;
  20 , 'name' , 'cHf' ;
  21 , 'name' , 'c_eHf' ;
  22 , 'name' , '22' ;
  23 , 'name' , 'r_kHf' ;
  24 , 'name' , 'iHf' ;
  25 , 'name' , '25' ;
  26 , 'name' , '26' ;
  27 , 'name' , 'kHf' ;
  28 , 'name' , 'nHf' ;
  29 , 'name' , 'outputgap' ;
  30 , 'name' , 'gdp_rgd_obs' ;
  31 , 'name' , 'ifi_rgd_obs' ;
  32 , 'name' , 'gdpdef_obs' ;
  33 , 'name' , 'ffr_obs' ;
  34 , 'name' , 'baag10_obs' ;
};
M_.mapping.cH.eqidx = [1 2 8 ];
M_.mapping.hH.eqidx = [7 8 ];
M_.mapping.piH.eqidx = [9 12 13 32 ];
M_.mapping.rH.eqidx = [2 4 11 13 14 ];
M_.mapping.r_nH.eqidx = [12 13 33 ];
M_.mapping.qH.eqidx = [4 5 6 11 ];
M_.mapping.kH.eqidx = [4 5 7 10 11 ];
M_.mapping.nH.eqidx = [3 4 11 ];
M_.mapping.r_kH.eqidx = [4 5 11 14 ];
M_.mapping.yH.eqidx = [1 5 7 8 11 12 29 30 ];
M_.mapping.xH.eqidx = [5 8 9 11 ];
M_.mapping.iH.eqidx = [1 6 10 31 ];
M_.mapping.aH.eqidx = [7 15 25 ];
M_.mapping.c_eH.eqidx = [1 3 ];
M_.mapping.gH.eqidx = [1 16 19 ];
M_.mapping.premiumH.eqidx = [14 34 ];
M_.mapping.xiH.eqidx = [6 10 17 24 27 ];
M_.mapping.fH.eqidx = [4 11 18 28 ];
M_.mapping.yHf.eqidx = [12 19 23 25 26 28 29 ];
M_.mapping.kHf.eqidx = [23 25 27 28 ];
M_.mapping.iHf.eqidx = [19 24 27 ];
M_.mapping.rHf.eqidx = [20 22 28 ];
M_.mapping.r_kHf.eqidx = [22 23 28 ];
M_.mapping.nHf.eqidx = [21 28 ];
M_.mapping.cHf.eqidx = [19 20 26 ];
M_.mapping.qHf.eqidx = [23 24 28 ];
M_.mapping.hHf.eqidx = [25 26 ];
M_.mapping.c_eHf.eqidx = [19 21 ];
M_.mapping.gdp_rgd_obs.eqidx = [30 ];
M_.mapping.gdpdef_obs.eqidx = [32 ];
M_.mapping.ffr_obs.eqidx = [33 ];
M_.mapping.ifi_rgd_obs.eqidx = [31 ];
M_.mapping.baag10_obs.eqidx = [34 ];
M_.mapping.outputgap.eqidx = [29 ];
M_.mapping.e_a.eqidx = [15 ];
M_.mapping.e_g.eqidx = [16 ];
M_.mapping.e_rn.eqidx = [12 ];
M_.mapping.e_i.eqidx = [17 ];
M_.mapping.e_f.eqidx = [18 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = true;
M_.state_var = [3 4 5 6 7 10 12 13 15 17 18 20 21 22 26 ];
M_.exo_names_orig_ord = [1:5];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(34, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(5, 1);
M_.params = NaN(24, 1);
M_.endo_trends = struct('deflator', cell(34, 1), 'log_deflator', cell(34, 1), 'growth_factor', cell(34, 1), 'log_growth_factor', cell(34, 1));
M_.NNZDerivatives = [130; 0; -1; ];
M_.static_tmp_nbr = [37; 1; 0; 0; ];
M_.model_local_variables_static_tt_idxs = {
};
thispath = cd; 
cd('..');
external_function_path = cd('..'); 
eval(['addpath  ' external_function_path '; ']);
cd(thispath); 
M_.params(10) = 2;
etav = M_.params(10);
M_.params(7) = 0.025;
deltav = M_.params(7);
M_.params(1) = 1.1;
X = M_.params(1);
M_.params(6) = 0.9728;
gammav = M_.params(6);
M_.params(21) = 0.0075;
F_bar = M_.params(21);
M_.params(3) = 0.2;
GY = M_.params(3);
M_.params(5) = 0.35;
alphav = M_.params(5);
M_.params(4) = 0.64/(1-M_.params(5));
omegav = M_.params(4);
M_.params(2) = 0.3333333333333333;
H = M_.params(2);
estim_params_.var_exo = zeros(0, 10);
estim_params_.var_endo = zeros(0, 10);
estim_params_.corrx = zeros(0, 11);
estim_params_.corrn = zeros(0, 11);
estim_params_.param_vals = zeros(0, 10);
estim_params_.param_vals = [estim_params_.param_vals; 22, NaN, (-Inf), Inf, 1, 0.05, 0.005, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 8, NaN, (-Inf), Inf, 3, 4, 1.5, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 9, NaN, (-Inf), Inf, 1, 0.5, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 13, NaN, (-Inf), Inf, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 11, NaN, (-Inf), Inf, 2, 1.5, 0.25, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 12, NaN, (-Inf), Inf, 2, 0.125, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 19, NaN, (-Inf), Inf, 2, 0.62, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 24, NaN, (-Inf), Inf, 1, 0.5, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 23, NaN, (-Inf), Inf, 2, 0.3, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 18, NaN, (-Inf), Inf, 3, 0.4, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 20, NaN, (-Inf), Inf, 2, 0.5, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 14, NaN, (-Inf), Inf, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 15, NaN, (-Inf), Inf, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 16, NaN, (-Inf), Inf, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 17, NaN, (-Inf), Inf, 1, 0.75, 0.15, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 1, NaN, (-Inf), Inf, 4, 0.1, 2.0, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, NaN, (-Inf), Inf, 4, 0.1, 2.0, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 3, NaN, (-Inf), Inf, 4, 0.1, 2.0, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 4, NaN, (-Inf), Inf, 4, 0.1, 2.0, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 5, NaN, (-Inf), Inf, 4, 0.05, 4.0, NaN, NaN, NaN ];
tmp1 = find(estim_params_.param_vals(:,1)==22);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{22}))
else
    estim_params_.param_vals(tmp1,2) = 0.05;
end
tmp1 = find(estim_params_.param_vals(:,1)==8);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{8}))
else
    estim_params_.param_vals(tmp1,2) = 5;
end
tmp1 = find(estim_params_.param_vals(:,1)==9);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{9}))
else
    estim_params_.param_vals(tmp1,2) = 0.75;
end
tmp1 = find(estim_params_.param_vals(:,1)==13);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{13}))
else
    estim_params_.param_vals(tmp1,2) = 0.7;
end
tmp1 = find(estim_params_.param_vals(:,1)==11);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{11}))
else
    estim_params_.param_vals(tmp1,2) = 1.5;
end
tmp1 = find(estim_params_.param_vals(:,1)==12);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{12}))
else
    estim_params_.param_vals(tmp1,2) = 0.125;
end
tmp1 = find(estim_params_.param_vals(:,1)==19);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{19}))
else
    estim_params_.param_vals(tmp1,2) = 0.625;
end
tmp1 = find(estim_params_.param_vals(:,1)==23);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{23}))
else
    estim_params_.param_vals(tmp1,2) = 0.25;
end
tmp1 = find(estim_params_.param_vals(:,1)==24);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{24}))
else
    estim_params_.param_vals(tmp1,2) = 0.5;
end
tmp1 = find(estim_params_.param_vals(:,1)==18);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{18}))
else
    estim_params_.param_vals(tmp1,2) = 0.4;
end
tmp1 = find(estim_params_.param_vals(:,1)==20);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{20}))
else
    estim_params_.param_vals(tmp1,2) = 0.5;
end
tmp1 = find(estim_params_.param_vals(:,1)==14);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{14}))
else
    estim_params_.param_vals(tmp1,2) = 0.90;
end
tmp1 = find(estim_params_.param_vals(:,1)==15);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{15}))
else
    estim_params_.param_vals(tmp1,2) = 0.80;
end
tmp1 = find(estim_params_.param_vals(:,1)==16);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{16}))
else
    estim_params_.param_vals(tmp1,2) = 0.80;
end
tmp1 = find(estim_params_.param_vals(:,1)==17);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', M_.param_names{17}))
else
    estim_params_.param_vals(tmp1,2) = 0.80;
end
tmp1 = find(estim_params_.var_exo(:,1)==1);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', M_.exo_names{1}))
else
    estim_params_.var_exo(tmp1,2) = 0.5;
end
tmp1 = find(estim_params_.var_exo(:,1)==2);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', M_.exo_names{2}))
else
    estim_params_.var_exo(tmp1,2) = 0.5;
end
tmp1 = find(estim_params_.var_exo(:,1)==3);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', M_.exo_names{3}))
else
    estim_params_.var_exo(tmp1,2) = 0.0625;
end
tmp1 = find(estim_params_.var_exo(:,1)==4);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', M_.exo_names{4}))
else
    estim_params_.var_exo(tmp1,2) = 0.5;
end
tmp1 = find(estim_params_.var_exo(:,1)==5);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', M_.exo_names{5}))
else
    estim_params_.var_exo(tmp1,2) = 0.5;
end
skipline()
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
options_.datafile = 'data_20201110';
options_.xls_range = 'B1:AY101';
options_.xls_sheet = 's3';
var_list_ = {'gdp_rgd_obs';'gdpdef_obs'};
oo_recursive_=dynare_estimation(var_list_);
save('NKBGG_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('NKBGG_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('NKBGG_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('NKBGG_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('NKBGG_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('NKBGG_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('NKBGG_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
