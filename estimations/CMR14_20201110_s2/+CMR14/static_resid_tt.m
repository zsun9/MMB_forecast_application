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

assert(length(T) >= 147);

T(1) = y(26)^params(30)*y(24)^(1-params(30));
T(2) = (y(34));
T(3) = normcdf((log(y(22))+y(38)^2/2)/y(38)-y(38),0,1);
T(4) = normcdf((log(y(22))+y(38)^2/2)/y(38),0,1);
T(5) = y(26)^params(30)*y(24)^(1-params(30));
T(6) = y(26)^params(32)*y(24)^(1-params(32));
T(7) = y(24)*y(19);
T(8) = y(26)^params(32)*y(24)^(1-params(32));
T(9) = y(24)*y(19);
T(10) = normcdf((log(y(22))+y(38)^2/2)/y(38),0,1);
T(11) = normcdf((log(y(22))+y(38)^2/2)/y(38)-y(38),0,1);
T(12) = y(5)*((1-params(83)*(T(1)/y(24))^(1/(1-y(16))))/(1-params(83)))^(1-y(16));
T(13) = y(28)^(y(16)/(y(16)-1))*(y(4)*(y(51)*y(15)/(y(19)*params(81)))^params(16)*(y(10)*y(54)^(params(34)/(params(34)-1)))^(1-params(16))-y(23));
T(14) = y(5)*((1-params(83)*(T(5)/y(24))^(1/(1-y(16))))/(1-params(83)))^(1-y(16));
T(15) = y(6)*y(53)*((1-params(84)*(y(19)^params(31)*params(37)^(1-params(31))*T(8)/T(9))^(1/(1-params(34))))/(1-params(84)))^(1-params(34)*(1+params(59)))/params(44);
T(16) = y(53)*((1-params(84)*(T(6)/T(7)*params(37)^(1-params(31))*y(19)^params(31))^(1/(1-params(34))))/(1-params(84)))^(1-params(34)*(1+params(59)))*y(6)/params(44);
T(17) = T(2)*(exp(params(61)*(y(51)-1))-1)/params(61);
T(18) = (T(3)+y(22)*(1-T(4))-(y(22)*(1-T(4))+T(3)*(1-params(35))))*(1+y(35))*y(29)*y(15)/(y(24)*y(19));
T(19) = exp(sqrt(params(58)/2)*(params(81)*y(19)*y(56)-params(81)*params(37)))+exp((params(81)*y(19)*y(56)-params(81)*params(37))*(-sqrt(params(58)/2)))-2;
T(20) = y(22)*(1-T(10))+T(11);
T(21) = 1-T(10);
T(22) = normpdf((log(y(22))+y(38)^2/2)/y(38),0,1)/y(38);
T(23) = sqrt(params(58)/2)*(exp(sqrt(params(58)/2)*(params(81)*y(19)*y(56)-params(81)*params(37)))-exp((params(81)*y(19)*y(56)-params(81)*params(37))*(-sqrt(params(58)/2))));
T(24) = sqrt(params(58)/2)*(exp(sqrt(params(58)/2)*(params(81)*y(19)*y(56)-params(81)*params(37)))-exp((params(81)*y(19)*y(56)-params(81)*params(37))*(-sqrt(params(58)/2))));
T(25) = normcdf((log(y(22))+y(38)^2/2)/y(38)-2*y(38),0,1);
T(26) = (y(10));
T(27) = normcdf((log((y(22)))+(y(38))^2/2)/(y(38))-(y(38)),0,1);
T(28) = (y(35));
T(29) = (y(15));
T(30) = (y(20));
T(31) = params(25)*((y(1))+(y(12)))/(1-params(25));
T(32) = (y(38));
T(33) = T(1)/y(24);
T(34) = 1/(1-y(16));
T(35) = y(38)^2;
T(36) = (T(3)+y(22)*(1-T(4))-(y(22)*(1-T(4))+T(3)*(1-params(35))))*(1+y(35))*y(29)*y(15);
T(37) = y(54)^(params(34)/(params(34)-1));
T(38) = T(5)/y(24);
T(39) = T(38)^T(34);
T(40) = params(37)^(1-params(31));
T(41) = y(19)^params(31);
T(42) = T(6)/T(7)*T(40)*T(41);
T(43) = 1/(1-params(34));
T(44) = T(41)*T(40)*T(8)/T(9);
T(45) = (1-params(84)*T(44)^T(43))/(1-params(84));
T(46) = T(12)/y(5);
T(47) = y(16)/(1-y(16));
T(48) = T(46)^T(47);
T(49) = (T(33)*y(28))^T(47);
T(50) = (1-params(83))*T(48)+params(83)*T(49);
T(51) = T(50)^((1-y(16))/y(16));
T(52) = params(83)*T(39)*params(20);
T(53) = T(38)^T(47);
T(54) = params(83)*params(20)*T(53);
T(55) = params(84)*params(20)*params(37)^((1-params(31))/(1-params(34)));
T(56) = T(55)*y(19)^(params(31)/(1-params(34))-1);
T(57) = T(6)^T(43);
T(58) = T(56)*T(57)/y(24);
T(59) = params(34)/(1-params(34));
T(60) = (1/T(7))^T(59);
T(61) = T(58)*T(60);
T(62) = (y(10)*T(37))^(1+params(59));
T(63) = params(84)*params(20)*T(42)^(params(34)*(1+params(59))/(1-params(34)));
T(64) = (1-params(84))*T(45)^params(34)+params(84)*(y(54)*T(44))^T(59);
T(65) = (T(37)*y(19)*params(81)*y(10)/(y(51)*y(15)))^(1-params(16));
T(66) = (y(34)/params(16))^params(16);
T(67) = (y(53)/(1-params(16)))^(1-params(16));
T(68) = T(66)*T(67);
T(69) = T(21)/(T(21)-params(35)*T(22));
T(70) = (1+y(35))/(1+y(30))*(T(20)-params(35)*T(11))-1;
T(71) = 1+params(81)*y(19)*y(12)*y(56)*(-T(23))/y(12)-T(19);
T(72) = (params(81)*y(19)*y(56)*y(12)/y(12))^2;
T(73) = params(39)*1/params(45)*(1-params(57))*params(17);
T(74) = (params(22)+params(29))/(1-params(25));
T(75) = y(19)/params(37);
T(76) = (1-params(57))*1/(params(45)*4)*params(18);
T(77) = y(8)/(y(24)*y(19));
T(78) = y(35)-y(30)-(T(3)+y(22)*(1-T(4))-(y(22)*(1-T(4))+T(3)*(1-params(35))))*(1+y(35));
T(79) = T(77)*T(78);
T(80) = y(15)*(1+y(35))*y(29)/y(20);
T(81) = exp(T(35))/(1-T(4));
T(82) = sqrt(T(81)*(1-T(25))-((1-T(3))/(1-T(4)))^2);
T(83) = exp(T(36)/(y(29)*y(15)-y(20))-params(35)*T(27)*(1+T(28))*T(29)/(T(29)-T(30)));
T(84) = params(38)^2;
T(85) = sqrt(1-T(84));
T(86) = params(74)*T(85);
T(87) = params(38)^3;
T(88) = params(38)^4;
T(89) = params(38)^5;
T(90) = params(38)^6;
T(91) = params(38)^7;
T(92) = y(49)/(y(24)*y(19));
T(93) = (params(20)*(1+y(36)))^40;
T(94) = y(55)*T(93);
T(95) = T(92)*T(92)*T(92)*T(92)*T(92)*T(92)*T(92)*T(92)*T(92)*T(92)*y(17)*T(94);
T(96) = T(92)*T(95);
T(97) = T(92)*T(96);
T(98) = T(92)*T(97);
T(99) = T(92)*T(98);
T(100) = T(92)*T(99);
T(101) = T(92)*T(100);
T(102) = T(92)*T(101);
T(103) = T(92)*T(102);
T(104) = T(92)*T(103);
T(105) = T(92)*T(104);
T(106) = T(92)*T(105);
T(107) = T(92)*T(106);
T(108) = T(92)*T(107);
T(109) = T(92)*T(108);
T(110) = T(92)*T(109);
T(111) = T(92)*T(110);
T(112) = T(92)*T(111);
T(113) = T(92)*T(112);
T(114) = T(92)*T(113);
T(115) = T(92)*T(114);
T(116) = T(92)*T(115);
T(117) = T(92)*T(116);
T(118) = T(92)*T(117);
T(119) = T(92)*T(118);
T(120) = T(92)*T(119);
T(121) = T(92)*T(120);
T(122) = T(92)*T(121);
T(123) = T(92)*T(122);
T(124) = T(92)*T(123);
T(125) = T(92)*T(124);
T(126) = (params(20)*y(33))^40;
T(127) = y(55)*T(126);
T(128) = y(17)*T(127)/y(19)/y(19);
T(129) = T(128)/y(19)/y(19);
T(130) = T(129)/y(19)/y(19);
T(131) = T(130)/y(19)/y(19);
T(132) = T(131)/y(19)/y(19);
T(133) = T(132)/y(19)/y(19);
T(134) = T(133)/y(19)/y(19);
T(135) = T(134)/y(19)/y(19);
T(136) = T(135)/y(19)/y(19);
T(137) = T(136)/y(19)/y(19);
T(138) = T(137)/y(19)/y(19);
T(139) = T(138)/y(19)/y(19);
T(140) = T(139)/y(19)/y(19);
T(141) = T(140)/y(19)/y(19);
T(142) = T(141)/y(19)/y(19);
T(143) = T(142)/y(19)/y(19);
T(144) = T(143)/y(19)/y(19);
T(145) = T(144)/y(19)/y(19);
T(146) = T(145)/y(19)/y(19);
T(147) = T(146)/y(19)/y(19);

end
