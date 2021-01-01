function setparams_simple

global M_

NumberOfParameters = M_.param_nbr;                            % Number of deep parameters.
for i = 1:NumberOfParameters                                  % Loop...
  paramname = deblank(M_.param_names(i,:));                   %    Get the name of parameter i. 
  eval([ paramname ' = M_.params(' int2str(i) ');']);         %    Get the value of parameter i.
end  
 


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

  

%%% if estimation is done 
  
if exist('model_nonlinear_mode.mat')==2

    load model_nonlinear_mode
rho_w=0;
rho_k=0; 

etaWk=xparam1(1);
etaWb=xparam1(2);
etaWy=xparam1(3);
etaWc=xparam1(4);
etaWh=xparam1(5);
etaWw=xparam1(6); 
etaWI=xparam1(7);  
etaKk=xparam1(8);
etaKb=xparam1(9);
etaKy=xparam1(10);
etaKc=xparam1(11); 
etaKh= xparam1(12);
etaKw=xparam1(13);
etaKI=xparam1(14);



etaWpi=xparam1(15);
etaWR=xparam1(16);
etaKpi=xparam1(17);
etaKR=xparam1(18);


else
    

rho_w=0;
etaWk=0;
etaWb=.5;
etaWy=0;
etaWc=0;
etaWh=0;
etaWw=0; 
etaWI=0; 
etaWpi=0;
etaWR=0;


rho_k=0;  
etaKk=0;
etaKb=-.5;
etaKy=0;
etaKc=0; 
etaKh= 0;
etaKw=0;
etaKI=0;
etaKpi=0;
etaKR=0;
 
end
%%%%

NumberOfParameters = M_.param_nbr;
         for i = 1:NumberOfParameters
             paramname = deblank(M_.param_names(i,:));
             eval(['M_.params(' int2str(i) ')=' paramname ';']);
            
         end
           


[ inf_SS, u_SS, s_SS, s_foc_SS, q_SS, psi_u_SS, R_SS, mc_SS, rk_SS, psi_u_foc_SS, w_SS, lp_SS, k_SS,  ...  
  y_SS, I_SS, b_SS, cg_SS, c_SS, tax_SS, chi_SS, Util_SS, Welf_SS, eps_i_SS, eps_z_SS, eps_q_SS, Kw_SS, Fw_SS,  ...  
  w_star_SS, wplusU_SS, pplus_SS, Kp_SS, Fp_SS, p_star_SS, wplus_SS, tr_SS,FC, psi_l]=model_calc2_steadystate;



 NumberOfParameters = M_.param_nbr;
         for i = 1:NumberOfParameters
             paramname = deblank(M_.param_names(i,:));
             eval(['M_.params(' int2str(i) ')=' paramname ';']);
            
         end
         