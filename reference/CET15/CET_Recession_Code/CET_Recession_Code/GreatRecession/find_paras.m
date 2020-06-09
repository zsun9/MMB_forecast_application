function [ff,UcH, cH,gamma,alp1,alp2,alp3,alp4,V,A,U,N,K,F,...
    psi,omega,pl]=find_paras(xx,s,e,wp,delta,M,J,varthet,...
    y,xi,pibar,L,l,c,b,D,...
    rho,betta,f,mu,Fcal,FcalL,...
    FcalprimeL,nD,nGAM,nH,lambda,mc,pitilde,w,...
    nDN,m,chi)


%solve equations (28) and (30) for omega and pl
omega=xx(1);
pl=xx(2);

%marginal utilities etc
cH=nH*(1-L)-Fcal;
ctilde=( (1-omega)*(c*(1-b/mu))^chi+omega*(cH*(1-b/mu))^chi )^(1/chi);
psi=(1-omega)*ctilde^(1-chi-1)*(c*(1-b/mu))^(chi-1);
UcH=omega/(1-omega)*( cH*(1-b/mu)/(c*(1-b/mu)) )^(chi-1)*psi;

%pricing equations
K=lambda*psi*y*mc/(1-betta*xi*(pitilde/pibar)^(lambda/(1-lambda)));
F=psi*y/(1-betta*xi*(pitilde/pibar)^(1/(1-lambda)));

%solve for V A U N
Emat=zeros(4,4);
Emat(1,2)=1;
Emat(2,1)=(1-rho)*m*mu*s*f/(1-rho*m*mu);
Emat(2,3)=(1-rho)*m*mu*s*(1-f)/(1-rho*m*mu);
Emat(2,4)=(1-rho)*m*mu*(1-s)/(1-rho*m*mu);
Emat(3,1)=m*mu*s*f;
Emat(3,3)=m*mu*s*(1-f);
Emat(3,4)=m*mu*(1-s);
Emat(4,1)=m*mu*e*f/(1-m*mu*(1-e));
Emat(4,3)=m*mu*e*(1-f)/(1-m*mu*(1-e));
sol=inv(eye(4)-Emat)*[wp;0;nD*D;(UcH/psi*nH)/(1-m*mu*(1-e))];
V=sol(1);
A=sol(2);
U=sol(3);
N=sol(4);


%AOB sharing rule
alp1=1-delta+(1-delta)^M;
alp2=1-(1-delta)^M;
alp3=alp2*(1-delta)/delta-alp1;
alp4=(1-delta)/(2-delta)*alp2/M+1-alp2;
gamma=(alp2*(V-U)-alp1*J+alp4*(varthet-nD*D))/(nGAM*alp3);


ff=NaN*zeros(2,1);
%eq 30 - LFP FOC
ff(1)=-UcH/psi*(cH+Fcal)*(1/(1-L))+nD*D+pl*f-(FcalL+betta*FcalprimeL)*UcH/psi;
%eq 28 - Employment FOC
ff(2)=-pl+w-nD*D+m*mu*pl*rho*(1-f);
