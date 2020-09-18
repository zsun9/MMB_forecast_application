function [residual, g1, g2, g3] = FU20_dynamic(y, x, params, steady_state, it_)
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
T11 = params(1)/params(2);
T25 = (params(3)-1)*params(4)/((1+T11)*params(3));
T32 = (1-T11)/((1+T11)*params(3));
T45 = 1/(1+params(2)*params(6));
T52 = params(2)^2*params(7);
T73 = (1-params(9))/(1+params(8)-params(9));
T82 = 1/(params(44)/(1-params(44)));
T138 = (1-params(2)*params(6)*params(13))*(1-params(13))/(1+params(2)*params(6)*params(14))/params(13)/(1+params(15)*params(45));
T165 = (1-params(2)*params(6)*params(16))*(1-params(16))/params(16)/(1+params(19)*params(46));
T166 = 1/(1-T11);
T168 = T11/(1-T11);
T272 = params(10)*(params(2)*params(25))^(-1);
lhs =y(32);
rhs =T11/(1+T11)*y(3)+1/(1+T11)*y(64)+T25*(y(34)-y(65))-T32*(y(33)-y(63))+y(55);
residual(1)= lhs-rhs;
lhs =y(38);
rhs =T45*(y(6)+params(2)*params(6)*y(66)+1/T52*y(39))+y(56);
residual(2)= lhs-rhs;
lhs =y(39);
rhs =y(55)*1/T32-(y(33)-y(63))+params(8)/(1+params(8)-params(9))*y(62)+T73*y(67);
residual(3)= lhs-rhs;
lhs =y(36);
rhs =T82*y(30);
residual(4)= lhs-rhs;
lhs =y(35);
rhs =y(36)+y(5);
residual(5)= lhs-rhs;
lhs =y(37);
rhs =y(5)*(1-params(47))+params(47)*(y(38)+T52*y(56));
residual(6)= lhs-rhs;
lhs =y(40);
rhs =params(11)*y(52)+y(35)*params(11)*params(12)+y(34)*params(11)*(1-params(12));
residual(7)= lhs-rhs;
lhs =y(35);
rhs =y(34)+y(29)-y(30);
residual(8)= lhs-rhs;
lhs =y(28);
rhs =y(30)*params(12)+(1-params(12))*y(29)-y(52);
residual(9)= lhs-rhs;
lhs =y(31);
rhs =y(28)*T138+y(53)+params(14)/(1+params(2)*params(6)*params(14))*y(2)+y(63)*params(2)*params(6)/(1+params(2)*params(6)*params(14));
residual(10)= lhs-rhs;
lhs =y(29);
rhs =T45*(y(1)+params(2)*params(6)*y(61)+T165*(y(32)*T166-y(3)*T168+y(34)*params(17)-y(29))-y(31)*(1+params(2)*params(6)*params(18))+y(2)*params(18)+y(63)*params(2)*params(6))+y(54);
residual(11)= lhs-rhs;
lhs =y(33);
rhs =params(20)*y(4)+(1-params(20))*(y(31)*params(21)+params(22)*(y(40)-y(50)))+params(23)*(y(40)-y(7)-(y(50)-y(11)))+y(58);
residual(12)= lhs-rhs;
lhs =y(40);
rhs =y(32)*params(24)+y(38)*params(10)+y(57)+y(36)*params(8)*params(25);
residual(13)= lhs-rhs;
lhs =y(43);
rhs =y(55)+T11/(1+T11)*y(8)+1/(1+T11)*y(69)+T25*(y(45)-y(70))-T32*y(44);
residual(14)= lhs-rhs;
lhs =y(49);
rhs =y(56)+T45*(y(10)+params(2)*params(6)*y(71)+1/T52*y(51));
residual(15)= lhs-rhs;
lhs =y(51);
rhs =y(55)*1/T32-y(44)+params(8)/(1+params(8)-params(9))*y(68)+T73*y(72);
residual(16)= lhs-rhs;
lhs =y(47);
rhs =T82*y(42);
residual(17)= lhs-rhs;
lhs =y(46);
rhs =y(47)+y(9);
residual(18)= lhs-rhs;
lhs =y(48);
rhs =y(9)*(1-T272)+T272*(T52*y(56)+y(49));
residual(19)= lhs-rhs;
lhs =y(50);
rhs =params(11)*y(52)+params(11)*params(12)*y(46)+params(11)*(1-params(12))*y(45);
residual(20)= lhs-rhs;
lhs =y(46);
rhs =y(45)+y(41)-y(42);
residual(21)= lhs-rhs;
lhs =0;
rhs =params(12)*y(42)+(1-params(12))*y(41)-y(52);
residual(22)= lhs-rhs;
lhs =y(41);
rhs =T166*y(43)-T168*y(8)+params(17)*y(45);
residual(23)= lhs-rhs;
lhs =y(50);
rhs =y(57)+params(24)*y(43)+params(10)*y(49)+params(8)*params(25)*y(47);
residual(24)= lhs-rhs;
lhs =y(52);
rhs =params(34)*y(12)+x(it_, 1);
residual(25)= lhs-rhs;
lhs =y(55);
rhs =params(35)*y(15)+x(it_, 4);
residual(26)= lhs-rhs;
lhs =y(57);
rhs =params(36)*y(17)+x(it_, 6)+x(it_, 1)*params(37);
residual(27)= lhs-rhs;
lhs =y(56);
rhs =params(38)*y(16)+x(it_, 5);
residual(28)= lhs-rhs;
lhs =y(53);
rhs =params(39)*y(13)+x(it_, 2)-params(40)*y(19);
residual(29)= lhs-rhs;
lhs =y(54);
rhs =params(41)*y(14)+x(it_, 3)-params(42)*y(20);
residual(30)= lhs-rhs;
lhs =y(58);
rhs =params(43)*y(18)+x(it_, 7);
residual(31)= lhs-rhs;
lhs =y(24);
rhs =y(40)-y(7)+params(29);
residual(32)= lhs-rhs;
lhs =y(25);
rhs =params(29)+y(32)-y(3);
residual(33)= lhs-rhs;
lhs =y(26);
rhs =params(29)+y(38)-y(6);
residual(34)= lhs-rhs;
lhs =y(27);
rhs =params(29)+y(29)-y(1);
residual(35)= lhs-rhs;
lhs =y(23);
rhs =y(31)+params(30);
residual(36)= lhs-rhs;
lhs =y(22);
rhs =y(33)+params(31);
residual(37)= lhs-rhs;
lhs =y(21);
rhs =y(34)+params(32);
residual(38)= lhs-rhs;
lhs =y(59);
rhs =x(it_, 2);
residual(39)= lhs-rhs;
lhs =y(60);
rhs =x(it_, 3);
residual(40)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(40, 79);

  %
  % Jacobian matrix
  %

  g1(1,63)=(-T32);
  g1(1,3)=(-(T11/(1+T11)));
  g1(1,32)=1;
  g1(1,64)=(-(1/(1+T11)));
  g1(1,33)=T32;
  g1(1,34)=(-T25);
  g1(1,65)=T25;
  g1(1,55)=(-1);
  g1(2,6)=(-T45);
  g1(2,38)=1;
  g1(2,66)=(-(params(2)*params(6)*T45));
  g1(2,39)=(-(T45*1/T52));
  g1(2,56)=(-1);
  g1(3,62)=(-(params(8)/(1+params(8)-params(9))));
  g1(3,63)=(-1);
  g1(3,33)=1;
  g1(3,39)=1;
  g1(3,67)=(-T73);
  g1(3,55)=(-(1/T32));
  g1(4,30)=(-T82);
  g1(4,36)=1;
  g1(5,35)=1;
  g1(5,36)=(-1);
  g1(5,5)=(-1);
  g1(6,5)=(-(1-params(47)));
  g1(6,37)=1;
  g1(6,38)=(-params(47));
  g1(6,56)=(-(T52*params(47)));
  g1(7,34)=(-(params(11)*(1-params(12))));
  g1(7,35)=(-(params(11)*params(12)));
  g1(7,40)=1;
  g1(7,52)=(-params(11));
  g1(8,29)=(-1);
  g1(8,30)=1;
  g1(8,34)=(-1);
  g1(8,35)=1;
  g1(9,28)=1;
  g1(9,29)=(-(1-params(12)));
  g1(9,30)=(-params(12));
  g1(9,52)=1;
  g1(10,28)=(-T138);
  g1(10,2)=(-(params(14)/(1+params(2)*params(6)*params(14))));
  g1(10,31)=1;
  g1(10,63)=(-(params(2)*params(6)/(1+params(2)*params(6)*params(14))));
  g1(10,53)=(-1);
  g1(11,1)=(-T45);
  g1(11,29)=1-T45*(-T165);
  g1(11,61)=(-(params(2)*params(6)*T45));
  g1(11,2)=(-(T45*params(18)));
  g1(11,31)=(-(T45*(-(1+params(2)*params(6)*params(18)))));
  g1(11,63)=(-(params(2)*params(6)*T45));
  g1(11,3)=(-(T45*T165*(-T168)));
  g1(11,32)=(-(T45*T165*T166));
  g1(11,34)=(-(T45*T165*params(17)));
  g1(11,54)=(-1);
  g1(12,31)=(-((1-params(20))*params(21)));
  g1(12,4)=(-params(20));
  g1(12,33)=1;
  g1(12,7)=params(23);
  g1(12,40)=(-(params(23)+(1-params(20))*params(22)));
  g1(12,11)=(-params(23));
  g1(12,50)=(-((1-params(20))*(-params(22))-params(23)));
  g1(12,58)=(-1);
  g1(13,32)=(-params(24));
  g1(13,36)=(-(params(8)*params(25)));
  g1(13,38)=(-params(10));
  g1(13,40)=1;
  g1(13,57)=(-1);
  g1(14,8)=(-(T11/(1+T11)));
  g1(14,43)=1;
  g1(14,69)=(-(1/(1+T11)));
  g1(14,44)=T32;
  g1(14,45)=(-T25);
  g1(14,70)=T25;
  g1(14,55)=(-1);
  g1(15,10)=(-T45);
  g1(15,49)=1;
  g1(15,71)=(-(params(2)*params(6)*T45));
  g1(15,51)=(-(T45*1/T52));
  g1(15,56)=(-1);
  g1(16,68)=(-(params(8)/(1+params(8)-params(9))));
  g1(16,44)=1;
  g1(16,51)=1;
  g1(16,72)=(-T73);
  g1(16,55)=(-(1/T32));
  g1(17,42)=(-T82);
  g1(17,47)=1;
  g1(18,46)=1;
  g1(18,47)=(-1);
  g1(18,9)=(-1);
  g1(19,9)=(-(1-T272));
  g1(19,48)=1;
  g1(19,49)=(-T272);
  g1(19,56)=(-(T52*T272));
  g1(20,45)=(-(params(11)*(1-params(12))));
  g1(20,46)=(-(params(11)*params(12)));
  g1(20,50)=1;
  g1(20,52)=(-params(11));
  g1(21,41)=(-1);
  g1(21,42)=1;
  g1(21,45)=(-1);
  g1(21,46)=1;
  g1(22,41)=(-(1-params(12)));
  g1(22,42)=(-params(12));
  g1(22,52)=1;
  g1(23,41)=1;
  g1(23,8)=T168;
  g1(23,43)=(-T166);
  g1(23,45)=(-params(17));
  g1(24,43)=(-params(24));
  g1(24,47)=(-(params(8)*params(25)));
  g1(24,49)=(-params(10));
  g1(24,50)=1;
  g1(24,57)=(-1);
  g1(25,12)=(-params(34));
  g1(25,52)=1;
  g1(25,73)=(-1);
  g1(26,15)=(-params(35));
  g1(26,55)=1;
  g1(26,76)=(-1);
  g1(27,17)=(-params(36));
  g1(27,57)=1;
  g1(27,73)=(-params(37));
  g1(27,78)=(-1);
  g1(28,16)=(-params(38));
  g1(28,56)=1;
  g1(28,77)=(-1);
  g1(29,13)=(-params(39));
  g1(29,53)=1;
  g1(29,74)=(-1);
  g1(29,19)=params(40);
  g1(30,14)=(-params(41));
  g1(30,54)=1;
  g1(30,75)=(-1);
  g1(30,20)=params(42);
  g1(31,18)=(-params(43));
  g1(31,58)=1;
  g1(31,79)=(-1);
  g1(32,24)=1;
  g1(32,7)=1;
  g1(32,40)=(-1);
  g1(33,25)=1;
  g1(33,3)=1;
  g1(33,32)=(-1);
  g1(34,26)=1;
  g1(34,6)=1;
  g1(34,38)=(-1);
  g1(35,27)=1;
  g1(35,1)=1;
  g1(35,29)=(-1);
  g1(36,23)=1;
  g1(36,31)=(-1);
  g1(37,22)=1;
  g1(37,33)=(-1);
  g1(38,21)=1;
  g1(38,34)=(-1);
  g1(39,74)=(-1);
  g1(39,59)=1;
  g1(40,75)=(-1);
  g1(40,60)=1;

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
