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
    T = jules1.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(50, 1);
lhs = exp(y(30))+exp(y(46))/exp(y(25))+exp(y(47))+exp(y(53)+y(43))+exp(y(29));
rhs = (1-params(9))*exp(y(53)+y(12)-T(4))+exp(y(59)+y(49))+exp(y(61)+y(51))+(1-1/exp(y(63)))*exp(y(68))+exp(y(16)-y(42)+y(8)-T(1))+T(53)+(1-params(8)+exp(y(56)+y(71)))*exp(y(15)-T(1))+params(33)*exp(y(53))*exp(y(45));
residual(1) = lhs - rhs;
lhs = exp(y(53)+y(57));
rhs = params(4)*exp(y(28)+y(24)-y(43))+(1-params(9))*exp(T(1))*params(1)*exp(T(3)+y(78)+y(81)-T(1));
residual(2) = lhs - rhs;
lhs = exp(y(57));
rhs = exp(T(1))*params(1)*exp(y(81)+y(54)-y(75)-T(1));
residual(3) = lhs - rhs;
lhs = T(54)*(1+params(14)*(exp(y(46)-y(14))-1));
rhs = T(58);
residual(4) = lhs - rhs;
lhs = exp(y(57))*(1+params(15)*(exp(y(47)-y(15))-1));
rhs = T(62);
residual(5) = lhs - rhs;
lhs = T(66);
rhs = exp(y(59)+y(57)-y(64));
residual(6) = lhs - rhs;
lhs = T(68);
rhs = exp(y(61)+y(57)-y(66));
residual(7) = lhs - rhs;
lhs = exp(y(31))+exp(y(53)+y(44))-(1-params(9))*exp(y(53)+y(13)-T(4));
rhs = exp(y(29))+exp(y(60)+y(50))+exp(y(62)+y(52))-exp(y(16)-y(42)+y(8)-T(1));
residual(8) = lhs - rhs;
lhs = exp(y(53)+y(58));
rhs = params(4)*exp(y(28)+y(24)-y(44))+(1-params(9))*exp(T(1))*params(2)*exp(T(3)+y(78)+y(82)-T(1))+params(3)*exp(y(48)+y(75)+T(3)+y(78)-y(54));
residual(9) = lhs - rhs;
lhs = y(29);
rhs = y(75)+y(44)+T(3)+y(78)+log(params(3))-y(54);
residual(10) = lhs - rhs;
lhs = exp(y(58));
rhs = exp(T(1))*params(2)*exp(y(54)-y(75)+y(82)-T(1))+exp(y(48));
residual(11) = lhs - rhs;
lhs = T(72);
rhs = exp(y(60)+y(58)-y(65));
residual(12) = lhs - rhs;
lhs = T(74);
rhs = exp(y(62)+y(58)-y(67));
residual(13) = lhs - rhs;
lhs = y(68);
rhs = (1-params(5))*y(22)+(1-params(5))*params(16)*y(49)+(1-params(5))*(1-params(16))*y(50)+params(5)*(y(70)+y(14)-T(2));
residual(14) = lhs - rhs;
lhs = y(45);
rhs = (1-params(6)-params(43)-params(33))*y(23)+params(43)*(y(45)+y(53)+log(params(43)))+y(51)*params(16)*(1-params(6)-params(43)-params(33))+y(52)*(1-params(16))*(1-params(6)-params(43)-params(33))+params(6)*(y(71)+y(15)-T(1));
residual(15) = lhs - rhs;
lhs = y(68)+log(1-params(5))+log(params(16))-y(63)-y(49);
rhs = y(59);
residual(16) = lhs - rhs;
lhs = y(68)+log(1-params(5))+log(1-params(16))-y(63)-y(50);
rhs = y(60);
residual(17) = lhs - rhs;
lhs = y(45)+y(53)+log(params(16))+log(1-params(6)-params(33)-params(43))-y(51);
rhs = y(61);
residual(18) = lhs - rhs;
lhs = y(45)+y(53)+log(1-params(16))+log(1-params(6)-params(33)-params(43))-y(52);
rhs = y(62);
residual(19) = lhs - rhs;
lhs = T(2)+y(68)+log(params(5))-y(63)-y(14);
rhs = y(55)+y(70);
residual(20) = lhs - rhs;
lhs = T(1)+y(45)+y(53)+log(params(6))-y(15);
rhs = y(56)+y(71);
residual(21) = lhs - rhs;
lhs = y(42)-params(22)*y(11);
rhs = exp(T(1))*params(1)*(y(75)-y(42)*params(22))-(1-params(17))*(1-exp(T(1))*params(1)*params(17))/params(17)*(y(63)-log(params(21)))+x(it_, 6);
residual(22) = lhs - rhs;
lhs = y(54);
rhs = y(16)*params(18)+y(42)*(1-params(18))*params(20)+(1-params(18))*params(19)*(y(69)-y(21))+(1-params(18))*(-log(params(1)))+x(it_, 2)-y(26)/100;
residual(23) = lhs - rhs;
lhs = exp(y(43))+exp(y(44));
rhs = exp(y(45))+(1-params(9))*exp(y(12)-T(4))+(1-params(9))*exp(y(13)-T(4));
residual(24) = lhs - rhs;
lhs = exp(y(57));
rhs = T(76);
residual(25) = lhs - rhs;
lhs = exp(y(58));
rhs = T(78);
residual(26) = lhs - rhs;
lhs = y(59);
rhs = T(79)*y(17)+(1-T(79))*(y(75)+y(83))-y(42)*(1+exp(T(1))*params(1)*params(37))/(1+exp(T(1))*params(1))+y(11)*params(37)/(1+exp(T(1))*params(1))-T(80)*(y(64)-log(params(34)));
residual(27) = lhs - rhs;
lhs = y(60);
rhs = T(81)*y(18)+(1-T(81))*(y(75)+y(84))-y(42)*(1+exp(T(1))*params(2)*params(37))/(1+exp(T(1))*params(2))+y(11)*params(37)/(1+exp(T(1))*params(2))-T(82)*(y(65)-log(params(34)));
residual(28) = lhs - rhs;
lhs = y(61);
rhs = T(79)*y(19)+(1-T(79))*(y(75)+y(85))-y(42)*(1+exp(T(1))*params(1)*params(38))/(1+exp(T(1))*params(1))+y(11)*params(38)/(1+exp(T(1))*params(1))-T(83)*(y(66)-log(params(34)));
residual(29) = lhs - rhs;
lhs = y(62);
rhs = T(81)*y(20)+(1-T(81))*(y(75)+y(86))-y(42)*(1+exp(T(1))*params(2)*params(38))/(1+exp(T(1))*params(2))+y(11)*params(38)/(1+exp(T(1))*params(2))-T(84)*(y(67)-log(params(34)));
residual(30) = lhs - rhs;
lhs = T(85);
rhs = params(39)/(1-params(39))*exp(y(70))+1-params(39)/(1-params(39));
residual(31) = lhs - rhs;
lhs = T(86);
rhs = 1-params(39)/(1-params(39))+params(39)/(1-params(39))*exp(y(71));
residual(32) = lhs - rhs;
lhs = y(32);
rhs = T(1)+log(exp(y(30))+exp(y(31)))-T(47);
residual(33) = lhs - rhs;
lhs = y(33);
rhs = y(42);
residual(34) = lhs - rhs;
lhs = y(34);
rhs = T(4)+y(45)-T(48);
residual(35) = lhs - rhs;
lhs = y(35);
rhs = T(2)+log(T(87))-T(49);
residual(36) = lhs - rhs;
lhs = y(36);
rhs = params(16)*y(49)+(1-params(16))*y(50)-T(50);
residual(37) = lhs - rhs;
lhs = y(37);
rhs = params(16)*y(51)+(1-params(16))*y(52)-T(51);
residual(38) = lhs - rhs;
lhs = y(38);
rhs = T(3)+y(53)-T(52);
residual(39) = lhs - rhs;
lhs = y(39);
rhs = y(54)+log(params(1));
residual(40) = lhs - rhs;
lhs = y(40);
rhs = y(42)+log(exp(y(59))+exp(y(60)))-log(exp(y(17))+exp(y(18)));
residual(41) = lhs - rhs;
lhs = y(41);
rhs = y(42)+log(exp(y(61))+exp(y(62)))-log(exp(y(19))+exp(y(20)));
residual(42) = lhs - rhs;
lhs = y(69);
rhs = T(88)*(y(32)-T(1))+T(89)*(y(35)-T(2))+T(90)*(y(34)-T(4));
residual(43) = lhs - rhs;
lhs = y(22);
rhs = params(23)*y(1)+x(it_, 1);
residual(44) = lhs - rhs;
lhs = y(23);
rhs = params(24)*y(2)+x(it_, 3);
residual(45) = lhs - rhs;
lhs = y(24);
rhs = params(25)*y(3)+x(it_, 4);
residual(46) = lhs - rhs;
lhs = y(25);
rhs = params(26)*y(4)+x(it_, 5);
residual(47) = lhs - rhs;
lhs = y(27);
rhs = params(28)*y(6)+x(it_, 8);
residual(48) = lhs - rhs;
lhs = y(26);
rhs = params(30)*y(5)+x(it_, 7);
residual(49) = lhs - rhs;
lhs = y(28);
rhs = params(29)*y(7)+x(it_, 9);
residual(50) = lhs - rhs;

end
