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

assert(length(T) >= 28);

T(1) = 1/params(1);
T(2) = params(38);
T(3) = T(2)-(1-params(6));
T(4) = (params(5)^params(5)*(1-params(5))^(1-params(5))/(params(20)*T(3)^params(5)))^(1/(1-params(5)));
T(5) = params(5)*T(4)/((1-params(5))*T(3));
T(6) = (params(30)*T(5)^(1-params(5)))^(-1);
T(7) = 1-(1-params(6));
T(8) = T(7)/T(6);
T(9) = params(10);
T(10) = params(4)/T(6);
T(11) = 1/(1-T(1)*params(12))*(T(10)+params(12)*(params(38)-T(1))/T(6));
T(12) = (T(6)*T(11))^(-1);
T(13) = T(1)+(params(38)-T(1))*T(12);
T(14) = params(1);
T(15) = T(13);
T(16) = (params(38)-T(1))*T(14)*(1-params(12))/(1-params(1)*params(12)*T(15));
T(17) = T(11)-T(10);
T(18) = 1-T(8)-params(9);
T(19) = T(6)^(-1);
T(20) = 100*(T(1)-1);
T(21) = T(14)*(1-params(12))/T(16);
T(22) = (params(38)-T(1))*T(21);
T(23) = 1/T(13);
T(24) = 1/(params(13)/(1-params(13)));
T(25) = 1/(1+T(14));
T(26) = (1-params(17))*T(25)*(1-T(14)*params(17))/(params(17)*(1+params(2)*params(8)));
T(27) = 1/(1+T(14)*params(16));
T(28) = (1-params(15))*(1-T(14)*params(15))/params(15);

end
