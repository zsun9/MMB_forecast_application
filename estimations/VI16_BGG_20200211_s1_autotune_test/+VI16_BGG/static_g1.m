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
    T = VI16_BGG.static_g1_tt(T, y, x, params);
end
g1 = zeros(43, 43);
g1(1,18)=(-(1-params(2)));
g1(1,21)=(-params(2));
g1(1,37)=1;
g1(2,10)=1;
g1(2,21)=(-T(15));
g1(3,10)=1;
g1(3,12)=1;
g1(3,17)=(-1);
g1(3,18)=(-1);
g1(3,21)=1;
g1(4,13)=T(23);
g1(4,39)=T(23);
g1(5,11)=1;
g1(5,13)=(-(T(17)-1));
g1(5,21)=(-(T(4)/T(2)));
g1(5,43)=(-T(17));
g1(6,12)=(-params(12));
g1(6,13)=(-params(12));
g1(6,20)=1;
g1(6,22)=params(12);
g1(7,11)=1;
g1(7,19)=(-1);
g1(7,20)=(-1);
g1(8,11)=(-T(18));
g1(8,12)=params(12)*(T(18)-1);
g1(8,13)=params(12)*(T(18)-1);
g1(8,19)=T(18)-1;
g1(8,22)=1/(T(2)*params(1))-(1+params(12)*(T(18)-1));
g1(9,19)=1;
g1(10,10)=(-(T(4)*T(13)));
g1(10,14)=(-T(12));
g1(10,15)=(-T(9));
g1(10,16)=1;
g1(10,38)=(-params(6));
g1(11,10)=(-(params(2)*params(40)));
g1(11,12)=(-(params(2)*params(40)));
g1(11,16)=1;
g1(11,17)=(-((1-params(2))*params(40)));
g1(11,37)=(-params(40));
g1(11,43)=(-(params(2)*params(40)));
g1(12,14)=(-T(24));
g1(12,17)=(-params(41));
g1(12,18)=1;
g1(13,12)=1-(1-params(4));
g1(13,15)=(-T(8));
g1(13,39)=(-T(8));
g1(13,43)=(-(1-params(4)));
g1(14,24)=(-T(15));
g1(14,26)=1;
g1(15,24)=1;
g1(15,26)=1;
g1(15,28)=1;
g1(15,33)=(-1);
g1(15,35)=(-1);
g1(16,29)=T(23);
g1(16,39)=T(23);
g1(17,24)=(-(T(4)/T(2)));
g1(17,27)=1;
g1(17,29)=(-(T(17)-1));
g1(17,43)=(-T(17));
g1(18,23)=1;
g1(18,25)=params(12);
g1(18,28)=(-params(12));
g1(18,29)=(-params(12));
g1(19,23)=(-1);
g1(19,27)=1;
g1(19,34)=1;
g1(19,36)=(-1);
g1(20,25)=1/(T(2)*params(1))-(1+params(12)*(T(18)-1));
g1(20,27)=(-T(18));
g1(20,28)=params(12)*(T(18)-1);
g1(20,29)=params(12)*(T(18)-1);
g1(20,36)=T(18)-1;
g1(21,36)=1;
g1(22,26)=(-(T(4)*T(13)));
g1(22,30)=(-T(12));
g1(22,31)=(-T(9));
g1(22,32)=1;
g1(22,38)=(-params(6));
g1(23,26)=(-(params(2)*params(40)));
g1(23,28)=(-(params(2)*params(40)));
g1(23,32)=1;
g1(23,33)=(-((1-params(2))*params(40)));
g1(23,37)=(-params(40));
g1(23,43)=(-(params(2)*params(40)));
g1(24,24)=(-(T(19)*params(2)*T(20)));
g1(24,34)=1-T(19)*(T(10)+params(23));
g1(24,35)=(-(T(19)*(1-params(2))*T(20)));
g1(24,37)=(-(T(19)*(-T(20))));
g1(24,41)=(-1);
g1(25,30)=(-(T(22)*T(24)));
g1(25,33)=(-(params(41)*T(22)));
g1(25,34)=(-(T(21)+params(22)/(1+T(10))-(1+T(10)*params(22))/(1+T(10))));
g1(25,35)=1-(T(16)+T(21)-T(22));
g1(25,42)=(-1);
g1(26,16)=(1-params(28))*params(27);
g1(26,32)=(-((1-params(28))*params(27)));
g1(26,34)=(-((1-params(28))*params(25)));
g1(26,36)=1-params(28);
g1(26,40)=(-1);
g1(27,28)=1-(1-params(4));
g1(27,31)=(-T(8));
g1(27,39)=(-(T(8)*params(17)));
g1(27,43)=(-(1-params(4)));
g1(28,37)=1-params(30);
g1(29,38)=1-params(32);
g1(30,39)=1-params(33);
g1(31,40)=1-params(34);
g1(32,9)=(-(1-params(38)));
g1(32,41)=1-params(35);
g1(33,9)=1;
g1(34,8)=(-(1-params(37)));
g1(34,42)=1-params(36);
g1(35,8)=1;
g1(36,43)=1-params(31);
g1(37,4)=1;
g1(38,5)=1;
g1(39,6)=1;
g1(40,7)=1;
g1(41,3)=1;
g1(41,34)=(-1);
g1(42,2)=1;
g1(42,36)=(-1);
g1(43,1)=1;
g1(43,33)=(-1);
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
