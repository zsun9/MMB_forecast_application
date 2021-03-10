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
    T = IN10.static_resid_tt(T, y, x, params);
end
residual = zeros(50, 1);
lhs = exp(y(9))+exp(y(25))/exp(y(4))+exp(y(26))+exp(y(32)+y(22))+exp(y(8));
rhs = (1-params(9))*exp(y(32)+y(22)-T(4))+exp(y(38)+y(28))+exp(y(40)+y(30))+(1-1/exp(y(42)))*exp(y(47))+exp(y(8)+y(33)-y(21)-T(1))+T(53)+(1-params(8)+exp(y(35)+y(50)))*exp(y(26)-T(1))+params(33)*exp(y(32))*exp(y(24));
residual(1) = lhs - rhs;
lhs = exp(y(32)+y(36));
rhs = params(4)*exp(y(7)+y(3)-y(22))+(1-params(9))*exp(T(1))*params(1)*exp(y(36)+T(3)+y(32)-T(1));
residual(2) = lhs - rhs;
lhs = exp(y(36));
rhs = exp(T(1))*params(1)*exp(y(33)-y(21)+y(36)-T(1));
residual(3) = lhs - rhs;
lhs = exp(y(36))/exp(y(4));
rhs = T(54);
residual(4) = lhs - rhs;
lhs = exp(y(36));
rhs = (1-params(8)+exp(y(35)+y(50)))*exp(T(1))*params(1)*exp(y(36)-T(1));
residual(5) = lhs - rhs;
lhs = T(58);
rhs = exp(y(38)+y(36)-y(43));
residual(6) = lhs - rhs;
lhs = T(60);
rhs = exp(y(40)+y(36)-y(45));
residual(7) = lhs - rhs;
lhs = exp(y(10))+exp(y(32)+y(23))-(1-params(9))*exp(y(32)+y(23)-T(4));
rhs = exp(y(8))+exp(y(39)+y(29))+exp(y(41)+y(31))-exp(y(8)+y(33)-y(21)-T(1));
residual(8) = lhs - rhs;
lhs = exp(y(32)+y(37));
rhs = params(4)*exp(y(7)+y(3)-y(23))+(1-params(9))*exp(T(1))*params(2)*exp(T(3)+y(32)+y(37)-T(1))+params(3)*exp(y(27)+y(21)+T(3)+y(32)-y(33));
residual(9) = lhs - rhs;
lhs = y(8);
rhs = y(21)+y(23)+T(3)+y(32)+log(params(3))-y(33);
residual(10) = lhs - rhs;
lhs = exp(y(37));
rhs = exp(T(1))*params(2)*exp(y(33)-y(21)+y(37)-T(1))+exp(y(27));
residual(11) = lhs - rhs;
lhs = T(64);
rhs = exp(y(39)+y(37)-y(44));
residual(12) = lhs - rhs;
lhs = T(66);
rhs = exp(y(41)+y(37)-y(46));
residual(13) = lhs - rhs;
lhs = y(47);
rhs = (1-params(5))*y(1)+(1-params(5))*params(16)*y(28)+(1-params(5))*(1-params(16))*y(29)+params(5)*(y(25)+y(49)-T(2));
residual(14) = lhs - rhs;
lhs = y(24);
rhs = (1-params(6)-params(43)-params(33))*y(2)+params(43)*(y(24)+y(32)+log(params(43)))+y(30)*params(16)*(1-params(6)-params(43)-params(33))+y(31)*(1-params(16))*(1-params(6)-params(43)-params(33))+params(6)*(y(26)+y(50)-T(1));
residual(15) = lhs - rhs;
lhs = y(47)+log(1-params(5))+log(params(16))-y(42)-y(28);
rhs = y(38);
residual(16) = lhs - rhs;
lhs = y(47)+log(1-params(5))+log(1-params(16))-y(42)-y(29);
rhs = y(39);
residual(17) = lhs - rhs;
lhs = y(24)+y(32)+log(params(16))+log(1-params(6)-params(33)-params(43))-y(30);
rhs = y(40);
residual(18) = lhs - rhs;
lhs = y(24)+y(32)+log(1-params(16))+log(1-params(6)-params(33)-params(43))-y(31);
rhs = y(41);
residual(19) = lhs - rhs;
lhs = T(2)+y(47)+log(params(5))-y(42)-y(25);
rhs = y(34)+y(49);
residual(20) = lhs - rhs;
lhs = T(1)+y(24)+y(32)+log(params(6))-y(26);
rhs = y(35)+y(50);
residual(21) = lhs - rhs;
lhs = y(21)-y(21)*params(22);
rhs = exp(T(1))*params(1)*(y(21)-y(21)*params(22))-(1-params(17))*(1-exp(T(1))*params(1)*params(17))/params(17)*(y(42)-log(params(21)))+x(6);
residual(22) = lhs - rhs;
lhs = y(33);
rhs = y(33)*params(18)+y(21)*(1-params(18))*params(20)+(1-params(18))*(-log(params(1)))+x(2)-y(5)/100;
residual(23) = lhs - rhs;
lhs = exp(y(22))+exp(y(23));
rhs = exp(y(24))+(1-params(9))*exp(y(22)-T(4))+(1-params(9))*exp(y(23)-T(4));
residual(24) = lhs - rhs;
lhs = exp(y(36));
rhs = T(68);
residual(25) = lhs - rhs;
lhs = exp(y(37));
rhs = T(70);
residual(26) = lhs - rhs;
lhs = y(38);
rhs = y(38)*T(71)+(1-T(71))*(y(38)+y(21))-y(21)*(1+exp(T(1))*params(1)*params(37))/(1+exp(T(1))*params(1))+y(21)*params(37)/(1+exp(T(1))*params(1))-T(72)*(y(43)-log(params(34)));
residual(27) = lhs - rhs;
lhs = y(39);
rhs = y(39)*T(73)+(1-T(73))*(y(21)+y(39))-y(21)*(1+exp(T(1))*params(2)*params(37))/(1+exp(T(1))*params(2))+y(21)*params(37)/(1+exp(T(1))*params(2))-T(74)*(y(44)-log(params(34)));
residual(28) = lhs - rhs;
lhs = y(40);
rhs = y(40)*T(71)+(1-T(71))*(y(40)+y(21))-y(21)*(1+exp(T(1))*params(1)*params(38))/(1+exp(T(1))*params(1))+y(21)*params(38)/(1+exp(T(1))*params(1))-T(75)*(y(45)-log(params(34)));
residual(29) = lhs - rhs;
lhs = y(41);
rhs = y(41)*T(73)+(1-T(73))*(y(21)+y(41))-y(21)*(1+exp(T(1))*params(2)*params(38))/(1+exp(T(1))*params(2))+y(21)*params(38)/(1+exp(T(1))*params(2))-T(76)*(y(46)-log(params(34)));
residual(30) = lhs - rhs;
lhs = T(77);
rhs = params(39)/(1-params(39))*exp(y(49))+1-params(39)/(1-params(39));
residual(31) = lhs - rhs;
lhs = T(78);
rhs = 1-params(39)/(1-params(39))+params(39)/(1-params(39))*exp(y(50));
residual(32) = lhs - rhs;
lhs = y(11);
rhs = T(1)+log(exp(y(9))+exp(y(10)))-T(47);
residual(33) = lhs - rhs;
lhs = y(12);
rhs = y(21);
residual(34) = lhs - rhs;
lhs = y(13);
rhs = T(4)+y(24)-T(48);
residual(35) = lhs - rhs;
lhs = y(14);
rhs = T(2)+log(T(79))-T(49);
residual(36) = lhs - rhs;
lhs = y(15);
rhs = params(16)*y(28)+(1-params(16))*y(29)-T(50);
residual(37) = lhs - rhs;
lhs = y(16);
rhs = params(16)*y(30)+(1-params(16))*y(31)-T(51);
residual(38) = lhs - rhs;
lhs = y(17);
rhs = T(3)+y(32)-T(52);
residual(39) = lhs - rhs;
lhs = y(18);
rhs = y(33)+log(params(1));
residual(40) = lhs - rhs;
lhs = y(19);
rhs = y(21);
residual(41) = lhs - rhs;
lhs = y(20);
rhs = y(21);
residual(42) = lhs - rhs;
lhs = y(48);
rhs = T(80)*(y(11)-T(1))+T(81)*(y(14)-T(2))+T(82)*(y(13)-T(4));
residual(43) = lhs - rhs;
lhs = y(1);
rhs = y(1)*params(23)+x(1);
residual(44) = lhs - rhs;
lhs = y(2);
rhs = y(2)*params(24)+x(3);
residual(45) = lhs - rhs;
lhs = y(3);
rhs = y(3)*params(25)+x(4);
residual(46) = lhs - rhs;
lhs = y(4);
rhs = y(4)*params(26)+x(5);
residual(47) = lhs - rhs;
lhs = y(6);
rhs = y(6)*params(28)+x(8);
residual(48) = lhs - rhs;
lhs = y(5);
rhs = y(5)*params(30)+x(7);
residual(49) = lhs - rhs;
lhs = y(7);
rhs = y(7)*params(29)+x(9);
residual(50) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
