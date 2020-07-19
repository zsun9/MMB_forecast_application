%
% Status : main Dynare file 
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

tic;
global M_ oo_ options_ ys0_ ex0_
options_ = [];
M_.fname = 'DS04';
%
% Some global variables initialization
%
global_initialization;
diary off;
logname_ = 'DS04.log';
if exist(logname_, 'file')
    delete(logname_)
end
diary(logname_)
M_.exo_names = 'epsilon_R';
M_.exo_names_tex = 'epsilon\_R';
M_.exo_names = char(M_.exo_names, 'epsilon_g');
M_.exo_names_tex = char(M_.exo_names_tex, 'epsilon\_g');
M_.exo_names = char(M_.exo_names, 'epsilon_z');
M_.exo_names_tex = char(M_.exo_names_tex, 'epsilon\_z');
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names = char(M_.endo_names, 'pie');
M_.endo_names_tex = char(M_.endo_names_tex, 'pie');
M_.endo_names = char(M_.endo_names, 'R');
M_.endo_names_tex = char(M_.endo_names_tex, 'R');
M_.endo_names = char(M_.endo_names, 'g');
M_.endo_names_tex = char(M_.endo_names_tex, 'g');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.endo_names = char(M_.endo_names, 'interest');
M_.endo_names_tex = char(M_.endo_names_tex, 'interest');
M_.endo_names = char(M_.endo_names, 'ffr_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'ffr\_obs');
M_.endo_names = char(M_.endo_names, 'inflation');
M_.endo_names_tex = char(M_.endo_names_tex, 'inflation');
M_.endo_names = char(M_.endo_names, 'gdpdef_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'gdpdef\_obs');
M_.endo_names = char(M_.endo_names, 'outputgap');
M_.endo_names_tex = char(M_.endo_names_tex, 'outputgap');
M_.endo_names = char(M_.endo_names, 'gdp_rgd_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'gdp\_rgd\_obs');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_1_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_1\_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_1_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_1\_2');
M_.param_names = 'tau';
M_.param_names_tex = 'tau';
M_.param_names = char(M_.param_names, 'kappa');
M_.param_names_tex = char(M_.param_names_tex, 'kappa');
M_.param_names = char(M_.param_names, 'psi1');
M_.param_names_tex = char(M_.param_names_tex, 'psi1');
M_.param_names = char(M_.param_names, 'psi2');
M_.param_names_tex = char(M_.param_names_tex, 'psi2');
M_.param_names = char(M_.param_names, 'rhoR');
M_.param_names_tex = char(M_.param_names_tex, 'rhoR');
M_.param_names = char(M_.param_names, 'rhog');
M_.param_names_tex = char(M_.param_names_tex, 'rhog');
M_.param_names = char(M_.param_names, 'rhoz');
M_.param_names_tex = char(M_.param_names_tex, 'rhoz');
M_.param_names = char(M_.param_names, 'trend');
M_.param_names_tex = char(M_.param_names_tex, 'trend');
M_.param_names = char(M_.param_names, 'inflationqstar');
M_.param_names_tex = char(M_.param_names_tex, 'inflationqstar');
M_.param_names = char(M_.param_names, 'rstar');
M_.param_names_tex = char(M_.param_names_tex, 'rstar');
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
options_.varobs = [];
options_.varobs = 'gdp_rgd_obs';
options_.varobs = char(options_.varobs, 'gdpdef_obs');
options_.varobs = char(options_.varobs, 'ffr_obs');
options_.varobs_id = [ 11 9 7  ];
M_.Sigma_e = zeros(3, 3);
M_.H = 0;
options_.linear = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('DS04_dynamic');
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
M_.equations_tags = {
};
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
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 42;
M_.NNZDerivatives(2) = -1;
M_.NNZDerivatives(3) = -1;
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
make_ex_;
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (0.01)^2;
M_.Sigma_e(2, 2) = (0.01)^2;
M_.Sigma_e(3, 3) = (0.01)^2;
M_.sigma_e_is_diagonal = 1;
global estim_params_
estim_params_.var_exo = [];
estim_params_.var_endo = [];
estim_params_.corrx = [];
estim_params_.corrn = [];
estim_params_.param_vals = [];
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
options_.mode_check = 1;
options_.mode_compute = 4;
options_.nograph = 1;
options_.order = 1;
options_.prefilter = 0;
options_.presample = 4;
options_.smoother = 1;
options_.datafile = 'data_20200512';
options_.xls_range = 'B1:AN100';
options_.xls_sheet = 's1';
var_list_=[];
var_list_ = 'gdp_rgd_obs';
dynare_estimation(var_list_);
save('DS04_results.mat', 'oo_', 'M_', 'options_');
diary off

disp(['Total computing time : ' dynsec2hms(toc) ]);
