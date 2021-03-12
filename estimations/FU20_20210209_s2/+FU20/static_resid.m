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
    T = FU20.static_resid_tt(T, y, x, params);
end
residual = zeros(40, 1);
lhs = y(12);
rhs = y(12)*T(1)/(1+T(1))+y(12)*1/(1+T(1))-T(2)*(y(13)-y(11))+y(35);
residual(1) = lhs - rhs;
lhs = y(18);
rhs = T(3)*(y(18)+y(18)*params(2)*params(6)+1/T(4)*y(19))+y(36);
residual(2) = lhs - rhs;
lhs = y(19);
rhs = y(35)*1/T(2)-(y(13)-y(11))+params(8)/(1+params(8)-params(9))*y(10)+y(19)*T(5);
residual(3) = lhs - rhs;
lhs = y(16);
rhs = y(10)*T(6);
residual(4) = lhs - rhs;
lhs = y(15);
rhs = y(16)+y(17);
residual(5) = lhs - rhs;
lhs = y(17);
rhs = y(17)*(1-params(47))+params(47)*(y(18)+T(4)*y(36));
residual(6) = lhs - rhs;
lhs = y(20);
rhs = params(11)*y(32)+y(15)*params(11)*params(12)+y(14)*params(11)*(1-params(12));
residual(7) = lhs - rhs;
lhs = y(15);
rhs = y(14)+y(9)-y(10);
residual(8) = lhs - rhs;
lhs = y(8);
rhs = y(10)*params(12)+(1-params(12))*y(9)-y(32);
residual(9) = lhs - rhs;
lhs = y(11);
rhs = y(8)*T(7)+y(33)+y(11)*params(14)/(1+params(2)*params(6)*params(14))+y(11)*params(2)*params(6)/(1+params(2)*params(6)*params(14));
residual(10) = lhs - rhs;
lhs = y(9);
rhs = T(3)*(y(9)+params(2)*params(6)*y(9)+T(8)*(y(12)*1/(1-T(1))-y(12)*T(1)/(1-T(1))+y(14)*params(17)-y(9))-y(11)*(1+params(2)*params(6)*params(18))+y(11)*params(18)+y(11)*params(2)*params(6))+y(34);
residual(11) = lhs - rhs;
lhs = y(13);
rhs = y(13)*params(20)+(1-params(20))*(y(11)*params(21)+params(22)*(y(20)-y(30)))+y(38);
residual(12) = lhs - rhs;
lhs = y(20);
rhs = y(12)*params(24)+y(18)*params(10)+y(37)+y(16)*params(8)*params(25);
residual(13) = lhs - rhs;
lhs = y(23);
rhs = y(35)+T(1)/(1+T(1))*y(23)+1/(1+T(1))*y(23)-T(2)*y(24);
residual(14) = lhs - rhs;
lhs = y(29);
rhs = y(36)+T(3)*(y(29)+params(2)*params(6)*y(29)+1/T(4)*y(31));
residual(15) = lhs - rhs;
lhs = y(31);
rhs = y(35)*1/T(2)-y(24)+params(8)/(1+params(8)-params(9))*y(22)+T(5)*y(31);
residual(16) = lhs - rhs;
lhs = y(27);
rhs = T(6)*y(22);
residual(17) = lhs - rhs;
lhs = y(26);
rhs = y(27)+y(28);
residual(18) = lhs - rhs;
lhs = y(28);
rhs = y(28)*(1-T(9))+T(9)*(T(4)*y(36)+y(29));
residual(19) = lhs - rhs;
lhs = y(30);
rhs = params(11)*y(32)+params(11)*params(12)*y(26)+params(11)*(1-params(12))*y(25);
residual(20) = lhs - rhs;
lhs = y(26);
rhs = y(25)+y(21)-y(22);
residual(21) = lhs - rhs;
lhs = 0;
rhs = params(12)*y(22)+(1-params(12))*y(21)-y(32);
residual(22) = lhs - rhs;
lhs = y(21);
rhs = 1/(1-T(1))*y(23)-T(1)/(1-T(1))*y(23)+params(17)*y(25);
residual(23) = lhs - rhs;
lhs = y(30);
rhs = y(37)+params(24)*y(23)+params(10)*y(29)+params(8)*params(25)*y(27);
residual(24) = lhs - rhs;
lhs = y(32);
rhs = y(32)*params(34)+x(1);
residual(25) = lhs - rhs;
lhs = y(35);
rhs = y(35)*params(35)+x(4);
residual(26) = lhs - rhs;
lhs = y(37);
rhs = y(37)*params(36)+x(6)+x(1)*params(37);
residual(27) = lhs - rhs;
lhs = y(36);
rhs = y(36)*params(38)+x(5);
residual(28) = lhs - rhs;
lhs = y(33);
rhs = y(33)*params(39)+x(2)-x(2)*params(40);
residual(29) = lhs - rhs;
lhs = y(34);
rhs = y(34)*params(41)+x(3)-x(3)*params(42);
residual(30) = lhs - rhs;
lhs = y(38);
rhs = y(38)*params(43)+x(7);
residual(31) = lhs - rhs;
lhs = y(4);
rhs = params(29);
residual(32) = lhs - rhs;
lhs = y(5);
rhs = params(29);
residual(33) = lhs - rhs;
lhs = y(6);
rhs = params(29);
residual(34) = lhs - rhs;
lhs = y(7);
rhs = params(29);
residual(35) = lhs - rhs;
lhs = y(3);
rhs = y(11)+params(30);
residual(36) = lhs - rhs;
lhs = y(2);
rhs = y(13)+params(31);
residual(37) = lhs - rhs;
lhs = y(1);
rhs = y(14)+params(32);
residual(38) = lhs - rhs;
lhs = y(39);
rhs = x(2);
residual(39) = lhs - rhs;
lhs = y(40);
rhs = x(3);
residual(40) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
