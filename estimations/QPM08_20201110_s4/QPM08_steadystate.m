function [ys,params,check] = QPM08_steadystate(ys,exo,M_,options_)
% function [ys,params,check] = NK_baseline_steadystate(ys,exo,M_,options_)
% computes the steady state for the NK_baseline.mod and uses a numerical
% solver to do so
% Inputs: 
%   - ys        [vector] vector of initial values for the steady state of
%                   the endogenous variables
%   - exo       [vector] vector of values for the exogenous variables
%   - M_        [structure] Dynare model structure
%   - options   [structure] Dynare options structure
%
% Output: 
%   - ys        [vector] vector of steady state values for the the endogenous variables
%   - params    [vector] vector of parameter values
%   - check     [scalar] set to 0 if steady state computation worked and to
%                    1 of not (allows to impose restrictions on parameters)

% read out parameters to access them with their name
NumberOfParameters = M_.param_nbr;
for ii = 1:NumberOfParameters
  paramname = M_.param_names{ii};
  eval([ paramname ' = M_.params(' int2str(ii) ');']);
end
% initialize indicator
check = 0;


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

params=NaN(NumberOfParameters,1);
for iter = 1:length(M_.params) %update parameters set in the file
  eval([ 'params(' num2str(iter) ') = ' M_.param_names{iter} ';' ])
end

NumberOfEndogenousVariables = M_.orig_endo_nbr; %auxiliary variables are set automatically
for ii = 1:NumberOfEndogenousVariables
  varname = M_.endo_names{ii};
  eval(['ys(' int2str(ii) ') = ' varname ';']);
end
