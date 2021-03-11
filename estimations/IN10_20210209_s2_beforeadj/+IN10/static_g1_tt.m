function T = static_g1_tt(T, y, x, params)
% function T = static_g1_tt(T, y, x, params)
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

assert(length(T) >= 89);

T = IN10.static_resid_tt(T, y, x, params);

T(83) = (-((1-params(7))*exp(y(4))))/(exp(y(4))*exp(y(4)));
T(84) = getPowerDeriv(T(55),(params(31)+params(10))/(1-params(31)),1);
T(85) = exp(y(6))*exp(y(7))*exp(y(28))*getPowerDeriv(exp(y(28)),1-params(31),1)*T(84);
T(86) = getPowerDeriv(T(61),(params(32)+params(11))/(1-params(32)),1);
T(87) = exp(y(6))*exp(y(7))*exp(y(29))*getPowerDeriv(exp(y(29)),1-params(32),1)*T(86);
T(88) = exp(y(6))*exp(y(7))*T(84)*exp(y(30))*getPowerDeriv(exp(y(30)),1-params(31),1);
T(89) = exp(y(6))*exp(y(7))*T(86)*exp(y(31))*getPowerDeriv(exp(y(31)),1-params(32),1);

end
