function [residual, g1, g2, g3] = GSW12_cql_static(y, x, params)
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

residual = zeros( 51, 1);

%
% Model equations
%

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
T85 = params(12)/cgamma__;
T88 = 1-T85;
T91 = params(11)*(1+T85)/T88*y(35);
T99 = params(11)*params(12)/cgamma__/T88;
T112 = 1/(1+cgamma__*cbetabar__);
T115 = cgamma__^2;
T117 = T115*params(9);
T128 = 1/(T88/(params(11)*(1+T85)));
T129 = y(35)*T128;
T136 = (1-params(10))/(1-params(10)+crk__);
T156 = 1/(params(8)/(1-params(8)));
T202 = (1-cbeta__*params(34))*(1-params(34))/params(34);
T278 = 1/(1+cgamma__*cbetabar__*params(16));
T292 = (1-params(17))*(1-cgamma__*cbetabar__*params(17))/params(17)/(1+(params(13)-1)*params(2));
T303 = cgamma__*cbetabar__/(1+cgamma__*cbetabar__);
T327 = params(18)*(1-cgamma__*cbetabar__*params(15))*(1-params(15))/((1+cgamma__*cbetabar__)*params(15)*params(19)*params(18)/(params(19)-1));
T375 = params(18)*(1-params(15))*(1+cgamma__*cbetabar__)*params(15)*params(19)*params(18)/(params(19)-1)/(1-cgamma__*cbetabar__*params(15));
lhs =y(20);
rhs =params(13)*(params(7)*y(29)+(1-params(7))*y(26)+y(37));
residual(1)= lhs-rhs;
lhs =y(24);
rhs =y(24)+y(25)-T91;
residual(2)= lhs-rhs;
lhs =y(24);
rhs =(-params(11))/T88*y(21)+y(21)*T99+y(26)*(params(11)-1)*whlcstar__/T88;
residual(3)= lhs-rhs;
lhs =y(22);
rhs =T112*(y(22)+y(22)*cgamma__*cbetabar__+1/T117*y(27))+y(36);
residual(4)= lhs-rhs;
lhs =y(27);
rhs =(-y(25))+T129+crk__/(1-params(10)+crk__)*y(28)+y(27)*T136;
residual(5)= lhs-rhs;
lhs =y(20);
rhs =ccy__*y(21)+ciy__*y(22)+y(34)+crkky__*y(23);
residual(6)= lhs-rhs;
lhs =y(29);
rhs =y(23)+y(30);
residual(7)= lhs-rhs;
lhs =y(23);
rhs =y(28)*T156;
residual(8)= lhs-rhs;
lhs =y(30);
rhs =y(30)*(1-cikbar__)+y(22)*cikbar__+y(36)*T117*cikbar__;
residual(9)= lhs-rhs;
lhs =y(37);
rhs =params(7)*y(28)+(1-params(7))*y(31);
residual(10)= lhs-rhs;
lhs =y(28);
rhs =y(26)+y(31)-y(29);
residual(11)= lhs-rhs;
lhs =y(32);
rhs =y(32)*(1-params(33))+params(33)/T88*(y(21)-T85*y(21));
residual(12)= lhs-rhs;
lhs =y(31);
rhs =y(32)+y(26)*params(18)-(y(21)-T85*y(21))*1/T88-y(24)+y(43);
residual(13)= lhs-rhs;
lhs =y(33);
rhs =y(33)+T202*(y(26)-y(33));
residual(14)= lhs-rhs;
lhs =y(1);
rhs =y(34)+ccy__*y(2)+ciy__*y(3)+crkky__*y(4);
residual(15)= lhs-rhs;
lhs =y(5);
rhs =y(5)+y(6)-y(7)-T91;
residual(16)= lhs-rhs;
lhs =y(5);
rhs =(-params(11))/T88*y(2)+T99*y(2)+(params(11)-1)*whlcstar__/T88*y(8);
residual(17)= lhs-rhs;
lhs =y(3);
rhs =y(36)+T112*(y(3)+cgamma__*cbetabar__*y(3)+1/T117*y(9));
residual(18)= lhs-rhs;
lhs =y(9);
rhs =T136*y(9)+crk__/(1-params(10)+crk__)*y(10)+T129+y(7)-y(6);
residual(19)= lhs-rhs;
lhs =y(1);
rhs =params(13)*(y(37)+params(7)*y(11)+(1-params(7))*y(8));
residual(20)= lhs-rhs;
lhs =y(11);
rhs =y(4)+y(12);
residual(21)= lhs-rhs;
lhs =y(4);
rhs =T156*y(10);
residual(22)= lhs-rhs;
lhs =y(12);
rhs =(1-cikbar__)*y(12)+cikbar__*y(3)+y(36)*params(9)*T115*cikbar__;
residual(23)= lhs-rhs;
lhs =y(13);
rhs =params(7)*y(10)+(1-params(7))*y(14)-y(37);
residual(24)= lhs-rhs;
lhs =y(7);
rhs =T278*(cgamma__*cbetabar__*y(7)+y(7)*params(16)+y(13)*T292)+y(38);
residual(25)= lhs-rhs;
lhs =y(10);
rhs =y(8)+y(14)-y(11);
residual(26)= lhs-rhs;
lhs =y(14);
rhs =T112*y(14)+T303*(y(7)+y(14))-y(7)*(1+cgamma__*cbetabar__*params(14))/(1+cgamma__*cbetabar__)+y(7)*params(14)/(1+cgamma__*cbetabar__)-T327*y(15)+y(40);
residual(27)= lhs-rhs;
lhs =y(6);
rhs =y(7)*params(20)*(1-params(23))+(1-params(23))*params(22)*(y(1)-y(20))+params(21)*(y(20)+y(1)-y(20)-y(1))+y(6)*params(23)+y(42);
residual(28)= lhs-rhs;
lhs =y(16);
rhs =(1-params(33))*y(16)+params(33)/T88*(y(2)-T85*y(2));
residual(29)= lhs-rhs;
lhs =y(14);
rhs =y(43)+y(16)+params(18)*y(17)-1/T88*(y(2)-T85*y(2))-y(5);
residual(30)= lhs-rhs;
lhs =y(15);
rhs =y(17)-y(19);
residual(31)= lhs-rhs;
lhs =y(18);
rhs =y(40)*T375;
residual(32)= lhs-rhs;
lhs =y(19);
rhs =y(19)+T202*(y(8)-y(19));
residual(33)= lhs-rhs;
lhs =y(37);
rhs =y(37)*params(24)+x(1);
residual(34)= lhs-rhs;
lhs =y(35);
rhs =y(35)*params(25)+x(2);
residual(35)= lhs-rhs;
lhs =y(34);
rhs =y(34)*params(26)+x(3)+x(1)*params(1);
residual(36)= lhs-rhs;
lhs =y(36);
rhs =y(36)*params(27)+x(4);
residual(37)= lhs-rhs;
lhs =y(42);
rhs =y(42)*params(28)+x(5);
residual(38)= lhs-rhs;
lhs =y(38);
rhs =y(38)*params(29)+y(39)-y(39)*params(6);
residual(39)= lhs-rhs;
lhs =y(39);
rhs =x(6);
residual(40)= lhs-rhs;
lhs =y(40);
rhs =y(40)*params(30)+y(41)-y(41)*params(5);
residual(41)= lhs-rhs;
lhs =y(41);
rhs =x(7);
residual(42)= lhs-rhs;
lhs =y(43);
rhs =y(43)*params(35)+x(8);
residual(43)= lhs-rhs;
lhs =y(46);
rhs =params(31)+params(36);
residual(44)= lhs-rhs;
lhs =y(47);
rhs =params(31)+params(36);
residual(45)= lhs-rhs;
lhs =y(48);
rhs =params(31)+params(36);
residual(46)= lhs-rhs;
lhs =y(49);
rhs =params(31);
residual(47)= lhs-rhs;
lhs =y(45);
rhs =params(3)+y(7);
residual(48)= lhs-rhs;
lhs =y(44);
rhs =y(6)+4*cr__;
residual(49)= lhs-rhs;
lhs =y(50);
rhs =params(36);
residual(50)= lhs-rhs;
lhs =y(51);
rhs =y(15)+100*(params(19)-1)/params(18);
residual(51)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(51, 51);

  %
  % Jacobian matrix
  %

  g1(1,20)=1;
  g1(1,26)=(-(params(13)*(1-params(7))));
  g1(1,29)=(-(params(13)*params(7)));
  g1(1,37)=(-params(13));
  g1(2,25)=(-1);
  g1(2,35)=params(11)*(1+T85)/T88;
  g1(3,21)=(-((-params(11))/T88+T99));
  g1(3,24)=1;
  g1(3,26)=(-((params(11)-1)*whlcstar__/T88));
  g1(4,22)=1-(1+cgamma__*cbetabar__)*T112;
  g1(4,27)=(-(T112*1/T117));
  g1(4,36)=(-1);
  g1(5,25)=1;
  g1(5,27)=1-T136;
  g1(5,28)=(-(crk__/(1-params(10)+crk__)));
  g1(5,35)=(-T128);
  g1(6,20)=1;
  g1(6,21)=(-ccy__);
  g1(6,22)=(-ciy__);
  g1(6,23)=(-crkky__);
  g1(6,34)=(-1);
  g1(7,23)=(-1);
  g1(7,29)=1;
  g1(7,30)=(-1);
  g1(8,23)=1;
  g1(8,28)=(-T156);
  g1(9,22)=(-cikbar__);
  g1(9,30)=1-(1-cikbar__);
  g1(9,36)=(-(T117*cikbar__));
  g1(10,28)=(-params(7));
  g1(10,31)=(-(1-params(7)));
  g1(10,37)=1;
  g1(11,26)=(-1);
  g1(11,28)=1;
  g1(11,29)=1;
  g1(11,31)=(-1);
  g1(12,21)=(-(T88*params(33)/T88));
  g1(12,32)=1-(1-params(33));
  g1(13,21)=T88*1/T88;
  g1(13,24)=1;
  g1(13,26)=(-params(18));
  g1(13,31)=1;
  g1(13,32)=(-1);
  g1(13,43)=(-1);
  g1(14,26)=(-T202);
  g1(14,33)=1-(1-T202);
  g1(15,1)=1;
  g1(15,2)=(-ccy__);
  g1(15,3)=(-ciy__);
  g1(15,4)=(-crkky__);
  g1(15,34)=(-1);
  g1(16,6)=(-1);
  g1(16,7)=1;
  g1(16,35)=params(11)*(1+T85)/T88;
  g1(17,2)=(-((-params(11))/T88+T99));
  g1(17,5)=1;
  g1(17,8)=(-((params(11)-1)*whlcstar__/T88));
  g1(18,3)=1-(1+cgamma__*cbetabar__)*T112;
  g1(18,9)=(-(T112*1/T117));
  g1(18,36)=(-1);
  g1(19,6)=1;
  g1(19,7)=(-1);
  g1(19,9)=1-T136;
  g1(19,10)=(-(crk__/(1-params(10)+crk__)));
  g1(19,35)=(-T128);
  g1(20,1)=1;
  g1(20,8)=(-(params(13)*(1-params(7))));
  g1(20,11)=(-(params(13)*params(7)));
  g1(20,37)=(-params(13));
  g1(21,4)=(-1);
  g1(21,11)=1;
  g1(21,12)=(-1);
  g1(22,4)=1;
  g1(22,10)=(-T156);
  g1(23,3)=(-cikbar__);
  g1(23,12)=1-(1-cikbar__);
  g1(23,36)=(-(params(9)*T115*cikbar__));
  g1(24,10)=(-params(7));
  g1(24,13)=1;
  g1(24,14)=(-(1-params(7)));
  g1(24,37)=1;
  g1(25,7)=1-T278*(cgamma__*cbetabar__+params(16));
  g1(25,13)=(-(T278*T292));
  g1(25,38)=(-1);
  g1(26,8)=(-1);
  g1(26,10)=1;
  g1(26,11)=1;
  g1(26,14)=(-1);
  g1(27,7)=(-(params(14)/(1+cgamma__*cbetabar__)+T303-(1+cgamma__*cbetabar__*params(14))/(1+cgamma__*cbetabar__)));
  g1(27,14)=1-(T112+T303);
  g1(27,15)=T327;
  g1(27,40)=(-1);
  g1(28,1)=(-((1-params(23))*params(22)));
  g1(28,6)=1-params(23);
  g1(28,7)=(-(params(20)*(1-params(23))));
  g1(28,20)=(1-params(23))*params(22);
  g1(28,42)=(-1);
  g1(29,2)=(-(T88*params(33)/T88));
  g1(29,16)=1-(1-params(33));
  g1(30,2)=T88*1/T88;
  g1(30,5)=1;
  g1(30,14)=1;
  g1(30,16)=(-1);
  g1(30,17)=(-params(18));
  g1(30,43)=(-1);
  g1(31,15)=1;
  g1(31,17)=(-1);
  g1(31,19)=1;
  g1(32,18)=1;
  g1(32,40)=(-T375);
  g1(33,8)=(-T202);
  g1(33,19)=1-(1-T202);
  g1(34,37)=1-params(24);
  g1(35,35)=1-params(25);
  g1(36,34)=1-params(26);
  g1(37,36)=1-params(27);
  g1(38,42)=1-params(28);
  g1(39,38)=1-params(29);
  g1(39,39)=(-(1-params(6)));
  g1(40,39)=1;
  g1(41,40)=1-params(30);
  g1(41,41)=(-(1-params(5)));
  g1(42,41)=1;
  g1(43,43)=1-params(35);
  g1(44,46)=1;
  g1(45,47)=1;
  g1(46,48)=1;
  g1(47,49)=1;
  g1(48,7)=(-1);
  g1(48,45)=1;
  g1(49,6)=(-1);
  g1(49,44)=1;
  g1(50,50)=1;
  g1(51,15)=(-1);
  g1(51,51)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],51,2601);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],51,132651);
end
end
end
end
