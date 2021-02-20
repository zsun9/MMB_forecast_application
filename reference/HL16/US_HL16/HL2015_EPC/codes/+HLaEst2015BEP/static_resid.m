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
    T = HLaEst2015BEP.static_resid_tt(T, y, x, params);
end
residual = zeros(48, 1);
lhs = y(5);
rhs = (y(6)+(params(5)-1)*y(7)-params(5)*params(10)/(1-params(2))*(y(1)-params(2)*y(1)))*params(1)*T(5)+T(5)*(T(6)-y(6))+((params(5)-1)*y(7)+y(6)+params(5)*(y(8)+y(11)+y(3)))*(T(2)-params(1))*(1-params(7))*params(6)*T(5);
residual(1) = lhs - rhs;
lhs = y(9);
rhs = params(7)/params(4)*(y(10)+y(13))+T(7)*(y(6)+(params(5)-1)*y(7)+y(5)*params(5))-y(4)+T(2)*y(3)+T(2)*y(11);
residual(2) = lhs - rhs;
lhs = (T(2)-params(1))*y(8);
rhs = params(1)*(T(6)+y(3))-T(2)*(T(6)+y(4));
residual(3) = lhs - rhs;
lhs = y(10);
rhs = T(6)+y(13)*params(8)*(1+(T(2)-params(1))*params(6)*params(7))-(T(2)-params(1))*params(6)*params(7)*(y(3)+y(8)+y(11)+y(10));
residual(4) = lhs - rhs;
lhs = y(14);
rhs = (y(15)-params(2)*y(15))*T(8)-(y(3)+T(9)-y(2))*T(10);
residual(5) = lhs - rhs;
lhs = y(16);
rhs = (y(6)+(params(5)-1)*y(7)-(y(15)-params(2)*y(15))*params(5)*params(9)/(1-params(2)))*params(11)*T(5)+T(5)*(T(9)-y(6));
residual(6) = lhs - rhs;
lhs = y(10);
rhs = T(9)+params(8)*y(12);
residual(7) = lhs - rhs;
lhs = y(15)+0.789*y(14)+T(1)*(y(6)+y(16));
rhs = T(1)*(y(6)+y(16))+(y(10)+y(12))*T(11)+(y(14)+y(2)-y(3))*0.789*params(3)+(y(7)+y(16))*T(1)*(params(5)-1);
residual(8) = lhs - rhs;
lhs = y(3);
rhs = y(39)+y(3)*params(11)/(1+params(11)*params(14))+y(3)*params(14)/(1+params(11)*params(14))-y(17)*T(12);
residual(9) = lhs - rhs;
lhs = y(20);
rhs = y(18)-y(17)-y(10);
residual(10) = lhs - rhs;
lhs = (T(3)-params(19))*y(25);
rhs = params(19)*y(3)-T(3)*y(23);
residual(11) = lhs - rhs;
lhs = y(26)-y(19);
rhs = params(19)*(y(26)-y(19))+(y(18)-y(17)-y(19))*T(13)+(y(25)+y(24)+y(22))*(T(3)-params(19))*params(16)*params(17)*1/params(21);
residual(12) = lhs - rhs;
lhs = y(22);
rhs = (y(26)-y(19))*params(21);
residual(13) = lhs - rhs;
lhs = y(21);
rhs = params(17)/params(18)*(y(19)+y(22))+y(6)*(1-params(17))/params(18)-y(23)+T(3)*y(3)+T(3)*y(24);
residual(14) = lhs - rhs;
lhs = y(18);
rhs = params(15)*y(19)+(1-params(15))*y(20)+y(33);
residual(15) = lhs - rhs;
lhs = y(19);
rhs = (1-params(20))*y(19)+params(20)*y(26);
residual(16) = lhs - rhs;
lhs = y(27);
rhs = (1-params(23))*y(27)+params(23)*y(28)-y(3)*(1-(1-params(23))*params(34));
residual(17) = lhs - rhs;
lhs = y(29);
rhs = y(2)-T(14)*(y(27)-y(30));
residual(18) = lhs - rhs;
lhs = y(23);
rhs = y(23)*params(26)/(params(26)+params(27)-1+params(26)*params(28))+y(23)*params(26)*params(28)/(params(26)+params(27)-1+params(26)*params(28))+y(29)*(params(27)-1)/(params(26)+params(27)-1+params(26)*params(28))-y(36)/(params(26)+params(27)-1+params(26)*params(28));
residual(19) = lhs - rhs;
lhs = y(4);
rhs = y(4)*params(29)/(params(29)+params(30)-1+params(28)*params(29))+y(4)*params(28)*params(29)/(params(29)+params(30)-1+params(28)*params(29))+y(29)*(params(30)-1)/(params(29)+params(30)-1+params(28)*params(29))-y(37)/(params(29)+params(30)-1+params(28)*params(29));
residual(20) = lhs - rhs;
lhs = ((params(18)-1)*params(32)+(params(4)-1)*params(31)-(1-params(25))*(params(3)-1))*y(28);
rhs = (params(4)-1)*params(31)*(y(9)+y(4))+(params(18)-1)*params(32)*(y(23)+y(21))-(1-params(25))*(params(3)-1)*(y(14)+y(2));
residual(21) = lhs - rhs;
lhs = y(2);
rhs = y(2)*params(36)+y(3)*params(37)*(1-params(36))+y(35);
residual(22) = lhs - rhs;
lhs = y(18);
rhs = y(27)*params(23)*params(40)+y(15)*params(39)*params(22)+y(1)*params(39)*(1-params(22))+T(4)*y(26)-y(3)*params(23)*params(40);
residual(23) = lhs - rhs;
lhs = y(32);
rhs = y(15)*params(22)+y(1)*(1-params(22));
residual(24) = lhs - rhs;
lhs = y(20);
rhs = y(12)*params(22)+y(13)*(1-params(22));
residual(25) = lhs - rhs;
lhs = y(6);
rhs = (1-params(22))*(T(6)+params(1)*(y(6)+(params(5)-1)*y(7)-params(5)*params(10)/(1-params(2))*(y(1)-params(2)*y(1)))+((params(5)-1)*y(7)+y(6)+params(5)*(y(8)+y(11)+y(3)))*(T(2)-params(1))*params(6)*(1-params(7)))+params(22)*(T(9)+params(11)*(y(6)+(params(5)-1)*y(7)-(y(15)-params(2)*y(15))*params(5)*params(9)/(1-params(2))))-y(38);
residual(26) = lhs - rhs;
lhs = y(7);
rhs = y(6)*(params(5)-1)*params(35)+y(28)*(1-params(35));
residual(27) = lhs - rhs;
lhs = y(30);
rhs = params(31)*y(9)+params(32)*y(21);
residual(28) = lhs - rhs;
lhs = y(30);
rhs = params(25)*y(27)+(1-params(25))*(y(14)-y(34));
residual(29) = lhs - rhs;
lhs = y(33);
rhs = y(33)*params(43)+x(2);
residual(30) = lhs - rhs;
lhs = y(34);
rhs = y(34)*params(44)+x(4);
residual(31) = lhs - rhs;
lhs = y(35);
rhs = y(35)*params(45)+x(3);
residual(32) = lhs - rhs;
lhs = y(36);
rhs = y(36)*params(46)+x(6);
residual(33) = lhs - rhs;
lhs = y(37);
rhs = y(37)*params(47)+x(5);
residual(34) = lhs - rhs;
lhs = y(11);
rhs = y(11)*params(48)+x(7);
residual(35) = lhs - rhs;
lhs = y(24);
rhs = y(24)*params(49)+x(8);
residual(36) = lhs - rhs;
lhs = y(38);
rhs = y(38)*params(50)+x(9);
residual(37) = lhs - rhs;
lhs = y(39);
rhs = y(39)*params(51)+x(1);
residual(38) = lhs - rhs;
lhs = y(31);
rhs = y(27)-y(30);
residual(39) = lhs - rhs;
lhs = y(40);
rhs = y(3)+params(55);
residual(40) = lhs - rhs;
lhs = y(41);
rhs = 0.01537;
residual(41) = lhs - rhs;
lhs = y(42);
rhs = 0.0039;
residual(42) = lhs - rhs;
lhs = y(43);
rhs = 0.007885;
residual(43) = lhs - rhs;
lhs = y(44);
rhs = 0.006;
residual(44) = lhs - rhs;
lhs = y(45);
rhs = 0.0046;
residual(45) = lhs - rhs;
lhs = y(47);
rhs = y(4)+params(52);
residual(46) = lhs - rhs;
lhs = y(48);
rhs = y(23)+params(53);
residual(47) = lhs - rhs;
lhs = y(46);
rhs = y(2)+params(54);
residual(48) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
