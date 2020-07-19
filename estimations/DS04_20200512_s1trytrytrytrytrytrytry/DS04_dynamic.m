function [residual, g1, g2, g3] = DS04_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(13, 1);
beta__ = (1+params(8)/100)/(1+params(10)/100);
T63 = 1/params(1);
lhs =y(15);
rhs =params(9)+100*0.25*(y(9)+y(2)+y(6)+y(7));
residual(1)= lhs-rhs;
lhs =y(17);
rhs =100*y(8);
residual(2)= lhs-rhs;
lhs =y(13);
rhs =4*y(14);
residual(3)= lhs-rhs;
lhs =y(18);
rhs =params(8)+100*(y(8)-y(1)+y(12));
residual(4)= lhs-rhs;
lhs =y(16);
rhs =params(9)+100*y(9);
residual(5)= lhs-rhs;
lhs =y(14);
rhs =params(10)+params(9)+100*y(10);
residual(6)= lhs-rhs;
lhs =y(8);
rhs =y(21)-T63*(y(10)-y(22))+(1-params(6))*y(11)+y(12)*T63*params(7);
residual(7)= lhs-rhs;
lhs =y(9);
rhs =y(22)*beta__+params(2)*(y(8)-y(11));
residual(8)= lhs-rhs;
lhs =y(10);
rhs =params(5)*y(3)+(1-params(5))*(y(9)*params(3)+y(8)*params(4))+x(it_, 1);
residual(9)= lhs-rhs;
lhs =y(12);
rhs =params(7)*y(5)+x(it_, 3);
residual(10)= lhs-rhs;
lhs =y(11);
rhs =params(6)*y(4)+x(it_, 2);
residual(11)= lhs-rhs;
lhs =y(19);
rhs =y(2);
residual(12)= lhs-rhs;
lhs =y(20);
rhs =y(6);
residual(13)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(13, 25);

%
% Jacobian matrix
%

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
g1(7,22)=(-T63);
g1(7,10)=T63;
g1(7,11)=(-(1-params(6)));
g1(7,12)=(-(T63*params(7)));
g1(8,8)=(-params(2));
g1(8,9)=1;
g1(8,22)=(-beta__);
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
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],13,625);
end
if nargout >= 4,
%
% Third order derivatives
%

  g3 = sparse([],[],[],13,15625);
end
end
