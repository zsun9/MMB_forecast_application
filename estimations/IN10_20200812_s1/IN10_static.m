function [residual, g1, g2, g3] = IN10_static(y, x, params)
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

residual = zeros( 50, 1);

%
% Model equations
%

TRENDK__ = params(40)+1/(1-params(5))*params(42);
TRENDY__ = params(40)+params(42)*params(5)/(1-params(5));
TRENDH__ = (1-params(6)-params(33)-params(43))*params(41)+params(40)*(params(6)+params(43))+params(42)*params(5)*(params(6)+params(43))/(1-params(5));
TRENDQ__ = params(40)*(1-params(6)-params(43))+params(42)*params(5)*(1-params(6)-params(43))/(1-params(5))-(1-params(6)-params(33)-params(43))*params(41);
llEXPTRENDY__ = exp(TRENDY__);
llEXPTRENDK__ = exp(TRENDK__);
llEXPTRENDQ__ = exp(TRENDQ__);
llEXPTRENDH__ = exp(TRENDH__);
llgamma_k__ = exp(params(42));
llr__ = 1/params(1);
llr1__ = llr__/llEXPTRENDY__-1;
llZETA0__ = params(5)*params(1)*llEXPTRENDK__/(llgamma_k__-params(1)*(1-params(7)))/params(21);
llZETA1__ = params(6)*params(1)*llEXPTRENDY__/(1-params(1)*(1-params(8)));
llZETA2__ = params(4)/(1-params(1)*llEXPTRENDQ__*(1-params(9)));
llZETA3__ = params(4)/(1-(1-params(9))*llEXPTRENDQ__*params(2)-llEXPTRENDQ__*(params(1)-params(2))*params(3));
llZETA4__ = llEXPTRENDQ__*(llr__/llEXPTRENDY__-1)*params(3)/llr__;
llDH1__ = 1-(1-params(9))/llEXPTRENDH__;
llDKC1__ = 1-(1-params(7))/llEXPTRENDK__;
llDKH1__ = 1-(1-params(8))/llEXPTRENDY__;
llCHI1__ = 1+llDH1__*llZETA2__*(1-llr1__*llZETA1__-params(33)-(1-params(6)-params(33)-params(43))*params(16));
llCHI2__ = llDH1__*((1-params(6)-params(33)-params(43))*params(16)+params(33)+llr1__*llZETA1__)*llZETA3__+llZETA3__*llZETA4__;
llCHI3__ = (params(21)-1+params(21)*llr1__*llZETA0__+(1-params(5))*params(16))/params(21);
llCHI4__ = llZETA3__*llZETA4__+1+llDH1__*llZETA3__*(1-(1-params(6)-params(33)-params(43))*(1-params(16)));
llCHI5__ = llZETA2__*llDH1__*(1-params(6)-params(33)-params(43))*(1-params(16));
llCHI6__ = (1-params(5))*(1-params(16))/params(21);
llCY__ = (llCHI3__*llCHI4__+llCHI2__*llCHI6__)/(llCHI4__*llCHI1__-llCHI2__*llCHI5__);
llCYPRIME__ = (llCHI6__*llCHI1__+llCHI3__*llCHI5__)/(llCHI4__*llCHI1__-llCHI2__*llCHI5__);
llQIY__ = llDH1__*llZETA2__*llCY__+llDH1__*llZETA3__*llCYPRIME__;
llRATION__ = params(21)*(1-params(6)-params(33)-params(43))/(1-params(5))*llQIY__;
llNHNC__ = llRATION__^(1/(1-params(31)));
llNHNC1__ = llRATION__^(1/(1-params(32)));
llnc__ = ((1-params(5))*params(16)/llCY__/params(21)/params(34)/(1+llRATION__)^((params(31)+params(10))/(1-params(31))))^(1/(1+params(10)));
llnh__ = llNHNC__*llnc__;
llnc1__ = ((1-params(5))*(1-params(16))/llCYPRIME__/params(21)/params(34)/(1+llRATION__)^((params(32)+params(11))/(1-params(32))))^(1/(1+params(11)));
llnh1__ = llNHNC1__*llnc1__;
llY__ = llnc__^params(16)*llnc1__^(1-params(16))*llZETA0__^(params(5)/(1-params(5)))/llEXPTRENDK__^(params(5)/(1-params(5)));
llI__ = llnh__^((1-params(6)-params(33)-params(43))*params(16))*llnh1__^((1-params(6)-params(33)-params(43))*(1-params(16)))*llZETA1__^params(6)*(llQIY__*llY__)^params(6)/llEXPTRENDY__^params(6)*(llQIY__*params(43)*llY__)^params(43);
llq__ = llQIY__*llY__/llI__;
llQI__ = llQIY__*llY__;
llkc__ = llZETA0__*llY__;
llkh__ = llZETA1__*llQI__;
llc__ = llCY__*llY__;
llc1__ = llCYPRIME__*llY__;
llCC__ = llc__+llc1__;
llIH__ = llI__;
llIK__ = llDKC1__*llkc__+llDKH1__*llkh__;
CC_SS__ = log(llCC__);
IH_SS__ = log(llIH__);
IK_SS__ = log(llIK__);
QQ_SS__ = log(llq__);
NC_SS__ = params(16)*log(llnc__)+(1-params(16))*log(llnc1__);
NH_SS__ = params(16)*log(llnh__)+(1-params(16))*log(llnh1__);
T336 = (exp(y(34)+y(49))+(1-params(7))/exp(y(4)))*exp(y(25)-TRENDK__);
T386 = (exp(y(34)+y(49))+(1-params(7))/exp(y(4)))*exp(TRENDY__)*params(1)*exp(y(36)-TRENDK__);
T405 = exp(y(28))^(1-params(31))+exp(y(30))^(1-params(31));
T407 = exp(y(6))*exp(y(7))*T405^((params(31)+params(10))/(1-params(31)));
T409 = exp(y(28))^(-params(31));
T410 = T407*T409;
T416 = exp(y(30))^(-params(31));
T417 = T407*T416;
T484 = exp(y(29))^(1-params(32))+exp(y(31))^(1-params(32));
T486 = exp(y(6))*exp(y(7))*T484^((params(32)+params(11))/(1-params(32)));
T488 = exp(y(29))^(-params(32));
T489 = T486*T488;
T495 = exp(y(31))^(-params(32));
T496 = T486*T495;
T622 = (exp(TRENDY__)-params(12))/(exp(TRENDY__)-exp(TRENDY__)*params(1)*params(12));
T635 = exp(y(7))*T622*(1/(exp(y(9))-params(12)*exp(y(9)-TRENDY__))-exp(TRENDY__)*params(1)*params(12)/(exp(TRENDY__+y(9))-exp(y(9))*params(12)));
T642 = (exp(TRENDY__)-params(13))/(exp(TRENDY__)-exp(TRENDY__)*params(2)*params(13));
T655 = exp(y(7))*T642*(1/(exp(y(10))-params(13)*exp(y(10)-TRENDY__))-exp(TRENDY__)*params(2)*params(13)/(exp(TRENDY__+y(10))-exp(y(10))*params(13)));
T658 = 1/(1+exp(TRENDY__)*params(1));
T679 = (1-params(35))*(1-exp(TRENDY__)*params(1)*params(35))/params(35)/(1+exp(TRENDY__)*params(1));
T686 = 1/(1+exp(TRENDY__)*params(2));
T704 = (1-params(35))*(1-exp(TRENDY__)*params(2)*params(35))/params(35)/(1+exp(TRENDY__)*params(2));
T728 = (1-params(36))*(1-exp(TRENDY__)*params(1)*params(36))/params(36)/(1+exp(TRENDY__)*params(1));
T749 = (1-params(36))*(1-exp(TRENDY__)*params(2)*params(36))/params(36)/(1+exp(TRENDY__)*params(2));
T758 = exp(y(4)+y(34))/(exp(params(42))*1/params(1)-(1-params(7)));
T769 = exp(y(35))/(1/params(1)-(1-params(8)));
T793 = exp(y(26))+exp(y(25))-(1-params(7))*exp(y(25)-TRENDK__)-(1-params(8))*exp(y(26)-TRENDY__);
T839 = exp(CC_SS__)/(exp(CC_SS__)+exp(IH_SS__+QQ_SS__)+exp(IK_SS__));
T842 = exp(IK_SS__)/(exp(CC_SS__)+exp(IH_SS__+QQ_SS__)+exp(IK_SS__));
T846 = exp(IH_SS__+QQ_SS__)/(exp(CC_SS__)+exp(IH_SS__+QQ_SS__)+exp(IK_SS__));
lhs =exp(y(9))+exp(y(25))/exp(y(4))+exp(y(26))+exp(y(32)+y(22))+exp(y(8));
rhs =(1-params(9))*exp(y(32)+y(22)-TRENDH__)+exp(y(38)+y(28))+exp(y(40)+y(30))+(1-1/exp(y(42)))*exp(y(47))+exp(y(8)+y(33)-y(21)-TRENDY__)+T336+(1-params(8)+exp(y(35)+y(50)))*exp(y(26)-TRENDY__)+params(33)*exp(y(32))*exp(y(24));
residual(1)= lhs-rhs;
lhs =exp(y(32)+y(36));
rhs =params(4)*exp(y(7)+y(3)-y(22))+(1-params(9))*exp(TRENDY__)*params(1)*exp(y(36)+TRENDQ__+y(32)-TRENDY__);
residual(2)= lhs-rhs;
lhs =exp(y(36));
rhs =exp(TRENDY__)*params(1)*exp(y(33)-y(21)+y(36)-TRENDY__);
residual(3)= lhs-rhs;
lhs =exp(y(36))/exp(y(4));
rhs =T386;
residual(4)= lhs-rhs;
lhs =exp(y(36));
rhs =(1-params(8)+exp(y(35)+y(50)))*exp(TRENDY__)*params(1)*exp(y(36)-TRENDY__);
residual(5)= lhs-rhs;
lhs =T410;
rhs =exp(y(38)+y(36)-y(43));
residual(6)= lhs-rhs;
lhs =T417;
rhs =exp(y(40)+y(36)-y(45));
residual(7)= lhs-rhs;
lhs =exp(y(10))+exp(y(32)+y(23))-(1-params(9))*exp(y(32)+y(23)-TRENDH__);
rhs =exp(y(8))+exp(y(39)+y(29))+exp(y(41)+y(31))-exp(y(8)+y(33)-y(21)-TRENDY__);
residual(8)= lhs-rhs;
lhs =exp(y(32)+y(37));
rhs =params(4)*exp(y(7)+y(3)-y(23))+(1-params(9))*exp(TRENDY__)*params(2)*exp(TRENDQ__+y(32)+y(37)-TRENDY__)+params(3)*exp(y(27)+y(21)+TRENDQ__+y(32)-y(33));
residual(9)= lhs-rhs;
lhs =y(8);
rhs =y(21)+y(23)+TRENDQ__+y(32)+log(params(3))-y(33);
residual(10)= lhs-rhs;
lhs =exp(y(37));
rhs =exp(TRENDY__)*params(2)*exp(y(33)-y(21)+y(37)-TRENDY__)+exp(y(27));
residual(11)= lhs-rhs;
lhs =T489;
rhs =exp(y(39)+y(37)-y(44));
residual(12)= lhs-rhs;
lhs =T496;
rhs =exp(y(41)+y(37)-y(46));
residual(13)= lhs-rhs;
lhs =y(47);
rhs =(1-params(5))*y(1)+(1-params(5))*params(16)*y(28)+(1-params(5))*(1-params(16))*y(29)+params(5)*(y(25)+y(49)-TRENDK__);
residual(14)= lhs-rhs;
lhs =y(24);
rhs =(1-params(6)-params(43)-params(33))*y(2)+params(43)*(y(24)+y(32)+log(params(43)))+y(30)*params(16)*(1-params(6)-params(43)-params(33))+y(31)*(1-params(16))*(1-params(6)-params(43)-params(33))+params(6)*(y(26)+y(50)-TRENDY__);
residual(15)= lhs-rhs;
lhs =y(47)+log(1-params(5))+log(params(16))-y(42)-y(28);
rhs =y(38);
residual(16)= lhs-rhs;
lhs =y(47)+log(1-params(5))+log(1-params(16))-y(42)-y(29);
rhs =y(39);
residual(17)= lhs-rhs;
lhs =y(24)+y(32)+log(params(16))+log(1-params(6)-params(33)-params(43))-y(30);
rhs =y(40);
residual(18)= lhs-rhs;
lhs =y(24)+y(32)+log(1-params(16))+log(1-params(6)-params(33)-params(43))-y(31);
rhs =y(41);
residual(19)= lhs-rhs;
lhs =TRENDK__+y(47)+log(params(5))-y(42)-y(25);
rhs =y(34)+y(49);
residual(20)= lhs-rhs;
lhs =TRENDY__+y(24)+y(32)+log(params(6))-y(26);
rhs =y(35)+y(50);
residual(21)= lhs-rhs;
lhs =y(21)-y(21)*params(22);
rhs =exp(TRENDY__)*params(1)*(y(21)-y(21)*params(22))-(1-params(17))*(1-exp(TRENDY__)*params(1)*params(17))/params(17)*(y(42)-log(params(21)))+x(6);
residual(22)= lhs-rhs;
lhs =y(33);
rhs =y(33)*params(18)+y(21)*(1-params(18))*params(20)+(1-params(18))*log(1/params(1))+x(2)-y(5)/100;
residual(23)= lhs-rhs;
lhs =exp(y(22))+exp(y(23));
rhs =exp(y(24))+(1-params(9))*exp(y(22)-TRENDH__)+(1-params(9))*exp(y(23)-TRENDH__);
residual(24)= lhs-rhs;
lhs =exp(y(36));
rhs =T635;
residual(25)= lhs-rhs;
lhs =exp(y(37));
rhs =T655;
residual(26)= lhs-rhs;
lhs =y(38);
rhs =y(38)*T658+(1-T658)*(y(38)+y(21))-y(21)*(1+exp(TRENDY__)*params(1)*params(37))/(1+exp(TRENDY__)*params(1))+y(21)*params(37)/(1+exp(TRENDY__)*params(1))-T679*(y(43)-log(params(34)));
residual(27)= lhs-rhs;
lhs =y(39);
rhs =y(39)*T686+(1-T686)*(y(21)+y(39))-y(21)*(1+exp(TRENDY__)*params(2)*params(37))/(1+exp(TRENDY__)*params(2))+y(21)*params(37)/(1+exp(TRENDY__)*params(2))-T704*(y(44)-log(params(34)));
residual(28)= lhs-rhs;
lhs =y(40);
rhs =y(40)*T658+(1-T658)*(y(40)+y(21))-y(21)*(1+exp(TRENDY__)*params(1)*params(38))/(1+exp(TRENDY__)*params(1))+y(21)*params(38)/(1+exp(TRENDY__)*params(1))-T728*(y(45)-log(params(34)));
residual(29)= lhs-rhs;
lhs =y(41);
rhs =y(41)*T686+(1-T686)*(y(21)+y(41))-y(21)*(1+exp(TRENDY__)*params(2)*params(38))/(1+exp(TRENDY__)*params(2))+y(21)*params(38)/(1+exp(TRENDY__)*params(2))-T749*(y(46)-log(params(34)));
residual(30)= lhs-rhs;
lhs =T758;
rhs =params(39)/(1-params(39))*exp(y(49))+1-params(39)/(1-params(39));
residual(31)= lhs-rhs;
lhs =T769;
rhs =1-params(39)/(1-params(39))+params(39)/(1-params(39))*exp(y(50));
residual(32)= lhs-rhs;
lhs =y(11);
rhs =TRENDY__+log(exp(y(9))+exp(y(10)))-CC_SS__;
residual(33)= lhs-rhs;
lhs =y(12);
rhs =y(21);
residual(34)= lhs-rhs;
lhs =y(13);
rhs =TRENDH__+y(24)-IH_SS__;
residual(35)= lhs-rhs;
lhs =y(14);
rhs =TRENDK__+log(T793)-IK_SS__;
residual(36)= lhs-rhs;
lhs =y(15);
rhs =params(16)*y(28)+(1-params(16))*y(29)-NC_SS__;
residual(37)= lhs-rhs;
lhs =y(16);
rhs =params(16)*y(30)+(1-params(16))*y(31)-NH_SS__;
residual(38)= lhs-rhs;
lhs =y(17);
rhs =TRENDQ__+y(32)-QQ_SS__;
residual(39)= lhs-rhs;
lhs =y(18);
rhs =y(33)-log(1/params(1));
residual(40)= lhs-rhs;
lhs =y(19);
rhs =y(21);
residual(41)= lhs-rhs;
lhs =y(20);
rhs =y(21);
residual(42)= lhs-rhs;
lhs =y(48);
rhs =T839*(y(11)-TRENDY__)+T842*(y(14)-TRENDK__)+T846*(y(13)-TRENDH__);
residual(43)= lhs-rhs;
lhs =y(1);
rhs =y(1)*params(23)+x(1);
residual(44)= lhs-rhs;
lhs =y(2);
rhs =y(2)*params(24)+x(3);
residual(45)= lhs-rhs;
lhs =y(3);
rhs =y(3)*params(25)+x(4);
residual(46)= lhs-rhs;
lhs =y(4);
rhs =y(4)*params(26)+x(5);
residual(47)= lhs-rhs;
lhs =y(6);
rhs =y(6)*params(28)+x(8);
residual(48)= lhs-rhs;
lhs =y(5);
rhs =y(5)*params(30)+x(7);
residual(49)= lhs-rhs;
lhs =y(7);
rhs =y(7)*params(29)+x(9);
residual(50)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(50, 50);

  %
  % Jacobian matrix
  %

T899 = (-((1-params(7))*exp(y(4))))/(exp(y(4))*exp(y(4)));
T996 = getPowerDeriv(T405,(params(31)+params(10))/(1-params(31)),1);
T998 = exp(y(6))*exp(y(7))*exp(y(28))*getPowerDeriv(exp(y(28)),1-params(31),1)*T996;
T1010 = getPowerDeriv(T484,(params(32)+params(11))/(1-params(32)),1);
T1012 = exp(y(6))*exp(y(7))*exp(y(29))*getPowerDeriv(exp(y(29)),1-params(32),1)*T1010;
T1025 = exp(y(6))*exp(y(7))*T996*exp(y(30))*getPowerDeriv(exp(y(30)),1-params(31),1);
T1037 = exp(y(6))*exp(y(7))*T1010*exp(y(31))*getPowerDeriv(exp(y(31)),1-params(32),1);
  g1(1,4)=(-(exp(y(25))*exp(y(4))))/(exp(y(4))*exp(y(4)))-exp(y(25)-TRENDK__)*T899;
  g1(1,8)=exp(y(8))-exp(y(8)+y(33)-y(21)-TRENDY__);
  g1(1,9)=exp(y(9));
  g1(1,21)=exp(y(8)+y(33)-y(21)-TRENDY__);
  g1(1,22)=exp(y(32)+y(22))-(1-params(9))*exp(y(32)+y(22)-TRENDH__);
  g1(1,24)=(-(params(33)*exp(y(32))*exp(y(24))));
  g1(1,25)=exp(y(25))/exp(y(4))-T336;
  g1(1,26)=exp(y(26))-(1-params(8)+exp(y(35)+y(50)))*exp(y(26)-TRENDY__);
  g1(1,28)=(-exp(y(38)+y(28)));
  g1(1,30)=(-exp(y(40)+y(30)));
  g1(1,32)=exp(y(32)+y(22))-((1-params(9))*exp(y(32)+y(22)-TRENDH__)+params(33)*exp(y(32))*exp(y(24)));
  g1(1,33)=(-exp(y(8)+y(33)-y(21)-TRENDY__));
  g1(1,34)=(-(exp(y(34)+y(49))*exp(y(25)-TRENDK__)));
  g1(1,35)=(-(exp(y(35)+y(50))*exp(y(26)-TRENDY__)));
  g1(1,38)=(-exp(y(38)+y(28)));
  g1(1,40)=(-exp(y(40)+y(30)));
  g1(1,42)=(-(exp(y(47))*(-((-exp(y(42)))/(exp(y(42))*exp(y(42)))))));
  g1(1,47)=(-((1-1/exp(y(42)))*exp(y(47))));
  g1(1,49)=(-(exp(y(34)+y(49))*exp(y(25)-TRENDK__)));
  g1(1,50)=(-(exp(y(35)+y(50))*exp(y(26)-TRENDY__)));
  g1(2,3)=(-(params(4)*exp(y(7)+y(3)-y(22))));
  g1(2,7)=(-(params(4)*exp(y(7)+y(3)-y(22))));
  g1(2,22)=(-(params(4)*(-exp(y(7)+y(3)-y(22)))));
  g1(2,32)=exp(y(32)+y(36))-(1-params(9))*exp(TRENDY__)*params(1)*exp(y(36)+TRENDQ__+y(32)-TRENDY__);
  g1(2,36)=exp(y(32)+y(36))-(1-params(9))*exp(TRENDY__)*params(1)*exp(y(36)+TRENDQ__+y(32)-TRENDY__);
  g1(3,21)=(-(exp(TRENDY__)*params(1)*(-exp(y(33)-y(21)+y(36)-TRENDY__))));
  g1(3,33)=(-(exp(TRENDY__)*params(1)*exp(y(33)-y(21)+y(36)-TRENDY__)));
  g1(3,36)=exp(y(36))-exp(TRENDY__)*params(1)*exp(y(33)-y(21)+y(36)-TRENDY__);
  g1(4,4)=(-(exp(y(4))*exp(y(36))))/(exp(y(4))*exp(y(4)))-exp(TRENDY__)*params(1)*exp(y(36)-TRENDK__)*T899;
  g1(4,34)=(-(exp(y(34)+y(49))*exp(TRENDY__)*params(1)*exp(y(36)-TRENDK__)));
  g1(4,36)=exp(y(36))/exp(y(4))-T386;
  g1(4,49)=(-(exp(y(34)+y(49))*exp(TRENDY__)*params(1)*exp(y(36)-TRENDK__)));
  g1(5,35)=(-(exp(y(35)+y(50))*exp(TRENDY__)*params(1)*exp(y(36)-TRENDY__)));
  g1(5,36)=exp(y(36))-(1-params(8)+exp(y(35)+y(50)))*exp(TRENDY__)*params(1)*exp(y(36)-TRENDY__);
  g1(5,50)=(-(exp(y(35)+y(50))*exp(TRENDY__)*params(1)*exp(y(36)-TRENDY__)));
  g1(6,6)=T410;
  g1(6,7)=T410;
  g1(6,28)=T409*T998+T407*exp(y(28))*getPowerDeriv(exp(y(28)),(-params(31)),1);
  g1(6,30)=T409*T1025;
  g1(6,36)=(-exp(y(38)+y(36)-y(43)));
  g1(6,38)=(-exp(y(38)+y(36)-y(43)));
  g1(6,43)=exp(y(38)+y(36)-y(43));
  g1(7,6)=T417;
  g1(7,7)=T417;
  g1(7,28)=T416*T998;
  g1(7,30)=T416*T1025+T407*exp(y(30))*getPowerDeriv(exp(y(30)),(-params(31)),1);
  g1(7,36)=(-exp(y(40)+y(36)-y(45)));
  g1(7,40)=(-exp(y(40)+y(36)-y(45)));
  g1(7,45)=exp(y(40)+y(36)-y(45));
  g1(8,8)=(-(exp(y(8))-exp(y(8)+y(33)-y(21)-TRENDY__)));
  g1(8,10)=exp(y(10));
  g1(8,21)=(-exp(y(8)+y(33)-y(21)-TRENDY__));
  g1(8,23)=exp(y(32)+y(23))-(1-params(9))*exp(y(32)+y(23)-TRENDH__);
  g1(8,29)=(-exp(y(39)+y(29)));
  g1(8,31)=(-exp(y(41)+y(31)));
  g1(8,32)=exp(y(32)+y(23))-(1-params(9))*exp(y(32)+y(23)-TRENDH__);
  g1(8,33)=exp(y(8)+y(33)-y(21)-TRENDY__);
  g1(8,39)=(-exp(y(39)+y(29)));
  g1(8,41)=(-exp(y(41)+y(31)));
  g1(9,3)=(-(params(4)*exp(y(7)+y(3)-y(23))));
  g1(9,7)=(-(params(4)*exp(y(7)+y(3)-y(23))));
  g1(9,21)=(-(params(3)*exp(y(27)+y(21)+TRENDQ__+y(32)-y(33))));
  g1(9,23)=(-(params(4)*(-exp(y(7)+y(3)-y(23)))));
  g1(9,27)=(-(params(3)*exp(y(27)+y(21)+TRENDQ__+y(32)-y(33))));
  g1(9,32)=exp(y(32)+y(37))-((1-params(9))*exp(TRENDY__)*params(2)*exp(TRENDQ__+y(32)+y(37)-TRENDY__)+params(3)*exp(y(27)+y(21)+TRENDQ__+y(32)-y(33)));
  g1(9,33)=(-(params(3)*(-exp(y(27)+y(21)+TRENDQ__+y(32)-y(33)))));
  g1(9,37)=exp(y(32)+y(37))-(1-params(9))*exp(TRENDY__)*params(2)*exp(TRENDQ__+y(32)+y(37)-TRENDY__);
  g1(10,8)=1;
  g1(10,21)=(-1);
  g1(10,23)=(-1);
  g1(10,32)=(-1);
  g1(10,33)=1;
  g1(11,21)=(-(exp(TRENDY__)*params(2)*(-exp(y(33)-y(21)+y(37)-TRENDY__))));
  g1(11,27)=(-exp(y(27)));
  g1(11,33)=(-(exp(TRENDY__)*params(2)*exp(y(33)-y(21)+y(37)-TRENDY__)));
  g1(11,37)=exp(y(37))-exp(TRENDY__)*params(2)*exp(y(33)-y(21)+y(37)-TRENDY__);
  g1(12,6)=T489;
  g1(12,7)=T489;
  g1(12,29)=T488*T1012+T486*exp(y(29))*getPowerDeriv(exp(y(29)),(-params(32)),1);
  g1(12,31)=T488*T1037;
  g1(12,37)=(-exp(y(39)+y(37)-y(44)));
  g1(12,39)=(-exp(y(39)+y(37)-y(44)));
  g1(12,44)=exp(y(39)+y(37)-y(44));
  g1(13,6)=T496;
  g1(13,7)=T496;
  g1(13,29)=T495*T1012;
  g1(13,31)=T495*T1037+T486*exp(y(31))*getPowerDeriv(exp(y(31)),(-params(32)),1);
  g1(13,37)=(-exp(y(41)+y(37)-y(46)));
  g1(13,41)=(-exp(y(41)+y(37)-y(46)));
  g1(13,46)=exp(y(41)+y(37)-y(46));
  g1(14,1)=(-(1-params(5)));
  g1(14,25)=(-params(5));
  g1(14,28)=(-((1-params(5))*params(16)));
  g1(14,29)=(-((1-params(5))*(1-params(16))));
  g1(14,47)=1;
  g1(14,49)=(-params(5));
  g1(15,2)=(-(1-params(6)-params(43)-params(33)));
  g1(15,24)=1-params(43);
  g1(15,26)=(-params(6));
  g1(15,30)=(-(params(16)*(1-params(6)-params(43)-params(33))));
  g1(15,31)=(-((1-params(16))*(1-params(6)-params(43)-params(33))));
  g1(15,32)=(-params(43));
  g1(15,50)=(-params(6));
  g1(16,28)=(-1);
  g1(16,38)=(-1);
  g1(16,42)=(-1);
  g1(16,47)=1;
  g1(17,29)=(-1);
  g1(17,39)=(-1);
  g1(17,42)=(-1);
  g1(17,47)=1;
  g1(18,24)=1;
  g1(18,30)=(-1);
  g1(18,32)=1;
  g1(18,40)=(-1);
  g1(19,24)=1;
  g1(19,31)=(-1);
  g1(19,32)=1;
  g1(19,41)=(-1);
  g1(20,25)=(-1);
  g1(20,34)=(-1);
  g1(20,42)=(-1);
  g1(20,47)=1;
  g1(20,49)=(-1);
  g1(21,24)=1;
  g1(21,26)=(-1);
  g1(21,32)=1;
  g1(21,35)=(-1);
  g1(21,50)=(-1);
  g1(22,21)=1-params(22)-exp(TRENDY__)*params(1)*(1-params(22));
  g1(22,42)=(1-params(17))*(1-exp(TRENDY__)*params(1)*params(17))/params(17);
  g1(23,5)=0.01;
  g1(23,21)=(-((1-params(18))*params(20)));
  g1(23,33)=1-params(18);
  g1(24,22)=exp(y(22))-(1-params(9))*exp(y(22)-TRENDH__);
  g1(24,23)=exp(y(23))-(1-params(9))*exp(y(23)-TRENDH__);
  g1(24,24)=(-exp(y(24)));
  g1(25,7)=(-T635);
  g1(25,9)=(-(exp(y(7))*T622*((-(exp(y(9))-params(12)*exp(y(9)-TRENDY__)))/((exp(y(9))-params(12)*exp(y(9)-TRENDY__))*(exp(y(9))-params(12)*exp(y(9)-TRENDY__)))-(-(exp(TRENDY__)*params(1)*params(12)*(exp(TRENDY__+y(9))-exp(y(9))*params(12))))/((exp(TRENDY__+y(9))-exp(y(9))*params(12))*(exp(TRENDY__+y(9))-exp(y(9))*params(12))))));
  g1(25,36)=exp(y(36));
  g1(26,7)=(-T655);
  g1(26,10)=(-(exp(y(7))*T642*((-(exp(y(10))-params(13)*exp(y(10)-TRENDY__)))/((exp(y(10))-params(13)*exp(y(10)-TRENDY__))*(exp(y(10))-params(13)*exp(y(10)-TRENDY__)))-(-(exp(TRENDY__)*params(2)*params(13)*(exp(TRENDY__+y(10))-exp(y(10))*params(13))))/((exp(TRENDY__+y(10))-exp(y(10))*params(13))*(exp(TRENDY__+y(10))-exp(y(10))*params(13))))));
  g1(26,37)=exp(y(37));
  g1(27,21)=(-(params(37)/(1+exp(TRENDY__)*params(1))+1-T658-(1+exp(TRENDY__)*params(1)*params(37))/(1+exp(TRENDY__)*params(1))));
  g1(27,38)=1-(T658+1-T658);
  g1(27,43)=T679;
  g1(28,21)=(-(params(37)/(1+exp(TRENDY__)*params(2))+1-T686-(1+exp(TRENDY__)*params(2)*params(37))/(1+exp(TRENDY__)*params(2))));
  g1(28,39)=1-(T686+1-T686);
  g1(28,44)=T704;
  g1(29,21)=(-(params(38)/(1+exp(TRENDY__)*params(1))+1-T658-(1+exp(TRENDY__)*params(1)*params(38))/(1+exp(TRENDY__)*params(1))));
  g1(29,40)=1-(T658+1-T658);
  g1(29,45)=T728;
  g1(30,21)=(-(params(38)/(1+exp(TRENDY__)*params(2))+1-T686-(1+exp(TRENDY__)*params(2)*params(38))/(1+exp(TRENDY__)*params(2))));
  g1(30,41)=1-(T686+1-T686);
  g1(30,46)=T749;
  g1(31,4)=T758;
  g1(31,34)=T758;
  g1(31,49)=(-(params(39)/(1-params(39))*exp(y(49))));
  g1(32,35)=T769;
  g1(32,50)=(-(params(39)/(1-params(39))*exp(y(50))));
  g1(33,9)=(-(exp(y(9))/(exp(y(9))+exp(y(10)))));
  g1(33,10)=(-(exp(y(10))/(exp(y(9))+exp(y(10)))));
  g1(33,11)=1;
  g1(34,12)=1;
  g1(34,21)=(-1);
  g1(35,13)=1;
  g1(35,24)=(-1);
  g1(36,14)=1;
  g1(36,25)=(-((exp(y(25))-(1-params(7))*exp(y(25)-TRENDK__))/T793));
  g1(36,26)=(-((exp(y(26))-(1-params(8))*exp(y(26)-TRENDY__))/T793));
  g1(37,15)=1;
  g1(37,28)=(-params(16));
  g1(37,29)=(-(1-params(16)));
  g1(38,16)=1;
  g1(38,30)=(-params(16));
  g1(38,31)=(-(1-params(16)));
  g1(39,17)=1;
  g1(39,32)=(-1);
  g1(40,18)=1;
  g1(40,33)=(-1);
  g1(41,19)=1;
  g1(41,21)=(-1);
  g1(42,20)=1;
  g1(42,21)=(-1);
  g1(43,11)=(-T839);
  g1(43,13)=(-T846);
  g1(43,14)=(-T842);
  g1(43,48)=1;
  g1(44,1)=1-params(23);
  g1(45,2)=1-params(24);
  g1(46,3)=1-params(25);
  g1(47,4)=1-params(26);
  g1(48,6)=1-params(28);
  g1(49,5)=1-params(30);
  g1(50,7)=1-params(29);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],50,2500);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],50,125000);
end
end
end
end
