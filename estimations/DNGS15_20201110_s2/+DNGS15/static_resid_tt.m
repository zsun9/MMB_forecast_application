function T = static_resid_tt(T, y, x, params)
% function T = static_resid_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 19);

T(1) = (-(1-params(14)*exp((-params(45)))))/(params(20)*(1+params(14)*exp((-params(45)))));
T(2) = params(14)*exp((-params(45)))/(1+params(14)*exp((-params(45))));
T(3) = 1/(1+params(14)*exp((-params(45))));
T(4) = params(19)*exp(2*params(45))*(1+params(41)*exp(params(45)*(1-params(20))));
T(5) = 1/(1+params(41)*exp(params(45)*(1-params(20))));
T(6) = params(41)*exp(params(45)*(1-params(20)))/(1+params(41)*exp(params(45)*(1-params(20))));
T(7) = params(48)/(1+params(48)-params(23));
T(8) = (1-params(23))/(1+params(48)-params(23));
T(9) = (-(params(20)*(1+params(14)*exp((-params(45))))))/(1-params(14)*exp((-params(45))));
T(10) = params(20)*(1+params(14)*exp((-params(45))))/(1-params(14)*exp((-params(45))));
T(11) = params(53)/params(52);
T(12) = (1+params(41)*exp(params(45)*(1-params(20))))*exp(2*params(45))*params(19)*params(53)/params(52);
T(13) = y(24)*T(12);
T(14) = (1-exp(params(45)*(1-params(20)))*params(41)*params(5))*(1-params(5))/(params(5)*(1+(params(13)-1)*params(28)))/(1+exp(params(45)*(1-params(20)))*params(41)*params(6));
T(15) = params(41)*exp(params(45)*(1-params(20)))/(1+exp(params(45)*(1-params(20)))*params(41)*params(6));
T(16) = (-1)/(1-params(14)*exp((-params(45))));
T(17) = params(14)*exp((-params(45)))/(1-params(14)*exp((-params(45))));
T(18) = (-(1-exp(params(45)*(1-params(20)))*params(41)*params(7)))*(1-params(7))/(params(7)*(1+(params(25)-1)*params(29)))/(1+params(41)*exp(params(45)*(1-params(20))));
T(19) = (1+exp(params(45)*(1-params(20)))*params(41)*params(8))/(1+params(41)*exp(params(45)*(1-params(20))));

end
