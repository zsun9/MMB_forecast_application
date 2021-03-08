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
    T = VI16_BGG.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(43, 83);
g1(1,43)=(-(1-params(2)));
g1(1,46)=(-params(2));
g1(1,62)=1;
g1(2,35)=1;
g1(2,46)=(-T(15));
g1(3,35)=1;
g1(3,3)=1;
g1(3,42)=(-1);
g1(3,43)=(-1);
g1(3,46)=1;
g1(4,38)=T(23);
g1(4,6)=(-T(16));
g1(4,40)=1;
g1(4,71)=(-(T(10)*T(16)));
g1(4,64)=T(23);
g1(5,36)=1;
g1(5,4)=1;
g1(5,38)=T(24);
g1(5,46)=(-(T(4)/T(2)));
g1(5,68)=T(24);
g1(6,37)=(-params(12));
g1(6,38)=(-params(12));
g1(6,45)=1;
g1(6,47)=params(12);
g1(7,69)=1;
g1(7,44)=(-1);
g1(7,45)=(-1);
g1(8,36)=(-T(17));
g1(8,3)=params(12)*(T(17)-1);
g1(8,4)=params(12)*(T(17)-1);
g1(8,8)=T(17)-1;
g1(8,9)=(-(1+params(12)*(T(17)-1)));
g1(8,47)=1/(T(2)*params(1));
g1(9,5)=(-T(18));
g1(9,39)=T(18)+T(19);
g1(9,70)=(-T(19));
g1(9,44)=1;
g1(10,35)=(-(T(4)*T(13)));
g1(10,39)=(-T(12));
g1(10,40)=(-T(9));
g1(10,41)=1;
g1(10,63)=(-params(6));
g1(11,35)=(-(params(2)*params(40)));
g1(11,3)=(-(params(2)*params(40)));
g1(11,41)=1;
g1(11,42)=(-((1-params(2))*params(40)));
g1(11,62)=(-params(40));
g1(11,68)=(-(params(2)*params(40)));
g1(12,5)=T(18);
g1(12,39)=(-T(19));
g1(12,42)=(-params(41));
g1(12,43)=1;
g1(13,3)=(-(1-params(4)));
g1(13,37)=1;
g1(13,40)=(-T(8));
g1(13,64)=(-T(8));
g1(13,68)=(-(1-params(4)));
g1(14,49)=(-T(15));
g1(14,51)=1;
g1(15,49)=1;
g1(15,51)=1;
g1(15,11)=1;
g1(15,58)=(-1);
g1(15,60)=(-1);
g1(16,54)=T(23);
g1(16,14)=(-T(16));
g1(16,56)=1;
g1(16,74)=(-(T(10)*T(16)));
g1(16,64)=T(23);
g1(17,49)=(-(T(4)/T(2)));
g1(17,52)=1;
g1(17,12)=1;
g1(17,54)=T(24);
g1(17,68)=T(24);
g1(18,48)=1;
g1(18,50)=params(12);
g1(18,53)=(-params(12));
g1(18,54)=(-params(12));
g1(19,48)=(-1);
g1(19,72)=1;
g1(19,75)=1;
g1(19,61)=(-1);
g1(20,10)=(-(1+params(12)*(T(17)-1)));
g1(20,50)=1/(T(2)*params(1));
g1(20,52)=(-T(17));
g1(20,11)=params(12)*(T(17)-1);
g1(20,12)=params(12)*(T(17)-1);
g1(20,18)=T(17)-1;
g1(21,13)=(-T(18));
g1(21,55)=T(18)+T(19);
g1(21,73)=(-T(19));
g1(21,61)=1;
g1(22,51)=(-(T(4)*T(13)));
g1(22,55)=(-T(12));
g1(22,56)=(-T(9));
g1(22,57)=1;
g1(22,63)=(-params(6));
g1(23,51)=(-(params(2)*params(40)));
g1(23,11)=(-(params(2)*params(40)));
g1(23,57)=1;
g1(23,58)=(-((1-params(2))*params(40)));
g1(23,62)=(-params(40));
g1(23,68)=(-(params(2)*params(40)));
g1(24,49)=(-(T(20)*params(2)*T(21)));
g1(24,16)=(-(params(23)*T(20)));
g1(24,59)=1;
g1(24,75)=(-(T(10)*T(20)));
g1(24,60)=(-(T(20)*(1-params(2))*T(21)));
g1(24,62)=(-(T(20)*(-T(21))));
g1(24,66)=(-1);
g1(25,13)=(-(T(22)*(-T(18))));
g1(25,55)=(-(T(19)*T(22)));
g1(25,58)=(-(params(41)*T(22)));
g1(25,16)=(-(params(22)/(1+T(10))));
g1(25,59)=(1+T(10)*params(22))/(1+T(10));
g1(25,75)=(-(T(10)/(1+T(10))));
g1(25,17)=(-T(16));
g1(25,60)=1+T(22);
g1(25,76)=(-(T(10)/(1+T(10))));
g1(25,67)=(-1);
g1(26,7)=(-params(26));
g1(26,41)=(-((-((1-params(28))*params(27)))-params(26)));
g1(26,15)=params(26);
g1(26,57)=(-((1-params(28))*params(27)+params(26)));
g1(26,16)=params(29);
g1(26,59)=(-((1-params(28))*params(25)+params(29)));
g1(26,18)=(-params(28));
g1(26,61)=1;
g1(26,65)=(-1);
g1(27,11)=(-(1-params(4)));
g1(27,53)=1;
g1(27,56)=(-T(8));
g1(27,64)=(-(T(8)*params(17)));
g1(27,68)=(-(1-params(4)));
g1(28,19)=(-params(30));
g1(28,62)=1;
g1(28,77)=1;
g1(29,20)=(-params(32));
g1(29,63)=1;
g1(29,77)=params(16);
g1(29,78)=1;
g1(30,21)=(-params(33));
g1(30,64)=1;
g1(30,79)=1;
g1(31,22)=(-params(34));
g1(31,65)=1;
g1(31,80)=(-1);
g1(32,2)=params(38);
g1(32,34)=(-1);
g1(32,23)=(-params(35));
g1(32,66)=1;
g1(33,34)=1;
g1(33,81)=(-1);
g1(34,1)=params(37);
g1(34,33)=(-1);
g1(34,24)=(-params(36));
g1(34,67)=1;
g1(35,33)=1;
g1(35,82)=(-1);
g1(36,25)=(-params(31));
g1(36,68)=1;
g1(36,83)=(-1);
g1(37,29)=1;
g1(37,15)=1;
g1(37,57)=(-1);
g1(38,30)=1;
g1(38,13)=1;
g1(38,55)=(-1);
g1(39,31)=1;
g1(39,14)=1;
g1(39,56)=(-1);
g1(40,32)=1;
g1(40,17)=1;
g1(40,60)=(-1);
g1(41,28)=1;
g1(41,59)=(-1);
g1(42,27)=1;
g1(42,61)=(-1);
g1(43,26)=1;
g1(43,58)=(-1);

end
