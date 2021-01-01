function setparams

global M_

NumberOfParameters = M_.param_nbr;                            % Number of deep parameters.
for i = 1:NumberOfParameters                                  % Loop...
  paramname = deblank(M_.param_names(i,:));                   %    Get the name of parameter i. 
  eval([ paramname ' = M_.params(' int2str(i) ');']);         %    Get the value of parameter i.
end  
 

%% Calibrated Parameter
  
theta_p=6;
theta_w=11;
  

R_SS=1.013;       
cgy=0.085;          
tr_o_y=0.105;       
nbeta=0.9935;       
nalpha=0.36;      
delta=0.025;  

%% Optimal steady state Tax rates


tau_k_SS=    -0.152317467790574;
tau_w_SS=    0.394496355651328;

  
%% Deep Parameters at the posterior Mean
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

%xi_w=0;
%xi_p=0;

xi_w=0;
xi_p=0 ;


rho_R=0.8321;  
rho_pi=1.9286; 
rho_y=0.0289 ;  


rho_w=0.9;   
eta_w=0.5;   
rho_k=0.9;   
eta_k=0.5;  
   



  
     
    
  
   
 NumberOfParameters = M_.param_nbr;
         for i = 1:NumberOfParameters
             paramname = deblank(M_.param_names(i,:));
             eval(['M_.params(' int2str(i) ')=' paramname ';']);
            
         end
         
         %
%% calculating parameter with steady state

[ inf_p_SS,inf_w_SS, u_SS, s_SS, s_foc_SS, q_SS, psi_u_SS, R_SS, mc_SS, rk_SS, psi_u_foc_SS, w_SS, lp_SS, k_SS,  ...  
  y_SS, I_SS,  b_SS, cg_SS, c_SS, tax_SS, chi_SS, Util_SS, Welf_SS, eps_i_SS, eps_z_SS, eps_q_SS, Kw_SS, Fw_SS,  ...  
  w_star_SS, wplusU_SS, pplus_SS, Kp_SS, Fp_SS, p_star_SS, wplus_SS, tr_SS,FC, psi_l, z_P_SS]=model_calc_steadystate;


inf_SS=inf_p_SS;

NumberOfParameters = M_.param_nbr;
        for i = 1:NumberOfParameters
            paramname = deblank(M_.param_names(i,:));
            eval(['M_.params(' int2str(i) ')=' paramname ';']);
        end

 



[ lmult1_SS,  lmult2_SS,  lmult3_SS,  lmult4_SS,  lmult5_SS, ...  
           lmult6_SS,  lmult7_SS,  lmult8_SS,  lmult9_SS,  lmult10_SS, ...  
           lmult11_SS,  lmult12_SS,  lmult13_SS,  lmult14_SS,  lmult15_SS, ...  
           lmult16_SS,  lmult17_SS,  lmult18_SS,  lmult19_SS,  lmult20_SS, ...  
           lmult21_SS,  lmult22_SS,  lmult23_SS,  lmult24_SS,  lmult25_SS, ...  
           lmult26_SS,  lmult27_SS,  lmult28_SS,  lmult35_SS] = model_SS_fiscal_lmss;


NumberOfParameters = M_.param_nbr;
        for i = 1:NumberOfParameters
            paramname = deblank(M_.param_names(i,:));
            eval(['M_.params(' int2str(i) ')=' paramname ';']);
         
        end

 
	

