
function [ys,check] = model_ramsey_fiscal_steadystate(ys,exe)

global M_ oo_

%% DO NOT CHANGE THIS PART.
%%
%% Here we load the values of the deep parameters in a loop.
%%
NumberOfParameters = M_.param_nbr;                            % Number of deep parameters.
for i = 1:NumberOfParameters                                  % Loop...
  paramname = deblank(M_.param_names(i,:));                   %    Get the name of parameter i. 
  eval([ paramname ' = M_.params(' int2str(i) ');']);         %    Get the value of parameter i.
end                                                           % End of the loop.  

check=0;

tau_k=tau_k_SS; 
tau_w=tau_w_SS; 
inf_p=inf_p_SS; 
inf_w=inf_w_SS; 
u=u_SS; 
s=s_SS; 
s_foc=s_foc_SS; 
q=q_SS; 
psi_u=psi_u_SS; 
R=R_SS; 
mc=mc_SS; 
rk=rk_SS; 
psi_u_foc=psi_u_foc_SS; 
w=w_SS; 
lp=lp_SS; 
k=k_SS; 
y=y_SS; 
I=I_SS; 
b=b_SS; 
cg=cg_SS; 
tr=tr_SS;
c=c_SS; 
tax=tax_SS; 
chi=chi_SS; 
Util=Util_SS; 
Welf=Welf_SS; 
eps_i=eps_i_SS; 
eps_z=eps_z_SS; 
Kw=Kw_SS; 
Fw=Fw_SS; 
w_star=w_star_SS; 
wplusU=wplusU_SS; 
pplus=pplus_SS;  
Kp=Kp_SS;  
Fp=Fp_SS;  
p_star=p_star_SS; 
wplus= wplus_SS; 
eps_q=eps_q_SS;
z_P=z_P_SS;

lmult1 = lmult1_SS; 
lmult2 = lmult2_SS; 
lmult3 = lmult3_SS; 
lmult4 = lmult4_SS; 
lmult5 = lmult5_SS; 
lmult6 = lmult6_SS; 
lmult7 = lmult7_SS; 
lmult8 = lmult8_SS; 
lmult9 = lmult9_SS; 
lmult10 = lmult10_SS; 
lmult11 = lmult11_SS; 
lmult12 = lmult12_SS; 
lmult13 = lmult13_SS; 
lmult14 = lmult14_SS; 
lmult15 = lmult15_SS; 
lmult16 = lmult16_SS; 
lmult17 = lmult17_SS; 
lmult18 = lmult18_SS; 
lmult19 = lmult19_SS; 
lmult20 = lmult20_SS; 
lmult21 = lmult21_SS; 
lmult22 = lmult22_SS; 
lmult23 = lmult23_SS; 
lmult24 = lmult24_SS; 
lmult25 = lmult25_SS; 
lmult26 = lmult26_SS; 
lmult27 = lmult27_SS; 
lmult28 = lmult28_SS; 
lmult35 = lmult35_SS; 

 %%% simple Rules
tau_k_c=tau_k_SS; 
tau_w_c=tau_w_SS; 
inf_p_c=inf_p_SS; 
inf_w_c=inf_w_SS; 
u_c=u_SS; 
s_c=s_SS; 
s_foc_c=s_foc_SS; 
q_c=q_SS; 
psi_u_c=psi_u_SS; 
R_c=R_SS; 
mc_c=mc_SS; 
rk_c=rk_SS; 
psi_u_foc_c=psi_u_foc_SS; 
w_c=w_SS; 
lp_c=lp_SS; 
k_c=k_SS; 
y_c=y_SS; 
I_c=I_SS; 
b_c=b_SS; 
c_c=c_SS; 
tax_c=tax_SS; 
chi_c=chi_SS; 
Util_c=Util_SS; 
Welf_c=Welf_SS; 
Kw_c=Kw_SS; 
Fw_c=Fw_SS; 
w_star_c=w_star_SS; 
wplusU_c=wplusU_SS; 
pplus_c=pplus_SS;  
Kp_c=Kp_SS;  
Fp_c=Fp_SS;  
p_star_c=p_star_SS; 
wplus_c= wplus_SS; 


Util_Lc =psi_l*lp_c^(1+sigma_l)/(1+sigma_l);
Welf_Lc = Util_Lc/(1-nbeta); 

WL=((Welf+Welf_Lc)/(Welf_c+Welf_Lc))^(1/(1-sigma_c))-1;


NumberOfEndogenousVariables = M_.endo_nbr;                    % Number of endogenous variables.
ys = zeros(NumberOfEndogenousVariables,1);                    % Initialization of ys (steady state).
for i = 1:NumberOfEndogenousVariables                         % Loop...
  varname = deblank(M_.endo_names(i,:)); %    Get the name of endogenous variable i.                     
    
  eval(['ys(' int2str(i) ') = ' varname ';']);              %    Get the steady state value of this variable.

end   




