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
    T = NKBGG.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(34, 61);
g1(1,16)=(-T(26));
g1(1,25)=1;
g1(1,27)=(-T(27));
g1(1,29)=(-T(28));
g1(1,30)=(-params(3));
g1(2,16)=1;
g1(2,50)=(-1);
g1(2,19)=1;
g1(3,23)=(-1);
g1(3,29)=1;
g1(4,19)=(-1);
g1(4,21)=(-params(22));
g1(4,22)=(-params(22));
g1(4,23)=params(22);
g1(4,52)=1;
g1(4,33)=(-T(29));
g1(5,4)=1;
g1(5,21)=(-T(30));
g1(5,5)=1-T(30);
g1(5,24)=1;
g1(5,25)=(-(1-T(30)));
g1(5,26)=1-T(30);
g1(6,21)=(-T(38));
g1(6,7)=(-(1/(1+T(2))));
g1(6,27)=1;
g1(6,53)=(-(T(2)/(1+T(2))));
g1(6,32)=(-T(38));
g1(7,17)=(-((1-params(5))*params(4)));
g1(7,5)=(-params(5));
g1(7,25)=1;
g1(7,28)=(-(1-params(5)));
g1(8,16)=(-1);
g1(8,17)=(-1)-T(39);
g1(8,25)=1;
g1(8,26)=(-1);
g1(9,1)=(-(params(24)/(1+T(2)*params(24))));
g1(9,18)=1;
g1(9,51)=(-(T(2)/(1+T(2)*params(24))));
g1(9,26)=1/(1+T(2)*params(24))*T(31);
g1(10,5)=(-T(40));
g1(10,22)=1;
g1(10,27)=(-(1-T(40)));
g1(10,32)=(-(1-T(40)));
g1(11,2)=T(33);
g1(11,4)=(-T(34));
g1(11,5)=(-T(34));
g1(11,23)=1;
g1(11,24)=(-T(32));
g1(11,25)=(-T(41));
g1(11,26)=T(41);
g1(11,11)=T(36);
g1(12,18)=(-((1-params(13))*params(11)));
g1(12,3)=(-params(13));
g1(12,20)=1;
g1(12,25)=(-((1-params(13))*params(12)));
g1(12,34)=(1-params(13))*params(12);
g1(12,59)=(-1);
g1(13,51)=(-1);
g1(13,19)=(-1);
g1(13,20)=1;
g1(14,19)=1;
g1(14,52)=(-1);
g1(14,31)=1;
g1(15,8)=(-params(14));
g1(15,28)=1;
g1(15,57)=(-1);
g1(16,9)=(-params(15));
g1(16,30)=1;
g1(16,58)=(-1);
g1(17,10)=(-params(16));
g1(17,32)=1;
g1(17,60)=(-1);
g1(18,11)=(-params(17));
g1(18,33)=1;
g1(18,61)=(-1);
g1(19,30)=(-params(3));
g1(19,34)=1;
g1(19,36)=(-T(27));
g1(19,40)=(-T(26));
g1(19,43)=(-T(28));
g1(20,37)=1;
g1(20,40)=1;
g1(20,56)=(-1);
g1(21,39)=(-1);
g1(21,43)=1;
g1(22,37)=(-1);
g1(22,55)=1;
g1(23,34)=(-(1-T(30)));
g1(23,12)=1-T(30);
g1(23,38)=1;
g1(23,15)=1;
g1(23,41)=(-T(30));
g1(24,32)=(-T(38));
g1(24,13)=(-(1/(1+T(2))));
g1(24,36)=1;
g1(24,54)=(-(T(2)/(1+T(2))));
g1(24,41)=(-T(38));
g1(25,28)=(-(1-params(5)));
g1(25,34)=1;
g1(25,12)=(-params(5));
g1(25,42)=(-((1-params(5))*params(4)));
g1(26,34)=1;
g1(26,40)=(-1);
g1(26,42)=(-1)-T(39);
g1(27,32)=(-(1-T(40)));
g1(27,12)=(-T(40));
g1(27,35)=1;
g1(27,36)=(-(1-T(40)));
g1(28,11)=T(36);
g1(28,34)=(-T(41));
g1(28,12)=(-T(34));
g1(28,14)=T(33);
g1(28,38)=(-T(32));
g1(28,39)=1;
g1(28,15)=(-T(34));
g1(29,25)=(-1);
g1(29,34)=1;
g1(29,49)=1;
g1(30,6)=1;
g1(30,25)=(-1);
g1(30,44)=1;
g1(31,7)=1;
g1(31,27)=(-1);
g1(31,47)=1;
g1(32,18)=(-1);
g1(32,45)=1;
g1(33,20)=(-1);
g1(33,46)=1;
g1(34,31)=(-1);
g1(34,48)=1;

end
