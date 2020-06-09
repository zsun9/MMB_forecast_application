function [steady] =   steadystate(params_ss)

alpha       =   params_ss(1);
b           =   params_ss(2);
beta        =   params_ss(3);
delta       =   params_ss(4);
epsilon     =   params_ss(5);
eta         =   params_ss(6);
lambda_f    =   params_ss(7);
lambda_w    =   params_ss(8);
mu_ups      =   params_ss(9);
mu_z        =   params_ss(10);
nu          =   params_ss(11);
psi_L       =   params_ss(12);
sigma_L     =   params_ss(13);
x           =   params_ss(14);
xi_w        =   params_ss(15);
V           =   params_ss(16);

mu_zstar    =   mu_ups^(alpha/(1-alpha))*mu_z;
rhotilde    =   mu_ups*mu_zstar/beta-(1-delta);
infl        =   x/mu_zstar;
R           =   infl*mu_zstar/beta;
eta_pr      =   (R-1)/V^2;
s           =   1/lambda_f;
R_nu        =   nu*R+1-nu;
wtilde      =   ((1-alpha)/R_nu)*s*(rhotilde/(alpha*s))^(alpha/(alpha-1));
h_kbar      =   (rhotilde/(alpha*s*(mu_zstar*mu_ups)^(1-alpha)))^(1/(1-alpha));
kbar        =   ( ( (1+eta)*wtilde/(psi_L*(h_kbar^sigma_L)) ) * (mu_zstar-b*beta)/(lambda_w*(mu_zstar-b)*(1+eta+eta_pr*V))/...
    ((1/lambda_f)*(1/((mu_zstar*mu_ups))^alpha)*(h_kbar^(1-alpha))-(1-(1-delta)/(mu_ups*mu_zstar))))^(1/(1+sigma_L));
h           =   h_kbar*kbar;
c           =   kbar^(-sigma_L)*wtilde/(psi_L*h_kbar^sigma_L)*(mu_zstar-beta*b)/(lambda_w*(mu_zstar-b)*(1+eta+eta_pr*V));
q           =   c/V;
m           =   (nu*wtilde*h+q)/x;
ytilde      =   rhotilde*kbar/(mu_ups*mu_zstar)+wtilde*R_nu*h;
phi         =   ytilde*(lambda_f-1);
sig_eta     =   1/((R-1)*4*epsilon)-2;

steady      =   [mu_zstar,rhotilde,infl,R,eta_pr,sig_eta,s,R_nu,wtilde,kbar,h,c,q,m,ytilde,phi];