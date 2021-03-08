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
    T = FU20.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(40, 1);
lhs = y(32);
rhs = T(1)/(1+T(1))*y(3)+1/(1+T(1))*y(64)+T(2)*(y(34)-y(65))-T(3)*(y(33)-y(63))+y(55);
residual(1) = lhs - rhs;
lhs = y(38);
rhs = T(4)*(y(6)+params(2)*params(6)*y(66)+1/T(5)*y(39))+y(56);
residual(2) = lhs - rhs;
lhs = y(39);
rhs = y(55)*1/T(3)-(y(33)-y(63))+params(8)/(1+params(8)-params(9))*y(62)+T(6)*y(67);
residual(3) = lhs - rhs;
lhs = y(36);
rhs = T(7)*y(30);
residual(4) = lhs - rhs;
lhs = y(35);
rhs = y(36)+y(5);
residual(5) = lhs - rhs;
lhs = y(37);
rhs = y(5)*(1-params(47))+params(47)*(y(38)+T(5)*y(56));
residual(6) = lhs - rhs;
lhs = y(40);
rhs = params(11)*y(52)+y(35)*params(11)*params(12)+y(34)*params(11)*(1-params(12));
residual(7) = lhs - rhs;
lhs = y(35);
rhs = y(34)+y(29)-y(30);
residual(8) = lhs - rhs;
lhs = y(28);
rhs = y(30)*params(12)+(1-params(12))*y(29)-y(52);
residual(9) = lhs - rhs;
lhs = y(31);
rhs = y(28)*T(8)+y(53)+params(14)/(1+params(2)*params(6)*params(14))*y(2)+y(63)*params(2)*params(6)/(1+params(2)*params(6)*params(14));
residual(10) = lhs - rhs;
lhs = y(29);
rhs = T(4)*(y(1)+params(2)*params(6)*y(61)+T(9)*(y(32)*T(10)-y(3)*T(11)+y(34)*params(17)-y(29))-y(31)*(1+params(2)*params(6)*params(18))+y(2)*params(18)+y(63)*params(2)*params(6))+y(54);
residual(11) = lhs - rhs;
lhs = y(33);
rhs = params(20)*y(4)+(1-params(20))*(y(31)*params(21)+params(22)*(y(40)-y(50)))+params(23)*(y(40)-y(7)-(y(50)-y(11)))+y(58);
residual(12) = lhs - rhs;
lhs = y(40);
rhs = y(32)*params(24)+y(38)*params(10)+y(57)+y(36)*params(8)*params(25);
residual(13) = lhs - rhs;
lhs = y(43);
rhs = y(55)+T(1)/(1+T(1))*y(8)+1/(1+T(1))*y(69)+T(2)*(y(45)-y(70))-T(3)*y(44);
residual(14) = lhs - rhs;
lhs = y(49);
rhs = y(56)+T(4)*(y(10)+params(2)*params(6)*y(71)+1/T(5)*y(51));
residual(15) = lhs - rhs;
lhs = y(51);
rhs = y(55)*1/T(3)-y(44)+params(8)/(1+params(8)-params(9))*y(68)+T(6)*y(72);
residual(16) = lhs - rhs;
lhs = y(47);
rhs = T(7)*y(42);
residual(17) = lhs - rhs;
lhs = y(46);
rhs = y(47)+y(9);
residual(18) = lhs - rhs;
lhs = y(48);
rhs = y(9)*(1-T(12))+T(12)*(T(5)*y(56)+y(49));
residual(19) = lhs - rhs;
lhs = y(50);
rhs = params(11)*y(52)+params(11)*params(12)*y(46)+params(11)*(1-params(12))*y(45);
residual(20) = lhs - rhs;
lhs = y(46);
rhs = y(45)+y(41)-y(42);
residual(21) = lhs - rhs;
lhs = 0;
rhs = params(12)*y(42)+(1-params(12))*y(41)-y(52);
residual(22) = lhs - rhs;
lhs = y(41);
rhs = T(10)*y(43)-T(11)*y(8)+params(17)*y(45);
residual(23) = lhs - rhs;
lhs = y(50);
rhs = y(57)+params(24)*y(43)+params(10)*y(49)+params(8)*params(25)*y(47);
residual(24) = lhs - rhs;
lhs = y(52);
rhs = params(34)*y(12)+x(it_, 1);
residual(25) = lhs - rhs;
lhs = y(55);
rhs = params(35)*y(15)+x(it_, 4);
residual(26) = lhs - rhs;
lhs = y(57);
rhs = params(36)*y(17)+x(it_, 6)+x(it_, 1)*params(37);
residual(27) = lhs - rhs;
lhs = y(56);
rhs = params(38)*y(16)+x(it_, 5);
residual(28) = lhs - rhs;
lhs = y(53);
rhs = params(39)*y(13)+x(it_, 2)-params(40)*y(19);
residual(29) = lhs - rhs;
lhs = y(54);
rhs = params(41)*y(14)+x(it_, 3)-params(42)*y(20);
residual(30) = lhs - rhs;
lhs = y(58);
rhs = params(43)*y(18)+x(it_, 7);
residual(31) = lhs - rhs;
lhs = y(24);
rhs = y(40)-y(7)+params(29);
residual(32) = lhs - rhs;
lhs = y(25);
rhs = params(29)+y(32)-y(3);
residual(33) = lhs - rhs;
lhs = y(26);
rhs = params(29)+y(38)-y(6);
residual(34) = lhs - rhs;
lhs = y(27);
rhs = params(29)+y(29)-y(1);
residual(35) = lhs - rhs;
lhs = y(23);
rhs = y(31)+params(30);
residual(36) = lhs - rhs;
lhs = y(22);
rhs = y(33)+params(31);
residual(37) = lhs - rhs;
lhs = y(21);
rhs = y(34)+params(32);
residual(38) = lhs - rhs;
lhs = y(59);
rhs = x(it_, 2);
residual(39) = lhs - rhs;
lhs = y(60);
rhs = x(it_, 3);
residual(40) = lhs - rhs;

end
