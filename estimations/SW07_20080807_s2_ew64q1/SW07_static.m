function [residual, g1, g2, g3] = SW07_static(y, x, params)
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
conster__ = 100*(cr__-1);
T87 = 1/(params(10)/(1-params(10)));
T102 = 1/(1+cgamma__*cbetabar__);
T105 = cgamma__^2;
T107 = T105*params(11);
T120 = params(14)/cgamma__;
T124 = (1-T120)/(params(13)*(1+T120));
T132 = (1-params(12))/(1-params(12)+crk__);
T249 = 1/(1+cgamma__*cbetabar__*params(20));
T263 = (1-params(21))*(1-cgamma__*cbetabar__*params(21))/params(21)/(1+(params(17)-1)*params(3));
T271 = cgamma__*cbetabar__/(1+cgamma__*cbetabar__);
T297 = (1-params(19))*(1-cgamma__*cbetabar__*params(19))/((1+cgamma__*cbetabar__)*params(19))*1/(1+(params(23)-1)*params(1));
lhs =y(32);
rhs =params(9)*y(11)+(1-params(9))*y(18);
residual(1)= lhs-rhs;
lhs =y(10);
rhs =y(11)*T87;
residual(2)= lhs-rhs;
lhs =y(11);
rhs =y(18)+y(17)-y(12);
residual(3)= lhs-rhs;
lhs =y(12);
rhs =y(10)+y(39);
residual(4)= lhs-rhs;
lhs =y(15);
rhs =T102*(y(15)+y(15)*cgamma__*cbetabar__+1/T107*y(13))+y(35);
residual(5)= lhs-rhs;
lhs =y(13);
rhs =(-y(19))+y(33)*1/T124+y(11)*crk__/(1-params(12)+crk__)+y(13)*T132;
residual(6)= lhs-rhs;
lhs =y(14);
rhs =y(33)+y(14)*T120/(1+T120)+y(14)*1/(1+T120)-y(19)*T124;
residual(7)= lhs-rhs;
lhs =y(16);
rhs =ccy__*y(14)+y(15)*ciy__+y(34)+y(10)*crkky__;
residual(8)= lhs-rhs;
lhs =y(16);
rhs =params(17)*(y(32)+params(9)*y(12)+(1-params(9))*y(17));
residual(9)= lhs-rhs;
lhs =y(18);
rhs =y(17)*params(22)+y(14)*1/(1-T120)-y(14)*T120/(1-T120);
residual(10)= lhs-rhs;
lhs =y(39);
rhs =y(39)*(1-cikbar__)+y(15)*cikbar__+y(35)*T107*cikbar__;
residual(11)= lhs-rhs;
lhs =y(20);
rhs =params(9)*y(22)+(1-params(9))*y(30)-y(32);
residual(12)= lhs-rhs;
lhs =y(21);
rhs =T87*y(22);
residual(13)= lhs-rhs;
lhs =y(22);
rhs =y(30)+y(28)-y(23);
residual(14)= lhs-rhs;
lhs =y(23);
rhs =y(21)+y(40);
residual(15)= lhs-rhs;
lhs =y(26);
rhs =y(35)+T102*(y(26)+cgamma__*cbetabar__*y(26)+1/T107*y(24));
residual(16)= lhs-rhs;
lhs =y(24);
rhs =y(33)*1/T124+(-y(31))+y(29)+crk__/(1-params(12)+crk__)*y(22)+T132*y(24);
residual(17)= lhs-rhs;
lhs =y(25);
rhs =y(33)+T120/(1+T120)*y(25)+1/(1+T120)*y(25)-T124*(y(31)-y(29));
residual(18)= lhs-rhs;
lhs =y(27);
rhs =y(34)+ccy__*y(25)+ciy__*y(26)+crkky__*y(21);
residual(19)= lhs-rhs;
lhs =y(27);
rhs =params(17)*(y(32)+params(9)*y(23)+(1-params(9))*y(28));
residual(20)= lhs-rhs;
lhs =y(29);
rhs =T249*(cgamma__*cbetabar__*y(29)+y(29)*params(20)+y(20)*T263)+y(37);
residual(21)= lhs-rhs;
lhs =y(30);
rhs =T102*y(30)+y(30)*T271+y(29)*params(18)/(1+cgamma__*cbetabar__)-y(29)*(1+cgamma__*cbetabar__*params(18))/(1+cgamma__*cbetabar__)+y(29)*T271+T297*(params(22)*y(28)+1/(1-T120)*y(25)-T120/(1-T120)*y(25)-y(30))+y(38);
residual(22)= lhs-rhs;
lhs =y(31);
rhs =y(29)*params(25)*(1-params(28))+(1-params(28))*params(27)*(y(27)-y(16))+params(26)*(y(16)+y(27)-y(16)-y(27))+y(31)*params(28)+y(36);
residual(23)= lhs-rhs;
lhs =y(32);
rhs =y(32)*params(29)+x(1);
residual(24)= lhs-rhs;
lhs =y(33);
rhs =y(33)*params(31)+x(2);
residual(25)= lhs-rhs;
lhs =y(34);
rhs =y(34)*params(32)+x(3)+x(1)*params(2);
residual(26)= lhs-rhs;
lhs =y(35);
rhs =y(35)*params(34)+x(4);
residual(27)= lhs-rhs;
lhs =y(36);
rhs =y(36)*params(35)+x(5);
residual(28)= lhs-rhs;
lhs =y(37);
rhs =y(37)*params(36)+y(9)-y(9)*params(8);
residual(29)= lhs-rhs;
lhs =y(9);
rhs =x(6);
residual(30)= lhs-rhs;
lhs =y(38);
rhs =y(38)*params(37)+y(8)-y(8)*params(7);
residual(31)= lhs-rhs;
lhs =y(8);
rhs =x(7);
residual(32)= lhs-rhs;
lhs =y(40);
rhs =(1-cikbar__)*y(40)+cikbar__*y(26)+y(35)*params(11)*T105*cikbar__;
residual(33)= lhs-rhs;
lhs =y(4);
rhs =params(38);
residual(34)= lhs-rhs;
lhs =y(5);
rhs =params(38);
residual(35)= lhs-rhs;
lhs =y(6);
rhs =params(38);
residual(36)= lhs-rhs;
lhs =y(7);
rhs =params(38);
residual(37)= lhs-rhs;
lhs =y(3);
rhs =params(5)+y(29);
residual(38)= lhs-rhs;
lhs =y(2);
rhs =y(31)+conster__;
residual(39)= lhs-rhs;
lhs =y(1);
rhs =y(28)+params(4);
residual(40)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(40, 40);

  %
  % Jacobian matrix
  %

T418 = 1-(T120/(1+T120)+1/(1+T120));
T420 = 1/(1-T120)-T120/(1-T120);
  g1(1,11)=(-params(9));
  g1(1,18)=(-(1-params(9)));
  g1(1,32)=1;
  g1(2,10)=1;
  g1(2,11)=(-T87);
  g1(3,11)=1;
  g1(3,12)=1;
  g1(3,17)=(-1);
  g1(3,18)=(-1);
  g1(4,10)=(-1);
  g1(4,12)=1;
  g1(4,39)=(-1);
  g1(5,13)=(-(T102*1/T107));
  g1(5,15)=1-(1+cgamma__*cbetabar__)*T102;
  g1(5,35)=(-1);
  g1(6,11)=(-(crk__/(1-params(12)+crk__)));
  g1(6,13)=1-T132;
  g1(6,19)=1;
  g1(6,33)=(-(1/T124));
  g1(7,14)=T418;
  g1(7,19)=T124;
  g1(7,33)=(-1);
  g1(8,10)=(-crkky__);
  g1(8,14)=(-ccy__);
  g1(8,15)=(-ciy__);
  g1(8,16)=1;
  g1(8,34)=(-1);
  g1(9,12)=(-(params(17)*params(9)));
  g1(9,16)=1;
  g1(9,17)=(-(params(17)*(1-params(9))));
  g1(9,32)=(-params(17));
  g1(10,14)=(-T420);
  g1(10,17)=(-params(22));
  g1(10,18)=1;
  g1(11,15)=(-cikbar__);
  g1(11,35)=(-(T107*cikbar__));
  g1(11,39)=1-(1-cikbar__);
  g1(12,20)=1;
  g1(12,22)=(-params(9));
  g1(12,30)=(-(1-params(9)));
  g1(12,32)=1;
  g1(13,21)=1;
  g1(13,22)=(-T87);
  g1(14,22)=1;
  g1(14,23)=1;
  g1(14,28)=(-1);
  g1(14,30)=(-1);
  g1(15,21)=(-1);
  g1(15,23)=1;
  g1(15,40)=(-1);
  g1(16,24)=(-(T102*1/T107));
  g1(16,26)=1-(1+cgamma__*cbetabar__)*T102;
  g1(16,35)=(-1);
  g1(17,22)=(-(crk__/(1-params(12)+crk__)));
  g1(17,24)=1-T132;
  g1(17,29)=(-1);
  g1(17,31)=1;
  g1(17,33)=(-(1/T124));
  g1(18,25)=T418;
  g1(18,29)=(-T124);
  g1(18,31)=T124;
  g1(18,33)=(-1);
  g1(19,21)=(-crkky__);
  g1(19,25)=(-ccy__);
  g1(19,26)=(-ciy__);
  g1(19,27)=1;
  g1(19,34)=(-1);
  g1(20,23)=(-(params(17)*params(9)));
  g1(20,27)=1;
  g1(20,28)=(-(params(17)*(1-params(9))));
  g1(20,32)=(-params(17));
  g1(21,20)=(-(T249*T263));
  g1(21,29)=1-T249*(cgamma__*cbetabar__+params(20));
  g1(21,37)=(-1);
  g1(22,25)=(-(T297*T420));
  g1(22,28)=(-(params(22)*T297));
  g1(22,29)=(-(T271+params(18)/(1+cgamma__*cbetabar__)-(1+cgamma__*cbetabar__*params(18))/(1+cgamma__*cbetabar__)));
  g1(22,30)=1-(T102+T271-T297);
  g1(22,38)=(-1);
  g1(23,16)=(1-params(28))*params(27);
  g1(23,27)=(-((1-params(28))*params(27)));
  g1(23,29)=(-(params(25)*(1-params(28))));
  g1(23,31)=1-params(28);
  g1(23,36)=(-1);
  g1(24,32)=1-params(29);
  g1(25,33)=1-params(31);
  g1(26,34)=1-params(32);
  g1(27,35)=1-params(34);
  g1(28,36)=1-params(35);
  g1(29,9)=(-(1-params(8)));
  g1(29,37)=1-params(36);
  g1(30,9)=1;
  g1(31,8)=(-(1-params(7)));
  g1(31,38)=1-params(37);
  g1(32,8)=1;
  g1(33,26)=(-cikbar__);
  g1(33,35)=(-(params(11)*T105*cikbar__));
  g1(33,40)=1-(1-cikbar__);
  g1(34,4)=1;
  g1(35,5)=1;
  g1(36,6)=1;
  g1(37,7)=1;
  g1(38,3)=1;
  g1(38,29)=(-1);
  g1(39,2)=1;
  g1(39,31)=(-1);
  g1(40,1)=1;
  g1(40,28)=(-1);
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
