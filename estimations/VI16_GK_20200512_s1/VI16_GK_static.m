function [residual, g1, g2, g3] = VI16_GK_static(y, x, params)
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

residual = zeros( 61, 1);

%
% Model equations
%

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
T143 = BETABAR__*(1-params(12))/NU_SS__;
T150 = (params(38)-R_SS__)*T143;
T161 = 1/Z_SS__;
T219 = (1-params(6))/params(38);
T228 = 1/(params(13)/(1-params(13)));
T241 = 1/(1+BETABAR__);
T286 = BETABAR__/(1+BETABAR__);
T310 = (1-params(17))*T241*(1-BETABAR__*params(17))/(params(17)*(1+params(2)*params(8)));
T425 = 1/(1+BETABAR__*params(16));
T434 = (1-params(15))*(1-BETABAR__*params(15))/params(15);
lhs =(1-HBAR__)*y(54);
rhs =HBAR__*y(43)-y(43);
residual(1)= lhs-rhs;
residual(2) = y(46);
residual(3) = y(46)+y(60);
lhs =y(59);
rhs =params(2)*y(47)-y(54);
residual(4)= lhs-rhs;
lhs =y(49);
rhs =params(1)*params(12)*X_SS__*(y(49)+y(46)+y(51))+T143*(params(38)*y(50)-R_SS__*y(60))+y(46)*T150;
residual(5)= lhs-rhs;
lhs =y(48);
rhs =Z_SS__*params(1)*params(12)*(y(48)+y(46)+y(52));
residual(6)= lhs-rhs;
lhs =y(52);
rhs =T161*(y(50)*params(38)*LEV_SS__+y(60)*R_SS__*(1-LEV_SS__)+(params(38)-R_SS__)*LEV_SS__*y(44));
residual(7)= lhs-rhs;
lhs =y(51);
rhs =y(52)+y(44)-y(44);
residual(8)= lhs-rhs;
lhs =y(44);
rhs =y(48)+y(49)*NU_SS__/(params(11)-NU_SS__);
residual(9)= lhs-rhs;
lhs =y(56);
rhs =y(52)+y(55);
residual(10)= lhs-rhs;
lhs =y(57)+y(45);
rhs =y(44)+y(55);
residual(11)= lhs-rhs;
lhs =y(55);
rhs =y(56)*N_e_OVER_Y__/N_OVER_Y__+S_OVER_Y__/N_OVER_Y__*y(53);
residual(12)= lhs-rhs;
lhs =y(53);
rhs =y(57)+y(45);
residual(13)= lhs-rhs;
lhs =y(42);
rhs =y(50)-y(60);
residual(14)= lhs-rhs;
lhs =y(40);
rhs =params(30)*(y(33)+params(5)*(y(57)+y(37))+params(5)*y(58)+(1-params(5))*y(47));
residual(15)= lhs-rhs;
lhs =y(50);
rhs =ZK_SS__/params(38)*y(61)+T219*(y(45)+y(37))-y(45);
residual(16)= lhs-rhs;
lhs =y(58);
rhs =y(61)*T228;
residual(17)= lhs-rhs;
lhs =y(33);
rhs =params(5)*y(61)+(1-params(5))*y(59);
residual(18)= lhs-rhs;
lhs =y(61);
rhs =y(59)+y(47)-y(57)-y(58);
residual(19)= lhs-rhs;
lhs =y(41);
rhs =T241*(y(41)+BETABAR__*y(41)+1/params(14)*(y(45)+y(22)));
residual(20)= lhs-rhs;
lhs =y(57);
rhs =(1-params(6))*(y(57)+y(37))+params(6)*y(41)+y(22)*I_OVER_K__*params(14);
residual(21)= lhs-rhs;
lhs =y(40);
rhs =y(43)*C_OVER_Y__+I_OVER_Y__*y(41)+params(9)*y(31)+y(58)*ZK_SS__*K_OVER_Y__;
residual(22)= lhs-rhs;
lhs =(1-HBAR__)*y(25);
rhs =HBAR__*y(14)-y(14);
residual(23)= lhs-rhs;
residual(24) = y(17);
residual(25) = y(17)+y(32)-y(13);
lhs =y(30);
rhs =T241*y(30)+y(30)*T286+y(13)*params(18)/(1+BETABAR__)-y(13)*(1+BETABAR__*params(18))/(1+BETABAR__)+y(13)*T286+T310*(params(2)*y(18)+y(14)*1/(1-HBAR__)-y(14)*HBAR__/(1-HBAR__)-y(30))+y(36);
residual(26)= lhs-rhs;
lhs =y(20);
rhs =params(1)*params(12)*X_SS__*(y(20)+y(17)+y(34))+T143*(params(38)*y(21)-R_SS__*(y(32)-y(13)))+T150*y(17);
residual(27)= lhs-rhs;
lhs =y(19);
rhs =Z_SS__*params(1)*params(12)*(y(19)+y(17)+y(23));
residual(28)= lhs-rhs;
lhs =y(23);
rhs =T161*(params(38)*LEV_SS__*y(21)+R_SS__*(1-LEV_SS__)*(y(32)-y(13))+(params(38)-R_SS__)*LEV_SS__*y(15));
residual(29)= lhs-rhs;
lhs =y(34);
rhs =y(23)+y(15)-y(15);
residual(30)= lhs-rhs;
lhs =y(15);
rhs =y(19)+NU_SS__/(params(11)-NU_SS__)*y(20);
residual(31)= lhs-rhs;
lhs =y(27);
rhs =y(23)+y(26);
residual(32)= lhs-rhs;
lhs =y(28)+y(16);
rhs =y(15)+y(26);
residual(33)= lhs-rhs;
lhs =y(26);
rhs =N_e_OVER_Y__/N_OVER_Y__*y(27)+S_OVER_Y__/N_OVER_Y__*y(24);
residual(34)= lhs-rhs;
lhs =y(24);
rhs =y(28)+y(16);
residual(35)= lhs-rhs;
lhs =y(12);
rhs =y(21)-(y(32)-y(13));
residual(36)= lhs-rhs;
lhs =y(10);
rhs =params(30)*(y(33)+params(5)*(y(37)+y(28))+params(5)*y(29)+(1-params(5))*y(18));
residual(37)= lhs-rhs;
lhs =y(21);
rhs =ZK_SS__/params(38)*y(38)+T219*(y(37)+y(16))-y(16);
residual(38)= lhs-rhs;
lhs =y(29);
rhs =T228*y(38);
residual(39)= lhs-rhs;
lhs =y(38);
rhs =y(30)+y(18)-y(28)-y(29);
residual(40)= lhs-rhs;
lhs =y(11);
rhs =T241*(y(11)+BETABAR__*y(11)+1/params(14)*(y(22)+y(16)));
residual(41)= lhs-rhs;
lhs =y(28);
rhs =y(22)*I_OVER_K__*params(14)+(1-params(6))*(y(37)+y(28))+params(6)*y(11);
residual(42)= lhs-rhs;
lhs =y(10);
rhs =params(9)*y(31)+C_OVER_Y__*y(14)+I_OVER_Y__*y(11)+ZK_SS__*K_OVER_Y__*y(29);
residual(43)= lhs-rhs;
lhs =y(13);
rhs =T425*(BETABAR__*y(13)+y(13)*params(16)+T434*(params(5)*y(38)-y(33)+(1-params(5))*y(30)))+y(35);
residual(44)= lhs-rhs;
lhs =y(32);
rhs =y(32)*params(21)+(1-params(21))*(y(13)*params(22)+params(23)*(y(10)-y(40)))+params(32)*(y(40)+y(10)-y(40)-y(10))+y(39);
residual(45)= lhs-rhs;
lhs =y(33);
rhs =y(33)*params(24)-x(5);
residual(46)= lhs-rhs;
lhs =y(22);
rhs =y(22)*params(26)-x(1);
residual(47)= lhs-rhs;
lhs =y(31);
rhs =y(31)*params(25)-x(4);
residual(48)= lhs-rhs;
lhs =y(39);
rhs =y(39)*params(37)+x(2);
residual(49)= lhs-rhs;
lhs =y(35);
rhs =y(35)*params(29)+y(9)-y(9)*params(35);
residual(50)= lhs-rhs;
lhs =y(9);
rhs =x(7);
residual(51)= lhs-rhs;
lhs =y(36);
rhs =y(36)*params(28)+y(8)-y(8)*params(34);
residual(52)= lhs-rhs;
lhs =y(8);
rhs =x(6);
residual(53)= lhs-rhs;
lhs =y(37);
rhs =y(37)*params(27)-x(3);
residual(54)= lhs-rhs;
lhs =y(4);
rhs =params(41);
residual(55)= lhs-rhs;
lhs =y(5);
rhs =params(41);
residual(56)= lhs-rhs;
lhs =y(6);
rhs =params(41);
residual(57)= lhs-rhs;
lhs =y(7);
rhs =params(41);
residual(58)= lhs-rhs;
lhs =y(3);
rhs =params(40)+y(13);
residual(59)= lhs-rhs;
lhs =y(2);
rhs =y(32)+conster__;
residual(60)= lhs-rhs;
lhs =y(1);
rhs =y(18)+params(39);
residual(61)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(61, 61);

  %
  % Jacobian matrix
  %

T564 = (-(T241*1/params(14)));
  g1(1,43)=(-(HBAR__-1));
  g1(1,54)=1-HBAR__;
  g1(2,46)=1;
  g1(3,46)=1;
  g1(3,60)=1;
  g1(4,47)=(-params(2));
  g1(4,54)=1;
  g1(4,59)=1;
  g1(5,46)=(-(params(1)*params(12)*X_SS__+T150));
  g1(5,49)=1-params(1)*params(12)*X_SS__;
  g1(5,50)=(-(params(38)*T143));
  g1(5,51)=(-(params(1)*params(12)*X_SS__));
  g1(5,60)=(-(T143*(-R_SS__)));
  g1(6,46)=(-(Z_SS__*params(1)*params(12)));
  g1(6,48)=1-Z_SS__*params(1)*params(12);
  g1(6,52)=(-(Z_SS__*params(1)*params(12)));
  g1(7,44)=(-((params(38)-R_SS__)*LEV_SS__*T161));
  g1(7,50)=(-(T161*params(38)*LEV_SS__));
  g1(7,52)=1;
  g1(7,60)=(-(T161*R_SS__*(1-LEV_SS__)));
  g1(8,51)=1;
  g1(8,52)=(-1);
  g1(9,44)=1;
  g1(9,48)=(-1);
  g1(9,49)=(-(NU_SS__/(params(11)-NU_SS__)));
  g1(10,52)=(-1);
  g1(10,55)=(-1);
  g1(10,56)=1;
  g1(11,44)=(-1);
  g1(11,45)=1;
  g1(11,55)=(-1);
  g1(11,57)=1;
  g1(12,53)=(-(S_OVER_Y__/N_OVER_Y__));
  g1(12,55)=1;
  g1(12,56)=(-(N_e_OVER_Y__/N_OVER_Y__));
  g1(13,45)=(-1);
  g1(13,53)=1;
  g1(13,57)=(-1);
  g1(14,42)=1;
  g1(14,50)=(-1);
  g1(14,60)=1;
  g1(15,33)=(-params(30));
  g1(15,37)=(-(params(5)*params(30)));
  g1(15,40)=1;
  g1(15,47)=(-((1-params(5))*params(30)));
  g1(15,57)=(-(params(5)*params(30)));
  g1(15,58)=(-(params(5)*params(30)));
  g1(16,37)=(-T219);
  g1(16,45)=(-(T219-1));
  g1(16,50)=1;
  g1(16,61)=(-(ZK_SS__/params(38)));
  g1(17,58)=1;
  g1(17,61)=(-T228);
  g1(18,33)=1;
  g1(18,59)=(-(1-params(5)));
  g1(18,61)=(-params(5));
  g1(19,47)=(-1);
  g1(19,57)=1;
  g1(19,58)=1;
  g1(19,59)=(-1);
  g1(19,61)=1;
  g1(20,22)=T564;
  g1(20,41)=1-(1+BETABAR__)*T241;
  g1(20,45)=T564;
  g1(21,22)=(-(I_OVER_K__*params(14)));
  g1(21,37)=(-(1-params(6)));
  g1(21,41)=(-params(6));
  g1(21,57)=1-(1-params(6));
  g1(22,31)=(-params(9));
  g1(22,40)=1;
  g1(22,41)=(-I_OVER_Y__);
  g1(22,43)=(-C_OVER_Y__);
  g1(22,58)=(-(ZK_SS__*K_OVER_Y__));
  g1(23,14)=(-(HBAR__-1));
  g1(23,25)=1-HBAR__;
  g1(24,17)=1;
  g1(25,13)=(-1);
  g1(25,17)=1;
  g1(25,32)=1;
  g1(26,13)=(-(T286+params(18)/(1+BETABAR__)-(1+BETABAR__*params(18))/(1+BETABAR__)));
  g1(26,14)=(-(T310*(1/(1-HBAR__)-HBAR__/(1-HBAR__))));
  g1(26,18)=(-(params(2)*T310));
  g1(26,30)=1-(T241+T286-T310);
  g1(26,36)=(-1);
  g1(27,13)=(-(R_SS__*T143));
  g1(27,17)=(-(params(1)*params(12)*X_SS__+T150));
  g1(27,20)=1-params(1)*params(12)*X_SS__;
  g1(27,21)=(-(params(38)*T143));
  g1(27,32)=(-(T143*(-R_SS__)));
  g1(27,34)=(-(params(1)*params(12)*X_SS__));
  g1(28,17)=(-(Z_SS__*params(1)*params(12)));
  g1(28,19)=1-Z_SS__*params(1)*params(12);
  g1(28,23)=(-(Z_SS__*params(1)*params(12)));
  g1(29,13)=(-(T161*(-(R_SS__*(1-LEV_SS__)))));
  g1(29,15)=(-((params(38)-R_SS__)*LEV_SS__*T161));
  g1(29,21)=(-(T161*params(38)*LEV_SS__));
  g1(29,23)=1;
  g1(29,32)=(-(T161*R_SS__*(1-LEV_SS__)));
  g1(30,23)=(-1);
  g1(30,34)=1;
  g1(31,15)=1;
  g1(31,19)=(-1);
  g1(31,20)=(-(NU_SS__/(params(11)-NU_SS__)));
  g1(32,23)=(-1);
  g1(32,26)=(-1);
  g1(32,27)=1;
  g1(33,15)=(-1);
  g1(33,16)=1;
  g1(33,26)=(-1);
  g1(33,28)=1;
  g1(34,24)=(-(S_OVER_Y__/N_OVER_Y__));
  g1(34,26)=1;
  g1(34,27)=(-(N_e_OVER_Y__/N_OVER_Y__));
  g1(35,16)=(-1);
  g1(35,24)=1;
  g1(35,28)=(-1);
  g1(36,12)=1;
  g1(36,13)=(-1);
  g1(36,21)=(-1);
  g1(36,32)=1;
  g1(37,10)=1;
  g1(37,18)=(-((1-params(5))*params(30)));
  g1(37,28)=(-(params(5)*params(30)));
  g1(37,29)=(-(params(5)*params(30)));
  g1(37,33)=(-params(30));
  g1(37,37)=(-(params(5)*params(30)));
  g1(38,16)=(-(T219-1));
  g1(38,21)=1;
  g1(38,37)=(-T219);
  g1(38,38)=(-(ZK_SS__/params(38)));
  g1(39,29)=1;
  g1(39,38)=(-T228);
  g1(40,18)=(-1);
  g1(40,28)=1;
  g1(40,29)=1;
  g1(40,30)=(-1);
  g1(40,38)=1;
  g1(41,11)=1-(1+BETABAR__)*T241;
  g1(41,16)=T564;
  g1(41,22)=T564;
  g1(42,11)=(-params(6));
  g1(42,22)=(-(I_OVER_K__*params(14)));
  g1(42,28)=1-(1-params(6));
  g1(42,37)=(-(1-params(6)));
  g1(43,10)=1;
  g1(43,11)=(-I_OVER_Y__);
  g1(43,14)=(-C_OVER_Y__);
  g1(43,29)=(-(ZK_SS__*K_OVER_Y__));
  g1(43,31)=(-params(9));
  g1(44,13)=1-T425*(BETABAR__+params(16));
  g1(44,30)=(-(T425*(1-params(5))*T434));
  g1(44,33)=(-(T425*(-T434)));
  g1(44,35)=(-1);
  g1(44,38)=(-(T425*params(5)*T434));
  g1(45,10)=(-((1-params(21))*params(23)));
  g1(45,13)=(-((1-params(21))*params(22)));
  g1(45,32)=1-params(21);
  g1(45,39)=(-1);
  g1(45,40)=(-((1-params(21))*(-params(23))));
  g1(46,33)=1-params(24);
  g1(47,22)=1-params(26);
  g1(48,31)=1-params(25);
  g1(49,39)=1-params(37);
  g1(50,9)=(-(1-params(35)));
  g1(50,35)=1-params(29);
  g1(51,9)=1;
  g1(52,8)=(-(1-params(34)));
  g1(52,36)=1-params(28);
  g1(53,8)=1;
  g1(54,37)=1-params(27);
  g1(55,4)=1;
  g1(56,5)=1;
  g1(57,6)=1;
  g1(58,7)=1;
  g1(59,3)=1;
  g1(59,13)=(-1);
  g1(60,2)=1;
  g1(60,32)=(-1);
  g1(61,1)=1;
  g1(61,18)=(-1);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],61,3721);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],61,226981);
end
end
end
end
