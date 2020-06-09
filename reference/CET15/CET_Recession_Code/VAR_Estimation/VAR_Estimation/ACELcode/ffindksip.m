function [ff] = ffindksip(xx,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,Spp,gam)
ksip=xx;
skap1=0.1;
skap2=.1;
skap3=1;
[psi0,psi1,kap1,kap2,kap3,gamma,zeta,fval] ...
        = getsolveACEL(skap1,skap2,skap3,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,ksip,Spp);   
ff=gamma-gam;