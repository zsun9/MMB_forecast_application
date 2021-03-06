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
    T = WW11.static_g1_tt(T, y, x, params);
end
g1 = zeros(16, 16);
g1(1,7)=(-100);
g1(1,15)=1;
g1(2,4)=(-100);
g1(2,14)=1;
g1(3,5)=(-100);
g1(3,13)=1;
g1(4,4)=(-T(2));
g1(4,5)=T(2);
g1(4,9)=(-T(2));
g1(5,4)=(-1);
g1(5,7)=(-1);
g1(5,8)=1;
g1(6,4)=1;
g1(6,8)=(-1);
g1(6,9)=1;
g1(7,4)=1-T(1);
g1(7,12)=(-params(12));
g1(8,10)=(-T(2));
g1(8,12)=1;
g1(8,16)=(-1);
g1(9,2)=1;
g1(9,6)=(-1);
g1(9,11)=(-T(2));
g1(10,4)=(-((1-params(7))*params(5)));
g1(10,5)=1-params(7);
g1(10,16)=(-((1-params(7))*params(6)));
g1(11,1)=(-1);
g1(11,3)=1;
g1(11,6)=1;
g1(12,1)=(-1);
g1(12,2)=1;
g1(12,16)=1;
g1(13,7)=1-params(9);
g1(14,6)=1-params(8);
g1(15,11)=1-params(10);
g1(16,10)=1-params(11);
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
