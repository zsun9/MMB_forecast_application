 
// Endogenous variables  
var Util, Welf,  chi,  q, s, s_foc, Kw, Fw, w, w_star, wplusU, inf_w, wplus,  inf_p, pplus, 
    Kp, Fp, p_star, mc, I, c, lp,  rk, R, k, y, tau_w, tau_k, b, tax,  u, psi_u, psi_u_foc,
    eps_i, eps_z, eps_q, cg, tr, z_P, 
    lmult1,  lmult2,  lmult3,  lmult4,  lmult5,  lmult6,  lmult7,   
    lmult8,  lmult9,  lmult10,  lmult11,  lmult12,  lmult13,  lmult14,   
    lmult15,  lmult16,  lmult17,  lmult18,  lmult19,  lmult20,  lmult21,   
    lmult22,  lmult23,  lmult24,  lmult25,  lmult26,  lmult27,  lmult28,   
    lmult35,
/// simple Rules
    Util_c, Welf_c,  chi_c,  q_c, s_c, s_foc_c, Kw_c, Fw_c, w_c, w_star_c, wplusU_c, inf_w_c, wplus_c,  inf_p_c, pplus_c, 
    Kp_c, Fp_c, p_star_c, mc_c, I_c, c_c, lp_c,  rk_c, R_c, k_c, y_c, tau_w_c, tau_k_c, b_c, tax_c,  u_c, psi_u_c, psi_u_foc_c,
    WL, Welf_Lc, Util_Lc
; 

 
// Stochastic Exogenous Shocks     
varexo e_i, e_z, e_q, eps_m, eps_cg, eps_tr, e_P;  
 
 
//PARAMETERS  
parameters nbeta, nalpha, sigma_l, sigma_c, psi_l, theta_w, theta_p, gamma_w, gamma_p, delta, nu, sigma_u, h, 
            rho_R, rho_pi, rho_y,  rho_cg,  rho_eps_i, rho_eps_z,rho_eps_q, rho_tr,  cgy,  
            tau_k_SS, tau_w_SS, inf_SS, u_SS, s_SS, s_foc_SS, q_SS, psi_u_SS, R_SS, mc_SS, rk_SS, psi_u_foc_SS, w_SS, lp_SS, k_SS, 
            y_SS, I_SS, b_SS, cg_SS, c_SS, tax_SS, chi_SS, Util_SS, Welf_SS, eps_i_SS, eps_z_SS, eps_q_SS, Kw_SS, Fw_SS, 
            w_star_SS, wplusU_SS, pplus_SS, Kp_SS, Fp_SS, p_star_SS, wplus_SS, tr_SS, FC, tr_o_y, rho_P, inf_p_SS, inf_w_SS, z_P_SS,
            lmult1_SS,  lmult2_SS,  lmult3_SS,  lmult4_SS,  lmult5_SS,   
            lmult6_SS,  lmult7_SS,  lmult8_SS,  lmult9_SS,  lmult10_SS,   
            lmult11_SS,  lmult12_SS,  lmult13_SS,  lmult14_SS,  lmult15_SS,   
            lmult16_SS,  lmult17_SS,  lmult18_SS,  lmult19_SS,  lmult20_SS,   
            lmult21_SS,  lmult22_SS,  lmult23_SS,  lmult24_SS,  lmult25_SS,   
            lmult26_SS,  lmult27_SS,  lmult28_SS,  lmult35_SS,
/// simple Rules
            rho_w, rho_k,
            etaWk, etaWb, etaWy, etaWc, etaWh,  etaWw, etaWI, etaWpi,etaWR,
            etaKk, etaKb, etaKy, etaKc, etaKh,  etaKw, etaKI, etaKpi,etaKR;

 
 
setparams;
  
model; 
// Welfare and utility   
   
Util = (eps_q*(c-h*c(-1))^(1-sigma_c)/(1-sigma_c)-wplusU*psi_l*(lp/wplus)^(1+sigma_l)/(1+sigma_l));  
Welf = Util + nbeta*Welf(+1);   
  
// Welfare and utility    - Simple Rules
Util_c = (eps_q*(c_c-h*c_c(-1))^(1-sigma_c)/(1-sigma_c)-wplusU_c*psi_l*(lp_c/wplus_c)^(1+sigma_l)/(1+sigma_l));  
Welf_c = Util_c + nbeta*Welf_c(+1);   

Util_Lc=wplusU_c*psi_l*(lp_c/wplus_c)^(1+sigma_l)/(1+sigma_l);
Welf_Lc=Util_Lc + nbeta*Welf_Lc(+1); 

WL=((Welf+Welf_Lc)/(Welf_c+Welf_Lc))^(1/(1-sigma_c))-1;

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

//Household - Simple Rules
chi_c=eps_q*(c_c-h*c_c(-1))^(-sigma_c)-eps_q(+1)*h*nbeta*(c_c(+1)-h*c_c)^(-sigma_c);  
1/R_c=nbeta*chi_c(+1)/chi_c/inf_p_c(+1);  
chi_c*q_c*eps_i*(1-s_c-s_foc_c*I/I(-1))+nbeta*chi_c(+1)*q_c(+1)*s_foc_c(+1)*eps_i(+1)*(I_c(+1)/I_c)^2-chi_c=0;  
q_c=nbeta*chi_c(+1)/chi_c*(u_c(+1)*psi_u_foc_c(+1)-psi_u_c(+1)+q_c(+1)*(1-delta));  
psi_u_c=rk_SS*(1-tau_k_SS)/sigma_u*(exp(sigma_u*(u_c -1 ))-1);   
psi_u_foc_c=rk_SS*(1-tau_k_SS)*(exp(sigma_u*(u_c-1)));   
psi_u_foc_c=rk_c*(1-tau_k_c);  
k_c = (1-delta)*k_c(-1) +eps_i *(1 - s_c)*I_c;   
s_c=nu/2*(I_c/I_c(-1)-1)^2;  
s_foc_c=nu*(I_c/I_c(-1)-1);  
  
    
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


// Price setting & wage setting  -Simple Rules
  
pplus_c=(1-gamma_p)*p_star_c^(-theta_p)+gamma_p*((inf_SS/inf_p_c))^(-theta_p)*pplus_c(-1);  
  
Fp_c=y_c*chi_c+gamma_p*nbeta*(inf_SS/inf_p_c(+1))^(1-theta_p)*Fp_c(+1);  
  
Kp_c=z_P*theta_p/(theta_p-1)*y_c*chi_c*mc_c+gamma_p*nbeta*(inf_SS/inf_p_c(+1))^(-theta_p)*Kp_c(+1);   
  
Kp_c/Fp_c=p_star_c;  
  
1=gamma_p*(inf_SS/inf_p_c)^(1-theta_p)+(1-gamma_p)*p_star_c^(1-theta_p);  
  
Kw_c=(lp_c/wplus_c)^(1+sigma_l)+ nbeta*gamma_w*(inf_SS/inf_w_c(+1))^(-theta_w*(1+sigma_l))*Kw_c(+1);  
  
Fw_c=(theta_w-1)/theta_w*(1-tau_w_c)*lp_c/wplus_c*(chi)+nbeta*gamma_w*(inf_p_c(+1)/inf_w_c(+1))^(-theta_w)*(inf_SS/inf_p_c(+1))^(1-theta_w)*Fw_c(+1);  
  
Kw_c/Fw_c=1/psi_l*w_star_c^(1+theta_w*sigma_l)*w_c;  
  
inf_w_c=w_c/w_c(-1)*inf_p_c;  
  
1=gamma_w*(inf_SS/inf_w_c)^(1-theta_w)+(1-gamma_w)*w_star_c^(1-theta_w);  
  
wplus_c=(1-gamma_w)*w_star_c^(-theta_w)+gamma_w*(inf_SS/inf_w_c)^(-theta_w)*wplus_c(-1);  
  
wplusU_c=(1-gamma_w)*w_star_c^(-theta_w*(1+sigma_l))+gamma_w*(inf_SS/inf_w_c)^(-theta_w*(1+sigma_l))*wplusU_c(-1);  
  

  
// Firm  
  
  
mc*eps_z^(1-nalpha)*(1-nalpha)*(u*k(-1))^(nalpha)*(lp/wplus)^(-nalpha)=w;  
mc*eps_z^(1-nalpha)*nalpha*u^(nalpha-1)*k(-1)^(nalpha-1)*(lp/wplus)^(1-nalpha)=rk;                                                                
  
// Firm  -Simple Rules
  
  
mc_c*eps_z^(1-nalpha)*(1-nalpha)*(u_c*k_c(-1))^(nalpha)*(lp_c/wplus_c)^(-nalpha)=w_c;  
mc_c*eps_z^(1-nalpha)*nalpha*u_c^(nalpha-1)*k_c(-1)^(nalpha-1)*(lp_c/wplus_c)^(1-nalpha)=rk_c;                                                                


  
// supply & demand  
  
y=((u*k(-1))^nalpha*(lp/wplus)^(1-nalpha)*eps_z^(1-nalpha)-FC)/pplus;  
  
y=(c+I+cg+psi_u*k(-1));  

// supply & demand  -Simple Rules
  
y_c=((u_c*k_c(-1))^nalpha*(lp_c/wplus_c)^(1-nalpha)*eps_z^(1-nalpha)-FC)/pplus_c;  
  
y_c=(c_c+I_c+cg+psi_u_c*k_c(-1));  
  
// Government  
 
 
b-R(-1)*b(-1)/inf_p=cg+tr-tax;  
 
tax=tau_w*w*lp/wplus+tau_k*(rk*u*k(-1)+(y-rk*u*k(-1)-w*lp/wplus));  

// Government -Simple Rules
 
 
b_c-R_c(-1)*b_c(-1)/inf_p_c=cg+tr-tax_c;  
 
tax_c=tau_w_c*w_c*lp_c/wplus_c+tau_k_c*(rk_c*u_c*k_c(-1)+(y_c-rk_c*u_c*k_c(-1)-w_c*lp_c/wplus_c));  
  
// exogenous variables  
 
log(cg/cg_SS)=rho_cg*log(cg(-1)/cg_SS)+eps_cg; 
log(tr/tr_SS)=rho_tr*log(tr(-1)/tr_SS)+eps_tr; 
log(eps_i)=rho_eps_i*log(eps_i(-1))+e_i; 
log(eps_z)=rho_eps_z*log(eps_z(-1))+e_z; 
log(eps_q)=rho_eps_q*log(eps_q(-1))+e_q; 
log(z_P)=rho_P*log(z_P(-1))+e_P/((1-gamma_p)*(1-gamma_p*nbeta)/gamma_p); 
 
 
// Policy functions 
 
 
log(R/R_SS) = rho_R*log(R(-1)/R_SS) + (1-rho_R)*(rho_pi*log(inf_p/inf_SS)+rho_y*log(y/y_SS))+eps_m;  
 
// Policymaker's First-Order Conditions 
lmult27 - (R*lmult27(+1)*nbeta)/inf_p(+1); 
lmult1*((eps_q*sigma_c)/(c - c(-1)*h)^(sigma_c + 1) + (eps_q(+1)*h^2*nbeta*sigma_c)/(c(+1) - c*h)^(sigma_c + 1)) - lmult26 + eps_q/(c - c(-1)*h)^sigma_c - (eps_q(+1)*h*nbeta)/(c(+1) - c*h)^sigma_c - (eps_q*h*lmult1(-1)*sigma_c)/(c - c(-1)*h)^(sigma_c + 1) - (eps_q(+1)*h*lmult1(+1)*nbeta*sigma_c)/(c(+1) - c*h)^(sigma_c + 1); 
lmult1 - lmult12*y - lmult3*(eps_i*q*(s + (I*s_foc)/I(-1) - 1) + 1) + (lmult4(-1)*(psi_u - psi_u_foc*u + q*(delta - 1)))/chi(-1) - lmult2(-1)/(chi(-1)*inf_p) - (chi(+1)*lmult4*nbeta*(psi_u(+1) - psi_u_foc(+1)*u(+1) + q(+1)*(delta - 1)))/chi^2 + (chi(+1)*lmult2*nbeta)/(chi^2*inf_p(+1)) + (I^2*eps_i*lmult3(-1)*q*s_foc)/I(-1)^2 + (lmult17*lp*(tau_w - 1)*(theta_w - 1))/(theta_w*wplus) - (lmult13*mc*theta_p*y*z_P)/(theta_p - 1); 
lmult12 - gamma_p*lmult12(-1)*(inf_SS/inf_p)^(1 - theta_p) - (Kp*lmult14)/Fp^2; 
lmult17 - (Kw*lmult18)/Fw^2 - (gamma_w*lmult17(-1)*(inf_SS/inf_p)^(1 - theta_w))/(inf_p/inf_w)^theta_w; 
eps_i*lmult8*(s - 1) - lmult3*((chi*eps_i*q*s_foc)/I(-1) + (2*I(+1)^2*chi(+1)*eps_i(+1)*nbeta*q(+1)*s_foc(+1))/I^3) - lmult26 - (lmult10*nu)/I(-1) - (lmult9*nu*(I/I(-1) - 1))/I(-1) + (I(+1)*lmult10(+1)*nbeta*nu)/I^2 + (I(+1)*lmult9(+1)*nbeta*nu*(I(+1)/I - 1))/I^2 + (2*I*chi*eps_i*lmult3(-1)*q*s_foc)/I(-1)^2 + (I(+1)*chi(+1)*eps_i(+1)*lmult3(+1)*nbeta*q(+1)*s_foc(+1))/I^2; 
(lmult17(-1)*((Fw*gamma_w*nbeta*theta_w*(inf_SS/inf_p)^(1 - theta_w))/(inf_w*(inf_p/inf_w)^(theta_w + 1)) - (Fw*gamma_w*inf_SS*nbeta*(theta_w - 1))/(inf_p^2*(inf_p/inf_w)^theta_w*(inf_SS/inf_p)^theta_w)))/nbeta - (lmult19*w)/w(-1) + (R(-1)*b(-1)*lmult27)/inf_p^2 + (chi*lmult2(-1))/(chi(-1)*inf_p^2) + (lmult35*rho_pi*(rho_R - 1))/inf_p - (gamma_p*inf_SS*lmult15*(theta_p - 1))/(inf_p^2*(inf_SS/inf_p)^theta_p) - (Fp*gamma_p*inf_SS*lmult12(-1)*(theta_p - 1))/(inf_p^2*(inf_SS/inf_p)^theta_p) - (Kp*gamma_p*inf_SS*lmult13(-1)*theta_p)/(inf_p^2*(inf_SS/inf_p)^(theta_p + 1)) - (gamma_p*inf_SS*lmult11*pplus(-1)*theta_p)/(inf_p^2*(inf_SS/inf_p)^(theta_p + 1)); 
lmult19 - (gamma_w*inf_SS*lmult20*(theta_w - 1))/(inf_w^2*(inf_SS/inf_w)^theta_w) - (gamma_w*inf_SS*lmult21*theta_w*wplus(-1))/(inf_w^2*(inf_SS/inf_w)^(theta_w + 1)) - (gamma_w*inf_SS*lmult22*theta_w*wplusU(-1)*(sigma_l + 1))/(inf_w^2*(inf_SS/inf_w)^(theta_w*(sigma_l + 1) + 1)) - (Fw*gamma_w*inf_p*lmult17(-1)*theta_w*(inf_SS/inf_p)^(1 - theta_w))/(inf_w^2*(inf_p/inf_w)^(theta_w + 1)) - (Kw*gamma_w*inf_SS*lmult16(-1)*theta_w*(sigma_l + 1))/(inf_w^2*(inf_SS/inf_w)^(theta_w*(sigma_l + 1) + 1)); 
lmult8 - lmult26(+1)*nbeta*psi_u(+1) + lmult8(+1)*nbeta*(delta - 1) - (eps_z(+1)^(1 - nalpha)*lmult25(+1)*nalpha*nbeta*u(+1)*(k*u(+1))^(nalpha - 1)*(lp(+1)/wplus(+1))^(1 - nalpha))/pplus(+1) + eps_z(+1)^(1 - nalpha)*k^(nalpha - 2)*lmult24(+1)*mc(+1)*nalpha*nbeta*u(+1)^(nalpha - 1)*(lp(+1)/wplus(+1))^(1 - nalpha)*(nalpha - 1) - (eps_z(+1)^(1 - nalpha)*lmult23(+1)*mc(+1)*nalpha*nbeta*u(+1)*(k*u(+1))^(nalpha - 1)*(nalpha - 1))/(lp(+1)/wplus(+1))^nalpha; 
lmult13 + lmult14/Fp - (gamma_p*lmult13(-1))/(inf_SS/inf_p)^theta_p; 
lmult16 + lmult18/Fw - (gamma_w*lmult16(-1))/(inf_SS/inf_w)^(theta_w*(sigma_l + 1)); 
lmult28*((tau_k*w)/wplus - (tau_w*w)/wplus) - (psi_l*wplusU*(lp/wplus)^sigma_l)/wplus - (lmult16*(lp/wplus)^sigma_l*(sigma_l + 1))/wplus + (chi*lmult17*(tau_w - 1)*(theta_w - 1))/(theta_w*wplus) + (eps_z^(1 - nalpha)*lmult25*(k(-1)*u)^nalpha*(nalpha - 1))/(pplus*wplus*(lp/wplus)^nalpha) + (eps_z^(1 - nalpha)*lmult23*mc*nalpha*(k(-1)*u)^nalpha*(nalpha - 1))/(wplus*(lp/wplus)^(nalpha + 1)) - (eps_z^(1 - nalpha)*k(-1)^(nalpha - 1)*lmult24*mc*nalpha*u^(nalpha - 1)*(nalpha - 1))/(wplus*(lp/wplus)^nalpha); 
eps_z^(1 - nalpha)*k(-1)^(nalpha - 1)*lmult24*nalpha*u^(nalpha - 1)*(lp/wplus)^(1 - nalpha) - (eps_z^(1 - nalpha)*lmult23*(k(-1)*u)^nalpha*(nalpha - 1))/(lp/wplus)^nalpha - (chi*lmult13*theta_p*y*z_P)/(theta_p - 1); 
lmult11 - (lmult25*(FC - eps_z^(1 - nalpha)*(k(-1)*u)^nalpha*(lp/wplus)^(1 - nalpha)))/pplus^2 - (gamma_p*lmult11(+1)*nbeta)/(inf_SS/inf_p(+1))^theta_p; 
lmult5 - k(-1)*lmult26 + (chi*lmult4(-1))/chi(-1); 
lmult6 + lmult7 - (chi*lmult4(-1)*u)/chi(-1); 
- lmult14 - (lmult11*theta_p*(gamma_p - 1))/p_star^(theta_p + 1) - (lmult15*(gamma_p - 1)*(theta_p - 1))/p_star^theta_p; 
lmult4 - chi*eps_i*lmult3*(s + (I*s_foc)/I(-1) - 1) + (chi*lmult4(-1)*(delta - 1))/chi(-1) + (I^2*chi*eps_i*lmult3(-1)*s_foc)/I(-1)^2; 
lmult35/R - lmult2/R^2 - (lmult35(+1)*nbeta*rho_R)/R - (b*lmult27(+1)*nbeta)/inf_p(+1); 
lmult7*(tau_k - 1) - lmult24; 
lmult9 + I*eps_i*lmult8 - chi*eps_i*lmult3*q; 
lmult10 + (I^2*chi*eps_i*lmult3(-1)*q)/I(-1)^2 - (I*chi*eps_i*lmult3*q)/I(-1); 
lmult7*rk - lmult28*(y - (lp*w)/wplus); 
(chi*lmult17*lp*(theta_w - 1))/(theta_w*wplus) - (lmult28*lp*w)/wplus; 
lmult27 + lmult28; 
lmult5*rk_SS*exp(sigma_u*(u - 1))*(tau_k_SS - 1) - (chi*lmult4(-1)*psi_u_foc)/chi(-1) + lmult6*rk_SS*sigma_u*exp(sigma_u*(u - 1))*(tau_k_SS - 1) - (eps_z^(1 - nalpha)*k(-1)*lmult25*nalpha*(k(-1)*u)^(nalpha - 1)*(lp/wplus)^(1 - nalpha))/pplus - (eps_z^(1 - nalpha)*k(-1)*lmult23*mc*nalpha*(k(-1)*u)^(nalpha - 1)*(nalpha - 1))/(lp/wplus)^nalpha + eps_z^(1 - nalpha)*k(-1)^(nalpha - 1)*lmult24*mc*nalpha*u^(nalpha - 2)*(lp/wplus)^(1 - nalpha)*(nalpha - 1); 
lmult28*((lp*tau_k)/wplus - (lp*tau_w)/wplus) - lmult23 - (inf_p*lmult19)/w(-1) - (lmult18*w_star^(sigma_l*theta_w + 1))/psi_l + (inf_p(+1)*lmult19(+1)*nbeta*w(+1))/w^2; 
lmult21 - lmult28*((lp*tau_k*w)/wplus^2 - (lp*tau_w*w)/wplus^2) - (gamma_w*lmult21(+1)*nbeta)/(inf_SS/inf_w(+1))^theta_w + (lp*psi_l*wplusU*(lp/wplus)^sigma_l)/wplus^2 + (lmult16*lp*(lp/wplus)^sigma_l*(sigma_l + 1))/wplus^2 - (chi*lmult17*lp*(tau_w - 1)*(theta_w - 1))/(theta_w*wplus^2) - (eps_z^(1 - nalpha)*lmult25*lp*(k(-1)*u)^nalpha*(nalpha - 1))/(pplus*wplus^2*(lp/wplus)^nalpha) - (eps_z^(1 - nalpha)*lmult23*lp*mc*nalpha*(k(-1)*u)^nalpha*(nalpha - 1))/(wplus^2*(lp/wplus)^(nalpha + 1)) + (eps_z^(1 - nalpha)*k(-1)^(nalpha - 1)*lmult24*lp*mc*nalpha*u^(nalpha - 1)*(nalpha - 1))/(wplus^2*(lp/wplus)^nalpha); 
lmult22 - (psi_l*(lp/wplus)^(sigma_l + 1))/(sigma_l + 1) - (gamma_w*lmult22(+1)*nbeta)/(inf_SS/inf_w(+1))^(theta_w*(sigma_l + 1)); 
- (lmult20*(gamma_w - 1)*(theta_w - 1))/w_star^theta_w - (lmult21*theta_w*(gamma_w - 1))/w_star^(theta_w + 1) - (lmult22*theta_w*(gamma_w - 1)*(sigma_l + 1))/w_star^(theta_w*(sigma_l + 1) + 1) - (lmult18*w*w_star^(sigma_l*theta_w)*(sigma_l*theta_w + 1))/psi_l; 
lmult25 + lmult26 - chi*lmult12 - lmult28*tau_k + (lmult35*rho_y*(rho_R - 1))/y - (chi*lmult13*mc*theta_p*z_P)/(theta_p - 1); 
 

// Policy functions  -simple Rules
 
 
log(R_c/R_SS) = rho_R*log(R_c(-1)/R_SS) + (1-rho_R)*(rho_pi*log(inf_p_c/inf_SS)+rho_y*log(y_c/y_SS))+eps_m;  

log(tau_w_c/tau_w_SS)= rho_w*log(tau_w_c(-1)/tau_w_SS)+  (etaWk*log(k_c(-1)/k_SS)+etaWb*log(b_c(-1)/b_SS)+etaWy*log(y_c/y_SS)+etaWc*log(c_c/c_SS)+etaWh*log(lp_c/lp_SS)+etaWw*log(w_c/w_SS)+etaWI*log(I_c/I_SS)+etaWpi*log(inf_p_c/inf_SS)+etaWR*log(R_c/R_SS));

log(tau_k_c/tau_k_SS)= rho_k*log(tau_k_c(-1)/tau_k_SS)+  (etaKk*log(k_c(-1)/k_SS)+etaKb*log(b_c(-1)/b_SS)+etaKy*log(y_c/y_SS)+etaKc*log(c_c/c_SS)+etaKh*log(lp_c/lp_SS)+etaKw*log(w_c/w_SS)+etaKI*log(I_c/I_SS)+etaKpi*log(inf_p_c/inf_SS)+etaKR*log(R_c/R_SS));


    
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


//steady;
//resid(1);
//check;  
  

stoch_simul(irf=0,order = 2,nograph, nomoments, noprint);

row_WL = strmatch('WL', M_.endo_names(oo_.dr.order_var,:), 'exact');

Loss=(oo_.dr.ys(oo_.dr.order_var(row_WL))+oo_.dr.ghs2(row_WL)/2)*100;


//disp(sprintf('Welfare Loss: %0.5g',Loss));
disp('Starting optmization, please wait!')

//para_b_k=[-5:0.25:0.5];
//para_b_w=[0.5:0.25:5];

//CLS=zeros(size(para_b_w,2),size(para_b_k,2));

//tot=size(para_b_w,2)*size(para_b_k,2);
//count_tot=0;
//for jj=1:size(para_b_w,2)
//for ii=1:size(para_b_k,2)
//count_tot=count_tot+1;
//disp(count_tot)
//CLS(jj,ii)=calc_conditional_WL([para_b_w(jj);para_b_k(ii)],row_WL);
//end
//end

//figure
//mesh(para_b_w,para_b_k,CLS)
//xlim([min(para_b_k) max(para_b_k)])
//ylim([min(para_b_w) max(para_b_w)])


options=optimset('Display', 'off');

//[para_new_L91, fval_L91]=fminsearch(@calc_conditional_WL,[2.2654;-0.001],options,row_WL);

[para_new_L10, fval_L10]=fminsearch(@calc_conditional_WL2,[0.2043;-3.7885;-1.6419;14.7218],options,row_WL);

[para_new_KK, fval_KK]=fminsearch(@calc_conditional_WL3,[0.00;-3.689;-3.174;8.428],options,row_WL);

clc;

disp(' ')
disp('respond on debt - output / output ')
disp(' ')
disp(sprintf('eta_wb: %1.4f',para_new_L10(1)));
disp(sprintf('eta_Kb: %1.4f',para_new_L10(3)));
disp(sprintf('eta_wy: %1.4f',para_new_L10(2)));
disp(sprintf('eta_Ky: %1.4f',para_new_L10(4)));
disp(' ')
disp('loss:')
disp(fval_L10)
disp('-------------------------------------- ')
disp(' ')
disp('respond on debt - hours worked / investment')
disp(' ')
disp(sprintf('eta_wb: %1.4f',para_new_KK(1)));
disp(sprintf('eta_Kb: %1.4f',para_new_KK(3)));
disp(sprintf('eta_wh: %1.4f',para_new_KK(2)));
disp(sprintf('eta_KI: %1.4f',para_new_KK(4)));

disp(' ')
disp('loss:')
disp(fval_KK)
