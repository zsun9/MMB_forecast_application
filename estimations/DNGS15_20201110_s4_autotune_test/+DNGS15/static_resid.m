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
    T = DNGS15.static_resid_tt(T, y, x, params);
end
residual = zeros(49, 1);
lhs = y(2);
rhs = T(1)*(y(9)-y(8))+y(19)+T(2)*(y(2)-y(17))+T(3)*(y(2)+y(17));
residual(1) = lhs - rhs;
lhs = y(35);
rhs = y(19)+T(1)*y(40)+T(2)*(y(35)-y(17))+T(3)*(y(17)+y(35));
residual(2) = lhs - rhs;
lhs = y(14);
rhs = T(4)*(y(3)-T(5)*(y(3)-y(17))-T(6)*(y(17)+y(3))-y(24));
residual(3) = lhs - rhs;
lhs = y(44);
rhs = T(4)*(y(36)-T(5)*(y(36)-y(17))-T(6)*(y(17)+y(36))-y(24));
residual(4) = lhs - rhs;
lhs = y(15)-y(8);
rhs = T(7)*y(10)+y(14)*T(8)-y(14);
residual(5) = lhs - rhs;
lhs = y(15)-y(9);
rhs = y(19)*T(9)+params(9)*(y(14)+y(5)-y(16))+y(23);
residual(6) = lhs - rhs;
lhs = y(16);
rhs = (y(15)-y(8))*params(91)-(y(9)-y(8))*params(92)+(y(14)+y(5))*params(93)+y(16)*params(94)-y(23)*params(96)/params(84)-y(17)*params(10)*params(76)/params(75);
residual(7) = lhs - rhs;
lhs = T(7)*y(41)+y(44)*T(8)-y(44);
rhs = y(40)-y(19)*T(10);
residual(8) = lhs - rhs;
lhs = y(1);
rhs = params(13)*(params(12)*y(4)+y(6)*(1-params(12)))+(params(13)-1)/(1-params(12))*y(18);
residual(9) = lhs - rhs;
lhs = y(34);
rhs = (params(13)-1)/(1-params(12))*y(18)+params(13)*(params(12)*y(37)+y(39)*(1-params(12)));
residual(10) = lhs - rhs;
lhs = y(4);
rhs = y(5)+y(11)-y(17);
residual(11) = lhs - rhs;
lhs = y(37);
rhs = y(42)-y(17)+y(38);
residual(12) = lhs - rhs;
lhs = y(11);
rhs = y(10)*(1-params(21))/params(21);
residual(13) = lhs - rhs;
lhs = y(42);
rhs = y(41)*(1-params(21))/params(21);
residual(14) = lhs - rhs;
lhs = y(5);
rhs = (1-T(11))*(y(5)-y(17))+y(3)*T(11)+T(13);
residual(15) = lhs - rhs;
lhs = y(38);
rhs = T(13)+(1-T(11))*(y(38)-y(17))+y(36)*T(11);
residual(16) = lhs - rhs;
lhs = y(7);
rhs = y(12)+y(6)*params(12)-params(12)*y(4);
residual(17) = lhs - rhs;
lhs = 0;
rhs = y(43)+y(39)*params(12)-params(12)*y(37);
residual(18) = lhs - rhs;
lhs = y(8);
rhs = y(7)*T(14)+y(8)*params(6)/(1+exp(params(45)*(1-params(20)))*params(41)*params(6))+y(8)*T(15)+y(21);
residual(19) = lhs - rhs;
lhs = y(4);
rhs = y(6)+y(12)-y(10);
residual(20) = lhs - rhs;
lhs = y(37);
rhs = y(39)+y(43)-y(41);
residual(21) = lhs - rhs;
lhs = y(13)-y(12);
rhs = y(2)*T(16)+y(2)*T(17)-y(17)*T(17)-y(6)*params(15);
residual(22) = lhs - rhs;
lhs = 0;
rhs = y(43)+y(35)*T(16)+y(35)*T(17)-y(17)*T(17)-y(39)*params(15);
residual(23) = lhs - rhs;
lhs = y(12);
rhs = y(13)*T(18)-y(8)*T(19)+T(5)*(y(12)-y(17)-y(8)*params(8))+T(6)*(y(8)+y(17)+y(12))+y(22);
residual(24) = lhs - rhs;
lhs = y(9);
rhs = y(9)*params(4)+(1-params(4))*(y(8)*params(1)+params(2)*(y(1)-y(34)))+y(25);
residual(25) = lhs - rhs;
lhs = y(1);
rhs = params(24)*y(20)+y(2)*params(55)/params(54)+y(3)*params(53)/params(54)+y(11)*params(48)*params(51)/params(54)+y(18)*params(24)*1/(1-params(12));
residual(26) = lhs - rhs;
lhs = y(34);
rhs = y(18)*params(24)*1/(1-params(12))+params(24)*y(20)+y(35)*params(55)/params(54)+y(36)*params(53)/params(54)+y(42)*params(48)*params(51)/params(54);
residual(27) = lhs - rhs;
lhs = y(17);
rhs = y(18)*1/(1-params(12))*(params(30)-1)+1/(1-params(12))*x(1);
residual(28) = lhs - rhs;
lhs = y(18);
rhs = x(1)+y(18)*params(30);
residual(29) = lhs - rhs;
lhs = y(20);
rhs = y(20)*params(35)+x(2)+x(1)*params(38);
residual(30) = lhs - rhs;
lhs = y(19);
rhs = y(19)*params(31)+x(3);
residual(31) = lhs - rhs;
lhs = y(24);
rhs = y(24)*params(34)+x(4);
residual(32) = lhs - rhs;
lhs = y(21);
rhs = y(21)*params(32)+x(5)-x(5)*params(36);
residual(33) = lhs - rhs;
lhs = y(22);
rhs = y(22)*params(33)+x(6)-x(6)*params(37);
residual(34) = lhs - rhs;
lhs = y(25);
rhs = y(25)*params(40)+x(8);
residual(35) = lhs - rhs;
lhs = y(23);
rhs = y(23)*params(39)+x(7);
residual(36) = lhs - rhs;
lhs = y(45);
rhs = y(1)-y(34);
residual(37) = lhs - rhs;
lhs = y(46)/4;
rhs = y(40)+params(47)-100*(params(42)-1);
residual(38) = lhs - rhs;
lhs = y(47)/4;
rhs = y(9)-y(8)+params(47)-100*(params(42)-1);
residual(39) = lhs - rhs;
lhs = y(26);
rhs = y(17)+100*(exp(params(45))-1);
residual(40) = lhs - rhs;
lhs = y(31);
rhs = y(17)+100*(exp(params(45))-1);
residual(41) = lhs - rhs;
lhs = y(32);
rhs = y(17)+100*(exp(params(45))-1);
residual(42) = lhs - rhs;
lhs = y(28);
rhs = y(17)+100*(exp(params(45))-1);
residual(43) = lhs - rhs;
lhs = y(30);
rhs = y(9)+params(47);
residual(44) = lhs - rhs;
lhs = y(29);
rhs = y(8)+100*(params(42)-1);
residual(45) = lhs - rhs;
lhs = y(33);
rhs = y(15)-y(9)+100*log(params(43));
residual(46) = lhs - rhs;
lhs = y(27);
rhs = y(6)+params(22);
residual(47) = lhs - rhs;
lhs = y(48);
rhs = x(5);
residual(48) = lhs - rhs;
lhs = y(49);
rhs = x(6);
residual(49) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
