function [residual, g1, g2, g3] = SW07_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(40, 1);
cpie__ = 1+params(5)/100;
cgamma__ = 1+params(38)/100;
cbeta__ = 1/(1+params(6)/100);
clandap__ = params(17);
cbetabar__ = cbeta__*cgamma__^(-params(13));
cr__ = cpie__/(cbeta__*cgamma__^(-params(13)));
crk__ = cbeta__^(-1)*cgamma__^params(13)-(1-params(12));
cw__ = (params(9)^params(9)*(1-params(9))^(1-params(9))/(clandap__*crk__^params(9)))^(1/(1-params(9)));
cikbar__ = 1-(1-params(12))/cgamma__;
cik__ = cgamma__*(1-(1-params(12))/cgamma__);
clk__ = (1-params(9))/params(9)*crk__/cw__;
cky__ = params(17)*clk__^(params(9)-1);
ciy__ = cik__*cky__;
ccy__ = 1-params(39)-cik__*cky__;
crkky__ = crk__*cky__;
cwhlc__ = cky__*crk__*(1-params(9))*1/params(23)/params(9)/ccy__;
conster__ = 100*(cr__-1);
T87 = 1/(params(10)/(1-params(10)));
T102 = 1/(1+cgamma__*cbetabar__);
T107 = cgamma__^2;
T109 = T107*params(11);
T122 = params(14)/cgamma__;
T126 = (1-T122)/(params(13)*(1+T122));
T135 = (1-params(12))/(1-params(12)+crk__);
T151 = (params(13)-1)*cwhlc__/(params(13)*(1+T122));
T179 = 1/(1-T122);
T182 = T122/(1-T122);
T271 = 1/(1+cgamma__*cbetabar__*params(20));
T286 = (1-params(21))*(1-cgamma__*cbetabar__*params(21))/params(21)/(1+(params(17)-1)*params(3));
T295 = cgamma__*cbetabar__/(1+cgamma__*cbetabar__);
T322 = (1-params(19))*(1-cgamma__*cbetabar__*params(19))/((1+cgamma__*cbetabar__)*params(19))*1/(1+(params(23)-1)*params(1));
lhs =y(52);
rhs =params(9)*y(31)+(1-params(9))*y(38);
residual(1)= lhs-rhs;
lhs =y(30);
rhs =y(31)*T87;
residual(2)= lhs-rhs;
lhs =y(31);
rhs =y(38)+y(37)-y(32);
residual(3)= lhs-rhs;
lhs =y(32);
rhs =y(30)+y(19);
residual(4)= lhs-rhs;
lhs =y(35);
rhs =T102*(y(4)+cgamma__*cbetabar__*y(64)+1/T109*y(33))+y(55);
residual(5)= lhs-rhs;
lhs =y(33);
rhs =(-y(39))+y(53)*1/T126+crk__/(1-params(12)+crk__)*y(61)+T135*y(62);
residual(6)= lhs-rhs;
lhs =y(34);
rhs =y(53)+T122/(1+T122)*y(3)+1/(1+T122)*y(63)+T151*(y(37)-y(65))-y(39)*T126;
residual(7)= lhs-rhs;
lhs =y(36);
rhs =ccy__*y(34)+y(35)*ciy__+y(54)+y(30)*crkky__;
residual(8)= lhs-rhs;
lhs =y(36);
rhs =params(17)*(y(52)+params(9)*y(32)+(1-params(9))*y(37));
residual(9)= lhs-rhs;
lhs =y(38);
rhs =y(37)*params(22)+y(34)*T179-y(3)*T182;
residual(10)= lhs-rhs;
lhs =y(59);
rhs =y(19)*(1-cikbar__)+y(35)*cikbar__+y(55)*T109*cikbar__;
residual(11)= lhs-rhs;
lhs =y(40);
rhs =params(9)*y(42)+(1-params(9))*y(50)-y(52);
residual(12)= lhs-rhs;
lhs =y(41);
rhs =T87*y(42);
residual(13)= lhs-rhs;
lhs =y(42);
rhs =y(50)+y(48)-y(43);
residual(14)= lhs-rhs;
lhs =y(43);
rhs =y(41)+y(20);
residual(15)= lhs-rhs;
lhs =y(46);
rhs =y(55)+T102*(y(7)+cgamma__*cbetabar__*y(69)+1/T109*y(44));
residual(16)= lhs-rhs;
lhs =y(44);
rhs =y(53)*1/T126+(-y(51))+y(71)+crk__/(1-params(12)+crk__)*y(66)+T135*y(67);
residual(17)= lhs-rhs;
lhs =y(45);
rhs =y(53)+T122/(1+T122)*y(6)+1/(1+T122)*y(68)+T151*(y(48)-y(70))-T126*(y(51)-y(71));
residual(18)= lhs-rhs;
lhs =y(47);
rhs =y(54)+ccy__*y(45)+ciy__*y(46)+crkky__*y(41);
residual(19)= lhs-rhs;
lhs =y(47);
rhs =params(17)*(y(52)+params(9)*y(43)+(1-params(9))*y(48));
residual(20)= lhs-rhs;
lhs =y(49);
rhs =T271*(cgamma__*cbetabar__*y(71)+params(20)*y(9)+y(40)*T286)+y(57);
residual(21)= lhs-rhs;
lhs =y(50);
rhs =T102*y(10)+T295*y(72)+y(9)*params(18)/(1+cgamma__*cbetabar__)-y(49)*(1+cgamma__*cbetabar__*params(18))/(1+cgamma__*cbetabar__)+y(71)*T295+T322*(params(22)*y(48)+T179*y(45)-T182*y(6)-y(50))+y(58);
residual(22)= lhs-rhs;
lhs =y(51);
rhs =y(49)*params(25)*(1-params(28))+(1-params(28))*params(27)*(y(47)-y(36))+params(26)*(y(47)-y(36)-y(8)+y(5))+params(28)*y(11)+y(56);
residual(23)= lhs-rhs;
lhs =y(52);
rhs =params(29)*y(12)+x(it_, 1);
residual(24)= lhs-rhs;
lhs =y(53);
rhs =params(31)*y(13)+x(it_, 2);
residual(25)= lhs-rhs;
lhs =y(54);
rhs =params(32)*y(14)+x(it_, 3)+x(it_, 1)*params(2);
residual(26)= lhs-rhs;
lhs =y(55);
rhs =params(34)*y(15)+x(it_, 4);
residual(27)= lhs-rhs;
lhs =y(56);
rhs =params(35)*y(16)+x(it_, 5);
residual(28)= lhs-rhs;
lhs =y(57);
rhs =params(36)*y(17)+y(29)-params(8)*y(2);
residual(29)= lhs-rhs;
lhs =y(29);
rhs =x(it_, 6);
residual(30)= lhs-rhs;
lhs =y(58);
rhs =params(37)*y(18)+y(28)-params(7)*y(1);
residual(31)= lhs-rhs;
lhs =y(28);
rhs =x(it_, 7);
residual(32)= lhs-rhs;
lhs =y(60);
rhs =(1-cikbar__)*y(20)+cikbar__*y(46)+y(55)*params(11)*T107*cikbar__;
residual(33)= lhs-rhs;
lhs =y(24);
rhs =params(38)+y(47)-y(8);
residual(34)= lhs-rhs;
lhs =y(25);
rhs =params(38)+y(45)-y(6);
residual(35)= lhs-rhs;
lhs =y(26);
rhs =params(38)+y(46)-y(7);
residual(36)= lhs-rhs;
lhs =y(27);
rhs =params(38)+y(50)-y(10);
residual(37)= lhs-rhs;
lhs =y(23);
rhs =params(5)+y(49);
residual(38)= lhs-rhs;
lhs =y(22);
rhs =y(51)+conster__;
residual(39)= lhs-rhs;
lhs =y(21);
rhs =y(48)+params(4);
residual(40)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(40, 79);

  %
  % Jacobian matrix
  %

  g1(1,31)=(-params(9));
  g1(1,38)=(-(1-params(9)));
  g1(1,52)=1;
  g1(2,30)=1;
  g1(2,31)=(-T87);
  g1(3,31)=1;
  g1(3,32)=1;
  g1(3,37)=(-1);
  g1(3,38)=(-1);
  g1(4,30)=(-1);
  g1(4,32)=1;
  g1(4,19)=(-1);
  g1(5,33)=(-(T102*1/T109));
  g1(5,4)=(-T102);
  g1(5,35)=1;
  g1(5,64)=(-(cgamma__*cbetabar__*T102));
  g1(5,55)=(-1);
  g1(6,61)=(-(crk__/(1-params(12)+crk__)));
  g1(6,33)=1;
  g1(6,62)=(-T135);
  g1(6,39)=1;
  g1(6,53)=(-(1/T126));
  g1(7,3)=(-(T122/(1+T122)));
  g1(7,34)=1;
  g1(7,63)=(-(1/(1+T122)));
  g1(7,37)=(-T151);
  g1(7,65)=T151;
  g1(7,39)=T126;
  g1(7,53)=(-1);
  g1(8,30)=(-crkky__);
  g1(8,34)=(-ccy__);
  g1(8,35)=(-ciy__);
  g1(8,36)=1;
  g1(8,54)=(-1);
  g1(9,32)=(-(params(17)*params(9)));
  g1(9,36)=1;
  g1(9,37)=(-(params(17)*(1-params(9))));
  g1(9,52)=(-params(17));
  g1(10,3)=T182;
  g1(10,34)=(-T179);
  g1(10,37)=(-params(22));
  g1(10,38)=1;
  g1(11,35)=(-cikbar__);
  g1(11,55)=(-(T109*cikbar__));
  g1(11,19)=(-(1-cikbar__));
  g1(11,59)=1;
  g1(12,40)=1;
  g1(12,42)=(-params(9));
  g1(12,50)=(-(1-params(9)));
  g1(12,52)=1;
  g1(13,41)=1;
  g1(13,42)=(-T87);
  g1(14,42)=1;
  g1(14,43)=1;
  g1(14,48)=(-1);
  g1(14,50)=(-1);
  g1(15,41)=(-1);
  g1(15,43)=1;
  g1(15,20)=(-1);
  g1(16,44)=(-(T102*1/T109));
  g1(16,7)=(-T102);
  g1(16,46)=1;
  g1(16,69)=(-(cgamma__*cbetabar__*T102));
  g1(16,55)=(-1);
  g1(17,66)=(-(crk__/(1-params(12)+crk__)));
  g1(17,44)=1;
  g1(17,67)=(-T135);
  g1(17,71)=(-1);
  g1(17,51)=1;
  g1(17,53)=(-(1/T126));
  g1(18,6)=(-(T122/(1+T122)));
  g1(18,45)=1;
  g1(18,68)=(-(1/(1+T122)));
  g1(18,48)=(-T151);
  g1(18,70)=T151;
  g1(18,71)=(-T126);
  g1(18,51)=T126;
  g1(18,53)=(-1);
  g1(19,41)=(-crkky__);
  g1(19,45)=(-ccy__);
  g1(19,46)=(-ciy__);
  g1(19,47)=1;
  g1(19,54)=(-1);
  g1(20,43)=(-(params(17)*params(9)));
  g1(20,47)=1;
  g1(20,48)=(-(params(17)*(1-params(9))));
  g1(20,52)=(-params(17));
  g1(21,40)=(-(T271*T286));
  g1(21,9)=(-(params(20)*T271));
  g1(21,49)=1;
  g1(21,71)=(-(cgamma__*cbetabar__*T271));
  g1(21,57)=(-1);
  g1(22,6)=(-(T322*(-T182)));
  g1(22,45)=(-(T179*T322));
  g1(22,48)=(-(params(22)*T322));
  g1(22,9)=(-(params(18)/(1+cgamma__*cbetabar__)));
  g1(22,49)=(1+cgamma__*cbetabar__*params(18))/(1+cgamma__*cbetabar__);
  g1(22,71)=(-T295);
  g1(22,10)=(-T102);
  g1(22,50)=1-(-T322);
  g1(22,72)=(-T295);
  g1(22,58)=(-1);
  g1(23,5)=(-params(26));
  g1(23,36)=(-((-((1-params(28))*params(27)))-params(26)));
  g1(23,8)=params(26);
  g1(23,47)=(-((1-params(28))*params(27)+params(26)));
  g1(23,49)=(-(params(25)*(1-params(28))));
  g1(23,11)=(-params(28));
  g1(23,51)=1;
  g1(23,56)=(-1);
  g1(24,12)=(-params(29));
  g1(24,52)=1;
  g1(24,73)=(-1);
  g1(25,13)=(-params(31));
  g1(25,53)=1;
  g1(25,74)=(-1);
  g1(26,14)=(-params(32));
  g1(26,54)=1;
  g1(26,73)=(-params(2));
  g1(26,75)=(-1);
  g1(27,15)=(-params(34));
  g1(27,55)=1;
  g1(27,76)=(-1);
  g1(28,16)=(-params(35));
  g1(28,56)=1;
  g1(28,77)=(-1);
  g1(29,2)=params(8);
  g1(29,29)=(-1);
  g1(29,17)=(-params(36));
  g1(29,57)=1;
  g1(30,29)=1;
  g1(30,78)=(-1);
  g1(31,1)=params(7);
  g1(31,28)=(-1);
  g1(31,18)=(-params(37));
  g1(31,58)=1;
  g1(32,28)=1;
  g1(32,79)=(-1);
  g1(33,46)=(-cikbar__);
  g1(33,55)=(-(params(11)*T107*cikbar__));
  g1(33,20)=(-(1-cikbar__));
  g1(33,60)=1;
  g1(34,24)=1;
  g1(34,8)=1;
  g1(34,47)=(-1);
  g1(35,25)=1;
  g1(35,6)=1;
  g1(35,45)=(-1);
  g1(36,26)=1;
  g1(36,7)=1;
  g1(36,46)=(-1);
  g1(37,27)=1;
  g1(37,10)=1;
  g1(37,50)=(-1);
  g1(38,23)=1;
  g1(38,49)=(-1);
  g1(39,22)=1;
  g1(39,51)=(-1);
  g1(40,21)=1;
  g1(40,48)=(-1);

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],40,6241);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],40,493039);
end
end
end
end
