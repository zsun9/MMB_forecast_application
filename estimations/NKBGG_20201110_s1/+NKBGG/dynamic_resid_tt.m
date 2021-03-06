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

assert(length(T) >= 41);

T(1) = 1+params(18)/100;
T(2) = 1/(1+params(23)/100);
T(3) = T(1)*(1+params(19)/100)/T(2);
T(4) = 1+params(20)/100;
T(5) = T(1)/T(2);
T(6) = T(4)*T(5);
TEF_0 = call_csolve1(params(21),T(4),params(22));
T(7) = TEF_0;
TEF_1 = norminv(params(21),0,1);
T(8) = TEF_1;
T(9) = exp(T(7)*T(8)-0.5*T(7)^2);
T(10) = normcdf(T(8)-T(7),0,1);
T(11) = T(9)*(1-params(21))+T(10);
T(12) = normpdf(T(8),0,1);
T(13) = (1-1/T(4))/(T(10)+(1-T(11))*T(12)/T(7)/(1-params(21)));
T(14) = 1/(1-T(4)*(T(9)*(1-params(21))+T(10)*(1-T(13))));
T(15) = (1-T(8)*T(13)/T(7))/(1-T(12)*T(13)/(T(7)*(1-params(21))))-1;
T(16) = T(12)^2*(T(8)/T(7)-1)/T(7)+(1-params(21))*T(12)/T(7)^2*(1-T(8)*(T(8)-T(7)));
T(17) = T(9)*T(13)/T(14)*((1-params(21))*T(8)*T(12)-T(12)^2)/(T(4)*T(7)^2*T(9)*(1-params(21)-T(12)*T(13)/T(7))^2*(1-T(11)+(1-params(21))*(T(11)-T(10)*T(13))/(1-params(21)-T(12)*T(13)/T(7))));
T(18) = T(9)*(1-params(21)-T(12)*T(13)/T(7))/(T(11)-T(10)*T(13));
T(19) = T(7)*(T(12)*(-T(9))+T(12)*T(9)*T(8)*T(13)/T(7))/(T(11)-T(10)*T(13));
T(20) = T(7)*(T(4)*T(15)*T(12)*(-T(9))+T(13)/T(14)*T(16)/(1-params(21)-T(12)*T(13)/T(7))^2)/(T(4)*(1-T(11))+(1-params(21))*(1-1/T(14))/(1-params(21)-T(12)*T(13)/T(7)));
T(21) = T(9)*T(12)/T(7)/T(10);
T(22) = params(1)/params(5)*(T(6)-(1-params(7)));
T(23) = (params(6)/T(22)*(T(6)*(1-T(10)*T(13))-T(5))+(1-params(5))*(1-params(4))/params(1))/(T(1)-T(5)*params(6));
T(24) = (1-params(5))*params(4)/(params(1)*params(2));
T(25) = 1/T(22)-T(23);
T(26) = params(2)*T(24)-params(3)+(params(1)-1)/params(1)+(T(5)-1)*T(25);
T(27) = 1/T(22)*(params(7)+T(1)-1);
T(28) = 1-T(26)-T(27)-params(3);
T(29) = (T(17)/T(18)*T(19)-T(20))/(1-T(17)/T(18));
T(30) = (1-params(7))/(1-params(7)+params(5)*T(22)/params(1));
T(31) = (1-params(9))/params(9)*(1-T(2)*params(9));
T(32) = T(14)*T(6)*params(6)/T(1)*(1-T(10)*T(13)*(1-T(21)/T(18)));
T(33) = T(14)*params(6)/T(2)*(1-1/T(14)+T(21)*T(4)*T(10)*T(13)/T(18));
T(34) = T(14)*T(6)*params(6)/T(1)*(1-T(10)*T(13)*(1-T(21)/(T(18)*(T(14)-1))))-T(14)*params(6)/T(2);
T(35) = 1/T(23);
T(36) = T(21)*T(10)*T(13)*T(14)*T(6)*params(6)/T(1)*(1-T(19)/T(18));
T(37) = 100*(T(3)-1);
T(38) = 1/((1+T(2))*params(8)*T(1)^2);
T(39) = params(10)^(-1);
T(40) = (1-params(7))/T(1);
T(41) = (1-params(5))*(1-params(4))*T(35)/params(1)*1/T(1);

end
