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

assert(length(T) >= 91);

T = FRBEDO08.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(65) = getPowerDeriv(y(48)/y(1),params(22),1);
T(66) = getPowerDeriv(T(20),1-params(20),1);
T(67) = getPowerDeriv(y(49)/y(2),params(24),1);
T(68) = getPowerDeriv(y(105)*y(50)/y(3),params(34)*T(8),1);
T(69) = getPowerDeriv(T(63),1/(params(34)*params(37)+params(34)*T(8)+params(35)*T(9)),1);
T(70) = (-((-(y(101)*y(105)*(y(69)+y(50)+y(51)*y(100))))/((y(15)+y(3)+y(28)*y(4))*(y(15)+y(3)+y(28)*y(4)))));
T(71) = getPowerDeriv(y(106)*y(51)/y(4),params(35)*T(9),1);
T(72) = T(39)*T(39);
T(73) = T(41)*T(41);
T(74) = (-(params(2)*y(118)))/(y(56)*y(56));
T(75) = T(74)/y(141);
T(76) = params(2)/y(56);
T(77) = T(76)/y(141);
T(78) = (-(params(29)*y(83)*getPowerDeriv(y(61)+y(62),params(19),1)));
T(79) = getPowerDeriv(y(11)*y(63)/y(106),params(1),1);
T(80) = getPowerDeriv(y(12)*y(64)/y(106),params(1),1);
T(81) = 1/y(106);
T(82) = (-(y(94)*(-(100*params(6)*y(106)*(-(y(52)-y(5)))/((y(11)+y(12))*(y(11)+y(12)))))));
T(83) = (-((1-params(9))/y(106)-(-(T(33)*T(81)))/(T(34)*T(34))));
T(84) = (-(params(6)*100*T(27)*y(130)*y(141)*(-(y(114)-y(52)))/((y(65)+y(66))*(y(65)+y(66)))));
T(85) = getPowerDeriv(y(105)*y(69)/y(15),params(34)*params(37),1);
T(86) = 1/params(18)/y(94);
T(87) = getPowerDeriv(T(29),T(30),1);
T(88) = getPowerDeriv(T(31),T(30),1);
T(89) = (-(100*exp(x(it_, 23))*(-(y(105)*y(101)/y(49)*(y(98)+y(99))))/((y(26)+y(27))*(y(26)+y(27)))));
T(90) = (-(100*exp(x(it_, 23))*y(105)*y(101)/y(49)/(y(26)+y(27))));
T(91) = 1/y(101)/y(105);

end
