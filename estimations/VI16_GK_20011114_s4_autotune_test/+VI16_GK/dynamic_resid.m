function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = VI16_GK.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(61, 1);
lhs = (1-T(9))*y(83);
rhs = T(9)*y(23)-y(72);
residual(1) = lhs - rhs;
lhs = y(75);
rhs = y(83)-y(26);
residual(2) = lhs - rhs;
residual(3) = y(100)+y(89);
lhs = y(88);
rhs = params(2)*y(76)-y(83);
residual(4) = lhs - rhs;
lhs = y(78);
rhs = params(1)*params(12)*T(15)*(y(100)+y(80)+y(102))+T(21)*(params(38)*y(79)-T(1)*y(29))+y(100)*T(22);
residual(5) = lhs - rhs;
lhs = y(77);
rhs = T(13)*params(1)*params(12)*(y(100)+y(81)+y(101));
residual(6) = lhs - rhs;
lhs = y(81);
rhs = T(23)*(y(79)*params(38)*T(12)+y(29)*T(1)*(1-T(12))+(params(38)-T(1))*T(12)*y(24));
residual(7) = lhs - rhs;
lhs = y(80);
rhs = y(81)+y(73)-y(24);
residual(8) = lhs - rhs;
lhs = y(73);
rhs = y(101)+y(102)*T(16)/(params(11)-T(16));
residual(9) = lhs - rhs;
lhs = y(85);
rhs = y(81)+y(27);
residual(10) = lhs - rhs;
lhs = y(104)+y(74);
rhs = y(73)+y(84);
residual(11) = lhs - rhs;
lhs = y(84);
rhs = y(85)*T(17)/T(11)+T(10)/T(11)*y(82);
residual(12) = lhs - rhs;
lhs = y(82);
rhs = y(74)+y(86);
residual(13) = lhs - rhs;
lhs = y(71);
rhs = y(103)-y(89);
residual(14) = lhs - rhs;
lhs = y(69);
rhs = params(30)*(y(62)+params(5)*(y(28)+y(66))+params(5)*y(87)+(1-params(5))*y(76));
residual(15) = lhs - rhs;
lhs = y(79);
rhs = T(3)/params(38)*y(90)+(1-params(6))/params(38)*(y(74)+y(66))-y(25);
residual(16) = lhs - rhs;
lhs = y(87);
rhs = y(90)*T(24);
residual(17) = lhs - rhs;
lhs = y(62);
rhs = params(5)*y(90)+(1-params(5))*y(88);
residual(18) = lhs - rhs;
lhs = y(90);
rhs = y(88)+y(76)-y(28)-y(87);
residual(19) = lhs - rhs;
lhs = y(70);
rhs = T(25)*(y(22)+T(14)*y(99)+1/params(14)*(y(74)+y(51)));
residual(20) = lhs - rhs;
lhs = y(86);
rhs = (1-params(6))*(y(28)+y(66))+params(6)*y(70)+y(51)*T(7)*params(14);
residual(21) = lhs - rhs;
lhs = y(69);
rhs = y(72)*T(18)+T(8)*y(70)+params(9)*y(60)+y(87)*T(3)*T(19);
residual(22) = lhs - rhs;
lhs = (1-T(9))*y(54);
rhs = T(9)*y(6)-y(43);
residual(23) = lhs - rhs;
lhs = y(46);
rhs = y(54)-y(10);
residual(24) = lhs - rhs;
residual(25) = y(93)+y(61)-y(92);
lhs = y(59);
rhs = T(25)*y(13)+T(14)/(1+T(14))*y(98)+params(18)/(1+T(14))*y(5)-(1+T(14)*params(18))/(1+T(14))*y(42)+y(92)*T(14)/(1+T(14))+T(26)*(params(2)*y(47)+y(43)*1/(1-T(9))-y(6)*T(9)/(1-T(9))-y(59))+y(65);
residual(26) = lhs - rhs;
lhs = y(49);
rhs = params(1)*params(12)*T(15)*(y(93)+y(63)+y(95))+T(21)*(params(38)*y(50)-T(1)*(y(15)-y(42)))+T(22)*y(93);
residual(27) = lhs - rhs;
lhs = y(48);
rhs = T(13)*params(1)*params(12)*(y(93)+y(52)+y(94));
residual(28) = lhs - rhs;
lhs = y(52);
rhs = T(23)*(params(38)*T(12)*y(50)+T(1)*(1-T(12))*(y(15)-y(42))+(params(38)-T(1))*T(12)*y(7));
residual(29) = lhs - rhs;
lhs = y(63);
rhs = y(52)+y(44)-y(7);
residual(30) = lhs - rhs;
lhs = y(44);
rhs = y(94)+T(16)/(params(11)-T(16))*y(95);
residual(31) = lhs - rhs;
lhs = y(56);
rhs = y(52)+y(11);
residual(32) = lhs - rhs;
lhs = y(97)+y(45);
rhs = y(44)+y(55);
residual(33) = lhs - rhs;
lhs = y(55);
rhs = T(17)/T(11)*y(56)+T(10)/T(11)*y(53);
residual(34) = lhs - rhs;
lhs = y(53);
rhs = y(45)+y(57);
residual(35) = lhs - rhs;
lhs = y(41);
rhs = y(96)-(y(61)-y(92));
residual(36) = lhs - rhs;
lhs = y(39);
rhs = params(30)*(y(62)+params(5)*(y(66)+y(12))+params(5)*y(58)+(1-params(5))*y(47));
residual(37) = lhs - rhs;
lhs = y(50);
rhs = T(3)/params(38)*y(67)+(1-params(6))/params(38)*(y(66)+y(45))-y(8);
residual(38) = lhs - rhs;
lhs = y(58);
rhs = T(24)*y(67);
residual(39) = lhs - rhs;
lhs = y(67);
rhs = y(59)+y(47)-y(12)-y(58);
residual(40) = lhs - rhs;
lhs = y(40);
rhs = T(25)*(y(4)+T(14)*y(91)+1/params(14)*(y(51)+y(45)));
residual(41) = lhs - rhs;
lhs = y(57);
rhs = y(51)*T(7)*params(14)+(1-params(6))*(y(66)+y(12))+params(6)*y(40);
residual(42) = lhs - rhs;
lhs = y(39);
rhs = params(9)*y(60)+T(18)*y(43)+T(8)*y(40)+T(3)*T(19)*y(58);
residual(43) = lhs - rhs;
lhs = y(42);
rhs = T(27)*(T(14)*y(92)+y(5)*params(16)+T(28)*(params(5)*y(67)-y(62)+(1-params(5))*y(59)))+y(64);
residual(44) = lhs - rhs;
lhs = y(61);
rhs = y(15)*params(21)+(1-params(21))*(y(42)*params(22)+params(23)*(y(39)-y(69)))+params(32)*(y(39)-y(69)-y(3)+y(21))+params(33)*(y(42)-y(5))+y(68);
residual(45) = lhs - rhs;
lhs = y(62);
rhs = params(24)*y(16)-x(it_, 5);
residual(46) = lhs - rhs;
lhs = y(51);
rhs = params(26)*y(9)-x(it_, 1);
residual(47) = lhs - rhs;
lhs = y(60);
rhs = params(25)*y(14)-x(it_, 4);
residual(48) = lhs - rhs;
lhs = y(68);
rhs = params(37)*y(20)+x(it_, 2);
residual(49) = lhs - rhs;
lhs = y(64);
rhs = params(29)*y(17)+y(38)-params(35)*y(2);
residual(50) = lhs - rhs;
lhs = y(38);
rhs = x(it_, 7);
residual(51) = lhs - rhs;
lhs = y(65);
rhs = params(28)*y(18)+y(37)-params(34)*y(1);
residual(52) = lhs - rhs;
lhs = y(37);
rhs = x(it_, 6);
residual(53) = lhs - rhs;
lhs = y(66);
rhs = params(27)*y(19)-x(it_, 3);
residual(54) = lhs - rhs;
lhs = y(33);
rhs = params(41)+y(39)-y(3);
residual(55) = lhs - rhs;
lhs = y(34);
rhs = params(41)+y(43)-y(6);
residual(56) = lhs - rhs;
lhs = y(35);
rhs = params(41)+y(40)-y(4);
residual(57) = lhs - rhs;
lhs = y(36);
rhs = params(41)+y(59)-y(13);
residual(58) = lhs - rhs;
lhs = y(32);
rhs = params(40)+y(42);
residual(59) = lhs - rhs;
lhs = y(31);
rhs = y(61)+T(20);
residual(60) = lhs - rhs;
lhs = y(30);
rhs = y(47)+params(39);
residual(61) = lhs - rhs;

end
