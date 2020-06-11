function [alpha_0,alpha_1,alpha_2,beta_0,beta_1,params_mat,tau,rho] = ...
    getlinear(params_ss,kappa,sigma_a,gamma,squig,vartheta,rho_M,theta_M,rho_muz,theta_muz,c_z,cp_z,rho_xz,rho_muups,theta_muups,c_ups,cp_ups,rho_xups,steady)

params_mat  =   [params_ss,kappa,sigma_a,gamma,squig,vartheta,rho_M,theta_M,rho_muz,theta_muz,c_z,cp_z,rho_xz,rho_muups,theta_muups,c_ups,cp_ups,rho_xups];
[alpha_0,alpha_1,alpha_2,beta_0,beta_1,rho,tau]  =   makematrices(params_mat,steady);