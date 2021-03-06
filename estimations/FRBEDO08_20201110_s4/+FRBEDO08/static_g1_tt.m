function T = static_g1_tt(T, y, x, params)
% function T = static_g1_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 60);

T = FRBEDO08.static_resid_tt(T, y, x, params);

T(49) = getPowerDeriv(T(15),1-params(20),1);
T(50) = T(36)*(1/y(26)-params(13)/y(26));
T(51) = (-(params(29)*y(47)*getPowerDeriv(y(25)+y(26),params(19),1)));
T(52) = T(36)*((-y(25))/(y(26)*y(26))-(-(y(25)*params(13)))/(y(26)*y(26)));
T(53) = getPowerDeriv(y(29)*y(27)/y(70),params(1),1);
T(54) = getPowerDeriv(y(30)*y(28)/y(70),params(1),1);
T(55) = 1/y(70);
T(56) = 1/params(18)/y(58);
T(57) = getPowerDeriv(T(22),T(23),1);
T(58) = getPowerDeriv(T(24),T(23),1);
T(59) = 1/y(65)/y(69);
T(60) = getPowerDeriv(T(46)*T(47),1/(params(34)*params(37)+params(34)*T(8)+params(35)*T(9)),1);

end
