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
    T = FU20.static_g1_tt(T, y, x, params);
end
g1 = zeros(40, 40);
g1(1,11)=(-T(2));
g1(1,12)=T(10);
g1(1,13)=T(2);
g1(1,35)=(-1);
g1(2,19)=(-(T(3)*1/T(4)));
g1(2,36)=(-1);
g1(3,10)=(-(params(8)/(1+params(8)-params(9))));
g1(3,11)=(-1);
g1(3,13)=1;
g1(3,19)=1-T(5);
g1(3,35)=(-(1/T(2)));
g1(4,10)=(-T(6));
g1(4,16)=1;
g1(5,15)=1;
g1(5,16)=(-1);
g1(5,17)=(-1);
g1(6,17)=1-(1-params(47));
g1(6,18)=(-params(47));
g1(6,36)=(-(T(4)*params(47)));
g1(7,14)=(-(params(11)*(1-params(12))));
g1(7,15)=(-(params(11)*params(12)));
g1(7,20)=1;
g1(7,32)=(-params(11));
g1(8,9)=(-1);
g1(8,10)=1;
g1(8,14)=(-1);
g1(8,15)=1;
g1(9,8)=1;
g1(9,9)=(-(1-params(12)));
g1(9,10)=(-params(12));
g1(9,32)=1;
g1(10,8)=(-T(7));
g1(10,11)=1-(params(14)/(1+params(2)*params(6)*params(14))+params(2)*params(6)/(1+params(2)*params(6)*params(14)));
g1(10,33)=(-1);
g1(11,9)=1-T(3)*(1+params(2)*params(6)-T(8));
g1(11,11)=(-(T(3)*(params(2)*params(6)+params(18)-(1+params(2)*params(6)*params(18)))));
g1(11,12)=(-(T(3)*T(8)*T(11)));
g1(11,14)=(-(T(3)*T(8)*params(17)));
g1(11,34)=(-1);
g1(12,11)=(-((1-params(20))*params(21)));
g1(12,13)=1-params(20);
g1(12,20)=(-((1-params(20))*params(22)));
g1(12,30)=(-((1-params(20))*(-params(22))));
g1(12,38)=(-1);
g1(13,12)=(-params(24));
g1(13,16)=(-(params(8)*params(25)));
g1(13,18)=(-params(10));
g1(13,20)=1;
g1(13,37)=(-1);
g1(14,23)=T(10);
g1(14,24)=T(2);
g1(14,35)=(-1);
g1(15,31)=(-(T(3)*1/T(4)));
g1(15,36)=(-1);
g1(16,22)=(-(params(8)/(1+params(8)-params(9))));
g1(16,24)=1;
g1(16,31)=1-T(5);
g1(16,35)=(-(1/T(2)));
g1(17,22)=(-T(6));
g1(17,27)=1;
g1(18,26)=1;
g1(18,27)=(-1);
g1(18,28)=(-1);
g1(19,28)=1-(1-T(9));
g1(19,29)=(-T(9));
g1(19,36)=(-(T(4)*T(9)));
g1(20,25)=(-(params(11)*(1-params(12))));
g1(20,26)=(-(params(11)*params(12)));
g1(20,30)=1;
g1(20,32)=(-params(11));
g1(21,21)=(-1);
g1(21,22)=1;
g1(21,25)=(-1);
g1(21,26)=1;
g1(22,21)=(-(1-params(12)));
g1(22,22)=(-params(12));
g1(22,32)=1;
g1(23,21)=1;
g1(23,23)=(-T(11));
g1(23,25)=(-params(17));
g1(24,23)=(-params(24));
g1(24,27)=(-(params(8)*params(25)));
g1(24,29)=(-params(10));
g1(24,30)=1;
g1(24,37)=(-1);
g1(25,32)=1-params(34);
g1(26,35)=1-params(35);
g1(27,37)=1-params(36);
g1(28,36)=1-params(38);
g1(29,33)=1-params(39);
g1(30,34)=1-params(41);
g1(31,38)=1-params(43);
g1(32,4)=1;
g1(33,5)=1;
g1(34,6)=1;
g1(35,7)=1;
g1(36,3)=1;
g1(36,11)=(-1);
g1(37,2)=1;
g1(37,13)=(-1);
g1(38,1)=1;
g1(38,14)=(-1);
g1(39,39)=1;
g1(40,40)=1;
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
