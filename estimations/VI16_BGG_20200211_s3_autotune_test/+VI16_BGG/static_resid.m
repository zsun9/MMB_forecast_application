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
    T = VI16_BGG.static_resid_tt(T, y, x, params);
end
residual = zeros(43, 1);
lhs = y(37);
rhs = params(2)*y(21)+(1-params(2))*y(18);
residual(1) = lhs - rhs;
lhs = y(10);
rhs = y(21)*T(15);
residual(2) = lhs - rhs;
lhs = y(21);
rhs = y(18)+y(17)-y(12)-y(10);
residual(3) = lhs - rhs;
lhs = y(15);
rhs = T(16)*(y(15)+y(15)*T(10)+1/params(17)*(y(13)+y(39)));
residual(4) = lhs - rhs;
lhs = y(11);
rhs = y(21)*T(4)/T(2)+T(17)*(y(13)+y(43))-y(13);
residual(5) = lhs - rhs;
lhs = y(20);
rhs = params(12)*(y(12)+y(13)-y(22));
residual(6) = lhs - rhs;
lhs = y(11);
rhs = y(20)+y(19);
residual(7) = lhs - rhs;
lhs = y(22)/(T(2)*params(1));
rhs = y(11)*T(18)-y(19)*(T(18)-1)-(y(12)+y(13))*params(12)*(T(18)-1)+y(22)*(1+params(12)*(T(18)-1));
residual(8) = lhs - rhs;
lhs = T(11)/(1-T(11))*y(14);
rhs = T(11)/(1-T(11))*y(14)-y(19);
residual(9) = lhs - rhs;
lhs = y(16);
rhs = y(14)*T(12)+T(9)*y(15)+params(6)*y(38)+y(10)*T(4)*T(13);
residual(10) = lhs - rhs;
lhs = y(16);
rhs = params(40)*(y(37)+params(2)*(y(12)+y(43))+params(2)*y(10)+(1-params(2))*y(17));
residual(11) = lhs - rhs;
lhs = y(18);
rhs = y(14)*1/(1-T(11))+y(17)*params(41)-T(11)/(1-T(11))*y(14);
residual(12) = lhs - rhs;
lhs = y(12);
rhs = (1-params(4))*(y(12)+y(43))+T(8)*(y(15)+y(39));
residual(13) = lhs - rhs;
lhs = y(26);
rhs = T(15)*y(24);
residual(14) = lhs - rhs;
lhs = y(24);
rhs = y(35)+y(33)-y(28)-y(26);
residual(15) = lhs - rhs;
lhs = y(31);
rhs = T(16)*(y(31)+T(10)*y(31)+1/params(17)*(y(39)+y(29)));
residual(16) = lhs - rhs;
lhs = y(27);
rhs = T(4)/T(2)*y(24)+T(17)*(y(43)+y(29))-y(29);
residual(17) = lhs - rhs;
lhs = y(23);
rhs = params(12)*(y(28)+y(29)-y(25));
residual(18) = lhs - rhs;
lhs = y(27);
rhs = y(23)+y(36)-y(34);
residual(19) = lhs - rhs;
lhs = y(25)/(T(2)*params(1));
rhs = T(18)*y(27)-(T(18)-1)*y(36)-params(12)*(T(18)-1)*(y(28)+y(29))+(1+params(12)*(T(18)-1))*y(25);
residual(20) = lhs - rhs;
lhs = T(11)/(1-T(11))*y(30);
rhs = T(11)/(1-T(11))*y(30)-y(36);
residual(21) = lhs - rhs;
lhs = y(32);
rhs = params(6)*y(38)+T(12)*y(30)+T(9)*y(31)+T(4)*T(13)*y(26);
residual(22) = lhs - rhs;
lhs = y(32);
rhs = params(40)*(y(37)+params(2)*(y(43)+y(28))+params(2)*y(26)+(1-params(2))*y(33));
residual(23) = lhs - rhs;
lhs = y(34);
rhs = T(19)*(T(10)*y(34)+y(34)*params(23)+T(20)*(params(2)*y(24)-y(37)+(1-params(2))*y(35)))+y(41);
residual(24) = lhs - rhs;
lhs = y(35);
rhs = T(16)*y(35)+y(35)*T(21)+y(34)*params(22)/(1+T(10))-y(34)*(1+T(10)*params(22))/(1+T(10))+y(34)*T(21)+T(22)*(1/(1-T(11))*y(30)+params(41)*y(33)-T(11)/(1-T(11))*y(30)-y(35))+y(42);
residual(25) = lhs - rhs;
lhs = y(36);
rhs = y(34)*(1-params(28))*params(25)+(1-params(28))*params(27)*(y(32)-y(16))+params(26)*(y(16)+y(32)-y(16)-y(32))+y(36)*params(28)+y(40);
residual(26) = lhs - rhs;
lhs = y(28);
rhs = (1-params(4))*(y(43)+y(28))+T(8)*y(31)+y(39)*T(8)*params(17);
residual(27) = lhs - rhs;
lhs = y(37);
rhs = y(37)*params(30)-x(1);
residual(28) = lhs - rhs;
lhs = y(38);
rhs = y(38)*params(32)-x(2)-x(1)*params(16);
residual(29) = lhs - rhs;
lhs = y(39);
rhs = y(39)*params(33)-x(3);
residual(30) = lhs - rhs;
lhs = y(40);
rhs = y(40)*params(34)+x(4);
residual(31) = lhs - rhs;
lhs = y(41);
rhs = y(41)*params(35)+y(9)-y(9)*params(38);
residual(32) = lhs - rhs;
lhs = y(9);
rhs = x(5);
residual(33) = lhs - rhs;
lhs = y(42);
rhs = y(42)*params(36)+y(8)-y(8)*params(37);
residual(34) = lhs - rhs;
lhs = y(8);
rhs = x(6);
residual(35) = lhs - rhs;
lhs = y(43);
rhs = y(43)*params(31)+x(7);
residual(36) = lhs - rhs;
lhs = y(4);
rhs = params(13);
residual(37) = lhs - rhs;
lhs = y(5);
rhs = params(13);
residual(38) = lhs - rhs;
lhs = y(6);
rhs = params(13);
residual(39) = lhs - rhs;
lhs = y(7);
rhs = params(13);
residual(40) = lhs - rhs;
lhs = y(3);
rhs = params(42)+y(34);
residual(41) = lhs - rhs;
lhs = y(2);
rhs = y(36)+T(14);
residual(42) = lhs - rhs;
lhs = y(1);
rhs = y(33)+params(39);
residual(43) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
