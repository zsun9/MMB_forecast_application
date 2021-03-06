function [residual, g1, g2, g3] = DS04_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the static model equations 
%                                          in order of declaration of the equations.
%                                          Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g3        [M_.endo_nbr by (M_.endo_nbr)^3] double   Third derivatives matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 13, 1);

%
% Model equations
%

beta__ = (1+params(8)/100)/(1+params(10)/100);
T55 = 1/params(1);
lhs =y(8);
rhs =params(9)+100*0.25*(y(2)+y(2)+y(2)+y(2));
residual(1)= lhs-rhs;
lhs =y(10);
rhs =100*y(1);
residual(2)= lhs-rhs;
lhs =y(6);
rhs =4*y(7);
residual(3)= lhs-rhs;
lhs =y(11);
rhs =params(8)+100*y(5);
residual(4)= lhs-rhs;
lhs =y(9);
rhs =params(9)+100*y(2);
residual(5)= lhs-rhs;
lhs =y(7);
rhs =params(10)+params(9)+100*y(3);
residual(6)= lhs-rhs;
lhs =y(1);
rhs =y(1)-T55*(y(3)-y(2))+(1-params(6))*y(4)+y(5)*T55*params(7);
residual(7)= lhs-rhs;
lhs =y(2);
rhs =y(2)*beta__+params(2)*(y(1)-y(4));
residual(8)= lhs-rhs;
lhs =y(3);
rhs =y(3)*params(5)+(1-params(5))*(y(2)*params(3)+y(1)*params(4))+x(1);
residual(9)= lhs-rhs;
lhs =y(5);
rhs =y(5)*params(7)+x(3);
residual(10)= lhs-rhs;
lhs =y(4);
rhs =params(6)*y(4)+x(2);
residual(11)= lhs-rhs;
lhs =y(12);
rhs =y(2);
residual(12)= lhs-rhs;
lhs =y(13);
rhs =y(2);
residual(13)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(13, 13);

  %
  % Jacobian matrix
  %

  g1(1,2)=(-100);
  g1(1,8)=1;
  g1(2,1)=(-100);
  g1(2,10)=1;
  g1(3,6)=1;
  g1(3,7)=(-4);
  g1(4,5)=(-100);
  g1(4,11)=1;
  g1(5,2)=(-100);
  g1(5,9)=1;
  g1(6,3)=(-100);
  g1(6,7)=1;
  g1(7,2)=(-T55);
  g1(7,3)=T55;
  g1(7,4)=(-(1-params(6)));
  g1(7,5)=(-(T55*params(7)));
  g1(8,1)=(-params(2));
  g1(8,2)=1-beta__;
  g1(8,4)=params(2);
  g1(9,1)=(-((1-params(5))*params(4)));
  g1(9,2)=(-((1-params(5))*params(3)));
  g1(9,3)=1-params(5);
  g1(10,5)=1-params(7);
  g1(11,4)=1-params(6);
  g1(12,2)=(-1);
  g1(12,12)=1;
  g1(13,2)=(-1);
  g1(13,13)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],13,169);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],13,2197);
end
end
end
end
