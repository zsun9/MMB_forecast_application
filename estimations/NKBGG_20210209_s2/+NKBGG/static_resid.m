function residual = static_resid(T, y, x, params, T_flag)
% function residual = static_resid(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = NKBGG.static_resid_tt(T, y, x, params);
end
residual = zeros(34, 1);
lhs = y(10);
rhs = params(3)*y(15)+T(30)*y(1)+(1-T(30)-T(31)-params(3))*y(14)+T(31)*y(12);
residual(1) = lhs - rhs;
lhs = y(1);
rhs = y(1)-y(4);
residual(2) = lhs - rhs;
lhs = y(14);
rhs = y(8);
residual(3) = lhs - rhs;
lhs = y(9)-y(4);
rhs = (-params(22))*(y(8)-(y(6)+y(7)))+T(23)*y(18);
residual(4) = lhs - rhs;
lhs = y(9);
rhs = (y(10)-y(11)-y(7))*(1-T(32))+T(32)*y(6)-y(6);
residual(5) = lhs - rhs;
lhs = y(12);
rhs = y(12)*1/(1+T(3))+y(12)*T(3)/(1+T(3))+(y(6)+y(17))*T(33);
residual(6) = lhs - rhs;
lhs = y(10);
rhs = (1-params(5))*y(13)+params(5)*y(7)+(1-params(5))*params(4)*y(2);
residual(7) = lhs - rhs;
lhs = y(10)-y(2)-y(11)-y(1);
rhs = y(2)*T(34);
residual(8) = lhs - rhs;
lhs = y(3);
rhs = y(11)*(-T(35))+y(3)*params(24)/(1+T(3)*params(24))+y(3)*T(3)/(1+T(3)*params(24));
residual(9) = lhs - rhs;
lhs = y(7);
rhs = (y(12)+y(17))*T(36)+y(7)*(1-params(7))/T(1);
residual(10) = lhs - rhs;
lhs = y(8);
rhs = T(25)*y(9)-T(26)*y(4)+T(27)*(y(6)+y(7))+(y(10)-y(11))*T(37)-T(28)*y(18);
residual(11) = lhs - rhs;
lhs = y(5);
rhs = y(5)*params(13)+y(3)*(1-params(13))*params(11)+(1-params(13))*params(12)*(y(10)-y(19))+x(3);
residual(12) = lhs - rhs;
lhs = y(5);
rhs = y(4)+y(3);
residual(13) = lhs - rhs;
lhs = y(16);
rhs = y(9)-y(4);
residual(14) = lhs - rhs;
lhs = y(13);
rhs = y(13)*params(14)+x(1);
residual(15) = lhs - rhs;
lhs = y(15);
rhs = y(15)*params(15)+x(2);
residual(16) = lhs - rhs;
lhs = y(17);
rhs = y(17)*params(16)+x(4);
residual(17) = lhs - rhs;
lhs = y(18);
rhs = y(18)*params(17)+x(5);
residual(18) = lhs - rhs;
lhs = y(19);
rhs = params(3)*y(15)+T(30)*y(25)+(1-T(30)-T(31)-params(3))*y(28)+T(31)*y(21);
residual(19) = lhs - rhs;
lhs = y(25);
rhs = y(25)-y(22);
residual(20) = lhs - rhs;
lhs = y(28);
rhs = y(24);
residual(21) = lhs - rhs;
residual(22) = y(23)-y(22);
lhs = y(23);
rhs = (1-T(32))*(y(19)-y(20))+T(32)*y(26)-y(26);
residual(23) = lhs - rhs;
lhs = y(21);
rhs = 1/(1+T(3))*y(21)+T(3)/(1+T(3))*y(21)+T(33)*(y(17)+y(26));
residual(24) = lhs - rhs;
lhs = y(19);
rhs = (1-params(5))*y(13)+params(5)*y(20)+(1-params(5))*params(4)*y(27);
residual(25) = lhs - rhs;
lhs = y(19)-y(27)-y(25);
rhs = T(34)*y(27);
residual(26) = lhs - rhs;
lhs = y(20);
rhs = T(36)*(y(17)+y(21))+(1-params(7))/T(1)*y(20);
residual(27) = lhs - rhs;
lhs = y(24);
rhs = T(25)*y(23)-T(26)*y(22)+T(27)*(y(20)+y(26))+T(37)*y(19)-T(28)*y(18);
residual(28) = lhs - rhs;
lhs = y(34);
rhs = y(10)-y(19);
residual(29) = lhs - rhs;
lhs = y(29);
rhs = params(18);
residual(30) = lhs - rhs;
lhs = y(32);
rhs = params(18);
residual(31) = lhs - rhs;
lhs = y(30);
rhs = params(19)+y(3);
residual(32) = lhs - rhs;
lhs = y(31);
rhs = 100*(T(2)*T(1)*(1+params(19)/100)-1)+y(5);
residual(33) = lhs - rhs;
lhs = y(33);
rhs = params(20)+y(16);
residual(34) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
