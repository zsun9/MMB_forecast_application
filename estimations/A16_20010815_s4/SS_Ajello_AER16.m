function [cineq, ceq, stst] = SS_Ajello_AER16(x,params)

% Steady State file for baseline model in "Financial Intermediation, Investment Dynamics, and
% Business Cycle Fluctuations" by Andrea Ajello

% Code written by Andrea Ajello, 2015


gam_s        = params(1);
bet_s        = params(2);
delta        = params(3);
l_ss         = params(4);
nu           = params(5);
eta          = params(6);
gs_ss        = params(7);
pis          = params(8);
lambda_w     = params(9);
etau_q       = params(10);
lambda_p     = params(11);
h            = params(12);
sg_ss        = params(13);
mu           = params(14);
theta        = params(15);
fgs_param    = params(16);
Bs_ss        = params(17);

pi_ss    = pis/100;
gam      = gam_s/100;
beta     = 1/(bet_s/100 + 1);
tau_q_ss = etau_q/100;

c_ss     = x(1);
chi0     = x(2);
Q_t_A    = x(3);
D_t      = x(4);
phi_ss   = x(5);

sdfr     = log(beta/(exp(gam)));
sdf      = log(beta/(exp(gam)*exp(pi_ss)));
QK       = 0;


sg    = sg_ss;
mc_ss = log(1/(1+lambda_p));

Q_t_B = log(((exp(tau_q_ss)))*exp(Q_t_A));

lambda_t = log( 1/(exp(c_ss) - h*exp(c_ss)/exp(gam)) - h*beta/(exp(c_ss)*exp(gam) - h*exp(c_ss)));

Uh        = - chi0*(1/exp(lambda_t))*((exp(l_ss)))^(nu);
what_t    = log( -Uh * exp(lambda_w) );

z_t       = gam;
phi_t     = phi_ss;

rK     = log((exp(mc_ss)*((1-eta)^(1-eta) * eta^eta)/exp(what_t)^(eta))^ (1/(1-eta)));

Kbar   =  log(( exp(gam) * exp(l_ss) )*( exp(what_t)/exp(rK) * (1-eta)/eta ));

yhat      = log(((exp(Kbar)/exp(gam))^(1-eta)*exp(l_ss)^eta));

B_t       = log(Bs_ss*exp(yhat));

N_t       = Kbar;

chi_s     = log(1 - (1/2 + 1/2*erf((log(exp(QK)/exp(Q_t_A)) - mu)/(sqrt(2)*sg))));
chi_k     = log(1/2 + 1/2*erf((log(exp(QK)/exp(Q_t_A)) - mu)/(sqrt(2)*sg)) - (1/2 + 1/2*erf((log(exp(QK)/exp(Q_t_B)) - mu)/(sqrt(2)*sg))));
chi_w     = log(1/2 + 1/2*erf((log(exp(QK)/exp(Q_t_B)) - mu)/(sqrt(2)*sg)) - 0);


invQ_til_As  = log(  ( -( exp(QK)*theta*(-1)) + exp(mu + sg^2/2)*exp(Q_t_A)*(-1))/(2*exp(QK)*exp(Q_t_A)*(-1 + theta)) -... 
                       ( -( exp(QK)*theta* erf((mu - log(exp(QK)/exp(Q_t_A)))/(sqrt(2)*sg))) + exp(mu + sg^2/2)*exp(Q_t_A)*erf((mu + sg^2 - log(exp(QK)/exp(Q_t_A)) )/ (sqrt(2)*sg)))/(2*exp(QK)*exp(Q_t_A)*(-1 + theta)) ) ;

QtilS_iota_t =  log(exp(chi_s)/(exp(QK)*(1-theta)));

Ak_over_P    = log((exp(mu + 1/2 * sg^2)*(normcdf((mu + sg^2 - log(exp(QK)/exp(Q_t_B)))/sg) - normcdf((mu + sg^2 - log(exp(QK)/exp(Q_t_A)))/sg) ))/exp(QK));
QtilK_iota_t = chi_k;

i_t          = log(1/(exp(sdf) * (exp(invQ_til_As)*exp(Q_t_B) + exp(Ak_over_P)*exp(Q_t_B) + exp(chi_w))));

r_t          = i_t - pi_ss;
                                    
T_t          = log(-(exp(B_t) - (1 - 1/exp(gs_ss))*exp(yhat) - exp(r_t)*exp(B_t)/exp(z_t)));

AIK          = log( exp(Ak_over_P)  *...
                         (exp(rK)*exp(N_t)/exp(z_t) + exp(r_t)*exp(B_t)/exp(z_t) + exp(D_t) - exp(T_t)) );   
                     
AIS          = log( ( (exp(mu + sg^2/2)*(-1))/ (2*exp(QK)*(-1 + theta)) - (exp(mu + sg^2/2)*erf((mu + sg^2 - log(exp(QK)/exp(Q_t_A)))/(sqrt(2)*sg)))/ (2*exp(QK)*(-1 + theta)) ) *...
                    (exp(rK)*exp(N_t)/exp(z_t) + exp(r_t)*exp(B_t)/exp(z_t) + exp(D_t) - exp(T_t) + exp(phi_t)*exp(Q_t_A)*(1-delta)*exp(N_t)/exp(z_t)) );

AI           = log(exp(AIS) + exp(AIK));

iota_s       = log( exp(QtilS_iota_t) *...                     
                       (exp(rK)*exp(N_t)/exp(z_t) + exp(r_t)*exp(B_t)/exp(z_t) + exp(D_t) - exp(T_t) + exp(phi_t)*exp(Q_t_A)*(1-delta)*exp(N_t)/exp(z_t)));

iota_k       = log( exp(QtilK_iota_t)/exp(QK)  *...
                         (exp(rK)*exp(N_t)/exp(z_t) + exp(r_t)*exp(B_t)/exp(z_t) + exp(D_t) - exp(T_t)) );                     

iota_t       = log(exp(iota_s) + exp(iota_k));                     
                      
Ihat         = iota_t;

Delta_N      = log( theta*exp(QK)/exp(Q_t_A)*exp(iota_s) + exp(phi_t)*(1-delta)*exp(chi_s)*exp(N_t)/exp(z_t) );

FGS          = log(  (exp(Q_t_A)*exp(Delta_N) + (exp(chi_s)+exp(chi_k))*exp(r_t)*exp(B_t)/exp(z_t))   /   (exp(Ihat)) );

LIQShare = log( (exp(Q_t_A)*((exp(phi_t))*(1-delta) * exp(N_t)/exp(z_t)) + exp(r_t)*exp(B_t)/exp(z_t)) / (exp(Q_t_A)*((1-delta) * exp(N_t)/exp(z_t)) + exp(r_t)*exp(B_t)/exp(z_t)) );

CASHShare = log(( exp(r_t)*exp(B_t)/exp(z_t)) / (exp(Q_t_A)*((1-delta) * exp(N_t)/exp(z_t)) + exp(r_t)*exp(B_t)/exp(z_t)) );

LIQS_t     = (exp(Q_t_A)*((exp(phi_t))*(1-delta) * exp(chi_s) * exp(N_t)/exp(z_t)) + (exp(chi_s)+exp(chi_k))*exp(r_t)*exp(B_t)/exp(z_t))/((exp(FGS))*exp(Ihat));
CASH_t     = ((exp(chi_s)+exp(chi_k))*exp(r_t)*exp(B_t)/exp(z_t))/((exp(FGS))*exp(Ihat));

%% Inequality Constraints

cineq = [- exp(chi_s);exp(chi_s) - 1;- exp(chi_k);exp(chi_k) - 1;- exp(chi_w);exp(chi_w) - 1];

%% Equality Constraints

ceq   = [c_ss - log(exp(yhat)  - exp(Ihat) - (1 - 1/exp(gs_ss))*exp(yhat));
    
        exp(Q_t_B) - exp(sdfr) * (exp(Q_t_B) * (exp(invQ_til_As)) *...
                                                      (exp(rK) + exp(phi_t)*exp(Q_t_A)*(1-delta)) + exp(chi_s)*(1-exp(phi_t))*exp(Q_t_B)*(1-delta) +...
                          exp(Q_t_B) * (exp(Ak_over_P)) *...
                                                      (exp(rK))                                   + exp(chi_k)*exp(Q_t_B)*(1-delta) + ...
                          exp(chi_w) * (exp(rK) + exp(Q_t_B)*(1-delta) ) );

        N_t  -  log(exp(AI)/(1 - (1-delta)/exp(z_t)));

        D_t - log(exp(yhat) - exp(rK)*exp(N_t)/exp(z_t) - exp(what_t)*exp(l_ss) + (exp(Q_t_B) - exp(Q_t_A))*exp(Delta_N) );
        
        exp(FGS) - fgs_param];
 
mchat      = mc_ss;
pi_t       = pis/100;
chat       = x(1); 
Q_t_A      = x(3); 
chi_spk    = log(exp(chi_s) + exp(chi_k));
iota_t     = Ihat;
l          = l_ss;
r          = i_t - pis/100;
g_t        = gs_ss; 
S          = 0; 
Sprime     = 0;
GDP_t      = log(exp(chat) + exp(Ihat) + (1 - 1/exp(g_t))*exp(yhat)); 
gdpdef_obs    = pis; 
ffr_obs     = i_t*100;
hours_A16_obs     = l; 
pi_tm1     = pis/100;
pi_tm2     = pis/100;
pi_tm3     = pis/100;
eta_beta   = 0;
tau_q_t    = etau_q/100; 
lambda_p_t = lambda_p; 
lambda_w_t = lambda_w;
beta_t     = 1/(bet_s/100 + 1);
pistar     = pis/100;
AIS        = log(exp(AI) - exp(AIK));
fgs_obs    = FGS; 
FGS_num    = log( ( (exp(Q_t_A)*exp(Delta_N) + exp(chi_spk)*exp(r)*exp(B_t)/exp(z_t))  ) );
FGS        = (FGS_num - Ihat);
SMG        = 0;
SMGm1      = SMG;
SMGm2      = SMG;
SMGm3      = SMG;
SMG_bar    = SMG;
e_p        = 0;
e_w        = 0; 
cnds_nom_demean_obs     = 0;
i_A16_obs     = 0;
gdp_rgd_obs   = 0;
wage_rgd_demean_obs    = 0;
d_GDPm1    = 0;
d_GDPm2    = 0;
d_GDPm3    = 0;
Spread_t   = log(((exp(rK) + exp(Q_t_A)*(1-delta))* exp(pi_ss)/exp(Q_t_A)  )/ exp(i_t));
baag10_obs     = 100*Spread_t;
etau_q_t   = tau_q_t;
ygap_t           = yhat - yhat;                              
ToY_t            = log(exp(T_t)/exp(yhat));
BoY_t            = log((exp(B_t)/exp(yhat))/exp(gam));
A_eff            = log(exp(AI)/exp(iota_t));
d_FGS_num        = 0;
CASH_t           = log(CASH_t);
LIQS_t           = log(LIQS_t);
ctau_q_t         = 0;
FGSgap_t         = 0;
Spreadgap_t      = 0;

stst =  [AI             
AIK            
AIS            
A_eff          
Ak_over_P      
B_t            
BoY_t          
CASH_t         
D_t            
Delta_N        
FGS            
FGS_num     		
fgs_obs        
FGSgap_t       
GDP_t          
Ihat          	
Kbar           
LIQS_t         
N_t            
QK						
Q_t_A          
Q_t_B         	
QtilK_iota_t   
QtilS_iota_t   
S              
SMG     				
SMG_bar        
SMGm1          
SMGm2          
SMGm3          
baag10_obs    
Spread_t 				
Spreadgap_t    
Sprime         
T_t            
ToY_t          
beta_t         
chat           
chi_k          
chi_s          
chi_spk        
chi_w          
ctau_q_t       
d_FGS_num      
gdp_rgd_obs          
d_GDPm1        
d_GDPm2        
d_GDPm3        
i_A16_obs         
cnds_nom_demean_obs         
wage_rgd_demean_obs        
eta_beta       
etau_q_t   
e_p
e_w
g_t            
ffr_obs					
i_t            
invQ_til_As    
iota_k         
iota_s  				
iota_t         
l              
hours_A16_obs         
lambda_p_t     
lambda_t       
lambda_w_t     
mchat          
phi_t          
gdpdef_obs        
pi_t           
pi_tm1         
pi_tm2         
pi_tm3         
pistar         
r              
rK             
sdf            
sdfr
sg_ss
tau_q_t        
what_t					
ygap_t         
yhat           
z_t]';
          
    
end