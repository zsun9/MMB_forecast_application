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

assert(length(T) >= 14);

T(1) = params(42)/params(39);
T(2) = 1/params(4);
T(3) = 1/params(18);
T(4) = params(10)/(1-params(2));
T(5) = T(4)*(y(25)-params(2)*y(1));
T(6) = (1-params(7))/(params(4)*params(5));
T(7) = params(9)/(1-params(2));
T(8) = 1/(params(3)-1)*params(24)*params(25)^3;
T(9) = T(1)/(1-params(2));
T(10) = params(11)*params(3)*0.789/(1-params(2));
T(11) = 1/params(39)*(1-params(15))/(params(13)/(params(13)-1));
T(12) = 1/(1+params(11)*params(14))*(1-params(12))*(1-params(11)*params(12))/params(12);
T(13) = 1/params(21)*(1-params(19)*(1-params(20))-(T(3)-params(19))*params(16)*params(17));
T(14) = params(20)*params(15)/(params(13)/(params(13)-1))*1/(1-params(19)*(1-params(20))-(T(3)-params(19))*params(16)*params(17));

end
