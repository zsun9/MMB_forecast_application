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

assert(length(T) >= 90);

T(1) = params(40)+params(42)*params(5)/(1-params(5));
T(2) = params(40)+1/(1-params(5))*params(42);
T(3) = params(40)*(1-params(6)-params(43))+params(42)*params(5)*(1-params(6)-params(43))/(1-params(5))-(1-params(6)-params(33)-params(43))*params(41);
T(4) = (1-params(6)-params(33)-params(43))*params(41)+params(40)*(params(6)+params(43))+params(42)*params(5)*(params(6)+params(43))/(1-params(5));
T(5) = 1/params(1);
T(6) = exp(T(1));
T(7) = exp(T(2));
T(8) = exp(params(42));
T(9) = exp(T(3));
T(10) = exp(T(4));
T(11) = 1-(1-params(9))/T(10);
T(12) = params(4)/(1-params(1)*T(9)*(1-params(9)));
T(13) = T(5)/T(6)-1;
T(14) = params(6)*params(1)*T(6)/(1-params(1)*(1-params(8)));
T(15) = params(4)/(1-(1-params(9))*T(9)*params(2)-T(9)*(params(1)-params(2))*params(3));
T(16) = T(9)*(T(5)/T(6)-1)*params(3)/T(5);
T(17) = params(5)*params(1)*T(7)/(T(8)-params(1)*(1-params(7)))/params(21);
T(18) = (params(21)-1+params(21)*T(13)*T(17)+(1-params(5))*params(16))/params(21);
T(19) = T(15)*T(16)+1+T(11)*T(15)*(1-(1-params(6)-params(33)-params(43))*(1-params(16)));
T(20) = T(11)*((1-params(6)-params(33)-params(43))*params(16)+params(33)+T(13)*T(14))*T(15)+T(15)*T(16);
T(21) = (1-params(5))*(1-params(16))/params(21);
T(22) = 1+T(11)*T(12)*(1-T(13)*T(14)-params(33)-(1-params(6)-params(33)-params(43))*params(16));
T(23) = T(12)*T(11)*(1-params(6)-params(33)-params(43))*(1-params(16));
T(24) = (T(18)*T(19)+T(20)*T(21))/(T(19)*T(22)-T(20)*T(23));
T(25) = (T(21)*T(22)+T(18)*T(23))/(T(19)*T(22)-T(20)*T(23));
T(26) = T(11)*T(12)*T(24)+T(11)*T(15)*T(25);
T(27) = params(21)*(1-params(6)-params(33)-params(43))/(1-params(5))*T(26);
T(28) = T(27)^(1/(1-params(31)));
T(29) = ((1-params(5))*params(16)/T(24)/params(21)/params(34)/(1+T(27))^((params(31)+params(10))/(1-params(31))))^(1/(1+params(10)));
T(30) = T(27)^(1/(1-params(32)));
T(31) = ((1-params(5))*(1-params(16))/T(25)/params(21)/params(34)/(1+T(27))^((params(32)+params(11))/(1-params(32))))^(1/(1+params(11)));
T(32) = T(28)*T(29);
T(33) = T(30)*T(31);
T(34) = T(29)^params(16)*T(31)^(1-params(16))*T(17)^(params(5)/(1-params(5)))/T(7)^(params(5)/(1-params(5)));
T(35) = T(32)^((1-params(6)-params(33)-params(43))*params(16))*T(33)^((1-params(6)-params(33)-params(43))*(1-params(16)))*T(14)^params(6)*(T(26)*T(34))^params(6)/T(6)^params(6)*(T(26)*params(43)*T(34))^params(43);
T(36) = T(26)*T(34);
T(37) = T(24)*T(34);
T(38) = T(26)*T(34)/T(35);
T(39) = T(25)*T(34);
T(40) = 1-(1-params(7))/T(7);
T(41) = T(17)*T(34);
T(42) = 1-(1-params(8))/T(6);
T(43) = T(14)*T(36);
T(44) = T(37)+T(39);
T(45) = T(35);
T(46) = T(40)*T(41)+T(42)*T(43);
T(47) = log(T(44));
T(48) = log(T(45));
T(49) = log(T(46));
T(50) = params(16)*log(T(29))+(1-params(16))*log(T(31));
T(51) = params(16)*log(T(32))+(1-params(16))*log(T(33));
T(52) = log(T(38));
T(53) = (exp(y(55)+y(70))+(1-params(7))/exp(y(25)))*exp(y(14)-T(2));
T(54) = exp(y(57))/exp(y(25));
T(55) = exp(T(2))*params(14)/2;
T(56) = exp(y(76))^2;
T(57) = exp(y(46))^2;
T(58) = exp(T(1))*params(1)*exp(y(81)-T(2))*(exp(y(79)+y(87))+(1-params(7))/exp(y(72))+T(55)*(T(56)/T(57)-1));
T(59) = exp(T(1))*params(15)/2;
T(60) = exp(y(77))^2;
T(61) = exp(y(47))^2;
T(62) = exp(T(1))*params(1)*exp(y(81)-T(1))*(1-params(8)+exp(y(80)+y(88))+T(59)*(T(60)/T(61)-1));
T(63) = exp(y(49))^(1-params(31))+exp(y(51))^(1-params(31));
T(64) = exp(y(27))*exp(y(28))*T(63)^((params(31)+params(10))/(1-params(31)));
T(65) = exp(y(49))^(-params(31));
T(66) = T(64)*T(65);
T(67) = exp(y(51))^(-params(31));
T(68) = T(64)*T(67);
T(69) = exp(y(50))^(1-params(32))+exp(y(52))^(1-params(32));
T(70) = exp(y(27))*exp(y(28))*T(69)^((params(32)+params(11))/(1-params(32)));
T(71) = exp(y(50))^(-params(32));
T(72) = T(70)*T(71);
T(73) = exp(y(52))^(-params(32));
T(74) = T(70)*T(73);
T(75) = (exp(T(1))-params(12))/(exp(T(1))-exp(T(1))*params(1)*params(12));
T(76) = exp(y(28))*T(75)*(1/(exp(y(30))-params(12)*exp(y(9)-T(1)))-exp(T(1))*params(1)*params(12)/(exp(T(1)+y(73))-exp(y(30))*params(12)));
T(77) = (exp(T(1))-params(13))/(exp(T(1))-exp(T(1))*params(2)*params(13));
T(78) = exp(y(28))*T(77)*(1/(exp(y(31))-params(13)*exp(y(10)-T(1)))-exp(T(1))*params(2)*params(13)/(exp(T(1)+y(74))-exp(y(31))*params(13)));
T(79) = 1/(1+exp(T(1))*params(1));
T(80) = (1-params(35))*(1-exp(T(1))*params(1)*params(35))/params(35)/(1+exp(T(1))*params(1));
T(81) = 1/(1+exp(T(1))*params(2));
T(82) = (1-params(35))*(1-exp(T(1))*params(2)*params(35))/params(35)/(1+exp(T(1))*params(2));
T(83) = (1-params(36))*(1-exp(T(1))*params(1)*params(36))/params(36)/(1+exp(T(1))*params(1));
T(84) = (1-params(36))*(1-exp(T(1))*params(2)*params(36))/params(36)/(1+exp(T(1))*params(2));
T(85) = exp(y(25)+y(55))/(exp(params(42))*1/params(1)-(1-params(7)));
T(86) = exp(y(56))/(1/params(1)-(1-params(8)));
T(87) = exp(y(47))+exp(y(46))-(1-params(7))*exp(y(14)-T(2))-(1-params(8))*exp(y(15)-T(1));
T(88) = exp(T(47))/(exp(T(47))+exp(T(48)+T(52))+exp(T(49)));
T(89) = exp(T(49))/(exp(T(47))+exp(T(48)+T(52))+exp(T(49)));
T(90) = exp(T(48)+T(52))/(exp(T(47))+exp(T(48)+T(52))+exp(T(49)));

end
