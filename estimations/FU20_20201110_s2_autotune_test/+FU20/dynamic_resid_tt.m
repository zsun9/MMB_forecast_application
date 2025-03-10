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

assert(length(T) >= 12);

T(1) = params(1)/params(2);
T(2) = (params(3)-1)*params(4)/((1+T(1))*params(3));
T(3) = (1-T(1))/((1+T(1))*params(3));
T(4) = 1/(1+params(2)*params(6));
T(5) = params(2)^2*params(7);
T(6) = (1-params(9))/(1+params(8)-params(9));
T(7) = 1/(params(44)/(1-params(44)));
T(8) = (1-params(2)*params(6)*params(13))*(1-params(13))/(1+params(2)*params(6)*params(14))/params(13)/(1+params(15)*params(45));
T(9) = (1-params(2)*params(6)*params(16))*(1-params(16))/params(16)/(1+params(19)*params(46));
T(10) = 1/(1-T(1));
T(11) = T(1)/(1-T(1));
T(12) = params(10)*(params(2)*params(25))^(-1);

end
