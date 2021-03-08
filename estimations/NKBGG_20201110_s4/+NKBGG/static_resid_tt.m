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

assert(length(T) >= 37);

T(1) = 1+params(18)/100;
T(2) = 1+params(23)/100;
T(3) = 1/T(2);
T(4) = T(1)*T(2);
T(5) = 1+params(20)/100;
T(6) = T(4)*T(5);
T(7) = params(1)/params(5)*(T(6)-(1-params(7)));
TEF_0 = call_csolve1(params(21),T(5),params(22));
T(8) = TEF_0;
TEF_1 = norminv(params(21),0,1);
T(9) = TEF_1;
T(10) = T(8)^2;
T(11) = exp(T(8)*T(9)-0.5*T(10));
T(12) = normcdf(T(9)-T(8),0,1);
T(13) = normpdf(T(9),0,1);
T(14) = (1-1/T(5))/(T(12)+(1-(T(12)+T(11)*(1-params(21))))*T(13)/T(8)/(1-params(21)));
T(15) = 1/(1-T(5)*(T(11)*(1-params(21))+T(12)*(1-T(14))));
T(16) = T(13)^2;
T(17) = 1-params(21)-T(13)*T(14)/T(8);
T(18) = T(17)^2;
T(19) = T(11)*T(17)/(T(12)+T(11)*(1-params(21))-T(12)*T(14));
T(20) = T(8)*(T(13)*(-T(11))+T(13)*T(11)*T(9)*T(14)/T(8))/(T(12)+T(11)*(1-params(21))-T(12)*T(14));
T(21) = T(11)*T(13)/T(8)/T(12);
T(22) = T(11)*T(14)*(1-T(5)*(T(11)*(1-params(21))+T(12)*(1-T(14))))*((1-params(21))*T(9)*T(13)-T(16))/(T(5)*T(10)*T(11)*T(18)*(1-(T(12)+T(11)*(1-params(21)))+(1-params(21))*(T(12)+T(11)*(1-params(21))-T(12)*T(14))/T(17)))/T(19);
T(23) = (T(20)*T(22)-T(8)*(T(13)*(-T(11))*T(5)*((1-T(9)*T(14)/T(8))/(1-T(13)*T(14)/(T(8)*(1-params(21))))-1)+T(14)*(1-T(5)*(T(11)*(1-params(21))+T(12)*(1-T(14))))*(T(16)*(T(9)/T(8)-1)/T(8)+(1-params(21))*T(13)/T(10)*(1-T(9)*(T(9)-T(8))))/T(18))/(T(5)*(1-(T(12)+T(11)*(1-params(21))))+(1-params(21))*(1-(1-T(5)*(T(11)*(1-params(21))+T(12)*(1-T(14)))))/T(17)))/(1-T(22));
T(24) = T(15)*T(6)*params(6)/T(1);
T(25) = T(24)*(1-T(12)*T(14)*(1-T(21)/T(19)));
T(26) = T(2)*T(15)*params(6)*(1-(1-T(5)*(T(11)*(1-params(21))+T(12)*(1-T(14))))+T(21)*T(5)*T(12)*T(14)/T(19));
T(27) = T(24)*(1-T(12)*T(14)*(1-T(21)/(T(19)*(T(15)-1))))-T(2)*T(15)*params(6);
T(28) = T(21)*T(12)*T(14)*T(24)*(1-T(20)/T(19));
T(29) = ((1-params(5))*(1-params(4))/params(1)+params(6)/T(7)*(T(6)*(1-T(12)*T(14))-T(4)))/(T(1)-T(4)*params(6));
T(30) = (params(1)-1)/params(1)+params(2)*(1-params(5))*params(4)/(params(1)*params(2))-params(3)+(1/T(7)-T(29))*(T(4)-1);
T(31) = 1/T(7)*(params(18)/100+params(7));
T(32) = (1-params(7))/(1-params(7)+params(5)*T(7)/params(1));
T(33) = 1/((1+T(3))*params(8)*T(1)^2);
T(34) = params(10)^(-1);
T(35) = (1-params(9))/params(9)*(1-T(3)*params(9))*1/(1+T(3)*params(24));
T(36) = 1-(1-params(7))/T(1);
T(37) = (1-params(5))*(1-params(4))*1/T(29)/params(1)*1/T(1);

end
