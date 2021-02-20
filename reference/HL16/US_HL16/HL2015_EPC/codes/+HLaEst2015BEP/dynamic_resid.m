function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = HLaEst2015BEP.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(48, 1);
lhs = y(29);
rhs = (y(76)+(params(5)-1)*y(77)-params(5)*T(4)*(y(73)-params(2)*y(25)))*params(1)*T(9)+(T(5)-y(30))*T(9)+((params(5)-1)*y(77)+y(76)+params(5)*(y(32)+y(35)+y(74)))*(T(2)-params(1))*(1-params(7))*params(6)*T(9);
residual(1) = lhs - rhs;
lhs = y(33);
rhs = params(7)/params(4)*(y(78)+y(37))+T(6)*(y(76)+(params(5)-1)*y(77)+y(29)*params(5))-y(28)+T(2)*y(74)+T(2)*y(35);
residual(2) = lhs - rhs;
lhs = (T(2)-params(1))*y(32);
rhs = params(1)*(y(74)+T(4)*(y(73)-params(2)*y(25)))-T(2)*(T(5)+y(28));
residual(3) = lhs - rhs;
lhs = y(34);
rhs = T(5)+y(37)*params(8)*(1+(T(2)-params(1))*params(6)*params(7))-(T(2)-params(1))*params(6)*params(7)*(y(74)+y(32)+y(35)+y(78));
residual(4) = lhs - rhs;
lhs = y(38);
rhs = (y(39)-params(2)*y(9))*T(7)*0.789/(1-params(2))-(y(74)+T(7)*(y(79)-params(2)*y(39))-y(26))*T(10);
residual(5) = lhs - rhs;
lhs = y(40);
rhs = (y(76)+(params(5)-1)*y(77)-(y(79)-params(2)*y(39))*params(5)*T(7))*params(11)*T(9)+(T(7)*(y(39)-params(2)*y(9))-y(30))*T(9);
residual(6) = lhs - rhs;
lhs = y(34);
rhs = T(7)*(y(39)-params(2)*y(9))+params(8)*y(36);
residual(7) = lhs - rhs;
lhs = y(39)+0.789*y(38)+T(1)*(y(30)+y(40));
rhs = (y(34)+y(36))*T(11)+(y(2)+y(8)-y(27))*0.789*params(3)+T(1)*(y(30)+y(10))+(y(10)+y(31))*T(1)*(params(5)-1);
residual(8) = lhs - rhs;
lhs = y(27);
rhs = y(63)+y(74)*params(11)/(1+params(11)*params(14))+y(3)*params(14)/(1+params(11)*params(14))-y(41)*T(12);
residual(9) = lhs - rhs;
lhs = y(44);
rhs = y(42)-y(41)-y(34);
residual(10) = lhs - rhs;
lhs = (T(3)-params(19))*y(49);
rhs = params(19)*y(74)-T(3)*y(47);
residual(11) = lhs - rhs;
lhs = y(50)-y(12);
rhs = params(19)*(y(84)-y(43))+(y(81)-y(80)-y(43))*T(13)+(y(49)+y(48)+y(82))*(T(3)-params(19))*params(16)*params(17)*1/params(21);
residual(12) = lhs - rhs;
lhs = y(46);
rhs = (y(50)-y(12))*params(21);
residual(13) = lhs - rhs;
lhs = y(45);
rhs = params(17)/params(18)*(y(43)+y(82))+y(76)*(1-params(17))/params(18)-y(47)+T(3)*y(74)+T(3)*y(48);
residual(14) = lhs - rhs;
lhs = y(42);
rhs = params(15)*y(12)+(1-params(15))*y(44)+y(57);
residual(15) = lhs - rhs;
lhs = y(43);
rhs = (1-params(20))*y(12)+params(20)*y(50);
residual(16) = lhs - rhs;
lhs = y(51);
rhs = (1-params(23))*y(16)+params(23)*y(17)+(y(30)-y(5))*(1-params(23))*params(34)-y(27)*(1-(1-params(23))*params(34));
residual(17) = lhs - rhs;
lhs = y(53);
rhs = y(26)-T(8)*(y(51)-y(54));
residual(18) = lhs - rhs;
lhs = y(47);
rhs = params(26)/(params(26)+params(27)-1+params(26)*params(28))*y(14)+params(26)*params(28)/(params(26)+params(27)-1+params(26)*params(28))*y(83)+y(53)*(params(27)-1)/(params(26)+params(27)-1+params(26)*params(28))-y(60)/(params(26)+params(27)-1+params(26)*params(28));
residual(19) = lhs - rhs;
lhs = y(28);
rhs = params(29)/(params(29)+params(30)-1+params(28)*params(29))*y(4)+params(28)*params(29)/(params(29)+params(30)-1+params(28)*params(29))*y(75)+y(53)*(params(30)-1)/(params(29)+params(30)-1+params(28)*params(29))-y(61)/(params(29)+params(30)-1+params(28)*params(29));
residual(20) = lhs - rhs;
lhs = y(52)*((params(18)-1)*params(32)+(params(4)-1)*params(31)-(1-params(25))*(params(3)-1));
rhs = (params(4)-1)*params(31)*(y(33)+y(28))+(params(18)-1)*params(32)*(y(47)+y(45))-(y(38)+y(26))*(1-params(25))*(params(3)-1);
residual(21) = lhs - rhs;
lhs = y(26);
rhs = y(2)*params(36)+y(27)*params(37)*(1-params(36))+(1-params(36))*params(38)*(y(42)-y(11))+y(59);
residual(22) = lhs - rhs;
lhs = y(42);
rhs = y(16)*params(23)*params(40)+y(39)*params(39)*params(22)+y(25)*params(39)*(1-params(22))+y(50)*T(14)-y(27)*params(23)*params(40);
residual(23) = lhs - rhs;
lhs = y(56);
rhs = y(39)*params(22)+y(25)*(1-params(22));
residual(24) = lhs - rhs;
lhs = y(44);
rhs = y(36)*params(22)+y(37)*(1-params(22));
residual(25) = lhs - rhs;
lhs = y(30);
rhs = (1-params(22))*(T(5)+params(1)*(y(76)+(params(5)-1)*y(77)-params(5)*T(4)*(y(73)-params(2)*y(25)))+((params(5)-1)*y(77)+y(76)+params(5)*(y(32)+y(35)+y(74)))*(T(2)-params(1))*params(6)*(1-params(7)))+params(22)*(T(7)*(y(39)-params(2)*y(9))+params(11)*(y(76)+(params(5)-1)*y(77)-(y(79)-params(2)*y(39))*params(5)*T(7)))-y(62);
residual(26) = lhs - rhs;
lhs = y(31);
rhs = y(30)*(params(5)-1)*params(35)+y(52)*(1-params(35));
residual(27) = lhs - rhs;
lhs = y(54);
rhs = params(31)*y(33)+params(32)*y(45);
residual(28) = lhs - rhs;
lhs = y(54);
rhs = params(25)*y(51)+(1-params(25))*(y(38)-y(58));
residual(29) = lhs - rhs;
lhs = y(57);
rhs = params(43)*y(18)+x(it_, 2);
residual(30) = lhs - rhs;
lhs = y(58);
rhs = params(44)*y(19)+x(it_, 4);
residual(31) = lhs - rhs;
lhs = y(59);
rhs = params(45)*y(20)+x(it_, 3);
residual(32) = lhs - rhs;
lhs = y(60);
rhs = params(46)*y(21)+x(it_, 6);
residual(33) = lhs - rhs;
lhs = y(61);
rhs = params(47)*y(22)+x(it_, 5);
residual(34) = lhs - rhs;
lhs = y(35);
rhs = params(48)*y(7)+x(it_, 7);
residual(35) = lhs - rhs;
lhs = y(48);
rhs = params(49)*y(15)+x(it_, 8);
residual(36) = lhs - rhs;
lhs = y(62);
rhs = params(50)*y(23)+x(it_, 9);
residual(37) = lhs - rhs;
lhs = y(63);
rhs = params(51)*y(24)+x(it_, 1);
residual(38) = lhs - rhs;
lhs = y(55);
rhs = y(51)-y(54);
residual(39) = lhs - rhs;
lhs = y(64);
rhs = y(27)+params(55);
residual(40) = lhs - rhs;
lhs = y(65);
rhs = y(30)-y(5)+0.01537;
residual(41) = lhs - rhs;
lhs = y(66);
rhs = y(42)-y(11)+0.0039;
residual(42) = lhs - rhs;
lhs = y(67);
rhs = y(33)-y(6)+0.007885;
residual(43) = lhs - rhs;
lhs = y(68);
rhs = y(45)-y(13)+0.006;
residual(44) = lhs - rhs;
lhs = y(69);
rhs = y(38)-y(8)+0.0046;
residual(45) = lhs - rhs;
lhs = y(71);
rhs = y(28)+params(52);
residual(46) = lhs - rhs;
lhs = y(72);
rhs = y(47)+params(53);
residual(47) = lhs - rhs;
lhs = y(70);
rhs = y(26)+params(54);
residual(48) = lhs - rhs;

end
