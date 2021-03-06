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
    T = DS04.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(13, 25);
g1(1,2)=(-25);
g1(1,9)=(-25);
g1(1,15)=1;
g1(1,6)=(-25);
g1(1,7)=(-25);
g1(2,8)=(-100);
g1(2,17)=1;
g1(3,13)=1;
g1(3,14)=(-4);
g1(4,1)=100;
g1(4,8)=(-100);
g1(4,12)=(-100);
g1(4,18)=1;
g1(5,9)=(-100);
g1(5,16)=1;
g1(6,10)=(-100);
g1(6,14)=1;
g1(7,8)=1;
g1(7,21)=(-1);
g1(7,22)=(-T(2));
g1(7,10)=T(2);
g1(7,11)=(-(1-params(6)));
g1(7,12)=(-(T(2)*params(7)));
g1(8,8)=(-params(2));
g1(8,9)=1;
g1(8,22)=(-T(1));
g1(8,11)=params(2);
g1(9,8)=(-((1-params(5))*params(4)));
g1(9,9)=(-((1-params(5))*params(3)));
g1(9,3)=(-params(5));
g1(9,10)=1;
g1(9,23)=(-1);
g1(10,5)=(-params(7));
g1(10,12)=1;
g1(10,25)=(-1);
g1(11,4)=(-params(6));
g1(11,11)=1;
g1(11,24)=(-1);
g1(12,2)=(-1);
g1(12,19)=1;
g1(13,6)=(-1);
g1(13,20)=1;

end
