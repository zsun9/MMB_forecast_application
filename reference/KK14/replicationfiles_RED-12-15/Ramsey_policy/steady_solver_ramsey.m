function [err]=steady_solver_ramsey(x0)

global M_ oo_ bounds_low bounds_up

NumberOfParameters = M_.param_nbr;                            % Number of deep parameters.
for i = 1:NumberOfParameters                                  % Loop...
  paramname = deblank(M_.param_names(i,:));                   %    Get the name of parameter i. 
  eval([ paramname ' = M_.params(' int2str(i) ');']);         %    Get the value of parameter i.
end  

tau_k_SS=x0(1);  % steady state capital tax rate
tau_w_SS=x0(2);  % steady state labor tax rate
%%para_tauc=.19;  % steady state consumption tax rate
%para_tauw=x0(1); 
%tau_k_SS=0;
%x0=[tau_k_SS;tau_w_SS];

if any(bounds_low>x0)|| any (bounds_up<x0) ||any (x0==0)
    
    err=1e8;
    return;
end

%  sigma_c=2; 
% h=0.7;      
% nbeta=0.9926;    
% sigma_l=2; 
% psi_l=1;
% 
% sigma_u=0.1;  
% nu=4;   
% gamma_p=0.75;
% theta_p=11;
% gamma_w=0.75;
% theta_w=11;
% 
% 
% nalpha=0.30;   
% delta=0.025;  
% by=0.4;     
% cgy=0.165;
% 
% rho_cg=0.85;   
% rho_tr=0.85; 
% rho_eps_i=.85;
% rho_eps_z=.85;
% rho_R=0.8;   
% rho_pi=1.5; 
% rho_y=0.125;  
% 
% 
% rho_w=0.9;   
% eta_w=0.5;   
% rho_k=0.9;   
% eta_k=0.5;  
% 
% tau_k_SS=0.3;
% tau_w_SS=0.2;
% para_growth=0.005;   

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


[ys,check] = model_optimal_steadystate;


   oo_.steady_state=ys;
    
  
      
      
        
 %[oo_.dr, info] = resol(oo_.steady_state,0);

     
     err=max(abs(feval([M_.fname '_static'],...
 			       oo_.steady_state,...
 			       [oo_.exo_steady_state; ...
 		    oo_.exo_det_steady_state], M_.params)));
        
    check_b=b_SS/y_SS/4  
 
    if check_b<0 || check_b>1
      err=err+1000;
    end
        
%if  info(1)>0 %|| trans_SS <0
     
 %   err=err+10;     

 %end
       
 %if   trans_SS<0
     
  %   err=err+20;     

% end
       