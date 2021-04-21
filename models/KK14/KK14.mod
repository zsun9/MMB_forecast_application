// Endogenous variables 
var  MUL,  MRS,  chi,   w,  q, y, inf_p, mc, u,
    I, c, lp,  rk, R,  k, tax,  b, tau_w, tau_k, z_P, z_L, GDP,
     cg,  eps_i, eps_z, eps_q, tr, gdp_rgd_obs, c_rgpc_obs, i_rgpc_obs, tr_obs, taxrev_rgpc_obs, govdebt_rcpc_obs, gexp_rgpc_obs, l_obs, w_obs;
   

varexo e_i, e_z, e_q, eps_m, eps_cg, eps_tr, eps_tauk, eps_tauw, e_P, e_L,eps_y; 

//PARAMETERS 
parameters nbeta, nalpha, sigma_l, sigma_c,  theta_w, theta_p, gamma_w, gamma_p, delta, nu,  h, sigma_u,
            rho_R, rho_pi, rho_y,  rho_cg,  rho_eps_i ,rho_eps_z,rho_eps_q, rho_w, rho_k, rho_tr,
            tr_o_y, cgy,  tau_k_SS, tau_w_SS, R_SS, l_SS, rho_P, xi_w, xi_p, rho_L,
            etaWk, etaWb, etaWy, etaWc, etaWh,  etaWw, etaWI, etaWpi,etaWR,
            etaKk, etaKb, etaKy, etaKc, etaKh,  etaKw, etaKI, etaKpi,etaKR;
            
  

//deep model parameter and implied SS
  
tau_k_SS=0.1929;   // average trend of our data to our data 
tau_w_SS=0.2088;   // average trend of our data to our data 
R_SS=1.013;       // average trend of our data 
cgy=0.085;          // to match ca. b/4Y =0.50
tr_o_y=0.105;       //  data 0.11 
l_SS=1/3;
nbeta=0.9935;       // to match average trend of inflation in our data 
nalpha=0.36;      
delta=0.025;  


          
// other Deep Model Parameter
 
sigma_c=1.5; 
h=0.7;      
sigma_l=2; 
sigma_u=2;  
nu=5;   

// Calvo Pricing and Wages

gamma_p=0.7;
theta_p=6;
gamma_w=0.7;
theta_w=11;

xi_w=0;
xi_p=0;

// Parameter Taylor Rule
rho_R=0.8;   
rho_pi= 2.1; 
rho_y= 0.125  ;  

// AR(1) Parameter
rho_cg=0.85;   
rho_tr= 0.85;  
rho_eps_i= 0.85;
rho_eps_z= 0.85;
rho_eps_q=0.85 ;
rho_L=0;
rho_P=0;

// Fiscal feedback Rules

rho_w=0.7535; 
etaWk=0; 
etaWb=0.2; 
etaWy=0; 
etaWc=0; 
etaWh=0; 
etaWw=0; 
etaWI=0; 
etaWpi=0; 
etaWR=0; 


rho_k=0.9029;    
etaKk=0;  
etaKb=0.2;  
etaKy=0; 
etaKc=0; 
etaKh=0; 
etaKw=0; 
etaKI=0; 
etaKpi=0; 
etaKR=0; 





model(linear); 

#inf_p_SS=R_SS*nbeta;
#mc_SS=(theta_p-1)/theta_p;
#rk_SS=(1-nbeta*(1-delta))/(1-tau_k_SS)/nbeta;
#w_SS=mc_SS^(1/(1-nalpha))*(1-nalpha)*nalpha^(nalpha/(1-nalpha))*rk_SS^(-nalpha/(1-nalpha));
#lk_bar=(1-nalpha)/nalpha*rk_SS/w_SS;
#ckbar=(1-cgy)*(mc_SS*lk_bar^(1-nalpha))-delta;
#psi_l=(w_SS^(1)*(theta_w-1)/theta_w *(1-h)^(-sigma_c)*(1-tau_w_SS)*(1-nbeta*h) *ckbar^(-sigma_c)*lk_bar^(sigma_c))/l_SS^(sigma_c+sigma_l);
#lp_SS=l_SS;
#k_SS=lp_SS/lk_bar;
#FC= (1-mc_SS)*(k_SS)^nalpha*lp_SS^(1-nalpha);
#y_SS=k_SS^nalpha*lp_SS^(1-nalpha)-FC;
#c_SS=ckbar*k_SS;
#I_SS=delta*k_SS;
#cg_SS=y_SS-c_SS-I_SS;
#tax_SS=tau_w_SS*w_SS*lp_SS+tau_k_SS*(rk_SS*k_SS+y_SS-rk_SS*k_SS-w_SS*lp_SS);
#tr_SS=tr_o_y*y_SS;
#b_SS=1/(1-1/nbeta)*(tr_SS+cg_SS-tax_SS);

// Household

(1-nbeta*h)*chi=eps_q-sigma_c/(1-h)*(c-h*c(-1))-h*nbeta*eps_q(+1)+h*nbeta*sigma_c/(1-h)*(c(+1)-h*c);
0=chi(+1)-chi+R-inf_p(+1);
MRS=MUL-chi;
MUL=z_L+sigma_l*lp;
chi+q=chi(+1)+nbeta*((1-tau_k_SS)*rk_SS*rk(+1)-tau_k_SS*rk_SS*tau_k(+1)+(1-delta)*q(+1));
k=(1-delta)*k(-1)+delta*I+delta*eps_i;
I=I(-1)/(1+nbeta)+nbeta/(1+nbeta)*I(+1)+ q/nu/(1+nbeta)+eps_i/nu/(1+nbeta);
//k=(1-delta)*k(-1)+delta*I;
//I=I(-1)/(1+nbeta)+nbeta/(1+nbeta)*I(+1)+ q/nu/(1+nbeta)+ nbeta/(1+nbeta)*eps_i(+1)- eps_i/(1+nbeta);


sigma_u*u=rk-tau_k_SS/(1-tau_k_SS)*tau_k;
//sigma_u*u=rk;

// Staggered Prices & Wages 

(1+nbeta)*w-nbeta*w(+1)-nbeta*inf_p(+1)-xi_w*inf_p(-1)=w(-1)-(1+nbeta*xi_w)*inf_p+(1-gamma_w)*(1-gamma_w*nbeta)/gamma_w/(1+theta_w*sigma_l)*(MRS-w+ tau_w_SS/(1-tau_w_SS)*tau_w);
(1+nbeta*xi_p)*inf_p =nbeta*inf_p(+1)+xi_p*inf_p(-1)+(1-gamma_p)*(1-gamma_p*nbeta)/gamma_p*(z_P+mc);

//Firm

//u+k(-1)=y+(1-nalpha)*(w-rk)+(nalpha-1)*eps_z;
mc+(1-nalpha)*eps_z+nalpha*(u+k(-1))-nalpha*lp=w;

//mc=(1-nalpha)*(w-eps_z)+nalpha*rk;
mc+(1-nalpha)*eps_z+(nalpha-1)*(u+k(-1))+(1-nalpha)*lp=rk;


// Supply & Demand

y_SS*y=k_SS^(nalpha)*lp_SS^(1-nalpha)*(nalpha*u+nalpha*k(-1)+(1-nalpha)*lp+ (1-nalpha)*eps_z);
y_SS*y=c_SS*c+I_SS*I+eps_y+cg_SS*cg+rk_SS*(1-tau_k_SS)*k_SS*u;
//y_SS*y=c_SS*c+I_SS*I+cg_SS*cg+rk_SS*(1-tau_k_SS)*k_SS*u;

GDP=y-rk_SS*(1-tau_k_SS)*k_SS/y_SS*u;


//Government

b_SS*b-b_SS/nbeta*(R(-1)-inf_p+b(-1))=cg_SS*cg+tr_SS*tr-tax_SS*tax;

//tax_SS*tax=tau_w_SS*w_SS*lp_SS*(tau_w+w+lp)+tau_k_SS*rk_SS*k_SS*(tau_k+rk+u+k(-1))+tau_k_SS*d_SS*(tau_k+(y_SS*y-rk_SS*k_SS*(rk+u+k(-1))-w_SS*lp_SS*(w+lp)));
tax_SS*tax=tau_w_SS*w_SS*lp_SS*(tau_w+w+lp)+tau_k_SS*rk_SS*k_SS*(tau_k+rk+u+k(-1))+tau_k_SS*(y_SS*y-rk_SS*k_SS*(rk+u+k(-1))-w_SS*lp_SS*(w+lp));

// Policy functions


R = rho_R*R(-1) + (1-rho_R)*(rho_pi*inf_p+rho_y*GDP)+eps_m; 

// Fiscal Policy Rule 

tau_w= rho_w*tau_w(-1)+ (1-rho_w)*( etaWk*k(-1)+etaWb*b(-1)+etaWy*GDP+etaWc*c+etaWh*lp+etaWw*w+etaWI*I+etaWpi*inf_p+etaWR*R)+eps_tauw;
tau_k= rho_k*tau_k(-1)+ (1-rho_k)*( etaKk*k(-1)+etaKb*b(-1)+etaKy*GDP+etaKc*c+etaKh*lp+etaKw*w+etaKI*I+etaKpi*inf_p+etaKR*R)+eps_tauk;


// Exogenous Variables

cg=rho_cg*cg(-1)+eps_cg;
tr=rho_tr*tr(-1)+eps_tr;
eps_i=rho_eps_i*eps_i(-1)+e_i;
eps_z=rho_eps_z*eps_z(-1)+e_z;
eps_q=rho_eps_q*eps_q(-1)+e_q;

z_P=rho_P*z_P(-1)+e_P/((1-gamma_p)*(1-gamma_p*nbeta)/gamma_p);
z_L=rho_L*z_L(-1)+e_L/((1-gamma_w)*(1-gamma_w*nbeta)/gamma_w/(1+theta_w*sigma_l));



//observables

gdp_rgd_obs=GDP-GDP(-1);
c_rgpc_obs=c-c(-1);
i_rgpc_obs=I-I(-1);
tr_obs=tr-tr(-1);
taxrev_rgpc_obs=tax-tax(-1);
govdebt_rcpc_obs=b-b(-1);
gexp_rgpc_obs=cg-cg(-1);
w_obs=w-w(-1);
l_obs=lp-lp(-1);


end; 
 
shocks; 
var e_i; stderr  0.01 ;
var e_z; stderr 0.01 ;
var eps_m; stderr 0.01 ;
var e_q; stderr 0.01 ;
var eps_cg; stderr 0.01 ;
var eps_tr; stderr 0.01 ;
var eps_tauk; stderr 0.01;
var eps_tauw; stderr 0.01 ;
var e_P; stderr 0.01;
var e_L; stderr 0.01;
var eps_y; stderr 0.01;
end; 



steady;
check;

estimated_params;
sigma_c,  1.9029, gamma_pdf, 1.75, 0.5;
sigma_l,3.7701 , gamma_pdf, 2, 1;
h,   0.5378, beta_pdf, 0.5, 0.15;
gamma_p,0.6786, beta_pdf, 0.5, 0.1;
gamma_w,0.7325,beta_pdf, 0.5, 0.1;
//xi_p,.3, beta_pdf, 0.5, 0.1;
//xi_w,.3,beta_pdf, 0.5, 0.1;
nu, 3.6422, gamma_pdf,4, .75;
sigma_u, 1.7460, gamma_pdf, 2, 0.5;



rho_R,0.8296, beta_pdf, 0.8, 0.1;
rho_pi,1.9086 , gamma_pdf, 1.7,0.1;
rho_y, 0.0285, gamma_pdf, 0.125, 0.05;

rho_eps_i,0.8203, beta_pdf, 0.85, 0.1;
rho_eps_z,0.9898, beta_pdf, 0.85, 0.1;
rho_eps_q,0.8922, beta_pdf, 0.85, 0.1;
rho_tr,0.8689, beta_pdf, 0.85, 0.1;
rho_cg,0.9629, beta_pdf, 0.85, 0.1;
rho_P,0.9681 , beta_pdf, 0.85, 0.1;
//rho_L,0.2, beta_pdf, 0.85, 0.1;

rho_w, 0.8551, beta_pdf, 0.85,  0.1;
etaWb, 0.1128, normal_pdf, 0, .5;
etaWh, 0.1458, normal_pdf, 0, .5;

rho_k,  0.8676, beta_pdf, 0.85,  0.1;
etaKb,0.4079, normal_pdf, 0, .5;
etaKI,.26, normal_pdf, 0, .5;


stderr e_i,0.0458, inv_gamma_pdf, 0.01, 4;
stderr e_z,0.0068, inv_gamma_pdf, 0.01, 4;
stderr e_q,0.0189, inv_gamma_pdf, 0.01, 4;
stderr eps_m,0.0016, inv_gamma_pdf, 0.01, 4;
stderr eps_tauw,0.0217, inv_gamma_pdf, 0.01, 4;
stderr eps_tauk,0.0382, inv_gamma_pdf, 0.01, 4;
stderr eps_cg,0.0263, inv_gamma_pdf, 0.01, 4;
stderr eps_tr,0.0494, inv_gamma_pdf, 0.01, 4;
stderr e_P,0.0015, inv_gamma_pdf, 0.01, 4;
stderr e_L,0.0071, inv_gamma_pdf, 0.01, 4;
stderr eps_y,0.0127, inv_gamma_pdf, 0.01, 4;

stderr taxrev_rgpc_obs,0.0055, inv_gamma_pdf, 0.01, 4;
end;

varobs  gdp_rgd_obs,c_rgpc_obs, i_rgpc_obs, inf_p, R, tau_w, tau_k, govdebt_rcpc_obs, taxrev_rgpc_obs, lp, w_obs, gexp_rgpc_obs;

stoch_simul( irf=20,order =1, nograph);

// estimation part

estimation(datafile=obsdata_first_diff2, order=1, mh_replic=0,
 mh_drop=0.9, mh_jscale=.325, mh_init_scale=0.7, mh_nblocks=2,  mode_compute=4
//,load_mh_file
,mode_check
,mode_file=model_ext_mode_backup
//,bayesian_irf, irf=40
//,tex
)y, c, I, lp, w, inf_p, rk, b, R, tau_w, tau_k, tax;   


