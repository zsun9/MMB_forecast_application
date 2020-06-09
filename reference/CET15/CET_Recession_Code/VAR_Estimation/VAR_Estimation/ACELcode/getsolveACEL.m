function [psi0,psi1,kap1,kap2,kap3,gamma,zeta,fval] = getsolveACEL(skap1,skap2,skap3,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,ksip,Spp)
kap1=skap1;
kap2=skap2;
kap3=skap3;
xx(1)=kap1;
xx(2)=kap2;
xx(3)=kap3;

[ff] = funcdiACEL(xx,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,ksip,Spp);

options = optimset('LevenbergMarquardt','on','Display','off','TolFun',1e-10,'TolX',1e-10,'MaxFun',5000,'Diagnostics','off','MaxFunEvals',4000,'MaxIter',5000);
[xnew,fval,exitflag]=fsolve('funcdiACEL',xx,options,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,ksip,Spp);

kap1=xnew(1);
kap2=xnew(2);
kap3=xnew(3);

aa=roots([1 -kap1 -kap2]);
if max(abs(aa)) > 1
    error('fatal (getsolveACEL) one or more roots explosive')
end

if exitflag == 0
    disp('(getsolveACEL) maximum number of function evaluations reached')
elseif exitflag < 0
    error('(getsolveACEL) did not converge to a solution')
end

if isnan(fval) == 1 | abs(imag(fval)) > .1e-8 
    error('fatal (getsolveACEL) optimized function value not a sensible number')
end

[psi0,psi1,zeta] = mapACEL(alpha,siga,theta,yt,phi,beta,ksip,kap1,kap2,kap3);

gamma=((1-ksip)*(1-beta*ksip)/ksip)*zeta;