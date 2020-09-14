% Financial frictions in the Euro Area and the United States: a Bayesian assessment
% Macroeconomic Dynamics, 20 (05), p. 1313-1340, 2016
% Stefania Villa

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SMETS-WOUTERS & BGG MODEL   [US]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ////////////////////////////////////////////////////////////////////////
% 1. Defining variables and parameters
% ////////////////////////////////////////////////////////////////////////

var        y  c  i  w  l  pi r rn zk  u  k  q  rk   ext_pr   n             % Variables under nominal rigidities (15)
           yf cf if wf lf    rf   zkf uf kf qf rkf  ext_prf  nf            % Variables under flexible prices (13)
           a g eps_x eps_r eps_p eps_w eps_k;                              % Shocks (7)
      
 
varexo     e_a e_g e_x e_r e_p e_w e_k;                                    % (7) 

parameters alpha beta delta  epsilon epsilon_w M G_Y kappa theta  N_K      % Calibrated Parameters
           ksi h  sigma_w sigma_p sigma_wi sigma_pi zeta  Theta            % Estimated Parameters
           rho_pi rho_dy rho_y rho_r                                       % Taylor rule parameters
           rho_a rho_k rho_g rho_x rho_ri rho_p rho_w                      % Shock persistence parematers
           phi  bas_point s_coef;

% ////////////////////////////////////////////////////////////////////////
% 2. Calibrated Parameters and Initialisations
% ////////////////////////////////////////////////////////////////////////

% Calibrated Parameters
alpha     = 0.330;    % Capital income share
beta      = 0.990;    % Discount factor
delta     = 0.025;    % Steady state depreciation rate
epsilon_w = 6.000;    % Elasticity across different types of labour, set to target M_w=1.20
epsilon   = 6.000;    % Elasticity of substitution in goods market, set to target M=1.20
M         = 1.200;    % gross steady state mark-up  
G_Y       = 0.200;    % G/Y
N_K       = 0.500;    % N/K, net worth-to-capital
theta     = 0.972;   % Probability the firm survives next period
                      
% Estimated Parameters (Initialisation)
phi       = 1.69;      % Inverse Frisch elasticity of L supply
Theta     = 1.28;      % FCP: fixed costs in production (in Villa)
ksi       = 4.75;      % 2nd derivative of Inv adjustment cost
h         = 0.48;      % Habit parameter   
zeta      = 0.79;      % Elasticity of capital utilization
sigma_w   = 0.82;      % Calvo wages, calvo parameter for unions
sigma_p   = 0.89;      % Calvo prices, calvo parameter for retail firms
sigma_wi  = 0.31;      % Indexation to past wage inflation
sigma_pi  = 0.35;      % indexation to past inflation
%sigma_e   = 0.81;     % Calvo employment  
kappa     = 0.05;      % Elasticity of external finance 

rho_pi    = 1.83;      % Response to inflation in Taylor rule
rho_r     = 0.84;      % Interest rate smoothing in Taylor rule
rho_y     = 0.12;      % Response to output gap in Taylor rule
rho_dy    = 0.18;      % Response to change in the output gap

rho_a     = 0.92;      % Persistence of technological shock
rho_k     = 0.97;
rho_g     = 0.95;
rho_x     = 0.96;      % Persistence of shock to K
rho_ri    = 0.27;
rho_p     = 0.32;
rho_w     = 0.17;

% Derived from steady state
bas_point = 150;                         % Steady state spread
s_coef    = (bas_point + 40000)/40000;   % Transformation to decimal form and quarterly basis


% ////////////////////////////////////////////////////////////////////////
% 3. Model
% ////////////////////////////////////////////////////////////////////////


model(linear); 
#R     = 1/beta;
#ZK    = R - (1-delta);
#W     = (alpha^alpha*((1-alpha)^(1-alpha))/(M*((ZK)^alpha)))^(1/(1-alpha));
#K_L   = alpha*W/((1-alpha)*ZK);
#I_K   =  delta;
#Y_K   = (Theta*(K_L^(1-alpha)))^(-1);
#C_K   = Y_K - I_K - G_Y*Y_K;
#K_Y   = Y_K^(-1);
#I_Y   = I_K / Y_K;
#C_Y   = 1 - I_Y - G_Y;
#K_N   = 1/N_K;
#RK    = s_coef*R; 

%%%%% Sticky Price Model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1 % Euler Equation
c = (1/(1+h))*c(+1)+(h/(1+h))*c(-1)- ((1-h)/(1+h))*r ;

% 2 % Phillips Curve: Wages
w =  (1/(1+beta))*(w(-1) + beta*w(+1) + sigma_wi* pi(-1)-(1+beta*sigma_wi)*pi + beta*pi(+1) 
  +  (((1-sigma_w)*(1-beta*sigma_w))/(sigma_w*(1+epsilon_w*phi)))
  *  (phi*l + (1/(1-h))*c - (h/(1-h))*c(-1) - w)) + eps_w ;

% 3 % Capital Accumulation
k =  (1-delta)*(k(-1)+eps_k) + I_K*i + I_K*ksi*eps_x ;

% 4 % Optimal Capital Utilization
u =  ((1-zeta)/zeta)* zk;

% 5 % Investment Euler Equation
i = (1/(1+beta))* (i(-1) + beta*i(+1) + (1/ksi)*(q+eps_x));

% 6 % Resource Constraint
y = C_Y*c + I_Y*i + G_Y*g + ZK*K_Y*u ;

% 7 % Production Function
y = Theta*(a + alpha*(k(-1) + eps_k + u) + (1-alpha)*l);    

% 8 % Firms FOC
zk=  w + l - k(-1) - u ;

% 9 % Phillips Curve: Prices
pi=  (1/(1+beta*sigma_pi)) * (sigma_pi*pi(-1) + beta*pi(+1) -((1-sigma_p)*(
1-beta*sigma_p)/sigma_p)*(a - alpha*zk-(1-alpha)*w)) + eps_p ; 

% 10 % Taylor Rule
rn= rho_r*rn(-1) +(1-rho_r)*(rho_pi*pi +rho_y *(y-yf))+rho_dy*(y-yf-(y(-1)-yf(-1)))+eps_r ;

% 11 % Fischer Equation
rn= r + pi(+1);

% 12 % Phillips Curve: Employment
%e = (1/(1+beta))*(e(-1) + beta*e(+1) - (1-sigma_e*beta)*(1-sigma_e)/sigma_e*(l-e)) 

% 13a % Price of capital
rk = (ZK/RK)*zk + (1-delta)/RK*(q+eps_k)- q(-1);

% 14a % External Finance Premium
ext_pr= kappa*(q + k - n); 

% 15a % Spread
rk(+1)= ext_pr +r; 

% 16a % Firms' Net Worth Accummulation
(1/(theta*RK))*n = K_N*rk - (K_N-1)*r(-1) - kappa*(K_N - 1)*(k(-1) + q(-1)) + ((K_N - 1)*kappa+1)*n(-1);  
%(1/(theta*RK))*n(+1) = K_N*rk - (K_N-1)*r(-1) - kappa*(K_N - 1)*(k(-1) + q(-1)) + ((K_N - 1)*kappa+1)*n;  


% Shocks
a     = rho_a *     a(-1) - e_a;     % Technology shock
g     = rho_g *     g(-1) - e_g;     % Government shock
eps_x = rho_x * eps_x(-1) - e_x;     % Investment shock
eps_r = rho_ri* eps_r(-1) + e_r;     % Montary shock
eps_p = rho_p * eps_p(-1) + e_p;     % Price mark-up shock
eps_w = rho_w * eps_w(-1) + e_w;     % Wage mark-up shock
eps_k = rho_k * eps_k(-1) - e_k;     % Capital quality shock



%%% Flexible Price Model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 9
alpha * zkf = a-(1-alpha)*wf ;
% 4
uf =  ((1-zeta)/zeta)* zkf  ;
% 8
zkf=  (wf)+lf-kf(-1)-uf ;
% 5
if = (1/(1+beta*1))* (if(-1) + beta*1*if(+1)+(1/(1^2*ksi))*(qf +eps_x))  ;
% 13a 
rkf = (ZK/RK)*zkf + (1-delta)/RK*(qf+eps_k)- qf(-1); 
% 14a
ext_prf= kappa*(qf + kf - nf); 
% 15a
rkf(+1)= ext_prf +rf; 
% 16a
(1/(theta*RK))*nf = K_N*rkf - (K_N-1)*rf(-1) - kappa*(K_N - 1)*(kf(-1) + qf(-1)) + ((K_N - 1)*kappa+1)*nf(-1);  
%(1/(theta*RK))*nf(+1) = K_N*rkf - (K_N-1)*rf(-1) - kappa*(K_N - 1)*(kf(-1) + qf(-1)) + ((K_N - 1)*kappa+1)*nf;  

% 1
cf = (1/(1+h))* cf(+1) +(h/(1+h))*cf(-1) - ((1-h)/(1+h))*rf ;

% 6
yf = C_Y*cf + I_Y*if + G_Y*g + ZK*K_Y*uf ;
% 7
yf = Theta*(a + alpha*(kf(-1)+eps_k + uf) +(1-alpha)*lf);  
% 2
wf = phi*lf	+ (1/(1-h))*cf - h/(1-h)*cf(-1) ;
% 3
kf = (1-delta)*(kf(-1)+eps_k) + I_K*if + I_K*ksi*eps_x ;
% 12
%ef = (1/(1+beta))*(ef(-1) + beta*ef(+1) - (1-sigma_e*beta)*(1-sigma_e)/sigma_e*(lf-ef)) 

end;

%%% Shocks %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shocks;
var e_a; stderr 1.0;       %0.42;
var e_k; stderr 1.0;       %0.25;
var e_g; stderr 1.0;       %2.23;
var e_x; stderr 1.0;       %1.04;
var e_r; stderr 1.0;       %0.13;
var e_p; stderr 1.0;       %0.12;
var e_w; stderr 1.0;       %0.29;
end;
varobs gdp_rgd_obs c_rgd_obs ifi_rgd hours_sw07_obs gdpdef_obs wage_rgd_obs ffr_obs;

estimated_params;

stderr e_a,   0.3974 ,0.01,25,INV_GAMMA_PDF,0.1,2;
stderr e_x,   1.0534 ,0.01,50,INV_GAMMA_PDF,0.1,2;
stderr e_r,   0.1224 ,0.01,25,INV_GAMMA_PDF,0.1,2;
stderr e_k,  0.1705 ,0.025,25,INV_GAMMA_PDF,0.1,2;
stderr e_g,   2.2030 ,0.01,50,INV_GAMMA_PDF,0.1,2;
stderr e_p, 0.1288 ,0.01,25,INV_GAMMA_PDF,0.1,2;
stderr e_w,    0.2806 ,0.01,25,INV_GAMMA_PDF,0.1,2;
%%%%%%%%%%%%%%%%%%%%%%%%%
rho_A,         0.9493 ,.01,.99999,BETA_PDF,0.5,0.20;
rho_k,        0.9802 ,.01,.99999,BETA_PDF,0.5,0.20;
rho_G,         0.9624 ,.01,.9999999,BETA_PDF,0.5,0.20;
rho_X,         0.9914 ,.01,.9999999,BETA_PDF,0.5,0.20;
rho_ri,        0.2154 ,-0.02,.9999,BETA_PDF,0.5,0.20;
rho_P,         0.2101 ,.01,.99999,BETA_PDF,0.5,0.20;
rho_W,         0.1907 ,.001,.9999,BETA_PDF,0.5,0.20;
ksi,      3.8293 ,0.0001,15,NORMAL_PDF,4,1.5;
h,             0.4279 ,0.1,0.99,BETA_PDF,0.7,0.1;
sig_w,       0.8453 ,0.25,0.99,BETA_PDF,0.75,0.05;
sig_p,        0.8953 ,0.5,0.97,BETA_PDF,0.75,0.05;
THETA,           1.3488 ,1.0,3,NORMAL_PDF,1.45,0.125;
phi,           1.6665 , 0.1, 3.5,gamma_pdf, 0.33,  0.25;
sig_wi,      0.3078 ,0.01,0.99,BETA_PDF,0.5,0.15;
sig_pi,      0.4257 ,0.01,0.99,BETA_PDF,0.5,0.15;
zeta,          0.8554 ,0.0001,1,BETA_PDF,0.25,0.15;
rho_PI,       1.8855 , 1.0,3,NORMAL_PDF,1.7,0.15;
rho_r,         0.8495 ,0.35,0.975,BETA_PDF,0.75,0.10;
rho_Y,        0.0743 ,-0.065 ,0.5,GAMMA_PDF,.125,0.05;
rho_DY,       0.2004 ,-0.1,0.5,NORMAL_PDF,0.0625,0.05;
%%%%%%%%%%%%%%%%%%%%%
picbar,       0.6473 ,0.1,2.0,GAMMA_PDF,0.625,0.1;
trend,       0.3029 ,0.001,0.8,NORMAL_PDF,0.4,0.10;

end;
 

% ////////////////////////////////////////////////////////////////////////
% 6. Simulation
% ////////////////////////////////////////////////////////////////////////
%stoch_simul(irf=21, nograph ) y i pi n ext_pr  ;                           % All shocks without a chart 
