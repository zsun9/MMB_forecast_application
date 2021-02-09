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

assert(length(T) >= 25);

T(1) = 1+params(31)/100;
T(2) = 1/(1+params(4)/100);
T(3) = 1/(params(8)/(1-params(8)));
T(4) = params(12)/T(1);
T(5) = params(11)*(1+T(4))/(1-T(4));
T(6) = params(11)*params(12)/T(1)/(1-T(4));
T(7) = T(2)*T(1)^(-params(11));
T(8) = 1/T(7)-(1-params(10));
T(9) = params(13)*((1-params(7))/params(7)*T(8)/(params(7)^params(7)*(1-params(7))^(1-params(7))/(params(13)*T(8)^params(7)))^(1/(1-params(7))))^(params(7)-1);
T(10) = (T(1)+params(10)-1)*T(9);
T(11) = 1-params(32)-T(10);
T(12) = (params(11)-1)*(1-params(7))/(params(19)*T(11))/(1-T(4));
T(13) = 1/(1+T(1)*T(7));
T(14) = T(1)^2;
T(15) = params(9)*T(14);
T(16) = 1/((1-T(4))/(params(11)*(1+T(4))));
T(17) = y(60)*T(16);
T(18) = 1-(1-params(10))/T(1);
T(19) = params(33)/(1-T(4));
T(20) = 1/(1-T(4));
T(21) = (1-params(34))*(1-T(2)*params(34))/params(34);
T(22) = 1/(1+params(16)*T(1)*T(7));
T(23) = (1-params(17))*(1-params(17)*T(1)*T(7))/params(17)/(1+(params(13)-1)*params(2));
T(24) = params(18)*(1-params(15))*(1-params(15)*T(1)*T(7))/(params(19)*params(18)/(params(19)-1)*params(15)*(1+T(1)*T(7)));
T(25) = params(18)*(1-params(15))*params(19)*params(18)/(params(19)-1)*params(15)*(1+T(1)*T(7))/(1-params(15)*T(1)*T(7));

end
