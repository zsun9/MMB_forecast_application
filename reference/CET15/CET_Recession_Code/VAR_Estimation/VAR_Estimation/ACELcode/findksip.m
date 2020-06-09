function [ksipfspecific,ksiph,kap1,kap2,kap3,kap4,kap5,psi0,psi1,psi2,psi3] = ...
    findksip(gam,lambdaf,lambdaw,muups,muz,beta,del,eta,b,sigmaL,psiL,V,nu,x,eps,alpha,siga,Spp,ksiet,ksiep)

%this takes the coefficients for the firm-specific capital versio of the ACEL model and computes the implied
%value of ksip. It checks - by looking over a grid of admissible values of
%ksip - that the solution is unique
          
fixed=1;%if unity, there is a fixed cost and profits are zero in steady state, if zero, the fixed cost is zero and profits are positive in ss
[muzst,rhot,R,Rnu,wt,kb,h,q,m,pie,yt,c,phi,theta]=steady(lambdaf,lambdaw,muups,muz,beta,del,eta,b,sigmaL,psiL,V,nu,x,eps,alpha,fixed);
           
kksip=.00000000001:.1:.99;
skap1=0.1;
skap2=.1;
skap3=1;

ksip=kksip(1);
[psi0,psi1,kap1,kap2,kap3,gamma,zeta,fval] ...
    = getsolveACEL(skap1,skap2,skap3,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,ksip,Spp);
ff=(gamma-gam);
ix=0;
fz(1)=ff;
for ii = 2:length(kksip)
    ksip=kksip(ii);
    [psi0,psi1,kap1,kap2,kap3,gamma,zeta,fval] ...
        = getsolveACEL(skap1,skap2,skap3,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,ksip,Spp);  
    fz(ii)=gamma-gam;
    if (gamma-gam)*ff < 0
        ix=ix+1;
        II(ix)=ii;
    end
    ff=gamma-gam;
end

if ix > 1 | ix == 0
    figure
    plot(kksip,fz)
    title('criterion to set to zero in findksip')
    error('fatal (findksip) failed to bracket a solution')
end
    
k1=kksip(II(ix)-1);
k2=kksip(II(ix));
[ff1] = ffindksip(k1,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,Spp,gam);
[ff2] = ffindksip(k2,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,Spp,gam);

if ff1*ff2 > 0
    error('fatal (findksip) failed to bracket a solution')
end

options = optimset('Display','off','TolFun',1e-10,'TolX',1e-10,'maxiter',10000,'MaxFun',10000,'LargeScale','off');
[xx,ff,exitflag]=fzero('ffindksip',[k1 k2],options,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,Spp,gam);   

if exitflag == 0
    disp('(findksip) maximum number of function evaluations reached')
elseif exitflag < 0
    error('(findksip) did not converge to a solution')
end

if isnan(ff) == 1 | abs(imag(ff)) > .1e-0 
    error('fatal (findksip) optimized function value not a sensible number')
end

ksipfspecific=xx;

c=[beta -(1+beta+gam) 1];
rr=roots(c);
ksiph=rr(1);
if ksiph > 1 | ksiph < 0
    ksiph=rr(2);
end
if ksiph > 1 | ksiph < 0 | abs(imag(ksiph)) > .1e-10
    disp('WARNING (findksip) - no value of ksip inside unit circle is consistent with value of gamma used')
end

[psi0,psi1,kap1,kap2,kap3,gamma,zeta,fval] ...
    = getsolveACEL(skap1,skap2,skap3,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,ksipfspecific,Spp);

ksip=ksipfspecific;

xx(1)=kap1;
xx(2)=kap2;
xx(3)=kap3;

[ff,gamma0t,gamma1t,gamma2t,gamma3t,gamma4t,phi] = funcdiACEL(xx,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,ksip,Spp);

if max(abs(ff)) > .1e-9
    error('fatal (findksip) something wrong')
end

A=[kap1 kap2
      1  0];

tau=[1 0];

boob=tau*(eye(2)-A/ksiet)*(1/ksiet)*(( ksip*ksiet*beta/(1-ksip*ksiet*beta) )*eye(2) - inv(eye(2)-ksip*beta*A)*ksip*beta*A)*(tau');

boobep=tau*(eye(2)-A/ksiep)*(1/ksiep)*(( ksip*ksiep*beta/(1-ksip*ksiep*beta) )*eye(2) - inv(eye(2)-ksip*beta*A)*ksip*beta*A)*(tau');

Aet(1,1)=gamma0t*ksiet*ksiet/phi + (1-ksip)*psi0;
Aet(1,2)=-(1-ksip)*ksiet;
Aet(2,1)=zeta*(alpha/(1-alpha))*siga*((1-alpha)/(siga*(1-alpha)+1))*(1-beta*ksip)*boob;
Aet(2,2)=1;

Aep(1,1)=gamma0t*ksiep*ksiep/phi + (1-ksip)*psi0;
Aep(1,2)=-(1-ksip)*ksiep;
Aep(2,1)=(alpha/(1-alpha))*siga*((1-alpha)/(siga*(1-alpha)+1))*(1-beta*ksip)*boobep;
Aep(2,2)=1;

Bet=[-((theta-1)/theta)*ksiet zeta*(alpha/(1-alpha))*siga*((1-alpha)/(siga*(1-alpha)+1))*(1-beta*ksip)*(theta-1)/lambdaf]';

Bep=[(lambdaf/theta)*ksiep 0]';

bb=Aet\Bet;
kap4=bb(1);
psi2=bb(2);

bb=Aep\Bep;
kap5=bb(1);
psi3=bb(2);


