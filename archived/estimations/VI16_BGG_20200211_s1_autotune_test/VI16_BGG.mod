% Financial frictions in the Euro Area and the United States: a Bayesian assessment
% Macroeconomic Dynamics, 20 (05), p. 1313-1340, 2016
% Stefania Villa
% Model SWBGG

var   hours_sw07_obs ffr_obs gdpdef_obs gdp_rgd_obs c_rgd_obs ifi_rgd_obs wage_rgd_obs  ewma epinfma  uf rkf kf qf cf invf yf ellf wf rf 
ext_prf zkf nf ext_pr  zk n u rk k q c inv y ell pinf w r a g x ms  spinf sw kq ;    
 
varexo ea eg  eqs  em  epinf ew e_kq ;  

parameters THETA ALPHA CBETA DELTA_SS WMU G_Y EPSILON EPSILON_W
S_COEF  N_over_K K_over_N VARKAPPA ctrend SIGMAC cpie CGY S_PRIMEP H M_U
SIGMA_W SIGMAP SIGMA_WI SIGMA_PI ZETA IOTA_PI IOTA_DY IOTA_Y RHO_I IOTA_DPI
RHO_A RHO_EFP RHO_G RHO_X RHO_MS RHO_P RHO_W MAW MAP
constelab  FCP PPHI picbar  basispoint  ;

% Y_OVER_K C_OVER_K C_OVER_Y K_OVER_Y I_OVER_Y K_OVER_L W_SS conster  
% derived from steady state GAMMAT BETABAR R_SS R_K_SS HBAR ZK_SS
% R_K_SS_BAR I_OVER_K L_OVER_K spread

% calibrated parameters
ALPHA       = 0.33;
CBETA       = 0.99;
DELTA_SS    = 0.025;
EPSILON    = 6;         % Price elasticity of demand for retail good
EPSILON_W  = 6;            % elasticity across different types of labour
WMU         = 1.2;   % the mark-up is equal to 1.5 EPSILON /(EPSILON-1)
M_U        = EPSILON /(EPSILON-1);
G_Y        = 0.20;
THETA       = 0.9715;  
S_COEF      =  1.00375;  
N_over_K    = 0.5;
K_over_N    = N_over_K^-1;
VARKAPPA    = 0.045;      
SIGMAC      =   1;
PPHI        =   1.2;
cpie        =   1.0143;

% estimated parameters initialisation
CGY         =   0;
FCP         =   1.4;
S_PRIMEP    =   6.0144;
H           =   0.6361;    
SIGMA_W     =   0.8087;
SIGMAP      =   0.7500;
SIGMA_WI    =   0.3243;
SIGMA_PI    =   0.47;
ZETA        =   0.2696;
IOTA_PI     =   1.488;
RHO_I       =   0.8762;
IOTA_Y      =   0.0593;
IOTA_DY     =   0.2347;
IOTA_DPI    =   0;
RHO_A   =   0.9577;
RHO_EFP =   0.987;
RHO_G   =   0.9957;
RHO_X   =   0.7165;
RHO_MS  =   0;
RHO_P   =   0;
RHO_W   =   0;
MAP     =   0;
MAW     =   0;

% derived from steady state
basispoint = 150;
S_COEF    = (basispoint + 40000)/40000;
constelab  = 0;
picbar     = 0.8; 
ctrend      = 0.43;


model(linear); 
#GAMMAT     = 1 + ctrend/100;
#pic_ss     = 1+picbar/100;
#HBAR   = H/1;
#BETABAR=CBETA*1^(-SIGMAC);
#R_SS= 1/(CBETA*1^(-SIGMAC));
#R_K_SS     = S_COEF*R_SS; 
#R_K_SS_BAR = R_K_SS/1;
#ZK_SS      = R_K_SS_BAR - (1-DELTA_SS);
# spread     = R_K_SS/R_SS;

#W_SS   = (ALPHA^ALPHA*((1-ALPHA)^(1-ALPHA))/(WMU*((ZK_SS)^ALPHA)))^(1/(1-ALPHA));
#K_OVER_L   = ALPHA*W_SS/((1-ALPHA)*ZK_SS);
#L_OVER_K   = K_OVER_L^-1;
#I_OVER_K   = 1- ((1-DELTA_SS)/1);
#conster    =(R_SS-1)*100;

#Y_OVER_K   = (FCP*(K_OVER_L^(1-ALPHA)))^(-1);
#C_OVER_K   = Y_OVER_K-I_OVER_K-G_Y*Y_OVER_K;
#K_OVER_Y   = Y_OVER_K^(-1);
#I_OVER_Y   = I_OVER_K/Y_OVER_K;
#C_OVER_Y   = 1-I_OVER_Y-G_Y;

%%%%%%%%%%%%%%%%%%%%%%%%%
%%FLEXIBLE PRICE MODEL%%%
%%%%%%%%%%%%%%%%%%%%%%%%% 
a    =  ALPHA*zkf+(1-ALPHA)*(wf) ;
uf   =  (1/(ZETA/(1-ZETA)))* zkf  ;
zkf  =  (wf)+ellf-kf(-1)-uf ;
invf = (1/(1+BETABAR*1))* (invf(-1) + BETABAR*1*invf(+1)+(1/(1^2*S_PRIMEP))*(qf +x))  ;
rkf  = (ZK_SS/R_K_SS)*zkf + (1-DELTA_SS)/R_K_SS*(qf+kq)  -qf(-1); 
ext_prf= VARKAPPA*(qf + kf - nf); 
rkf(+1) = rf +ext_prf ;       
nf/(THETA*R_K_SS) = (N_over_K^-1)* rkf - ((N_over_K^-1) -1) * rf(-1) - VARKAPPA * 
((N_over_K^-1) - 1) * (kf(-1) + qf(-1)) + (VARKAPPA * ((N_over_K^-1)- 1)+1)* nf(-1)     ;  
(HBAR/(1-HBAR))*cf=(1/(1-HBAR))*cf(+1)+(HBAR/(1-HBAR))*cf(-1)-(1/(1-HBAR))*cf- rf ;
% cf   = (H/GAMMAT)/(1+H/GAMMAT)*cf(-1) + (1/(1+H/GAMMAT))*cf(+1)- (1-H/GAMMAT)/(SIGMAC*(1+H/GAMMAT))*(rf)+
% ((SIGMAC-1)*WHL_OVER_C/(SIGMAC*(1+H/GAMMAT)))*(ellf-ellf(+1)) ;
yf   = C_OVER_Y*cf+I_OVER_Y*invf+G_Y*g+ ZK_SS*K_OVER_Y*uf ;
yf = FCP*(a + ALPHA*(kf(-1)+kq) + ALPHA*uf  +(1-ALPHA)*ellf);    
wf   = PPHI*ellf	+(1/(1-HBAR))*cf -(HBAR)/(1-HBAR)*cf(-1) ;
kf   =((1-DELTA_SS)/1)*(kf(-1)+kq)+(I_OVER_K)*(invf + x) ;

%%%%%%%%%%%%%%%%%%%%%%%%%
%%STICKY PRICE MODEL%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
u   =  (1/(ZETA/(1-ZETA)))* zk ;
zk  =  w+ell-k(-1)-u ;
inv = (1/(1+BETABAR*1))* (inv(-1) + BETABAR*1*inv(+1)+(1/(1^2*S_PRIMEP))*(q+x) )  ;
rk  = (ZK_SS/R_K_SS)*zk + (1-DELTA_SS)/R_K_SS*(q+kq)- q(-1); 
ext_pr= VARKAPPA*(q + k - n);
rk(+1)= ext_pr +r-pinf(+1);      
n/(THETA*R_K_SS) = (N_over_K^-1)* rk - ((N_over_K^-1) -1) * r(-1) - VARKAPPA * 
((N_over_K^-1) - 1) * (k(-1) + q(-1)) + (VARKAPPA * ((N_over_K^-1)- 1)+1)* n(-1)     ;  
(HBAR/(1-HBAR))*c=(1/(1-HBAR))*c(+1)+(HBAR/(1-HBAR))*c(-1)-(1/(1-HBAR))*c- r ;
% c   = (H/GAMMAT)/(1+H/GAMMAT)*c(-1) + (1/(1+H/GAMMAT))*c(+1)- (1-H/GAMMAT)/(SIGMAC*(1+H/GAMMAT))*(r-pinf(+1) ) +
% ((SIGMAC-1)*WHL_OVER_C/(SIGMAC*(1+H/GAMMAT)))*(ell-ell(+1)) ;
y   = C_OVER_Y*c+I_OVER_Y*inv+G_Y*g+ ZK_SS*K_OVER_Y*u ;
y = FCP*(a + ALPHA*(k(-1)+kq) + ALPHA*u  +(1-ALPHA)*ell);    
pinf =  (1/(1+BETABAR*1*SIGMA_PI)) * (BETABAR*1*pinf(+1) +SIGMA_PI*pinf(-1)+((1-SIGMAP)*(
1-BETABAR*1*SIGMAP)/SIGMAP)*(ALPHA*zk-a+(1-ALPHA)*(w) ) ) + spinf ; 
w   =  (1/(1+BETABAR*1))*w(-1) +(BETABAR*1/(1+BETABAR*1))*w(+1)+(SIGMA_WI/(1+BETABAR*1))*pinf(-1)
-(1+BETABAR*1*SIGMA_WI)/(1+BETABAR*1)*pinf+(BETABAR*1)/(1+BETABAR*1)*pinf(+1)+            
    (1-SIGMA_W)*((1-BETABAR*1*SIGMA_W) *(1/(1+BETABAR*1))/(SIGMA_W*(1+ EPSILON_W*PPHI )))* 
  (PPHI*ell + (1/(1-HBAR))*c - ((HBAR)/(1-HBAR))*c(-1) -w) + sw ;
r  = (1-RHO_I)*IOTA_PI*pinf +IOTA_Y*(1-RHO_I)*(y-yf)+IOTA_DY*(y-yf-y(-1)+yf(-1))+IOTA_DPI*(pinf-pinf(-1)) +
RHO_I*r(-1) +ms  ;
k  =  ((1-DELTA_SS)/1)*(k(-1)+kq)+I_OVER_K*inv + I_OVER_K*1^2*S_PRIMEP*x ;
a  = RHO_A*a(-1)  - ea;
g  = RHO_G*(g(-1)) - eg - CGY*ea;
x  = RHO_X*x(-1) - eqs;
ms = RHO_MS*ms(-1) + em;
spinf = RHO_P*spinf(-1) + epinfma - MAP*epinfma(-1);
epinfma=epinf;
sw = RHO_W*sw(-1) + ewma - MAW*ewma(-1) ;
ewma=ew; 
kq  = RHO_EFP*kq(-1) + e_kq;

% measurement equations

gdp_rgd_obs   =y-y(-1)+ctrend;
c_rgd_obs   =c-c(-1)+ctrend;
ifi_rgd_obs =inv-inv(-1)+ctrend;
wage_rgd_obs   =w-w(-1)+ctrend;
gdpdef_obs = 1*(pinf) + picbar;
ffr_obs =    1*(r) + conster;
hours_sw07_obs = ell + constelab;

end; 


shocks;
var ea; stderr 0.4618;
var e_kq; stderr 0.8513;
var eg; stderr 0.6090;
var eqs; stderr 0.6017;
var em; stderr 0.2397;
var epinf; stderr 0.1372;
var ew; stderr 0.2089;
end;

varobs gdp_rgd_obs c_rgd_obs ifi_rgd_obs hours_sw07_obs gdpdef_obs wage_rgd_obs ffr_obs;

estimated_params;
stderr ea,     0.3772 ,0.01,5,INV_GAMMA_PDF,0.1,2;
stderr e_kq,   0.2487 ,0.025,40,INV_GAMMA_PDF,0.1,2;
stderr eg,     2.4688 ,0.01,10,INV_GAMMA_PDF,0.1,2;
stderr eqs,    1.3985 ,0.01,10,INV_GAMMA_PDF,0.1,2;
stderr em,     0.1479 ,0.01,5,INV_GAMMA_PDF,0.1,2;
stderr epinf,  0.0803 ,0.01,5,INV_GAMMA_PDF,0.1,2;
stderr ew,     0.2973 ,0.01,5,INV_GAMMA_PDF,0.1,2;
%%%%%%%%%%%%%%%%%%%%%%%%%
RHO_A,         0.9334 ,.01,.99999,BETA_PDF,0.5,0.20;
RHO_EFP,       0.8800 ,.01,.99999,BETA_PDF,0.5,0.20;
RHO_G,         0.9520 ,.01,.9999999,BETA_PDF,0.5,0.20;
RHO_X,         0.8753 ,.01,.9999999,BETA_PDF,0.5,0.20;
RHO_MS,        0.4994 ,-0.02,.9999,BETA_PDF,0.5,0.20;
RHO_P,         0.8548 ,.01,.99999,BETA_PDF,0.5,0.20;
RHO_W,         0.1577 ,.001,.9999,BETA_PDF,0.5,0.20;
S_PRIMEP,      6.9415 ,0.0001,15,NORMAL_PDF,4,1.5;
H,             0.7485 ,0.1,0.99,BETA_PDF,0.7,0.1;
SIGMA_W,       0.8912 ,0.25,0.99,BETA_PDF,0.75,0.05;
SIGMAP,        0.8075 ,0.5,0.97,BETA_PDF,0.75,0.05;
FCP,           1.7541 ,1.0,3,NORMAL_PDF,1.45,0.125;
PPHI,          0.4133 , 0.1, 3.5,gamma_pdf, 0.33,  0.25;
SIGMA_WI,      0.3645 ,0.01,0.99,BETA_PDF,0.5,0.15;
SIGMA_PI,      0.1461 ,0.01,0.99,BETA_PDF,0.5,0.15;
ZETA,          0.9040 ,0.0001,1,BETA_PDF,0.25,0.15;
IOTA_PI,       1.6877 , 1.0,3,NORMAL_PDF,1.7,0.15;
RHO_I,         0.7447 ,0.5,0.975,BETA_PDF,0.75,0.10;
IOTA_Y,        0.0593 ,-0.065 ,0.5,GAMMA_PDF,.125,0.05;
% % IOTA_DPI,     0.0755 , -0.095,0.5, normal_pdf, 0.3,0.1;
IOTA_DY,       0.1133 ,-0.1,0.5,NORMAL_PDF,0.0625,0.05;
VARKAPPA,      0.1041 , uniform_pdf, , ,0.01,0.3;
%%%%%%%%%%%%%%%%%%%%%
picbar,       0.8941 ,0.1,2.0,GAMMA_PDF,0.625,0.1;
ctrend,       0.3982 ,0.1,0.8,NORMAL_PDF,0.4,0.05;
%%%constelab,   -3.4365 ,-10.0,10.0,NORMAL_PDF,0.0,2.0;
% constebeta,0.7420,0.01,2.0,GAMMA_PDF,0.25,0.1;
%%% CGY,0.05,-0.5,2.0,NORMAL_PDF,0.5,0.25;
% % % MAP,.7652,0.01,.9999,BETA_PDF,0.5,0.2;
% % % MAW,.8936,0,.9999,BETA_PDF,0.5,0.2;
end;

%options_.plot_priors=0;

%,,,bayesian_irf,
% estimation(datafile=dataset_mv,mode_compute=0,mode_file=swbggus_mode,first_obs=125,nobs = 103, presample=0,
% lik_init=2,prefilter=0,conf_sig=0.95,mh_replic=0,mh_nblocks=2,mh_jscale=0.35,mh_drop=0.25) y inv  ext_pr pinf ffr_obs n q k c rk;

% conditional_variance_decomposition=[1 4 8 40 80],
%stoch_simul(irf=20,nograph ) y inv ext_pr pinf ffr_obs n q k c rk ;


estimation(nodisplay, smoother, order=1, prefilter=0, datafile=data_20200211, xls_sheet=s1, xls_range=B1:BE100, presample=4, mh_replic=1000000, mh_nblocks=1, mh_drop=0.3, mh_tune_jscale=0.3, sub_draws=5000, forecast=40, mode_compute=6) gdp_rgd_obs gdpdef_obs;