function [ys,check] = QPM08_steadystate(ys, junk)

global M_;

growth_us_ss = get_param_by_name('growth_us_ss'); 
rr_us_bar_ss = get_param_by_name('rr_us_bar_ss'); 
pietar_us_ss = get_param_by_name('pietar_us_ss');


% because of that crapy (i am sorry) Koopman&durbin stuff, which doesn't
% take into account cointagration of unit-root variables, we initialize
% all unit root variables to the first observation

%data;
unr_obs=6.525;
blt_obs=-8.87;
cpil_obs=498.924140140858;
gdpl_rgd_obs=895.093472647606;
ffr_obs=3.21406593406593/4;

RR_US = rr_us_bar_ss;
RR_US_BAR = rr_us_bar_ss;
unr_obs = unr_obs(1);
unr_obs_GAP = 0;
unr_obs_BAR = unr_obs;
PIE_US     = pietar_us_ss;
PIE_US4    = pietar_us_ss;
Y_US       = 0;
gdpl_rgd_obs    = gdpl_rgd_obs(1);
gdpl_rgd_obs_BAR = gdpl_rgd_obs(1);
ffr_obs      = rr_us_bar_ss/4+pietar_us_ss/4;
G_US  = growth_us_ss;
cpil_obs    = cpil_obs(1);
E4_PIE_US4 = pietar_us_ss;
E1_Y_US    = 0;
E1_PIE_US = pietar_us_ss;
UNR_G_US = 0;
GROWTH_US = growth_us_ss;
GROWTH4_US = growth_us_ss;
GROWTH4_US_BAR = growth_us_ss;
blt_obs = blt_obs(1);
blt_obs_BAR = blt_obs(1);
E=0;
E2=0;
GROWTH_US_BAR = growth_us_ss;
RR_US_GAP = 0;
blt_obs_GAP = 0;

check = 0;

ys = [
RR_US 
RR_US_BAR
unr_obs 
unr_obs_GAP 
unr_obs_BAR
PIE_US 
PIE_US4 
Y_US 
gdpl_rgd_obs 
gdpl_rgd_obs_BAR 
ffr_obs 
G_US 
cpil_obs 
E4_PIE_US4 
E1_Y_US 
E1_PIE_US 
UNR_G_US
GROWTH_US
GROWTH4_US
GROWTH4_US_BAR
blt_obs
blt_obs_BAR
E
E2
GROWTH_US_BAR
RR_US_GAP
blt_obs_GAP
    ];