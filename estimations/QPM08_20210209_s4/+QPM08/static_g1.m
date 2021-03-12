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
    T = QPM08.static_g1_tt(T, y, x, params);
end
g1 = zeros(49, 49);
g1(1,4)=1-params(3);
g1(1,8)=(-params(4));
g1(2,3)=1;
g1(2,4)=1;
g1(2,5)=(-1);
g1(3,17)=(-1);
g1(4,17)=1-(1-params(16));
g1(5,8)=(-1);
g1(5,9)=1;
g1(5,10)=(-1);
g1(6,12)=1-(1-params(5));
g1(7,12)=(-0.25);
g1(8,1)=params(9);
g1(8,2)=(-params(9));
g1(8,8)=1-(params(7)+params(8));
g1(8,23)=params(18);
g1(9,23)=1;
g1(10,8)=params(17);
g1(10,21)=1;
g1(10,22)=(-1);
g1(12,21)=(-1);
g1(12,22)=1;
g1(12,27)=1;
g1(13,18)=1;
g1(14,19)=1;
g1(15,25)=1;
g1(16,20)=1;
g1(17,6)=1;
g1(17,7)=(-1);
g1(17,8)=(-params(11));
g1(18,2)=(-(1-params(12)));
g1(18,7)=(-((1-params(12))*(1+params(13))));
g1(18,8)=(-((1-params(12))*params(14)));
g1(18,11)=4-4*params(12);
g1(19,1)=1;
g1(19,6)=1;
g1(19,11)=(-4);
g1(20,6)=(-0.25);
g1(21,2)=1-(1-params(1));
g1(22,6)=(-1);
g1(22,7)=1;
g1(23,1)=(-1);
g1(23,2)=1;
g1(23,26)=1;
g1(24,7)=(-1);
g1(24,14)=1;
g1(25,6)=(-1);
g1(25,16)=1;
g1(26,8)=(-1);
g1(26,15)=1;
g1(27,23)=(-params(18));
g1(27,24)=1;
g1(28,8)=(-1);
g1(28,28)=1;
g1(29,8)=(-1);
g1(29,29)=1;
g1(30,8)=(-1);
g1(30,30)=1;
g1(31,7)=(-1);
g1(31,31)=1;
g1(32,7)=(-1);
g1(32,32)=1;
g1(33,7)=(-1);
g1(33,33)=1;
g1(34,23)=(-1);
g1(34,34)=1;
g1(35,23)=(-1);
g1(35,35)=1;
g1(36,23)=(-1);
g1(36,36)=1;
g1(37,23)=(-1);
g1(37,37)=1;
g1(38,23)=(-1);
g1(38,38)=1;
g1(39,23)=(-1);
g1(39,39)=1;
g1(40,23)=(-1);
g1(40,40)=1;
g1(41,23)=(-1);
g1(41,41)=1;
g1(42,9)=(-1);
g1(42,42)=1;
g1(43,9)=(-1);
g1(43,43)=1;
g1(44,9)=(-1);
g1(44,44)=1;
g1(45,10)=(-1);
g1(45,45)=1;
g1(46,10)=(-1);
g1(46,46)=1;
g1(47,10)=(-1);
g1(47,47)=1;
g1(48,6)=(-1);
g1(48,48)=1;
g1(49,6)=(-1);
g1(49,49)=1;
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
