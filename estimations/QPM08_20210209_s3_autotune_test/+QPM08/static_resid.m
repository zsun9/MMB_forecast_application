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
    T = QPM08.static_resid_tt(T, y, x, params);
end
residual = zeros(49, 1);
lhs = y(4);
rhs = y(4)*params(3)+params(4)*y(8)+x(2);
residual(1) = lhs - rhs;
lhs = y(4);
rhs = y(5)-y(3);
residual(2) = lhs - rhs;
lhs = y(5);
rhs = y(5)+y(17)+x(3);
residual(3) = lhs - rhs;
lhs = y(17);
rhs = y(17)*(1-params(16))+x(9);
residual(4) = lhs - rhs;
lhs = y(9);
rhs = y(8)+y(10);
residual(5) = lhs - rhs;
lhs = y(12);
rhs = params(5)*params(6)+y(12)*(1-params(5))+x(5);
residual(6) = lhs - rhs;
lhs = y(10);
rhs = y(10)+y(12)/4+x(7);
residual(7) = lhs - rhs;
lhs = y(8);
rhs = x(6)+y(8)*params(7)+y(8)*params(8)-params(9)*(y(1)-y(2))-params(18)*(0.04*(y(23)+y(23))+0.08*(y(23)+y(23))+0.12*(y(23)+y(23))+0.16*(y(23)+y(23))+y(23)*0.2);
residual(8) = lhs - rhs;
lhs = y(23);
rhs = x(10);
residual(9) = lhs - rhs;
lhs = y(21);
rhs = x(10)+y(22)-y(8)*params(17);
residual(10) = lhs - rhs;
lhs = y(22);
rhs = y(22)+x(11);
residual(11) = lhs - rhs;
lhs = y(27);
rhs = y(21)-y(22);
residual(12) = lhs - rhs;
residual(13) = y(18);
residual(14) = y(19);
residual(15) = y(25);
residual(16) = y(20);
lhs = y(6);
rhs = y(8)*params(11)+(1-params(10))*y(7)+params(10)*y(7)-x(8);
residual(17) = lhs - rhs;
lhs = 4*y(11);
rhs = x(4)+4*y(11)*params(12)+(1-params(12))*(y(8)*params(14)+y(2)+y(7)+params(13)*(y(7)-params(15)));
residual(18) = lhs - rhs;
lhs = y(1);
rhs = 4*y(11)-y(6);
residual(19) = lhs - rhs;
lhs = y(13);
rhs = y(13)+y(6)/4;
residual(20) = lhs - rhs;
lhs = y(2);
rhs = params(1)*params(2)+y(2)*(1-params(1))+x(1);
residual(21) = lhs - rhs;
lhs = y(7);
rhs = (y(6)+y(6)+y(6)+y(6))/4;
residual(22) = lhs - rhs;
lhs = y(26);
rhs = y(1)-y(2);
residual(23) = lhs - rhs;
lhs = y(14);
rhs = y(7);
residual(24) = lhs - rhs;
lhs = y(16);
rhs = y(6);
residual(25) = lhs - rhs;
lhs = y(15);
rhs = y(8);
residual(26) = lhs - rhs;
lhs = y(24);
rhs = params(18)*(0.04*(y(23)+y(23))+0.08*(y(23)+y(23))+0.12*(y(23)+y(23))+0.16*(y(23)+y(23))+y(23)*0.2);
residual(27) = lhs - rhs;
lhs = y(28);
rhs = y(8);
residual(28) = lhs - rhs;
lhs = y(29);
rhs = y(8);
residual(29) = lhs - rhs;
lhs = y(30);
rhs = y(8);
residual(30) = lhs - rhs;
lhs = y(31);
rhs = y(7);
residual(31) = lhs - rhs;
lhs = y(32);
rhs = y(7);
residual(32) = lhs - rhs;
lhs = y(33);
rhs = y(7);
residual(33) = lhs - rhs;
lhs = y(34);
rhs = y(23);
residual(34) = lhs - rhs;
lhs = y(35);
rhs = y(23);
residual(35) = lhs - rhs;
lhs = y(36);
rhs = y(23);
residual(36) = lhs - rhs;
lhs = y(37);
rhs = y(23);
residual(37) = lhs - rhs;
lhs = y(38);
rhs = y(23);
residual(38) = lhs - rhs;
lhs = y(39);
rhs = y(23);
residual(39) = lhs - rhs;
lhs = y(40);
rhs = y(23);
residual(40) = lhs - rhs;
lhs = y(41);
rhs = y(23);
residual(41) = lhs - rhs;
lhs = y(42);
rhs = y(9);
residual(42) = lhs - rhs;
lhs = y(43);
rhs = y(9);
residual(43) = lhs - rhs;
lhs = y(44);
rhs = y(9);
residual(44) = lhs - rhs;
lhs = y(45);
rhs = y(10);
residual(45) = lhs - rhs;
lhs = y(46);
rhs = y(10);
residual(46) = lhs - rhs;
lhs = y(47);
rhs = y(10);
residual(47) = lhs - rhs;
lhs = y(48);
rhs = y(6);
residual(48) = lhs - rhs;
lhs = y(49);
rhs = y(6);
residual(49) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
