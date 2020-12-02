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
    T = GSW12.static_resid_tt(T, y, x, params);
end
residual = zeros(51, 1);
lhs = y(20);
rhs = params(13)*(params(7)*y(29)+(1-params(7))*y(26)+y(37));
residual(1) = lhs - rhs;
lhs = y(24);
rhs = y(24)+y(25)-T(19);
residual(2) = lhs - rhs;
lhs = y(24);
rhs = (-params(11))/T(18)*y(21)+y(21)*T(20)+y(26)*(params(11)-1)*T(13)/T(18);
residual(3) = lhs - rhs;
lhs = y(22);
rhs = T(21)*(y(22)+y(22)*T(2)*T(4)+1/T(23)*y(27))+y(36);
residual(4) = lhs - rhs;
lhs = y(27);
rhs = T(25)-y(25)+T(6)/(1-params(10)+T(6))*y(28)+y(27)*T(26);
residual(5) = lhs - rhs;
lhs = y(20);
rhs = T(12)*y(21)+T(11)*y(22)+y(34)+T(14)*y(23);
residual(6) = lhs - rhs;
lhs = y(29);
rhs = y(23)+y(30);
residual(7) = lhs - rhs;
lhs = y(23);
rhs = y(28)*T(27);
residual(8) = lhs - rhs;
lhs = y(30);
rhs = y(30)*(1-T(15))+y(22)*T(15)+y(36)*T(23)*T(15);
residual(9) = lhs - rhs;
lhs = y(37);
rhs = params(7)*y(28)+(1-params(7))*y(31);
residual(10) = lhs - rhs;
lhs = y(28);
rhs = y(26)+y(31)-y(29);
residual(11) = lhs - rhs;
lhs = y(32);
rhs = y(32)*(1-params(33))+params(33)/T(18)*(y(21)-T(17)*y(21));
residual(12) = lhs - rhs;
lhs = y(31);
rhs = y(32)+y(26)*params(18)-(y(21)-T(17)*y(21))*1/T(18)-y(24)+y(43);
residual(13) = lhs - rhs;
lhs = y(33);
rhs = y(33)+T(28)*(y(26)-y(33));
residual(14) = lhs - rhs;
lhs = y(1);
rhs = y(34)+T(12)*y(2)+T(11)*y(3)+T(14)*y(4);
residual(15) = lhs - rhs;
lhs = y(5);
rhs = y(5)+y(6)-y(7)-T(19);
residual(16) = lhs - rhs;
lhs = y(5);
rhs = (-params(11))/T(18)*y(2)+T(20)*y(2)+(params(11)-1)*T(13)/T(18)*y(8);
residual(17) = lhs - rhs;
lhs = y(3);
rhs = y(36)+T(21)*(y(3)+T(2)*T(4)*y(3)+1/T(23)*y(9));
residual(18) = lhs - rhs;
lhs = y(9);
rhs = T(25)+y(7)-y(6)+T(6)/(1-params(10)+T(6))*y(10)+T(26)*y(9);
residual(19) = lhs - rhs;
lhs = y(1);
rhs = params(13)*(y(37)+params(7)*y(11)+(1-params(7))*y(8));
residual(20) = lhs - rhs;
lhs = y(11);
rhs = y(4)+y(12);
residual(21) = lhs - rhs;
lhs = y(4);
rhs = T(27)*y(10);
residual(22) = lhs - rhs;
lhs = y(12);
rhs = (1-T(15))*y(12)+T(15)*y(3)+y(36)*params(9)*T(22)*T(15);
residual(23) = lhs - rhs;
lhs = y(13);
rhs = params(7)*y(10)+(1-params(7))*y(14)-y(37);
residual(24) = lhs - rhs;
lhs = y(7);
rhs = T(29)*(T(2)*T(4)*y(7)+y(7)*params(16)+y(13)*T(30))+y(38);
residual(25) = lhs - rhs;
lhs = y(10);
rhs = y(8)+y(14)-y(11);
residual(26) = lhs - rhs;
lhs = y(14);
rhs = T(21)*y(14)+T(31)*(y(7)+y(14))-y(7)*(1+T(2)*T(4)*params(14))/(1+T(2)*T(4))+y(7)*params(14)/(1+T(2)*T(4))-T(32)*y(15)+y(40);
residual(27) = lhs - rhs;
lhs = y(6);
rhs = y(7)*params(20)*(1-params(23))+(1-params(23))*params(22)*(y(1)-y(20))+params(21)*(y(20)+y(1)-y(20)-y(1))+y(6)*params(23)+y(42);
residual(28) = lhs - rhs;
lhs = y(16);
rhs = (1-params(33))*y(16)+params(33)/T(18)*(y(2)-T(17)*y(2));
residual(29) = lhs - rhs;
lhs = y(14);
rhs = y(43)+y(16)+params(18)*y(17)-1/T(18)*(y(2)-T(17)*y(2))-y(5);
residual(30) = lhs - rhs;
lhs = y(15);
rhs = y(17)-y(19);
residual(31) = lhs - rhs;
lhs = y(18);
rhs = y(40)*T(33);
residual(32) = lhs - rhs;
lhs = y(19);
rhs = y(19)+T(28)*(y(8)-y(19));
residual(33) = lhs - rhs;
lhs = y(37);
rhs = y(37)*params(24)+x(1);
residual(34) = lhs - rhs;
lhs = y(35);
rhs = y(35)*params(25)+x(2);
residual(35) = lhs - rhs;
lhs = y(34);
rhs = y(34)*params(26)+x(3)+x(1)*params(1);
residual(36) = lhs - rhs;
lhs = y(36);
rhs = y(36)*params(27)+x(4);
residual(37) = lhs - rhs;
lhs = y(42);
rhs = y(42)*params(28)+x(5);
residual(38) = lhs - rhs;
lhs = y(38);
rhs = y(38)*params(29)+y(39)-y(39)*params(6);
residual(39) = lhs - rhs;
lhs = y(39);
rhs = x(6);
residual(40) = lhs - rhs;
lhs = y(40);
rhs = y(40)*params(30)+y(41)-y(41)*params(5);
residual(41) = lhs - rhs;
lhs = y(41);
rhs = x(7);
residual(42) = lhs - rhs;
lhs = y(43);
rhs = y(43)*params(35)+x(8);
residual(43) = lhs - rhs;
lhs = y(46);
rhs = params(31)+params(36);
residual(44) = lhs - rhs;
lhs = y(47);
rhs = params(31)+params(36);
residual(45) = lhs - rhs;
lhs = y(48);
rhs = params(31)+params(36);
residual(46) = lhs - rhs;
lhs = y(49);
rhs = params(31);
residual(47) = lhs - rhs;
lhs = y(45);
rhs = params(3)+y(7);
residual(48) = lhs - rhs;
lhs = y(44);
rhs = y(6)+4*T(16);
residual(49) = lhs - rhs;
lhs = y(50);
rhs = params(36);
residual(50) = lhs - rhs;
lhs = y(51);
rhs = y(15)+100*(params(19)-1)/params(18);
residual(51) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
