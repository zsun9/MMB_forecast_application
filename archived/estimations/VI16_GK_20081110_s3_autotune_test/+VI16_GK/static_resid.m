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
    T = VI16_GK.static_resid_tt(T, y, x, params);
end
residual = zeros(61, 1);
lhs = (1-T(9))*y(54);
rhs = T(9)*y(43)-y(43);
residual(1) = lhs - rhs;
residual(2) = y(46);
residual(3) = y(46)+y(60);
lhs = y(59);
rhs = params(2)*y(47)-y(54);
residual(4) = lhs - rhs;
lhs = y(49);
rhs = params(1)*params(12)*T(15)*(y(49)+y(46)+y(51))+T(21)*(params(38)*y(50)-T(1)*y(60))+y(46)*T(22);
residual(5) = lhs - rhs;
lhs = y(48);
rhs = T(13)*params(1)*params(12)*(y(48)+y(46)+y(52));
residual(6) = lhs - rhs;
lhs = y(52);
rhs = T(23)*(y(50)*params(38)*T(12)+y(60)*T(1)*(1-T(12))+(params(38)-T(1))*T(12)*y(44));
residual(7) = lhs - rhs;
lhs = y(51);
rhs = y(52);
residual(8) = lhs - rhs;
lhs = y(44);
rhs = y(48)+y(49)*T(16)/(params(11)-T(16));
residual(9) = lhs - rhs;
lhs = y(56);
rhs = y(52)+y(55);
residual(10) = lhs - rhs;
lhs = y(57)+y(45);
rhs = y(44)+y(55);
residual(11) = lhs - rhs;
lhs = y(55);
rhs = y(56)*T(17)/T(11)+T(10)/T(11)*y(53);
residual(12) = lhs - rhs;
lhs = y(53);
rhs = y(57)+y(45);
residual(13) = lhs - rhs;
lhs = y(42);
rhs = y(50)-y(60);
residual(14) = lhs - rhs;
lhs = y(40);
rhs = params(30)*(y(33)+params(5)*(y(57)+y(37))+params(5)*y(58)+(1-params(5))*y(47));
residual(15) = lhs - rhs;
lhs = y(50);
rhs = T(3)/params(38)*y(61)+T(24)*(y(45)+y(37))-y(45);
residual(16) = lhs - rhs;
lhs = y(58);
rhs = y(61)*T(25);
residual(17) = lhs - rhs;
lhs = y(33);
rhs = params(5)*y(61)+(1-params(5))*y(59);
residual(18) = lhs - rhs;
lhs = y(61);
rhs = y(59)+y(47)-y(57)-y(58);
residual(19) = lhs - rhs;
lhs = y(41);
rhs = T(26)*(y(41)+T(14)*y(41)+1/params(14)*(y(45)+y(22)));
residual(20) = lhs - rhs;
lhs = y(57);
rhs = (1-params(6))*(y(57)+y(37))+params(6)*y(41)+y(22)*T(7)*params(14);
residual(21) = lhs - rhs;
lhs = y(40);
rhs = y(43)*T(18)+T(8)*y(41)+params(9)*y(31)+y(58)*T(3)*T(19);
residual(22) = lhs - rhs;
lhs = (1-T(9))*y(25);
rhs = T(9)*y(14)-y(14);
residual(23) = lhs - rhs;
residual(24) = y(17);
residual(25) = y(17)+y(32)-y(13);
lhs = y(30);
rhs = T(26)*y(30)+y(30)*T(27)+y(13)*params(18)/(1+T(14))-y(13)*(1+T(14)*params(18))/(1+T(14))+y(13)*T(27)+T(28)*(params(2)*y(18)+y(14)*1/(1-T(9))-y(14)*T(9)/(1-T(9))-y(30))+y(36);
residual(26) = lhs - rhs;
lhs = y(20);
rhs = params(1)*params(12)*T(15)*(y(20)+y(17)+y(34))+T(21)*(params(38)*y(21)-T(1)*(y(32)-y(13)))+T(22)*y(17);
residual(27) = lhs - rhs;
lhs = y(19);
rhs = T(13)*params(1)*params(12)*(y(19)+y(17)+y(23));
residual(28) = lhs - rhs;
lhs = y(23);
rhs = T(23)*(params(38)*T(12)*y(21)+T(1)*(1-T(12))*(y(32)-y(13))+(params(38)-T(1))*T(12)*y(15));
residual(29) = lhs - rhs;
lhs = y(34);
rhs = y(23);
residual(30) = lhs - rhs;
lhs = y(15);
rhs = y(19)+T(16)/(params(11)-T(16))*y(20);
residual(31) = lhs - rhs;
lhs = y(27);
rhs = y(23)+y(26);
residual(32) = lhs - rhs;
lhs = y(28)+y(16);
rhs = y(15)+y(26);
residual(33) = lhs - rhs;
lhs = y(26);
rhs = T(17)/T(11)*y(27)+T(10)/T(11)*y(24);
residual(34) = lhs - rhs;
lhs = y(24);
rhs = y(28)+y(16);
residual(35) = lhs - rhs;
lhs = y(12);
rhs = y(21)-(y(32)-y(13));
residual(36) = lhs - rhs;
lhs = y(10);
rhs = params(30)*(y(33)+params(5)*(y(37)+y(28))+params(5)*y(29)+(1-params(5))*y(18));
residual(37) = lhs - rhs;
lhs = y(21);
rhs = T(3)/params(38)*y(38)+T(24)*(y(37)+y(16))-y(16);
residual(38) = lhs - rhs;
lhs = y(29);
rhs = T(25)*y(38);
residual(39) = lhs - rhs;
lhs = y(38);
rhs = y(30)+y(18)-y(28)-y(29);
residual(40) = lhs - rhs;
lhs = y(11);
rhs = T(26)*(y(11)+T(14)*y(11)+1/params(14)*(y(22)+y(16)));
residual(41) = lhs - rhs;
lhs = y(28);
rhs = y(22)*T(7)*params(14)+(1-params(6))*(y(37)+y(28))+params(6)*y(11);
residual(42) = lhs - rhs;
lhs = y(10);
rhs = params(9)*y(31)+T(18)*y(14)+T(8)*y(11)+T(3)*T(19)*y(29);
residual(43) = lhs - rhs;
lhs = y(13);
rhs = T(29)*(T(14)*y(13)+y(13)*params(16)+T(30)*(params(5)*y(38)-y(33)+(1-params(5))*y(30)))+y(35);
residual(44) = lhs - rhs;
lhs = y(32);
rhs = y(32)*params(21)+(1-params(21))*(y(13)*params(22)+params(23)*(y(10)-y(40)))+params(32)*(y(40)+y(10)-y(40)-y(10))+y(39);
residual(45) = lhs - rhs;
lhs = y(33);
rhs = y(33)*params(24)-x(5);
residual(46) = lhs - rhs;
lhs = y(22);
rhs = y(22)*params(26)-x(1);
residual(47) = lhs - rhs;
lhs = y(31);
rhs = y(31)*params(25)-x(4);
residual(48) = lhs - rhs;
lhs = y(39);
rhs = y(39)*params(37)+x(2);
residual(49) = lhs - rhs;
lhs = y(35);
rhs = y(35)*params(29)+y(9)-y(9)*params(35);
residual(50) = lhs - rhs;
lhs = y(9);
rhs = x(7);
residual(51) = lhs - rhs;
lhs = y(36);
rhs = y(36)*params(28)+y(8)-y(8)*params(34);
residual(52) = lhs - rhs;
lhs = y(8);
rhs = x(6);
residual(53) = lhs - rhs;
lhs = y(37);
rhs = y(37)*params(27)-x(3);
residual(54) = lhs - rhs;
lhs = y(4);
rhs = params(41);
residual(55) = lhs - rhs;
lhs = y(5);
rhs = params(41);
residual(56) = lhs - rhs;
lhs = y(6);
rhs = params(41);
residual(57) = lhs - rhs;
lhs = y(7);
rhs = params(41);
residual(58) = lhs - rhs;
lhs = y(3);
rhs = params(40)+y(13);
residual(59) = lhs - rhs;
lhs = y(2);
rhs = y(32)+T(20);
residual(60) = lhs - rhs;
lhs = y(1);
rhs = y(18)+params(39);
residual(61) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
