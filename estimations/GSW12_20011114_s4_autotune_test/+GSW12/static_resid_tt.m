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

assert(length(T) >= 33);

T(1) = 1/(1+params(4)/100);
T(2) = 1+params(31)/100;
T(3) = 1+params(3)/100;
T(4) = T(1)*T(2)^(-params(11));
T(5) = params(13);
T(6) = 1/T(4)-(1-params(10));
T(7) = (params(7)^params(7)*(1-params(7))^(1-params(7))/(T(5)*T(6)^params(7)))^(1/(1-params(7)));
T(8) = (1-params(7))/params(7)*T(6)/T(7);
T(9) = T(2)+params(10)-1;
T(10) = params(13)*T(8)^(params(7)-1);
T(11) = T(9)*T(10);
T(12) = 1-params(32)-T(11);
T(13) = (1-params(7))/(params(19)*T(12));
T(14) = T(6)*T(10);
T(15) = 1-(1-params(10))/T(2);
T(16) = 100*(T(3)/T(4)-1);
T(17) = params(12)/T(2);
T(18) = 1-T(17);
T(19) = params(11)*(1+T(17))/T(18)*y(35);
T(20) = params(11)*params(12)/T(2)/T(18);
T(21) = 1/(1+T(2)*T(4));
T(22) = T(2)^2;
T(23) = T(22)*params(9);
T(24) = 1/(T(18)/(params(11)*(1+T(17))));
T(25) = y(35)*T(24);
T(26) = (1-params(10))/(1-params(10)+T(6));
T(27) = 1/(params(8)/(1-params(8)));
T(28) = (1-T(1)*params(34))*(1-params(34))/params(34);
T(29) = 1/(1+T(2)*T(4)*params(16));
T(30) = (1-params(17))*(1-T(2)*T(4)*params(17))/params(17)/(1+(params(13)-1)*params(2));
T(31) = T(2)*T(4)/(1+T(2)*T(4));
T(32) = params(18)*(1-T(2)*T(4)*params(15))*(1-params(15))/((1+T(2)*T(4))*params(15)*params(19)*params(18)/(params(19)-1));
T(33) = params(18)*(1-params(15))*(1+T(2)*T(4))*params(15)*params(19)*params(18)/(params(19)-1)/(1-T(2)*T(4)*params(15));

end
