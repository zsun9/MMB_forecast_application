function [residual, g1, g2, g3] = FU20_static(y, x, params)
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

residual = zeros( 40, 1);

%
% Model equations
%

T11 = params(1)/params(2);
T26 = (1-T11)/((1+T11)*params(3));
T39 = 1/(1+params(2)*params(6));
T44 = params(2)^2*params(7);
T65 = (1-params(9))/(1+params(8)-params(9));
T73 = 1/(params(44)/(1-params(44)));
T126 = (1-params(2)*params(6)*params(13))*(1-params(13))/(1+params(2)*params(6)*params(14))/params(13)/(1+params(15)*params(45));
T150 = (1-params(2)*params(6)*params(16))*(1-params(16))/params(16)/(1+params(19)*params(46));
T238 = params(10)*(params(2)*params(25))^(-1);
lhs =y(12);
rhs =y(12)*T11/(1+T11)+y(12)*1/(1+T11)-T26*(y(13)-y(11))+y(35);
residual(1)= lhs-rhs;
lhs =y(18);
rhs =T39*(y(18)+y(18)*params(2)*params(6)+1/T44*y(19))+y(36);
residual(2)= lhs-rhs;
lhs =y(19);
rhs =y(35)*1/T26-(y(13)-y(11))+params(8)/(1+params(8)-params(9))*y(10)+y(19)*T65;
residual(3)= lhs-rhs;
lhs =y(16);
rhs =y(10)*T73;
residual(4)= lhs-rhs;
lhs =y(15);
rhs =y(16)+y(17);
residual(5)= lhs-rhs;
lhs =y(17);
rhs =y(17)*(1-params(47))+params(47)*(y(18)+T44*y(36));
residual(6)= lhs-rhs;
lhs =y(20);
rhs =params(11)*y(32)+y(15)*params(11)*params(12)+y(14)*params(11)*(1-params(12));
residual(7)= lhs-rhs;
lhs =y(15);
rhs =y(14)+y(9)-y(10);
residual(8)= lhs-rhs;
lhs =y(8);
rhs =y(10)*params(12)+(1-params(12))*y(9)-y(32);
residual(9)= lhs-rhs;
lhs =y(11);
rhs =y(8)*T126+y(33)+y(11)*params(14)/(1+params(2)*params(6)*params(14))+y(11)*params(2)*params(6)/(1+params(2)*params(6)*params(14));
residual(10)= lhs-rhs;
lhs =y(9);
rhs =T39*(y(9)+params(2)*params(6)*y(9)+T150*(y(12)*1/(1-T11)-y(12)*T11/(1-T11)+y(14)*params(17)-y(9))-y(11)*(1+params(2)*params(6)*params(18))+y(11)*params(18)+y(11)*params(2)*params(6))+y(34);
residual(11)= lhs-rhs;
lhs =y(13);
rhs =y(13)*params(20)+(1-params(20))*(y(11)*params(21)+params(22)*(y(20)-y(30)))+y(38);
residual(12)= lhs-rhs;
lhs =y(20);
rhs =y(12)*params(24)+y(18)*params(10)+y(37)+y(16)*params(8)*params(25);
residual(13)= lhs-rhs;
lhs =y(23);
rhs =y(35)+T11/(1+T11)*y(23)+1/(1+T11)*y(23)-T26*y(24);
residual(14)= lhs-rhs;
lhs =y(29);
rhs =y(36)+T39*(y(29)+params(2)*params(6)*y(29)+1/T44*y(31));
residual(15)= lhs-rhs;
lhs =y(31);
rhs =y(35)*1/T26-y(24)+params(8)/(1+params(8)-params(9))*y(22)+T65*y(31);
residual(16)= lhs-rhs;
lhs =y(27);
rhs =T73*y(22);
residual(17)= lhs-rhs;
lhs =y(26);
rhs =y(27)+y(28);
residual(18)= lhs-rhs;
lhs =y(28);
rhs =y(28)*(1-T238)+T238*(T44*y(36)+y(29));
residual(19)= lhs-rhs;
lhs =y(30);
rhs =params(11)*y(32)+params(11)*params(12)*y(26)+params(11)*(1-params(12))*y(25);
residual(20)= lhs-rhs;
lhs =y(26);
rhs =y(25)+y(21)-y(22);
residual(21)= lhs-rhs;
lhs =0;
rhs =params(12)*y(22)+(1-params(12))*y(21)-y(32);
residual(22)= lhs-rhs;
lhs =y(21);
rhs =1/(1-T11)*y(23)-T11/(1-T11)*y(23)+params(17)*y(25);
residual(23)= lhs-rhs;
lhs =y(30);
rhs =y(37)+params(24)*y(23)+params(10)*y(29)+params(8)*params(25)*y(27);
residual(24)= lhs-rhs;
lhs =y(32);
rhs =y(32)*params(34)+x(1);
residual(25)= lhs-rhs;
lhs =y(35);
rhs =y(35)*params(35)+x(4);
residual(26)= lhs-rhs;
lhs =y(37);
rhs =y(37)*params(36)+x(6)+x(1)*params(37);
residual(27)= lhs-rhs;
lhs =y(36);
rhs =y(36)*params(38)+x(5);
residual(28)= lhs-rhs;
lhs =y(33);
rhs =y(33)*params(39)+x(2)-x(2)*params(40);
residual(29)= lhs-rhs;
lhs =y(34);
rhs =y(34)*params(41)+x(3)-x(3)*params(42);
residual(30)= lhs-rhs;
lhs =y(38);
rhs =y(38)*params(43)+x(7);
residual(31)= lhs-rhs;
lhs =y(4);
rhs =params(29);
residual(32)= lhs-rhs;
lhs =y(5);
rhs =params(29);
residual(33)= lhs-rhs;
lhs =y(6);
rhs =params(29);
residual(34)= lhs-rhs;
lhs =y(7);
rhs =params(29);
residual(35)= lhs-rhs;
lhs =y(3);
rhs =y(11)+params(30);
residual(36)= lhs-rhs;
lhs =y(2);
rhs =y(13)+params(31);
residual(37)= lhs-rhs;
lhs =y(1);
rhs =y(14)+params(32);
residual(38)= lhs-rhs;
lhs =y(39);
rhs =x(2);
residual(39)= lhs-rhs;
lhs =y(40);
rhs =x(3);
residual(40)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(40, 40);

  %
  % Jacobian matrix
  %

T373 = 1-(T11/(1+T11)+1/(1+T11));
T374 = 1/(1-T11)-T11/(1-T11);
  g1(1,11)=(-T26);
  g1(1,12)=T373;
  g1(1,13)=T26;
  g1(1,35)=(-1);
  g1(2,18)=1-(1+params(2)*params(6))*T39;
  g1(2,19)=(-(T39*1/T44));
  g1(2,36)=(-1);
  g1(3,10)=(-(params(8)/(1+params(8)-params(9))));
  g1(3,11)=(-1);
  g1(3,13)=1;
  g1(3,19)=1-T65;
  g1(3,35)=(-(1/T26));
  g1(4,10)=(-T73);
  g1(4,16)=1;
  g1(5,15)=1;
  g1(5,16)=(-1);
  g1(5,17)=(-1);
  g1(6,17)=1-(1-params(47));
  g1(6,18)=(-params(47));
  g1(6,36)=(-(T44*params(47)));
  g1(7,14)=(-(params(11)*(1-params(12))));
  g1(7,15)=(-(params(11)*params(12)));
  g1(7,20)=1;
  g1(7,32)=(-params(11));
  g1(8,9)=(-1);
  g1(8,10)=1;
  g1(8,14)=(-1);
  g1(8,15)=1;
  g1(9,8)=1;
  g1(9,9)=(-(1-params(12)));
  g1(9,10)=(-params(12));
  g1(9,32)=1;
  g1(10,8)=(-T126);
  g1(10,11)=1-(params(14)/(1+params(2)*params(6)*params(14))+params(2)*params(6)/(1+params(2)*params(6)*params(14)));
  g1(10,33)=(-1);
  g1(11,9)=1-T39*(1+params(2)*params(6)-T150);
  g1(11,11)=(-(T39*(params(2)*params(6)+params(18)+(-(1+params(2)*params(6)*params(18))))));
  g1(11,12)=(-(T39*T150*T374));
  g1(11,14)=(-(T39*T150*params(17)));
  g1(11,34)=(-1);
  g1(12,11)=(-((1-params(20))*params(21)));
  g1(12,13)=1-params(20);
  g1(12,20)=(-((1-params(20))*params(22)));
  g1(12,30)=(-((1-params(20))*(-params(22))));
  g1(12,38)=(-1);
  g1(13,12)=(-params(24));
  g1(13,16)=(-(params(8)*params(25)));
  g1(13,18)=(-params(10));
  g1(13,20)=1;
  g1(13,37)=(-1);
  g1(14,23)=T373;
  g1(14,24)=T26;
  g1(14,35)=(-1);
  g1(15,29)=1-(1+params(2)*params(6))*T39;
  g1(15,31)=(-(T39*1/T44));
  g1(15,36)=(-1);
  g1(16,22)=(-(params(8)/(1+params(8)-params(9))));
  g1(16,24)=1;
  g1(16,31)=1-T65;
  g1(16,35)=(-(1/T26));
  g1(17,22)=(-T73);
  g1(17,27)=1;
  g1(18,26)=1;
  g1(18,27)=(-1);
  g1(18,28)=(-1);
  g1(19,28)=1-(1-T238);
  g1(19,29)=(-T238);
  g1(19,36)=(-(T44*T238));
  g1(20,25)=(-(params(11)*(1-params(12))));
  g1(20,26)=(-(params(11)*params(12)));
  g1(20,30)=1;
  g1(20,32)=(-params(11));
  g1(21,21)=(-1);
  g1(21,22)=1;
  g1(21,25)=(-1);
  g1(21,26)=1;
  g1(22,21)=(-(1-params(12)));
  g1(22,22)=(-params(12));
  g1(22,32)=1;
  g1(23,21)=1;
  g1(23,23)=(-T374);
  g1(23,25)=(-params(17));
  g1(24,23)=(-params(24));
  g1(24,27)=(-(params(8)*params(25)));
  g1(24,29)=(-params(10));
  g1(24,30)=1;
  g1(24,37)=(-1);
  g1(25,32)=1-params(34);
  g1(26,35)=1-params(35);
  g1(27,37)=1-params(36);
  g1(28,36)=1-params(38);
  g1(29,33)=1-params(39);
  g1(30,34)=1-params(41);
  g1(31,38)=1-params(43);
  g1(32,4)=1;
  g1(33,5)=1;
  g1(34,6)=1;
  g1(35,7)=1;
  g1(36,3)=1;
  g1(36,11)=(-1);
  g1(37,2)=1;
  g1(37,13)=(-1);
  g1(38,1)=1;
  g1(38,14)=(-1);
  g1(39,39)=1;
  g1(40,40)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],40,1600);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],40,64000);
end
end
end
end
