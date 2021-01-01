
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
inf_p=inf_SS; 
inf_w=inf_SS; 
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



c_obs=0;
I_obs=0;
y_obs=0;
inf_p_obs=0;
trans_obs=0;

tau_w_obs=0;
tau_k_obs=0;

R_obs=0;
lp_obs=0;
k_obs=0;
w_obs=0;
b_obs=0;
tr_obs=0;
tax_obs=0;
welf_obs=0;
cg_obs=0;
z_L=1;
z_P=1;

eI_obs=0;
eZ_obs=0;
eQ_obs=0;
eM_obs=0;
eC_obs=0;

NumberOfEndogenousVariables = M_.endo_nbr;                    % Number of endogenous variables.
ys = zeros(NumberOfEndogenousVariables,1);                    % Initialization of ys (steady state).
for i = 1:NumberOfEndogenousVariables                         % Loop...
  varname = deblank(M_.endo_names(i,:)); %    Get the name of endogenous variable i.                     
    
  eval(['ys(' int2str(i) ') = ' varname ';']);              %    Get the steady state value of this variable.

end   







