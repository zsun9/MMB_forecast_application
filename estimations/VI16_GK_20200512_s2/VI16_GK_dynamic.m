function [residual, g1, g2, g3] = VI16_GK_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(61, 1);
HBAR__ = params(10);
BETABAR__ = params(1);
R_SS__ = 1/params(1);
R_K_BAR__ = params(38);
ZK_SS__ = R_K_BAR__-(1-params(6));
W_SS__ = (params(5)^params(5)*(1-params(5))^(1-params(5))/(params(20)*ZK_SS__^params(5)))^(1/(1-params(5)));
K_OVER_L__ = params(5)*W_SS__/((1-params(5))*ZK_SS__);
conster__ = 100*(R_SS__-1);
Y_OVER_K__ = (params(30)*K_OVER_L__^(1-params(5)))^(-1);
I_OVER_K__ = 1-(1-params(6));
K_OVER_Y__ = Y_OVER_K__^(-1);
I_OVER_Y__ = I_OVER_K__/Y_OVER_K__;
C_OVER_Y__ = 1-I_OVER_Y__-params(9);
S_OVER_Y__ = params(4)/Y_OVER_K__;
N_OVER_Y__ = 1/(1-R_SS__*params(12))*(S_OVER_Y__+params(12)*(params(38)-R_SS__)/Y_OVER_K__);
N_e_OVER_Y__ = N_OVER_Y__-S_OVER_Y__;
LEV_SS__ = (Y_OVER_K__*N_OVER_Y__)^(-1);
Z_SS__ = R_SS__+(params(38)-R_SS__)*LEV_SS__;
X_SS__ = Z_SS__;
NU_SS__ = (params(38)-R_SS__)*BETABAR__*(1-params(12))/(1-params(1)*params(12)*X_SS__);
T148 = BETABAR__*(1-params(12))/NU_SS__;
T156 = (params(38)-R_SS__)*T148;
T168 = 1/Z_SS__;
T242 = 1/(params(13)/(1-params(13)));
T255 = 1/(1+BETABAR__);
T334 = (1-params(17))*T255*(1-BETABAR__*params(17))/(params(17)*(1+params(2)*params(8)));
T462 = 1/(1+BETABAR__*params(16));
T471 = (1-params(15))*(1-BETABAR__*params(15))/params(15);
lhs =(1-HBAR__)*y(83);
rhs =HBAR__*y(23)-y(72);
residual(1)= lhs-rhs;
lhs =y(75);
rhs =y(83)-y(26);
residual(2)= lhs-rhs;
residual(3) = y(100)+y(89);
lhs =y(88);
rhs =params(2)*y(76)-y(83);
residual(4)= lhs-rhs;
lhs =y(78);
rhs =params(1)*params(12)*X_SS__*(y(100)+y(80)+y(102))+T148*(params(38)*y(79)-R_SS__*y(29))+y(100)*T156;
residual(5)= lhs-rhs;
lhs =y(77);
rhs =Z_SS__*params(1)*params(12)*(y(100)+y(81)+y(101));
residual(6)= lhs-rhs;
lhs =y(81);
rhs =T168*(y(79)*params(38)*LEV_SS__+y(29)*R_SS__*(1-LEV_SS__)+(params(38)-R_SS__)*LEV_SS__*y(24));
residual(7)= lhs-rhs;
lhs =y(80);
rhs =y(81)+y(73)-y(24);
residual(8)= lhs-rhs;
lhs =y(73);
rhs =y(101)+y(102)*NU_SS__/(params(11)-NU_SS__);
residual(9)= lhs-rhs;
lhs =y(85);
rhs =y(81)+y(27);
residual(10)= lhs-rhs;
lhs =y(104)+y(74);
rhs =y(73)+y(84);
residual(11)= lhs-rhs;
lhs =y(84);
rhs =y(85)*N_e_OVER_Y__/N_OVER_Y__+S_OVER_Y__/N_OVER_Y__*y(82);
residual(12)= lhs-rhs;
lhs =y(82);
rhs =y(74)+y(86);
residual(13)= lhs-rhs;
lhs =y(71);
rhs =y(103)-y(89);
residual(14)= lhs-rhs;
lhs =y(69);
rhs =params(30)*(y(62)+params(5)*(y(28)+y(66))+params(5)*y(87)+(1-params(5))*y(76));
residual(15)= lhs-rhs;
lhs =y(79);
rhs =ZK_SS__/params(38)*y(90)+(1-params(6))/params(38)*(y(74)+y(66))-y(25);
residual(16)= lhs-rhs;
lhs =y(87);
rhs =y(90)*T242;
residual(17)= lhs-rhs;
lhs =y(62);
rhs =params(5)*y(90)+(1-params(5))*y(88);
residual(18)= lhs-rhs;
lhs =y(90);
rhs =y(88)+y(76)-y(28)-y(87);
residual(19)= lhs-rhs;
lhs =y(70);
rhs =T255*(y(22)+BETABAR__*y(99)+1/params(14)*(y(74)+y(51)));
residual(20)= lhs-rhs;
lhs =y(86);
rhs =(1-params(6))*(y(28)+y(66))+params(6)*y(70)+y(51)*I_OVER_K__*params(14);
residual(21)= lhs-rhs;
lhs =y(69);
rhs =y(72)*C_OVER_Y__+I_OVER_Y__*y(70)+params(9)*y(60)+y(87)*ZK_SS__*K_OVER_Y__;
residual(22)= lhs-rhs;
lhs =(1-HBAR__)*y(54);
rhs =HBAR__*y(6)-y(43);
residual(23)= lhs-rhs;
lhs =y(46);
rhs =y(54)-y(10);
residual(24)= lhs-rhs;
residual(25) = y(93)+y(61)-y(92);
lhs =y(59);
rhs =T255*y(13)+BETABAR__/(1+BETABAR__)*y(98)+params(18)/(1+BETABAR__)*y(5)-(1+BETABAR__*params(18))/(1+BETABAR__)*y(42)+y(92)*BETABAR__/(1+BETABAR__)+T334*(params(2)*y(47)+y(43)*1/(1-HBAR__)-y(6)*HBAR__/(1-HBAR__)-y(59))+y(65);
residual(26)= lhs-rhs;
lhs =y(49);
rhs =params(1)*params(12)*X_SS__*(y(93)+y(63)+y(95))+T148*(params(38)*y(50)-R_SS__*(y(15)-y(42)))+T156*y(93);
residual(27)= lhs-rhs;
lhs =y(48);
rhs =Z_SS__*params(1)*params(12)*(y(93)+y(52)+y(94));
residual(28)= lhs-rhs;
lhs =y(52);
rhs =T168*(params(38)*LEV_SS__*y(50)+R_SS__*(1-LEV_SS__)*(y(15)-y(42))+(params(38)-R_SS__)*LEV_SS__*y(7));
residual(29)= lhs-rhs;
lhs =y(63);
rhs =y(52)+y(44)-y(7);
residual(30)= lhs-rhs;
lhs =y(44);
rhs =y(94)+NU_SS__/(params(11)-NU_SS__)*y(95);
residual(31)= lhs-rhs;
lhs =y(56);
rhs =y(52)+y(11);
residual(32)= lhs-rhs;
lhs =y(97)+y(45);
rhs =y(44)+y(55);
residual(33)= lhs-rhs;
lhs =y(55);
rhs =N_e_OVER_Y__/N_OVER_Y__*y(56)+S_OVER_Y__/N_OVER_Y__*y(53);
residual(34)= lhs-rhs;
lhs =y(53);
rhs =y(45)+y(57);
residual(35)= lhs-rhs;
lhs =y(41);
rhs =y(96)-(y(61)-y(92));
residual(36)= lhs-rhs;
lhs =y(39);
rhs =params(30)*(y(62)+params(5)*(y(66)+y(12))+params(5)*y(58)+(1-params(5))*y(47));
residual(37)= lhs-rhs;
lhs =y(50);
rhs =ZK_SS__/params(38)*y(67)+(1-params(6))/params(38)*(y(66)+y(45))-y(8);
residual(38)= lhs-rhs;
lhs =y(58);
rhs =T242*y(67);
residual(39)= lhs-rhs;
lhs =y(67);
rhs =y(59)+y(47)-y(12)-y(58);
residual(40)= lhs-rhs;
lhs =y(40);
rhs =T255*(y(4)+BETABAR__*y(91)+1/params(14)*(y(51)+y(45)));
residual(41)= lhs-rhs;
lhs =y(57);
rhs =y(51)*I_OVER_K__*params(14)+(1-params(6))*(y(66)+y(12))+params(6)*y(40);
residual(42)= lhs-rhs;
lhs =y(39);
rhs =params(9)*y(60)+C_OVER_Y__*y(43)+I_OVER_Y__*y(40)+ZK_SS__*K_OVER_Y__*y(58);
residual(43)= lhs-rhs;
lhs =y(42);
rhs =T462*(BETABAR__*y(92)+y(5)*params(16)+T471*(params(5)*y(67)-y(62)+(1-params(5))*y(59)))+y(64);
residual(44)= lhs-rhs;
lhs =y(61);
rhs =y(15)*params(21)+(1-params(21))*(y(42)*params(22)+params(23)*(y(39)-y(69)))+params(32)*(y(39)-y(69)-y(3)+y(21))+params(33)*(y(42)-y(5))+y(68);
residual(45)= lhs-rhs;
lhs =y(62);
rhs =params(24)*y(16)-x(it_, 5);
residual(46)= lhs-rhs;
lhs =y(51);
rhs =params(26)*y(9)-x(it_, 1);
residual(47)= lhs-rhs;
lhs =y(60);
rhs =params(25)*y(14)-x(it_, 4);
residual(48)= lhs-rhs;
lhs =y(68);
rhs =params(37)*y(20)+x(it_, 2);
residual(49)= lhs-rhs;
lhs =y(64);
rhs =params(29)*y(17)+y(38)-params(35)*y(2);
residual(50)= lhs-rhs;
lhs =y(38);
rhs =x(it_, 7);
residual(51)= lhs-rhs;
lhs =y(65);
rhs =params(28)*y(18)+y(37)-params(34)*y(1);
residual(52)= lhs-rhs;
lhs =y(37);
rhs =x(it_, 6);
residual(53)= lhs-rhs;
lhs =y(66);
rhs =params(27)*y(19)-x(it_, 3);
residual(54)= lhs-rhs;
lhs =y(33);
rhs =params(41)+y(39)-y(3);
residual(55)= lhs-rhs;
lhs =y(34);
rhs =params(41)+y(43)-y(6);
residual(56)= lhs-rhs;
lhs =y(35);
rhs =params(41)+y(40)-y(4);
residual(57)= lhs-rhs;
lhs =y(36);
rhs =params(41)+y(59)-y(13);
residual(58)= lhs-rhs;
lhs =y(32);
rhs =params(40)+y(42);
residual(59)= lhs-rhs;
lhs =y(31);
rhs =y(61)+conster__;
residual(60)= lhs-rhs;
lhs =y(30);
rhs =y(47)+params(39);
residual(61)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(61, 111);

  %
  % Jacobian matrix
  %

T625 = (-((1-params(6))/params(38)));
T627 = (-(T255*1/params(14)));
  g1(1,23)=(-HBAR__);
  g1(1,72)=1;
  g1(1,83)=1-HBAR__;
  g1(2,75)=1;
  g1(2,26)=1;
  g1(2,83)=(-1);
  g1(3,100)=1;
  g1(3,89)=1;
  g1(4,76)=(-params(2));
  g1(4,83)=1;
  g1(4,88)=1;
  g1(5,100)=(-(params(1)*params(12)*X_SS__+T156));
  g1(5,78)=1;
  g1(5,102)=(-(params(1)*params(12)*X_SS__));
  g1(5,79)=(-(params(38)*T148));
  g1(5,80)=(-(params(1)*params(12)*X_SS__));
  g1(5,29)=(-(T148*(-R_SS__)));
  g1(6,100)=(-(Z_SS__*params(1)*params(12)));
  g1(6,77)=1;
  g1(6,101)=(-(Z_SS__*params(1)*params(12)));
  g1(6,81)=(-(Z_SS__*params(1)*params(12)));
  g1(7,24)=(-((params(38)-R_SS__)*LEV_SS__*T168));
  g1(7,79)=(-(T168*params(38)*LEV_SS__));
  g1(7,81)=1;
  g1(7,29)=(-(T168*R_SS__*(1-LEV_SS__)));
  g1(8,24)=1;
  g1(8,73)=(-1);
  g1(8,80)=1;
  g1(8,81)=(-1);
  g1(9,73)=1;
  g1(9,101)=(-1);
  g1(9,102)=(-(NU_SS__/(params(11)-NU_SS__)));
  g1(10,81)=(-1);
  g1(10,27)=(-1);
  g1(10,85)=1;
  g1(11,73)=(-1);
  g1(11,74)=1;
  g1(11,84)=(-1);
  g1(11,104)=1;
  g1(12,82)=(-(S_OVER_Y__/N_OVER_Y__));
  g1(12,84)=1;
  g1(12,85)=(-(N_e_OVER_Y__/N_OVER_Y__));
  g1(13,74)=(-1);
  g1(13,82)=1;
  g1(13,86)=(-1);
  g1(14,71)=1;
  g1(14,103)=(-1);
  g1(14,89)=1;
  g1(15,62)=(-params(30));
  g1(15,66)=(-(params(5)*params(30)));
  g1(15,69)=1;
  g1(15,76)=(-((1-params(5))*params(30)));
  g1(15,28)=(-(params(5)*params(30)));
  g1(15,87)=(-(params(5)*params(30)));
  g1(16,66)=T625;
  g1(16,25)=1;
  g1(16,74)=T625;
  g1(16,79)=1;
  g1(16,90)=(-(ZK_SS__/params(38)));
  g1(17,87)=1;
  g1(17,90)=(-T242);
  g1(18,62)=1;
  g1(18,88)=(-(1-params(5)));
  g1(18,90)=(-params(5));
  g1(19,76)=(-1);
  g1(19,28)=1;
  g1(19,87)=1;
  g1(19,88)=(-1);
  g1(19,90)=1;
  g1(20,51)=T627;
  g1(20,22)=(-T255);
  g1(20,70)=1;
  g1(20,99)=(-(BETABAR__*T255));
  g1(20,74)=T627;
  g1(21,51)=(-(I_OVER_K__*params(14)));
  g1(21,66)=(-(1-params(6)));
  g1(21,70)=(-params(6));
  g1(21,28)=(-(1-params(6)));
  g1(21,86)=1;
  g1(22,60)=(-params(9));
  g1(22,69)=1;
  g1(22,70)=(-I_OVER_Y__);
  g1(22,72)=(-C_OVER_Y__);
  g1(22,87)=(-(ZK_SS__*K_OVER_Y__));
  g1(23,6)=(-HBAR__);
  g1(23,43)=1;
  g1(23,54)=1-HBAR__;
  g1(24,46)=1;
  g1(24,10)=1;
  g1(24,54)=(-1);
  g1(25,92)=(-1);
  g1(25,93)=1;
  g1(25,61)=1;
  g1(26,5)=(-(params(18)/(1+BETABAR__)));
  g1(26,42)=(1+BETABAR__*params(18))/(1+BETABAR__);
  g1(26,92)=(-(BETABAR__/(1+BETABAR__)));
  g1(26,6)=(-(T334*(-(HBAR__/(1-HBAR__)))));
  g1(26,43)=(-(T334*1/(1-HBAR__)));
  g1(26,47)=(-(params(2)*T334));
  g1(26,13)=(-T255);
  g1(26,59)=1-(-T334);
  g1(26,98)=(-(BETABAR__/(1+BETABAR__)));
  g1(26,65)=(-1);
  g1(27,42)=(-(R_SS__*T148));
  g1(27,93)=(-(params(1)*params(12)*X_SS__+T156));
  g1(27,49)=1;
  g1(27,95)=(-(params(1)*params(12)*X_SS__));
  g1(27,50)=(-(params(38)*T148));
  g1(27,15)=(-(T148*(-R_SS__)));
  g1(27,63)=(-(params(1)*params(12)*X_SS__));
  g1(28,93)=(-(Z_SS__*params(1)*params(12)));
  g1(28,48)=1;
  g1(28,94)=(-(Z_SS__*params(1)*params(12)));
  g1(28,52)=(-(Z_SS__*params(1)*params(12)));
  g1(29,42)=(-(T168*(-(R_SS__*(1-LEV_SS__)))));
  g1(29,7)=(-((params(38)-R_SS__)*LEV_SS__*T168));
  g1(29,50)=(-(T168*params(38)*LEV_SS__));
  g1(29,52)=1;
  g1(29,15)=(-(T168*R_SS__*(1-LEV_SS__)));
  g1(30,7)=1;
  g1(30,44)=(-1);
  g1(30,52)=(-1);
  g1(30,63)=1;
  g1(31,44)=1;
  g1(31,94)=(-1);
  g1(31,95)=(-(NU_SS__/(params(11)-NU_SS__)));
  g1(32,52)=(-1);
  g1(32,11)=(-1);
  g1(32,56)=1;
  g1(33,44)=(-1);
  g1(33,45)=1;
  g1(33,55)=(-1);
  g1(33,97)=1;
  g1(34,53)=(-(S_OVER_Y__/N_OVER_Y__));
  g1(34,55)=1;
  g1(34,56)=(-(N_e_OVER_Y__/N_OVER_Y__));
  g1(35,45)=(-1);
  g1(35,53)=1;
  g1(35,57)=(-1);
  g1(36,41)=1;
  g1(36,92)=(-1);
  g1(36,96)=(-1);
  g1(36,61)=1;
  g1(37,39)=1;
  g1(37,47)=(-((1-params(5))*params(30)));
  g1(37,12)=(-(params(5)*params(30)));
  g1(37,58)=(-(params(5)*params(30)));
  g1(37,62)=(-params(30));
  g1(37,66)=(-(params(5)*params(30)));
  g1(38,8)=1;
  g1(38,45)=T625;
  g1(38,50)=1;
  g1(38,66)=T625;
  g1(38,67)=(-(ZK_SS__/params(38)));
  g1(39,58)=1;
  g1(39,67)=(-T242);
  g1(40,47)=(-1);
  g1(40,12)=1;
  g1(40,58)=1;
  g1(40,59)=(-1);
  g1(40,67)=1;
  g1(41,4)=(-T255);
  g1(41,40)=1;
  g1(41,91)=(-(BETABAR__*T255));
  g1(41,45)=T627;
  g1(41,51)=T627;
  g1(42,40)=(-params(6));
  g1(42,51)=(-(I_OVER_K__*params(14)));
  g1(42,12)=(-(1-params(6)));
  g1(42,57)=1;
  g1(42,66)=(-(1-params(6)));
  g1(43,39)=1;
  g1(43,40)=(-I_OVER_Y__);
  g1(43,43)=(-C_OVER_Y__);
  g1(43,58)=(-(ZK_SS__*K_OVER_Y__));
  g1(43,60)=(-params(9));
  g1(44,5)=(-(params(16)*T462));
  g1(44,42)=1;
  g1(44,92)=(-(BETABAR__*T462));
  g1(44,59)=(-(T462*(1-params(5))*T471));
  g1(44,62)=(-(T462*(-T471)));
  g1(44,64)=(-1);
  g1(44,67)=(-(T462*params(5)*T471));
  g1(45,3)=params(32);
  g1(45,39)=(-(params(32)+(1-params(21))*params(23)));
  g1(45,5)=params(33);
  g1(45,42)=(-(params(33)+(1-params(21))*params(22)));
  g1(45,15)=(-params(21));
  g1(45,61)=1;
  g1(45,68)=(-1);
  g1(45,21)=(-params(32));
  g1(45,69)=(-((1-params(21))*(-params(23))-params(32)));
  g1(46,16)=(-params(24));
  g1(46,62)=1;
  g1(46,109)=1;
  g1(47,9)=(-params(26));
  g1(47,51)=1;
  g1(47,105)=1;
  g1(48,14)=(-params(25));
  g1(48,60)=1;
  g1(48,108)=1;
  g1(49,20)=(-params(37));
  g1(49,68)=1;
  g1(49,106)=(-1);
  g1(50,2)=params(35);
  g1(50,38)=(-1);
  g1(50,17)=(-params(29));
  g1(50,64)=1;
  g1(51,38)=1;
  g1(51,111)=(-1);
  g1(52,1)=params(34);
  g1(52,37)=(-1);
  g1(52,18)=(-params(28));
  g1(52,65)=1;
  g1(53,37)=1;
  g1(53,110)=(-1);
  g1(54,19)=(-params(27));
  g1(54,66)=1;
  g1(54,107)=1;
  g1(55,33)=1;
  g1(55,3)=1;
  g1(55,39)=(-1);
  g1(56,34)=1;
  g1(56,6)=1;
  g1(56,43)=(-1);
  g1(57,35)=1;
  g1(57,4)=1;
  g1(57,40)=(-1);
  g1(58,36)=1;
  g1(58,13)=1;
  g1(58,59)=(-1);
  g1(59,32)=1;
  g1(59,42)=(-1);
  g1(60,31)=1;
  g1(60,61)=(-1);
  g1(61,30)=1;
  g1(61,47)=(-1);

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],61,12321);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],61,1367631);
end
end
end
end
