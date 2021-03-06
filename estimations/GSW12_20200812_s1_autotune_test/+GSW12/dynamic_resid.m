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
    T = GSW12.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(51, 1);
lhs = y(45);
rhs = params(13)*(params(7)*y(54)+(1-params(7))*y(51)+y(62));
residual(1) = lhs - rhs;
lhs = y(49);
rhs = y(85)+y(50)-y(60)*T(5);
residual(2) = lhs - rhs;
lhs = y(49);
rhs = y(46)*(-params(11))/(1-T(4))+y(11)*T(6)+y(51)*T(12);
residual(3) = lhs - rhs;
lhs = y(47);
rhs = y(61)+T(13)*(y(12)+y(84)*T(1)*T(7)+y(52)*1/T(15));
residual(4) = lhs - rhs;
lhs = y(52);
rhs = T(17)-y(50)+y(87)*T(7)*T(8)+y(86)*(1-params(10))*T(7);
residual(5) = lhs - rhs;
lhs = y(45);
rhs = y(59)+y(46)*T(11)+y(47)*T(10)+y(48)*T(8)*T(9);
residual(6) = lhs - rhs;
lhs = y(54);
rhs = y(48)+y(13);
residual(7) = lhs - rhs;
lhs = y(48);
rhs = T(3)*y(53);
residual(8) = lhs - rhs;
lhs = y(55);
rhs = y(13)*(1-T(18))+y(47)*T(18)+y(61)*T(15)*T(18);
residual(9) = lhs - rhs;
lhs = y(62);
rhs = params(7)*y(53)+(1-params(7))*y(56);
residual(10) = lhs - rhs;
lhs = y(53);
rhs = y(51)+y(56)-y(54);
residual(11) = lhs - rhs;
lhs = y(57);
rhs = (1-params(33))*y(14)+T(19)*(y(46)-y(11)*T(4));
residual(12) = lhs - rhs;
lhs = y(56);
rhs = y(68)+y(57)+y(51)*params(18)-(y(46)-y(11)*T(4))*T(20)-y(49);
residual(13) = lhs - rhs;
lhs = y(58);
rhs = y(15)+T(2)*(y(88)-y(58))+(y(51)-y(58))*T(21);
residual(14) = lhs - rhs;
lhs = y(26);
rhs = y(59)+y(27)*T(11)+y(28)*T(10)+y(29)*T(8)*T(9);
residual(15) = lhs - rhs;
lhs = y(30);
rhs = y(78)+y(31)-y(79)-y(60)*T(5);
residual(16) = lhs - rhs;
lhs = y(30);
rhs = y(27)*(-params(11))/(1-T(4))+y(2)*T(6)+y(33)*T(12);
residual(17) = lhs - rhs;
lhs = y(28);
rhs = y(61)+T(13)*(y(3)+y(77)*T(1)*T(7)+y(34)*1/T(15));
residual(18) = lhs - rhs;
lhs = y(34);
rhs = y(79)-y(31)+T(17)+y(81)*T(7)*T(8)+y(80)*(1-params(10))*T(7);
residual(19) = lhs - rhs;
lhs = y(26);
rhs = params(13)*(y(62)+params(7)*y(36)+(1-params(7))*y(33));
residual(20) = lhs - rhs;
lhs = y(36);
rhs = y(29)+y(6);
residual(21) = lhs - rhs;
lhs = y(29);
rhs = T(3)*y(35);
residual(22) = lhs - rhs;
lhs = y(37);
rhs = y(6)*(1-T(18))+y(28)*T(18)+y(61)*params(9)*T(14)*T(18);
residual(23) = lhs - rhs;
lhs = y(38);
rhs = params(7)*y(35)+(1-params(7))*y(39)-y(62);
residual(24) = lhs - rhs;
lhs = y(32);
rhs = y(63)+T(22)*(params(16)*y(5)+y(79)*T(1)*T(7)+y(38)*T(23));
residual(25) = lhs - rhs;
lhs = y(35);
rhs = y(33)+y(39)-y(36);
residual(26) = lhs - rhs;
lhs = y(39);
rhs = y(65)+y(7)*T(13)+(y(79)+y(82))*T(1)*T(7)/(1+T(1)*T(7))-y(32)*(1+params(14)*T(1)*T(7))/(1+T(1)*T(7))+y(5)*params(14)/(1+T(1)*T(7))-y(40)*T(24);
residual(27) = lhs - rhs;
lhs = y(31);
rhs = y(32)*params(20)*(1-params(23))+(1-params(23))*params(22)*(y(26)-y(45))+params(21)*(y(26)-y(45)-y(1)+y(10))+params(23)*y(4)+y(67);
residual(28) = lhs - rhs;
lhs = y(41);
rhs = (1-params(33))*y(8)+T(19)*(y(27)-y(2)*T(4));
residual(29) = lhs - rhs;
lhs = y(39);
rhs = y(68)+y(41)+params(18)*y(42)-T(20)*(y(27)-y(2)*T(4))-y(30);
residual(30) = lhs - rhs;
lhs = y(40);
rhs = y(42)-y(44);
residual(31) = lhs - rhs;
lhs = y(43);
rhs = y(65)*T(25);
residual(32) = lhs - rhs;
lhs = y(44);
rhs = y(9)+T(2)*(y(83)-y(44))+(y(33)-y(44))*T(21);
residual(33) = lhs - rhs;
lhs = y(62);
rhs = params(24)*y(19)+x(it_, 1);
residual(34) = lhs - rhs;
lhs = y(60);
rhs = params(25)*y(17)+x(it_, 2);
residual(35) = lhs - rhs;
lhs = y(59);
rhs = params(26)*y(16)+x(it_, 3)+x(it_, 1)*params(1);
residual(36) = lhs - rhs;
lhs = y(61);
rhs = params(27)*y(18)+x(it_, 4);
residual(37) = lhs - rhs;
lhs = y(67);
rhs = params(28)*y(24)+x(it_, 5);
residual(38) = lhs - rhs;
lhs = y(63);
rhs = params(29)*y(20)+y(64)-params(6)*y(21);
residual(39) = lhs - rhs;
lhs = y(64);
rhs = x(it_, 6);
residual(40) = lhs - rhs;
lhs = y(65);
rhs = params(30)*y(22)+y(66)-params(5)*y(23);
residual(41) = lhs - rhs;
lhs = y(66);
rhs = x(it_, 7);
residual(42) = lhs - rhs;
lhs = y(68);
rhs = params(35)*y(25)+x(it_, 8);
residual(43) = lhs - rhs;
lhs = y(71);
rhs = params(31)+y(26)-y(1)+params(36);
residual(44) = lhs - rhs;
lhs = y(72);
rhs = params(36)+params(31)+y(27)-y(2);
residual(45) = lhs - rhs;
lhs = y(73);
rhs = params(36)+params(31)+y(28)-y(3);
residual(46) = lhs - rhs;
lhs = y(74);
rhs = params(31)+y(39)-y(7);
residual(47) = lhs - rhs;
lhs = y(70);
rhs = params(3)+y(32);
residual(48) = lhs - rhs;
lhs = y(69);
rhs = y(31)+4*100*((1+params(3)/100)/T(7)-1);
residual(49) = lhs - rhs;
lhs = y(75);
rhs = params(36)+y(44)-y(9);
residual(50) = lhs - rhs;
lhs = y(76);
rhs = y(40)+100*(params(19)-1)/params(18);
residual(51) = lhs - rhs;

end
