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
    T = NKBGG.static_g1_tt(T, y, x, params);
end
g1 = zeros(34, 34);
g1(1,1)=(-T(26));
g1(1,10)=1;
g1(1,12)=(-T(27));
g1(1,14)=(-T(28));
g1(1,15)=(-params(3));
g1(2,4)=1;
g1(3,8)=(-1);
g1(3,14)=1;
g1(4,4)=(-1);
g1(4,6)=(-params(22));
g1(4,7)=(-params(22));
g1(4,8)=params(22);
g1(4,9)=1;
g1(4,18)=(-T(29));
g1(5,6)=(-(T(30)-1));
g1(5,7)=1-T(30);
g1(5,9)=1;
g1(5,10)=(-(1-T(30)));
g1(5,11)=1-T(30);
g1(6,6)=(-T(38));
g1(6,12)=T(42);
g1(6,17)=(-T(38));
g1(7,2)=(-((1-params(5))*params(4)));
g1(7,7)=(-params(5));
g1(7,10)=1;
g1(7,13)=(-(1-params(5)));
g1(8,1)=(-1);
g1(8,2)=(-1)-T(39);
g1(8,10)=1;
g1(8,11)=(-1);
g1(9,3)=1-(params(24)/(1+T(2)*params(24))+T(2)/(1+T(2)*params(24)));
g1(9,11)=1/(1+T(2)*params(24))*T(31);
g1(10,7)=T(40);
g1(10,12)=(-T(40));
g1(10,17)=(-T(40));
g1(11,4)=T(33);
g1(11,6)=(-T(34));
g1(11,7)=(-T(34));
g1(11,8)=1;
g1(11,9)=(-T(32));
g1(11,10)=(-T(41));
g1(11,11)=T(41);
g1(11,18)=T(36);
g1(12,3)=(-((1-params(13))*params(11)));
g1(12,5)=1-params(13);
g1(12,10)=(-((1-params(13))*params(12)));
g1(12,19)=(1-params(13))*params(12);
g1(13,3)=(-1);
g1(13,4)=(-1);
g1(13,5)=1;
g1(14,4)=1;
g1(14,9)=(-1);
g1(14,16)=1;
g1(15,13)=1-params(14);
g1(16,15)=1-params(15);
g1(17,17)=1-params(16);
g1(18,18)=1-params(17);
g1(19,15)=(-params(3));
g1(19,19)=1;
g1(19,21)=(-T(27));
g1(19,25)=(-T(26));
g1(19,28)=(-T(28));
g1(20,22)=1;
g1(21,24)=(-1);
g1(21,28)=1;
g1(22,22)=(-1);
g1(22,23)=1;
g1(23,19)=(-(1-T(30)));
g1(23,20)=1-T(30);
g1(23,23)=1;
g1(23,26)=(-(T(30)-1));
g1(24,17)=(-T(38));
g1(24,21)=T(42);
g1(24,26)=(-T(38));
g1(25,13)=(-(1-params(5)));
g1(25,19)=1;
g1(25,20)=(-params(5));
g1(25,27)=(-((1-params(5))*params(4)));
g1(26,19)=1;
g1(26,25)=(-1);
g1(26,27)=(-1)-T(39);
g1(27,17)=(-T(40));
g1(27,20)=T(40);
g1(27,21)=(-T(40));
g1(28,18)=T(36);
g1(28,19)=(-T(41));
g1(28,20)=(-T(34));
g1(28,22)=T(33);
g1(28,23)=(-T(32));
g1(28,24)=1;
g1(28,26)=(-T(34));
g1(29,10)=(-1);
g1(29,19)=1;
g1(29,34)=1;
g1(30,29)=1;
g1(31,32)=1;
g1(32,3)=(-1);
g1(32,30)=1;
g1(33,5)=(-1);
g1(33,31)=1;
g1(34,16)=(-1);
g1(34,33)=1;
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
