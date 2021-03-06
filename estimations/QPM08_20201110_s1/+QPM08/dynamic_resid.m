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
    T = QPM08.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(49, 1);
lhs = y(35);
rhs = params(3)*y(3)+params(4)*y(39)+x(it_, 2);
residual(1) = lhs - rhs;
lhs = y(35);
rhs = y(36)-y(34);
residual(2) = lhs - rhs;
lhs = y(36);
rhs = y(4)+y(48)+x(it_, 3);
residual(3) = lhs - rhs;
lhs = y(48);
rhs = (1-params(16))*y(13)+x(it_, 9);
residual(4) = lhs - rhs;
lhs = y(40);
rhs = y(39)+y(41);
residual(5) = lhs - rhs;
lhs = y(43);
rhs = params(5)*params(6)+(1-params(5))*y(11)+x(it_, 5);
residual(6) = lhs - rhs;
lhs = y(41);
rhs = y(9)+y(43)/4+x(it_, 7);
residual(7) = lhs - rhs;
lhs = y(39);
rhs = x(it_, 6)+params(7)*y(7)+params(8)*y(83)-params(9)*(y(1)-y(2))-params(18)*(0.04*(y(15)+y(23))+0.08*(y(16)+y(22))+0.12*(y(17)+y(21))+0.16*(y(18)+y(20))+0.2*y(19));
residual(8) = lhs - rhs;
lhs = y(54);
rhs = x(it_, 10);
residual(9) = lhs - rhs;
lhs = y(52);
rhs = x(it_, 10)+y(53)-params(17)*y(86);
residual(10) = lhs - rhs;
lhs = y(53);
rhs = y(14)+x(it_, 11);
residual(11) = lhs - rhs;
lhs = y(58);
rhs = y(52)-y(53);
residual(12) = lhs - rhs;
lhs = y(49);
rhs = 4*(y(40)-y(8));
residual(13) = lhs - rhs;
lhs = y(50);
rhs = y(40)-y(26);
residual(14) = lhs - rhs;
lhs = y(56);
rhs = 4*(y(41)-y(9));
residual(15) = lhs - rhs;
lhs = y(51);
rhs = y(41)-y(29);
residual(16) = lhs - rhs;
lhs = y(37);
rhs = y(7)*params(11)+(1-params(10))*y(6)+params(10)*y(89)-x(it_, 8);
residual(17) = lhs - rhs;
lhs = 4*y(42);
rhs = x(it_, 4)+4*params(12)*y(10)+(1-params(12))*(y(39)*params(14)+y(33)+y(88)+params(13)*(y(88)-params(15)));
residual(18) = lhs - rhs;
lhs = y(32);
rhs = 4*y(42)-y(81);
residual(19) = lhs - rhs;
lhs = y(44);
rhs = y(12)+y(37)/4;
residual(20) = lhs - rhs;
lhs = y(33);
rhs = params(1)*params(2)+y(2)*(1-params(1))+x(it_, 1);
residual(21) = lhs - rhs;
lhs = y(38);
rhs = (y(37)+y(5)+y(30)+y(31))/4;
residual(22) = lhs - rhs;
lhs = y(57);
rhs = y(32)-y(33);
residual(23) = lhs - rhs;
lhs = y(45);
rhs = y(89);
residual(24) = lhs - rhs;
lhs = y(47);
rhs = y(81);
residual(25) = lhs - rhs;
lhs = y(46);
rhs = y(83);
residual(26) = lhs - rhs;
lhs = y(55);
rhs = params(18)*(0.04*(y(15)+y(23))+0.08*(y(16)+y(22))+0.12*(y(17)+y(21))+0.16*(y(18)+y(20))+0.2*y(19));
residual(27) = lhs - rhs;
lhs = y(59);
rhs = y(83);
residual(28) = lhs - rhs;
lhs = y(60);
rhs = y(84);
residual(29) = lhs - rhs;
lhs = y(61);
rhs = y(85);
residual(30) = lhs - rhs;
lhs = y(62);
rhs = y(82);
residual(31) = lhs - rhs;
lhs = y(63);
rhs = y(87);
residual(32) = lhs - rhs;
lhs = y(64);
rhs = y(88);
residual(33) = lhs - rhs;
lhs = y(65);
rhs = y(15);
residual(34) = lhs - rhs;
lhs = y(66);
rhs = y(16);
residual(35) = lhs - rhs;
lhs = y(67);
rhs = y(17);
residual(36) = lhs - rhs;
lhs = y(68);
rhs = y(18);
residual(37) = lhs - rhs;
lhs = y(69);
rhs = y(19);
residual(38) = lhs - rhs;
lhs = y(70);
rhs = y(20);
residual(39) = lhs - rhs;
lhs = y(71);
rhs = y(21);
residual(40) = lhs - rhs;
lhs = y(72);
rhs = y(22);
residual(41) = lhs - rhs;
lhs = y(73);
rhs = y(8);
residual(42) = lhs - rhs;
lhs = y(74);
rhs = y(24);
residual(43) = lhs - rhs;
lhs = y(75);
rhs = y(25);
residual(44) = lhs - rhs;
lhs = y(76);
rhs = y(9);
residual(45) = lhs - rhs;
lhs = y(77);
rhs = y(27);
residual(46) = lhs - rhs;
lhs = y(78);
rhs = y(28);
residual(47) = lhs - rhs;
lhs = y(79);
rhs = y(5);
residual(48) = lhs - rhs;
lhs = y(80);
rhs = y(30);
residual(49) = lhs - rhs;

end
