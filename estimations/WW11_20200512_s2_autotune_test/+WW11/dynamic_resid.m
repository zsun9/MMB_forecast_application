function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
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
%   residual
%

if T_flag
    T = WW11.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(16, 1);
lhs = y(21);
rhs = params(2)+100*(y(7)-y(1)+y(13));
residual(1) = lhs - rhs;
lhs = y(20);
rhs = params(3)+100*y(10);
residual(2) = lhs - rhs;
lhs = y(19);
rhs = params(4)+params(3)+100*y(11);
residual(3) = lhs - rhs;
lhs = y(22);
rhs = y(28)-T(2)*(y(11)-y(24)-y(15));
residual(4) = lhs - rhs;
lhs = y(14);
rhs = y(24)+params(1)*(y(23)-y(8))-(y(27)-y(17))-params(1)*(y(25)-y(12))+y(26);
residual(5) = lhs - rhs;
lhs = y(15);
rhs = y(14)-y(24);
residual(6) = lhs - rhs;
lhs = y(10);
rhs = params(12)*y(18)+T(1)*y(24);
residual(7) = lhs - rhs;
lhs = y(18);
rhs = y(22)+T(2)*y(16);
residual(8) = lhs - rhs;
lhs = y(8);
rhs = y(12)+T(2)*y(17);
residual(9) = lhs - rhs;
lhs = y(11);
rhs = params(7)*y(2)+(1-params(7))*(y(10)*params(5)+y(22)*params(6))+x(it_, 1);
residual(10) = lhs - rhs;
lhs = y(9);
rhs = y(7)-y(12);
residual(11) = lhs - rhs;
lhs = y(22);
rhs = y(7)-y(8);
residual(12) = lhs - rhs;
lhs = y(13);
rhs = params(9)*y(4)+x(it_, 3);
residual(13) = lhs - rhs;
lhs = y(12);
rhs = params(8)*y(3)+x(it_, 2);
residual(14) = lhs - rhs;
lhs = y(17);
rhs = params(10)*y(6)+x(it_, 4);
residual(15) = lhs - rhs;
lhs = y(16);
rhs = params(11)*y(5)+x(it_, 5);
residual(16) = lhs - rhs;

end
