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

assert(length(T) >= 64);

T(1) = params(53)*params(2)*params(27)/params(26)*(1-params(2)*params(16)/params(53))/(1-params(2)*params(15)/params(54))*(1-params(15)/params(54))/(1-params(16)/params(53))*(params(53)-(1-params(10)))/params(53)/(params(53)-params(2)*(1-params(10)));
T(2) = params(54)*params(2)*(1-params(15)/params(54))*params(28)/params(26)*(1-params(2)*params(17)/params(54))/(1-params(2)*params(15)/params(54))/(1-params(17)/params(54))*(params(54)-(1-params(11)))/params(54)/(params(54)-params(2)*(1-params(11)));
T(3) = params(1)/(params(53)/params(2)-(1-params(9)))*(params(44)-1)/params(44);
T(4) = (T(1)+(1+T(2))*(params(53)-(1-params(9)))*T(3))/(1+T(2)-(1+T(2))*(params(53)-(1-params(9)))*T(3));
T(5) = ((1-params(2)*params(15)/params(54))*params(26)*(1+T(2))*(params(45)-1)/params(45)*(1-params(1))*((params(44)-1)/params(44))^(1/(1-params(1)))*(params(1)/(params(53)/params(2)-(1-params(9))))^(params(1)/(1-params(1)))*(1+T(4))/T(3)^(params(1)/(1-params(1)))/params(29)/(1-params(15)/params(54)))^(1/(1+params(19)));
T(6) = 1/(1+T(4))*T(5);
T(7) = T(5)*T(4)/(1+T(4));
T(8) = T(6)/(params(44)*(params(53)*1/params(2)-(1-params(9)))/params(1)/(params(44)-1))^(params(1)/(1-params(1)));
T(9) = T(7)/(params(44)*(params(53)*1/params(2)-(1-params(9)))/params(1)/(params(44)-1))^(params(1)/(1-params(1)));
T(10) = params(54)^((params(34)*T(8)+params(34)*params(37))/(params(34)*params(37)+params(34)*T(8)+params(35)*T(9)))*params(53)^(params(35)*T(9)/(params(34)*params(37)+params(34)*T(8)+params(35)*T(9)));
T(11) = params(54)*1/T(10)*params(30);
T(12) = y(105)*y(101)/y(49)*(y(98)+y(99))/(y(26)+y(27))*exp(x(it_, 23));
T(13) = y(25)^params(20);
T(14) = (y(49)/T(11))^params(23);
T(15) = (y(49)/y(2))^params(24);
T(16) = T(14)*T(15);
T(17) = (y(48)/T(10))^params(21);
T(18) = T(16)*T(17);
T(19) = (y(48)/y(1))^params(22);
T(20) = T(18)*T(19)*params(36);
T(21) = T(20)^(1-params(20));
T(22) = (y(11)*y(63)/y(106))^params(1);
T(23) = y(61)^(1-params(1));
T(24) = (y(12)*y(64)/y(106))^params(1);
T(25) = y(62)^(1-params(1));
T(26) = params(3)*100*y(118)/y(56);
T(27) = params(2)*y(118)/y(56);
T(28) = T(27)/y(141);
T(29) = y(90)*1/params(18)/y(94);
T(30) = 1/params(25);
T(31) = y(91)*1/params(18)/y(94);
T(32) = y(141)*(y(114)-y(52))/(y(65)+y(66));
T(33) = 100*params(6)/2*(y(52)-y(5))^2;
T(34) = (y(11)+y(12))/y(106);
T(35) = y(141)*(y(115)-y(53))/y(67);
T(36) = 100*params(4)/2*(y(53)-y(6))^2;
T(37) = y(140)*(y(116)-y(54))/y(68);
T(38) = 100*params(7)/2*(y(54)-y(7))^2;
T(39) = y(55)-y(8)*params(15)/y(105);
T(40) = params(15)*params(2)*params(26)/y(140)*y(123);
T(41) = y(117)-y(55)*params(15)/y(140);
T(42) = y(13)/y(106)-params(16)/(y(106)*y(34))*y(35);
T(43) = params(2)*params(27)*params(16)/y(106)*y(124);
T(44) = y(67)/y(106)-y(13)*params(16)/(y(106)*y(106));
T(45) = y(14)/y(105)-params(17)/(y(105)*y(33))*y(36);
T(46) = params(2)*params(28)*params(17)/y(105)*y(125);
T(47) = y(68)/y(105)-y(14)*params(17)/(y(105)*y(105));
T(48) = y(98)*T(6)/(T(6)+T(7))+y(99)*T(7)/(T(6)+T(7));
T(49) = 100*y(72)*params(5)*T(48);
T(50) = y(61)/y(62)-params(13)*y(9)/y(10)-T(6)*(1-params(13))/T(7);
T(51) = T(49)*T(50);
T(52) = 100*y(118)/y(56)*params(8);
T(53) = y(138)*T(52)*(y(138)-y(103)*params(14)-(1-params(14))*params(32))*y(133);
T(54) = T(53)*y(119);
T(55) = (y(61)+y(62))^params(19);
T(56) = params(29)*y(83)*T(55);
T(57) = y(106)*y(102)/y(101)/y(105);
T(58) = y(103)/y(101)/y(105);
T(59) = y(104)/y(101)/y(105);
T(60) = (y(105)*y(50)/y(3))^(params(34)*T(8));
T(61) = (y(106)*y(51)/y(4))^(params(35)*T(9));
T(62) = (y(105)*y(69)/y(15))^(params(34)*params(37));
T(63) = T(60)*T(61)*T(62);
T(64) = y(75)^params(1);

end
