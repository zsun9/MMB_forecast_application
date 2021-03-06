function T = static_resid_tt(T, y, x, params)
% function T = static_resid_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 48);

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
T(12) = y(61)^params(20);
T(13) = (y(13)/T(11))^params(23);
T(14) = (y(12)/T(10))^params(21);
T(15) = T(13)*T(14)*params(36);
T(16) = T(15)^(1-params(20));
T(17) = (y(29)*y(27)/y(70))^params(1);
T(18) = y(25)^(1-params(1));
T(19) = (y(30)*y(28)/y(70))^params(1);
T(20) = y(26)^(1-params(1));
T(21) = params(2)/y(70);
T(22) = y(54)*1/params(18)/y(58);
T(23) = 1/params(25);
T(24) = y(55)*1/params(18)/y(58);
T(25) = y(19)-y(19)*params(15)/y(69);
T(26) = y(44)*params(15)*params(2)*params(26)/y(69);
T(27) = params(16)/(y(70)*y(70));
T(28) = y(31)/y(70)-T(27)*y(71);
T(29) = params(2)*params(27)*y(45)*params(16)/y(70);
T(30) = y(31)/y(70)-y(31)*T(27);
T(31) = params(17)/(y(69)*y(69));
T(32) = y(32)/y(69)-T(31)*y(72);
T(33) = params(2)*params(28)*y(46)*params(17)/y(69);
T(34) = y(32)/y(69)-y(32)*T(31);
T(35) = y(62)*T(6)/(T(6)+T(7))+y(63)*T(7)/(T(6)+T(7));
T(36) = 100*y(36)*params(5)*T(35);
T(37) = y(25)/y(26)-y(25)*params(13)/y(26)-T(6)*(1-params(13))/T(7);
T(38) = T(36)*T(37);
T(39) = (y(25)+y(26))^params(19);
T(40) = params(29)*y(47)*T(39);
T(41) = y(70)*y(66)/y(65)/y(69);
T(42) = y(67)/y(65)/y(69);
T(43) = y(68)/y(65)/y(69);
T(44) = y(69)^(params(34)*T(8));
T(45) = y(70)^(params(35)*T(9));
T(46) = T(44)*T(45);
T(47) = y(69)^(params(34)*params(37));
T(48) = y(39)^params(1);

end
