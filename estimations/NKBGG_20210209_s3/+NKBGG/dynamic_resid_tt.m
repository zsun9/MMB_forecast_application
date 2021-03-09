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

assert(length(T) >= 36);

T(1) = 1+params(18)/100;
T(2) = 1+params(23)/100;
T(3) = 1/T(2);
T(4) = 1+params(20)/100;
TEF_0 = norminv(params(21),0,1);
T(5) = TEF_0;
T(6) = params(10)^(-1);
T(7) = T(1)*T(2);
T(8) = params(1)/params(5)*(T(4)*T(7)-(1-params(7)));
TEF_1 = call_csolve1(params(21),T(4),params(22));
T(9) = TEF_1;
T(10) = normcdf(T(5)-T(9),0,1);
T(11) = T(9)^2;
T(12) = exp(T(5)*T(9)-0.5*T(11));
T(13) = normpdf(T(5),0,1);
T(14) = (1-1/T(4))/(T(10)+(1-(T(10)+(1-params(21))*T(12)))*T(13)/T(9)/(1-params(21)));
T(15) = ((1-params(5))*(1-params(4))/params(1)+params(6)/T(8)*(T(4)*T(7)*(1-T(10)*T(14))-T(7)))/(T(1)-params(6)*T(7));
T(16) = (params(1)-1)/params(1)+params(2)*(1-params(5))*params(4)/(params(1)*params(2))-params(3)+(T(7)-1)*(1/T(8)-T(15));
T(17) = 1/T(8)*(params(18)/100+params(7));
T(18) = 1/(1-T(4)*((1-params(21))*T(12)+T(10)*(1-T(14))));
T(19) = T(13)^2;
T(20) = 1-params(21)-T(13)*T(14)/T(9);
T(21) = T(20)^2;
T(22) = T(12)*T(20)/(T(10)+(1-params(21))*T(12)-T(10)*T(14));
T(23) = T(12)*T(14)*(1-T(4)*((1-params(21))*T(12)+T(10)*(1-T(14))))*((1-params(21))*T(5)*T(13)-T(19))/(T(4)*T(11)*T(12)*T(21)*(1-(T(10)+(1-params(21))*T(12))+(1-params(21))*(T(10)+(1-params(21))*T(12)-T(10)*T(14))/T(20)))/T(22);
T(24) = T(9)*(T(13)*(-T(12))+T(13)*T(12)*T(5)*T(14)/T(9))/(T(10)+(1-params(21))*T(12)-T(10)*T(14));
T(25) = (T(23)*T(24)-T(9)*(T(13)*(-T(12))*T(4)*((1-T(5)*T(14)/T(9))/(1-T(13)*T(14)/((1-params(21))*T(9)))-1)+T(14)*(1-T(4)*((1-params(21))*T(12)+T(10)*(1-T(14))))*(T(19)*(T(5)/T(9)-1)/T(9)+(1-params(21))*T(13)/T(11)*(1-T(5)*(T(5)-T(9))))/T(21))/(T(4)*(1-(T(10)+(1-params(21))*T(12)))+(1-params(21))*(1-(1-T(4)*((1-params(21))*T(12)+T(10)*(1-T(14)))))/T(20)))/(1-T(23));
T(26) = (1-params(7))/(1-params(7)+params(5)*T(8)/params(1));
T(27) = 1/(params(8)*(1+T(3))*T(1)^2);
T(28) = 1/(1+T(3)*params(24))*(1-params(9))/params(9)*(1-T(3)*params(9));
T(29) = (1-params(7))/T(1);
T(30) = T(18)*params(6)*T(4)*T(7)/T(1);
T(31) = T(12)*T(13)/T(9)/T(10);
T(32) = T(30)*(1-T(10)*T(14)*(1-T(31)/T(22)));
T(33) = T(2)*params(6)*T(18)*(1-(1-T(4)*((1-params(21))*T(12)+T(10)*(1-T(14))))+T(31)*T(4)*T(10)*T(14)/T(22));
T(34) = T(30)*(1-T(10)*T(14)*(1-T(31)/(T(22)*(T(18)-1))))-T(2)*params(6)*T(18);
T(35) = (1-params(5))*(1-params(4))*1/T(15)/params(1)*1/T(1);
T(36) = T(31)*T(10)*T(14)*T(30)*(1-T(24)/T(22));

end
