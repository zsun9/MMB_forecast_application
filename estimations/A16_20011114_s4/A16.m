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
M_.fname = 'A16';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('A16.log');
M_.exo_names = 'eps_z';
M_.exo_names_tex = 'eps\_z';
M_.exo_names_long = 'eps_z';
M_.exo_names = char(M_.exo_names, 'eps_g');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_g');
M_.exo_names_long = char(M_.exo_names_long, 'eps_g');
M_.exo_names = char(M_.exo_names, 'eps_i');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_i');
M_.exo_names_long = char(M_.exo_names_long, 'eps_i');
M_.exo_names = char(M_.exo_names, 'eps_tau');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_tau');
M_.exo_names_long = char(M_.exo_names_long, 'eps_tau');
M_.exo_names = char(M_.exo_names, 'eps_tau_trans');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_tau\_trans');
M_.exo_names_long = char(M_.exo_names_long, 'eps_tau_trans');
M_.exo_names = char(M_.exo_names, 'eps_phi');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_phi');
M_.exo_names_long = char(M_.exo_names_long, 'eps_phi');
M_.exo_names = char(M_.exo_names, 'eps_beta');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_beta');
M_.exo_names_long = char(M_.exo_names_long, 'eps_beta');
M_.exo_names = char(M_.exo_names, 'eps_p');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_p');
M_.exo_names_long = char(M_.exo_names_long, 'eps_p');
M_.exo_names = char(M_.exo_names, 'eps_w');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_w');
M_.exo_names_long = char(M_.exo_names_long, 'eps_w');
M_.exo_names = char(M_.exo_names, 'eps_meas');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_meas');
M_.exo_names_long = char(M_.exo_names_long, 'eps_meas');
M_.exo_names = char(M_.exo_names, 'eps_meas_sp');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_meas\_sp');
M_.exo_names_long = char(M_.exo_names_long, 'eps_meas_sp');
M_.endo_names = 'AI';
M_.endo_names_tex = 'AI';
M_.endo_names_long = 'AI';
M_.endo_names = char(M_.endo_names, 'AIK');
M_.endo_names_tex = char(M_.endo_names_tex, 'AIK');
M_.endo_names_long = char(M_.endo_names_long, 'AIK');
M_.endo_names = char(M_.endo_names, 'AIS');
M_.endo_names_tex = char(M_.endo_names_tex, 'AIS');
M_.endo_names_long = char(M_.endo_names_long, 'AIS');
M_.endo_names = char(M_.endo_names, 'A_eff');
M_.endo_names_tex = char(M_.endo_names_tex, 'A\_eff');
M_.endo_names_long = char(M_.endo_names_long, 'A_eff');
M_.endo_names = char(M_.endo_names, 'Ak_over_P');
M_.endo_names_tex = char(M_.endo_names_tex, 'Ak\_over\_P');
M_.endo_names_long = char(M_.endo_names_long, 'Ak_over_P');
M_.endo_names = char(M_.endo_names, 'B_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'B\_t');
M_.endo_names_long = char(M_.endo_names_long, 'B_t');
M_.endo_names = char(M_.endo_names, 'BoY_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'BoY\_t');
M_.endo_names_long = char(M_.endo_names_long, 'BoY_t');
M_.endo_names = char(M_.endo_names, 'CASH_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'CASH\_t');
M_.endo_names_long = char(M_.endo_names_long, 'CASH_t');
M_.endo_names = char(M_.endo_names, 'D_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'D\_t');
M_.endo_names_long = char(M_.endo_names_long, 'D_t');
M_.endo_names = char(M_.endo_names, 'Delta_N');
M_.endo_names_tex = char(M_.endo_names_tex, 'Delta\_N');
M_.endo_names_long = char(M_.endo_names_long, 'Delta_N');
M_.endo_names = char(M_.endo_names, 'FGS');
M_.endo_names_tex = char(M_.endo_names_tex, 'FGS');
M_.endo_names_long = char(M_.endo_names_long, 'FGS');
M_.endo_names = char(M_.endo_names, 'FGS_num');
M_.endo_names_tex = char(M_.endo_names_tex, 'FGS\_num');
M_.endo_names_long = char(M_.endo_names_long, 'FGS_num');
M_.endo_names = char(M_.endo_names, 'fgs_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'fgs\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'fgs_obs');
M_.endo_names = char(M_.endo_names, 'FGSgap_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'FGSgap\_t');
M_.endo_names_long = char(M_.endo_names_long, 'FGSgap_t');
M_.endo_names = char(M_.endo_names, 'GDP_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'GDP\_t');
M_.endo_names_long = char(M_.endo_names_long, 'GDP_t');
M_.endo_names = char(M_.endo_names, 'Ihat');
M_.endo_names_tex = char(M_.endo_names_tex, 'Ihat');
M_.endo_names_long = char(M_.endo_names_long, 'Ihat');
M_.endo_names = char(M_.endo_names, 'Kbar');
M_.endo_names_tex = char(M_.endo_names_tex, 'Kbar');
M_.endo_names_long = char(M_.endo_names_long, 'Kbar');
M_.endo_names = char(M_.endo_names, 'LIQS_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'LIQS\_t');
M_.endo_names_long = char(M_.endo_names_long, 'LIQS_t');
M_.endo_names = char(M_.endo_names, 'N_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'N\_t');
M_.endo_names_long = char(M_.endo_names_long, 'N_t');
M_.endo_names = char(M_.endo_names, 'QK');
M_.endo_names_tex = char(M_.endo_names_tex, 'QK');
M_.endo_names_long = char(M_.endo_names_long, 'QK');
M_.endo_names = char(M_.endo_names, 'Q_t_A');
M_.endo_names_tex = char(M_.endo_names_tex, 'Q\_t\_A');
M_.endo_names_long = char(M_.endo_names_long, 'Q_t_A');
M_.endo_names = char(M_.endo_names, 'Q_t_B');
M_.endo_names_tex = char(M_.endo_names_tex, 'Q\_t\_B');
M_.endo_names_long = char(M_.endo_names_long, 'Q_t_B');
M_.endo_names = char(M_.endo_names, 'QtilK_iota_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'QtilK\_iota\_t');
M_.endo_names_long = char(M_.endo_names_long, 'QtilK_iota_t');
M_.endo_names = char(M_.endo_names, 'QtilS_iota_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'QtilS\_iota\_t');
M_.endo_names_long = char(M_.endo_names_long, 'QtilS_iota_t');
M_.endo_names = char(M_.endo_names, 'S');
M_.endo_names_tex = char(M_.endo_names_tex, 'S');
M_.endo_names_long = char(M_.endo_names_long, 'S');
M_.endo_names = char(M_.endo_names, 'SMG');
M_.endo_names_tex = char(M_.endo_names_tex, 'SMG');
M_.endo_names_long = char(M_.endo_names_long, 'SMG');
M_.endo_names = char(M_.endo_names, 'SMG_bar');
M_.endo_names_tex = char(M_.endo_names_tex, 'SMG\_bar');
M_.endo_names_long = char(M_.endo_names_long, 'SMG_bar');
M_.endo_names = char(M_.endo_names, 'SMGm1');
M_.endo_names_tex = char(M_.endo_names_tex, 'SMGm1');
M_.endo_names_long = char(M_.endo_names_long, 'SMGm1');
M_.endo_names = char(M_.endo_names, 'SMGm2');
M_.endo_names_tex = char(M_.endo_names_tex, 'SMGm2');
M_.endo_names_long = char(M_.endo_names_long, 'SMGm2');
M_.endo_names = char(M_.endo_names, 'SMGm3');
M_.endo_names_tex = char(M_.endo_names_tex, 'SMGm3');
M_.endo_names_long = char(M_.endo_names_long, 'SMGm3');
M_.endo_names = char(M_.endo_names, 'baag10_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'baag10\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'baag10_obs');
M_.endo_names = char(M_.endo_names, 'Spread_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'Spread\_t');
M_.endo_names_long = char(M_.endo_names_long, 'Spread_t');
M_.endo_names = char(M_.endo_names, 'Spreadgap_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'Spreadgap\_t');
M_.endo_names_long = char(M_.endo_names_long, 'Spreadgap_t');
M_.endo_names = char(M_.endo_names, 'Sprime');
M_.endo_names_tex = char(M_.endo_names_tex, 'Sprime');
M_.endo_names_long = char(M_.endo_names_long, 'Sprime');
M_.endo_names = char(M_.endo_names, 'T_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'T\_t');
M_.endo_names_long = char(M_.endo_names_long, 'T_t');
M_.endo_names = char(M_.endo_names, 'ToY_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'ToY\_t');
M_.endo_names_long = char(M_.endo_names_long, 'ToY_t');
M_.endo_names = char(M_.endo_names, 'beta_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'beta\_t');
M_.endo_names_long = char(M_.endo_names_long, 'beta_t');
M_.endo_names = char(M_.endo_names, 'chat');
M_.endo_names_tex = char(M_.endo_names_tex, 'chat');
M_.endo_names_long = char(M_.endo_names_long, 'chat');
M_.endo_names = char(M_.endo_names, 'chi_k');
M_.endo_names_tex = char(M_.endo_names_tex, 'chi\_k');
M_.endo_names_long = char(M_.endo_names_long, 'chi_k');
M_.endo_names = char(M_.endo_names, 'chi_s');
M_.endo_names_tex = char(M_.endo_names_tex, 'chi\_s');
M_.endo_names_long = char(M_.endo_names_long, 'chi_s');
M_.endo_names = char(M_.endo_names, 'chi_spk');
M_.endo_names_tex = char(M_.endo_names_tex, 'chi\_spk');
M_.endo_names_long = char(M_.endo_names_long, 'chi_spk');
M_.endo_names = char(M_.endo_names, 'chi_w');
M_.endo_names_tex = char(M_.endo_names_tex, 'chi\_w');
M_.endo_names_long = char(M_.endo_names_long, 'chi_w');
M_.endo_names = char(M_.endo_names, 'ctau_q_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'ctau\_q\_t');
M_.endo_names_long = char(M_.endo_names_long, 'ctau_q_t');
M_.endo_names = char(M_.endo_names, 'd_FGS_num');
M_.endo_names_tex = char(M_.endo_names_tex, 'd\_FGS\_num');
M_.endo_names_long = char(M_.endo_names_long, 'd_FGS_num');
M_.endo_names = char(M_.endo_names, 'gdp_rgd_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'gdp\_rgd\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'gdp_rgd_obs');
M_.endo_names = char(M_.endo_names, 'd_GDPm1');
M_.endo_names_tex = char(M_.endo_names_tex, 'd\_GDPm1');
M_.endo_names_long = char(M_.endo_names_long, 'd_GDPm1');
M_.endo_names = char(M_.endo_names, 'd_GDPm2');
M_.endo_names_tex = char(M_.endo_names_tex, 'd\_GDPm2');
M_.endo_names_long = char(M_.endo_names_long, 'd_GDPm2');
M_.endo_names = char(M_.endo_names, 'd_GDPm3');
M_.endo_names_tex = char(M_.endo_names_tex, 'd\_GDPm3');
M_.endo_names_long = char(M_.endo_names_long, 'd_GDPm3');
M_.endo_names = char(M_.endo_names, 'i_A16_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'i\_A16\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'i_A16_obs');
M_.endo_names = char(M_.endo_names, 'cnds_nom_demean_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'cnds\_nom\_demean\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'cnds_nom_demean_obs');
M_.endo_names = char(M_.endo_names, 'wage_rgd_demean_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'wage\_rgd\_demean\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'wage_rgd_demean_obs');
M_.endo_names = char(M_.endo_names, 'eta_beta');
M_.endo_names_tex = char(M_.endo_names_tex, 'eta\_beta');
M_.endo_names_long = char(M_.endo_names_long, 'eta_beta');
M_.endo_names = char(M_.endo_names, 'etau_q_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'etau\_q\_t');
M_.endo_names_long = char(M_.endo_names_long, 'etau_q_t');
M_.endo_names = char(M_.endo_names, 'e_p');
M_.endo_names_tex = char(M_.endo_names_tex, 'e\_p');
M_.endo_names_long = char(M_.endo_names_long, 'e_p');
M_.endo_names = char(M_.endo_names, 'e_w');
M_.endo_names_tex = char(M_.endo_names_tex, 'e\_w');
M_.endo_names_long = char(M_.endo_names_long, 'e_w');
M_.endo_names = char(M_.endo_names, 'g_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'g\_t');
M_.endo_names_long = char(M_.endo_names_long, 'g_t');
M_.endo_names = char(M_.endo_names, 'ffr_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'ffr\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'ffr_obs');
M_.endo_names = char(M_.endo_names, 'i_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'i\_t');
M_.endo_names_long = char(M_.endo_names_long, 'i_t');
M_.endo_names = char(M_.endo_names, 'invQ_til_As');
M_.endo_names_tex = char(M_.endo_names_tex, 'invQ\_til\_As');
M_.endo_names_long = char(M_.endo_names_long, 'invQ_til_As');
M_.endo_names = char(M_.endo_names, 'iota_k');
M_.endo_names_tex = char(M_.endo_names_tex, 'iota\_k');
M_.endo_names_long = char(M_.endo_names_long, 'iota_k');
M_.endo_names = char(M_.endo_names, 'iota_s');
M_.endo_names_tex = char(M_.endo_names_tex, 'iota\_s');
M_.endo_names_long = char(M_.endo_names_long, 'iota_s');
M_.endo_names = char(M_.endo_names, 'iota_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'iota\_t');
M_.endo_names_long = char(M_.endo_names_long, 'iota_t');
M_.endo_names = char(M_.endo_names, 'l');
M_.endo_names_tex = char(M_.endo_names_tex, 'l');
M_.endo_names_long = char(M_.endo_names_long, 'l');
M_.endo_names = char(M_.endo_names, 'hours_A16_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'hours\_A16\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'hours_A16_obs');
M_.endo_names = char(M_.endo_names, 'lambda_p_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'lambda\_p\_t');
M_.endo_names_long = char(M_.endo_names_long, 'lambda_p_t');
M_.endo_names = char(M_.endo_names, 'lambda_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'lambda\_t');
M_.endo_names_long = char(M_.endo_names_long, 'lambda_t');
M_.endo_names = char(M_.endo_names, 'lambda_w_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'lambda\_w\_t');
M_.endo_names_long = char(M_.endo_names_long, 'lambda_w_t');
M_.endo_names = char(M_.endo_names, 'mchat');
M_.endo_names_tex = char(M_.endo_names_tex, 'mchat');
M_.endo_names_long = char(M_.endo_names_long, 'mchat');
M_.endo_names = char(M_.endo_names, 'phi_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'phi\_t');
M_.endo_names_long = char(M_.endo_names_long, 'phi_t');
M_.endo_names = char(M_.endo_names, 'gdpdef_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'gdpdef\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'gdpdef_obs');
M_.endo_names = char(M_.endo_names, 'pi_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'pi\_t');
M_.endo_names_long = char(M_.endo_names_long, 'pi_t');
M_.endo_names = char(M_.endo_names, 'pi_tm1');
M_.endo_names_tex = char(M_.endo_names_tex, 'pi\_tm1');
M_.endo_names_long = char(M_.endo_names_long, 'pi_tm1');
M_.endo_names = char(M_.endo_names, 'pi_tm2');
M_.endo_names_tex = char(M_.endo_names_tex, 'pi\_tm2');
M_.endo_names_long = char(M_.endo_names_long, 'pi_tm2');
M_.endo_names = char(M_.endo_names, 'pi_tm3');
M_.endo_names_tex = char(M_.endo_names_tex, 'pi\_tm3');
M_.endo_names_long = char(M_.endo_names_long, 'pi_tm3');
M_.endo_names = char(M_.endo_names, 'pistar');
M_.endo_names_tex = char(M_.endo_names_tex, 'pistar');
M_.endo_names_long = char(M_.endo_names_long, 'pistar');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names_long = char(M_.endo_names_long, 'r');
M_.endo_names = char(M_.endo_names, 'rK');
M_.endo_names_tex = char(M_.endo_names_tex, 'rK');
M_.endo_names_long = char(M_.endo_names_long, 'rK');
M_.endo_names = char(M_.endo_names, 'sdf');
M_.endo_names_tex = char(M_.endo_names_tex, 'sdf');
M_.endo_names_long = char(M_.endo_names_long, 'sdf');
M_.endo_names = char(M_.endo_names, 'sdfr');
M_.endo_names_tex = char(M_.endo_names_tex, 'sdfr');
M_.endo_names_long = char(M_.endo_names_long, 'sdfr');
M_.endo_names = char(M_.endo_names, 'sg');
M_.endo_names_tex = char(M_.endo_names_tex, 'sg');
M_.endo_names_long = char(M_.endo_names_long, 'sg');
M_.endo_names = char(M_.endo_names, 'tau_q_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'tau\_q\_t');
M_.endo_names_long = char(M_.endo_names_long, 'tau_q_t');
M_.endo_names = char(M_.endo_names, 'what_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'what\_t');
M_.endo_names_long = char(M_.endo_names_long, 'what_t');
M_.endo_names = char(M_.endo_names, 'ygap_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'ygap\_t');
M_.endo_names_long = char(M_.endo_names_long, 'ygap_t');
M_.endo_names = char(M_.endo_names, 'yhat');
M_.endo_names_tex = char(M_.endo_names_tex, 'yhat');
M_.endo_names_long = char(M_.endo_names_long, 'yhat');
M_.endo_names = char(M_.endo_names, 'z_t');
M_.endo_names_tex = char(M_.endo_names_tex, 'z\_t');
M_.endo_names_long = char(M_.endo_names_long, 'z_t');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_494');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_494');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_494');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_508');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_508');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_508');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_800');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_800');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_800');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_813');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_813');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_813');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_857');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_857');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_857');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_871');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_871');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_871');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_70_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_70\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_70_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_70_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_70\_2');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_70_2');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_44_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_44\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_44_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_44_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_44\_2');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_44_2');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_82_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_82\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_82_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_83_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_83\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_83_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_13_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_13\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_13_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_12_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_12\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_12_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_32_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_32\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_32_1');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_30_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_30\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_30_1');
M_.endo_partitions = struct();
M_.param_names = 'gam_s';
M_.param_names_tex = 'gam\_s';
M_.param_names_long = 'gam_s';
M_.param_names = char(M_.param_names, 'bet_s');
M_.param_names_tex = char(M_.param_names_tex, 'bet\_s');
M_.param_names_long = char(M_.param_names_long, 'bet_s');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'nu');
M_.param_names_tex = char(M_.param_names_tex, 'nu');
M_.param_names_long = char(M_.param_names_long, 'nu');
M_.param_names = char(M_.param_names, 'h');
M_.param_names_tex = char(M_.param_names_tex, 'h');
M_.param_names_long = char(M_.param_names_long, 'h');
M_.param_names = char(M_.param_names, 'l_ss');
M_.param_names_tex = char(M_.param_names_tex, 'l\_ss');
M_.param_names_long = char(M_.param_names_long, 'l_ss');
M_.param_names = char(M_.param_names, 'eta');
M_.param_names_tex = char(M_.param_names_tex, 'eta');
M_.param_names_long = char(M_.param_names_long, 'eta');
M_.param_names = char(M_.param_names, 'lambda_p');
M_.param_names_tex = char(M_.param_names_tex, 'lambda\_p');
M_.param_names_long = char(M_.param_names_long, 'lambda_p');
M_.param_names = char(M_.param_names, 'xi_p');
M_.param_names_tex = char(M_.param_names_tex, 'xi\_p');
M_.param_names_long = char(M_.param_names_long, 'xi_p');
M_.param_names = char(M_.param_names, 'iota_p');
M_.param_names_tex = char(M_.param_names_tex, 'iota\_p');
M_.param_names_long = char(M_.param_names_long, 'iota_p');
M_.param_names = char(M_.param_names, 'lambda_w');
M_.param_names_tex = char(M_.param_names_tex, 'lambda\_w');
M_.param_names_long = char(M_.param_names_long, 'lambda_w');
M_.param_names = char(M_.param_names, 'xi_w');
M_.param_names_tex = char(M_.param_names_tex, 'xi\_w');
M_.param_names_long = char(M_.param_names_long, 'xi_w');
M_.param_names = char(M_.param_names, 'iota_w');
M_.param_names_tex = char(M_.param_names_tex, 'iota\_w');
M_.param_names_long = char(M_.param_names_long, 'iota_w');
M_.param_names = char(M_.param_names, 'mu_ss');
M_.param_names_tex = char(M_.param_names_tex, 'mu\_ss');
M_.param_names_long = char(M_.param_names_long, 'mu_ss');
M_.param_names = char(M_.param_names, 'sg_ss');
M_.param_names_tex = char(M_.param_names_tex, 'sg\_ss');
M_.param_names_long = char(M_.param_names_long, 'sg_ss');
M_.param_names = char(M_.param_names, 'fgs_param');
M_.param_names_tex = char(M_.param_names_tex, 'fgs\_param');
M_.param_names_long = char(M_.param_names_long, 'fgs_param');
M_.param_names = char(M_.param_names, 'theta');
M_.param_names_tex = char(M_.param_names_tex, 'theta');
M_.param_names_long = char(M_.param_names_long, 'theta');
M_.param_names = char(M_.param_names, 'Bs_ss');
M_.param_names_tex = char(M_.param_names_tex, 'Bs\_ss');
M_.param_names_long = char(M_.param_names_long, 'Bs_ss');
M_.param_names = char(M_.param_names, 'gs_ss');
M_.param_names_tex = char(M_.param_names_tex, 'gs\_ss');
M_.param_names_long = char(M_.param_names_long, 'gs_ss');
M_.param_names = char(M_.param_names, 'etau_q_ss');
M_.param_names_tex = char(M_.param_names_tex, 'etau\_q\_ss');
M_.param_names_long = char(M_.param_names_long, 'etau_q_ss');
M_.param_names = char(M_.param_names, 'theta_I');
M_.param_names_tex = char(M_.param_names_tex, 'theta\_I');
M_.param_names_long = char(M_.param_names_long, 'theta_I');
M_.param_names = char(M_.param_names, 'pis');
M_.param_names_tex = char(M_.param_names_tex, 'pis');
M_.param_names_long = char(M_.param_names_long, 'pis');
M_.param_names = char(M_.param_names, 'rho_i');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_i');
M_.param_names_long = char(M_.param_names_long, 'rho_i');
M_.param_names = char(M_.param_names, 'phi_pi');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_pi');
M_.param_names_long = char(M_.param_names_long, 'phi_pi');
M_.param_names = char(M_.param_names, 'phi_DY');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_DY');
M_.param_names_long = char(M_.param_names_long, 'phi_DY');
M_.param_names = char(M_.param_names, 'phi_Ygap');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_Ygap');
M_.param_names_long = char(M_.param_names_long, 'phi_Ygap');
M_.param_names = char(M_.param_names, 'tB');
M_.param_names_tex = char(M_.param_names_tex, 'tB');
M_.param_names_long = char(M_.param_names_long, 'tB');
M_.param_names = char(M_.param_names, 'rho_z');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_z');
M_.param_names_long = char(M_.param_names_long, 'rho_z');
M_.param_names = char(M_.param_names, 'rho_g');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_g');
M_.param_names_long = char(M_.param_names_long, 'rho_g');
M_.param_names = char(M_.param_names, 'rho_tau');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_tau');
M_.param_names_long = char(M_.param_names_long, 'rho_tau');
M_.param_names = char(M_.param_names, 'decay');
M_.param_names_tex = char(M_.param_names_tex, 'decay');
M_.param_names_long = char(M_.param_names_long, 'decay');
M_.param_names = char(M_.param_names, 'rho_beta');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_beta');
M_.param_names_long = char(M_.param_names_long, 'rho_beta');
M_.param_names = char(M_.param_names, 'rho_p');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_p');
M_.param_names_long = char(M_.param_names_long, 'rho_p');
M_.param_names = char(M_.param_names, 'rho_w');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_w');
M_.param_names_long = char(M_.param_names_long, 'rho_w');
M_.param_names = char(M_.param_names, 'theta_p');
M_.param_names_tex = char(M_.param_names_tex, 'theta\_p');
M_.param_names_long = char(M_.param_names_long, 'theta_p');
M_.param_names = char(M_.param_names, 'theta_w');
M_.param_names_tex = char(M_.param_names_tex, 'theta\_w');
M_.param_names_long = char(M_.param_names_long, 'theta_w');
M_.param_names = char(M_.param_names, 's_z');
M_.param_names_tex = char(M_.param_names_tex, 's\_z');
M_.param_names_long = char(M_.param_names_long, 's_z');
M_.param_names = char(M_.param_names, 's_g');
M_.param_names_tex = char(M_.param_names_tex, 's\_g');
M_.param_names_long = char(M_.param_names_long, 's_g');
M_.param_names = char(M_.param_names, 's_i');
M_.param_names_tex = char(M_.param_names_tex, 's\_i');
M_.param_names_long = char(M_.param_names_long, 's_i');
M_.param_names = char(M_.param_names, 's_tau');
M_.param_names_tex = char(M_.param_names_tex, 's\_tau');
M_.param_names_long = char(M_.param_names_long, 's_tau');
M_.param_names = char(M_.param_names, 's_tau_trans');
M_.param_names_tex = char(M_.param_names_tex, 's\_tau\_trans');
M_.param_names_long = char(M_.param_names_long, 's_tau_trans');
M_.param_names = char(M_.param_names, 's_phi');
M_.param_names_tex = char(M_.param_names_tex, 's\_phi');
M_.param_names_long = char(M_.param_names_long, 's_phi');
M_.param_names = char(M_.param_names, 's_sg');
M_.param_names_tex = char(M_.param_names_tex, 's\_sg');
M_.param_names_long = char(M_.param_names_long, 's_sg');
M_.param_names = char(M_.param_names, 's_beta');
M_.param_names_tex = char(M_.param_names_tex, 's\_beta');
M_.param_names_long = char(M_.param_names_long, 's_beta');
M_.param_names = char(M_.param_names, 's_p');
M_.param_names_tex = char(M_.param_names_tex, 's\_p');
M_.param_names_long = char(M_.param_names_long, 's_p');
M_.param_names = char(M_.param_names, 's_w');
M_.param_names_tex = char(M_.param_names_tex, 's\_w');
M_.param_names_long = char(M_.param_names_long, 's_w');
M_.param_names = char(M_.param_names, 's_meas_sp');
M_.param_names_tex = char(M_.param_names_tex, 's\_meas\_sp');
M_.param_names_long = char(M_.param_names_long, 's_meas_sp');
M_.param_names = char(M_.param_names, 's_meas');
M_.param_names_tex = char(M_.param_names_tex, 's\_meas');
M_.param_names_long = char(M_.param_names_long, 's_meas');
M_.param_names = char(M_.param_names, 'rho_phi');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_phi');
M_.param_names_long = char(M_.param_names_long, 'rho_phi');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 11;
M_.endo_nbr = 101;
M_.param_nbr = 49;
M_.orig_endo_nbr = 85;
M_.aux_vars(1).endo_index = 86;
M_.aux_vars(1).type = 0;
M_.aux_vars(2).endo_index = 87;
M_.aux_vars(2).type = 0;
M_.aux_vars(3).endo_index = 88;
M_.aux_vars(3).type = 0;
M_.aux_vars(4).endo_index = 89;
M_.aux_vars(4).type = 0;
M_.aux_vars(5).endo_index = 90;
M_.aux_vars(5).type = 0;
M_.aux_vars(6).endo_index = 91;
M_.aux_vars(6).type = 0;
M_.aux_vars(7).endo_index = 92;
M_.aux_vars(7).type = 1;
M_.aux_vars(7).orig_index = 71;
M_.aux_vars(7).orig_lead_lag = -1;
M_.aux_vars(8).endo_index = 93;
M_.aux_vars(8).type = 1;
M_.aux_vars(8).orig_index = 71;
M_.aux_vars(8).orig_lead_lag = -2;
M_.aux_vars(9).endo_index = 94;
M_.aux_vars(9).type = 1;
M_.aux_vars(9).orig_index = 45;
M_.aux_vars(9).orig_lead_lag = -1;
M_.aux_vars(10).endo_index = 95;
M_.aux_vars(10).type = 1;
M_.aux_vars(10).orig_index = 45;
M_.aux_vars(10).orig_lead_lag = -2;
M_.aux_vars(11).endo_index = 96;
M_.aux_vars(11).type = 1;
M_.aux_vars(11).orig_index = 83;
M_.aux_vars(11).orig_lead_lag = -1;
M_.aux_vars(12).endo_index = 97;
M_.aux_vars(12).type = 1;
M_.aux_vars(12).orig_index = 84;
M_.aux_vars(12).orig_lead_lag = -1;
M_.aux_vars(13).endo_index = 98;
M_.aux_vars(13).type = 1;
M_.aux_vars(13).orig_index = 14;
M_.aux_vars(13).orig_lead_lag = -1;
M_.aux_vars(14).endo_index = 99;
M_.aux_vars(14).type = 1;
M_.aux_vars(14).orig_index = 13;
M_.aux_vars(14).orig_lead_lag = -1;
M_.aux_vars(15).endo_index = 100;
M_.aux_vars(15).type = 1;
M_.aux_vars(15).orig_index = 33;
M_.aux_vars(15).orig_lead_lag = -1;
M_.aux_vars(16).endo_index = 101;
M_.aux_vars(16).type = 1;
M_.aux_vars(16).orig_index = 31;
M_.aux_vars(16).orig_lead_lag = -1;
options_.varobs = cell(1);
options_.varobs(1)  = {'gdp_rgd_obs'};
options_.varobs(2)  = {'i_A16_obs'};
options_.varobs(3)  = {'cnds_nom_demean_obs'};
options_.varobs(4)  = {'wage_rgd_demean_obs'};
options_.varobs(5)  = {'gdpdef_obs'};
options_.varobs(6)  = {'ffr_obs'};
options_.varobs(7)  = {'hours_A16_obs'};
options_.varobs(8)  = {'baag10_obs'};
options_.varobs(9)  = {'fgs_obs'};
options_.varobs_id = [ 45 49 50 51 70 57 64 31 13  ];
M_.Sigma_e = zeros(11, 11);
M_.Correlation_matrix = eye(11, 11);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('A16_static');
erase_compiled_function('A16_dynamic');
M_.orig_eq_nbr = 85;
M_.eq_nbr = 101;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 48 0;
 0 49 0;
 0 50 0;
 0 51 0;
 0 52 149;
 1 53 0;
 0 54 0;
 0 55 0;
 0 56 0;
 0 57 0;
 0 58 0;
 2 59 0;
 3 60 150;
 4 61 151;
 5 62 0;
 6 63 152;
 7 64 0;
 0 65 0;
 8 66 0;
 0 67 153;
 0 68 154;
 9 69 155;
 0 70 0;
 0 71 0;
 0 72 0;
 10 73 0;
 0 74 0;
 11 75 0;
 12 76 0;
 0 77 0;
 13 78 156;
 0 79 0;
 14 80 157;
 0 81 158;
 0 82 0;
 0 83 0;
 0 84 0;
 15 85 159;
 0 86 160;
 0 87 161;
 0 88 0;
 0 89 162;
 16 90 0;
 0 91 0;
 17 92 0;
 18 93 0;
 19 94 0;
 0 95 0;
 0 96 0;
 0 97 0;
 0 98 0;
 20 99 0;
 21 100 0;
 22 101 0;
 23 102 0;
 24 103 0;
 0 104 0;
 25 105 0;
 0 106 163;
 0 107 0;
 0 108 0;
 0 109 0;
 0 110 0;
 0 111 0;
 26 112 0;
 27 113 0;
 28 114 0;
 0 115 0;
 29 116 164;
 0 117 0;
 30 118 165;
 31 119 0;
 32 120 0;
 0 121 0;
 0 122 0;
 33 123 0;
 0 124 166;
 0 125 167;
 0 126 168;
 0 127 0;
 0 128 0;
 34 129 169;
 35 130 170;
 36 131 171;
 37 132 172;
 0 133 173;
 0 134 174;
 0 135 175;
 0 136 176;
 0 137 177;
 0 138 178;
 38 139 0;
 39 140 0;
 40 141 0;
 41 142 0;
 42 143 0;
 43 144 0;
 44 145 0;
 45 146 0;
 46 147 0;
 47 148 0;]';
M_.nstatic = 37;
M_.nfwrd   = 17;
M_.npred   = 34;
M_.nboth   = 13;
M_.nsfwrd   = 30;
M_.nspred   = 47;
M_.ndynamic   = 64;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:11];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(101, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(11, 1);
M_.params = NaN(49, 1);
M_.NNZDerivatives = [449; -1; -1];
M_.params( 1 ) = 0.50;
gam_s = M_.params( 1 );
M_.params( 2 ) = 0.632;
bet_s = M_.params( 2 );
M_.params( 3 ) = 0.0250;
delta = M_.params( 3 );
M_.params( 4 ) = 2.38;
nu = M_.params( 4 );
M_.params( 5 ) = 0.843;
h = M_.params( 5 );
M_.params( 6 ) = 0;
l_ss = M_.params( 6 );
M_.params( 7 ) = 0.748;
eta = M_.params( 7 );
M_.params( 8 ) = 0.15;
lambda_p = M_.params( 8 );
M_.params( 9 ) = 0.813;
xi_p = M_.params( 9 );
M_.params( 10 ) = 0.203;
iota_p = M_.params( 10 );
M_.params( 11 ) = 0.15;
lambda_w = M_.params( 11 );
M_.params( 12 ) = 0.927;
xi_w = M_.params( 12 );
M_.params( 13 ) = 0.431;
iota_w = M_.params( 13 );
M_.params( 14 ) = 0;
mu_ss = M_.params( 14 );
M_.params( 15 ) = 0.0147;
sg_ss = M_.params( 15 );
M_.params( 16 ) = 0.35;
fgs_param = M_.params( 16 );
M_.params( 17 ) = 0.677;
theta = M_.params( 17 );
M_.params( 18 ) = 0.02;
Bs_ss = M_.params( 18 );
M_.params( 19 ) = 0.17;
gs_ss = M_.params( 19 );
M_.params( 20 ) = 3.52;
etau_q_ss = M_.params( 20 );
M_.params( 21 ) = 0.755;
theta_I = M_.params( 21 );
M_.params( 22 ) = 0.312;
pis = M_.params( 22 );
M_.params( 23 ) = 0.828;
rho_i = M_.params( 23 );
M_.params( 24 ) = 0.46;
phi_pi = M_.params( 24 );
M_.params( 25 ) = 0.156;
phi_DY = M_.params( 25 );
M_.params( 26 ) = 0;
phi_Ygap = M_.params( 26 );
M_.params( 27 ) = 0.236;
tB = M_.params( 27 );
M_.params( 28 ) = 0.379;
rho_z = M_.params( 28 );
M_.params( 29 ) = 0.996;
rho_g = M_.params( 29 );
M_.params( 30 ) = 0.986;
rho_tau = M_.params( 30 );
M_.params( 31 ) = 0.771;
decay = M_.params( 31 );
M_.params( 32 ) = 0.487;
rho_beta = M_.params( 32 );
M_.params( 33 ) = 0.707;
rho_p = M_.params( 33 );
M_.params( 34 ) = 0.159;
rho_w = M_.params( 34 );
M_.params( 35 ) = 0.194;
theta_p = M_.params( 35 );
M_.params( 36 ) = 0.148;
theta_w = M_.params( 36 );
M_.params( 37 ) = 0.601;
s_z = M_.params( 37 );
M_.params( 38 ) = 0.153;
s_g = M_.params( 38 );
M_.params( 39 ) = 0.121;
s_i = M_.params( 39 );
M_.params( 40 ) = 0.143;
s_tau = M_.params( 40 );
M_.params( 41 ) = 0.154;
s_tau_trans = M_.params( 41 );
M_.params( 42 ) = 0;
s_phi = M_.params( 42 );
M_.params( 43 ) = 0;
s_sg = M_.params( 43 );
M_.params( 44 ) = 2.37;
s_beta = M_.params( 44 );
M_.params( 45 ) = 0.069;
s_p = M_.params( 45 );
M_.params( 46 ) = 0.308;
s_w = M_.params( 46 );
M_.params( 47 ) = 0.025;
s_meas_sp = M_.params( 47 );
M_.params( 48 ) = 0.148;
s_meas = M_.params( 48 );
M_.params( 49 ) = 0.6250;
rho_phi = M_.params( 49 );
M_.params( 42 ) = 0;
s_phi = M_.params( 42 );
par_ss(1)   = gam_s;
par_ss(2)   = bet_s;
par_ss(3)   = delta;
par_ss(4)   = l_ss;
par_ss(5)   = nu;
par_ss(6)   = eta;
par_ss(7)   = gs_ss;
par_ss(8)   = pis;
par_ss(9)   = lambda_w;
par_ss(10)  = etau_q_ss;
par_ss(11)  = lambda_p;
par_ss(12)  = h;
par_ss(13)  = sg_ss;
par_ss(14)  = mu_ss;
par_ss(15)  = theta;
par_ss(16)  = fgs_param;
par_ss(17)  = Bs_ss;
x0=[  0.1971    0.8754   -0.0270   -1.4289   -6.0463 ];
options = optimset('MaxIter',10^6,'MaxFunEvals', 10^6,'Algorithm','interior-point','TolFun',10^-4,'TolX',10^-20,'TolCon',10^-6); 
[x,fval,exitflag] = fmincon(@(x) obj_dummy(x,par_ss),x0,[],[],[],[],[],[],@(x) SS_Ajello_AER16(x,par_ss),options);
[~, ~, stst] = SS_Ajello_AER16(x,par_ss);
for ie = 1:1
x0 = x;
filename = [ 'x_init' num2str(ie) '.mat' ];
save(filename,'x0');
end
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = M_.params(37)^2;
M_.Sigma_e(2, 2) = M_.params(38)^2;
M_.Sigma_e(3, 3) = M_.params(39)^2;
M_.Sigma_e(4, 4) = M_.params(40)^2;
M_.Sigma_e(5, 5) = M_.params(41)^2;
M_.Sigma_e(6, 6) = M_.params(42)^2;
M_.Sigma_e(7, 7) = M_.params(44)^2;
M_.Sigma_e(8, 8) = M_.params(45)^2;
M_.Sigma_e(9, 9) = M_.params(46)^2;
set_dynare_seed(cputime);
estim_params_.var_exo = zeros(0, 10);
estim_params_.var_endo = zeros(0, 10);
estim_params_.corrx = zeros(0, 11);
estim_params_.corrn = zeros(0, 11);
estim_params_.param_vals = zeros(0, 10);
estim_params_.var_exo = [estim_params_.var_exo; 1, 0.6142, NaN, NaN, 6, 0.50, 1, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, 0.1518, NaN, NaN, 6, 0.50, 1, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 3, 0.4441, NaN, NaN, 6, 0.10, 1, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 4, 0.2274, NaN, NaN, 6, 0.50, 1, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 5, 0.2491, NaN, NaN, 6, 0.50, 1, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 7, 1.1614, NaN, NaN, 6, 0.50, 1, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 8, 0.0641, NaN, NaN, 6, 0.10, 1, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 9, 0.2961, NaN, NaN, 6, 0.10, 1, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 10, 0.1, NaN, NaN, 6, 0.05, 0.05, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 11, 0.0300, NaN, NaN, 6, 0.05, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 2, 0.7549, NaN, NaN, 2, 0.75, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 4, 1.8823, NaN, NaN, 2, 2, 0.75, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 5, 0.7355, NaN, NaN, 1, 0.50, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 7, 0.7296, NaN, NaN, 1, 0.60, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 9, 0.8829, NaN, NaN, 1, 0.75, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 10, 0.0965, NaN, NaN, 1, 0.50, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 12, 0.8940, NaN, NaN, 1, 0.75, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 13, 0.4723, NaN, NaN, 1, 0.50, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 17, 0.5, NaN, NaN, 1, 0.75, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 21, 1.4534, NaN, NaN, 2, 4, 2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 22, 0.5893, NaN, NaN, 2, 0.50, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 23, 0.9525, NaN, NaN, 1, 0.85, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 24, 0.5689, NaN, NaN, 3, 0.70, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 25, 0.1152, NaN, NaN, 3, 0.125, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 27, 0.3, NaN, NaN, 2, 0.50, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 28, 0.3156, NaN, NaN, 1, 0.50, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 29, 0.9897, NaN, NaN, 1, 0.50, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 32, 0.6212, NaN, NaN, 1, 0.50, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 30, 0.95, NaN, NaN, 1, 0.50, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 31, 0.60, NaN, NaN, 1, 0.50, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 33, 0.6182, NaN, NaN, 1, 0.50, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 34, 0.1874, NaN, NaN, 1, 0.50, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 35, 0.2155, NaN, NaN, 1, 0.50, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 36, 0.1161, NaN, NaN, 1, 0.50, 0.20, NaN, NaN, NaN ];
tmp1 = find(estim_params_.param_vals(:,1)==2);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(2,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.6529;
end
tmp1 = find(estim_params_.param_vals(:,1)==4);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(4,:))))
else
    estim_params_.param_vals(tmp1,2) = 2.27;
end
tmp1 = find(estim_params_.param_vals(:,1)==5);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(5,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.84;
end
tmp1 = find(estim_params_.param_vals(:,1)==7);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(7,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.75;
end
tmp1 = find(estim_params_.param_vals(:,1)==9);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(9,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.80;
end
tmp1 = find(estim_params_.param_vals(:,1)==10);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(10,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.21;
end
tmp1 = find(estim_params_.param_vals(:,1)==12);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(12,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.92;
end
tmp1 = find(estim_params_.param_vals(:,1)==13);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(13,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.43;
end
tmp1 = find(estim_params_.param_vals(:,1)==17);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(17,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.68;
end
tmp1 = find(estim_params_.param_vals(:,1)==21);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(21,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.81;
end
tmp1 = find(estim_params_.param_vals(:,1)==22);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(22,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.34;
end
tmp1 = find(estim_params_.param_vals(:,1)==23);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(23,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.83;
end
tmp1 = find(estim_params_.param_vals(:,1)==24);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(24,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.41;
end
tmp1 = find(estim_params_.param_vals(:,1)==25);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(25,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.16;
end
tmp1 = find(estim_params_.param_vals(:,1)==27);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(27,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.235;
end
tmp1 = find(estim_params_.param_vals(:,1)==28);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(28,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.37;
end
tmp1 = find(estim_params_.param_vals(:,1)==29);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(29,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.99;
end
tmp1 = find(estim_params_.param_vals(:,1)==32);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(32,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.483;
end
tmp1 = find(estim_params_.param_vals(:,1)==30);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(30,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.986;
end
tmp1 = find(estim_params_.param_vals(:,1)==31);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(31,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.784;
end
tmp1 = find(estim_params_.param_vals(:,1)==33);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(33,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.737;
end
tmp1 = find(estim_params_.param_vals(:,1)==34);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(34,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.15;
end
tmp1 = find(estim_params_.param_vals(:,1)==35);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(35,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.172;
end
tmp1 = find(estim_params_.param_vals(:,1)==36);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(36,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.13;
end
tmp1 = find(estim_params_.var_exo(:,1)==1);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(1,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.29;
end
tmp1 = find(estim_params_.var_exo(:,1)==2);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(2,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.45;
end
tmp1 = find(estim_params_.var_exo(:,1)==3);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(3,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.02;
end
tmp1 = find(estim_params_.var_exo(:,1)==4);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(4,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.32;
end
tmp1 = find(estim_params_.var_exo(:,1)==5);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(5,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.34;
end
tmp1 = find(estim_params_.var_exo(:,1)==7);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(7,:))))
else
    estim_params_.var_exo(tmp1,2) = 4.40;
end
tmp1 = find(estim_params_.var_exo(:,1)==8);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(8,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.16;
end
tmp1 = find(estim_params_.var_exo(:,1)==9);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(9,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.22;
end
tmp1 = find(estim_params_.var_exo(:,1)==11);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(11,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.023;
end
tmp1 = find(estim_params_.var_exo(:,1)==10);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(10,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.154;
end
skipline()
options_.forecast = 40;
options_.mh_drop = 0.3;
options_.mh_jscale = 0.3;
options_.mh_nblck = 1;
options_.mh_replic = 100000;
options_.mode_compute = 6;
options_.nodisplay = 1;
options_.order = 1;
options_.prefilter = 0;
options_.presample = 4;
options_.qz_zero_threshold = 1e-32;
options_.smoother = 1;
options_.sub_draws = 5000;
options_.datafile = 'data_20011114';
options_.xls_range = 'B1:BD101';
options_.xls_sheet = 's4';
var_list_ = char('gdp_rgd_obs');
oo_recursive_=dynare_estimation(var_list_);
save('A16_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('A16_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('A16_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('A16_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('A16_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('A16_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('A16_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
disp('Note: 1 warning(s) encountered in the preprocessor')
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
