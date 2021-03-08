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
    T = DNGS15.static_g1_tt(T, y, x, params);
end
g1 = zeros(49, 49);
g1(1,2)=1-(T(2)+T(3));
g1(1,8)=T(1);
g1(1,9)=(-T(1));
g1(1,17)=(-(T(3)-T(2)));
g1(1,19)=(-1);
g1(2,17)=(-(T(3)-T(2)));
g1(2,19)=(-1);
g1(2,35)=1-(T(2)+T(3));
g1(2,40)=(-T(1));
g1(3,3)=(-(T(4)*(1-T(5)-T(6))));
g1(3,14)=1;
g1(3,17)=(-(T(4)*(T(5)-T(6))));
g1(3,24)=T(4);
g1(4,17)=(-(T(4)*(T(5)-T(6))));
g1(4,24)=T(4);
g1(4,36)=(-(T(4)*(1-T(5)-T(6))));
g1(4,44)=1;
g1(5,8)=(-1);
g1(5,10)=(-T(7));
g1(5,14)=(-(T(8)-1));
g1(5,15)=1;
g1(6,5)=(-params(9));
g1(6,9)=(-1);
g1(6,14)=(-params(9));
g1(6,15)=1;
g1(6,16)=params(9);
g1(6,19)=(-T(9));
g1(6,23)=(-1);
g1(7,5)=(-params(93));
g1(7,8)=(-(params(92)-params(91)));
g1(7,9)=params(92);
g1(7,14)=(-params(93));
g1(7,15)=(-params(91));
g1(7,16)=1-params(94);
g1(7,17)=params(10)*params(76)/params(75);
g1(7,23)=params(96)/params(84);
g1(8,19)=T(10);
g1(8,40)=(-1);
g1(8,41)=T(7);
g1(8,44)=T(8)-1;
g1(9,1)=1;
g1(9,4)=(-(params(13)*params(12)));
g1(9,6)=(-(params(13)*(1-params(12))));
g1(9,18)=(-((params(13)-1)/(1-params(12))));
g1(10,18)=(-((params(13)-1)/(1-params(12))));
g1(10,34)=1;
g1(10,37)=(-(params(13)*params(12)));
g1(10,39)=(-(params(13)*(1-params(12))));
g1(11,4)=1;
g1(11,5)=(-1);
g1(11,11)=(-1);
g1(11,17)=1;
g1(12,17)=1;
g1(12,37)=1;
g1(12,38)=(-1);
g1(12,42)=(-1);
g1(13,10)=(-((1-params(21))/params(21)));
g1(13,11)=1;
g1(14,41)=(-((1-params(21))/params(21)));
g1(14,42)=1;
g1(15,3)=(-T(11));
g1(15,5)=1-(1-T(11));
g1(15,17)=1-T(11);
g1(15,24)=(-T(12));
g1(16,17)=1-T(11);
g1(16,24)=(-T(12));
g1(16,36)=(-T(11));
g1(16,38)=1-(1-T(11));
g1(17,4)=params(12);
g1(17,6)=(-params(12));
g1(17,7)=1;
g1(17,12)=(-1);
g1(18,37)=params(12);
g1(18,39)=(-params(12));
g1(18,43)=(-1);
g1(19,7)=(-T(14));
g1(19,8)=1-(params(6)/(1+exp(params(45)*(1-params(20)))*params(41)*params(6))+T(15));
g1(19,21)=(-1);
g1(20,4)=1;
g1(20,6)=(-1);
g1(20,10)=1;
g1(20,12)=(-1);
g1(21,37)=1;
g1(21,39)=(-1);
g1(21,41)=1;
g1(21,43)=(-1);
g1(22,2)=(-(T(16)+T(17)));
g1(22,6)=params(15);
g1(22,12)=(-1);
g1(22,13)=1;
g1(22,17)=T(17);
g1(23,17)=T(17);
g1(23,35)=(-(T(16)+T(17)));
g1(23,39)=params(15);
g1(23,43)=(-1);
g1(24,8)=(-(T(6)+T(5)*(-params(8))-T(19)));
g1(24,12)=1-(T(5)+T(6));
g1(24,13)=(-T(18));
g1(24,17)=(-(T(6)-T(5)));
g1(24,22)=(-1);
g1(25,1)=(-((1-params(4))*params(2)));
g1(25,8)=(-((1-params(4))*params(1)));
g1(25,9)=1-params(4);
g1(25,25)=(-1);
g1(25,34)=(-((1-params(4))*(-params(2))));
g1(26,1)=1;
g1(26,2)=(-(params(55)/params(54)));
g1(26,3)=(-(params(53)/params(54)));
g1(26,11)=(-(params(48)*params(51)/params(54)));
g1(26,18)=(-(params(24)*1/(1-params(12))));
g1(26,20)=(-params(24));
g1(27,18)=(-(params(24)*1/(1-params(12))));
g1(27,20)=(-params(24));
g1(27,34)=1;
g1(27,35)=(-(params(55)/params(54)));
g1(27,36)=(-(params(53)/params(54)));
g1(27,42)=(-(params(48)*params(51)/params(54)));
g1(28,17)=1;
g1(28,18)=(-(1/(1-params(12))*(params(30)-1)));
g1(29,18)=1-params(30);
g1(30,20)=1-params(35);
g1(31,19)=1-params(31);
g1(32,24)=1-params(34);
g1(33,21)=1-params(32);
g1(34,22)=1-params(33);
g1(35,25)=1-params(40);
g1(36,23)=1-params(39);
g1(37,1)=(-1);
g1(37,34)=1;
g1(37,45)=1;
g1(38,40)=(-1);
g1(38,46)=0.25;
g1(39,8)=1;
g1(39,9)=(-1);
g1(39,47)=0.25;
g1(40,17)=(-1);
g1(40,26)=1;
g1(41,17)=(-1);
g1(41,31)=1;
g1(42,17)=(-1);
g1(42,32)=1;
g1(43,17)=(-1);
g1(43,28)=1;
g1(44,9)=(-1);
g1(44,30)=1;
g1(45,8)=(-1);
g1(45,29)=1;
g1(46,9)=1;
g1(46,15)=(-1);
g1(46,33)=1;
g1(47,6)=(-1);
g1(47,27)=1;
g1(48,48)=1;
g1(49,49)=1;
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
