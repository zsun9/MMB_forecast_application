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
M_.fname = 'IN10';
M_.dynare_version = '4.6.2';
oo_.dynare_version = '4.6.2';
options_.dynare_version = '4.6.2';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('IN10.log');
M_.exo_names = cell(9,1);
M_.exo_names_tex = cell(9,1);
M_.exo_names_long = cell(9,1);
M_.exo_names(1) = {'eps_c'};
M_.exo_names_tex(1) = {'eps\_c'};
M_.exo_names_long(1) = {'eps_c'};
M_.exo_names(2) = {'eps_e'};
M_.exo_names_tex(2) = {'eps\_e'};
M_.exo_names_long(2) = {'eps_e'};
M_.exo_names(3) = {'eps_h'};
M_.exo_names_tex(3) = {'eps\_h'};
M_.exo_names_long(3) = {'eps_h'};
M_.exo_names(4) = {'eps_j'};
M_.exo_names_tex(4) = {'eps\_j'};
M_.exo_names_long(4) = {'eps_j'};
M_.exo_names(5) = {'eps_k'};
M_.exo_names_tex(5) = {'eps\_k'};
M_.exo_names_long(5) = {'eps_k'};
M_.exo_names(6) = {'eps_p'};
M_.exo_names_tex(6) = {'eps\_p'};
M_.exo_names_long(6) = {'eps_p'};
M_.exo_names(7) = {'eps_s'};
M_.exo_names_tex(7) = {'eps\_s'};
M_.exo_names_long(7) = {'eps_s'};
M_.exo_names(8) = {'eps_t'};
M_.exo_names_tex(8) = {'eps\_t'};
M_.exo_names_long(8) = {'eps_t'};
M_.exo_names(9) = {'eps_z'};
M_.exo_names_tex(9) = {'eps\_z'};
M_.exo_names_long(9) = {'eps_z'};
M_.endo_names = cell(50,1);
M_.endo_names_tex = cell(50,1);
M_.endo_names_long = cell(50,1);
M_.endo_names(1) = {'a_c'};
M_.endo_names_tex(1) = {'a\_c'};
M_.endo_names_long(1) = {'a_c'};
M_.endo_names(2) = {'a_h'};
M_.endo_names_tex(2) = {'a\_h'};
M_.endo_names_long(2) = {'a_h'};
M_.endo_names(3) = {'a_j'};
M_.endo_names_tex(3) = {'a\_j'};
M_.endo_names_long(3) = {'a_j'};
M_.endo_names(4) = {'a_k'};
M_.endo_names_tex(4) = {'a\_k'};
M_.endo_names_long(4) = {'a_k'};
M_.endo_names(5) = {'a_s'};
M_.endo_names_tex(5) = {'a\_s'};
M_.endo_names_long(5) = {'a_s'};
M_.endo_names(6) = {'a_t'};
M_.endo_names_tex(6) = {'a\_t'};
M_.endo_names_long(6) = {'a_t'};
M_.endo_names(7) = {'a_z'};
M_.endo_names_tex(7) = {'a\_z'};
M_.endo_names_long(7) = {'a_z'};
M_.endo_names(8) = {'b'};
M_.endo_names_tex(8) = {'b'};
M_.endo_names_long(8) = {'b'};
M_.endo_names(9) = {'c'};
M_.endo_names_tex(9) = {'c'};
M_.endo_names_long(9) = {'c'};
M_.endo_names(10) = {'c1'};
M_.endo_names_tex(10) = {'c1'};
M_.endo_names_long(10) = {'c1'};
M_.endo_names(11) = {'rc_obs'};
M_.endo_names_tex(11) = {'rc\_obs'};
M_.endo_names_long(11) = {'rc_obs'};
M_.endo_names(12) = {'pi_dm_obs'};
M_.endo_names_tex(12) = {'pi\_dm\_obs'};
M_.endo_names_long(12) = {'pi_dm_obs'};
M_.endo_names(13) = {'rri_obs'};
M_.endo_names_tex(13) = {'rri\_obs'};
M_.endo_names_long(13) = {'rri_obs'};
M_.endo_names(14) = {'rbi_obs'};
M_.endo_names_tex(14) = {'rbi\_obs'};
M_.endo_names_long(14) = {'rbi_obs'};
M_.endo_names(15) = {'hwc_pd_obs'};
M_.endo_names_tex(15) = {'hwc\_pd\_obs'};
M_.endo_names_long(15) = {'hwc_pd_obs'};
M_.endo_names(16) = {'hwr_pd_obs'};
M_.endo_names_tex(16) = {'hwr\_pd\_obs'};
M_.endo_names_long(16) = {'hwr_pd_obs'};
M_.endo_names(17) = {'hp_r_obs'};
M_.endo_names_tex(17) = {'hp\_r\_obs'};
M_.endo_names_long(17) = {'hp_r_obs'};
M_.endo_names(18) = {'i_nom_obs'};
M_.endo_names_tex(18) = {'i\_nom\_obs'};
M_.endo_names_long(18) = {'i_nom_obs'};
M_.endo_names(19) = {'c_winf_obs'};
M_.endo_names_tex(19) = {'c\_winf\_obs'};
M_.endo_names_long(19) = {'c_winf_obs'};
M_.endo_names(20) = {'h_winf_obs'};
M_.endo_names_tex(20) = {'h\_winf\_obs'};
M_.endo_names_long(20) = {'h_winf_obs'};
M_.endo_names(21) = {'dp'};
M_.endo_names_tex(21) = {'dp'};
M_.endo_names_long(21) = {'dp'};
M_.endo_names(22) = {'h'};
M_.endo_names_tex(22) = {'h'};
M_.endo_names_long(22) = {'h'};
M_.endo_names(23) = {'h1'};
M_.endo_names_tex(23) = {'h1'};
M_.endo_names_long(23) = {'h1'};
M_.endo_names(24) = {'I'};
M_.endo_names_tex(24) = {'I'};
M_.endo_names_long(24) = {'I'};
M_.endo_names(25) = {'kc'};
M_.endo_names_tex(25) = {'kc'};
M_.endo_names_long(25) = {'kc'};
M_.endo_names(26) = {'kh'};
M_.endo_names_tex(26) = {'kh'};
M_.endo_names_long(26) = {'kh'};
M_.endo_names(27) = {'lm'};
M_.endo_names_tex(27) = {'lm'};
M_.endo_names_long(27) = {'lm'};
M_.endo_names(28) = {'nc'};
M_.endo_names_tex(28) = {'nc'};
M_.endo_names_long(28) = {'nc'};
M_.endo_names(29) = {'nc1'};
M_.endo_names_tex(29) = {'nc1'};
M_.endo_names_long(29) = {'nc1'};
M_.endo_names(30) = {'nh'};
M_.endo_names_tex(30) = {'nh'};
M_.endo_names_long(30) = {'nh'};
M_.endo_names(31) = {'nh1'};
M_.endo_names_tex(31) = {'nh1'};
M_.endo_names_long(31) = {'nh1'};
M_.endo_names(32) = {'q'};
M_.endo_names_tex(32) = {'q'};
M_.endo_names_long(32) = {'q'};
M_.endo_names(33) = {'r'};
M_.endo_names_tex(33) = {'r'};
M_.endo_names_long(33) = {'r'};
M_.endo_names(34) = {'rkc'};
M_.endo_names_tex(34) = {'rkc'};
M_.endo_names_long(34) = {'rkc'};
M_.endo_names(35) = {'rkh'};
M_.endo_names_tex(35) = {'rkh'};
M_.endo_names_long(35) = {'rkh'};
M_.endo_names(36) = {'uc'};
M_.endo_names_tex(36) = {'uc'};
M_.endo_names_long(36) = {'uc'};
M_.endo_names(37) = {'uc1'};
M_.endo_names_tex(37) = {'uc1'};
M_.endo_names_long(37) = {'uc1'};
M_.endo_names(38) = {'wc'};
M_.endo_names_tex(38) = {'wc'};
M_.endo_names_long(38) = {'wc'};
M_.endo_names(39) = {'wc1'};
M_.endo_names_tex(39) = {'wc1'};
M_.endo_names_long(39) = {'wc1'};
M_.endo_names(40) = {'wh'};
M_.endo_names_tex(40) = {'wh'};
M_.endo_names_long(40) = {'wh'};
M_.endo_names(41) = {'wh1'};
M_.endo_names_tex(41) = {'wh1'};
M_.endo_names_long(41) = {'wh1'};
M_.endo_names(42) = {'X'};
M_.endo_names_tex(42) = {'X'};
M_.endo_names_long(42) = {'X'};
M_.endo_names(43) = {'xwc'};
M_.endo_names_tex(43) = {'xwc'};
M_.endo_names_long(43) = {'xwc'};
M_.endo_names(44) = {'xwc1'};
M_.endo_names_tex(44) = {'xwc1'};
M_.endo_names_long(44) = {'xwc1'};
M_.endo_names(45) = {'xwh'};
M_.endo_names_tex(45) = {'xwh'};
M_.endo_names_long(45) = {'xwh'};
M_.endo_names(46) = {'xwh1'};
M_.endo_names_tex(46) = {'xwh1'};
M_.endo_names_long(46) = {'xwh1'};
M_.endo_names(47) = {'Y'};
M_.endo_names_tex(47) = {'Y'};
M_.endo_names_long(47) = {'Y'};
M_.endo_names(48) = {'gdpl_rgd_obs'};
M_.endo_names_tex(48) = {'gdpl\_rgd\_obs'};
M_.endo_names_long(48) = {'gdpl_rgd_obs'};
M_.endo_names(49) = {'zkc'};
M_.endo_names_tex(49) = {'zkc'};
M_.endo_names_long(49) = {'zkc'};
M_.endo_names(50) = {'zkh'};
M_.endo_names_tex(50) = {'zkh'};
M_.endo_names_long(50) = {'zkh'};
M_.endo_partitions = struct();
M_.param_names = cell(43,1);
M_.param_names_tex = cell(43,1);
M_.param_names_long = cell(43,1);
M_.param_names(1) = {'BETA'};
M_.param_names_tex(1) = {'BETA'};
M_.param_names_long(1) = {'BETA'};
M_.param_names(2) = {'BETA1'};
M_.param_names_tex(2) = {'BETA1'};
M_.param_names_long(2) = {'BETA1'};
M_.param_names(3) = {'M'};
M_.param_names_tex(3) = {'M'};
M_.param_names_long(3) = {'M'};
M_.param_names(4) = {'JEI'};
M_.param_names_tex(4) = {'JEI'};
M_.param_names_long(4) = {'JEI'};
M_.param_names(5) = {'MUC'};
M_.param_names_tex(5) = {'MUC'};
M_.param_names_long(5) = {'MUC'};
M_.param_names(6) = {'MUH'};
M_.param_names_tex(6) = {'MUH'};
M_.param_names_long(6) = {'MUH'};
M_.param_names(7) = {'DKC'};
M_.param_names_tex(7) = {'DKC'};
M_.param_names_long(7) = {'DKC'};
M_.param_names(8) = {'DKH'};
M_.param_names_tex(8) = {'DKH'};
M_.param_names_long(8) = {'DKH'};
M_.param_names(9) = {'DH'};
M_.param_names_tex(9) = {'DH'};
M_.param_names_long(9) = {'DH'};
M_.param_names(10) = {'ETA'};
M_.param_names_tex(10) = {'ETA'};
M_.param_names_long(10) = {'ETA'};
M_.param_names(11) = {'ETA1'};
M_.param_names_tex(11) = {'ETA1'};
M_.param_names_long(11) = {'ETA1'};
M_.param_names(12) = {'EC'};
M_.param_names_tex(12) = {'EC'};
M_.param_names_long(12) = {'EC'};
M_.param_names(13) = {'EC1'};
M_.param_names_tex(13) = {'EC1'};
M_.param_names_long(13) = {'EC1'};
M_.param_names(14) = {'FIKC'};
M_.param_names_tex(14) = {'FIKC'};
M_.param_names_long(14) = {'FIKC'};
M_.param_names(15) = {'FIKH'};
M_.param_names_tex(15) = {'FIKH'};
M_.param_names_long(15) = {'FIKH'};
M_.param_names(16) = {'ALPHA'};
M_.param_names_tex(16) = {'ALPHA'};
M_.param_names_long(16) = {'ALPHA'};
M_.param_names(17) = {'TETA'};
M_.param_names_tex(17) = {'TETA'};
M_.param_names_long(17) = {'TETA'};
M_.param_names(18) = {'TAYLOR_R'};
M_.param_names_tex(18) = {'TAYLOR\_R'};
M_.param_names_long(18) = {'TAYLOR_R'};
M_.param_names(19) = {'TAYLOR_Y'};
M_.param_names_tex(19) = {'TAYLOR\_Y'};
M_.param_names_long(19) = {'TAYLOR_Y'};
M_.param_names(20) = {'TAYLOR_P'};
M_.param_names_tex(20) = {'TAYLOR\_P'};
M_.param_names_long(20) = {'TAYLOR_P'};
M_.param_names(21) = {'X_SS'};
M_.param_names_tex(21) = {'X\_SS'};
M_.param_names_long(21) = {'X_SS'};
M_.param_names(22) = {'LAGP'};
M_.param_names_tex(22) = {'LAGP'};
M_.param_names_long(22) = {'LAGP'};
M_.param_names(23) = {'RHO_AC'};
M_.param_names_tex(23) = {'RHO\_AC'};
M_.param_names_long(23) = {'RHO_AC'};
M_.param_names(24) = {'RHO_AH'};
M_.param_names_tex(24) = {'RHO\_AH'};
M_.param_names_long(24) = {'RHO_AH'};
M_.param_names(25) = {'RHO_AJ'};
M_.param_names_tex(25) = {'RHO\_AJ'};
M_.param_names_long(25) = {'RHO_AJ'};
M_.param_names(26) = {'RHO_AK'};
M_.param_names_tex(26) = {'RHO\_AK'};
M_.param_names_long(26) = {'RHO_AK'};
M_.param_names(27) = {'RHO_AM'};
M_.param_names_tex(27) = {'RHO\_AM'};
M_.param_names_long(27) = {'RHO_AM'};
M_.param_names(28) = {'RHO_AT'};
M_.param_names_tex(28) = {'RHO\_AT'};
M_.param_names_long(28) = {'RHO_AT'};
M_.param_names(29) = {'RHO_AZ'};
M_.param_names_tex(29) = {'RHO\_AZ'};
M_.param_names_long(29) = {'RHO_AZ'};
M_.param_names(30) = {'RHO_AS'};
M_.param_names_tex(30) = {'RHO\_AS'};
M_.param_names_long(30) = {'RHO_AS'};
M_.param_names(31) = {'NU'};
M_.param_names_tex(31) = {'NU'};
M_.param_names_long(31) = {'NU'};
M_.param_names(32) = {'NU1'};
M_.param_names_tex(32) = {'NU1'};
M_.param_names_long(32) = {'NU1'};
M_.param_names(33) = {'KAPPA'};
M_.param_names_tex(33) = {'KAPPA'};
M_.param_names_long(33) = {'KAPPA'};
M_.param_names(34) = {'XW_SS'};
M_.param_names_tex(34) = {'XW\_SS'};
M_.param_names_long(34) = {'XW_SS'};
M_.param_names(35) = {'TETAWC'};
M_.param_names_tex(35) = {'TETAWC'};
M_.param_names_long(35) = {'TETAWC'};
M_.param_names(36) = {'TETAWH'};
M_.param_names_tex(36) = {'TETAWH'};
M_.param_names_long(36) = {'TETAWH'};
M_.param_names(37) = {'LAGWC'};
M_.param_names_tex(37) = {'LAGWC'};
M_.param_names_long(37) = {'LAGWC'};
M_.param_names(38) = {'LAGWH'};
M_.param_names_tex(38) = {'LAGWH'};
M_.param_names_long(38) = {'LAGWH'};
M_.param_names(39) = {'ZETAKC'};
M_.param_names_tex(39) = {'ZETAKC'};
M_.param_names_long(39) = {'ZETAKC'};
M_.param_names(40) = {'TREND_AC'};
M_.param_names_tex(40) = {'TREND\_AC'};
M_.param_names_long(40) = {'TREND_AC'};
M_.param_names(41) = {'TREND_AH'};
M_.param_names_tex(41) = {'TREND\_AH'};
M_.param_names_long(41) = {'TREND_AH'};
M_.param_names(42) = {'TREND_AK'};
M_.param_names_tex(42) = {'TREND\_AK'};
M_.param_names_long(42) = {'TREND_AK'};
M_.param_names(43) = {'MUBB'};
M_.param_names_tex(43) = {'MUBB'};
M_.param_names_long(43) = {'MUBB'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 9;
M_.endo_nbr = 50;
M_.param_nbr = 43;
M_.orig_endo_nbr = 50;
M_.aux_vars = [];
options_.varobs = cell(10, 1);
options_.varobs(1)  = {'rc_obs'};
options_.varobs(2)  = {'pi_dm_obs'};
options_.varobs(3)  = {'rri_obs'};
options_.varobs(4)  = {'rbi_obs'};
options_.varobs(5)  = {'hwc_pd_obs'};
options_.varobs(6)  = {'hwr_pd_obs'};
options_.varobs(7)  = {'hp_r_obs'};
options_.varobs(8)  = {'i_nom_obs'};
options_.varobs(9)  = {'c_winf_obs'};
options_.varobs(10)  = {'h_winf_obs'};
options_.varobs_id = [ 11 12 13 14 15 16 17 18 19 20  ];
M_.Sigma_e = zeros(9, 9);
M_.Correlation_matrix = eye(9, 9);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
options_.linear = false;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
options_.linear_decomposition = false;
M_.orig_eq_nbr = 50;
M_.eq_nbr = 50;
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
 1 22 0;
 2 23 0;
 3 24 0;
 4 25 72;
 5 26 0;
 6 27 0;
 7 28 0;
 8 29 0;
 9 30 73;
 10 31 74;
 0 32 0;
 0 33 0;
 0 34 0;
 0 35 0;
 0 36 0;
 0 37 0;
 0 38 0;
 0 39 0;
 0 40 0;
 0 41 0;
 11 42 75;
 12 43 0;
 13 44 0;
 0 45 0;
 14 46 76;
 15 47 77;
 0 48 0;
 0 49 0;
 0 50 0;
 0 51 0;
 0 52 0;
 0 53 78;
 16 54 0;
 0 55 79;
 0 56 80;
 0 57 81;
 0 58 82;
 17 59 83;
 18 60 84;
 19 61 85;
 20 62 86;
 0 63 0;
 0 64 0;
 0 65 0;
 0 66 0;
 0 67 0;
 0 68 0;
 21 69 0;
 0 70 87;
 0 71 88;]';
M_.nstatic = 22;
M_.nfwrd   = 7;
M_.npred   = 11;
M_.nboth   = 10;
M_.nsfwrd   = 17;
M_.nspred   = 21;
M_.ndynamic   = 28;
M_.dynamic_tmp_nbr = [90; 6; 0; 0; ];
M_.model_local_variables_dynamic_tt_idxs = {
  'TRENDY', 1;
  'TRENDK', 2;
  'TRENDQ', 3;
  'TRENDH', 4;
  'llr', 5;
  'llEXPTRENDY', 6;
  'llEXPTRENDK', 7;
  'llgamma_k', 8;
  'llEXPTRENDQ', 9;
  'llEXPTRENDH', 10;
  'llDH1', 11;
  'llZETA2', 12;
  'llr1', 13;
  'llZETA1', 14;
  'llZETA3', 15;
  'llZETA4', 16;
  'llZETA0', 17;
  'llCHI3', 18;
  'llCHI4', 19;
  'llCHI2', 20;
  'llCHI6', 21;
  'llCHI1', 22;
  'llCHI5', 23;
  'llCY', 24;
  'llCYPRIME', 25;
  'llQIY', 26;
  'llRATION', 27;
  'llNHNC', 28;
  'llnc', 29;
  'llNHNC1', 30;
  'llnc1', 31;
  'llnh', 32;
  'llnh1', 33;
  'llY', 34;
  'llI', 35;
  'llQI', 36;
  'llc', 37;
  'llq', 38;
  'llc1', 39;
  'llDKC1', 40;
  'llkc', 41;
  'llDKH1', 42;
  'llkh', 43;
  'llCC', 44;
  'llIH', 45;
  'llIK', 46;
  'CC_SS', 47;
  'IH_SS', 48;
  'IK_SS', 49;
  'NC_SS', 50;
  'NH_SS', 51;
  'QQ_SS', 52;
};
M_.equations_tags = {
  1 , 'name' , '1' ;
  2 , 'name' , '2' ;
  3 , 'name' , '3' ;
  4 , 'name' , '4' ;
  5 , 'name' , '5' ;
  6 , 'name' , '6' ;
  7 , 'name' , '7' ;
  8 , 'name' , '8' ;
  9 , 'name' , '9' ;
  10 , 'name' , 'b' ;
  11 , 'name' , '11' ;
  12 , 'name' , '12' ;
  13 , 'name' , '13' ;
  14 , 'name' , 'Y' ;
  15 , 'name' , 'I' ;
  16 , 'name' , '16' ;
  17 , 'name' , '17' ;
  18 , 'name' , '18' ;
  19 , 'name' , '19' ;
  20 , 'name' , '20' ;
  21 , 'name' , '21' ;
  22 , 'name' , '22' ;
  23 , 'name' , 'r' ;
  24 , 'name' , '24' ;
  25 , 'name' , '25' ;
  26 , 'name' , '26' ;
  27 , 'name' , 'wc' ;
  28 , 'name' , 'wc1' ;
  29 , 'name' , 'wh' ;
  30 , 'name' , 'wh1' ;
  31 , 'name' , '31' ;
  32 , 'name' , '32' ;
  33 , 'name' , 'rc_obs' ;
  34 , 'name' , 'pi_dm_obs' ;
  35 , 'name' , 'rri_obs' ;
  36 , 'name' , 'rbi_obs' ;
  37 , 'name' , 'hwc_pd_obs' ;
  38 , 'name' , 'hwr_pd_obs' ;
  39 , 'name' , 'hp_r_obs' ;
  40 , 'name' , 'i_nom_obs' ;
  41 , 'name' , 'c_winf_obs' ;
  42 , 'name' , 'h_winf_obs' ;
  43 , 'name' , 'gdpl_rgd_obs' ;
  44 , 'name' , 'a_c' ;
  45 , 'name' , 'a_h' ;
  46 , 'name' , 'a_j' ;
  47 , 'name' , 'a_k' ;
  48 , 'name' , 'a_t' ;
  49 , 'name' , 'a_s' ;
  50 , 'name' , 'a_z' ;
};
M_.mapping.a_c.eqidx = [14 44 ];
M_.mapping.a_h.eqidx = [15 45 ];
M_.mapping.a_j.eqidx = [2 9 46 ];
M_.mapping.a_k.eqidx = [1 4 31 47 ];
M_.mapping.a_s.eqidx = [23 49 ];
M_.mapping.a_t.eqidx = [6 7 12 13 48 ];
M_.mapping.a_z.eqidx = [2 6 7 9 12 13 25 26 50 ];
M_.mapping.b.eqidx = [1 8 10 ];
M_.mapping.c.eqidx = [1 25 33 ];
M_.mapping.c1.eqidx = [8 26 33 ];
M_.mapping.rc_obs.eqidx = [33 43 ];
M_.mapping.pi_dm_obs.eqidx = [34 ];
M_.mapping.rri_obs.eqidx = [35 43 ];
M_.mapping.rbi_obs.eqidx = [36 43 ];
M_.mapping.hwc_pd_obs.eqidx = [37 ];
M_.mapping.hwr_pd_obs.eqidx = [38 ];
M_.mapping.hp_r_obs.eqidx = [39 ];
M_.mapping.i_nom_obs.eqidx = [40 ];
M_.mapping.c_winf_obs.eqidx = [41 ];
M_.mapping.h_winf_obs.eqidx = [42 ];
M_.mapping.dp.eqidx = [1 3 8 9 10 11 22 23 27 28 29 30 34 41 42 ];
M_.mapping.h.eqidx = [1 2 24 ];
M_.mapping.h1.eqidx = [8 9 10 24 ];
M_.mapping.I.eqidx = [1 15 18 19 21 24 35 ];
M_.mapping.kc.eqidx = [1 4 14 20 36 ];
M_.mapping.kh.eqidx = [1 5 15 21 36 ];
M_.mapping.lm.eqidx = [9 11 ];
M_.mapping.nc.eqidx = [1 6 7 14 16 37 ];
M_.mapping.nc1.eqidx = [8 12 13 14 17 37 ];
M_.mapping.nh.eqidx = [1 6 7 15 18 38 ];
M_.mapping.nh1.eqidx = [8 12 13 15 19 38 ];
M_.mapping.q.eqidx = [1 2 8 9 10 15 18 19 21 39 ];
M_.mapping.r.eqidx = [1 3 8 9 10 11 23 40 ];
M_.mapping.rkc.eqidx = [1 4 20 31 ];
M_.mapping.rkh.eqidx = [1 5 21 32 ];
M_.mapping.uc.eqidx = [2 3 4 5 6 7 25 ];
M_.mapping.uc1.eqidx = [9 11 12 13 26 ];
M_.mapping.wc.eqidx = [1 6 16 27 41 ];
M_.mapping.wc1.eqidx = [8 12 17 28 41 ];
M_.mapping.wh.eqidx = [1 7 18 29 42 ];
M_.mapping.wh1.eqidx = [8 13 19 30 42 ];
M_.mapping.X.eqidx = [1 16 17 20 22 ];
M_.mapping.xwc.eqidx = [6 27 ];
M_.mapping.xwc1.eqidx = [12 28 ];
M_.mapping.xwh.eqidx = [7 29 ];
M_.mapping.xwh1.eqidx = [13 30 ];
M_.mapping.Y.eqidx = [1 14 16 17 20 ];
M_.mapping.gdpl_rgd_obs.eqidx = [23 43 ];
M_.mapping.zkc.eqidx = [1 4 14 20 31 ];
M_.mapping.zkh.eqidx = [1 5 15 21 32 ];
M_.mapping.eps_c.eqidx = [44 ];
M_.mapping.eps_e.eqidx = [23 ];
M_.mapping.eps_h.eqidx = [45 ];
M_.mapping.eps_j.eqidx = [46 ];
M_.mapping.eps_k.eqidx = [47 ];
M_.mapping.eps_p.eqidx = [22 ];
M_.mapping.eps_s.eqidx = [49 ];
M_.mapping.eps_t.eqidx = [48 ];
M_.mapping.eps_z.eqidx = [50 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [1 2 3 4 5 6 7 8 9 10 21 22 23 25 26 33 38 39 40 41 48 ];
M_.exo_names_orig_ord = [1:9];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(50, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(9, 1);
M_.params = NaN(43, 1);
M_.endo_trends = struct('deflator', cell(50, 1), 'log_deflator', cell(50, 1), 'growth_factor', cell(50, 1), 'log_growth_factor', cell(50, 1));
M_.NNZDerivatives = [269; -1; -1; ];
M_.static_tmp_nbr = [30; 7; 0; 0; ];
M_.model_local_variables_static_tt_idxs = {
  'TRENDY', 1;
  'TRENDK', 2;
  'TRENDQ', 3;
  'TRENDH', 4;
  'llr', 5;
  'llEXPTRENDY', 6;
  'llEXPTRENDK', 7;
  'llgamma_k', 8;
  'llEXPTRENDQ', 9;
  'llEXPTRENDH', 10;
  'llDH1', 11;
  'llZETA2', 12;
  'llr1', 13;
  'llZETA1', 14;
  'llZETA3', 15;
  'llZETA4', 16;
  'llZETA0', 17;
  'llCHI3', 18;
  'llCHI4', 19;
  'llCHI2', 20;
  'llCHI6', 21;
  'llCHI1', 22;
  'llCHI5', 23;
  'llCY', 24;
  'llCYPRIME', 25;
  'llQIY', 26;
  'llRATION', 27;
  'llNHNC', 28;
  'llnc', 29;
  'llNHNC1', 30;
  'llnc1', 31;
  'llnh', 32;
  'llnh1', 33;
  'llY', 34;
  'llI', 35;
  'llQI', 36;
  'llc', 37;
  'llq', 38;
  'llc1', 39;
  'llDKC1', 40;
  'llkc', 41;
  'llDKH1', 42;
  'llkh', 43;
  'llCC', 44;
  'llIH', 45;
  'llIK', 46;
  'CC_SS', 47;
  'IH_SS', 48;
  'IK_SS', 49;
  'NC_SS', 50;
  'NH_SS', 51;
  'QQ_SS', 52;
};
M_.params(21) = 1.15;
X_SS = M_.params(21);
M_.params(34) = 1.15;
XW_SS = M_.params(34);
M_.params(1) = 0.9925;
BETA = M_.params(1);
M_.params(2) = 0.97;
BETA1 = M_.params(2);
M_.params(4) = 0.12;
JEI = M_.params(4);
M_.params(5) = 0.35;
MUC = M_.params(5);
M_.params(6) = 0.10;
MUH = M_.params(6);
M_.params(33) = 0.10;
KAPPA = M_.params(33);
M_.params(43) = 0.10;
MUBB = M_.params(43);
M_.params(7) = 0.025;
DKC = M_.params(7);
M_.params(8) = 0.03;
DKH = M_.params(8);
M_.params(9) = 0.01;
DH = M_.params(9);
M_.params(3) = 0.85;
M = M_.params(3);
M_.params(30) = 0.975;
RHO_AS = M_.params(30);
M_.params(16) = 0.79343;
ALPHA = M_.params(16);
M_.params(12) = 0.31423;
EC = M_.params(12);
M_.params(13) = 0.56897;
EC1 = M_.params(13);
M_.params(10) = 0.52381;
ETA = M_.params(10);
M_.params(11) = 0.50602;
ETA1 = M_.params(11);
M_.params(14) = 14.47013;
FIKC = M_.params(14);
M_.params(15) = 11.02808;
FIKH = M_.params(15);
M_.params(22) = 0.69106;
LAGP = M_.params(22);
M_.params(37) = 0.08301;
LAGWC = M_.params(37);
M_.params(38) = 0.41186;
LAGWH = M_.params(38);
M_.params(31) = (-0.6833);
NU = M_.params(31);
M_.params(32) = (-0.96538);
NU1 = M_.params(32);
M_.params(20) = 1.40444;
TAYLOR_P = M_.params(20);
M_.params(18) = 0.59913;
TAYLOR_R = M_.params(18);
M_.params(19) = 0.51261;
TAYLOR_Y = M_.params(19);
M_.params(17) = 0.83671;
TETA = M_.params(17);
M_.params(35) = 0.79204;
TETAWC = M_.params(35);
M_.params(36) = 0.91181;
TETAWH = M_.params(36);
M_.params(40) = 0.0032;
TREND_AC = M_.params(40);
M_.params(41) = 0.0008;
TREND_AH = M_.params(41);
M_.params(42) = 0.00275;
TREND_AK = M_.params(42);
M_.params(39) = 0.70394;
ZETAKC = M_.params(39);
M_.params(23) = 0.94265;
RHO_AC = M_.params(23);
M_.params(24) = 0.99713;
RHO_AH = M_.params(24);
M_.params(25) = 0.95875;
RHO_AJ = M_.params(25);
M_.params(26) = 0.92384;
RHO_AK = M_.params(26);
M_.params(28) = 0.92158;
RHO_AT = M_.params(28);
M_.params(29) = 0.96439;
RHO_AZ = M_.params(29);
STDERR_AC	=	0.01011	;
STDERR_AE	=	0.00336	;
STDERR_AH	=	0.01942	;
STDERR_AJ	=	0.04094	;
STDERR_AK	=	0.01068	;
STDERR_AP	=	0.00457	;
STDERR_AS	=	0.00034*100	;
STDERR_AT	=	0.0252	;
STDERR_AZ	=	0.01711	;
DO_IRFS        = 0 ; 
DO_ESTIMATION  = 1 ; 
steady;
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (STDERR_AC)^2;
M_.Sigma_e(2, 2) = (STDERR_AE)^2;
M_.Sigma_e(3, 3) = (STDERR_AH)^2;
M_.Sigma_e(4, 4) = (STDERR_AJ)^2;
M_.Sigma_e(5, 5) = (STDERR_AK)^2;
M_.Sigma_e(6, 6) = (STDERR_AP)^2;
M_.Sigma_e(7, 7) = (STDERR_AS)^2;
M_.Sigma_e(8, 8) = (STDERR_AT)^2;
M_.Sigma_e(9, 9) = (STDERR_AZ)^2;
if DO_IRFS==1;
options_.irf = 20;
options_.order = 1;
var_list_ = {'rc_obs';'rbi_obs';'rri_obs';'hp_r_obs';'gdpl_rgd_obs';'i_nom_obs'};
[info, oo_, options_, M_] = stoch_simul(M_, options_, oo_, var_list_);
end;
estim_params_.var_exo = zeros(0, 10);
estim_params_.var_endo = zeros(0, 10);
estim_params_.corrx = zeros(0, 11);
estim_params_.corrn = zeros(0, 11);
estim_params_.param_vals = zeros(0, 10);
estim_params_.var_exo = [estim_params_.var_exo; 1, 0.0100, 0, Inf, 4, 0.001, 0.01, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, 0.0032, 0, Inf, 4, 0.001, 0.01, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 3, 0.0193, 0, Inf, 4, 0.001, 0.01, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 4, 0.0390, 0, Inf, 4, 0.001, 0.01, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 5, 0.0115, 0, Inf, 4, 0.001, 0.01, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 6, 0.0045, 0, Inf, 4, 0.001, 0.01, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 7, 0.0300, 0, Inf, 4, 0.100, 1.00, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 8, 0.0230, 0, Inf, 4, 0.001, 0.01, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 9, 0.0170, 0, Inf, 4, 0.001, 0.01, NaN, NaN, NaN ];
estim_params_.var_endo = [estim_params_.var_endo; 16, 0.1211, 0, Inf, 4, 0.001, 0.01, NaN, NaN, NaN ];
estim_params_.var_endo = [estim_params_.var_endo; 20, 0.0070, 0, Inf, 4, 0.001, 0.01, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 16, 0.7970, 0, 1, 1, 0.65, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 12, 0.3117, 0, 0.99, 1, 0.50, 0.075, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 13, 0.5749, 0, 0.99, 1, 0.50, 0.075, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 10, 0.4789, 0, Inf, 2, 0.50, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 11, 0.4738, 0, Inf, 2, 0.50, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 14, 16.0126, 0, Inf, 2, 10, 2.5, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 15, 10.0026, 0, Inf, 2, 10, 2.5, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 22, 0.6961, 0, 1, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 37, 0.0656, 0, 1, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 38, 0.4134, 0, 1, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 31, (-0.7523), NaN, NaN, 3, (-1), 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 32, (-0.9790), NaN, NaN, 3, (-1), 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 23, 0.9480, NaN, NaN, 1, 0.80, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 24, 0.9980, NaN, NaN, 1, 0.80, 0.09, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 25, 0.9604, NaN, NaN, 1, 0.80, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 26, 0.9256, NaN, NaN, 1, 0.80, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 28, 0.9259, NaN, NaN, 1, 0.80, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 29, 0.9714, NaN, NaN, 1, 0.80, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 20, 1.3743, 0, Inf, 3, 1.5, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 18, 0.6071, 0, Inf, 1, 0.75, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 19, 0.4938, 0, Inf, 3, 0, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 17, 0.8393, 0, 0.999, 1, 0.667, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 35, 0.7901, 0, 0.999, 1, 0.667, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 36, 0.9218, 0, 0.999, 1, 0.667, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 40, 0.0032, NaN, NaN, 3, 0.005, 0.01, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 41, 0.0008, NaN, NaN, 3, 0.005, 0.01, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 42, 0.0027, NaN, NaN, 3, 0.005, 0.01, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 39, 0.7469, 0, 0.999, 1, 0.50, 0.20, NaN, NaN, NaN ];
options_.trend_coeff = {};
tmp1 = strmatch('hp_r_obs',options_.varobs,'exact');
options_.trend_coeffs{tmp1} = 'M_.params(40)*(1-M_.params(6)-M_.params(43))+M_.params(42)*M_.params(5)*(1-M_.params(6)-M_.params(43))/(1-M_.params(5))-(1-M_.params(6)-M_.params(43)-M_.params(33))*M_.params(41)';
tmp1 = strmatch('rbi_obs',options_.varobs,'exact');
options_.trend_coeffs{tmp1} = 'M_.params(40)+M_.params(42)*1/(1-M_.params(5))';
tmp1 = strmatch('rc_obs',options_.varobs,'exact');
options_.trend_coeffs{tmp1} = 'M_.params(40)+M_.params(5)/(1-M_.params(5))*M_.params(42)';
tmp1 = strmatch('rri_obs',options_.varobs,'exact');
options_.trend_coeffs{tmp1} = 'M_.params(40)*(M_.params(6)+M_.params(43))+(1-M_.params(6)-M_.params(43)-M_.params(33))*M_.params(41)+M_.params(42)*M_.params(5)*(M_.params(6)+M_.params(43))/(1-M_.params(5))';
options_.bayesian_irf = true;
options_.forecast = 40;
options_.mh_drop = 0.3;
options_.mh_nblck = 1;
options_.mh_replic = 1000000;
options_.mh_tune_jscale.status = true;
options_.mh_tune_jscale.target = 0.3;
options_.mode_check.status = true;
options_.mode_compute = 6;
options_.nodisplay = true;
options_.order = 1;
options_.prefilter = 0;
options_.presample = 4;
options_.prior_trunc = 0;
options_.smoother = true;
options_.sub_draws = 1000;
options_.datafile = 'data_20210209';
options_.xls_range = 'B1:AY100';
options_.xls_sheet = 's1';
var_list_ = {'gdpl_rgd_obs';'pi_dm_obs'};
oo_recursive_=dynare_estimation(var_list_);
save('IN10_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('IN10_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('IN10_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('IN10_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('IN10_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('IN10_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('IN10_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
