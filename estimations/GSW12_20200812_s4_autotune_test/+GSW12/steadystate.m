function [ys_, params, info] = steadystate(ys_, exo_, params)
% Steady state generated by Dynare preprocessor
    info = 0;
    ys_(46)=params(31)+params(36);
    ys_(47)=params(31)+params(36);
    ys_(48)=params(31)+params(36);
    ys_(49)=params(31);
    ys_(45)=params(3);
    ys_(44)=((1+params(3)/100)/(1/(1+params(4)/100)*(1+params(31)/100)^(-params(11)))-1)*400;
    ys_(50)=params(36);
    ys_(51)=100*(params(19)-1)/params(18);
    % Auxiliary equations
end
