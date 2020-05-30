
function [c0,c1,c2,th1,th2,sigeta,rt]= blaschke(sigP,rhoP,sigT,rhoT,th1,th2)

c0=sigP^2*(1+rhoT^2)+sigT^2*(1+(1+rhoP)^2+rhoP^2);
c1=-rhoT*sigP^2-(1+rhoP)^2*sigT^2;
c2=rhoP*sigT^2;

rho1=c1/c0;
rho2=c2/c0;

x(1)=th1;
x(2)=th2;

%[gg,rrho1,rrho2,rt]=func(x,rho1,rho2);
options=optimset('MaxFunEvals',2000,'MaxIter',1000,'Display','off','TolX',1e-7,'TolFun',1e-7); 
%[xp,fval,exitflag]=fminsearch('func',x,options,rho1,rho2);
[xp,fval,exitflag]=fminunc('func',x,options,rho1,rho2);

if exitflag ~= 1
    %error('fatal (blaschke) failed to factorize covariance generating function')
    disp('fatal (blaschke) failed to factorize covariance generating function');
    return;
end
[gg,rrho1,rrho2,rt]=func(xp,rho1,rho2);
if max(abs(rt)) > 1
    %error('fatal (blaschke) moving average roots not inside unit circle')
    disp('fatal (blaschke) moving average roots not inside unit circle');
    return;
end
th1=xp(1);
th2=xp(2);
sigeta=sqrt(c0/(1+th1^2+th2^2));

 