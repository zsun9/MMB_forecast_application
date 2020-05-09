function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
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

assert(length(T) >= 96);

T = jules1.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(91) = getPowerDeriv(T(63),(params(31)+params(10))/(1-params(31)),1);
T(92) = exp(y(27))*exp(y(28))*exp(y(49))*getPowerDeriv(exp(y(49)),1-params(31),1)*T(91);
T(93) = getPowerDeriv(T(69),(params(32)+params(11))/(1-params(32)),1);
T(94) = exp(y(27))*exp(y(28))*exp(y(50))*getPowerDeriv(exp(y(50)),1-params(32),1)*T(93);
T(95) = exp(y(27))*exp(y(28))*T(91)*exp(y(51))*getPowerDeriv(exp(y(51)),1-params(31),1);
T(96) = exp(y(27))*exp(y(28))*T(93)*exp(y(52))*getPowerDeriv(exp(y(52)),1-params(32),1);

end
