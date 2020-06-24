function [residual, g1, g2, g3] = DNGS15_cql_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(49, 1);
T19 = (-(1-params(14)*exp((-params(45)))))/(params(20)*(1+params(14)*exp((-params(45)))));
T26 = params(14)*exp((-params(45)))/(1+params(14)*exp((-params(45))));
T32 = 1/(1+params(14)*exp((-params(45))));
T41 = (params(20)-1)*params(56)/(params(20)*(1+params(14)*exp((-params(45)))));
T77 = params(19)*exp(2*params(45))*(1+params(41)*exp(params(45)*(1-params(20))));
T79 = 1/(1+params(41)*exp(params(45)*(1-params(20))));
T84 = params(41)*exp(params(45)*(1-params(20)))/(1+params(41)*exp(params(45)*(1-params(20))));
T113 = params(48)/(1+params(48)-params(23));
T117 = (1-params(23))/(1+params(48)-params(23));
T126 = (-(params(20)*(1+params(14)*exp((-params(45))))))/(1-params(14)*exp((-params(45))));
T174 = params(20)*(1+params(14)*exp((-params(45))))/(1-params(14)*exp((-params(45))));
T220 = params(53)/params(52);
T229 = (1+params(41)*exp(params(45)*(1-params(20))))*exp(2*params(45))*params(19)*params(53)/params(52);
T230 = y(47)*T229;
T266 = (1-exp(params(45)*(1-params(20)))*params(41)*params(5))*(1-params(5))/(params(5)*(1+(params(13)-1)*params(28)))/(1+exp(params(45)*(1-params(20)))*params(41)*params(6));
T272 = params(41)*exp(params(45)*(1-params(20)))/(1+exp(params(45)*(1-params(20)))*params(41)*params(6));
T286 = (-1)/(1-params(14)*exp((-params(45))));
T288 = params(14)*exp((-params(45)))/(1-params(14)*exp((-params(45))));
T319 = (-(1-exp(params(45)*(1-params(20)))*params(41)*params(7)))*(1-params(7))/(params(7)*(1+(params(25)-1)*params(29)))/(1+params(41)*exp(params(45)*(1-params(20))));
T325 = (1+exp(params(45)*(1-params(20)))*params(41)*params(8))/(1+params(41)*exp(params(45)*(1-params(20))));
T379 = 1/(1-params(12));
lhs =y(25);
rhs =T19*(y(32)-y(76))+y(42)+T26*(y(2)-y(40))+T32*(y(73)+y(79))+T41*(y(29)-y(75));
residual(1)= lhs-rhs;
lhs =y(58);
rhs =y(42)+T19*y(63)+T26*(y(19)-y(40))+T32*(y(79)+y(80))+T41*(y(62)-y(82));
residual(2)= lhs-rhs;
lhs =y(37);
rhs =T77*(y(26)-T79*(y(3)-y(40))-T84*(y(79)+y(74))-y(47));
residual(3)= lhs-rhs;
lhs =y(67);
rhs =T77*(y(59)-T79*(y(20)-y(40))-T84*(y(79)+y(81))-y(47));
residual(4)= lhs-rhs;
lhs =y(38)-y(31);
rhs =T113*y(33)+y(37)*T117-y(8);
residual(5)= lhs-rhs;
lhs =y(78)-y(32);
rhs =y(42)*T126+params(9)*(y(37)+y(28)-y(39))+y(46);
residual(6)= lhs-rhs;
lhs =y(39);
rhs =(y(38)-y(31))*params(91)-params(92)*(y(6)-y(31))+params(93)*(y(8)+y(4))+params(94)*y(9)-params(96)/params(84)*y(15)-y(40)*params(10)*params(76)/params(75);
residual(7)= lhs-rhs;
lhs =T113*y(83)+T117*y(84)-y(67);
rhs =y(63)-y(42)*T174;
residual(8)= lhs-rhs;
lhs =y(24);
rhs =params(13)*(params(12)*y(27)+y(29)*(1-params(12)))+(params(13)-1)/(1-params(12))*y(41);
residual(9)= lhs-rhs;
lhs =y(57);
rhs =(params(13)-1)/(1-params(12))*y(41)+params(13)*(params(12)*y(60)+y(62)*(1-params(12)));
residual(10)= lhs-rhs;
lhs =y(27);
rhs =y(4)+y(34)-y(40);
residual(11)= lhs-rhs;
lhs =y(60);
rhs =y(65)-y(40)+y(21);
residual(12)= lhs-rhs;
lhs =y(34);
rhs =y(33)*(1-params(21))/params(21);
residual(13)= lhs-rhs;
lhs =y(65);
rhs =(1-params(21))/params(21)*y(64);
residual(14)= lhs-rhs;
lhs =y(28);
rhs =(1-T220)*(y(4)-y(40))+y(26)*T220+T230;
residual(15)= lhs-rhs;
lhs =y(61);
rhs =T230+(1-T220)*(y(21)-y(40))+y(59)*T220;
residual(16)= lhs-rhs;
lhs =y(30);
rhs =y(35)+y(29)*params(12)-params(12)*y(27);
residual(17)= lhs-rhs;
lhs =0;
rhs =y(66)+y(62)*params(12)-params(12)*y(60);
residual(18)= lhs-rhs;
lhs =y(31);
rhs =y(30)*T266+params(6)/(1+exp(params(45)*(1-params(20)))*params(41)*params(6))*y(5)+y(76)*T272+y(44);
residual(19)= lhs-rhs;
lhs =y(27);
rhs =y(29)+y(35)-y(33);
residual(20)= lhs-rhs;
lhs =y(60);
rhs =y(62)+y(66)-y(64);
residual(21)= lhs-rhs;
lhs =y(36)-y(35);
rhs =y(25)*T286+y(2)*T288-y(40)*T288-y(29)*params(15);
residual(22)= lhs-rhs;
lhs =0;
rhs =y(66)+y(58)*T286+y(19)*T288-y(40)*T288-y(62)*params(15);
residual(23)= lhs-rhs;
lhs =y(35);
rhs =y(36)*T319-y(31)*T325+T79*(y(7)-y(40)-y(5)*params(8))+T84*(y(76)+y(79)+y(77))+y(45);
residual(24)= lhs-rhs;
lhs =y(32);
rhs =y(6)*params(4)+(1-params(4))*(y(31)*params(1)+params(2)*(y(24)-y(57)))+params(3)*(y(24)-y(57)-(y(1)-y(18)))+y(48);
residual(25)= lhs-rhs;
lhs =y(24);
rhs =params(24)*y(43)+y(25)*params(55)/params(54)+y(26)*params(53)/params(54)+y(34)*params(48)*params(51)/params(54)+y(41)*params(24)*T379;
residual(26)= lhs-rhs;
lhs =y(57);
rhs =y(41)*params(24)*T379+params(24)*y(43)+y(58)*params(55)/params(54)+y(59)*params(53)/params(54)+y(65)*params(48)*params(51)/params(54);
residual(27)= lhs-rhs;
lhs =y(40);
rhs =T379*(params(30)-1)*y(10)+T379*x(it_, 1);
residual(28)= lhs-rhs;
lhs =y(41);
rhs =x(it_, 1)+params(30)*y(10);
residual(29)= lhs-rhs;
lhs =y(43);
rhs =params(35)*y(12)+x(it_, 2)+x(it_, 1)*params(38);
residual(30)= lhs-rhs;
lhs =y(42);
rhs =params(31)*y(11)+x(it_, 3);
residual(31)= lhs-rhs;
lhs =y(47);
rhs =params(34)*y(16)+x(it_, 4);
residual(32)= lhs-rhs;
lhs =y(44);
rhs =params(32)*y(13)+x(it_, 5)-params(36)*y(22);
residual(33)= lhs-rhs;
lhs =y(45);
rhs =params(33)*y(14)+x(it_, 6)-params(37)*y(23);
residual(34)= lhs-rhs;
lhs =y(48);
rhs =params(40)*y(17)+x(it_, 8);
residual(35)= lhs-rhs;
lhs =y(46);
rhs =y(15)*params(39)+x(it_, 7);
residual(36)= lhs-rhs;
lhs =y(68);
rhs =y(24)-y(57);
residual(37)= lhs-rhs;
lhs =y(69)/4;
rhs =y(63)+params(47)-100*(params(42)-1);
residual(38)= lhs-rhs;
lhs =y(70)/4;
rhs =y(32)-y(76)+params(47)-100*(params(42)-1);
residual(39)= lhs-rhs;
lhs =y(49);
rhs =y(40)+y(24)-y(1)+100*(exp(params(45))-1);
residual(40)= lhs-rhs;
lhs =y(54);
rhs =100*(exp(params(45))-1)+y(40)+y(25)-y(2);
residual(41)= lhs-rhs;
lhs =y(55);
rhs =100*(exp(params(45))-1)+y(40)+y(26)-y(3);
residual(42)= lhs-rhs;
lhs =y(51);
rhs =100*(exp(params(45))-1)+y(40)+y(35)-y(7);
residual(43)= lhs-rhs;
lhs =y(53);
rhs =y(32)+params(47);
residual(44)= lhs-rhs;
lhs =y(52);
rhs =y(31)+100*(params(42)-1);
residual(45)= lhs-rhs;
lhs =y(56);
rhs =y(78)-y(32)+100*log(params(43));
residual(46)= lhs-rhs;
lhs =y(50);
rhs =y(29)+params(22);
residual(47)= lhs-rhs;
lhs =y(71);
rhs =x(it_, 5);
residual(48)= lhs-rhs;
lhs =y(72);
rhs =x(it_, 6);
residual(49)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(49, 92);

  %
  % Jacobian matrix
  %

  g1(1,2)=(-T26);
  g1(1,25)=1;
  g1(1,73)=(-T32);
  g1(1,29)=(-T41);
  g1(1,75)=T41;
  g1(1,76)=T19;
  g1(1,32)=(-T19);
  g1(1,40)=T26;
  g1(1,79)=(-T32);
  g1(1,42)=(-1);
  g1(2,40)=T26;
  g1(2,79)=(-T32);
  g1(2,42)=(-1);
  g1(2,19)=(-T26);
  g1(2,58)=1;
  g1(2,80)=(-T32);
  g1(2,62)=(-T41);
  g1(2,82)=T41;
  g1(2,63)=(-T19);
  g1(3,3)=(-(T77*(-T79)));
  g1(3,26)=(-T77);
  g1(3,74)=(-(T77*(-T84)));
  g1(3,37)=1;
  g1(3,40)=(-(T77*T79));
  g1(3,79)=(-(T77*(-T84)));
  g1(3,47)=T77;
  g1(4,40)=(-(T77*T79));
  g1(4,79)=(-(T77*(-T84)));
  g1(4,47)=T77;
  g1(4,20)=(-(T77*(-T79)));
  g1(4,59)=(-T77);
  g1(4,81)=(-(T77*(-T84)));
  g1(4,67)=1;
  g1(5,31)=(-1);
  g1(5,33)=(-T113);
  g1(5,8)=1;
  g1(5,37)=(-T117);
  g1(5,38)=1;
  g1(6,28)=(-params(9));
  g1(6,32)=(-1);
  g1(6,37)=(-params(9));
  g1(6,78)=1;
  g1(6,39)=params(9);
  g1(6,42)=(-T126);
  g1(6,46)=(-1);
  g1(7,4)=(-params(93));
  g1(7,31)=(-((-params(91))-(-params(92))));
  g1(7,6)=params(92);
  g1(7,8)=(-params(93));
  g1(7,38)=(-params(91));
  g1(7,9)=(-params(94));
  g1(7,39)=1;
  g1(7,40)=params(10)*params(76)/params(75);
  g1(7,15)=params(96)/params(84);
  g1(8,42)=T174;
  g1(8,63)=(-1);
  g1(8,83)=T113;
  g1(8,67)=(-1);
  g1(8,84)=T117;
  g1(9,24)=1;
  g1(9,27)=(-(params(13)*params(12)));
  g1(9,29)=(-(params(13)*(1-params(12))));
  g1(9,41)=(-((params(13)-1)/(1-params(12))));
  g1(10,41)=(-((params(13)-1)/(1-params(12))));
  g1(10,57)=1;
  g1(10,60)=(-(params(13)*params(12)));
  g1(10,62)=(-(params(13)*(1-params(12))));
  g1(11,27)=1;
  g1(11,4)=(-1);
  g1(11,34)=(-1);
  g1(11,40)=1;
  g1(12,40)=1;
  g1(12,60)=1;
  g1(12,21)=(-1);
  g1(12,65)=(-1);
  g1(13,33)=(-((1-params(21))/params(21)));
  g1(13,34)=1;
  g1(14,64)=(-((1-params(21))/params(21)));
  g1(14,65)=1;
  g1(15,26)=(-T220);
  g1(15,4)=(-(1-T220));
  g1(15,28)=1;
  g1(15,40)=1-T220;
  g1(15,47)=(-T229);
  g1(16,40)=1-T220;
  g1(16,47)=(-T229);
  g1(16,59)=(-T220);
  g1(16,21)=(-(1-T220));
  g1(16,61)=1;
  g1(17,27)=params(12);
  g1(17,29)=(-params(12));
  g1(17,30)=1;
  g1(17,35)=(-1);
  g1(18,60)=params(12);
  g1(18,62)=(-params(12));
  g1(18,66)=(-1);
  g1(19,30)=(-T266);
  g1(19,5)=(-(params(6)/(1+exp(params(45)*(1-params(20)))*params(41)*params(6))));
  g1(19,31)=1;
  g1(19,76)=(-T272);
  g1(19,44)=(-1);
  g1(20,27)=1;
  g1(20,29)=(-1);
  g1(20,33)=1;
  g1(20,35)=(-1);
  g1(21,60)=1;
  g1(21,62)=(-1);
  g1(21,64)=1;
  g1(21,66)=(-1);
  g1(22,2)=(-T288);
  g1(22,25)=(-T286);
  g1(22,29)=params(15);
  g1(22,35)=(-1);
  g1(22,36)=1;
  g1(22,40)=T288;
  g1(23,40)=T288;
  g1(23,19)=(-T288);
  g1(23,58)=(-T286);
  g1(23,62)=params(15);
  g1(23,66)=(-1);
  g1(24,5)=(-(T79*(-params(8))));
  g1(24,31)=T325;
  g1(24,76)=(-T84);
  g1(24,7)=(-T79);
  g1(24,35)=1;
  g1(24,77)=(-T84);
  g1(24,36)=(-T319);
  g1(24,40)=T79;
  g1(24,79)=(-T84);
  g1(24,45)=(-1);
  g1(25,1)=params(3);
  g1(25,24)=(-(params(3)+(1-params(4))*params(2)));
  g1(25,31)=(-((1-params(4))*params(1)));
  g1(25,6)=(-params(4));
  g1(25,32)=1;
  g1(25,48)=(-1);
  g1(25,18)=(-params(3));
  g1(25,57)=(-((1-params(4))*(-params(2))-params(3)));
  g1(26,24)=1;
  g1(26,25)=(-(params(55)/params(54)));
  g1(26,26)=(-(params(53)/params(54)));
  g1(26,34)=(-(params(48)*params(51)/params(54)));
  g1(26,41)=(-(params(24)*T379));
  g1(26,43)=(-params(24));
  g1(27,41)=(-(params(24)*T379));
  g1(27,43)=(-params(24));
  g1(27,57)=1;
  g1(27,58)=(-(params(55)/params(54)));
  g1(27,59)=(-(params(53)/params(54)));
  g1(27,65)=(-(params(48)*params(51)/params(54)));
  g1(28,40)=1;
  g1(28,10)=(-(T379*(params(30)-1)));
  g1(28,85)=(-T379);
  g1(29,10)=(-params(30));
  g1(29,41)=1;
  g1(29,85)=(-1);
  g1(30,12)=(-params(35));
  g1(30,43)=1;
  g1(30,85)=(-params(38));
  g1(30,86)=(-1);
  g1(31,11)=(-params(31));
  g1(31,42)=1;
  g1(31,87)=(-1);
  g1(32,16)=(-params(34));
  g1(32,47)=1;
  g1(32,88)=(-1);
  g1(33,13)=(-params(32));
  g1(33,44)=1;
  g1(33,89)=(-1);
  g1(33,22)=params(36);
  g1(34,14)=(-params(33));
  g1(34,45)=1;
  g1(34,90)=(-1);
  g1(34,23)=params(37);
  g1(35,17)=(-params(40));
  g1(35,48)=1;
  g1(35,92)=(-1);
  g1(36,15)=(-params(39));
  g1(36,46)=1;
  g1(36,91)=(-1);
  g1(37,24)=(-1);
  g1(37,57)=1;
  g1(37,68)=1;
  g1(38,63)=(-1);
  g1(38,69)=0.25;
  g1(39,76)=1;
  g1(39,32)=(-1);
  g1(39,70)=0.25;
  g1(40,1)=1;
  g1(40,24)=(-1);
  g1(40,40)=(-1);
  g1(40,49)=1;
  g1(41,2)=1;
  g1(41,25)=(-1);
  g1(41,40)=(-1);
  g1(41,54)=1;
  g1(42,3)=1;
  g1(42,26)=(-1);
  g1(42,40)=(-1);
  g1(42,55)=1;
  g1(43,7)=1;
  g1(43,35)=(-1);
  g1(43,40)=(-1);
  g1(43,51)=1;
  g1(44,32)=(-1);
  g1(44,53)=1;
  g1(45,31)=(-1);
  g1(45,52)=1;
  g1(46,32)=1;
  g1(46,78)=(-1);
  g1(46,56)=1;
  g1(47,29)=(-1);
  g1(47,50)=1;
  g1(48,89)=(-1);
  g1(48,71)=1;
  g1(49,90)=(-1);
  g1(49,72)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],49,8464);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],49,778688);
end
end
end
end
