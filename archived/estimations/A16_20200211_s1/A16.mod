% Model file for "Financial Intermediation, Investment Dynamics, and
% Business Cycle Fluctuations" by Andrea Ajello

% Code written by Andrea Ajello, 2015




%% Model Variables and Paramters Declaration

% Declare model variables

var     
AI                      % Integral of A_{i_t}x \iota_{i,t} for all i
AIK                     % Integral of A_{i_t}x \iota_{i,t} for keepers (i = k)
AIS                     % Integral of A_{i_t}x \iota_{i,t} for savers (i = s)  
A_eff                   % Effective investment technology A_{eff} (i = s)  
Ak_over_P               % Integral of A_{i_t} \ P_t^K for keepers (i = k)
B_t                     % Government bonds
BoY_t                   % Government bonds as fraction of GDP                
CASH_t                  % Cash share (as of Table 1)
D_t                     % Dividend payoffs (intermediate good producers)
Delta_N                 % Traded equity claims
FGS                     % Finangin Gap Share
FGS_num     			% Financing Gap (numerator of FGS)
fgs_obs        			% Finangin Gap Share plus Measurement Error
FGSgap_t                % FGS (model-consistennt HP filtered series)
GDP_t                   % GDP
Ihat          			% Investment
Kbar                    % Capital stock
LIQS_t                  % Liquidation Share (as of Table 1)
N_t                     % Equity stock 
QK						% Price of investment units (P_t^K)             
Q_t_A                   % Sale price of equity
Q_t_B         			% Purchase price of equity
QtilK_iota_t        	% Integrals of tech distribution for Euler eq. (keepers)
QtilS_iota_t            % Integrals of tech distribution for Euler eq. (sellers)
S                       % Investment Adjustment Cost Function
SMG     				% Stock market growth
SMG_bar                 % 4-quarter stock-market growth rate
SMGm1                   % Stock market growth (lag 1)
SMGm2                   % Stock market growth (lag 2)
SMGm3                   % Stock market growth (lag 3)
baag10_obs             % Spread plus measurement error
Spread_t 				% Spread
Spreadgap_t             % Spread (model-consistent HP-filtered series)
Sprime                  % Investment Adjustment Costs (first derivative)
T_t                     % Taxes  
ToY_t                   % Taxes as a fraction of GDP
beta_t                  % Time-varying discount factor
chat                    % Consumption
chi_k                   % Fraction of keepers
chi_s                   % Fraction of savers
chi_spk                 % Fraction of savers and keepers
chi_w                   % Fraction of buyers/workers
ctau_q_t                % Transitory financial intermediation shock
d_FGS_num               % Growth rate of financing gap
gdp_rgd_obs                  % Growth rate of real GDP
d_GDPm1                 % Growth rate of real GDP (lag 1)
d_GDPm2                 % Growth rate of real GDP (lag 2)
d_GDPm3                 % Growth rate of real GDP (lag 3)
i_A16_obs                  % Growth rate of real Investment
cnds_nom_demean_obs                  % Growth rate of real Consumption
wage_rgd_demean_obs                 % Growth rate of real wages
eta_beta                % Intertemporal preference shock    
etau_q_t                % Persistent financial intermediation shock
e_p                     % Price mark-up shock
e_w                     % Wage mark-up shock
g_t                     % Government spending
ffr_obs					% FFR observed   
i_t                     % FFR (Taylor rule)
invQ_til_As             % Integrals of tech distribution for Euler eq. 
iota_k                  % Investment goods demand (keepers)
iota_s  				% Investment goods demand (savers)
iota_t                  % Investment goods demand (total)
l                       % Hours worked
hours_A16_obs                  % Hours worked observed
lambda_p_t              % Price mark-up
lambda_t                % Marginal Utility of consumption
lambda_w_t              % Wage mark-up
mchat                   % Marginal cost
phi_t                   % Liquidity shock
gdpdef_obs                 % Inflation observed
pi_t                    % Inflation
pi_tm1                  % Inflation (lag 1)
pi_tm2                  % Inflation (lag 2)
pi_tm3                  % Inflation (lag 3)
pistar                  % Inflation target
r                       % Real rate           
rK                      % Rate of return on capital
sdf                     % Stochastic discount factor (nominal)
sdfr                    % Stochastic discount factor (real)
sg                      % Investment technology dispersion
tau_q_t                 % Financial intermediation wedge
what_t					% Real wage            
ygap_t                  % Output Gap (model-consistent HP-filtered series)
yhat                    % output  = GDP
z_t;                    % TFP growth 


varexo  eps_z  eps_g  eps_i  eps_tau eps_tau_trans eps_phi eps_beta  eps_p  eps_w  eps_meas  eps_meas_sp ;

% Declare model parameters

parameters

gam_s       
bet_s       
delta       
nu          
h           
l_ss        
eta         
lambda_p    
xi_p        
iota_p      
lambda_w    
xi_w        
iota_w      
mu_ss          
sg_ss          
fgs_param   
theta       
Bs_ss       
gs_ss       
etau_q_ss   
theta_I     
pis         
rho_i       
phi_pi      
phi_DY      
phi_Ygap    
tB %\varphi_B in paper notation         
rho_z       
rho_g       
rho_tau     
decay       
rho_beta    
rho_p       
rho_w       
theta_p     
theta_w     
s_z         
s_g         
s_i         
s_tau       
s_tau_trans 
s_phi
s_sg
s_beta      
s_p         
s_w         
s_meas_sp   
s_meas
rho_phi
s_phi;

% Calibrate model parameters (order and numbers correspond to Table 2 in the paper)

gam_s        =  0.50;
bet_s        =  0.632;
delta        =  0.0250;
nu           =  2.38;
h            =  0.843;
l_ss         =     0;
eta          =  0.748;
lambda_p     =  0.15;
xi_p         =  0.813;
iota_p       =  0.203;
lambda_w     =  0.15;
xi_w         =  0.927;
iota_w       =  0.431;
mu_ss        =     0;
sg_ss        =  0.0147;
fgs_param    =  0.35;
theta        =  0.677;
Bs_ss        =  0.02;
gs_ss        =  0.17;
etau_q_ss    =  3.52;
theta_I      =  0.755;
pis          =  0.312;
rho_i        =  0.828;
phi_pi       =  0.46;
phi_DY       =  0.156;
phi_Ygap     =  0;
tB           =  0.236;
rho_z        =  0.379;
rho_g        =  0.996;
rho_tau      =  0.986;
decay        =  0.771;
rho_beta     =  0.487;
rho_p        =  0.707;
rho_w        =  0.159;
theta_p      =  0.194;
theta_w      =  0.148;
s_z          =  0.601;
s_g          =  0.153;
s_i          =  0.121;
s_tau        =  0.143;
s_tau_trans  =  0.154;
s_phi        =  0;
s_sg         =  0;
s_beta       =  2.37;
s_p          =  0.069;
s_w          =  0.308;
s_meas_sp    =  0.025;
s_meas       =  0.148;


% Parameters not used in the baseline version of the model. 
% These paramters play no role in the solution/simulation of the baseline model.
% They govern persistence and volatility of shocks to the degree of
% liquidity of financial assets, phi. These parameters can be modified to
% replicate liquidity shock simulations contained in the online appendix.

rho_phi      =  0.6250;
s_phi        =  0;

%% Store a sensible SS initial condition to be used during model estimation.

% Subset of parameters used to compute the SS of the model:



par_ss(1)   = gam_s;
par_ss(2)   = bet_s;
par_ss(3)   = delta;
par_ss(4)   = l_ss;
par_ss(5)   = nu;
par_ss(6)   = eta;
par_ss(7)   = gs_ss;
par_ss(8)   = pis;
par_ss(9)   = lambda_w;
par_ss(10)  = etau_q_ss;
par_ss(11)  = lambda_p;
par_ss(12)  = h;
par_ss(13)  = sg_ss;
par_ss(14)  = mu_ss;
par_ss(15)  = theta;
par_ss(16)  = fgs_param;
par_ss(17)  = Bs_ss;

% Initial condition for Steady State (SS):

x0=[  0.1971    0.8754   -0.0270   -1.4289   -6.0463 ];

% Find SS for calibrated paramters and store it:

options = optimset('MaxIter',10^6,'MaxFunEvals', 10^6,'Algorithm','interior-point','TolFun',10^-4,'TolX',10^-20,'TolCon',10^-6); % use if using fmincon

[x,fval,exitflag] = fmincon(@(x) obj_dummy(x,par_ss),x0,[],[],[],[],[],[],@(x) SS_Ajello_AER16(x,par_ss),options);

[~, ~, stst] = SS_Ajello_AER16(x,par_ss);

for ie = 1:1
    
    x0 = x;
    filename = [ 'x_init' num2str(ie) '.mat' ];
    save(filename,'x0');
    
end

%% Model Equilibrium Conditions

model;
#pi_ss    = pis/100;
#gam      = gam_s/100;
#bet      = 1/(bet_s/100 + 1);
#tau_q_ss = etau_q_ss/100;
#kp       = (1-xi_p*bet)*(1-xi_p)/(xi_p*(1+iota_p*bet));
#chi0     = exp(steady_state(what_t))/(exp(lambda_w))/((1/exp(steady_state(lambda_t)))*((exp(steady_state(l))))^(nu));
#phi_ss    = steady_state(phi_t);
#rho_tau_trans = rho_tau*decay;

// Household

beta_t - bet*exp(eta_beta);
(lambda_t - steady_state(lambda_t)) - ( exp(gam)/(exp(gam) - h*bet) * ( (z_t - gam) - exp(gam)/(exp(gam) - h) * ((chat - steady_state(chat)) + (z_t - gam)) + h/(exp(gam) - h) * (chat(-1) - steady_state(chat)) ) + h*bet/(exp(gam) - h*bet) * ( exp(gam)/(exp(gam)-h) * ((chat(1) - steady_state(chat)) +  (z_t(1) - gam)) - h/(exp(gam)-h) * (chat - steady_state(chat))) + ((exp(gam) - h*bet*rho_beta)/(exp(gam) - h*bet))*eta_beta );
(sdfr - steady_state(sdfr)) - ( (lambda_t - steady_state(lambda_t)) - (lambda_t(-1) - steady_state(lambda_t)) - (z_t - gam) );
(sdf - steady_state(sdf))   - ( (lambda_t - steady_state(lambda_t)) - (lambda_t(-1) - steady_state(lambda_t)) - (z_t - gam) - (pi_t - pi_ss));

exp(Q_t_B) - exp(sdfr(1)) * ( exp(Q_t_B(+1)) * (exp(invQ_til_As(+1))) *
                        (exp(rK(1)) + exp(phi_t(1))*exp(Q_t_A(1))*(1-delta)) + exp(chi_s(1))*(1-exp(phi_t(1)))*exp(Q_t_B(1))*(1-delta) +
                              exp(Q_t_B(+1)) * (exp(Ak_over_P(+1))) * 
                        (exp(rK(1))) + exp(chi_k(1))*exp(Q_t_B(1))*(1-delta) + 
                           exp(chi_w(1)) * (exp(rK(1)) + exp(Q_t_B(1))*(1-delta) ) );                           
                                         
1/exp(r) -   exp(sdfr(1)) *  ( exp(invQ_til_As(1))*exp(Q_t_B(+1)) + exp(Ak_over_P(1))*exp(Q_t_B(+1)) + exp(chi_w(1))  );
1/exp(i_t) - exp(sdf(1)) *   ( exp(invQ_til_As(1))*exp(Q_t_B(+1)) + exp(Ak_over_P(1))*exp(Q_t_B(+1)) + exp(chi_w(1))  );

// Bank 13 - 

exp(Q_t_B) - exp(Q_t_A)*(exp(tau_q_t));

// Savers and Keepers


exp(chi_w)   - (1/2 + 1/2*erf((log(exp(QK)/exp(Q_t_B)) - mu_ss)/(sqrt(2)*sg)) - 0);
exp(chi_spk) - (exp(chi_s) + exp(chi_k));
exp(chi_s)        - (1 - (1/2 + 1/2*erf((log(exp(QK)/exp(Q_t_A)) - mu_ss)/(sqrt(2)*sg))));
exp(invQ_til_As)  - (  ( -( exp(QK)*theta* (-1)) + exp(mu_ss + sg^2/2)*exp(Q_t_A)*(-1))/(2*exp(QK)*exp(Q_t_A)*(-1 + theta)) - 
                       ( -( exp(QK)*theta* erf((mu_ss - log(exp(QK)/exp(Q_t_A)))/(sqrt(2)*sg))) + exp(mu_ss + sg^2/2)*exp(Q_t_A)*erf((mu_ss + sg^2 - log(exp(QK)/exp(Q_t_A)) )/ (sqrt(2)*sg)))/(2*exp(QK)*exp(Q_t_A)*(-1 + theta)) ) ;
exp(QtilS_iota_t) -  exp(chi_s)/(exp(QK)*(1-theta));
exp(AIS)         -  ( (exp(mu_ss + sg^2/2)*(-1))/ (2*exp(QK)*(-1 + theta)) - (exp(mu_ss + sg^2/2)*erf((mu_ss + sg^2 - log(exp(QK)/exp(Q_t_A)))/(sqrt(2)*sg)))/ (2*exp(QK)*(-1 + theta)) ) *
                    (exp(rK)*exp(N_t(-1))/exp(z_t) + exp(r(-1))*exp(B_t(-1))/exp(z_t) + exp(D_t) - exp(T_t) + exp(phi_t)*exp(Q_t_A)*(1-delta)*exp(N_t(-1))/exp(z_t)) ;
exp(iota_s)       - exp(QtilS_iota_t) *                     
                          (exp(rK)*exp(N_t(-1))/exp(z_t) + exp(r(-1))*exp(B_t(-1))/exp(z_t) + exp(D_t) - exp(T_t) + exp(phi_t)*exp(Q_t_A)*(1-delta)*exp(N_t(-1))/exp(z_t));
                    
exp(chi_k)       - (1/2 + 1/2*erf((log(exp(QK)/exp(Q_t_A)) - mu_ss)/(sqrt(2)*sg)) - (1/2 + 1/2*erf((log(exp(QK)/exp(Q_t_B)) - mu_ss)/(sqrt(2)*sg))));
exp(Ak_over_P)   - ((exp(mu_ss + 1/2 * sg^2)*(normcdf((mu_ss + sg^2 - log(exp(QK)/exp(Q_t_B)))/sg) - normcdf((mu_ss + sg^2 - log(exp(QK)/exp(Q_t_A)))/sg) ))/exp(QK));
exp(QtilK_iota_t) - exp(chi_k)/exp(QK);
exp(AIK)          - ( exp(Ak_over_P) * (exp(rK)*exp(N_t(-1))/exp(z_t) + exp(r(-1))*exp(B_t(-1))/exp(z_t) + exp(D_t) - exp(T_t)) ) ; 
exp(iota_k)       - exp(QtilK_iota_t)  *
                         (exp(rK)*exp(N_t(-1))/exp(z_t) + exp(r(-1))*exp(B_t(-1))/exp(z_t) + exp(D_t) - exp(T_t));

exp(AI) - exp(AIK) - exp(AIS);

exp(iota_t) - (exp(QtilS_iota_t) *                     
                         ( exp(rK)*exp(N_t(-1))/exp(z_t) + exp(r(-1))*exp(B_t(-1))/exp(z_t) + exp(D_t) - exp(T_t) + exp(phi_t)*exp(Q_t_A)*(1-delta)*exp(N_t(-1))/exp(z_t)) +
               exp(QtilK_iota_t)  *
                         ( exp(rK)*exp(N_t(-1))/exp(z_t) + exp(r(-1))*exp(B_t(-1))/exp(z_t) + exp(D_t) - exp(T_t)) );    

exp(N_t) - ( exp(AI) + (1-delta)*exp(N_t(-1))/exp(z_t) );

exp(Delta_N) - ( theta*exp(QK)/exp(Q_t_A)*exp(iota_s) + exp(phi_t)*(1-delta)*exp(chi_s)*exp(N_t(-1))/exp(z_t));

exp(N_t) - exp(Kbar);

exp(A_eff) - (exp(AI)/exp(iota_t));

// Capital Producers

S - ( 0.5*theta_I*(exp(Ihat)/exp(Ihat(-1))*exp(z_t)-exp(gam))^2 );

Sprime - ( theta_I*(exp(Ihat)/exp(Ihat(-1))*exp(z_t)-exp(gam)));

exp(QK) - ( ( 1 - exp(sdfr(1))*exp(QK(1))*Sprime(1)*(exp(Ihat(1))/exp(Ihat)*exp(z_t(1)))^2)/((1-(Sprime*(exp(Ihat)/exp(Ihat(-1))*exp(z_t))+S))) );

exp(iota_t) - (1 - S)*exp(Ihat);

// Government and Central Bank

exp(ToY_t) = exp(T_t)/exp(yhat);
exp(BoY_t) = exp(B_t(-1))/exp(yhat) / exp(z_t);

exp(ToY_t)/exp(steady_state(ToY_t)) = ((exp(BoY_t)/(exp(steady_state(BoY_t))))^(tB));

(1 - 1/exp(g_t))*exp(yhat) + exp(r(-1))*exp(B_t(-1))/exp(z_t) - exp(T_t) - exp(B_t);

i_t - (rho_i*i_t(-1) + (1-rho_i)*((steady_state(r) + (pi_t + pi_t(-1)+pi_t(-2)+pi_t(-3))/4) + phi_pi*((pi_t + pi_t(-1)+pi_t(-2)+pi_t(-3))/4 - pistar) + phi_Ygap*(ygap_t) + phi_DY*(gdp_rgd_obs + gdp_rgd_obs(-1) + gdp_rgd_obs(-2) + gdp_rgd_obs(-3))/400) + eps_i/100);

(ygap_t+1600*(ygap_t(+2) - 4*ygap_t(+1) + 6*ygap_t - 4*ygap_t(-1) + ygap_t(-2))) = 1600*(yhat(+2) - 4*yhat(+1) + 6*yhat - 4*yhat(-1) + yhat(-2));

// Firms

exp(D_t) - ( exp(yhat) - exp(rK)*exp(N_t(-1))/exp(z_t) - exp(what_t)*exp(l) + (exp(QK)*(1-S)*exp(Ihat) - exp(Ihat)) + (exp(Q_t_B) - exp(Q_t_A) )*exp(Delta_N)  );

exp(mchat) - ( 1/((1-eta)^(1-eta) * eta^eta) * exp(rK)^(1-eta) * exp(what_t)^(eta) );

exp(Kbar(-1))/( exp(z_t) * exp(l) ) - ( exp(what_t)/exp(rK) * (1-eta)/eta );

(pi_t - pi_ss) - (bet/(1+iota_p*bet) * (pi_t(1) - pi_ss)
               + iota_p/(1+iota_p*bet)*(pi_t(-1) - pi_ss)
               + kp*(mchat - steady_state(mchat))
               + (lambda_p_t - lambda_p));

exp(yhat)  - ((exp(Kbar(-1))/exp(z_t))^(1-eta)*exp(l)^eta);
exp(yhat)  - (exp(chat) + exp(Ihat) + (1 - 1/exp(g_t))*exp(yhat)  );

// Wage block

% If you want to assume that wages are sticky, then use:
(what_t - steady_state(what_t)) - ( (1/(1+bet))*(what_t(-1) - steady_state(what_t))
      + (bet/(1+bet))*(what_t(1) - steady_state(what_t))
      + ((iota_w)/(1+bet)) * ( (pi_t(-1) - pi_ss)  + (z_t(-1) - gam) )
      - ((bet*iota_w + 1)/(1+bet)) * ( (pi_t - pi_ss)  + (z_t - gam) )
      + (bet/(1+bet)) * ( (pi_t(1) - pi_ss)  + (z_t(1) - gam) ) 
      + ((1-xi_w*bet)*(1-xi_w)/(1+bet)) * (eta_beta - (lambda_t - steady_state(lambda_t)) + nu*(l - l_ss) - (what_t - steady_state(what_t))) + (lambda_w_t - lambda_w) );  

% If you want to assume that wages are flexible (as in online appendix K), then use:
% exp(what_t)  -  chi0*(1/exp(lambda_t))*((exp(l)))^(nu) * exp(lambda_w_t);      

// Definitions

exp(GDP_t) - (exp(chat) + exp(Ihat) + (1 - 1/exp(g_t))*exp(yhat));
pistar - pi_ss;

// Exogenous processes

z_t         - ( (1-rho_z)*gam + rho_z*z_t(-1) + eps_z/100);
etau_q_t    - ( (1-rho_tau)*tau_q_ss + rho_tau*etau_q_t(-1) + eps_tau/100 );
ctau_q_t    - (  rho_tau_trans*ctau_q_t(-1) + eps_tau_trans/100);
tau_q_t     - (  etau_q_t + ctau_q_t  );
g_t         - ( (1-rho_g)*gs_ss  + rho_g*g_t(-1) + eps_g/100);
eta_beta    - ( rho_beta*eta_beta(-1) + eps_beta/100 );
lambda_p_t  - ( (1-rho_p)*lambda_p + rho_p*lambda_p_t(-1) + eps_p/100 + theta_p*e_p(-1)/100);
lambda_w_t  - ( (1-rho_w)*lambda_w + rho_w*lambda_w_t(-1) + eps_w/100 + theta_w*e_w(-1)/100);

% Liquidity shock (as described in online appendix D)
phi_t       - ( (1-rho_phi)*phi_ss + rho_phi*phi_t(-1) + eps_phi);

e_p          - eps_p;
e_w          - eps_w;


% Constant dispersion of investment technology distribution:
sg           - sg_ss;
% You can substitute the previous equation with the following: 
% log(sg)     - (1-rho_sg)*log(sg_ss) - rho_sg*log(sg(-1)) - eps_sg;
% to add a risk shock to the dispersion of investment technology distribution.

// Observation equations

(cnds_nom_demean_obs)      -     100*(chat - chat(-1) + z_t - gam);
(i_A16_obs)      -     100*(Ihat - Ihat(-1) + z_t - gam);
(gdp_rgd_obs)       -     100*(GDP_t - GDP_t(-1) + z_t - gam);
(wage_rgd_demean_obs)     -     100*(what_t - what_t(-1) + z_t - gam);
gdpdef_obs       -     100*pi_t;
ffr_obs        -     100*i_t;
hours_A16_obs        -     100*l;
fgs_obs       -     ((FGS) + eps_meas);
(4*baag10_obs)   -     (400*(Spread_t)) - eps_meas_sp;

(FGSgap_t+1600*(FGSgap_t(+2) - 4*FGSgap_t(+1) + 6*FGSgap_t - 4*FGSgap_t(-1) + FGSgap_t(-2))) = 1600*(fgs_obs(+2) - 4*fgs_obs(+1) + 6*fgs_obs - 4*fgs_obs(-1) + fgs_obs(-2));

// Auxiliary variables

exp(Spread_t) -  (((exp(rK(1)) + exp(Q_t_A(1))*(1-delta))*exp(pi_t(1))/exp(Q_t_A))/exp(i_t));

exp(FGS)      - ( (exp(Q_t_A)*exp(Delta_N) + exp(chi_spk)*exp(r(-1))*exp(B_t(-1))/exp(z_t))   /   (exp(Ihat)) );

exp(FGS_num)  - ( (exp(Q_t_A)*exp(Delta_N) + exp(chi_spk)*exp(r(-1))*exp(B_t(-1))/exp(z_t))  );

d_FGS_num     -     100*(FGS_num - FGS_num(-1) + z_t - gam);

(Spreadgap_t+1600*(Spreadgap_t(+2) - 4*Spreadgap_t(+1) + 6*Spreadgap_t - 4*Spreadgap_t(-1) + Spreadgap_t(-2))) = 1600*4*(baag10_obs(+2) - 4*baag10_obs(+1) + 6*baag10_obs - 4*baag10_obs(-1) + baag10_obs(-2));

d_GDPm1       - gdp_rgd_obs(-1);
d_GDPm2       - d_GDPm1(-1);
d_GDPm3       - d_GDPm2(-1);
pi_tm1        - pi_t(-1);
pi_tm2        - pi_tm1(-1);
pi_tm3        - pi_tm2(-1);

SMG     - ( 100*(log(exp(Q_t_B)*exp(N_t)) - log((exp(Q_t_B(-1))*exp(N_t(-1)))) + z_t - gam));
SMGm1   - SMG(-1);
SMGm2   - SMGm1(-1);
SMGm3   - SMGm2(-1);
SMG_bar - (SMG + SMGm1 + SMGm2 + SMGm3)/4;

exp(LIQS_t)  - (exp(Q_t_A)*((exp(phi_t))*(1-delta) * exp(chi_s) * exp(N_t(-1))/exp(z_t)) + (exp(chi_s)+exp(chi_k))*exp(r(-1))*exp(B_t(-1))/exp(z_t))/((exp(FGS))*exp(Ihat));
exp(CASH_t)  - ((exp(chi_s)+exp(chi_k))*exp(r(-1))*exp(B_t(-1))/exp(z_t))/((exp(FGS))*exp(Ihat));

end;

% Assign values to shock variances

shocks;
var eps_z          = s_z^2;
var eps_g          = s_g^2;
var eps_i          = s_i^2;
var eps_tau        = s_tau^2;
var eps_tau_trans  = s_tau_trans^2;
var eps_beta       = s_beta^2;
var eps_p          = s_p^2;
var eps_w          = s_w^2;
var eps_phi        = s_phi^2;
%var eps_sg         = s_sg^2;
end;

set_dynare_seed(cputime);

% Declare model observables

varobs gdp_rgd_obs i_A16_obs cnds_nom_demean_obs wage_rgd_demean_obs gdpdef_obs ffr_obs hours_A16_obs baag10_obs fgs_obs;

% Declare estimation parameters, starting values, bounds, and priors shapes.

estimated_params ;
stderr eps_z,                0.6142     , ,  , inv_gamma2_pdf,  0.50,    1;  
stderr eps_g,                0.1518     , ,  , inv_gamma2_pdf,  0.50,    1;  
stderr eps_i,                0.4441     , ,  , inv_gamma2_pdf,  0.10,    1;  
stderr eps_tau,              0.2274     , ,  , inv_gamma2_pdf,  0.50,    1;  
stderr eps_tau_trans,        0.2491     , ,  , inv_gamma2_pdf,  0.50,    1;  
stderr eps_beta,             1.1614     , ,  , inv_gamma2_pdf,  0.50,    1;  
stderr eps_p,                0.0641     , ,  , inv_gamma2_pdf,  0.10,    1;  
stderr eps_w,                0.2961     , ,  , inv_gamma2_pdf,  0.10,    1;  
stderr eps_meas,             0.1        , ,  , inv_gamma2_pdf,  0.05, 0.05;      
stderr eps_meas_sp,          0.0300     , ,  , inv_gamma2_pdf,  0.05, 0.05; 
bet_s       ,   		     0.7549  	,  ,  , gamma_pdf     ,  0.75, 0.05;        
nu          ,  			     1.8823     ,  ,  , gamma_pdf     ,     2, 0.75;      
h           , 			     0.7355     , , , beta_pdf      ,  0.50, 0.20;      
eta         , 			     0.7296  	, , , beta_pdf      ,  0.60, 0.10;        
xi_p        , 			     0.8829     , , , beta_pdf      ,  0.75, 0.15;      
iota_p      , 			     0.0965     , , , beta_pdf      ,  0.50, 0.15;      
xi_w        , 			     0.8940     , , , beta_pdf      ,  0.75, 0.15;      
iota_w      , 			     0.4723     , , , beta_pdf      ,  0.50, 0.15;  
%sg_ss       ,                0.0147       , 0.0131, 0.017, gamma_pdf     ,  0.40, 0.20; 
theta       ,                0.5        , , , beta_pdf      ,  0.75, 0.05;
%etau_q_ss   , 			     2          , 0,  , gamma_pdf     ,     2, 0.40;         
theta_I     ,   		     1.4534     , ,  , gamma_pdf     ,     4, 2;            
pis         ,                0.5893  	,  ,  , gamma_pdf     ,  0.50, 0.10;  
rho_i       , 			     0.9525     , , , beta_pdf      ,  0.85, 0.10;      
phi_pi      ,  			     0.5689     , ,  , normal_pdf    ,  0.70, 0.05;         
phi_DY      , 		         0.1152     ,  ,  , normal_pdf    , 0.125, 0.05;     
tB          ,  		         0.3	    , ,  , gamma_pdf     ,  0.50, 0.20;            
rho_z       , 			     0.3156     , , , beta_pdf      ,  0.50, 0.20;         
rho_g       , 			     0.9897     , , ,beta_pdf      ,  0.50, 0.20;         
rho_beta    , 			     0.6212     , , , beta_pdf      ,  0.50, 0.20;      
rho_tau     , 			     0.95       ,  ,  , beta_pdf      ,  0.50, 0.20;  
decay       ,                0.60       , ,  , beta_pdf      ,  0.50, 0.20;   
rho_p       , 			     0.6182     , , , beta_pdf      ,  0.50, 0.20;      
rho_w       , 			     0.1874     , , , beta_pdf      ,  0.50, 0.20;      
theta_p     , 			     0.2155     , , , beta_pdf      ,  0.50, 0.20;      
theta_w     , 			     0.1161     , , , beta_pdf      ,  0.50, 0.20;      
end;

% Initial condition for minimizer:

estimated_params_init;
bet_s        ,  0.6529;
nu           ,  2.27;
h            ,  0.84;
eta          ,  0.75;
xi_p         ,  0.80;
iota_p       ,  0.21;
xi_w         ,  0.92;
iota_w       ,  0.43;
%sg_ss        ,  0.0147;
theta        ,  0.68;
%etau_q_ss    ,  3.1;
theta_I      ,  0.81;
pis          ,  0.34;
rho_i        ,  0.83;
phi_pi       ,  0.41;
phi_DY       ,  0.16;
tB           ,  0.235;
rho_z        ,  0.37;
rho_g        ,  0.99;
rho_beta     ,  0.483;
rho_tau      ,  0.986;
decay        ,  0.784;
rho_p        ,  0.737;
rho_w        ,  0.15;
theta_p      ,  0.172;
theta_w      ,  0.13;
stderr eps_z ,  0.29;
stderr eps_g ,  0.45;
stderr eps_i ,  0.02;
stderr eps_tau, 0.32;
stderr eps_tau_trans, 0.34;
stderr eps_beta,4.40;
stderr eps_p ,  0.16;
stderr eps_w ,  0.22;
stderr eps_meas_sp,  0.023;
stderr eps_meas,  0.154;
end;

% Add prior on standard deviation of FGS observable:
% options_.endogenous_prior = 1;



   // estimation(lik_init=1,
   // datafile = data_20151110,xls_sheet=Sheet1, xls_range=B1:J79, first_obs = 1, order = 1,  
// plot_priors  = 0, mode_compute = 7,
  //  irf = 30, bayesian_irf, mh_replic =100000, mh_nblocks = 1,
   // mh_drop = .3, mh_jscale = .30, forecast=5)gdp_rgd_obs ;
    



estimation(nodisplay, smoother, order=1, prefilter=0, qz_zero_threshold = 1e-32, datafile=data_20200211, xls_sheet=s1, xls_range=B1:BD100, presample=4, mh_replic=100000, mh_nblocks=1, mh_jscale=0.3, mh_drop=0.3, sub_draws=5000, forecast=40, mode_compute=6) gdp_rgd_obs;