
function [inf_p, u, s, s_foc, q, psi_u, R, mc, rk, psi_u_foc, w, lp, k, ...
            y, I,  b, cg, c, tax, chi, Util, Welf, eps_i, eps_z, eps_q, Kw, Fw, ...
            w_star, wplusU, pplus, Kp, Fp, p_star, wplus, tr,FC, psi_l] = model_calc2_steadystate
global M_ 

%% DO NOT CHANGE THIS PART.
%%
%% Here we load the values of the deep parameters in a loop.
%%
NumberOfParameters = M_.param_nbr;                            % Number of deep parameters.
for i = 1:NumberOfParameters                                  % Loop...
  paramname = deblank(M_.param_names(i,:));                   %    Get the name of parameter i. 
  eval([ paramname ' = M_.params(' int2str(i) ');']);         %    Get the value of parameter i.
end                                                           % End of the loop.  

tau_k=tau_k_SS;
tau_w=tau_w_SS;

eps_i=1; 
eps_z=1;
eps_q=1;

R=R_SS;

u=1;
s=0;
s_foc=0;
q=1;
psi_u=0;

inf_p=R*nbeta;
inf_w=inf_p;
mc=(theta_p-1)/theta_p;
rk=(1-nbeta*(1-delta))/nbeta/(1-tau_k);
psi_u_foc=rk*(1-tau_k);


w=mc^(1/(1-nalpha))*(1-nalpha)*nalpha^(nalpha/(1-nalpha))*rk^(-nalpha/(1-nalpha))*eps_z;


lk_bar=(1-nalpha)/nalpha*rk/w*u;
ckbar=(1-cgy)*(mc*u^nalpha*lk_bar^(1-nalpha))-delta-psi_u;
 


%cy=1-(delta+psi_u)*kybar-cg_o_y;
l=1/3;

psi_l=(w^(1)*(theta_w-1)/theta_w *(1-h)^(-sigma_c)*(1-tau_w)*(1-nbeta*h)*ckbar^(-sigma_c)*lk_bar^(sigma_c))/l^(sigma_c+sigma_l);
lp=l;
%k=kybar^(1/(1-nalpha))*lp*u^(nalpha/(1-nalpha));
k=lp/lk_bar;

%y=kybar^(-1)*k-FC;
FC= (1-mc)*(u*k)^nalpha*lp^(1-nalpha);
y=(u*k)^nalpha*lp^(1-nalpha)-FC;
c=ckbar*k;


I=delta*k;
d=y-rk*u*k-w*lp;


cg=y-c-I;


tax=tau_w*w*lp+tau_k*(rk*k+d);
tr=tr_o_y*y;
%tr=(nbeta-1)*b+tax-cg;
b=1/(1-1/nbeta)*(tr+cg-tax);
%tr=tr_SS;

%

chi=(c-h*c)^(-sigma_c)-h*nbeta*(c-h*c)^(-sigma_c);
Util = ( ((1-h)*c)^(1-sigma_c)/(1-sigma_c)-psi_l*l^(1+sigma_l)/(1+sigma_l));
Welf = Util/(1-nbeta); 

%% steady state calvo
pplus=1;
Fp=y*chi/(1-gamma_p*nbeta);
Kp=Fp;
p_star=1;
wplus=1;
Kw=l^(1+sigma_l)/(1-gamma_w*nbeta);
Fw=(theta_w-1)/theta_w*(1-tau_w_SS)*l*chi/(1-gamma_w*nbeta);
w_star=1;
wplusU=1;










