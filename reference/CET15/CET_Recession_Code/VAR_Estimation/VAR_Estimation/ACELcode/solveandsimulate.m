function [modirf1,modirf2,modirf3] = solveandsimulate(alph,b,bet,delta,epsilon,eta,lambda_f,lambda_w,mu_ups,mu_z,nu,psi_L, ...
    sigma_L,x,xi_w,V,chk, ...
    kappa,sigma_a,gam,squig,vartheta,rho_M,theta_M,rho_muz,theta_muz,c_z,cp_z,rho_xz,rho_muups,theta_muups,c_ups,cp_ups,rho_xups, ...
    taux,sig_muups,sig_muz,sig_M)

% Steady state:

[mu_zstar,rhotilde,infl,R,eta_pr,sig_eta,s,R_nu,wtilde,kbar,h,c,q,m,ytilde,phi,i,params_ss,steady,lambda_zstar,mutilde,stst] = ...
    getsteady(alph,b,bet,delta,epsilon,eta,lambda_f,lambda_w,mu_ups,mu_z,nu,psi_L,sigma_L,x,xi_w,V,chk);

%get the parameters of the linearized canonical form:

[alpha_0,alpha_1,alpha_2,beta_0,beta_1,params_mat,tau,P] = ...
    getlinear(params_ss,kappa,sigma_a,gam,squig,vartheta,rho_M,theta_M,rho_muz,theta_muz,c_z,cp_z,rho_xz,rho_muups, ...
    theta_muups,c_ups,cp_ups,rho_xups,steady);

%check that analytic and numerical derivatives coincide
 if chk==1;checkderiv;end

%find the policy rule that solves the model
%First, find (and check) the feedback part, A
alphas   = [ alpha_0, alpha_1, alpha_2];

AIM=1;
if AIM == 1
    %New version of AIM, produce same answer but much faster
    condn  = 10^(-10); %condition used by AIM if a matrix does not invert, not important here
    uprbnd = 0.99999;  %largest eigenvalue of the feedback matrix, allowed to be slightly above unity
    hmat =[alpha_2,alpha_1,alpha_0]; % Aim uses this order of alphas.
    
    [A,ErrFlagVal] = feedback(alphas,hmat,condn,uprbnd);
    
else
    
    [A] = findandcheckA(alphas,alpha_2,alpha_1,alpha_0);
    
end
%Now, find (and check, if chk=1 in findB.m) the feedforward part:

[B,rho] = findB(P,A,beta_0,beta_1,alpha_0,alpha_1,alpha_2,rho_M,theta_M,taux,chk);

% Simulating an embodied technology shock
nn              =   length(rho);
T=21;

e1              =   zeros(nn,T);
e1(6,1)         =   sig_muups;
e1(7,1)         =   sig_muups;
e1(8,1)         =   c_ups*sig_muups;
[zz1,s1]        =   simulate(A,B,rho,e1);

% Simulating a neutral technology shock

e2              =   zeros(nn,T);
e2(3,1)         =   sig_muz;
e2(4,1)         =   sig_muz;
e2(5,1)         =   c_z*sig_muz;
[zz2,s2]        =   simulate(A,B,rho,e2);

% Simulating a monetary policy shock

e3              =   zeros(nn,T);
e3(1,1)         =   sig_M;
e3(2,1)         =   sig_M;
[zz3,s3]        =   simulate(A,B,rho,e3);

modirf1     =   unscaleforplots(zz1,s1,alph,R,infl)';
modirf2     =   unscaleforplots(zz2,s2,alph,R,infl)';
modirf3     =   unscaleforplots(zz3,s3,alph,R,infl)';
