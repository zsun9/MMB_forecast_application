function [alpha_0,alpha_1,alpha_2,beta_0,beta_1,rho,tau]  =   makematrices(params_mat,steady);

alpha       =   params_mat(1);
b           =   params_mat(2);
beta        =   params_mat(3);
delta       =   params_mat(4);
eps         =   params_mat(5);
eta         =   params_mat(6);
lambda_f    =   params_mat(7);
lambda_w    =   params_mat(8);
mu_ups      =   params_mat(9);
mu_z        =   params_mat(10);
nu          =   params_mat(11);
psi_L       =   params_mat(12);
sigma_L     =   params_mat(13);
x           =   params_mat(14);
xi_w        =   params_mat(15);
V           =   params_mat(16);

kappa       =   params_mat(17);
sigma_a     =   params_mat(18);
gamma       =   params_mat(19);
squig       =   params_mat(20);
vartheta    =   params_mat(21);

rho_M       =   params_mat(22);
theta_M     =   params_mat(23);
rho_muz     =   params_mat(24);
theta_muz   =   params_mat(25);
c_z         =   params_mat(26);
cp_z        =   params_mat(27);
rho_xz      =   params_mat(28);
rho_muups   =   params_mat(29);
theta_muups =   params_mat(30);
c_ups       =   params_mat(31);
cp_ups      =   params_mat(32);
rho_xups    =   params_mat(33);


mu_zstar    =   steady(1);
rhotilde    =   steady(2);
pi          =   steady(3);
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

i           =   kbar*(1-(1-delta)/(mu_ups*mu_zstar));
lambda_zstar    =   (mu_zstar-b*beta)/(mu_zstar*c-b*c)/(1+eta+eta_pr*V);

% Ordering in z_t:
% c_t, wtilde_t, m_t, lambda_z*t, pi_t, mutilde_t, s_t, i_t, h_t,
% kbar_t+1, q_t, ytilde_t, R_t, x_t, rhotilde_t

% Coefficients in the wage equation

blewy=0;%if 0, then index wage to steady state productivity growth
b_w     =   (lambda_w*sigma_L-(1-lambda_w))/((1-xi_w)*(1-beta*xi_w));
ETA(1)  =   b_w*xi_w;%eta0
ETA(2)  =   -b_w*(1+beta*xi_w^2)+sigma_L*lambda_w;%eta1
ETA(3)  =   beta*xi_w*b_w;%eta2
ETA(4)  =   b_w*xi_w;%eta3-bar
ETA(5)  =   -xi_w*b_w*(1+beta);%eta3   
ETA(6)  =   b_w*beta*xi_w;%eta4
ETA(7)  =   -sigma_L*(1-lambda_w);%eta5
ETA(8)  =   1-lambda_w;%eta6
ETA(9)  =   -b_w*xi_w*(1-blewy);%eta7
ETA(10)  =  beta*b_w*xi_w*(1-blewy);%eta8

alpha_0         =   zeros(16);
alpha_0(1,3)    =   1;
alpha_0(1,14)    =   (1-delta)/(rhotilde+1-delta);
alpha_0(1,15)   =   rhotilde/(rhotilde+1-delta);
alpha_0(2,8)    =   -beta*kappa*(mu_zstar*mu_ups)^2;
alpha_0(5,5)    =   beta;
alpha_0(8,1)    =   -beta*b*(1/(mu_zstar*c-b*c))^2*mu_zstar*c;
alpha_0(9,3)    =   1;
alpha_0(9,5)    =   -1;
alpha_0(9,13)   =   1;
alpha_0(10,2)   =   ETA(3);
alpha_0(10,5)   =   ETA(6);

% c_t, wtilde_t, m_t, lambda_z*t, pi_t, mutilde_t, s_t, i_t, h_t,
% kbar_t+1, q_t, ytilde_t, R_t, x_t, rhotilde_t
alpha_1         =   zeros(16);
alpha_1(1,3)    =   -1;
alpha_1(1,14)    =   -1;
alpha_1(2,14)    =   -1;
alpha_1(2,8)    =   kappa*(mu_zstar*mu_ups)^2*(1+beta);
alpha_1(3,2)    =   1;
alpha_1(3,12)   =   1/(1-alpha)*ytilde/(ytilde+phi);
alpha_1(3,13)   =   nu*R/(nu*R+1-nu);
alpha_1(3,15)   =   -1;
alpha_1(3,16)   =   -1/(1-alpha);
alpha_1(4,8)    =   mu_zstar*mu_ups-(1-delta);
alpha_1(4,10)   =   -mu_ups*mu_zstar;
alpha_1(5,5)    =   -(1+beta*squig);
alpha_1(5,7)    =   gamma;
alpha_1(6,2)    =   1;
alpha_1(6,7)    =   -1;
alpha_1(6,12)   =   alpha/(1-alpha)*ytilde/(ytilde+phi);
alpha_1(6,13)   =   nu*R/(nu*R+1-nu);
alpha_1(6,16)   =   -alpha/(1-alpha);
alpha_1(7,1)    =   1;
alpha_1(7,11)   =   -1;
alpha_1(7,13)   =   -R/(R-1)/(2+sig_eta);
alpha_1(8,1)    =   1/(c*(1-b/mu_zstar))^2*c+beta*b*(1/(mu_zstar*c-b*c))^2*b*c+lambda_zstar*(2+sig_eta)*eta_pr*V;
alpha_1(8,3)    =   +lambda_zstar*(1+eta+eta_pr*V);
alpha_1(8,11)   =   -lambda_zstar*(2+sig_eta)*eta_pr*V;
alpha_1(9,3)    =   -1;
alpha_1(10,2)   =   ETA(2);
alpha_1(10,5)   =   ETA(5);
alpha_1(10,9)   =   ETA(7);
alpha_1(10,3)   =   ETA(8);
alpha_1(11,1)   =   (1+eta)*c+eta_pr*c^2/q;
alpha_1(11,8)   =   (1-(1-delta)/(mu_ups*mu_zstar))*kbar;%LJC made this change 6/13/2004
alpha_1(11,9)   =   -(ytilde+phi)*(1-alpha);
alpha_1(11,11)  =   -eta_pr*c^2/q;
alpha_1(11,16)  =   rhotilde*kbar/(mu_zstar*mu_ups)-(ytilde+phi)*alpha;%LJC made this change 6/13/2004
alpha_1(12,2)   =   1;
alpha_1(12,4)   =   -x*m/(x*m-q);
alpha_1(12,9)   =   1;
alpha_1(12,11)  =   q/(x*m-q);
alpha_1(12,6)  =   -x*m/(x*m-q);
alpha_1(13,6)  =   -1;
alpha_1(14,4)   =   -1;
alpha_1(14,5)   =   -1;
alpha_1(15,9)   =   (ytilde+phi)*(1-alpha);
alpha_1(15,12)  =   -ytilde;
alpha_1(15,16)  =   (ytilde+phi)*alpha-rhotilde*kbar/(mu_zstar*mu_ups);
alpha_1(16,15)  =   -1/sigma_a;
alpha_1(16,16)  =   1;

alpha_2         =   zeros(16);
alpha_2(2,8)    =   -kappa*(mu_zstar*mu_ups)^2;
alpha_2(3,10)   =   -1/(1-alpha);
alpha_2(4,10)   =   (1-delta);
alpha_2(5,5)    =   squig;
alpha_2(6,10)   =   -alpha/(1-alpha);
alpha_2(8,1)    =   -1/(c*(1-b/mu_zstar))^2*b*c/mu_zstar;
alpha_2(10,2)   =   ETA(1);
alpha_2(10,5)   =   ETA(4);
alpha_2(11,10)  =   -(ytilde+phi)*alpha;%LJC change 6/13/2004
alpha_2(14,4)   =   1;
alpha_2(14,6)  =   1;
alpha_2(15,10)  =   (ytilde+phi)*alpha;

% Ordering in s_t:
% x_M, eps_M, mu_z, eps_muz, x_z, mu_ups, eps_muups, x_ups

beta_0          =   zeros(16,8);
beta_0(1,3)     =   -1;
beta_0(1,6)     =   -1/(1-alpha);
beta_0(2,3)     =   -beta*kappa*(mu_zstar*mu_ups)^2;
beta_0(2,6)     =   -beta*kappa*(mu_zstar*mu_ups)^2/(1-alpha);
beta_0(8,3)     =   -beta*b*(1/(mu_zstar*c-b*c))^2*mu_zstar*c;
beta_0(8,6)     =   -beta*b*(1/(mu_zstar*c-b*c))^2*mu_zstar*c*alpha/(1-alpha);
beta_0(9,3)     =   -1;
beta_0(9,6)     =   -alpha/(1-alpha);
beta_0(10,6)    =   ETA(10)*alpha/(1-alpha);
beta_0(10,3)    =   ETA(10);

beta_1          =   zeros(16,8);
beta_1(2,3)     =   kappa*(mu_zstar*mu_ups)^2;
beta_1(2,6)     =   kappa*(mu_zstar*mu_ups)^2/(1-alpha);
beta_1(3,3)     =   1/(1-alpha);
beta_1(3,6)     =   1/(1-alpha)^2;
beta_1(4,3)     =   -(1-delta);
beta_1(4,6)     =   -(1-delta)/(1-alpha);
beta_1(6,3)     =   alpha/(1-alpha);
beta_1(6,6)     =   alpha/(1-alpha)^2;
beta_1(8,3)     =   1/(c*(1-b/mu_zstar))^2*b*c/mu_zstar;
beta_1(8,6)     =   1/(c*(1-b/mu_zstar))^2*b*c/mu_zstar*alpha/(1-alpha);
beta_1(11,3)    =   (ytilde+phi)*alpha;
beta_1(11,6)    =   (ytilde+phi)*alpha/(1-alpha);
beta_1(13,1)    =   1;
beta_1(13,5)    =   1;
beta_1(13,8)    =   1;
beta_1(14,3)    =   -1;
beta_1(14,6)    =   -alpha/(1-alpha);
beta_1(15,3)    =   -(ytilde+phi)*alpha;
beta_1(15,6)    =   -(ytilde+phi)*alpha/(1-alpha);
beta_1(10,6)    =   ETA(9)*alpha/(1-alpha);
beta_1(10,3)    =   ETA(9);

rho             =   zeros(8);
rho(1,1)        =   rho_M;
rho(1,2)        =   theta_M;
rho(3,3)        =   rho_muz;
rho(3,4)        =   theta_muz;
rho(5,4)        =   cp_z;
rho(5,5)        =   rho_xz;
rho(6,6)        =   rho_muups;
rho(6,7)        =   theta_muups;
rho(8,7)        =   cp_ups;
rho(8,8)        =   rho_xups;

tau                     =   ones(size(rho,1),size(alpha_0,1));
tau(1:2,[1:2,4,5,8,10,14,16])   =   zeros(2,8);
