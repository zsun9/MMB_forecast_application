function g1 = static_g1(T, y, x, params, T_flag)
% function g1 = static_g1(T, y, x, params, T_flag)
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
%   g1
%

if T_flag
    T = GSW12.static_g1_tt(T, y, x, params);
end
g1 = zeros(51, 51);
g1(1,20)=1;
g1(1,26)=(-(params(13)*(1-params(7))));
g1(1,29)=(-(params(13)*params(7)));
g1(1,37)=(-params(13));
g1(2,25)=(-1);
g1(2,35)=T(10);
g1(3,21)=(-((-params(11))/(1-T(9))+T(11)));
g1(3,24)=1;
g1(3,26)=(-T(12));
g1(4,27)=(-(T(13)*1/T(15)));
g1(4,36)=(-1);
g1(5,25)=1;
g1(5,27)=1-T(3)*(1-params(10));
g1(5,28)=(-(T(3)*T(4)));
g1(5,35)=(-T(16));
g1(6,20)=1;
g1(6,21)=(-T(7));
g1(6,22)=(-T(6));
g1(6,23)=(-(T(4)*T(5)));
g1(6,34)=(-1);
g1(7,23)=(-1);
g1(7,29)=1;
g1(7,30)=(-1);
g1(8,23)=1;
g1(8,28)=(-T(18));
g1(9,22)=(-T(8));
g1(9,30)=1-(1-T(8));
g1(9,36)=(-(T(8)*T(15)));
g1(10,28)=(-params(7));
g1(10,31)=(-(1-params(7)));
g1(10,37)=1;
g1(11,26)=(-1);
g1(11,28)=1;
g1(11,29)=1;
g1(11,31)=(-1);
g1(12,21)=(-params(33));
g1(12,32)=1-(1-params(33));
g1(13,21)=1;
g1(13,24)=1;
g1(13,26)=(-params(18));
g1(13,31)=1;
g1(13,32)=(-1);
g1(13,43)=(-1);
g1(14,26)=(-T(19));
g1(14,33)=1-(1-T(19));
g1(15,1)=1;
g1(15,2)=(-T(7));
g1(15,3)=(-T(6));
g1(15,4)=(-(T(4)*T(5)));
g1(15,34)=(-1);
g1(16,6)=(-1);
g1(16,7)=1;
g1(16,35)=T(10);
g1(17,2)=(-((-params(11))/(1-T(9))+T(11)));
g1(17,5)=1;
g1(17,8)=(-T(12));
g1(18,9)=(-(T(13)*1/T(15)));
g1(18,36)=(-1);
g1(19,6)=1;
g1(19,7)=(-1);
g1(19,9)=1-T(3)*(1-params(10));
g1(19,10)=(-(T(3)*T(4)));
g1(19,35)=(-T(16));
g1(20,1)=1;
g1(20,8)=(-(params(13)*(1-params(7))));
g1(20,11)=(-(params(13)*params(7)));
g1(20,37)=(-params(13));
g1(21,4)=(-1);
g1(21,11)=1;
g1(21,12)=(-1);
g1(22,4)=1;
g1(22,10)=(-T(18));
g1(23,3)=(-T(8));
g1(23,12)=1-(1-T(8));
g1(23,36)=(-(params(9)*T(8)*T(14)));
g1(24,10)=(-params(7));
g1(24,13)=1;
g1(24,14)=(-(1-params(7)));
g1(24,37)=1;
g1(25,7)=1-T(20)*(T(1)*T(3)+params(16));
g1(25,13)=(-(T(20)*T(21)));
g1(25,38)=(-1);
g1(26,8)=(-1);
g1(26,10)=1;
g1(26,11)=1;
g1(26,14)=(-1);
g1(27,7)=(-(params(14)/(1+T(1)*T(3))+T(22)-(1+T(1)*T(3)*params(14))/(1+T(1)*T(3))));
g1(27,14)=1-(T(13)+T(22));
g1(27,15)=T(23);
g1(27,40)=(-1);
g1(28,1)=(-((1-params(23))*params(22)));
g1(28,6)=1-params(23);
g1(28,7)=(-(params(20)*(1-params(23))));
g1(28,20)=(1-params(23))*params(22);
g1(28,42)=(-1);
g1(29,2)=(-params(33));
g1(29,16)=1-(1-params(33));
g1(30,2)=1;
g1(30,5)=1;
g1(30,14)=1;
g1(30,16)=(-1);
g1(30,17)=(-params(18));
g1(30,43)=(-1);
g1(31,15)=1;
g1(31,17)=(-1);
g1(31,19)=1;
g1(32,18)=1;
g1(32,40)=(-T(24));
g1(33,8)=(-T(19));
g1(33,19)=1-(1-T(19));
g1(34,37)=1-params(24);
g1(35,35)=1-params(25);
g1(36,34)=1-params(26);
g1(37,36)=1-params(27);
g1(38,42)=1-params(28);
g1(39,38)=1-params(29);
g1(39,39)=(-(1-params(6)));
g1(40,39)=1;
g1(41,40)=1-params(30);
g1(41,41)=(-(1-params(5)));
g1(42,41)=1;
g1(43,43)=1-params(35);
g1(44,46)=1;
g1(45,47)=1;
g1(46,48)=1;
g1(47,49)=1;
g1(48,7)=(-1);
g1(48,45)=1;
g1(49,6)=(-1);
g1(49,44)=1;
g1(50,50)=1;
g1(51,15)=(-1);
g1(51,51)=1;
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
