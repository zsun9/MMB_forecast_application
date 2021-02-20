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

assert(length(T) >= 14);

T(1) = params(42)/params(39);
T(2) = 1/params(4);
T(3) = 1/params(18);
T(4) = params(20)*params(15)/(params(13)/(params(13)-1))*1/(1-params(19)*(1-params(20))-(T(3)-params(19))*params(16)*params(17));
T(5) = T(1)/(1-params(2));
T(6) = params(10)/(1-params(2))*(y(1)-params(2)*y(1));
T(7) = (1-params(7))/(params(4)*params(5));
T(8) = params(9)/(1-params(2))*0.789/(1-params(2));
T(9) = (y(15)-params(2)*y(15))*params(9)/(1-params(2));
T(10) = 0.789/(1-params(2))*params(11)*params(3);
T(11) = (1-params(15))/(params(13)/(params(13)-1))*1/params(39);
T(12) = 1/(1+params(11)*params(14))*(1-params(12))*(1-params(11)*params(12))/params(12);
T(13) = (1-params(19)*(1-params(20))-(T(3)-params(19))*params(16)*params(17))*1/params(21);
T(14) = 1/(params(3)-1)*params(24)*params(25)^3;

end
