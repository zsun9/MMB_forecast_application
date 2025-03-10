function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
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
%   g1
%

if T_flag
    T = IN10.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(50, 97);
g1(1,25)=(-(exp(y(46))*exp(y(25))))/(exp(y(25))*exp(y(25)))-exp(y(14)-T(2))*(-((1-params(7))*exp(y(25))))/(exp(y(25))*exp(y(25)));
g1(1,8)=(-exp(y(16)-y(42)+y(8)-T(1)));
g1(1,29)=exp(y(29));
g1(1,30)=exp(y(30));
g1(1,42)=exp(y(16)-y(42)+y(8)-T(1));
g1(1,12)=(-((1-params(9))*exp(y(53)+y(12)-T(4))));
g1(1,43)=exp(y(53)+y(43));
g1(1,45)=(-(params(33)*exp(y(53))*exp(y(45))));
g1(1,14)=(-T(53));
g1(1,46)=exp(y(46))/exp(y(25));
g1(1,15)=(-((1-params(8)+exp(y(56)+y(71)))*exp(y(15)-T(1))));
g1(1,47)=exp(y(47));
g1(1,49)=(-exp(y(59)+y(49)));
g1(1,51)=(-exp(y(61)+y(51)));
g1(1,53)=exp(y(53)+y(43))-((1-params(9))*exp(y(53)+y(12)-T(4))+params(33)*exp(y(53))*exp(y(45)));
g1(1,16)=(-exp(y(16)-y(42)+y(8)-T(1)));
g1(1,55)=(-(exp(y(55)+y(70))*exp(y(14)-T(2))));
g1(1,56)=(-(exp(y(56)+y(71))*exp(y(15)-T(1))));
g1(1,59)=(-exp(y(59)+y(49)));
g1(1,61)=(-exp(y(61)+y(51)));
g1(1,63)=(-(exp(y(68))*(-((-exp(y(63)))/(exp(y(63))*exp(y(63)))))));
g1(1,68)=(-((1-1/exp(y(63)))*exp(y(68))));
g1(1,70)=(-(exp(y(55)+y(70))*exp(y(14)-T(2))));
g1(1,71)=(-(exp(y(56)+y(71))*exp(y(15)-T(1))));
g1(2,24)=(-(params(4)*exp(y(28)+y(24)-y(43))));
g1(2,28)=(-(params(4)*exp(y(28)+y(24)-y(43))));
g1(2,43)=(-(params(4)*(-exp(y(28)+y(24)-y(43)))));
g1(2,53)=exp(y(53)+y(57));
g1(2,78)=(-((1-params(9))*exp(T(1))*params(1)*exp(T(3)+y(78)+y(81)-T(1))));
g1(2,57)=exp(y(53)+y(57));
g1(2,81)=(-((1-params(9))*exp(T(1))*params(1)*exp(T(3)+y(78)+y(81)-T(1))));
g1(3,75)=(-(exp(T(1))*params(1)*(-exp(y(81)+y(54)-y(75)-T(1)))));
g1(3,54)=(-(exp(T(1))*params(1)*exp(y(81)+y(54)-y(75)-T(1))));
g1(3,57)=exp(y(57));
g1(3,81)=(-(exp(T(1))*params(1)*exp(y(81)+y(54)-y(75)-T(1))));
g1(4,25)=(1+params(14)*(exp(y(46)-y(14))-1))*(-(exp(y(25))*exp(y(57))))/(exp(y(25))*exp(y(25)));
g1(4,72)=(-(exp(T(1))*params(1)*exp(y(81)-T(2))*(-((1-params(7))*exp(y(72))))/(exp(y(72))*exp(y(72)))));
g1(4,14)=T(54)*params(14)*(-exp(y(46)-y(14)));
g1(4,46)=T(54)*params(14)*exp(y(46)-y(14))-exp(T(1))*params(1)*exp(y(81)-T(2))*T(55)*(-(T(56)*exp(y(46))*2*exp(y(46))))/(T(57)*T(57));
g1(4,76)=(-(exp(T(1))*params(1)*exp(y(81)-T(2))*T(55)*exp(y(76))*2*exp(y(76))/T(57)));
g1(4,79)=(-(exp(T(1))*params(1)*exp(y(81)-T(2))*exp(y(79)+y(87))));
g1(4,57)=T(54)*(1+params(14)*(exp(y(46)-y(14))-1));
g1(4,81)=(-T(58));
g1(4,87)=(-(exp(T(1))*params(1)*exp(y(81)-T(2))*exp(y(79)+y(87))));
g1(5,15)=exp(y(57))*params(15)*(-exp(y(47)-y(15)));
g1(5,47)=exp(y(57))*params(15)*exp(y(47)-y(15))-exp(T(1))*params(1)*exp(y(81)-T(1))*T(59)*(-(T(60)*exp(y(47))*2*exp(y(47))))/(T(61)*T(61));
g1(5,77)=(-(exp(T(1))*params(1)*exp(y(81)-T(1))*T(59)*exp(y(77))*2*exp(y(77))/T(61)));
g1(5,80)=(-(exp(T(1))*params(1)*exp(y(81)-T(1))*exp(y(80)+y(88))));
g1(5,57)=exp(y(57))*(1+params(15)*(exp(y(47)-y(15))-1));
g1(5,81)=(-T(62));
g1(5,88)=(-(exp(T(1))*params(1)*exp(y(81)-T(1))*exp(y(80)+y(88))));
g1(6,27)=T(66);
g1(6,28)=T(66);
g1(6,49)=T(65)*T(92)+T(64)*exp(y(49))*getPowerDeriv(exp(y(49)),(-params(31)),1);
g1(6,51)=T(65)*T(95);
g1(6,57)=(-exp(y(59)+y(57)-y(64)));
g1(6,59)=(-exp(y(59)+y(57)-y(64)));
g1(6,64)=exp(y(59)+y(57)-y(64));
g1(7,27)=T(68);
g1(7,28)=T(68);
g1(7,49)=T(67)*T(92);
g1(7,51)=T(67)*T(95)+T(64)*exp(y(51))*getPowerDeriv(exp(y(51)),(-params(31)),1);
g1(7,57)=(-exp(y(61)+y(57)-y(66)));
g1(7,61)=(-exp(y(61)+y(57)-y(66)));
g1(7,66)=exp(y(61)+y(57)-y(66));
g1(8,8)=exp(y(16)-y(42)+y(8)-T(1));
g1(8,29)=(-exp(y(29)));
g1(8,31)=exp(y(31));
g1(8,42)=(-exp(y(16)-y(42)+y(8)-T(1)));
g1(8,13)=(-((1-params(9))*exp(y(53)+y(13)-T(4))));
g1(8,44)=exp(y(53)+y(44));
g1(8,50)=(-exp(y(60)+y(50)));
g1(8,52)=(-exp(y(62)+y(52)));
g1(8,53)=exp(y(53)+y(44))-(1-params(9))*exp(y(53)+y(13)-T(4));
g1(8,16)=exp(y(16)-y(42)+y(8)-T(1));
g1(8,60)=(-exp(y(60)+y(50)));
g1(8,62)=(-exp(y(62)+y(52)));
g1(9,24)=(-(params(4)*exp(y(28)+y(24)-y(44))));
g1(9,28)=(-(params(4)*exp(y(28)+y(24)-y(44))));
g1(9,75)=(-(params(3)*exp(y(48)+y(75)+T(3)+y(78)-y(54))));
g1(9,44)=(-(params(4)*(-exp(y(28)+y(24)-y(44)))));
g1(9,48)=(-(params(3)*exp(y(48)+y(75)+T(3)+y(78)-y(54))));
g1(9,53)=exp(y(53)+y(58));
g1(9,78)=(-((1-params(9))*exp(T(1))*params(2)*exp(T(3)+y(78)+y(82)-T(1))+params(3)*exp(y(48)+y(75)+T(3)+y(78)-y(54))));
g1(9,54)=(-(params(3)*(-exp(y(48)+y(75)+T(3)+y(78)-y(54)))));
g1(9,58)=exp(y(53)+y(58));
g1(9,82)=(-((1-params(9))*exp(T(1))*params(2)*exp(T(3)+y(78)+y(82)-T(1))));
g1(10,29)=1;
g1(10,75)=(-1);
g1(10,44)=(-1);
g1(10,78)=(-1);
g1(10,54)=1;
g1(11,75)=(-(exp(T(1))*params(2)*(-exp(y(54)-y(75)+y(82)-T(1)))));
g1(11,48)=(-exp(y(48)));
g1(11,54)=(-(exp(T(1))*params(2)*exp(y(54)-y(75)+y(82)-T(1))));
g1(11,58)=exp(y(58));
g1(11,82)=(-(exp(T(1))*params(2)*exp(y(54)-y(75)+y(82)-T(1))));
g1(12,27)=T(72);
g1(12,28)=T(72);
g1(12,50)=T(71)*T(94)+T(70)*exp(y(50))*getPowerDeriv(exp(y(50)),(-params(32)),1);
g1(12,52)=T(71)*T(96);
g1(12,58)=(-exp(y(60)+y(58)-y(65)));
g1(12,60)=(-exp(y(60)+y(58)-y(65)));
g1(12,65)=exp(y(60)+y(58)-y(65));
g1(13,27)=T(74);
g1(13,28)=T(74);
g1(13,50)=T(73)*T(94);
g1(13,52)=T(73)*T(96)+T(70)*exp(y(52))*getPowerDeriv(exp(y(52)),(-params(32)),1);
g1(13,58)=(-exp(y(62)+y(58)-y(67)));
g1(13,62)=(-exp(y(62)+y(58)-y(67)));
g1(13,67)=exp(y(62)+y(58)-y(67));
g1(14,22)=(-(1-params(5)));
g1(14,14)=(-params(5));
g1(14,49)=(-((1-params(5))*params(16)));
g1(14,50)=(-((1-params(5))*(1-params(16))));
g1(14,68)=1;
g1(14,70)=(-params(5));
g1(15,23)=(-(1-params(6)-params(43)-params(33)));
g1(15,45)=1-params(43);
g1(15,15)=(-params(6));
g1(15,51)=(-(params(16)*(1-params(6)-params(43)-params(33))));
g1(15,52)=(-((1-params(16))*(1-params(6)-params(43)-params(33))));
g1(15,53)=(-params(43));
g1(15,71)=(-params(6));
g1(16,49)=(-1);
g1(16,59)=(-1);
g1(16,63)=(-1);
g1(16,68)=1;
g1(17,50)=(-1);
g1(17,60)=(-1);
g1(17,63)=(-1);
g1(17,68)=1;
g1(18,45)=1;
g1(18,51)=(-1);
g1(18,53)=1;
g1(18,61)=(-1);
g1(19,45)=1;
g1(19,52)=(-1);
g1(19,53)=1;
g1(19,62)=(-1);
g1(20,14)=(-1);
g1(20,55)=(-1);
g1(20,63)=(-1);
g1(20,68)=1;
g1(20,70)=(-1);
g1(21,45)=1;
g1(21,15)=(-1);
g1(21,53)=1;
g1(21,56)=(-1);
g1(21,71)=(-1);
g1(22,11)=(-params(22));
g1(22,42)=1-exp(T(1))*params(1)*(-params(22));
g1(22,75)=(-(exp(T(1))*params(1)));
g1(22,63)=(1-params(17))*(1-exp(T(1))*params(1)*params(17))/params(17);
g1(22,94)=(-1);
g1(23,26)=0.01;
g1(23,42)=(-((1-params(18))*params(20)));
g1(23,16)=(-params(18));
g1(23,54)=1;
g1(23,21)=(1-params(18))*params(19);
g1(23,69)=(-((1-params(18))*params(19)));
g1(23,90)=(-1);
g1(24,12)=(-((1-params(9))*exp(y(12)-T(4))));
g1(24,43)=exp(y(43));
g1(24,13)=(-((1-params(9))*exp(y(13)-T(4))));
g1(24,44)=exp(y(44));
g1(24,45)=(-exp(y(45)));
g1(25,28)=(-T(76));
g1(25,9)=(-(exp(y(28))*T(75)*params(12)*exp(y(9)-T(1))/((exp(y(30))-params(12)*exp(y(9)-T(1)))*(exp(y(30))-params(12)*exp(y(9)-T(1))))));
g1(25,30)=(-(exp(y(28))*T(75)*((-exp(y(30)))/((exp(y(30))-params(12)*exp(y(9)-T(1)))*(exp(y(30))-params(12)*exp(y(9)-T(1))))-(-(exp(T(1))*params(1)*params(12)*(-(exp(y(30))*params(12)))))/((exp(T(1)+y(73))-exp(y(30))*params(12))*(exp(T(1)+y(73))-exp(y(30))*params(12))))));
g1(25,73)=(-(exp(y(28))*T(75)*(-((-(exp(T(1))*params(1)*params(12)*exp(T(1)+y(73))))/((exp(T(1)+y(73))-exp(y(30))*params(12))*(exp(T(1)+y(73))-exp(y(30))*params(12)))))));
g1(25,57)=exp(y(57));
g1(26,28)=(-T(78));
g1(26,10)=(-(exp(y(28))*T(77)*params(13)*exp(y(10)-T(1))/((exp(y(31))-params(13)*exp(y(10)-T(1)))*(exp(y(31))-params(13)*exp(y(10)-T(1))))));
g1(26,31)=(-(exp(y(28))*T(77)*((-exp(y(31)))/((exp(y(31))-params(13)*exp(y(10)-T(1)))*(exp(y(31))-params(13)*exp(y(10)-T(1))))-(-(exp(T(1))*params(2)*params(13)*(-(exp(y(31))*params(13)))))/((exp(T(1)+y(74))-exp(y(31))*params(13))*(exp(T(1)+y(74))-exp(y(31))*params(13))))));
g1(26,74)=(-(exp(y(28))*T(77)*(-((-(exp(T(1))*params(2)*params(13)*exp(T(1)+y(74))))/((exp(T(1)+y(74))-exp(y(31))*params(13))*(exp(T(1)+y(74))-exp(y(31))*params(13)))))));
g1(26,58)=exp(y(58));
g1(27,11)=(-(params(37)/(1+exp(T(1))*params(1))));
g1(27,42)=(1+exp(T(1))*params(1)*params(37))/(1+exp(T(1))*params(1));
g1(27,75)=(-(1-T(79)));
g1(27,17)=(-T(79));
g1(27,59)=1;
g1(27,83)=(-(1-T(79)));
g1(27,64)=T(80);
g1(28,11)=(-(params(37)/(1+exp(T(1))*params(2))));
g1(28,42)=(1+exp(T(1))*params(2)*params(37))/(1+exp(T(1))*params(2));
g1(28,75)=(-(1-T(81)));
g1(28,18)=(-T(81));
g1(28,60)=1;
g1(28,84)=(-(1-T(81)));
g1(28,65)=T(82);
g1(29,11)=(-(params(38)/(1+exp(T(1))*params(1))));
g1(29,42)=(1+exp(T(1))*params(1)*params(38))/(1+exp(T(1))*params(1));
g1(29,75)=(-(1-T(79)));
g1(29,19)=(-T(79));
g1(29,61)=1;
g1(29,85)=(-(1-T(79)));
g1(29,66)=T(83);
g1(30,11)=(-(params(38)/(1+exp(T(1))*params(2))));
g1(30,42)=(1+exp(T(1))*params(2)*params(38))/(1+exp(T(1))*params(2));
g1(30,75)=(-(1-T(81)));
g1(30,20)=(-T(81));
g1(30,62)=1;
g1(30,86)=(-(1-T(81)));
g1(30,67)=T(84);
g1(31,25)=T(85);
g1(31,55)=T(85);
g1(31,70)=(-(params(39)/(1-params(39))*exp(y(70))));
g1(32,56)=T(86);
g1(32,71)=(-(params(39)/(1-params(39))*exp(y(71))));
g1(33,30)=(-(exp(y(30))/(exp(y(30))+exp(y(31)))));
g1(33,31)=(-(exp(y(31))/(exp(y(30))+exp(y(31)))));
g1(33,32)=1;
g1(34,33)=1;
g1(34,42)=(-1);
g1(35,34)=1;
g1(35,45)=(-1);
g1(36,35)=1;
g1(36,14)=(-((-((1-params(7))*exp(y(14)-T(2))))/T(87)));
g1(36,46)=(-(exp(y(46))/T(87)));
g1(36,15)=(-((-((1-params(8))*exp(y(15)-T(1))))/T(87)));
g1(36,47)=(-(exp(y(47))/T(87)));
g1(37,36)=1;
g1(37,49)=(-params(16));
g1(37,50)=(-(1-params(16)));
g1(38,37)=1;
g1(38,51)=(-params(16));
g1(38,52)=(-(1-params(16)));
g1(39,38)=1;
g1(39,53)=(-1);
g1(40,39)=1;
g1(40,54)=(-1);
g1(41,40)=1;
g1(41,42)=(-1);
g1(41,17)=exp(y(17))/(exp(y(17))+exp(y(18)));
g1(41,59)=(-(exp(y(59))/(exp(y(59))+exp(y(60)))));
g1(41,18)=exp(y(18))/(exp(y(17))+exp(y(18)));
g1(41,60)=(-(exp(y(60))/(exp(y(59))+exp(y(60)))));
g1(42,41)=1;
g1(42,42)=(-1);
g1(42,19)=exp(y(19))/(exp(y(19))+exp(y(20)));
g1(42,61)=(-(exp(y(61))/(exp(y(61))+exp(y(62)))));
g1(42,20)=exp(y(20))/(exp(y(19))+exp(y(20)));
g1(42,62)=(-(exp(y(62))/(exp(y(61))+exp(y(62)))));
g1(43,32)=(-T(88));
g1(43,34)=(-T(90));
g1(43,35)=(-T(89));
g1(43,69)=1;
g1(44,1)=(-params(23));
g1(44,22)=1;
g1(44,89)=(-1);
g1(45,2)=(-params(24));
g1(45,23)=1;
g1(45,91)=(-1);
g1(46,3)=(-params(25));
g1(46,24)=1;
g1(46,92)=(-1);
g1(47,4)=(-params(26));
g1(47,25)=1;
g1(47,93)=(-1);
g1(48,6)=(-params(28));
g1(48,27)=1;
g1(48,96)=(-1);
g1(49,5)=(-params(30));
g1(49,26)=1;
g1(49,95)=(-1);
g1(50,7)=(-params(29));
g1(50,28)=1;
g1(50,97)=(-1);

end
