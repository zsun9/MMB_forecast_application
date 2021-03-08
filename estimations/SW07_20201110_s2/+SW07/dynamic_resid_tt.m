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

assert(length(T) >= 31);

T(1) = 1/(1+params(6)/100);
T(2) = 1+params(38)/100;
T(3) = 1+params(5)/100;
T(4) = params(17);
T(5) = T(1)^(-1)*T(2)^params(13)-(1-params(12));
T(6) = (params(9)^params(9)*(1-params(9))^(1-params(9))/(T(4)*T(5)^params(9)))^(1/(1-params(9)));
T(7) = (1-params(9))/params(9)*T(5)/T(6);
T(8) = T(2)*(1-(1-params(12))/T(2));
T(9) = params(17)*T(7)^(params(9)-1);
T(10) = 1-params(39)-T(8)*T(9);
T(11) = T(3)/(T(1)*T(2)^(-params(13)));
T(12) = T(1)*T(2)^(-params(13));
T(13) = T(9)*T(5)*(1-params(9))*1/params(23)/params(9)/T(10);
T(14) = T(8)*T(9);
T(15) = T(5)*T(9);
T(16) = 1-(1-params(12))/T(2);
T(17) = 100*(T(11)-1);
T(18) = 1/(params(10)/(1-params(10)));
T(19) = 1/(1+T(2)*T(12));
T(20) = T(2)^2;
T(21) = T(20)*params(11);
T(22) = params(14)/T(2);
T(23) = (1-T(22))/(params(13)*(1+T(22)));
T(24) = (1-params(12))/(1-params(12)+T(5));
T(25) = (params(13)-1)*T(13)/(params(13)*(1+T(22)));
T(26) = 1/(1-T(22));
T(27) = T(22)/(1-T(22));
T(28) = 1/(1+T(2)*T(12)*params(20));
T(29) = (1-params(21))*(1-T(2)*T(12)*params(21))/params(21)/(1+(params(17)-1)*params(3));
T(30) = T(2)*T(12)/(1+T(2)*T(12));
T(31) = (1-params(19))*(1-T(2)*T(12)*params(19))/((1+T(2)*T(12))*params(19))*1/(1+(params(23)-1)*params(1));

end
