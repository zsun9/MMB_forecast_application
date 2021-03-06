function [residual, g1, g2, g3] = VI16_BGG_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(43, 1);
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
T76 = 1/(params(24)/(1-params(24)));
T88 = 1/(1+BETABAR__);
T129 = params(10)^(-1);
T146 = HBAR__/(1-HBAR__);
T149 = 1/(1-HBAR__);
T278 = 1/(1+BETABAR__*params(23));
T288 = (1-params(21))*(1-BETABAR__*params(21))/params(21);
T326 = (1-params(20))*T88*(1-BETABAR__*params(20))/(params(20)*(1+params(41)*params(8)));
lhs =y(62);
rhs =params(2)*y(46)+(1-params(2))*y(43);
residual(1)= lhs-rhs;
lhs =y(35);
rhs =y(46)*T76;
residual(2)= lhs-rhs;
lhs =y(46);
rhs =y(43)+y(42)-y(3)-y(35);
residual(3)= lhs-rhs;
lhs =y(40);
rhs =T88*(y(6)+BETABAR__*y(71)+1/params(17)*(y(38)+y(64)));
residual(4)= lhs-rhs;
lhs =y(36);
rhs =y(46)*ZK_SS__/R_K_SS__+(1-params(4))/R_K_SS__*(y(38)+y(68))-y(4);
residual(5)= lhs-rhs;
lhs =y(45);
rhs =params(12)*(y(38)+y(37)-y(47));
residual(6)= lhs-rhs;
lhs =y(69);
rhs =y(45)+y(44);
residual(7)= lhs-rhs;
lhs =y(47)/(R_K_SS__*params(1));
rhs =y(36)*T129-(T129-1)*y(8)-params(12)*(T129-1)*(y(3)+y(4))+(1+params(12)*(T129-1))*y(9);
residual(8)= lhs-rhs;
lhs =T146*y(39);
rhs =T149*y(70)+T146*y(5)-y(39)*T149-y(44);
residual(9)= lhs-rhs;
lhs =y(41);
rhs =y(39)*C_OVER_Y__+I_OVER_Y__*y(40)+params(6)*y(63)+y(35)*ZK_SS__*K_OVER_Y__;
residual(10)= lhs-rhs;
lhs =y(41);
rhs =params(40)*(y(62)+params(2)*(y(3)+y(68))+params(2)*y(35)+(1-params(2))*y(42));
residual(11)= lhs-rhs;
lhs =y(43);
rhs =y(39)*T149+y(42)*params(41)-T146*y(5);
residual(12)= lhs-rhs;
lhs =y(37);
rhs =(1-params(4))*(y(3)+y(68))+I_OVER_K__*(y(40)+y(64));
residual(13)= lhs-rhs;
lhs =y(51);
rhs =T76*y(49);
residual(14)= lhs-rhs;
lhs =y(49);
rhs =y(60)+y(58)-y(11)-y(51);
residual(15)= lhs-rhs;
lhs =y(56);
rhs =T88*(y(14)+BETABAR__*y(74)+1/params(17)*(y(64)+y(54)));
residual(16)= lhs-rhs;
lhs =y(52);
rhs =ZK_SS__/R_K_SS__*y(49)+(1-params(4))/R_K_SS__*(y(68)+y(54))-y(12);
residual(17)= lhs-rhs;
lhs =y(48);
rhs =params(12)*(y(54)+y(53)-y(50));
residual(18)= lhs-rhs;
lhs =y(72);
rhs =y(48)+y(61)-y(75);
residual(19)= lhs-rhs;
lhs =y(50)/(R_K_SS__*params(1));
rhs =T129*y(52)-(T129-1)*y(18)-params(12)*(T129-1)*(y(11)+y(12))+(1+params(12)*(T129-1))*y(10);
residual(20)= lhs-rhs;
lhs =T146*y(55);
rhs =T149*y(73)+T146*y(13)-T149*y(55)-y(61);
residual(21)= lhs-rhs;
lhs =y(57);
rhs =params(6)*y(63)+C_OVER_Y__*y(55)+I_OVER_Y__*y(56)+ZK_SS__*K_OVER_Y__*y(51);
residual(22)= lhs-rhs;
lhs =y(57);
rhs =params(40)*(y(62)+params(2)*(y(68)+y(11))+params(2)*y(51)+(1-params(2))*y(58));
residual(23)= lhs-rhs;
lhs =y(59);
rhs =T278*(BETABAR__*y(75)+params(23)*y(16)+T288*(params(2)*y(49)-y(62)+(1-params(2))*y(60)))+y(66);
residual(24)= lhs-rhs;
lhs =y(60);
rhs =T88*y(17)+BETABAR__/(1+BETABAR__)*y(76)+y(16)*params(22)/(1+BETABAR__)-y(59)*(1+BETABAR__*params(22))/(1+BETABAR__)+y(75)*BETABAR__/(1+BETABAR__)+T326*(T149*y(55)+params(41)*y(58)-T146*y(13)-y(60))+y(67);
residual(25)= lhs-rhs;
lhs =y(61);
rhs =y(59)*(1-params(28))*params(25)+(1-params(28))*params(27)*(y(57)-y(41))+params(26)*(y(57)-y(41)-y(15)+y(7))+params(29)*(y(59)-y(16))+y(18)*params(28)+y(65);
residual(26)= lhs-rhs;
lhs =y(53);
rhs =(1-params(4))*(y(68)+y(11))+I_OVER_K__*y(56)+y(64)*I_OVER_K__*params(17);
residual(27)= lhs-rhs;
lhs =y(62);
rhs =params(30)*y(19)-x(it_, 1);
residual(28)= lhs-rhs;
lhs =y(63);
rhs =params(32)*y(20)-x(it_, 2)-x(it_, 1)*params(16);
residual(29)= lhs-rhs;
lhs =y(64);
rhs =params(33)*y(21)-x(it_, 3);
residual(30)= lhs-rhs;
lhs =y(65);
rhs =params(34)*y(22)+x(it_, 4);
residual(31)= lhs-rhs;
lhs =y(66);
rhs =params(35)*y(23)+y(34)-params(38)*y(2);
residual(32)= lhs-rhs;
lhs =y(34);
rhs =x(it_, 5);
residual(33)= lhs-rhs;
lhs =y(67);
rhs =params(36)*y(24)+y(33)-params(37)*y(1);
residual(34)= lhs-rhs;
lhs =y(33);
rhs =x(it_, 6);
residual(35)= lhs-rhs;
lhs =y(68);
rhs =params(31)*y(25)+x(it_, 7);
residual(36)= lhs-rhs;
lhs =y(29);
rhs =params(13)+y(57)-y(15);
residual(37)= lhs-rhs;
lhs =y(30);
rhs =params(13)+y(55)-y(13);
residual(38)= lhs-rhs;
lhs =y(31);
rhs =params(13)+y(56)-y(14);
residual(39)= lhs-rhs;
lhs =y(32);
rhs =params(13)+y(60)-y(17);
residual(40)= lhs-rhs;
lhs =y(28);
rhs =params(42)+y(59);
residual(41)= lhs-rhs;
lhs =y(27);
rhs =y(61)+conster__;
residual(42)= lhs-rhs;
lhs =y(26);
rhs =y(58)+params(39);
residual(43)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(43, 83);

  %
  % Jacobian matrix
  %

T463 = (-(T88*1/params(17)));
T464 = (-((1-params(4))/R_K_SS__));
  g1(1,43)=(-(1-params(2)));
  g1(1,46)=(-params(2));
  g1(1,62)=1;
  g1(2,35)=1;
  g1(2,46)=(-T76);
  g1(3,35)=1;
  g1(3,3)=1;
  g1(3,42)=(-1);
  g1(3,43)=(-1);
  g1(3,46)=1;
  g1(4,38)=T463;
  g1(4,6)=(-T88);
  g1(4,40)=1;
  g1(4,71)=(-(BETABAR__*T88));
  g1(4,64)=T463;
  g1(5,36)=1;
  g1(5,4)=1;
  g1(5,38)=T464;
  g1(5,46)=(-(ZK_SS__/R_K_SS__));
  g1(5,68)=T464;
  g1(6,37)=(-params(12));
  g1(6,38)=(-params(12));
  g1(6,45)=1;
  g1(6,47)=params(12);
  g1(7,69)=1;
  g1(7,44)=(-1);
  g1(7,45)=(-1);
  g1(8,36)=(-T129);
  g1(8,3)=params(12)*(T129-1);
  g1(8,4)=params(12)*(T129-1);
  g1(8,8)=T129-1;
  g1(8,9)=(-(1+params(12)*(T129-1)));
  g1(8,47)=1/(R_K_SS__*params(1));
  g1(9,5)=(-T146);
  g1(9,39)=T146-(-T149);
  g1(9,70)=(-T149);
  g1(9,44)=1;
  g1(10,35)=(-(ZK_SS__*K_OVER_Y__));
  g1(10,39)=(-C_OVER_Y__);
  g1(10,40)=(-I_OVER_Y__);
  g1(10,41)=1;
  g1(10,63)=(-params(6));
  g1(11,35)=(-(params(2)*params(40)));
  g1(11,3)=(-(params(2)*params(40)));
  g1(11,41)=1;
  g1(11,42)=(-((1-params(2))*params(40)));
  g1(11,62)=(-params(40));
  g1(11,68)=(-(params(2)*params(40)));
  g1(12,5)=T146;
  g1(12,39)=(-T149);
  g1(12,42)=(-params(41));
  g1(12,43)=1;
  g1(13,3)=(-(1-params(4)));
  g1(13,37)=1;
  g1(13,40)=(-I_OVER_K__);
  g1(13,64)=(-I_OVER_K__);
  g1(13,68)=(-(1-params(4)));
  g1(14,49)=(-T76);
  g1(14,51)=1;
  g1(15,49)=1;
  g1(15,51)=1;
  g1(15,11)=1;
  g1(15,58)=(-1);
  g1(15,60)=(-1);
  g1(16,54)=T463;
  g1(16,14)=(-T88);
  g1(16,56)=1;
  g1(16,74)=(-(BETABAR__*T88));
  g1(16,64)=T463;
  g1(17,49)=(-(ZK_SS__/R_K_SS__));
  g1(17,52)=1;
  g1(17,12)=1;
  g1(17,54)=T464;
  g1(17,68)=T464;
  g1(18,48)=1;
  g1(18,50)=params(12);
  g1(18,53)=(-params(12));
  g1(18,54)=(-params(12));
  g1(19,48)=(-1);
  g1(19,72)=1;
  g1(19,75)=1;
  g1(19,61)=(-1);
  g1(20,10)=(-(1+params(12)*(T129-1)));
  g1(20,50)=1/(R_K_SS__*params(1));
  g1(20,52)=(-T129);
  g1(20,11)=params(12)*(T129-1);
  g1(20,12)=params(12)*(T129-1);
  g1(20,18)=T129-1;
  g1(21,13)=(-T146);
  g1(21,55)=T146-(-T149);
  g1(21,73)=(-T149);
  g1(21,61)=1;
  g1(22,51)=(-(ZK_SS__*K_OVER_Y__));
  g1(22,55)=(-C_OVER_Y__);
  g1(22,56)=(-I_OVER_Y__);
  g1(22,57)=1;
  g1(22,63)=(-params(6));
  g1(23,51)=(-(params(2)*params(40)));
  g1(23,11)=(-(params(2)*params(40)));
  g1(23,57)=1;
  g1(23,58)=(-((1-params(2))*params(40)));
  g1(23,62)=(-params(40));
  g1(23,68)=(-(params(2)*params(40)));
  g1(24,49)=(-(T278*params(2)*T288));
  g1(24,16)=(-(params(23)*T278));
  g1(24,59)=1;
  g1(24,75)=(-(BETABAR__*T278));
  g1(24,60)=(-(T278*(1-params(2))*T288));
  g1(24,62)=(-(T278*(-T288)));
  g1(24,66)=(-1);
  g1(25,13)=(-(T326*(-T146)));
  g1(25,55)=(-(T149*T326));
  g1(25,58)=(-(params(41)*T326));
  g1(25,16)=(-(params(22)/(1+BETABAR__)));
  g1(25,59)=(1+BETABAR__*params(22))/(1+BETABAR__);
  g1(25,75)=(-(BETABAR__/(1+BETABAR__)));
  g1(25,17)=(-T88);
  g1(25,60)=1-(-T326);
  g1(25,76)=(-(BETABAR__/(1+BETABAR__)));
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
  g1(27,56)=(-I_OVER_K__);
  g1(27,64)=(-(I_OVER_K__*params(17)));
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

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],43,6889);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],43,571787);
end
end
end
end
