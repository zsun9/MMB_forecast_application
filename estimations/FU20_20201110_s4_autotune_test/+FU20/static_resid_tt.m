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

assert(length(T) >= 9);

T(1) = params(1)/params(2);
T(2) = (1-T(1))/((1+T(1))*params(3));
T(3) = 1/(1+params(2)*params(6));
T(4) = params(2)^2*params(7);
T(5) = (1-params(9))/(1+params(8)-params(9));
T(6) = 1/(params(44)/(1-params(44)));
T(7) = (1-params(2)*params(6)*params(13))*(1-params(13))/(1+params(2)*params(6)*params(14))/params(13)/(1+params(15)*params(45));
T(8) = (1-params(2)*params(6)*params(16))*(1-params(16))/params(16)/(1+params(19)*params(46));
T(9) = params(10)*(params(2)*params(25))^(-1);

end
