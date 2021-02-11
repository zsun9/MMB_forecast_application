function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double  vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double  vector of endogenous variables in the order stored
%                                                    in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double  matrix of exogenous variables (in declaration order)
%                                                    for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double  vector of steady state values
%   params        [M_.param_nbr by 1]        double  vector of parameter values in declaration order
%   it_           scalar                     double  time period for exogenous variables for which
%                                                    to evaluate the model
%
% Output:
%   T           [#temp variables by 1]       double  vector of temporary terms
%

assert(length(T) >= 21);

T(1) = (-(1-params(14)*exp((-params(45)))))/(params(20)*(1+params(14)*exp((-params(45)))));
T(2) = params(14)*exp((-params(45)))/(1+params(14)*exp((-params(45))));
T(3) = 1/(1+params(14)*exp((-params(45))));
T(4) = (params(20)-1)*params(56)/(params(20)*(1+params(14)*exp((-params(45)))));
T(5) = params(19)*exp(2*params(45))*(1+params(41)*exp(params(45)*(1-params(20))));
T(6) = 1/(1+params(41)*exp(params(45)*(1-params(20))));
T(7) = params(41)*exp(params(45)*(1-params(20)))/(1+params(41)*exp(params(45)*(1-params(20))));
T(8) = params(48)/(1+params(48)-params(23));
T(9) = (1-params(23))/(1+params(48)-params(23));
T(10) = (-(params(20)*(1+params(14)*exp((-params(45))))))/(1-params(14)*exp((-params(45))));
T(11) = params(20)*(1+params(14)*exp((-params(45))))/(1-params(14)*exp((-params(45))));
T(12) = params(53)/params(52);
T(13) = (1+params(41)*exp(params(45)*(1-params(20))))*exp(2*params(45))*params(19)*params(53)/params(52);
T(14) = y(47)*T(13);
T(15) = (1-exp(params(45)*(1-params(20)))*params(41)*params(5))*(1-params(5))/(params(5)*(1+(params(13)-1)*params(28)))/(1+exp(params(45)*(1-params(20)))*params(41)*params(6));
T(16) = params(41)*exp(params(45)*(1-params(20)))/(1+exp(params(45)*(1-params(20)))*params(41)*params(6));
T(17) = (-1)/(1-params(14)*exp((-params(45))));
T(18) = params(14)*exp((-params(45)))/(1-params(14)*exp((-params(45))));
T(19) = (-(1-exp(params(45)*(1-params(20)))*params(41)*params(7)))*(1-params(7))/(params(7)*(1+(params(25)-1)*params(29)))/(1+params(41)*exp(params(45)*(1-params(20))));
T(20) = (1+exp(params(45)*(1-params(20)))*params(41)*params(8))/(1+params(41)*exp(params(45)*(1-params(20))));
T(21) = 1/(1-params(12));

end
