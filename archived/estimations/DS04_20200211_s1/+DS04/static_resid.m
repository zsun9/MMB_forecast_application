function residual = static_resid(T, y, x, params, T_flag)
% function residual = static_resid(T, y, x, params, T_flag)
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
%   residual
%

if T_flag
    T = DS04.static_resid_tt(T, y, x, params);
end
residual = zeros(13, 1);
lhs = y(8);
rhs = params(9)+100*0.25*(y(2)+y(2)+y(2)+y(2));
residual(1) = lhs - rhs;
lhs = y(10);
rhs = 100*y(1);
residual(2) = lhs - rhs;
lhs = y(6);
rhs = 4*y(7);
residual(3) = lhs - rhs;
lhs = y(11);
rhs = params(8)+100*y(5);
residual(4) = lhs - rhs;
lhs = y(9);
rhs = params(9)+100*y(2);
residual(5) = lhs - rhs;
lhs = y(7);
rhs = params(10)+params(9)+100*y(3);
residual(6) = lhs - rhs;
lhs = y(1);
rhs = y(1)-T(2)*(y(3)-y(2))+(1-params(6))*y(4)+y(5)*T(2)*params(7);
residual(7) = lhs - rhs;
lhs = y(2);
rhs = y(2)*T(1)+params(2)*(y(1)-y(4));
residual(8) = lhs - rhs;
lhs = y(3);
rhs = y(3)*params(5)+(1-params(5))*(y(2)*params(3)+y(1)*params(4))+x(1);
residual(9) = lhs - rhs;
lhs = y(5);
rhs = y(5)*params(7)+x(3);
residual(10) = lhs - rhs;
lhs = y(4);
rhs = params(6)*y(4)+x(2);
residual(11) = lhs - rhs;
lhs = y(12);
rhs = y(2);
residual(12) = lhs - rhs;
lhs = y(13);
rhs = y(2);
residual(13) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
