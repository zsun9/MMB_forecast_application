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
    T = FU20.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(40, 79);
g1(1,63)=(-T(3));
g1(1,3)=(-(T(1)/(1+T(1))));
g1(1,32)=1;
g1(1,64)=(-(1/(1+T(1))));
g1(1,33)=T(3);
g1(1,34)=(-T(2));
g1(1,65)=T(2);
g1(1,55)=(-1);
g1(2,6)=(-T(4));
g1(2,38)=1;
g1(2,66)=(-(params(2)*params(6)*T(4)));
g1(2,39)=(-(T(4)*1/T(5)));
g1(2,56)=(-1);
g1(3,62)=(-(params(8)/(1+params(8)-params(9))));
g1(3,63)=(-1);
g1(3,33)=1;
g1(3,39)=1;
g1(3,67)=(-T(6));
g1(3,55)=(-(1/T(3)));
g1(4,30)=(-T(7));
g1(4,36)=1;
g1(5,35)=1;
g1(5,36)=(-1);
g1(5,5)=(-1);
g1(6,5)=(-(1-params(47)));
g1(6,37)=1;
g1(6,38)=(-params(47));
g1(6,56)=(-(T(5)*params(47)));
g1(7,34)=(-(params(11)*(1-params(12))));
g1(7,35)=(-(params(11)*params(12)));
g1(7,40)=1;
g1(7,52)=(-params(11));
g1(8,29)=(-1);
g1(8,30)=1;
g1(8,34)=(-1);
g1(8,35)=1;
g1(9,28)=1;
g1(9,29)=(-(1-params(12)));
g1(9,30)=(-params(12));
g1(9,52)=1;
g1(10,28)=(-T(8));
g1(10,2)=(-(params(14)/(1+params(2)*params(6)*params(14))));
g1(10,31)=1;
g1(10,63)=(-(params(2)*params(6)/(1+params(2)*params(6)*params(14))));
g1(10,53)=(-1);
g1(11,1)=(-T(4));
g1(11,29)=1-T(4)*(-T(9));
g1(11,61)=(-(params(2)*params(6)*T(4)));
g1(11,2)=(-(T(4)*params(18)));
g1(11,31)=(-(T(4)*(-(1+params(2)*params(6)*params(18)))));
g1(11,63)=(-(params(2)*params(6)*T(4)));
g1(11,3)=(-(T(4)*T(9)*(-T(11))));
g1(11,32)=(-(T(4)*T(9)*T(10)));
g1(11,34)=(-(T(4)*T(9)*params(17)));
g1(11,54)=(-1);
g1(12,31)=(-((1-params(20))*params(21)));
g1(12,4)=(-params(20));
g1(12,33)=1;
g1(12,7)=params(23);
g1(12,40)=(-(params(23)+(1-params(20))*params(22)));
g1(12,11)=(-params(23));
g1(12,50)=(-((1-params(20))*(-params(22))-params(23)));
g1(12,58)=(-1);
g1(13,32)=(-params(24));
g1(13,36)=(-(params(8)*params(25)));
g1(13,38)=(-params(10));
g1(13,40)=1;
g1(13,57)=(-1);
g1(14,8)=(-(T(1)/(1+T(1))));
g1(14,43)=1;
g1(14,69)=(-(1/(1+T(1))));
g1(14,44)=T(3);
g1(14,45)=(-T(2));
g1(14,70)=T(2);
g1(14,55)=(-1);
g1(15,10)=(-T(4));
g1(15,49)=1;
g1(15,71)=(-(params(2)*params(6)*T(4)));
g1(15,51)=(-(T(4)*1/T(5)));
g1(15,56)=(-1);
g1(16,68)=(-(params(8)/(1+params(8)-params(9))));
g1(16,44)=1;
g1(16,51)=1;
g1(16,72)=(-T(6));
g1(16,55)=(-(1/T(3)));
g1(17,42)=(-T(7));
g1(17,47)=1;
g1(18,46)=1;
g1(18,47)=(-1);
g1(18,9)=(-1);
g1(19,9)=(-(1-T(12)));
g1(19,48)=1;
g1(19,49)=(-T(12));
g1(19,56)=(-(T(5)*T(12)));
g1(20,45)=(-(params(11)*(1-params(12))));
g1(20,46)=(-(params(11)*params(12)));
g1(20,50)=1;
g1(20,52)=(-params(11));
g1(21,41)=(-1);
g1(21,42)=1;
g1(21,45)=(-1);
g1(21,46)=1;
g1(22,41)=(-(1-params(12)));
g1(22,42)=(-params(12));
g1(22,52)=1;
g1(23,41)=1;
g1(23,8)=T(11);
g1(23,43)=(-T(10));
g1(23,45)=(-params(17));
g1(24,43)=(-params(24));
g1(24,47)=(-(params(8)*params(25)));
g1(24,49)=(-params(10));
g1(24,50)=1;
g1(24,57)=(-1);
g1(25,12)=(-params(34));
g1(25,52)=1;
g1(25,73)=(-1);
g1(26,15)=(-params(35));
g1(26,55)=1;
g1(26,76)=(-1);
g1(27,17)=(-params(36));
g1(27,57)=1;
g1(27,73)=(-params(37));
g1(27,78)=(-1);
g1(28,16)=(-params(38));
g1(28,56)=1;
g1(28,77)=(-1);
g1(29,13)=(-params(39));
g1(29,53)=1;
g1(29,74)=(-1);
g1(29,19)=params(40);
g1(30,14)=(-params(41));
g1(30,54)=1;
g1(30,75)=(-1);
g1(30,20)=params(42);
g1(31,18)=(-params(43));
g1(31,58)=1;
g1(31,79)=(-1);
g1(32,24)=1;
g1(32,7)=1;
g1(32,40)=(-1);
g1(33,25)=1;
g1(33,3)=1;
g1(33,32)=(-1);
g1(34,26)=1;
g1(34,6)=1;
g1(34,38)=(-1);
g1(35,27)=1;
g1(35,1)=1;
g1(35,29)=(-1);
g1(36,23)=1;
g1(36,31)=(-1);
g1(37,22)=1;
g1(37,33)=(-1);
g1(38,21)=1;
g1(38,34)=(-1);
g1(39,74)=(-1);
g1(39,59)=1;
g1(40,75)=(-1);
g1(40,60)=1;

end
