// Endogenous variables 
var  MUL,  MRS,  chi,   w,  q, y, inf_p, mc, u, 
    I, c, lp,  rk, R,  k, tax,  b, tau_w, tau_k, GDP, Util, Welf, 
     cg,  eps_i, eps_z, eps_q, tr, y_obs, c_obs, I_obs, tr_obs, tax_obs, b_obs, g_obs, l_obs, w_obs;
   

varexo e_i, e_z, e_q, eps_m, eps_cg, eps_tr; 

//PARAMETERS 
parameters nbeta, nalpha, sigma_l, sigma_c,  theta_w, theta_p, gamma_w, gamma_p, delta, nu,  h, sigma_u,
            rho_R, rho_pi, rho_y,  rho_cg,  rho_eps_i ,rho_eps_z,rho_eps_q, rho_w, rho_k, rho_tr,
            tr_o_y, cgy,  tau_k_SS, tau_w_SS, R_SS,  xi_w, xi_p,
            etaWk, etaWb, etaWy, etaWc, etaWh,  etaWw, etaWI, etaWpi,etaWR,
            etaKk, etaKb, etaKy, etaKc, etaKh,  etaKw, etaKI, etaKpi,etaKR,
            inf_p_SS, mc_SS, rk_SS, w_SS, lk_bar, ckbar, l_SS, psi_l, lp_SS, k_SS, FC, y_SS,
            c_SS, I_SS, cg_SS, tax_SS, tr_SS,b_SS, Util_SS;
            
  

//deep model parameter and implied SS
  
theta_p=6;
theta_w=11;
  

R_SS=1.013;       
cgy=0.085;          
tr_o_y=0.105;       
nbeta=0.9935;       
nalpha=0.36;      
delta=0.025;  



tau_k_SS=    -0.152317467790574;
tau_w_SS=    0.394496355651328;

  
sigma_c=  1.7187; 
sigma_l=  3.4307; 
h=0.5677 ;      
sigma_u =1.7538 ;   

nu=2.9609;   



gamma_p=0.6771;
gamma_w=0.6596;

rho_cg=   0.9629 ;   
rho_tr= 0.8692 ;  

rho_eps_i=  0.8787 ;
rho_eps_z= 0.9796 ;
rho_eps_q=  0.8852 ;
rho_P=0.9641;
rho_L=0;

xi_w=0;
xi_p=0 ;


rho_R=0.8321;  
rho_pi=1.9286; 
rho_y=0.0289 ;  





// Fiscal feedback Rules

rho_w=0; 
etaWk=0; 
etaWb=0.2; 
etaWy=0; 
etaWc=0; 
etaWh=0; 
etaWw=0; 
etaWI=0; 
etaWpi=0; 
etaWR=0; 


rho_k=0;    
etaKk=0;  
etaKb=-0.2;  
etaKy=0; 
etaKc=0; 
etaKh=0; 
etaKw=0; 
etaKI=0; 
etaKpi=0; 
etaKR=0; 


inf_p_SS=R_SS*nbeta;
mc_SS=(theta_p-1)/theta_p;
rk_SS=(1-nbeta*(1-delta))/(1-tau_k_SS)/nbeta;
w_SS=mc_SS^(1/(1-nalpha))*(1-nalpha)*nalpha^(nalpha/(1-nalpha))*rk_SS^(-nalpha/(1-nalpha));
lk_bar=(1-nalpha)/nalpha*rk_SS/w_SS;
ckbar=(1-cgy)*(mc_SS*lk_bar^(1-nalpha))-delta;
l_SS=1/3;
lp_SS=l_SS;
psi_l=(w_SS^(1)*(theta_w-1)/theta_w *(1-h)^(-sigma_c)*(1-tau_w_SS)*(1-nbeta*h) *ckbar^(-sigma_c)*lk_bar^(sigma_c))/l_SS^(sigma_c+sigma_l);
k_SS=lp_SS/lk_bar;
FC= (1-mc_SS)*(k_SS)^nalpha*lp_SS^(1-nalpha);
y_SS=k_SS^nalpha*lp_SS^(1-nalpha)-FC;
c_SS=ckbar*k_SS;
I_SS=delta*k_SS;
cg_SS=y_SS-c_SS-I_SS;
tax_SS=tau_w_SS*w_SS*lp_SS+tau_k_SS*(rk_SS*k_SS+y_SS-rk_SS*k_SS-w_SS*lp_SS);
tr_SS=tr_o_y*y_SS;
b_SS=1/(1-1/nbeta)*(tr_SS+cg_SS-tax_SS);
Util_SS= ( ((1-h)*c_SS)^(1-sigma_c)/(1-sigma_c)-psi_l*l_SS^(1+sigma_l)/(1+sigma_l));



model(linear); 

// Household

(1-nbeta*h)*chi=eps_q-sigma_c/(1-h)*(c-h*c(-1))-h*nbeta*eps_q(+1)+h*nbeta*sigma_c/(1-h)*(c(+1)-h*c);
0=chi(+1)-chi+R-inf_p(+1);
MRS=MUL-chi;
MUL=sigma_l*lp;
chi+q=chi(+1)+nbeta*((1-tau_k_SS)*rk_SS*rk(+1)-tau_k_SS*rk_SS*tau_k(+1)+(1-delta)*q(+1));
//k=(1-delta)*k(-1)+delta*I+delta*eps_i;
//I=I(-1)/(1+nbeta)+nbeta/(1+nbeta)*I(+1)+ q/nu/(1+nbeta)+eps_i/nu/(1+nbeta);
k=(1-delta)*k(-1)+delta*I;
I=I(-1)/(1+nbeta)+nbeta/(1+nbeta)*I(+1)+ q/nu/(1+nbeta)+ nbeta/(1+nbeta)*eps_i(+1)- eps_i/(1+nbeta);


sigma_u*u=rk-tau_k_SS/(1-tau_k_SS)*tau_k;


// Staggered Prices & Wages 

(1+nbeta)*w-nbeta*w(+1)-nbeta*inf_p(+1)-xi_w*inf_p(-1)=w(-1)-(1+nbeta*xi_w)*inf_p+(1-gamma_w)*(1-gamma_w*nbeta)/gamma_w/(1+theta_w*sigma_l)*(MRS-w+ tau_w_SS/(1-tau_w_SS)*tau_w);
(1+nbeta*xi_p)*inf_p =nbeta*inf_p(+1)+xi_p*inf_p(-1)+(1-gamma_p)*(1-gamma_p*nbeta)/gamma_p*(mc);

//Firm

mc+(1-nalpha)*eps_z+nalpha*(u+k(-1))-nalpha*lp=w;
mc+(1-nalpha)*eps_z+(nalpha-1)*(u+k(-1))+(1-nalpha)*lp=rk;

// Supply & Demand

y_SS*y=k_SS^(nalpha)*lp_SS^(1-nalpha)*(nalpha*u+nalpha*k(-1)+(1-nalpha)*lp+ (1-nalpha)*eps_z);
y_SS*y=c_SS*c+I_SS*I+cg_SS*cg+rk_SS*(1-tau_k_SS)*k_SS*u;

GDP=y-rk_SS*(1-tau_k_SS)*k_SS/y_SS*u;

//Government

b_SS*b-b_SS/nbeta*(R(-1)-inf_p+b(-1))=cg_SS*cg+tr_SS*tr-tax_SS*tax;
tax_SS*tax=tau_w_SS*w_SS*lp_SS*(tau_w+w+lp)+tau_k_SS*rk_SS*k_SS*(tau_k+rk+u+k(-1))+tau_k_SS*(y_SS*y-rk_SS*k_SS*(rk+u+k(-1))-w_SS*lp_SS*(w+lp));


// Policy functions
R = rho_R*R(-1) + (1-rho_R)*(rho_pi*inf_p+rho_y*y)+eps_m; 

// Fiscal Policy Rule 

tau_w= rho_w*tau_w(-1)+ (1-rho_w)*( etaWk*k(-1)+etaWb*b(-1)+etaWy*y+etaWc*c+etaWh*lp+etaWw*w+etaWI*I+etaWpi*inf_p+etaWR*R);
tau_k= rho_k*tau_k(-1)+ (1-rho_k)*( etaKk*k(-1)+etaKb*b(-1)+etaKy*y+etaKc*c+etaKh*lp+etaKw*w+etaKI*I+etaKpi*inf_p+etaKR*R);

// Exogenous Variables

cg=rho_cg*cg(-1)+eps_cg;
tr=rho_tr*tr(-1)+eps_tr;
eps_i=rho_eps_i*eps_i(-1)+e_i;
eps_z=rho_eps_z*eps_z(-1)+e_z;
eps_q=rho_eps_q*eps_q(-1)+e_q;
//z_P=rho_P*z_P(-1)+e_P/((1-gamma_p)*(1-gamma_p*nbeta)/gamma_p);



Util_SS*Util=((1-h)*c_SS)^(1-sigma_c)/(1-sigma_c)*(eps_q+(1-sigma_c)/(1-h)*c-h*(1-sigma_c)/(1-h)*c(-1))-psi_l*lp_SS^(1+sigma_l)/(1+sigma_l)*((1+sigma_l)*(lp));
Welf=(1-nbeta)*Util+nbeta*Welf(+1);

//observables

y_obs=GDP-GDP(-1);
c_obs=c-c(-1);
I_obs=I-I(-1);
tr_obs=tr-tr(-1);
tax_obs=tax-tax(-1);
b_obs=b-b(-1);
g_obs=cg-cg(-1);
w_obs=w-w(-1);
l_obs=lp-lp(-1);


end; 
 
shocks; 
var e_i; stderr  0.0261 ;
var e_z; stderr 0.0064 ;
var eps_m; stderr 0.0016 ;
var e_q; stderr 0.0189  ;
var eps_cg; stderr  0.0263 ;
var eps_tr; stderr 0;//0.0494 ;
//var e_P; stderr 0;// 0.0015 ;
end; 



steady;
check;


estimated_params;


etaWk, normal_pdf,  -0.8091,  0.1630 ;
etaWb, normal_pdf, -0.0568 , 0.0486     ;
etaWy, normal_pdf,   1.7889 , 0.5867   ;
etaWc, normal_pdf, -0.3455,  0.3949;
etaWh, normal_pdf,-6.1840 , 0.4780 ;
etaWw, normal_pdf,-0.7528 , 0.6158;
etaWI, normal_pdf, -0.2179 , 0.2582 ;
etaWpi, normal_pdf,-5.2469,  0.9003   ;
etaWR, normal_pdf, 5.5651 , 0.8505   ;

etaKk, normal_pdf,  -0.3715 , 0.6508 ;
etaKb, normal_pdf, -2.3788 , 0.1330  ;
etaKy, normal_pdf,  -0.4596 , 0.5448 ;
etaKc, normal_pdf,1.7116,  0.3849 ;
etaKh, normal_pdf,  0.9508,  0.4208;
etaKw, normal_pdf,  3.7079 , 0.7443 ;
etaKI, normal_pdf,  3.5151 , 0.2365  ;
etaKpi, normal_pdf,  2.3441,  0.8985  ;
etaKR, normal_pdf, -0.5434 , 0.6652  ;

end;


varobs tau_w tau_k Welf;



identification(useautocorr=0, prior_mc=100, ar=1
//,load_ident_files=1
);

para_names=['eta_wk  ' 
                            'eta_wy  ' 
                            'eta_wc  '
                            'eta_wh  '
                            'eta_ww  '
                            'eta_wI  '
                            'eta_wp  ' 
                            'eta_wR  ' 
                            'eta_kk  '
                            'eta_ky  '
                            'eta_kc  '
                            'eta_kh  '
                            'eta_kw  '
                            'eta_kI  ' 
                            'eta_kp  '                            
                            'eta_kR  ' ];
     
load did_JJ_myself

n_autocovariances=1;

n_var=ceil(sqrt(size(JJ_save,1)/(1+n_autocovariances))); 

[num_para n_draws]=size(params_save);

Sensitivity_wrt_para=zeros(n_var,num_para,n_draws);

for i_draw=1:n_draws

JJ=JJ_save(:,:,i_draw);

param=params_save(:,i_draw);

for i=1:n_var
    
               %build picking matrix
            Pick_var=zeros((n_autocovariances)*(n_var^2)+(n_var*(n_var+1)/2),1);

            SS=zeros(n_var);
            SS(i,i)=1;
            S_vech=dyn_vech(SS);
            Pick_var(1:(n_var*(n_var+1)/2))=S_vech;
            for ii=1:n_autocovariances
                Pick_var(1+(n_var*(n_var+1)/2)+(ii-1)*n_var^2:(n_var*(n_var+1)/2)+ii*n_var^2)=SS(:);
            end
            
            mom_pick=find(Pick_var);
            %J_T=JJ_T(:,:,i_draws)';
            var_J=JJ(mom_pick,:,1);
            var_J=var_J./repmat(moments_save(mom_pick,i_draw),1,num_para);
            
            for j_para=1:num_para
                
                Sensitivity_wrt_para(i,j_para,i_draw)=norm(var_J(:,j_para)*param(j_para));
                
            end
            
            
            
            
end


end
    
save('sensitivity_results.mat','Sensitivity_wrt_para','para_names');