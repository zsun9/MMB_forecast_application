% Financial frictions in the Euro Area and the United States: a Bayesian assessment
% Macroeconomic Dynamics, 20 (05), p. 1313-1340, 2016
% Stefania Villa

var   hobsgm robs piobs dy dc dfi dw ewma epinfma uf  kf qf cf invf yf ellf wf rf 
zkf zk u k q c inv y ell pinf w r a g x ms  spinf sw kq ;    
 
varexo ea eg  eqs  em  epinf ew e_kq ;  

parameters ALPHA CBETA DELTA_SS WMU G_Y EPSILON EPSILON_W
ctrend SIGMAC cpie CGY S_PRIMEP H M_U SIGMA_EM
SIGMA_W SIGMAP SIGMA_WI SIGMA_PI ZETA IOTA_PI IOTA_DY IOTA_Y RHO_I IOTA_DPI
RHO_A RHO_EFP RHO_G RHO_X RHO_MS RHO_P RHO_W MAW MAP
constelab  FCP PPHI picbar   ;

% Y_OVER_K C_OVER_K C_OVER_Y K_OVER_Y I_OVER_Y K_OVER_L W_SS conster  
% derived from steady state GAMMAT BETABAR R_SS HBAR ZK_SS
% I_OVER_K L_OVER_K spread

% calibrated parameters
ALPHA       = 0.33;
CBETA       = 0.99;
DELTA_SS    = 0.025;
EPSILON    = 6;         % Price elasticity of demand for retail good
EPSILON_W  = 6;            % elasticity across different types of labour
WMU         = 1.2;   % the mark-up is equal to 1.5 EPSILON /(EPSILON-1)
M_U        = EPSILON /(EPSILON-1);
G_Y        = 0.20;
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
SIGMA_EM    =  0.5;
ZETA        =   0.2696;
IOTA_PI     =   1.488;
RHO_I       =   0.8762;
IOTA_Y      =   0.0593;
IOTA_DY     =   0;
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
constelab  = 0;
picbar     = 0.8; 
ctrend      = 0.43;


model(linear); 
#GAMMAT     = 1 + ctrend/100;
#pic_ss     = 1+picbar/100;
#HBAR   = H/1;
#BETABAR=CBETA*1^(-SIGMAC);
#R_SS=1/(CBETA*1^(-SIGMAC));
#ZK_SS      = R_SS - (1-DELTA_SS);
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
qf + rf = (ZK_SS/(ZK_SS+(1-DELTA_SS)))*zkf(+1) + ((1-DELTA_SS)/(ZK_SS+(1-DELTA_SS)))*(qf(+1)+kq(+1)); 
(HBAR/(1-HBAR))*cf=(1/(1-HBAR))*cf(+1)+(HBAR/(1-HBAR))*cf(-1)-(1/(1-HBAR))*cf- rf ;
% cf   = (H/1)/(1+H/1)*cf(-1) + (1/(1+H/1))*cf(+1)- (1-H/1)/(SIGMAC*(1+H/1))*(rf)+
% ((SIGMAC-1)*WHL_OVER_C/(SIGMAC*(1+H/1)))*(ellf-ellf(+1)) ;
yf   = C_OVER_Y*cf+I_OVER_Y*invf+G_Y*g+ ZK_SS*K_OVER_Y*uf ;
yf   = FCP*(a + ALPHA*(kf(-1)+kq) + ALPHA*uf  +(1-ALPHA)*ellf);    
wf   = PPHI*ellf	+(1/(1-HBAR))*cf -(HBAR)/(1-HBAR)*cf(-1) ;
kf   =((1-DELTA_SS)/1)*(kf(-1)+kq)+(I_OVER_K)*(invf )+I_OVER_K*1^2*S_PRIMEP*x ;

%%%%%%%%%%%%%%%%%%%%%%%%%
%%STICKY PRICE MODEL%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
u   =  (1/(ZETA/(1-ZETA)))* zk ;
zk  =  w+ell-k(-1)-u ;
inv = (1/(1+BETABAR*1))* (inv(-1) + BETABAR*1*inv(+1)+(1/(1^2*S_PRIMEP))*(q+x) )  ;
q + r - pinf(+1) = (ZK_SS/(ZK_SS+(1-DELTA_SS)))*zk(+1) + ((1-DELTA_SS)/(ZK_SS+(1-DELTA_SS)))*(q(+1)+kq(+1));
(HBAR/(1-HBAR))*c=(1/(1-HBAR))*c(+1)+(HBAR/(1-HBAR))*c(-1)-(1/(1-HBAR))*c- (r-pinf(+1)) ;
% c   = (H/1)/(1+H/1)*c(-1) + (1/(1+H/1))*c(+1)- (1-H/1)/(SIGMAC*(1+H/1))*(r-pinf(+1) ) +
% ((SIGMAC-1)*WHL_OVER_C/(SIGMAC*(1+H/1)))*(ell-ell(+1)) ;
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
k  =  ((1-DELTA_SS)/1)*(k(-1)+kq)+I_OVER_K*(inv)+ I_OVER_K*1^2*S_PRIMEP*x ;
a  = RHO_A*a(-1)  - ea;
g  = RHO_G*(g(-1)) - eg - CGY*ea;
x  = RHO_X*x(-1) - eqs;
ms = RHO_MS*ms(-1) + em;
spinf = RHO_P*spinf(-1) + epinfma - MAP*epinfma(-1);
epinfma=epinf;
sw = RHO_W*sw(-1) + ewma - MAW*ewma(-1) ;
ewma=ew; 
kq  = RHO_EFP*kq(-1) - e_kq;

% measurement equations

dy   =y-y(-1)+ctrend;
dc   =c-c(-1)+ctrend;
dfi =inv-inv(-1)+ctrend;
dw   =w-w(-1)+ctrend;
piobs = 1*(pinf) + picbar;
robs =    1*(r) + conster;
hobsgm = ell + constelab;

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

varobs dy dc dfi hobsgm piobs dw robs;

estimated_params;
stderr ea,     0.3831 ,0.01,30,INV_GAMMA_PDF,0.1,2;
stderr e_kq,   0.2064 ,0.025,40,INV_GAMMA_PDF,0.1,2;
stderr eg,     2.3775 ,0.01,30,INV_GAMMA_PDF,0.1,2;
stderr eqs,    3.1357 ,0.01,30,INV_GAMMA_PDF,0.1,2;
stderr em,     0.1255 ,0.01,30,INV_GAMMA_PDF,0.1,2;
stderr epinf,  0.1322 ,0.01,30,INV_GAMMA_PDF,0.1,2;
stderr ew,     0.2795 ,0.01,30,INV_GAMMA_PDF,0.1,2;
% %%%%%%%%%%%%%%%%%%%%%%%%%
RHO_A,         0.9397 ,.01,.99999,BETA_PDF,0.5,0.20;
RHO_EFP,       0.9672 ,.01,.99999,BETA_PDF,0.5,0.20;
RHO_G,         0.9294 ,.01,.9999999,BETA_PDF,0.5,0.20;
RHO_X,         0.1706 ,.01,.9999999,BETA_PDF,0.5,0.20;
RHO_MS,        0.2297 ,-0.02,.9999,BETA_PDF,0.5,0.20;
RHO_P,         0.2135 ,.01,.99999,BETA_PDF,0.5,0.20;
RHO_W,         0.1633 ,.001,.9999,BETA_PDF,0.5,0.20;
S_PRIMEP,      2.2306 ,0.0001,15,NORMAL_PDF,4,1.5;
H,             0.4100 ,0.1,0.99,BETA_PDF,0.7,0.1;
SIGMA_W,       0.9002 ,0.25,0.99,BETA_PDF,0.75,0.05;
SIGMAP,        0.8758 ,0.5,0.97,BETA_PDF,0.75,0.05;
FCP,           1.3814 ,1.0,3,NORMAL_PDF,1.45,0.125;
PPHI,          0.9611 , 0.1, 3.5,gamma_pdf, 0.33,  0.25;
SIGMA_WI,      0.2085 ,0.01,0.99,BETA_PDF,0.5,0.15;
SIGMA_PI,      0.4320 ,0.01,0.99,BETA_PDF,0.5,0.15;
ZETA,          0.8686 ,0.0001,1,BETA_PDF,0.25,0.15;
IOTA_PI,       1.8050 , 1.0,3,NORMAL_PDF,1.7,0.15;
RHO_I,         0.8261 ,0.5,0.975,BETA_PDF,0.75,0.10;
IOTA_Y,        0.0167 ,-0.065 ,0.5,GAMMA_PDF,.125,0.05;
% IOTA_DPI,      0.0516 , -0.15,0.5, normal_pdf, 0.3,0.1;
IOTA_DY,       0.0363 ,-0.1,0.5,NORMAL_PDF,0.0625,0.05;
%%%%%%%%%%%%%%%%%%%%%
picbar,       0.5702 ,0.1,2.0,GAMMA_PDF,0.625,0.1;
ctrend,       0.3272 ,0.01,0.8,NORMAL_PDF,0.4,0.10;
%%%constelab,   -3.4365 ,-10.0,10.0,NORMAL_PDF,0.0,2.0;
% constebeta,0.7420,0.01,2.0,GAMMA_PDF,0.25,0.1;
%%% CGY,0.05,-0.5,2.0,NORMAL_PDF,0.5,0.25;
% % % MAP,.7652,0.01,.9999,BETA_PDF,0.5,0.2;
% % % MAW,.8936,0,.9999,BETA_PDF,0.5,0.2;
end;

options_.plot_priors=0;

%load_mh_file,moments_varendo,bayesian_irf
% estimation(datafile=dataset_mv,mode_compute=0,mode_file=swusr2_mode,first_obs=125,nobs = 103, presample=0,
% lik_init=2,prefilter=0,conf_sig=0.95,mh_replic=250000,mh_nblocks=2,mh_jscale=0.32,mh_drop=0.25) y inv pinf robs q k c;

% ,conditional_variance_decomposition=[1 4 8 40 80]
stoch_simul(irf=20, nograph) y inv pinf robs q k c  ;

