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
    T = HLaEst2015BEP.static_g1_tt(T, y, x, params);
end
g1 = zeros(48, 48);
g1(1,1)=(-(params(1)*T(5)*(-((1-params(2))*params(5)*params(10)/(1-params(2))))+params(10)*T(5)));
g1(1,3)=(-(params(5)*(T(2)-params(1))*(1-params(7))*params(6)*T(5)));
g1(1,5)=1;
g1(1,6)=(-((T(2)-params(1))*(1-params(7))*params(6)*T(5)+params(1)*T(5)-T(5)));
g1(1,7)=(-((params(5)-1)*params(1)*T(5)+(params(5)-1)*(T(2)-params(1))*(1-params(7))*params(6)*T(5)));
g1(1,8)=(-(params(5)*(T(2)-params(1))*(1-params(7))*params(6)*T(5)));
g1(1,11)=(-(params(5)*(T(2)-params(1))*(1-params(7))*params(6)*T(5)));
g1(2,3)=(-T(2));
g1(2,4)=1;
g1(2,5)=(-(params(5)*T(7)));
g1(2,6)=(-T(7));
g1(2,7)=(-((params(5)-1)*T(7)));
g1(2,9)=1;
g1(2,10)=(-(params(7)/params(4)));
g1(2,11)=(-T(2));
g1(2,13)=(-(params(7)/params(4)));
g1(3,1)=(-(params(1)*params(10)-T(2)*params(10)));
g1(3,3)=(-params(1));
g1(3,4)=T(2);
g1(3,8)=T(2)-params(1);
g1(4,1)=(-params(10));
g1(4,3)=(T(2)-params(1))*params(6)*params(7);
g1(4,8)=(T(2)-params(1))*params(6)*params(7);
g1(4,10)=1+(T(2)-params(1))*params(6)*params(7);
g1(4,11)=(T(2)-params(1))*params(6)*params(7);
g1(4,13)=(-(params(8)*(1+(T(2)-params(1))*params(6)*params(7))));
g1(5,2)=(-T(10));
g1(5,3)=T(10);
g1(5,14)=1;
g1(5,15)=(-((1-params(2))*T(8)-params(9)*T(10)));
g1(6,6)=(-(params(11)*T(5)-T(5)));
g1(6,7)=(-((params(5)-1)*params(11)*T(5)));
g1(6,15)=(-(params(11)*T(5)*(-((1-params(2))*params(5)*params(9)/(1-params(2))))+T(5)*params(9)));
g1(6,16)=1;
g1(7,10)=1;
g1(7,12)=(-params(8));
g1(7,15)=(-params(9));
g1(8,2)=(-(0.789*params(3)));
g1(8,3)=0.789*params(3);
g1(8,7)=(-(T(1)*(params(5)-1)));
g1(8,10)=(-T(11));
g1(8,12)=(-T(11));
g1(8,14)=0.789-0.789*params(3);
g1(8,15)=1;
g1(8,16)=T(1)-(T(1)+T(1)*(params(5)-1));
g1(9,3)=1-(params(11)/(1+params(11)*params(14))+params(14)/(1+params(11)*params(14)));
g1(9,17)=T(12);
g1(9,39)=(-1);
g1(10,10)=1;
g1(10,17)=1;
g1(10,18)=(-1);
g1(10,20)=1;
g1(11,3)=(-params(19));
g1(11,23)=T(3);
g1(11,25)=T(3)-params(19);
g1(12,17)=T(13);
g1(12,18)=(-T(13));
g1(12,19)=(-1)-((-params(19))-T(13));
g1(12,22)=T(15);
g1(12,24)=T(15);
g1(12,25)=T(15);
g1(12,26)=1-params(19);
g1(13,19)=params(21);
g1(13,22)=1;
g1(13,26)=(-params(21));
g1(14,3)=(-T(3));
g1(14,6)=(-((1-params(17))/params(18)));
g1(14,19)=(-(params(17)/params(18)));
g1(14,21)=1;
g1(14,22)=(-(params(17)/params(18)));
g1(14,23)=1;
g1(14,24)=(-T(3));
g1(15,18)=1;
g1(15,19)=(-params(15));
g1(15,20)=(-(1-params(15)));
g1(15,33)=(-1);
g1(16,19)=1-(1-params(20));
g1(16,26)=(-params(20));
g1(17,3)=1-(1-params(23))*params(34);
g1(17,27)=1-(1-params(23));
g1(17,28)=(-params(23));
g1(18,2)=(-1);
g1(18,27)=T(14);
g1(18,29)=1;
g1(18,30)=(-T(14));
g1(19,23)=1-(params(26)/(params(26)+params(27)-1+params(26)*params(28))+params(26)*params(28)/(params(26)+params(27)-1+params(26)*params(28)));
g1(19,29)=(-((params(27)-1)/(params(26)+params(27)-1+params(26)*params(28))));
g1(19,36)=1/(params(26)+params(27)-1+params(26)*params(28));
g1(20,4)=1-(params(29)/(params(29)+params(30)-1+params(28)*params(29))+params(28)*params(29)/(params(29)+params(30)-1+params(28)*params(29)));
g1(20,29)=(-((params(30)-1)/(params(29)+params(30)-1+params(28)*params(29))));
g1(20,37)=1/(params(29)+params(30)-1+params(28)*params(29));
g1(21,2)=(1-params(25))*(params(3)-1);
g1(21,4)=(-((params(4)-1)*params(31)));
g1(21,9)=(-((params(4)-1)*params(31)));
g1(21,14)=(1-params(25))*(params(3)-1);
g1(21,21)=(-((params(18)-1)*params(32)));
g1(21,23)=(-((params(18)-1)*params(32)));
g1(21,28)=(params(18)-1)*params(32)+(params(4)-1)*params(31)-(1-params(25))*(params(3)-1);
g1(22,2)=1-params(36);
g1(22,3)=(-(params(37)*(1-params(36))));
g1(22,35)=(-1);
g1(23,1)=(-(params(39)*(1-params(22))));
g1(23,3)=params(23)*params(40);
g1(23,15)=(-(params(39)*params(22)));
g1(23,18)=1;
g1(23,26)=(-T(4));
g1(23,27)=(-(params(23)*params(40)));
g1(24,1)=(-(1-params(22)));
g1(24,15)=(-params(22));
g1(24,32)=1;
g1(25,12)=(-params(22));
g1(25,13)=(-(1-params(22)));
g1(25,20)=1;
g1(26,1)=(-((1-params(22))*(params(10)+params(1)*(-((1-params(2))*params(5)*params(10)/(1-params(2)))))));
g1(26,3)=(-((1-params(22))*params(5)*(T(2)-params(1))*params(6)*(1-params(7))));
g1(26,6)=1-((1-params(22))*(params(1)+(T(2)-params(1))*params(6)*(1-params(7)))+params(11)*params(22));
g1(26,7)=(-((1-params(22))*(params(1)*(params(5)-1)+(params(5)-1)*(T(2)-params(1))*params(6)*(1-params(7)))+params(22)*params(11)*(params(5)-1)));
g1(26,8)=(-((1-params(22))*params(5)*(T(2)-params(1))*params(6)*(1-params(7))));
g1(26,11)=(-((1-params(22))*params(5)*(T(2)-params(1))*params(6)*(1-params(7))));
g1(26,15)=(-(params(22)*(params(9)+params(11)*(-((1-params(2))*params(5)*params(9)/(1-params(2)))))));
g1(26,38)=1;
g1(27,6)=(-((params(5)-1)*params(35)));
g1(27,7)=1;
g1(27,28)=(-(1-params(35)));
g1(28,9)=(-params(31));
g1(28,21)=(-params(32));
g1(28,30)=1;
g1(29,14)=(-(1-params(25)));
g1(29,27)=(-params(25));
g1(29,30)=1;
g1(29,34)=1-params(25);
g1(30,33)=1-params(43);
g1(31,34)=1-params(44);
g1(32,35)=1-params(45);
g1(33,36)=1-params(46);
g1(34,37)=1-params(47);
g1(35,11)=1-params(48);
g1(36,24)=1-params(49);
g1(37,38)=1-params(50);
g1(38,39)=1-params(51);
g1(39,27)=(-1);
g1(39,30)=1;
g1(39,31)=1;
g1(40,3)=(-1);
g1(40,40)=1;
g1(41,41)=1;
g1(42,42)=1;
g1(43,43)=1;
g1(44,44)=1;
g1(45,45)=1;
g1(46,4)=(-1);
g1(46,47)=1;
g1(47,23)=(-1);
g1(47,48)=1;
g1(48,2)=(-1);
g1(48,46)=1;
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
