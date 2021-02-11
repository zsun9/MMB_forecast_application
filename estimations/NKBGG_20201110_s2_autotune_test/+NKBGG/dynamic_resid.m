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
    T = NKBGG.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(34, 1);
lhs = y(25);
rhs = T(26)*y(16)+T(28)*y(29)+T(27)*y(27)+params(3)*y(30);
residual(1) = lhs - rhs;
lhs = y(16);
rhs = y(50)-y(19);
residual(2) = lhs - rhs;
lhs = y(29);
rhs = y(23);
residual(3) = lhs - rhs;
lhs = y(52)-y(19);
rhs = (-params(22))*(y(23)-(y(21)+y(22)))+T(29)*y(33);
residual(4) = lhs - rhs;
lhs = y(24);
rhs = (1-T(30))*(y(25)-y(26)-y(5))+y(21)*T(30)-y(4);
residual(5) = lhs - rhs;
lhs = y(27);
rhs = 1/(1+T(2))*y(7)+T(2)/(1+T(2))*y(53)+T(38)*(y(21)+y(32));
residual(6) = lhs - rhs;
lhs = y(25);
rhs = (1-params(5))*y(28)+params(5)*y(5)+(1-params(5))*params(4)*y(17);
residual(7) = lhs - rhs;
lhs = y(25)-y(17)-y(26)-y(16);
rhs = y(17)*T(39);
residual(8) = lhs - rhs;
lhs = y(18);
rhs = y(26)*(-(1/(1+T(2)*params(24))*T(31)))+params(24)/(1+T(2)*params(24))*y(1)+T(2)/(1+T(2)*params(24))*y(51);
residual(9) = lhs - rhs;
lhs = y(22);
rhs = (1-T(40))*(y(27)+y(32))+y(5)*T(40);
residual(10) = lhs - rhs;
lhs = y(23);
rhs = y(24)*T(32)-T(33)*y(2)+T(34)*(y(5)+y(4))+(y(25)-y(26))*T(41)-T(36)*y(11);
residual(11) = lhs - rhs;
lhs = y(20);
rhs = params(13)*y(3)+y(18)*(1-params(13))*params(11)+(1-params(13))*params(12)*(y(25)-y(34))+x(it_, 3);
residual(12) = lhs - rhs;
lhs = y(20);
rhs = y(19)+y(51);
residual(13) = lhs - rhs;
lhs = y(31);
rhs = y(52)-y(19);
residual(14) = lhs - rhs;
lhs = y(28);
rhs = params(14)*y(8)+x(it_, 1);
residual(15) = lhs - rhs;
lhs = y(30);
rhs = params(15)*y(9)+x(it_, 2);
residual(16) = lhs - rhs;
lhs = y(32);
rhs = params(16)*y(10)+x(it_, 4);
residual(17) = lhs - rhs;
lhs = y(33);
rhs = y(11)*params(17)+x(it_, 5);
residual(18) = lhs - rhs;
lhs = y(34);
rhs = params(3)*y(30)+T(26)*y(40)+T(28)*y(43)+T(27)*y(36);
residual(19) = lhs - rhs;
lhs = y(40);
rhs = y(56)-y(37);
residual(20) = lhs - rhs;
lhs = y(43);
rhs = y(39);
residual(21) = lhs - rhs;
residual(22) = y(55)-y(37);
lhs = y(38);
rhs = (1-T(30))*(y(34)-y(12))+T(30)*y(41)-y(15);
residual(23) = lhs - rhs;
lhs = y(36);
rhs = 1/(1+T(2))*y(13)+T(2)/(1+T(2))*y(54)+T(38)*(y(32)+y(41));
residual(24) = lhs - rhs;
lhs = y(34);
rhs = (1-params(5))*y(28)+params(5)*y(12)+(1-params(5))*params(4)*y(42);
residual(25) = lhs - rhs;
lhs = y(34)-y(42)-y(40);
rhs = T(39)*y(42);
residual(26) = lhs - rhs;
lhs = y(35);
rhs = (1-T(40))*(y(32)+y(36))+T(40)*y(12);
residual(27) = lhs - rhs;
lhs = y(39);
rhs = T(32)*y(38)-T(33)*y(14)+T(34)*(y(12)+y(15))+T(41)*y(34)-T(36)*y(11);
residual(28) = lhs - rhs;
lhs = y(49);
rhs = y(25)-y(34);
residual(29) = lhs - rhs;
lhs = y(44);
rhs = params(18)+y(25)-y(6);
residual(30) = lhs - rhs;
lhs = y(47);
rhs = params(18)+y(27)-y(7);
residual(31) = lhs - rhs;
lhs = y(45);
rhs = params(19)+y(18);
residual(32) = lhs - rhs;
lhs = y(46);
rhs = y(20)+T(37);
residual(33) = lhs - rhs;
lhs = y(48);
rhs = params(20)+y(31);
residual(34) = lhs - rhs;

end
