function [residual, g1, g2, g3] = VI16_BGG_static(y, x, params)
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

residual = zeros( 43, 1);

%
% Model equations
%

HBAR__ = params(18);
BETABAR__ = params(3);
R_SS__ = 1/params(3);
R_K_SS__ = params(9)*R_SS__;
R_K_SS_BAR__ = R_K_SS__;
ZK_SS__ = R_K_SS_BAR__-(1-params(4));
W_SS__ = (params(2)^params(2)*(1-params(2))^(1-params(2))/(params(5)*ZK_SS__^params(2)))^(1/(1-params(2)));
K_OVER_L__ = params(2)*W_SS__/((1-params(2))*ZK_SS__);
I_OVER_K__ = 1-(1-params(4));
conster__ = 100*(R_SS__-1);
Y_OVER_K__ = (params(40)*K_OVER_L__^(1-params(2)))^(-1);
K_OVER_Y__ = Y_OVER_K__^(-1);
I_OVER_Y__ = I_OVER_K__/Y_OVER_K__;
C_OVER_Y__ = 1-I_OVER_Y__-params(6);
T74 = 1/(params(24)/(1-params(24)));
T86 = 1/(1+BETABAR__);
T101 = (1-params(4))/R_K_SS__;
T122 = params(10)^(-1);
T136 = HBAR__/(1-HBAR__);
T139 = 1/(1-HBAR__);
T251 = 1/(1+BETABAR__*params(23));
T260 = (1-params(21))*(1-BETABAR__*params(21))/params(21);
T272 = BETABAR__/(1+BETABAR__);
T296 = (1-params(20))*T86*(1-BETABAR__*params(20))/(params(20)*(1+params(41)*params(8)));
lhs =y(37);
rhs =params(2)*y(21)+(1-params(2))*y(18);
residual(1)= lhs-rhs;
lhs =y(10);
rhs =y(21)*T74;
residual(2)= lhs-rhs;
lhs =y(21);
rhs =y(18)+y(17)-y(12)-y(10);
residual(3)= lhs-rhs;
lhs =y(15);
rhs =T86*(y(15)+y(15)*BETABAR__+1/params(17)*(y(13)+y(39)));
residual(4)= lhs-rhs;
lhs =y(11);
rhs =y(21)*ZK_SS__/R_K_SS__+T101*(y(13)+y(43))-y(13);
residual(5)= lhs-rhs;
lhs =y(20);
rhs =params(12)*(y(12)+y(13)-y(22));
residual(6)= lhs-rhs;
lhs =y(11);
rhs =y(20)+y(19);
residual(7)= lhs-rhs;
lhs =y(22)/(R_K_SS__*params(1));
rhs =y(11)*T122-y(19)*(T122-1)-(y(12)+y(13))*params(12)*(T122-1)+y(22)*(1+params(12)*(T122-1));
residual(8)= lhs-rhs;
lhs =T136*y(14);
rhs =T136*y(14)+y(14)*T139-y(14)*T139-y(19);
residual(9)= lhs-rhs;
lhs =y(16);
rhs =y(14)*C_OVER_Y__+I_OVER_Y__*y(15)+params(6)*y(38)+y(10)*ZK_SS__*K_OVER_Y__;
residual(10)= lhs-rhs;
lhs =y(16);
rhs =params(40)*(y(37)+params(2)*(y(12)+y(43))+params(2)*y(10)+(1-params(2))*y(17));
residual(11)= lhs-rhs;
lhs =y(18);
rhs =y(14)*T139+y(17)*params(41)-T136*y(14);
residual(12)= lhs-rhs;
lhs =y(12);
rhs =(1-params(4))*(y(12)+y(43))+I_OVER_K__*(y(15)+y(39));
residual(13)= lhs-rhs;
lhs =y(26);
rhs =T74*y(24);
residual(14)= lhs-rhs;
lhs =y(24);
rhs =y(35)+y(33)-y(28)-y(26);
residual(15)= lhs-rhs;
lhs =y(31);
rhs =T86*(y(31)+BETABAR__*y(31)+1/params(17)*(y(39)+y(29)));
residual(16)= lhs-rhs;
lhs =y(27);
rhs =ZK_SS__/R_K_SS__*y(24)+T101*(y(43)+y(29))-y(29);
residual(17)= lhs-rhs;
lhs =y(23);
rhs =params(12)*(y(28)+y(29)-y(25));
residual(18)= lhs-rhs;
lhs =y(27);
rhs =y(23)+y(36)-y(34);
residual(19)= lhs-rhs;
lhs =y(25)/(R_K_SS__*params(1));
rhs =T122*y(27)-(T122-1)*y(36)-params(12)*(T122-1)*(y(28)+y(29))+(1+params(12)*(T122-1))*y(25);
residual(20)= lhs-rhs;
lhs =T136*y(30);
rhs =T136*y(30)+T139*y(30)-T139*y(30)-y(36);
residual(21)= lhs-rhs;
lhs =y(32);
rhs =params(6)*y(38)+C_OVER_Y__*y(30)+I_OVER_Y__*y(31)+ZK_SS__*K_OVER_Y__*y(26);
residual(22)= lhs-rhs;
lhs =y(32);
rhs =params(40)*(y(37)+params(2)*(y(43)+y(28))+params(2)*y(26)+(1-params(2))*y(33));
residual(23)= lhs-rhs;
lhs =y(34);
rhs =T251*(BETABAR__*y(34)+y(34)*params(23)+T260*(params(2)*y(24)-y(37)+(1-params(2))*y(35)))+y(41);
residual(24)= lhs-rhs;
lhs =y(35);
rhs =T86*y(35)+y(35)*T272+y(34)*params(22)/(1+BETABAR__)-y(34)*(1+BETABAR__*params(22))/(1+BETABAR__)+y(34)*T272+T296*(T139*y(30)+params(41)*y(33)-T136*y(30)-y(35))+y(42);
residual(25)= lhs-rhs;
lhs =y(36);
rhs =y(34)*(1-params(28))*params(25)+(1-params(28))*params(27)*(y(32)-y(16))+params(26)*(y(16)+y(32)-y(16)-y(32))+y(36)*params(28)+y(40);
residual(26)= lhs-rhs;
lhs =y(28);
rhs =(1-params(4))*(y(43)+y(28))+I_OVER_K__*y(31)+y(39)*I_OVER_K__*params(17);
residual(27)= lhs-rhs;
lhs =y(37);
rhs =y(37)*params(30)-x(1);
residual(28)= lhs-rhs;
lhs =y(38);
rhs =y(38)*params(32)-x(2)-x(1)*params(16);
residual(29)= lhs-rhs;
lhs =y(39);
rhs =y(39)*params(33)-x(3);
residual(30)= lhs-rhs;
lhs =y(40);
rhs =y(40)*params(34)+x(4);
residual(31)= lhs-rhs;
lhs =y(41);
rhs =y(41)*params(35)+y(9)-y(9)*params(38);
residual(32)= lhs-rhs;
lhs =y(9);
rhs =x(5);
residual(33)= lhs-rhs;
lhs =y(42);
rhs =y(42)*params(36)+y(8)-y(8)*params(37);
residual(34)= lhs-rhs;
lhs =y(8);
rhs =x(6);
residual(35)= lhs-rhs;
lhs =y(43);
rhs =y(43)*params(31)+x(7);
residual(36)= lhs-rhs;
lhs =y(4);
rhs =params(13);
residual(37)= lhs-rhs;
lhs =y(5);
rhs =params(13);
residual(38)= lhs-rhs;
lhs =y(6);
rhs =params(13);
residual(39)= lhs-rhs;
lhs =y(7);
rhs =params(13);
residual(40)= lhs-rhs;
lhs =y(3);
rhs =params(42)+y(34);
residual(41)= lhs-rhs;
lhs =y(2);
rhs =y(36)+conster__;
residual(42)= lhs-rhs;
lhs =y(1);
rhs =y(33)+params(39);
residual(43)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(43, 43);

  %
  % Jacobian matrix
  %

T412 = (-(T86*1/params(17)));
  g1(1,18)=(-(1-params(2)));
  g1(1,21)=(-params(2));
  g1(1,37)=1;
  g1(2,10)=1;
  g1(2,21)=(-T74);
  g1(3,10)=1;
  g1(3,12)=1;
  g1(3,17)=(-1);
  g1(3,18)=(-1);
  g1(3,21)=1;
  g1(4,13)=T412;
  g1(4,15)=1-(1+BETABAR__)*T86;
  g1(4,39)=T412;
  g1(5,11)=1;
  g1(5,13)=(-(T101-1));
  g1(5,21)=(-(ZK_SS__/R_K_SS__));
  g1(5,43)=(-T101);
  g1(6,12)=(-params(12));
  g1(6,13)=(-params(12));
  g1(6,20)=1;
  g1(6,22)=params(12);
  g1(7,11)=1;
  g1(7,19)=(-1);
  g1(7,20)=(-1);
  g1(8,11)=(-T122);
  g1(8,12)=params(12)*(T122-1);
  g1(8,13)=params(12)*(T122-1);
  g1(8,19)=T122-1;
  g1(8,22)=1/(R_K_SS__*params(1))-(1+params(12)*(T122-1));
  g1(9,14)=T136-(T136+T139-T139);
  g1(9,19)=1;
  g1(10,10)=(-(ZK_SS__*K_OVER_Y__));
  g1(10,14)=(-C_OVER_Y__);
  g1(10,15)=(-I_OVER_Y__);
  g1(10,16)=1;
  g1(10,38)=(-params(6));
  g1(11,10)=(-(params(2)*params(40)));
  g1(11,12)=(-(params(2)*params(40)));
  g1(11,16)=1;
  g1(11,17)=(-((1-params(2))*params(40)));
  g1(11,37)=(-params(40));
  g1(11,43)=(-(params(2)*params(40)));
  g1(12,14)=(-(T139-T136));
  g1(12,17)=(-params(41));
  g1(12,18)=1;
  g1(13,12)=1-(1-params(4));
  g1(13,15)=(-I_OVER_K__);
  g1(13,39)=(-I_OVER_K__);
  g1(13,43)=(-(1-params(4)));
  g1(14,24)=(-T74);
  g1(14,26)=1;
  g1(15,24)=1;
  g1(15,26)=1;
  g1(15,28)=1;
  g1(15,33)=(-1);
  g1(15,35)=(-1);
  g1(16,29)=T412;
  g1(16,31)=1-(1+BETABAR__)*T86;
  g1(16,39)=T412;
  g1(17,24)=(-(ZK_SS__/R_K_SS__));
  g1(17,27)=1;
  g1(17,29)=(-(T101-1));
  g1(17,43)=(-T101);
  g1(18,23)=1;
  g1(18,25)=params(12);
  g1(18,28)=(-params(12));
  g1(18,29)=(-params(12));
  g1(19,23)=(-1);
  g1(19,27)=1;
  g1(19,34)=1;
  g1(19,36)=(-1);
  g1(20,25)=1/(R_K_SS__*params(1))-(1+params(12)*(T122-1));
  g1(20,27)=(-T122);
  g1(20,28)=params(12)*(T122-1);
  g1(20,29)=params(12)*(T122-1);
  g1(20,36)=T122-1;
  g1(21,30)=T136-(T136+T139-T139);
  g1(21,36)=1;
  g1(22,26)=(-(ZK_SS__*K_OVER_Y__));
  g1(22,30)=(-C_OVER_Y__);
  g1(22,31)=(-I_OVER_Y__);
  g1(22,32)=1;
  g1(22,38)=(-params(6));
  g1(23,26)=(-(params(2)*params(40)));
  g1(23,28)=(-(params(2)*params(40)));
  g1(23,32)=1;
  g1(23,33)=(-((1-params(2))*params(40)));
  g1(23,37)=(-params(40));
  g1(23,43)=(-(params(2)*params(40)));
  g1(24,24)=(-(T251*params(2)*T260));
  g1(24,34)=1-T251*(BETABAR__+params(23));
  g1(24,35)=(-(T251*(1-params(2))*T260));
  g1(24,37)=(-(T251*(-T260)));
  g1(24,41)=(-1);
  g1(25,30)=(-(T296*(T139-T136)));
  g1(25,33)=(-(params(41)*T296));
  g1(25,34)=(-(T272+params(22)/(1+BETABAR__)-(1+BETABAR__*params(22))/(1+BETABAR__)));
  g1(25,35)=1-(T86+T272-T296);
  g1(25,42)=(-1);
  g1(26,16)=(1-params(28))*params(27);
  g1(26,32)=(-((1-params(28))*params(27)));
  g1(26,34)=(-((1-params(28))*params(25)));
  g1(26,36)=1-params(28);
  g1(26,40)=(-1);
  g1(27,28)=1-(1-params(4));
  g1(27,31)=(-I_OVER_K__);
  g1(27,39)=(-(I_OVER_K__*params(17)));
  g1(27,43)=(-(1-params(4)));
  g1(28,37)=1-params(30);
  g1(29,38)=1-params(32);
  g1(30,39)=1-params(33);
  g1(31,40)=1-params(34);
  g1(32,9)=(-(1-params(38)));
  g1(32,41)=1-params(35);
  g1(33,9)=1;
  g1(34,8)=(-(1-params(37)));
  g1(34,42)=1-params(36);
  g1(35,8)=1;
  g1(36,43)=1-params(31);
  g1(37,4)=1;
  g1(38,5)=1;
  g1(39,6)=1;
  g1(40,7)=1;
  g1(41,3)=1;
  g1(41,34)=(-1);
  g1(42,2)=1;
  g1(42,36)=(-1);
  g1(43,1)=1;
  g1(43,33)=(-1);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],43,1849);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],43,79507);
end
end
end
end
