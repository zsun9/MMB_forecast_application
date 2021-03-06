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
    T = DNGS15.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(49, 1);
lhs = y(25);
rhs = T(1)*(y(32)-y(76))+y(42)+T(2)*(y(2)-y(40))+T(3)*(y(73)+y(79))+T(4)*(y(29)-y(75));
residual(1) = lhs - rhs;
lhs = y(58);
rhs = y(42)+T(1)*y(63)+T(2)*(y(19)-y(40))+T(3)*(y(79)+y(80))+T(4)*(y(62)-y(82));
residual(2) = lhs - rhs;
lhs = y(37);
rhs = T(5)*(y(26)-T(6)*(y(3)-y(40))-T(7)*(y(79)+y(74))-y(47));
residual(3) = lhs - rhs;
lhs = y(67);
rhs = T(5)*(y(59)-T(6)*(y(20)-y(40))-T(7)*(y(79)+y(81))-y(47));
residual(4) = lhs - rhs;
lhs = y(38)-y(31);
rhs = T(8)*y(33)+y(37)*T(9)-y(8);
residual(5) = lhs - rhs;
lhs = y(78)-y(32);
rhs = y(42)*T(10)+params(9)*(y(37)+y(28)-y(39))+y(46);
residual(6) = lhs - rhs;
lhs = y(39);
rhs = (y(38)-y(31))*params(91)-params(92)*(y(6)-y(31))+params(93)*(y(8)+y(4))+params(94)*y(9)-params(96)/params(84)*y(15)-y(40)*params(10)*params(76)/params(75);
residual(7) = lhs - rhs;
lhs = T(8)*y(83)+T(9)*y(84)-y(67);
rhs = y(63)-y(42)*T(11);
residual(8) = lhs - rhs;
lhs = y(24);
rhs = params(13)*(params(12)*y(27)+y(29)*(1-params(12)))+(params(13)-1)/(1-params(12))*y(41);
residual(9) = lhs - rhs;
lhs = y(57);
rhs = (params(13)-1)/(1-params(12))*y(41)+params(13)*(params(12)*y(60)+y(62)*(1-params(12)));
residual(10) = lhs - rhs;
lhs = y(27);
rhs = y(4)+y(34)-y(40);
residual(11) = lhs - rhs;
lhs = y(60);
rhs = y(65)-y(40)+y(21);
residual(12) = lhs - rhs;
lhs = y(34);
rhs = y(33)*(1-params(21))/params(21);
residual(13) = lhs - rhs;
lhs = y(65);
rhs = (1-params(21))/params(21)*y(64);
residual(14) = lhs - rhs;
lhs = y(28);
rhs = (1-T(12))*(y(4)-y(40))+y(26)*T(12)+T(14);
residual(15) = lhs - rhs;
lhs = y(61);
rhs = T(14)+(1-T(12))*(y(21)-y(40))+y(59)*T(12);
residual(16) = lhs - rhs;
lhs = y(30);
rhs = y(35)+y(29)*params(12)-params(12)*y(27);
residual(17) = lhs - rhs;
lhs = 0;
rhs = y(66)+y(62)*params(12)-params(12)*y(60);
residual(18) = lhs - rhs;
lhs = y(31);
rhs = y(30)*T(15)+params(6)/(1+exp(params(45)*(1-params(20)))*params(41)*params(6))*y(5)+y(76)*T(16)+y(44);
residual(19) = lhs - rhs;
lhs = y(27);
rhs = y(29)+y(35)-y(33);
residual(20) = lhs - rhs;
lhs = y(60);
rhs = y(62)+y(66)-y(64);
residual(21) = lhs - rhs;
lhs = y(36)-y(35);
rhs = y(25)*T(17)+y(2)*T(18)-y(40)*T(18)-y(29)*params(15);
residual(22) = lhs - rhs;
lhs = 0;
rhs = y(66)+y(58)*T(17)+y(19)*T(18)-y(40)*T(18)-y(62)*params(15);
residual(23) = lhs - rhs;
lhs = y(35);
rhs = y(36)*T(19)-y(31)*T(20)+T(6)*(y(7)-y(40)-y(5)*params(8))+T(7)*(y(76)+y(79)+y(77))+y(45);
residual(24) = lhs - rhs;
lhs = y(32);
rhs = y(6)*params(4)+(1-params(4))*(y(31)*params(1)+params(2)*(y(24)-y(57)))+params(3)*(y(24)-y(57)-(y(1)-y(18)))+y(48);
residual(25) = lhs - rhs;
lhs = y(24);
rhs = params(24)*y(43)+y(25)*params(55)/params(54)+y(26)*params(53)/params(54)+y(34)*params(48)*params(51)/params(54)+y(41)*params(24)*T(21);
residual(26) = lhs - rhs;
lhs = y(57);
rhs = y(41)*params(24)*T(21)+params(24)*y(43)+y(58)*params(55)/params(54)+y(59)*params(53)/params(54)+y(65)*params(48)*params(51)/params(54);
residual(27) = lhs - rhs;
lhs = y(40);
rhs = T(21)*(params(30)-1)*y(10)+T(21)*x(it_, 1);
residual(28) = lhs - rhs;
lhs = y(41);
rhs = x(it_, 1)+params(30)*y(10);
residual(29) = lhs - rhs;
lhs = y(43);
rhs = params(35)*y(12)+x(it_, 2)+x(it_, 1)*params(38);
residual(30) = lhs - rhs;
lhs = y(42);
rhs = params(31)*y(11)+x(it_, 3);
residual(31) = lhs - rhs;
lhs = y(47);
rhs = params(34)*y(16)+x(it_, 4);
residual(32) = lhs - rhs;
lhs = y(44);
rhs = params(32)*y(13)+x(it_, 5)-params(36)*y(22);
residual(33) = lhs - rhs;
lhs = y(45);
rhs = params(33)*y(14)+x(it_, 6)-params(37)*y(23);
residual(34) = lhs - rhs;
lhs = y(48);
rhs = params(40)*y(17)+x(it_, 8);
residual(35) = lhs - rhs;
lhs = y(46);
rhs = y(15)*params(39)+x(it_, 7);
residual(36) = lhs - rhs;
lhs = y(68);
rhs = y(24)-y(57);
residual(37) = lhs - rhs;
lhs = y(69)/4;
rhs = y(63)+params(47)-100*(params(42)-1);
residual(38) = lhs - rhs;
lhs = y(70)/4;
rhs = y(32)-y(76)+params(47)-100*(params(42)-1);
residual(39) = lhs - rhs;
lhs = y(49);
rhs = y(40)+y(24)-y(1)+100*(exp(params(45))-1);
residual(40) = lhs - rhs;
lhs = y(54);
rhs = 100*(exp(params(45))-1)+y(40)+y(25)-y(2);
residual(41) = lhs - rhs;
lhs = y(55);
rhs = 100*(exp(params(45))-1)+y(40)+y(26)-y(3);
residual(42) = lhs - rhs;
lhs = y(51);
rhs = 100*(exp(params(45))-1)+y(40)+y(35)-y(7);
residual(43) = lhs - rhs;
lhs = y(53);
rhs = y(32)+params(47);
residual(44) = lhs - rhs;
lhs = y(52);
rhs = y(31)+100*(params(42)-1);
residual(45) = lhs - rhs;
lhs = y(56);
rhs = y(78)-y(32)+100*log(params(43));
residual(46) = lhs - rhs;
lhs = y(50);
rhs = y(29)+params(22);
residual(47) = lhs - rhs;
lhs = y(71);
rhs = x(it_, 5);
residual(48) = lhs - rhs;
lhs = y(72);
rhs = x(it_, 6);
residual(49) = lhs - rhs;

end
