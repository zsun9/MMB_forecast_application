function [muzst,rhot,R,Rnu,wt,kb,h,q,m,pie,yt,c,phi,theta] ... 
    =steady(lambdaf,lambdaw,muups,muz,beta,del,eta,b,sigmaL,psiL,V,nu,x,eps,alpha,fixed)
theta=lambdaf/(lambdaf-1);
muzst=(muups^(alpha/(1-alpha)))*muz;
rhot=(muups*muzst/beta)-(1-del);

pie=x/muzst;
R=pie*muzst/beta;
etap=(R-1)/(V^2);
sigeta=((1/(R-1))*(1/eps)*(1/4))-2;
s=(theta-1)/theta;
Rnu=nu*R+1-nu;
hkb= ((rhot/(alpha*s))^(1/(1-alpha)))/(muzst*muups);
wt=(s*(1-alpha)/Rnu)*((rhot/(alpha*s))^(-alpha/(1-alpha)));

%from here on, the calculations are slightly different, depending on
%whether or not there is a fixed cost. (When the fixed cost is positive, we
%choose its value, phi, so that profits are zero in steady state. When the
%fixed costs are zero, profits are permitted to exist in steady state.)

if fixed == 1
    ff=lambdaf;
else
    ff=1;
end

cst=((1/((muzst*muups))^alpha)*(1/ff)*(hkb^(1-alpha))-(1-(1-del)/(muups*muzst)))/(1+eta);
kb= ((wt/(psiL*(hkb^sigmaL)))*((muzst-beta*b)/(lambdaw*(muzst-b)))/((1+eta+etap*V)*cst))^(1/(1+sigmaL));

c=(kb^(-sigmaL))*wt*(muzst-beta*b)/(psiL*(hkb^sigmaL)*lambdaw*(muzst-b)*(1+eta+etap*V));
h=kb*hkb;
F=((kb/(muzst*muups))^alpha)*(h^(1-alpha));
yt=F/ff;

chk=1;
if chk == 1
    %do a couple of consistency checks:
    ytt=c*(1+eta)+(1-(1-del)/(muups*muzst))*kb;
    st=(Rnu*wt/(1-alpha))*((F*muzst*muups/kb)^(alpha/(1-alpha)));
    MPl=(1-alpha)*((hkb*muzst*muups)^(-alpha));
    MPk=alpha*(hkb^(1-alpha))*((muzst*muups)^(1-alpha));
    rhott=(alpha/(1-alpha))*Rnu*wt*((F*muzst*muups/kb)^(1/(1-alpha)));
    ct=kb*((yt/kb)-(1-(1-del)/(muzst*muups)))/(1+eta);
    
    err(1)=(hkb*muzst*muups)^(1-alpha)-rhot/(s*alpha);
    err(2)=yt-ytt;
    err(3)=s-st;
    err(4)=MPl-lambdaf*Rnu*wt;
    err(5)=MPk-lambdaf*rhot;
    err(6)=rhott-rhot;
    err(7)=rhot*kb/(muzst*muups)+wt*Rnu*h-F/lambdaf;
    err(8)=ct-c;
    if max(abs(err)) > .1e-10
        error('fatal (steady) steady state formulas not satisfied')
    end
end

q=c/V;
m=(nu*wt*h+q)/x;
lamzst=((muzst-beta*b)/(c*(muzst-b)))/(1+eta+etap*V);
phi=(1-1/ff)*F;