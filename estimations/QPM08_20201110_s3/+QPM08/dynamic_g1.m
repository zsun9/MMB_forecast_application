function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = QPM08.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(49, 100);
g1(1,3)=(-params(3));
g1(1,35)=1;
g1(1,39)=(-params(4));
g1(1,91)=(-1);
g1(2,34)=1;
g1(2,35)=1;
g1(2,36)=(-1);
g1(3,4)=(-1);
g1(3,36)=1;
g1(3,48)=(-1);
g1(3,92)=(-1);
g1(4,13)=(-(1-params(16)));
g1(4,48)=1;
g1(4,98)=(-1);
g1(5,39)=(-1);
g1(5,40)=1;
g1(5,41)=(-1);
g1(6,11)=(-(1-params(5)));
g1(6,43)=1;
g1(6,94)=(-1);
g1(7,9)=(-1);
g1(7,41)=1;
g1(7,43)=(-0.25);
g1(7,96)=(-1);
g1(8,1)=params(9);
g1(8,2)=(-params(9));
g1(8,7)=(-params(7));
g1(8,39)=1;
g1(8,83)=(-params(8));
g1(8,15)=params(18)*0.04;
g1(8,95)=(-1);
g1(8,16)=params(18)*0.08;
g1(8,17)=params(18)*0.12;
g1(8,18)=params(18)*0.16;
g1(8,19)=params(18)*0.2;
g1(8,20)=params(18)*0.16;
g1(8,21)=params(18)*0.12;
g1(8,22)=params(18)*0.08;
g1(8,23)=params(18)*0.04;
g1(9,54)=1;
g1(9,99)=(-1);
g1(10,52)=1;
g1(10,53)=(-1);
g1(10,99)=(-1);
g1(10,86)=params(17);
g1(11,14)=(-1);
g1(11,53)=1;
g1(11,100)=(-1);
g1(12,52)=(-1);
g1(12,53)=1;
g1(12,58)=1;
g1(13,8)=4;
g1(13,40)=(-4);
g1(13,49)=1;
g1(14,40)=(-1);
g1(14,50)=1;
g1(14,26)=1;
g1(15,9)=4;
g1(15,41)=(-4);
g1(15,56)=1;
g1(16,41)=(-1);
g1(16,51)=1;
g1(16,29)=1;
g1(17,37)=1;
g1(17,6)=(-(1-params(10)));
g1(17,7)=(-params(11));
g1(17,97)=1;
g1(17,89)=(-params(10));
g1(18,33)=(-(1-params(12)));
g1(18,39)=(-((1-params(12))*params(14)));
g1(18,10)=(-(4*params(12)));
g1(18,42)=4;
g1(18,93)=(-1);
g1(18,88)=(-((1-params(12))*(1+params(13))));
g1(19,32)=1;
g1(19,81)=1;
g1(19,42)=(-4);
g1(20,37)=(-0.25);
g1(20,12)=(-1);
g1(20,44)=1;
g1(21,2)=(-(1-params(1)));
g1(21,33)=1;
g1(21,90)=(-1);
g1(22,5)=(-0.25);
g1(22,37)=(-0.25);
g1(22,38)=1;
g1(22,30)=(-0.25);
g1(22,31)=(-0.25);
g1(23,32)=(-1);
g1(23,33)=1;
g1(23,57)=1;
g1(24,45)=1;
g1(24,89)=(-1);
g1(25,81)=(-1);
g1(25,47)=1;
g1(26,83)=(-1);
g1(26,46)=1;
g1(27,15)=(-(params(18)*0.04));
g1(27,55)=1;
g1(27,16)=(-(params(18)*0.08));
g1(27,17)=(-(params(18)*0.12));
g1(27,18)=(-(params(18)*0.16));
g1(27,19)=(-(params(18)*0.2));
g1(27,20)=(-(params(18)*0.16));
g1(27,21)=(-(params(18)*0.12));
g1(27,22)=(-(params(18)*0.08));
g1(27,23)=(-(params(18)*0.04));
g1(28,83)=(-1);
g1(28,59)=1;
g1(29,84)=(-1);
g1(29,60)=1;
g1(30,85)=(-1);
g1(30,61)=1;
g1(31,82)=(-1);
g1(31,62)=1;
g1(32,87)=(-1);
g1(32,63)=1;
g1(33,88)=(-1);
g1(33,64)=1;
g1(34,15)=(-1);
g1(34,65)=1;
g1(35,16)=(-1);
g1(35,66)=1;
g1(36,17)=(-1);
g1(36,67)=1;
g1(37,18)=(-1);
g1(37,68)=1;
g1(38,19)=(-1);
g1(38,69)=1;
g1(39,20)=(-1);
g1(39,70)=1;
g1(40,21)=(-1);
g1(40,71)=1;
g1(41,22)=(-1);
g1(41,72)=1;
g1(42,8)=(-1);
g1(42,73)=1;
g1(43,24)=(-1);
g1(43,74)=1;
g1(44,25)=(-1);
g1(44,75)=1;
g1(45,9)=(-1);
g1(45,76)=1;
g1(46,27)=(-1);
g1(46,77)=1;
g1(47,28)=(-1);
g1(47,78)=1;
g1(48,5)=(-1);
g1(48,79)=1;
g1(49,30)=(-1);
g1(49,80)=1;

end
