function [mu_zstar,rhotilde,infl,R,eta_pr,sig_eta,s,R_nu,wtilde,kbar,h,c,q,m,ytilde,phi,i,params_ss,steady,lambda_zstar,mutilde,stst] = ...
    getsteady(alpha,b,beta,delta,epsilon,eta,lambda_f,lambda_w,mu_ups,mu_z,nu,psi_L,sigma_L,x,xi_w,V,chk)

params_ss   =   [alpha,b,beta,delta,epsilon,eta,lambda_f,lambda_w,mu_ups,mu_z,nu,psi_L,sigma_L,x,xi_w,V];
[steady]    =   steadystate(params_ss);

mu_zstar    =   steady(1);
rhotilde    =   steady(2);
infl        =   steady(3);
R           =   steady(4);
eta_pr      =   steady(5);
sig_eta     =   steady(6);
s           =   steady(7);
R_nu        =   steady(8);
wtilde      =   steady(9);
kbar        =   steady(10);
h           =   steady(11);
c           =   steady(12);
q           =   steady(13);
m           =   steady(14);
ytilde      =   steady(15);
phi         =   steady(16);
i           =   (1-(1-delta)/(mu_ups*mu_zstar))*kbar;


if chk == 1
    [rhot,RR,Rnu,wt,kb,hh,qq,mm,yt,cc,pphi] = ...
        checksteady(lambda_f,lambda_w,mu_ups,mu_z,beta,delta,eta,b,sigma_L,psi_L,V,nu,x,epsilon,alpha);
    
    err(1)=rhot-rhotilde;
    err(2)=RR-R;
    err(3)=Rnu-R_nu;
    err(4)=wt-wtilde;
    err(5)=kb-kbar;
    err(6)=hh-h;
    err(7)=qq-q;
    err(8)=mm-m;
    err(9)=yt-ytilde;
    err(10)=cc-c;
    err(11)=pphi-phi;
    
    if max(abs(err)) > .1e-11
        error('fatal (getsteady) error in computing steady state')
    end
end
lambda_zstar    =   (mu_zstar-b*beta)/(mu_zstar*c-b*c)/(1+eta+eta_pr*V);
mutilde         =   rhotilde/(mu_ups*mu_zstar/beta-(1-delta));
stst            =   [c,wtilde,lambda_zstar,m,infl,x,s,i,h,kbar,q,ytilde,R,mutilde,rhotilde,1];
