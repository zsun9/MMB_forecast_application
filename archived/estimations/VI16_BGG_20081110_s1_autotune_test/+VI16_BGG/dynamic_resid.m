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
    T = VI16_BGG.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(43, 1);
lhs = y(62);
rhs = params(2)*y(46)+(1-params(2))*y(43);
residual(1) = lhs - rhs;
lhs = y(35);
rhs = y(46)*T(15);
residual(2) = lhs - rhs;
lhs = y(46);
rhs = y(43)+y(42)-y(3)-y(35);
residual(3) = lhs - rhs;
lhs = y(40);
rhs = T(16)*(y(6)+T(10)*y(71)+1/params(17)*(y(38)+y(64)));
residual(4) = lhs - rhs;
lhs = y(36);
rhs = y(46)*T(4)/T(2)+(1-params(4))/T(2)*(y(38)+y(68))-y(4);
residual(5) = lhs - rhs;
lhs = y(45);
rhs = params(12)*(y(38)+y(37)-y(47));
residual(6) = lhs - rhs;
lhs = y(69);
rhs = y(45)+y(44);
residual(7) = lhs - rhs;
lhs = y(47)/(T(2)*params(1));
rhs = y(36)*T(17)-(T(17)-1)*y(8)-params(12)*(T(17)-1)*(y(3)+y(4))+(1+params(12)*(T(17)-1))*y(9);
residual(8) = lhs - rhs;
lhs = T(18)*y(39);
rhs = T(19)*y(70)+T(18)*y(5)-y(39)*T(19)-y(44);
residual(9) = lhs - rhs;
lhs = y(41);
rhs = y(39)*T(12)+T(9)*y(40)+params(6)*y(63)+y(35)*T(4)*T(13);
residual(10) = lhs - rhs;
lhs = y(41);
rhs = params(40)*(y(62)+params(2)*(y(3)+y(68))+params(2)*y(35)+(1-params(2))*y(42));
residual(11) = lhs - rhs;
lhs = y(43);
rhs = y(39)*T(19)+y(42)*params(41)-T(18)*y(5);
residual(12) = lhs - rhs;
lhs = y(37);
rhs = (1-params(4))*(y(3)+y(68))+T(8)*(y(40)+y(64));
residual(13) = lhs - rhs;
lhs = y(51);
rhs = T(15)*y(49);
residual(14) = lhs - rhs;
lhs = y(49);
rhs = y(60)+y(58)-y(11)-y(51);
residual(15) = lhs - rhs;
lhs = y(56);
rhs = T(16)*(y(14)+T(10)*y(74)+1/params(17)*(y(64)+y(54)));
residual(16) = lhs - rhs;
lhs = y(52);
rhs = T(4)/T(2)*y(49)+(1-params(4))/T(2)*(y(68)+y(54))-y(12);
residual(17) = lhs - rhs;
lhs = y(48);
rhs = params(12)*(y(54)+y(53)-y(50));
residual(18) = lhs - rhs;
lhs = y(72);
rhs = y(48)+y(61)-y(75);
residual(19) = lhs - rhs;
lhs = y(50)/(T(2)*params(1));
rhs = T(17)*y(52)-(T(17)-1)*y(18)-params(12)*(T(17)-1)*(y(11)+y(12))+(1+params(12)*(T(17)-1))*y(10);
residual(20) = lhs - rhs;
lhs = T(18)*y(55);
rhs = T(19)*y(73)+T(18)*y(13)-T(19)*y(55)-y(61);
residual(21) = lhs - rhs;
lhs = y(57);
rhs = params(6)*y(63)+T(12)*y(55)+T(9)*y(56)+T(4)*T(13)*y(51);
residual(22) = lhs - rhs;
lhs = y(57);
rhs = params(40)*(y(62)+params(2)*(y(68)+y(11))+params(2)*y(51)+(1-params(2))*y(58));
residual(23) = lhs - rhs;
lhs = y(59);
rhs = T(20)*(T(10)*y(75)+params(23)*y(16)+T(21)*(params(2)*y(49)-y(62)+(1-params(2))*y(60)))+y(66);
residual(24) = lhs - rhs;
lhs = y(60);
rhs = T(16)*y(17)+T(10)/(1+T(10))*y(76)+y(16)*params(22)/(1+T(10))-y(59)*(1+T(10)*params(22))/(1+T(10))+y(75)*T(10)/(1+T(10))+T(22)*(T(19)*y(55)+params(41)*y(58)-T(18)*y(13)-y(60))+y(67);
residual(25) = lhs - rhs;
lhs = y(61);
rhs = y(59)*(1-params(28))*params(25)+(1-params(28))*params(27)*(y(57)-y(41))+params(26)*(y(57)-y(41)-y(15)+y(7))+params(29)*(y(59)-y(16))+y(18)*params(28)+y(65);
residual(26) = lhs - rhs;
lhs = y(53);
rhs = (1-params(4))*(y(68)+y(11))+T(8)*y(56)+y(64)*T(8)*params(17);
residual(27) = lhs - rhs;
lhs = y(62);
rhs = params(30)*y(19)-x(it_, 1);
residual(28) = lhs - rhs;
lhs = y(63);
rhs = params(32)*y(20)-x(it_, 2)-x(it_, 1)*params(16);
residual(29) = lhs - rhs;
lhs = y(64);
rhs = params(33)*y(21)-x(it_, 3);
residual(30) = lhs - rhs;
lhs = y(65);
rhs = params(34)*y(22)+x(it_, 4);
residual(31) = lhs - rhs;
lhs = y(66);
rhs = params(35)*y(23)+y(34)-params(38)*y(2);
residual(32) = lhs - rhs;
lhs = y(34);
rhs = x(it_, 5);
residual(33) = lhs - rhs;
lhs = y(67);
rhs = params(36)*y(24)+y(33)-params(37)*y(1);
residual(34) = lhs - rhs;
lhs = y(33);
rhs = x(it_, 6);
residual(35) = lhs - rhs;
lhs = y(68);
rhs = params(31)*y(25)+x(it_, 7);
residual(36) = lhs - rhs;
lhs = y(29);
rhs = params(13)+y(57)-y(15);
residual(37) = lhs - rhs;
lhs = y(30);
rhs = params(13)+y(55)-y(13);
residual(38) = lhs - rhs;
lhs = y(31);
rhs = params(13)+y(56)-y(14);
residual(39) = lhs - rhs;
lhs = y(32);
rhs = params(13)+y(60)-y(17);
residual(40) = lhs - rhs;
lhs = y(28);
rhs = params(42)+y(59);
residual(41) = lhs - rhs;
lhs = y(27);
rhs = y(61)+T(14);
residual(42) = lhs - rhs;
lhs = y(26);
rhs = y(58)+params(39);
residual(43) = lhs - rhs;

end
