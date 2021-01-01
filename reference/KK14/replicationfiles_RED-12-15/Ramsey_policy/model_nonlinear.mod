
// Endogenous variables 
var Util, Welf,  chi,  q, s, s_foc, Kw, Fw, w, w_star, wplusU, inf_w, wplus,  inf_p, pplus, eZ_obs, eI_obs, eQ_obs, eM_obs,
eC_obs, Kp, Fp, p_star, mc, I, c, lp,  rk, R, k, y, tau_w, tau_k, b, tax,  u, psi_u, psi_u_foc,eps_i, eps_z, eps_q, cg, tr,
c_obs, I_obs, y_obs, inf_p_obs,tau_k_obs,tau_w_obs,R_obs,lp_obs, k_obs, w_obs, tr_obs, b_obs, tax_obs, z_P, cg_obs,
welf_obs; 

// Stochastic Exogenous Shocks    
varexo e_i, e_z, e_q, eps_m, eps_cg, eps_tr, e_P; 

//PARAMETERS 
parameters nbeta, nalpha, sigma_l, sigma_c, psi_l, theta_w, theta_p, gamma_w, gamma_p, delta, nu, sigma_u, h,
            rho_R, rho_pi, rho_y, rho_w, rho_k, rho_cg,  rho_eps_i, rho_eps_z,rho_eps_q, rho_tr,   cgy, 
            tau_k_SS, tau_w_SS, inf_SS, u_SS, s_SS, s_foc_SS, q_SS, psi_u_SS, R_SS, mc_SS, rk_SS, psi_u_foc_SS, w_SS, lp_SS, k_SS,
            y_SS, I_SS, b_SS, cg_SS, c_SS, tax_SS, chi_SS, Util_SS, Welf_SS, eps_i_SS, eps_z_SS, eps_q_SS, Kw_SS, Fw_SS,
            w_star_SS, wplusU_SS, pplus_SS, Kp_SS, Fp_SS, p_star_SS, wplus_SS, tr_SS, FC, tr_o_y, rho_P,
            etaWk, etaWb, etaWy, etaWc, etaWh,  etaWw, etaWI, etaWpi,etaWR,
            etaKk, etaKb, etaKy, etaKc, etaKh,  etaKw, etaKI, etaKpi,etaKR;

setparams_simple;

model;
// Welfare and utility  
  
Util = (eps_q*(c-h*c(-1))^(1-sigma_c)/(1-sigma_c)-wplusU*psi_l*(lp/wplus)^(1+sigma_l)/(1+sigma_l)); 
Welf = Util + nbeta*Welf(+1);  
 
//Household 
chi=eps_q*(c-h*c(-1))^(-sigma_c)-eps_q(+1)*h*nbeta*(c(+1)-h*c)^(-sigma_c); 
1/R=nbeta*chi(+1)/chi/inf_p(+1); 
chi*q*eps_i*(1-s-s_foc*I/I(-1))+nbeta*chi(+1)*q(+1)*s_foc(+1)*eps_i(+1)*(I(+1)/I)^2-chi=0; 
q=nbeta*chi(+1)/chi*(u(+1)*psi_u_foc(+1)-psi_u(+1)+q(+1)*(1-delta)); 
psi_u=rk_SS*(1-tau_k_SS)/sigma_u*(exp(sigma_u*(u -1 ))-1);  
psi_u_foc=rk_SS*(1-tau_k_SS)*(exp(sigma_u*(u-1)));  
psi_u_foc=rk*(1-tau_k); 
k = (1-delta)*k(-1) +eps_i *(1 - s)*I;  
s=nu/2*(I/I(-1)-1)^2; 
s_foc=nu*(I/I(-1)-1); 
 
 
// Price setting & wage setting 
 
pplus=(1-gamma_p)*p_star^(-theta_p)+gamma_p*((inf_SS/inf_p))^(-theta_p)*pplus(-1); 
 
Fp=y*chi+gamma_p*nbeta*(inf_SS/inf_p(+1))^(1-theta_p)*Fp(+1); 
 
Kp=z_P*theta_p/(theta_p-1)*y*chi*mc+gamma_p*nbeta*(inf_SS/inf_p(+1))^(-theta_p)*Kp(+1);  
 
Kp/Fp=p_star; 
 
1=gamma_p*(inf_SS/inf_p)^(1-theta_p)+(1-gamma_p)*p_star^(1-theta_p); 
 
Kw=(lp/wplus)^(1+sigma_l)+ nbeta*gamma_w*(inf_SS/inf_w(+1))^(-theta_w*(1+sigma_l))*Kw(+1); 
 
Fw=(theta_w-1)/theta_w*(1-tau_w)*lp/wplus*(chi)+nbeta*gamma_w*(inf_p(+1)/inf_w(+1))^(-theta_w)*(inf_SS/inf_p(+1))^(1-theta_w)*Fw(+1); 
 
Kw/Fw=1/psi_l*w_star^(1+theta_w*sigma_l)*w; 
 
inf_w=w/w(-1)*inf_p; 
 
1=gamma_w*(inf_SS/inf_w)^(1-theta_w)+(1-gamma_w)*w_star^(1-theta_w); 
 
wplus=(1-gamma_w)*w_star^(-theta_w)+gamma_w*(inf_SS/inf_w)^(-theta_w)*wplus(-1); 
 
wplusU=(1-gamma_w)*w_star^(-theta_w*(1+sigma_l))+gamma_w*(inf_SS/inf_w)^(-theta_w*(1+sigma_l))*wplusU(-1); 
 
// Firm 
 
 
mc*eps_z^(1-nalpha)*(1-nalpha)*(u*k(-1))^(nalpha)*(lp/wplus)^(-nalpha)=w; 
mc*eps_z^(1-nalpha)*nalpha*u^(nalpha-1)*k(-1)^(nalpha-1)*(lp/wplus)^(1-nalpha)=rk;                                                               
 
 
// supply & demand 
 
y=((u*k(-1))^nalpha*(lp/wplus)^(1-nalpha)*eps_z^(1-nalpha)-FC)/pplus; 
 
y=(c+I+cg+psi_u*k(-1)); 
 
// Government 


b-R(-1)*b(-1)/inf_p=cg+tr-tax; 

tax=tau_w*w*lp/wplus+tau_k*(rk*u*k(-1)+(y-rk*u*k(-1)-w*lp/wplus)); 
 
// exogenous variables 

log(cg/cg_SS)=rho_cg*log(cg(-1)/cg_SS)+eps_cg;
log(tr/tr_SS)=rho_tr*log(tr(-1)/tr_SS)+eps_tr;
log(eps_i)=rho_eps_i*log(eps_i(-1))+e_i;
log(eps_z)=rho_eps_z*log(eps_z(-1))+e_z;
log(eps_q)=rho_eps_q*log(eps_q(-1))+e_q;
log(z_P)=rho_P*log(z_P(-1))+e_P/((1-gamma_p)*(1-gamma_p*nbeta)/gamma_p);


// Policy functions


log(R/R_SS) = rho_R*log(R(-1)/R_SS) + (1-rho_R)*(rho_pi*log(inf_p/inf_SS)+rho_y*log(y/y_SS))+eps_m; 

log(tau_w/tau_w_SS)= rho_w*log(tau_w(-1)/tau_w_SS)+  (etaWk*log(k(-1)/k_SS)+etaWb*log(b(-1)/b_SS)+etaWy*log(y/y_SS)+etaWc*log(c/c_SS)+etaWh*log(lp/lp_SS)+etaWw*log(w/w_SS)+etaWI*log(I/I_SS)+etaWpi*log(inf_p/inf_SS)+etaWR*log(R/R_SS));

log(tau_k/tau_k_SS)= rho_k*log(tau_k(-1)/tau_k_SS)+  (etaKk*log(k(-1)/k_SS)+etaKb*log(b(-1)/b_SS)+etaKy*log(y/y_SS)+etaKc*log(c/c_SS)+etaKh*log(lp/lp_SS)+etaKw*log(w/w_SS)+etaKI*log(I/I_SS)+etaKpi*log(inf_p/inf_SS)+etaKR*log(R/R_SS));



c_obs=log(c/c_SS);
I_obs=log(I/I_SS);
y_obs=log(y/y_SS);
inf_p_obs=log(inf_p/inf_SS);
tau_k_obs=log(tau_k/tau_k_SS);
tau_w_obs=log(tau_w/tau_w_SS); 
R_obs=log(R/R_SS);
lp_obs=log(lp/lp_SS);    
k_obs=log(k/k_SS);  
w_obs=log(w/w_SS);  
tr_obs=log(tr/tr_SS);
cg_obs=log(cg/cg_SS); 
b_obs=log(b/b_SS); 
tax_obs=log(tax/tax_SS);
welf_obs=log(Welf/Welf_SS); 

eZ_obs=e_z;
eI_obs=e_i; 
eQ_obs=e_q;
eM_obs=eps_m;
eC_obs=eps_cg;  
end; 
 
shocks; 



var e_i; stderr  0.0261 ;
var e_z; stderr 0.0064 ;
var eps_m; stderr 0.0016 ;
var e_q; stderr 0.0189  ;
var eps_cg; stderr  0.0263 ;
var eps_tr; stderr 0;//0.0494 ;
var e_P; stderr 0;// 0.0015 ;

end; 
 



steady;
check;

estimated_params;

//rho_w,0.3474 ,normal_pdf, 0, 1;
etaWk,0 , normal_pdf,  0 ,1;
etaWb,.2, normal_pdf, 0 ,1;
etaWy, 0 , normal_pdf,  0 ,1;
etaWc, 0, normal_pdf,  0,1;
etaWh,-4, normal_pdf,  0 ,1;
etaWw, 0, normal_pdf,  0 ,1;
etaWI,0 , normal_pdf,  0 ,1;

//rho_k,0.1980,normal_pdf, 0, 1;
etaKk,0, normal_pdf,  0 ,1;
etaKb, -.5, normal_pdf, 0,1;
etaKy,  0, normal_pdf,  0 ,1;
etaKc,0 , normal_pdf,  0 ,1;
etaKh,0 , normal_pdf,  0 ,1;
etaKw,0, normal_pdf, 0 ,1;
etaKI,4, normal_pdf,  0 ,1;

etaWpi, 0 , normal_pdf,  0 ,1;
etaWR, 0, normal_pdf,  0 ,1;

etaKpi, 0 , normal_pdf,  0 ,1;
etaKR, 0 , normal_pdf,  0, 1;

//stderr tau_k_obs, inv_gamma_pdf,0.01,4;
//stderr tau_w_obs, inv_gamma_pdf,0.01,4;
end;


varobs  tau_k_obs tau_w_obs eI_obs eC_obs eQ_obs;


estimation(datafile=ramsey_simult2, order=1, 
mh_replic=0,  mh_drop=0.9, mh_jscale=.4, mh_init_scale=0.7, mh_nblocks=2,  
mode_compute=4
//,load_mh_file
//,mode_check
//,bayesian_irf, irf=20
,mode_file=model_nonlinear_mode_backup
)lp, I, c, y, w, k, inf_p, R, b, tau_w, tau_k, tax;  

setparams_simple;

stoch_simul( irf=20,order =1, nograph)tau_k_obs tau_w_obs ;


stoch_simul( irf=20,order =1, nograph, periods=250)c_obs y_obs I_obs R_obs inf_p_obs lp_obs k_obs w_obs tax_obs b_obs tr_obs  tau_k_obs tau_w_obs welf_obs;

simul_base=[c_obs y_obs I_obs R_obs inf_p_obs lp_obs k_obs w_obs tax_obs b_obs tr_obs cg_obs tau_k_obs tau_w_obs welf_obs z_P eps_z eps_q eps_i];
save('simul_final2.mat', 'simul_base');

ramsey_simult_compare;



