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

assert(length(T) >= 22);

T(1) = 1/params(3);
T(2) = params(9)*T(1);
T(3) = T(2);
T(4) = T(3)-(1-params(4));
T(5) = (params(2)^params(2)*(1-params(2))^(1-params(2))/(params(5)*T(4)^params(2)))^(1/(1-params(2)));
T(6) = params(2)*T(5)/((1-params(2))*T(4));
T(7) = (params(40)*T(6)^(1-params(2)))^(-1);
T(8) = 1-(1-params(4));
T(9) = T(8)/T(7);
T(10) = params(3);
T(11) = params(18);
T(12) = 1-T(9)-params(6);
T(13) = T(7)^(-1);
T(14) = 100*(T(1)-1);
T(15) = 1/(params(24)/(1-params(24)));
T(16) = 1/(1+T(10));
T(17) = (1-params(4))/T(2);
T(18) = params(10)^(-1);
T(19) = 1/(1+T(10)*params(23));
T(20) = (1-params(21))*(1-T(10)*params(21))/params(21);
T(21) = T(10)/(1+T(10));
T(22) = (1-params(20))*T(16)*(1-T(10)*params(20))/(params(20)*(1+params(41)*params(8)));

end
