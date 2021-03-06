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
    T = WW11.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(16, 33);
g1(1,1)=100;
g1(1,7)=(-100);
g1(1,13)=(-100);
g1(1,21)=1;
g1(2,10)=(-100);
g1(2,20)=1;
g1(3,11)=(-100);
g1(3,19)=1;
g1(4,24)=(-T(2));
g1(4,11)=T(2);
g1(4,15)=(-T(2));
g1(4,22)=1;
g1(4,28)=(-1);
g1(5,8)=params(1);
g1(5,23)=(-params(1));
g1(5,24)=(-1);
g1(5,12)=(-params(1));
g1(5,25)=params(1);
g1(5,26)=(-1);
g1(5,14)=1;
g1(5,17)=(-1);
g1(5,27)=1;
g1(6,24)=1;
g1(6,14)=(-1);
g1(6,15)=1;
g1(7,10)=1;
g1(7,24)=(-T(1));
g1(7,18)=(-params(12));
g1(8,16)=(-T(2));
g1(8,18)=1;
g1(8,22)=(-1);
g1(9,8)=1;
g1(9,12)=(-1);
g1(9,17)=(-T(2));
g1(10,10)=(-((1-params(7))*params(5)));
g1(10,2)=(-params(7));
g1(10,11)=1;
g1(10,22)=(-((1-params(7))*params(6)));
g1(10,29)=(-1);
g1(11,7)=(-1);
g1(11,9)=1;
g1(11,12)=1;
g1(12,7)=(-1);
g1(12,8)=1;
g1(12,22)=1;
g1(13,4)=(-params(9));
g1(13,13)=1;
g1(13,31)=(-1);
g1(14,3)=(-params(8));
g1(14,12)=1;
g1(14,30)=(-1);
g1(15,6)=(-params(10));
g1(15,17)=1;
g1(15,32)=(-1);
g1(16,5)=(-params(11));
g1(16,16)=1;
g1(16,33)=(-1);

end
