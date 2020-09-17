% Financial frictions in the Euro Area and the United States: a Bayesian assessment
% Macroeconomic Dynamics, 20 (05), p. 1313-1340, 2016
% Stefania Villa

var hours_sw07_obs ffr_obs gdpdef_obs gdp_rgd_obs c_rgd_obs ifi_rgd_obs wage_rgd_obs ewma epinfma y inv ext_pr pinf c lev q Lambda ell eta v rk invss z s mu n n_e lend u    
w G  r  a x spinf sw kq zk ms
yf invf ext_prf cf levf qf Lambdaf ellf etaf vf rkf xf zf sf muf nf n_ef lendf uf    
wf rf zkf;

varexo e_x e_i e_kq e_g e_a ew epinf;

parameters 
% Deep parameters:
CBETA PHI OMEGA XICHI ALPHA DELTA_SS EPSILON EPSILON_W G_Y H
LAMBDA THETA ZETA S_PRIMEP SIGMAP SIGMA_PI SIGMA_W SIGMA_WI SIGMA_EM M_U  
RHO_I IOTA_PI IOTA_Y RHO_A RHO_G RHO_X RHO_RP RHO_W RHO_P FCP S_G 
 IOTA_DY IOTA_DPI MAW MAP SIGMAC RHO_MS

% Steady states declared as parameters:
R_K_SS constelab picbar ctrend
; %Y_OVER_K C_OVER_K K_OVER_Y I_OVER_Y C_OVER_Y S_OVER_Y N_OVER_Y N_e_OVER_Y LEV_SS L_SS K_SS I_SS 
% Z_SS X_SS NU_SS  N_SS Y_SS S_SS N_e_SS GAMMAT pic_ss HBAR BETABAR R_SS  I_OVER_K
% R_K_BAR spread basispoint ZK_SS W_SS K_OVER_L L_OVER_K 
%calibrated values are taken from the file steadystate_110127 in C:\Users\Stefania Villa\Documents\My Dropbox\ECB\Jobmrk_paper\Dynare
ALPHA      = 0.33;       %capital share
CBETA       = 0.99;         %Discount rate
DELTA_SS   = 0.025;      %Steady state depreciation rate
EPSILON    = 6;         % Price elasticity of demand for retail good
EPSILON_W  = 6;            % elasticity across different types of labour
M_U        = EPSILON /(EPSILON-1);   %Mark-up in retail sector
G_Y        = 0.20;         %G/Y
S_G        = 0.20;
SIGMAC     =   1;
PHI        = 0.333;        %Inverse Frisch elasticity of L supply
OMEGA      = 1;         %Relative utility weight of L
H          = 0.565;        %Habit parameter
LAMBDA     = 0.5152;       %Fraction of capital that can be diverted
THETA      = 0.9715;       %Fractions of bankers that survive every period
XICHI      = 0.001;     %fraction of of assets given to new banks       
FCP        = 1.26;           % fixed costs in production

SIGMAP      = 0.7898;        %Calvo parameter for retail firms
SIGMA_PI   = 0.0751;        % indexation to past inflation
SIGMA_W    = 0.75;        %Calvo parameter for unions
SIGMA_WI   = 0.25;        % indexation to past wage inflation
SIGMA_EM   = 0.5;
ZETA       = 0.85;        %EDCU
S_PRIMEP   = 5;        %2nd derivative of Inv adjustment cost

IOTA_PI    = 2;        %Response to inflation in Taylor rule
IOTA_DPI   = 0;        %0.15;
IOTA_Y     = 0.09;        %Response to output gap in Taylor rule
IOTA_DY    = 0;    %0.0625;
RHO_I      = 0.7526;        %Interest rate smoothing in Taylor rule
RHO_A      = 0.9392;        %Persistency of technological shock
RHO_X      = 0.9349;        %Persistency of shock to K
RHO_G      = 0.8767;   
RHO_W      = 0.8;
RHO_P      = 0.8;     
RHO_RP     = 0.2199;
RHO_MS     = 0;
MAP        = 0;
MAW        = 0;

% Steady State declared as parameters:
R_K_SS  = 1.013860066271978;

constelab  = 0;
picbar     = 0.8; 
ctrend      = 0.43;
 
% now I insert the log-linearised equilibrium conditions
model (linear);

%%%%%%transformed parameters%%%%%
#GAMMAT     = 1 + ctrend/100;
#pic_ss     = 1+picbar/100;
#HBAR   = H;
#BETABAR=CBETA;
#R_SS = 1/CBETA;
#R_K_BAR = R_K_SS;
#spread=R_K_SS/R_SS;
#basispoint= (spread - 1)*40000;
#ZK_SS = R_K_BAR - (1-DELTA_SS);
#W_SS   = (ALPHA^ALPHA*((1-ALPHA)^(1-ALPHA))/(M_U*((ZK_SS)^ALPHA)))^(1/(1-ALPHA));
#K_OVER_L   = ALPHA*W_SS/((1-ALPHA)*ZK_SS);
#L_OVER_K   = K_OVER_L^-1;
#conster    =(R_SS-1)*100;
#Y_OVER_K   = (FCP*(K_OVER_L)^(1-ALPHA))^(-1);
#I_OVER_K   = 1- ((1-DELTA_SS));
#C_OVER_K   = Y_OVER_K-I_OVER_K-G_Y*Y_OVER_K;
#K_OVER_Y   = Y_OVER_K^(-1);
#I_OVER_Y   = I_OVER_K/Y_OVER_K;
#C_OVER_Y   = 1-I_OVER_Y-G_Y;
#K_SS       = (W_SS*(1)/((1-HBAR)) *(C_OVER_K^-1)*(K_OVER_L^PHI))^(1/(1+PHI));
#L_SS       = K_SS*(ZK_SS)*(1-ALPHA)/(ALPHA*W_SS);
#I_SS       = DELTA_SS*K_SS;
#Y_SS       = K_SS*(L_OVER_K^(1-ALPHA))/FCP;
#S_OVER_Y   = XICHI/Y_OVER_K;
#N_OVER_Y   =(1/(1-(R_SS*THETA)))*(S_OVER_Y+(THETA*(R_K_SS-R_SS)/(Y_OVER_K)));
#N_e_OVER_Y =N_OVER_Y-S_OVER_Y;
#LEV_SS=(Y_OVER_K*N_OVER_Y)^(-1);
#Z_SS = (R_K_SS-R_SS)*LEV_SS+R_SS;
#X_SS = Z_SS;
#NU_SS = (BETABAR*(1-THETA)*(R_K_SS-R_SS))/(1-CBETA*THETA*X_SS);
#N_SS=K_SS/LEV_SS;
#S_SS=XICHI*K_SS;
#N_e_SS=N_SS-S_SS;

%%%%%%%%%%%%%%%%%%%%%%%%%
%%FLEXIBLE PRICE MODEL%%%
%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%HOUSEHOLDS%%%%%%%
(1-HBAR)*muf=HBAR*cf(-1)-cf;                                              
Lambdaf = muf-muf(-1);                            
Lambdaf(+1)+ rf = 0;                             
wf = PHI*ellf-muf;
%%%%%%%%FINANCIAL INTERMEDIARIES%%%%%%%
vf = CBETA*THETA*X_SS*(Lambdaf(+1)+xf+vf(+1))+((1-THETA)/NU_SS)*BETABAR*(R_K_SS*rkf-R_SS*rf(-1))+((1-THETA)/NU_SS)*BETABAR*(R_K_SS-R_SS)*Lambdaf(+1);
etaf = THETA*CBETA*Z_SS*(Lambdaf(+1)+zf+etaf(+1));
zf = (1/Z_SS)*((LEV_SS*R_K_SS/1)*rkf+(R_SS*(1-LEV_SS/1))*rf(-1)+
    ((R_K_SS-R_SS)*LEV_SS/1)*levf(-1));          
xf = levf+zf-levf(-1);                            
levf = etaf(+1)+(NU_SS/(LAMBDA-NU_SS))*vf(+1); 
n_ef = nf(-1)+zf;                         
lendf(+1)+qf=nf+levf; 
nf=(N_e_OVER_Y/N_OVER_Y)*n_ef+(S_OVER_Y/N_OVER_Y)*sf;   
sf = lendf+qf;                                     
ext_prf = rkf(+1)-rf;                             
%%%%%%%%INTERMEDIATE GOODS FIRMS%%%%%%%
yf = FCP*(a + ALPHA*(lendf(-1)+kq)+ALPHA*uf  +(1-ALPHA)*ellf);   
rkf = (ZK_SS/R_K_SS)*zkf + (1-DELTA_SS)/R_K_SS*(qf+kq)-qf(-1); 
uf = (1/(ZETA/(1-ZETA)))*zkf  ;          
a=ALPHA*zkf+ (1-ALPHA)*wf  ;   
zkf=wf+ellf-lendf(-1)-uf;                    
%CAPITAL PRODUCERS
invf = (1/(1+BETABAR*1))* (invf(-1) + BETABAR*1*invf(+1)+(1/(1^2*S_PRIMEP))*(qf +invss))  ;
%lendf  =  ((1-DELTA_SS)/1)*(lendf(-1)+kq)+I_OVER_K*invf + I_OVER_K*1^2*S_PRIMEP*invss ;
lendf  =((1-DELTA_SS)/1)*(lendf(-1)+kq)+DELTA_SS*(invf)+ I_OVER_K*1^2*S_PRIMEP*invss  ; %+ invss
% RESOURCE CONSTRAINTS
yf=(C_OVER_Y)*cf+(I_OVER_Y)*invf+G_Y*G+K_OVER_Y*ZK_SS*uf;       

%%%%%%%%%%%%%%%%%%%%%%%%%
%STICKY PRICE-WAGE MODEL%
%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%HOUSEHOLDS%%%%%%%
(1-HBAR)*mu=HBAR*c(-1)-c;
Lambda = mu-mu(-1);                        
Lambda(+1)+ r - pinf(+1) = 0;                     
w   =  (1/(1+BETABAR*1))*w(-1) +(BETABAR*1/(1+BETABAR* 1))*w(+1)+(SIGMA_WI/(1+BETABAR*1))
*pinf(-1)-(1+ BETABAR* 1*SIGMA_WI)/(1+BETABAR*1)*pinf+(BETABAR* 1)/(1+BETABAR*1)*pinf(+1)
+ (1-SIGMA_W)*((1-BETABAR* 1*SIGMA_W) *(1/(1+BETABAR*1))
/(SIGMA_W*(1+ EPSILON_W *PHI )))* (PHI*ell + (1/(1-HBAR))*c - ((HBAR)/(1-HBAR))*c(-1) -w) + sw ;
%FINANCIAL INTERMEDIARIES
v = CBETA*THETA*X_SS*(Lambda(+1)+x+v(+1))+((1-THETA)/NU_SS)*BETABAR*(R_K_SS*rk-R_SS*(r(-1)-pinf))+((1-THETA)/NU_SS)*BETABAR*(R_K_SS-R_SS)*Lambda(+1);
eta = THETA*CBETA*Z_SS*(Lambda(+1)+z+eta(+1));  
z = (1/Z_SS)*((LEV_SS*R_K_SS/1)*rk+(R_SS*(1-LEV_SS/1))*(r(-1)-pinf)+
    ((R_K_SS-R_SS)*LEV_SS/1)*lev(-1));        
x = lev+z-lev(-1);                          
lev = eta(+1)+(NU_SS/(LAMBDA-NU_SS))*v(+1);%if I change the timing BK is not satisfied
n_e = n(-1)+z;                     
lend(+1)+q=n+lev; 
n=(N_e_OVER_Y/N_OVER_Y)*n_e+(S_OVER_Y/N_OVER_Y)*s; 
s = lend+q;                                    
ext_pr = rk(+1)-(r-pinf(+1));                           
%INTERMEDIATE GOODS FIRMS
y = FCP*(a + ALPHA*(lend(-1)+kq)+ALPHA*u  +(1-ALPHA)*ell);
rk = (ZK_SS/R_K_SS)*zk + (1-DELTA_SS)/R_K_SS*(q+kq)- q(-1);    
u = (1/(ZETA/(1-ZETA)))*zk  ;          
zk=w+ell-lend(-1)-u;
%CAPITAL PRODUCERS
inv = (1/(1+BETABAR*1))* (inv(-1) + BETABAR*1*inv(+1)+(1/(1^2*S_PRIMEP))*(q+invss) )  ;
lend=  ((1-DELTA_SS)/1)*(lend(-1)+kq)+DELTA_SS*(inv)+ I_OVER_K*1^2*S_PRIMEP*invss ;%+invss)  ;  
% RESOURCE CONSTRAINTS
y=(C_OVER_Y)*c+(I_OVER_Y)*inv+G_Y*G+K_OVER_Y*ZK_SS*u;      
%MONETARY AUTHORITY
pinf =  (1/(1+BETABAR*1*SIGMA_PI)) * (BETABAR*1*pinf(+1) +SIGMA_PI*pinf(-1)+((1-SIGMAP)*(
1-BETABAR*1*SIGMAP)/SIGMAP)*(ALPHA*zk-a+(1-ALPHA)*(w) ) ) + spinf ; 
r=RHO_I*r(-1)+(1-RHO_I)*(IOTA_PI*pinf+IOTA_Y*(y-yf))+IOTA_DY*(y-yf-y(-1)+yf(-1))
+ IOTA_DPI*(pinf-pinf(-1))+ms; 
% AR PROCESSES FOR SOME SHOCKS                       
a = RHO_A*a(-1) - e_a ;                          
invss = RHO_X*invss(-1) - e_x ;               
G   =   RHO_G*G(-1)-e_g;            
ms = RHO_MS*ms(-1) + e_i;
spinf = RHO_P*spinf(-1) + epinfma - MAP*epinfma(-1);
epinfma=epinf;
sw = RHO_W*sw(-1) + ewma - MAW*ewma(-1) ;
ewma=ew;     
kq   =   RHO_RP*kq(-1)- e_kq;       

% measurement equations
 
gdp_rgd_obs   =y-y(-1)+ctrend;
c_rgd_obs   =c-c(-1)+ctrend;
ifi_rgd_obs =inv-inv(-1)+ctrend;
wage_rgd_obs   =w-w(-1)+ctrend;
gdpdef_obs = 1*(pinf) + picbar;
ffr_obs =    1*(r) + conster;
hours_sw07_obs = ell + constelab;
 
end;

steady;

check;

shocks;
var e_a; stderr 0.639;
var e_x; stderr 0.8913;
var e_g; stderr 0.335;
var e_kq; stderr 0.6017;
var e_i; stderr 0.2397;
var epinf; stderr 0.1655;
var ew; stderr 0.297;
end;
varobs gdp_rgd_obs c_rgd_obs ifi_rgd_obs hours_sw07_obs gdpdef_obs wage_rgd_obs ffr_obs;

estimated_params;

stderr e_a,   0.3974 ,0.01,25,INV_GAMMA_PDF,0.1,2;
stderr e_x,   1.0534 ,0.01,50,INV_GAMMA_PDF,0.1,2;
stderr e_i,   0.1224 ,0.01,25,INV_GAMMA_PDF,0.1,2;
stderr e_kq,  0.1705 ,0.025,25,INV_GAMMA_PDF,0.1,2;
stderr e_g,   2.2030 ,0.01,50,INV_GAMMA_PDF,0.1,2;
stderr epinf, 0.1288 ,0.01,25,INV_GAMMA_PDF,0.1,2;
stderr ew,    0.2806 ,0.01,25,INV_GAMMA_PDF,0.1,2;
%%%%%%%%%%%%%%%%%%%%%%%%%
RHO_A,         0.9493 ,.01,.99999,BETA_PDF,0.5,0.20;
RHO_RP,        0.9802 ,.01,.99999,BETA_PDF,0.5,0.20;
RHO_G,         0.9624 ,.01,.9999999,BETA_PDF,0.5,0.20;
RHO_X,         0.9914 ,.01,.9999999,BETA_PDF,0.5,0.20;
RHO_MS,        0.2154 ,-0.02,.9999,BETA_PDF,0.5,0.20;
RHO_P,         0.2101 ,.01,.99999,BETA_PDF,0.5,0.20;
RHO_W,         0.1907 ,.001,.9999,BETA_PDF,0.5,0.20;
S_PRIMEP,      3.8293 ,0.0001,15,NORMAL_PDF,4,1.5;
H,             0.4279 ,0.1,0.99,BETA_PDF,0.7,0.1;
SIGMA_W,       0.8453 ,0.25,0.99,BETA_PDF,0.75,0.05;
SIGMAP,        0.8953 ,0.5,0.97,BETA_PDF,0.75,0.05;
FCP,           1.3488 ,1.0,3,NORMAL_PDF,1.45,0.125;
PHI,           1.6665 , 0.1, 3.5,gamma_pdf, 0.33,  0.25;
SIGMA_WI,      0.3078 ,0.01,0.99,BETA_PDF,0.5,0.15;
SIGMA_PI,      0.4257 ,0.01,0.99,BETA_PDF,0.5,0.15;
ZETA,          0.8554 ,0.0001,1,BETA_PDF,0.25,0.15;
IOTA_PI,       1.8855 , 1.0,3,NORMAL_PDF,1.7,0.15;
RHO_I,         0.8495 ,0.35,0.975,BETA_PDF,0.75,0.10;
IOTA_Y,        0.0743 ,-0.065 ,0.5,GAMMA_PDF,.125,0.05;
% IOTA_DPI,      0.0931 , -0.145,0.6, normal_pdf, 0.3,0.1;
IOTA_DY,       0.2004 ,-0.1,0.5,NORMAL_PDF,0.0625,0.05;
%%%%%%%%%%%%%%%%%%%%%
picbar,       0.6473 ,0.1,2.0,GAMMA_PDF,0.625,0.1;
ctrend,       0.3029 ,0.001,0.8,NORMAL_PDF,0.4,0.10;

end;

%options_.plot_priors=0;

%,,,bayesian_irf,mode_file=swbggus_mode,,bayesian_irf
% estimation(datafile=dataset_mv,mode_compute=0,mode_file=swgkusr2_mode,first_obs=125,nobs = 103, presample=0,
% lik_init=2,prefilter=0,conf_sig=0.95,mh_replic=0,load_mh_file,mh_nblocks=2,mh_jscale=0.35,
% mh_drop=0.25,moments_varendo) y inv c pinf r ext_pr n;

%it gives IRF and variance decomposition,,conditional_variance_decomposition=[1 4 8 40 80]
%stoch_simul(irf=20,nograph)y inv pinf c ffr_obs q n ext_pr;
estimation(nodisplay, smoother, order=1, prefilter=0, datafile=data_20011114, xls_sheet=s3, xls_range=B1:BE101, presample=4, mh_replic=500000, mh_nblocks=1, mh_jscale=0.3, mh_drop=0.3, sub_draws=5000, forecast=40, mode_compute=1) gdp_rgd_obs;