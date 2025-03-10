% Chiara Fratto
% Catanzaro, May 20, 2015
%-------------------------------------------
% 0. Housekeeping
%-------------------------------------------
close all
%-------------------------------------------
% 1. Defining Variables
%-------------------------------------------
var hours_sw07_obs      ${lHOURS}$      (long_name='log hours worked')
    ffr_obs        ${FEDFUNDS}$    (long_name='Federal funds rate')
    gdpdef_obs     ${dlP}$         (long_name='Inflation')
    gdp_rgd_obs          ${dlGDP}$       (long_name='Output growth rate')
    c_rgd_obs          ${dlCONS}$      (long_name='Consumption growth rate')
    ifi_rgd_obs       ${dlINV}$       (long_name='Investment growth rate')
    wage_rgd_obs          ${dlWAG}$       (long_name='Wage growth rate')
    mc w r_k pi c R L k u k_bar i Q y
    w_flex r_k_flex c_flex R_flex L_flex k_flex u_flex
    k_bar_flex i_flex y_flex Q_flex
    Z lambda_p lambda_w b2 mu g ms;
varexo eZ ep ew eb2 emu
    eg ems ;
parameters h gamma sigma_c wLc beta beta_bar inv_adj_cost r_kSS delta
    invest_ratioSS
    Phi alpha zeta_p iota_p lambda_pSS
    zeta_w nu_L iota_w lambda_wSS
    rhoR psi1 psi2 psi3
    consumpt_ratioSS capital_ratioSS gSS capital_to_laborSS wSS
    ctrend const_pi const_R const_L constebeta
    rhoZ rhob2 rhog rhogZ rhomu rhop thetap rhow thetaw rhoms czcap
    curvp curvw invest_to_capitalbarSS;

%-------------------------------------------
% 2. Parameters
%-------------------------------------------
%--------------------- fixed parameters -------------------------%
delta =         .025;
lambda_wSS =    0.5;
gSS =           0.18;
curvp =         10;
curvw =         10;

%-------------- estimated parameters initialization -----------%
alpha =         .24;
gamma =         1.004;
constebeta =    (1/.9995 - 1)*100;
sigma_c =       1.5;
cpie =          1.005;
Phi =           1.5;
rhogZ =         0.51;

inv_adj_cost =  6.0144;
h =             0.6361;
zeta_w =        0.8087;
nu_L =          1.9423;
zeta_p =        0.6;
iota_w =        0.3243;
iota_p =        0.47;
czcap =         0.2696;
psi1 =          1.488;
rhoR =          0.8762;
psi2 =          0.0593;
psi3 =          0.2347;

rhoZ =          0.9977;
rhob2 =         0.5799;
rhog =          0.9957;
rhomu =         0.7165;
rhoms =         0;
rhop =          0;
rhow =          0;
thatap =        0;
thetaw  =       0;

const_L =           0;

%------------------- derived parameters -------------------------%
beta =              1/(1+constebeta/100);
beta_bar =          beta*gamma^(-sigma_c);
ctrend =            (gamma-1)*100;
lambda_pSS =        Phi-1;
cr =                cpie/(beta*gamma^(-sigma_c));
r_kSS =             (beta^(-1))*(gamma^sigma_c) - (1-delta);
wSS =               (alpha^alpha*(1-alpha)^(1-alpha)/(Phi*r_kSS^alpha))^(1/(1-alpha));
invest_to_capitalbarSS = (1-(1-delta)/gamma);
capital_to_laborSS =(alpha/(1-alpha))*(wSS/r_kSS);
capital_ratioSS =   Phi*(capital_to_laborSS)^(1 - alpha);
invest_ratioSS =    ((1-(1-delta)/gamma)*gamma)*capital_ratioSS;
consumpt_ratioSS =  1-gSS-((1-(1-delta)/gamma)*gamma)*capital_ratioSS;
wLc =               (1/(1 + lambda_wSS))*(1-alpha)/alpha*r_kSS*capital_ratioSS/consumpt_ratioSS;


const_R =           (cr-1)*100;
const_pi =          (cpie-1)*100;


%-------------------------------------------
% 3. Model
%-------------------------------------------
model(linear);
%------------------ stiky prices and wages ---------------------%
c =         (h/gamma)/(1+h/gamma)*c(-1) + (1/(1+h/gamma))*c(+1) +((sigma_c-1)*wLc/(sigma_c*(1+h/gamma)))*(L-L(+1)) - (1-h/gamma)/(sigma_c*(1+h/gamma))*(R-pi(+1) ) +b2 ;
i =         (1/(1+beta_bar*gamma))* (i(-1) + beta_bar*gamma*i(1)+(1/(gamma^2*inv_adj_cost))*Q ) +mu ;
Q =         1/((1 - h/gamma)/(sigma_c*(1 + h/gamma)))*b2 -( R - pi(+1))+r_kSS/(r_kSS + 1 - delta)*r_k(+1) + (1 - delta)/(r_kSS + 1 - delta)*Q(+1);
u =         (1/(czcap/(1-czcap)))* r_k ;
k =         u + k_bar(-1);
k_bar=      (1 - invest_to_capitalbarSS)*k_bar(-1) +
            invest_to_capitalbarSS*(gamma^2*inv_adj_cost*mu + i);
y =         Phi*Z+ alpha*Phi*k + (1 - alpha)*Phi*L;
k =         w - r_k + L;
mc =        alpha*r_k + (1 - alpha)*w - Z;
pi =        (1 - zeta_p*beta_bar*gamma)*(1 - zeta_p)/(1 + beta_bar*gamma*iota_p)/zeta_p/(lambda_pSS*curvp+1)*(mc )+ lambda_p +
            iota_p/(1 + beta_bar*gamma*iota_p)*pi(-1) + beta_bar*gamma/(1 + beta_bar*gamma*iota_p)*pi(+1);
w =         (1/(1 + beta_bar*gamma))*(w(-1) + beta_bar*gamma*w(+1) +
            (1 - zeta_w*beta_bar*gamma)*(1-zeta_w)/zeta_w/(lambda_wSS*curvw+1)*(1/(1 - h/gamma)*c - h/gamma/(1 - h/gamma)*c(-1)+ nu_L*L - w) -
            (1 + beta_bar*gamma*iota_w)*pi + iota_w*pi(-1)+beta_bar*gamma*pi(+1)) + lambda_w;
R =         rhoR*R(-1) + (1-rhoR)*(psi1*pi + psi2*(y - y_flex)) + psi3*(y - y(-1) - (y_flex -y_flex(-1)))+ms;
y =         consumpt_ratioSS*c + invest_ratioSS*i + g + r_kSS*capital_ratioSS*u ;


%-------------------------- flex economy ------------------------%
c_flex =    (h/gamma)/(1+h/gamma)*c_flex(-1) + (1/(1+h/gamma))*c_flex(+1) +((sigma_c-1)*wLc/(sigma_c*(1+h/gamma)))*(L_flex-L_flex(+1)) - (1-h/gamma)/(sigma_c*(1+h/gamma))*(R_flex ) +b2 ;
i_flex =    1/(1 + beta_bar*gamma)*(i_flex(-1) + beta_bar*gamma*i_flex(+1)+1/(gamma^2*inv_adj_cost)*(Q_flex ))+ mu;
Q_flex =    1/((1 - h/gamma)/(sigma_c*(1 + h/gamma)))*b2 -( R_flex )+r_kSS/(r_kSS + 1 - delta)*r_k_flex(+1) + (1 - delta)/(r_kSS + 1 - delta)*Q_flex(+1);
u_flex =    (1/(czcap/(1-czcap)))* r_k_flex ;
k_flex =    u_flex + k_bar_flex(-1);
k_bar_flex= (1 - invest_ratioSS*(capital_ratioSS*gamma)^(-1))*k_bar_flex(-1) +
            invest_ratioSS*(capital_ratioSS*gamma)^(-1)*(gamma^2*inv_adj_cost*mu + i_flex);
y_flex =    ( Phi)*Z+ alpha*( Phi)*k_flex + (1 - alpha)*(Phi)*L_flex;
k_flex =    w_flex - r_k_flex + L_flex;
0 =         alpha*r_k_flex + (1 - alpha)*w_flex - Z;
w_flex =    1/(1 - h/gamma)*c_flex - h/gamma/(1 - h/gamma)*c_flex(-1)+ nu_L*L_flex;
y_flex =    consumpt_ratioSS*c_flex + invest_ratioSS*i_flex + g + r_kSS*capital_ratioSS*u_flex ;


%------------------ exogenous processes -------------------------%
Z =         rhoZ*Z(-1) + eZ;
b2 =        rhob2*b2(-1)+eb2;
g =         rhog*g(-1) + eg + rhogZ*eZ;
mu =        rhomu*mu(-1) + emu;
lambda_p =  rhop*lambda_p(-1)+ ep - thetap*ep(-1);
lambda_w =  rhow*lambda_w(-1)+ ew - thetaw*ew(-1);
ms =        rhoms*ms(-1) + ems;

%------------------ measurement equations -----------------------%

gdp_rgd_obs =        y-y(-1)+ctrend;
c_rgd_obs =        c-c(-1)+ctrend;
ifi_rgd_obs =     i-i(-1)+ctrend;
wage_rgd_obs =        w-w(-1)+ctrend;
gdpdef_obs =   pi + const_pi;
ffr_obs =      R + const_R;
hours_sw07_obs =    L + const_L;
end;
%-------------------------------------------
% 4. Computation
%-------------------------------------------

shocks;
var eZ;
stderr 0.4618;
var eb2;
stderr 1.8513;
var eg;
stderr 0.6090;
var emu;
stderr 0.6017;
var ems;
stderr 0.2397;
var ep;
stderr 0.1455;
var ew;
stderr 0.2089;
end;




estimated_params;
// PARAM NAME, INITVAL, LB, UB, PRIOR_SHAPE, PRIOR_P1, PRIOR_P2, PRIOR_P3, PRIOR_P4, JSCALE
// PRIOR_SHAPE: BETA_PDF, GAMMA_PDF, NORMAL_PDF, INV_GAMMA_PDF
stderr eZ,0.4618,0.01,3,INV_GAMMA_PDF,0.1,2;
stderr eb2,0.1818513,0.025,5,INV_GAMMA_PDF,0.1,2;
stderr eg,0.6090,0.01,3,INV_GAMMA_PDF,0.1,2;
stderr emu,0.46017,0.01,3,INV_GAMMA_PDF,0.1,2;
stderr ems,0.2397,0.01,3,INV_GAMMA_PDF,0.1,2;
stderr ep,0.1455,0.01,3,INV_GAMMA_PDF,0.1,2;
stderr ew,0.2089,0.01,3,INV_GAMMA_PDF,0.1,2;
rhoZ,.9676 ,.01,.9999,BETA_PDF,0.5,0.20;
rhob2,.2703,.01,.9999,BETA_PDF,0.5,0.20;
rhog,.9930,.01,.9999,BETA_PDF,0.5,0.20;
rhomu,.5724,.01,.9999,BETA_PDF,0.5,0.20;
rhoms,.3,.01,.9999,BETA_PDF,0.5,0.20;
rhop,.8692,.01,.9999,BETA_PDF,0.5,0.20;
rhow,.9546,.001,.9999,BETA_PDF,0.5,0.20;
thetap,.7652,0.01,.9999,BETA_PDF,0.5,0.2;
thetaw,.8936,0.01,.9999,BETA_PDF,0.5,0.2;
inv_adj_cost,6.3325,2,15,NORMAL_PDF,4,1.5;
sigma_c,1.2312,0.25,3,NORMAL_PDF,1.50,0.375;
h,0.7205,0.001,0.99,BETA_PDF,0.7,0.1;
zeta_w,0.7937,0.3,0.95,BETA_PDF,0.5,0.1;
nu_L,2.8401,0.25,10,NORMAL_PDF,2,0.75;
zeta_p,0.7813,0.5,0.95,BETA_PDF,0.5,0.10;
iota_w,0.4425,0.01,0.99,BETA_PDF,0.5,0.15;
iota_p,0.3291,0.01,0.99,BETA_PDF,0.5,0.15;
czcap,0.2648,0.01,1,BETA_PDF,0.5,0.15;
Phi,1.4672,1.0,3,NORMAL_PDF,1.25,0.125;
psi1,1.7985,1.0,3,NORMAL_PDF,1.5,0.25;
rhoR,0.8258,0.5,0.975,BETA_PDF,0.75,0.10;
psi2,0.0893,0.001,0.5,NORMAL_PDF,0.125,0.05;
psi3,0.2239,0.001,0.5,NORMAL_PDF,0.125,0.05;
const_pi,0.7,0.1,2.0,GAMMA_PDF,0.625,0.1;//20;
constebeta,0.7420,0.01,2.0,GAMMA_PDF,0.25,0.1;//0.20;
const_L,1.2918,-10.0,10.0,NORMAL_PDF,0.0,2.0;
ctrend,0.3982,0.1,0.8,NORMAL_PDF,0.4,0.10;
rhogZ,0.05,0.01,2.0,NORMAL_PDF,0.5,0.25;
alpha,0.24,0.01,1.0,NORMAL_PDF,0.3,0.05;
end;

varobs gdp_rgd_obs c_rgd_obs ifi_rgd_obs hours_sw07_obs gdpdef_obs wage_rgd_obs ffr_obs;
//dy dc dinve labobs pinfobs dw robs;

//estimation(optim=('MaxIter',200),datafile=usmodel_data2015,mode_compute=1,first_obs=144, presample=4,lik_init=2,prefilter=0,mh_replic=250000,mh_nblocks=2,mh_jscale=0.20,mh_drop=0.2);

//stoch_simul(irf=20) gdpdef_obs gdp_rgd_obs ffr_obs c_rgd_obs ifi_rgd_obs hours_sw07_obs wage_rgd_obs;


//shock_decomposition gdpdef_obs gdp_rgd_obs ffr_obs c_rgd_obs ifi_rgd_obs hours_sw07_obs wage_rgd_obs;

estimation(nodisplay, smoother, order=1, prefilter=0, datafile=data_20010815, xls_sheet=s2, xls_range=B1:BE101, presample=4, mh_replic=500000, mh_nblocks=1, mh_jscale=0.3, mh_drop=0.3, sub_draws=5000, forecast=40, mode_compute=4) gdp_rgd_obs;