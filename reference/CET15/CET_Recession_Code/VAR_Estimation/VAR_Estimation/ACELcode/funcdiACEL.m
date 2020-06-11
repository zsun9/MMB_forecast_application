function [ff,gamma0t,gamma1t,gamma2t,gamma3t,gamma4t,PHI] = funcdiACEL(xx,alpha,siga,theta,yt,phi,del,rhot,muzst,muups,beta,ksip,Spp)

kap1=xx(1);
kap2=xx(2);
kap3=xx(3);

[psi0,psi1,zeta] = mapACEL(alpha,siga,theta,yt,phi,beta,ksip,kap1,kap2,kap3);

a1=(1-del)/(rhot+1-del);
a2=(1-del)/(muzst*muups);
cc=Spp*((muzst*muups)^2);
c=(muups*muzst/(muups*muzst-(1-del)));
PHI=-(rhot/(cc*(rhot+1-del)))*(yt*theta/(yt+phi))/(1-alpha+(1/siga));
gamma0=a1*beta*c;
gamma1=-(beta+a1+(1+a2)*a1*beta)*c;
gamma2=c*(1+(1+a2)*(beta+a1)+a1*a2*beta) + (rhot/(cc*(rhot+1-del)))*(1/(1-alpha+(1/siga)));
gamma3=-c*((1+a2)+a2*(beta+a1));
gamma4=c*a2;

gamma0t=gamma0;
gamma1t=gamma1;
gamma2t=gamma2;
gamma3t=gamma3+PHI*(1-ksip)*(psi0*kap1+psi1);
gamma4t=gamma4+PHI*(1-ksip)*psi0*kap2;

a1k=(kap1-(1-ksip)*kap3*psi0)*kap2;
a2k=kap2-(1-ksip)*kap3*psi1+a1k*kap1/kap2;
a0k=ksip*kap3+a1k*kap3/kap2;

a1p=-(1-ksip)*(ksip*(psi0+psi0*kap1+psi1)+(1-ksip)*(psi0*kap1+psi1-psi0*psi0*kap3))*kap2;
a0p=ksip*ksip-ksip*(1-ksip)*psi0*kap3+a1p*kap3/kap2;
a2p=-(1-ksip)*(ksip*(psi1+psi0*kap2)+(1-ksip)*(psi0*kap2-psi0*psi1*kap3))+a1p*kap1/kap2;

ff(1)=(gamma0t*kap1+gamma1t)*a2k+gamma0t*kap3*a2p+(gamma0t*kap2+gamma2t)*kap1+gamma3t;
ff(2)=(gamma0t*kap1+gamma1t)*a1k+gamma0t*kap3*a1p+(gamma0t*kap2+gamma2t)*kap2+gamma4t;
ff(3)=(gamma0t*kap1+gamma1t)*a0k+gamma0t*kap3*a0p+(gamma0t*kap2+gamma2t)*kap3 - PHI*(ksip-(1-ksip)*psi0*kap3);




