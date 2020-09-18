function [residual, g1, g2, g3] = GSW12_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(51, 1);
clandap__ = params(13);
cgamma__ = 1+params(31)/100;
cpie__ = 1+params(3)/100;
cbeta__ = 1/(1+params(4)/100);
cbetabar__ = cbeta__*cgamma__^(-params(11));
cr__ = 100*(cpie__/cbetabar__-1);
crk__ = 1/cbetabar__-(1-params(10));
cw__ = (params(7)^params(7)*(1-params(7))^(1-params(7))/(clandap__*crk__^params(7)))^(1/(1-params(7)));
cik__ = cgamma__+params(10)-1;
clk__ = (1-params(7))/params(7)*crk__/cw__;
cky__ = params(13)*clk__^(params(7)-1);
ciy__ = cik__*cky__;
ccy__ = 1-params(32)-ciy__;
crkky__ = crk__*cky__;
whlcstar__ = (1-params(7))/(params(19)*ccy__);
cikbar__ = 1-(1-params(10))/cgamma__;
T86 = params(12)/cgamma__;
T89 = 1-T86;
T92 = params(11)*(1+T86)/T89*y(60);
T100 = params(11)*params(12)/cgamma__/T89;
T114 = 1/(1+cgamma__*cbetabar__);
T119 = cgamma__^2;
T121 = T119*params(9);
T132 = 1/(T89/(params(11)*(1+T86)));
T133 = y(60)*T132;
T140 = (1-params(10))/(1-params(10)+crk__);
T161 = 1/(params(8)/(1-params(8)));
T188 = params(33)/T89;
T197 = 1/T89;
T215 = (1-cbeta__*params(34))*(1-params(34))/params(34);
T300 = 1/(1+cgamma__*cbetabar__*params(16));
T315 = (1-params(17))*(1-cgamma__*cbetabar__*params(17))/params(17)/(1+(params(13)-1)*params(2));
T352 = params(18)*(1-cgamma__*cbetabar__*params(15))*(1-params(15))/((1+cgamma__*cbetabar__)*params(15)*params(19)*params(18)/(params(19)-1));
T404 = params(18)*(1-params(15))*(1+cgamma__*cbetabar__)*params(15)*params(19)*params(18)/(params(19)-1)/(1-cgamma__*cbetabar__*params(15));
lhs =y(45);
rhs =params(13)*(params(7)*y(54)+(1-params(7))*y(51)+y(62));
residual(1)= lhs-rhs;
lhs =y(49);
rhs =y(85)+y(50)-T92;
residual(2)= lhs-rhs;
lhs =y(49);
rhs =(-params(11))/T89*y(46)+T100*y(11)+y(51)*(params(11)-1)*whlcstar__/T89;
residual(3)= lhs-rhs;
lhs =y(47);
rhs =T114*(y(12)+cgamma__*cbetabar__*y(84)+1/T121*y(52))+y(61);
residual(4)= lhs-rhs;
lhs =y(52);
rhs =(-y(50))+T133+crk__/(1-params(10)+crk__)*y(87)+T140*y(86);
residual(5)= lhs-rhs;
lhs =y(45);
rhs =ccy__*y(46)+ciy__*y(47)+y(59)+crkky__*y(48);
residual(6)= lhs-rhs;
lhs =y(54);
rhs =y(48)+y(13);
residual(7)= lhs-rhs;
lhs =y(48);
rhs =T161*y(53);
residual(8)= lhs-rhs;
lhs =y(55);
rhs =y(13)*(1-cikbar__)+y(47)*cikbar__+y(61)*T121*cikbar__;
residual(9)= lhs-rhs;
lhs =y(62);
rhs =params(7)*y(53)+(1-params(7))*y(56);
residual(10)= lhs-rhs;
lhs =y(53);
rhs =y(51)+y(56)-y(54);
residual(11)= lhs-rhs;
lhs =y(57);
rhs =(1-params(33))*y(14)+T188*(y(46)-T86*y(11));
residual(12)= lhs-rhs;
lhs =y(56);
rhs =y(57)+y(51)*params(18)-(y(46)-T86*y(11))*T197-y(49)+y(68);
residual(13)= lhs-rhs;
lhs =y(58);
rhs =cbeta__*(y(88)-y(58))+y(15)+T215*(y(51)-y(58));
residual(14)= lhs-rhs;
lhs =y(26);
rhs =y(59)+ccy__*y(27)+ciy__*y(28)+crkky__*y(29);
residual(15)= lhs-rhs;
lhs =y(30);
rhs =y(78)+y(31)-y(79)-T92;
residual(16)= lhs-rhs;
lhs =y(30);
rhs =(-params(11))/T89*y(27)+T100*y(2)+(params(11)-1)*whlcstar__/T89*y(33);
residual(17)= lhs-rhs;
lhs =y(28);
rhs =y(61)+T114*(y(3)+cgamma__*cbetabar__*y(77)+1/T121*y(34));
residual(18)= lhs-rhs;
lhs =y(34);
rhs =T140*y(80)+crk__/(1-params(10)+crk__)*y(81)+T133+y(79)-y(31);
residual(19)= lhs-rhs;
lhs =y(26);
rhs =params(13)*(y(62)+params(7)*y(36)+(1-params(7))*y(33));
residual(20)= lhs-rhs;
lhs =y(36);
rhs =y(29)+y(6);
residual(21)= lhs-rhs;
lhs =y(29);
rhs =T161*y(35);
residual(22)= lhs-rhs;
lhs =y(37);
rhs =(1-cikbar__)*y(6)+cikbar__*y(28)+y(61)*params(9)*T119*cikbar__;
residual(23)= lhs-rhs;
lhs =y(38);
rhs =params(7)*y(35)+(1-params(7))*y(39)-y(62);
residual(24)= lhs-rhs;
lhs =y(32);
rhs =T300*(cgamma__*cbetabar__*y(79)+params(16)*y(5)+y(38)*T315)+y(63);
residual(25)= lhs-rhs;
lhs =y(35);
rhs =y(33)+y(39)-y(36);
residual(26)= lhs-rhs;
lhs =y(39);
rhs =T114*y(7)+cgamma__*cbetabar__/(1+cgamma__*cbetabar__)*(y(79)+y(82))-y(32)*(1+cgamma__*cbetabar__*params(14))/(1+cgamma__*cbetabar__)+y(5)*params(14)/(1+cgamma__*cbetabar__)-T352*y(40)+y(65);
residual(27)= lhs-rhs;
lhs =y(31);
rhs =y(32)*params(20)*(1-params(23))+(1-params(23))*params(22)*(y(26)-y(45))+params(21)*(y(26)-y(45)-y(1)+y(10))+params(23)*y(4)+y(67);
residual(28)= lhs-rhs;
lhs =y(41);
rhs =(1-params(33))*y(8)+T188*(y(27)-T86*y(2));
residual(29)= lhs-rhs;
lhs =y(39);
rhs =y(68)+y(41)+params(18)*y(42)-T197*(y(27)-T86*y(2))-y(30);
residual(30)= lhs-rhs;
lhs =y(40);
rhs =y(42)-y(44);
residual(31)= lhs-rhs;
lhs =y(43);
rhs =y(65)*T404;
residual(32)= lhs-rhs;
lhs =y(44);
rhs =cbeta__*(y(83)-y(44))+y(9)+T215*(y(33)-y(44));
residual(33)= lhs-rhs;
lhs =y(62);
rhs =params(24)*y(19)+x(it_, 1);
residual(34)= lhs-rhs;
lhs =y(60);
rhs =params(25)*y(17)+x(it_, 2);
residual(35)= lhs-rhs;
lhs =y(59);
rhs =params(26)*y(16)+x(it_, 3)+x(it_, 1)*params(1);
residual(36)= lhs-rhs;
lhs =y(61);
rhs =params(27)*y(18)+x(it_, 4);
residual(37)= lhs-rhs;
lhs =y(67);
rhs =params(28)*y(24)+x(it_, 5);
residual(38)= lhs-rhs;
lhs =y(63);
rhs =params(29)*y(20)+y(64)-params(6)*y(21);
residual(39)= lhs-rhs;
lhs =y(64);
rhs =x(it_, 6);
residual(40)= lhs-rhs;
lhs =y(65);
rhs =params(30)*y(22)+y(66)-params(5)*y(23);
residual(41)= lhs-rhs;
lhs =y(66);
rhs =x(it_, 7);
residual(42)= lhs-rhs;
lhs =y(68);
rhs =params(35)*y(25)+x(it_, 8);
residual(43)= lhs-rhs;
lhs =y(71);
rhs =params(31)+y(26)-y(1)+params(36);
residual(44)= lhs-rhs;
lhs =y(72);
rhs =params(36)+params(31)+y(27)-y(2);
residual(45)= lhs-rhs;
lhs =y(73);
rhs =params(36)+params(31)+y(28)-y(3);
residual(46)= lhs-rhs;
lhs =y(74);
rhs =params(31)+y(39)-y(7);
residual(47)= lhs-rhs;
lhs =y(70);
rhs =params(3)+y(32);
residual(48)= lhs-rhs;
lhs =y(69);
rhs =y(31)+4*cr__;
residual(49)= lhs-rhs;
lhs =y(75);
rhs =params(36)+y(44)-y(9);
residual(50)= lhs-rhs;
lhs =y(76);
rhs =y(40)+100*(params(19)-1)/params(18);
residual(51)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(51, 96);

  %
  % Jacobian matrix
  %

  g1(1,45)=1;
  g1(1,51)=(-(params(13)*(1-params(7))));
  g1(1,54)=(-(params(13)*params(7)));
  g1(1,62)=(-params(13));
  g1(2,49)=1;
  g1(2,85)=(-1);
  g1(2,50)=(-1);
  g1(2,60)=params(11)*(1+T86)/T89;
  g1(3,11)=(-T100);
  g1(3,46)=(-((-params(11))/T89));
  g1(3,49)=1;
  g1(3,51)=(-((params(11)-1)*whlcstar__/T89));
  g1(4,12)=(-T114);
  g1(4,47)=1;
  g1(4,84)=(-(cgamma__*cbetabar__*T114));
  g1(4,52)=(-(T114*1/T121));
  g1(4,61)=(-1);
  g1(5,50)=1;
  g1(5,52)=1;
  g1(5,86)=(-T140);
  g1(5,87)=(-(crk__/(1-params(10)+crk__)));
  g1(5,60)=(-T132);
  g1(6,45)=1;
  g1(6,46)=(-ccy__);
  g1(6,47)=(-ciy__);
  g1(6,48)=(-crkky__);
  g1(6,59)=(-1);
  g1(7,48)=(-1);
  g1(7,54)=1;
  g1(7,13)=(-1);
  g1(8,48)=1;
  g1(8,53)=(-T161);
  g1(9,47)=(-cikbar__);
  g1(9,13)=(-(1-cikbar__));
  g1(9,55)=1;
  g1(9,61)=(-(T121*cikbar__));
  g1(10,53)=(-params(7));
  g1(10,56)=(-(1-params(7)));
  g1(10,62)=1;
  g1(11,51)=(-1);
  g1(11,53)=1;
  g1(11,54)=1;
  g1(11,56)=(-1);
  g1(12,11)=(-(T188*(-T86)));
  g1(12,46)=(-T188);
  g1(12,14)=(-(1-params(33)));
  g1(12,57)=1;
  g1(13,11)=T197*(-T86);
  g1(13,46)=T197;
  g1(13,49)=1;
  g1(13,51)=(-params(18));
  g1(13,56)=1;
  g1(13,57)=(-1);
  g1(13,68)=(-1);
  g1(14,51)=(-T215);
  g1(14,15)=(-1);
  g1(14,58)=1-((-cbeta__)-T215);
  g1(14,88)=(-cbeta__);
  g1(15,26)=1;
  g1(15,27)=(-ccy__);
  g1(15,28)=(-ciy__);
  g1(15,29)=(-crkky__);
  g1(15,59)=(-1);
  g1(16,30)=1;
  g1(16,78)=(-1);
  g1(16,31)=(-1);
  g1(16,79)=1;
  g1(16,60)=params(11)*(1+T86)/T89;
  g1(17,2)=(-T100);
  g1(17,27)=(-((-params(11))/T89));
  g1(17,30)=1;
  g1(17,33)=(-((params(11)-1)*whlcstar__/T89));
  g1(18,3)=(-T114);
  g1(18,28)=1;
  g1(18,77)=(-(cgamma__*cbetabar__*T114));
  g1(18,34)=(-(T114*1/T121));
  g1(18,61)=(-1);
  g1(19,31)=1;
  g1(19,79)=(-1);
  g1(19,34)=1;
  g1(19,80)=(-T140);
  g1(19,81)=(-(crk__/(1-params(10)+crk__)));
  g1(19,60)=(-T132);
  g1(20,26)=1;
  g1(20,33)=(-(params(13)*(1-params(7))));
  g1(20,36)=(-(params(13)*params(7)));
  g1(20,62)=(-params(13));
  g1(21,29)=(-1);
  g1(21,36)=1;
  g1(21,6)=(-1);
  g1(22,29)=1;
  g1(22,35)=(-T161);
  g1(23,28)=(-cikbar__);
  g1(23,6)=(-(1-cikbar__));
  g1(23,37)=1;
  g1(23,61)=(-(params(9)*T119*cikbar__));
  g1(24,35)=(-params(7));
  g1(24,38)=1;
  g1(24,39)=(-(1-params(7)));
  g1(24,62)=1;
  g1(25,5)=(-(params(16)*T300));
  g1(25,32)=1;
  g1(25,79)=(-(cgamma__*cbetabar__*T300));
  g1(25,38)=(-(T300*T315));
  g1(25,63)=(-1);
  g1(26,33)=(-1);
  g1(26,35)=1;
  g1(26,36)=1;
  g1(26,39)=(-1);
  g1(27,5)=(-(params(14)/(1+cgamma__*cbetabar__)));
  g1(27,32)=(1+cgamma__*cbetabar__*params(14))/(1+cgamma__*cbetabar__);
  g1(27,79)=(-(cgamma__*cbetabar__/(1+cgamma__*cbetabar__)));
  g1(27,7)=(-T114);
  g1(27,39)=1;
  g1(27,82)=(-(cgamma__*cbetabar__/(1+cgamma__*cbetabar__)));
  g1(27,40)=T352;
  g1(27,65)=(-1);
  g1(28,1)=params(21);
  g1(28,26)=(-((1-params(23))*params(22)+params(21)));
  g1(28,4)=(-params(23));
  g1(28,31)=1;
  g1(28,32)=(-(params(20)*(1-params(23))));
  g1(28,10)=(-params(21));
  g1(28,45)=(-((-((1-params(23))*params(22)))-params(21)));
  g1(28,67)=(-1);
  g1(29,2)=(-(T188*(-T86)));
  g1(29,27)=(-T188);
  g1(29,8)=(-(1-params(33)));
  g1(29,41)=1;
  g1(30,2)=T197*(-T86);
  g1(30,27)=T197;
  g1(30,30)=1;
  g1(30,39)=1;
  g1(30,41)=(-1);
  g1(30,42)=(-params(18));
  g1(30,68)=(-1);
  g1(31,40)=1;
  g1(31,42)=(-1);
  g1(31,44)=1;
  g1(32,43)=1;
  g1(32,65)=(-T404);
  g1(33,33)=(-T215);
  g1(33,9)=(-1);
  g1(33,44)=1-((-cbeta__)-T215);
  g1(33,83)=(-cbeta__);
  g1(34,19)=(-params(24));
  g1(34,62)=1;
  g1(34,89)=(-1);
  g1(35,17)=(-params(25));
  g1(35,60)=1;
  g1(35,90)=(-1);
  g1(36,16)=(-params(26));
  g1(36,59)=1;
  g1(36,89)=(-params(1));
  g1(36,91)=(-1);
  g1(37,18)=(-params(27));
  g1(37,61)=1;
  g1(37,92)=(-1);
  g1(38,24)=(-params(28));
  g1(38,67)=1;
  g1(38,93)=(-1);
  g1(39,20)=(-params(29));
  g1(39,63)=1;
  g1(39,21)=params(6);
  g1(39,64)=(-1);
  g1(40,64)=1;
  g1(40,94)=(-1);
  g1(41,22)=(-params(30));
  g1(41,65)=1;
  g1(41,23)=params(5);
  g1(41,66)=(-1);
  g1(42,66)=1;
  g1(42,95)=(-1);
  g1(43,25)=(-params(35));
  g1(43,68)=1;
  g1(43,96)=(-1);
  g1(44,1)=1;
  g1(44,26)=(-1);
  g1(44,71)=1;
  g1(45,2)=1;
  g1(45,27)=(-1);
  g1(45,72)=1;
  g1(46,3)=1;
  g1(46,28)=(-1);
  g1(46,73)=1;
  g1(47,7)=1;
  g1(47,39)=(-1);
  g1(47,74)=1;
  g1(48,32)=(-1);
  g1(48,70)=1;
  g1(49,31)=(-1);
  g1(49,69)=1;
  g1(50,9)=1;
  g1(50,44)=(-1);
  g1(50,75)=1;
  g1(51,40)=(-1);
  g1(51,76)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],51,9216);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],51,884736);
end
end
end
end
