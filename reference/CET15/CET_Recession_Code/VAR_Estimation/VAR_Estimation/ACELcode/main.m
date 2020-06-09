clear all;
close all;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program can be used to reproduce key features of the results in 
% Altig, Christiano, Eichenbaum and Linde, Firm-Specific Capital, Nominal Rigidities and the Business Cycle (ACEL)
% The program also allows the user to explore robustness of the results
% reported in ACEL to alternative specifications.

                                        %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
                                        %   User-controlled Paramaters             %
                                        %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

%
%   Parameters pertaining to construction of data for the VAR analysis
%   

vver        = 1;     % Set to 0 if using MATLAB version 6.5, to 1 for MATLAB 7
period      = 1;     % if 1, sample 1959:Q2-2001:Q4; 2, sample 1959:Q2-1979:Q4; 3, sample 1980:Q1-2001:Q4; 4, sample 1982:Q1-2001:Q4    
money       = 1;     % if 1, use MZM as measure of money, otherwise use M2
pinvestment = 1;     % if 1 use investment deflator for pi, otherwise use price of equipment
FR          = 0;     % if 0, use benchmark data, with P16 for population; if 1, use Francis and Ramey's measure of population instead 
                     %      of P16; if 2, detrend the measure of per capita hours that results from using the FR population measure
sm          = 0;     % if 1, replace whatever measure of population being used by its HP trend
product     = 0;     % if 0, use labor productivity in benchmark dataset, if 1 use non-farm business labor productivity
                     % if 2, use business labor productivity (data from Francis and Ramey)
hours       = 0;     % if 0, use benchmark dataset (ie., use non-farm business hours); 1 use benchmark data set with business hours

%
%   parameters pertaining to estimated VAR
%

estvar      = 1;     % Set to 1 if you want to estimate the ACEL VAR.
nsteps      = 20;    % If estvar = 1, this controls number of steps out to compute impulse responses
nlags       = 4;     % If estvar = 1, this controls number of lags in VAR
hascon      = 1;     % If estvar = 1, if unity, include constant term in VAR

%
%   parameters for plotting information about policy shock
%

ish         = 0;     % If estvar = 1, if unity, plot features of isth identified disturbance
is          = 9;     % If estvar = 1, ish = 1; disturbance whose properties should be plotted (suggested: policy shock, is=9)
nl          = 3;     % If estvar = 1, ish = 1; leads and lags to use in centered moving average for disturbance to be plotted (suggested: 3)

%
%  parameters related to bootstrapping various objects from VAR
%

imp         = 1;     % If estvar = 1, compute impulse resp funcs, variance decomps, multivariate q-stats and  
                     %     use the bootstrap to compute the sampling uncertainty in all these objects. Also, graph the
                     %     response of the variables to the three identified shocks: neutral and embodied technology
                     %     shocks, and policy shocks. Finally, store the results of the calculations for later use.
vardecomp   = 0;     % If estvar = 1, if unity, compute and print out point estimates of variance decompositions
                     %     results are printed to Scientific Word file, table.tex
decomp      = 0;     % If estvar = 1, if unity, plot decomposition of historical data in terms of fundamental shocks

ndraws      =10;   % If estvar = 1, imp = 1; number of artificial data sets to use in bootstrapping
PortmanteauLags = [4 6 8 10];%If estvar = 1, imp=1; var lag lengths for which multivariate q statistics are desired
a           = 8;     % If estvar = 1, (imp = 1 or vardecomp = 1, or ish = 1); component with shortest period for band pass filter to let through
b           = 32;    % If estvar = 1, (imp = 1 or vardecomp = 1, or ish = 1); component with longest period for band pass filter.
lam         = 1600;  % If estvar = 1, (imp = 1 or vardecomp = 1, or ish = 1); parameter for HP filter.
simm        = 0;     % If estvar = 1, ish = 1; do experiments on time-domain procedure for computing variance decompositions

%
%  parameters pertaining to the equilibrium model
%                    
                    
firmspecific  = 1;   % If 1, compute the value of ksip implied by the firm-specific model and parameter values specified below.

mimp          = 0;   % Graph model impulse responses (model params are in getparam.m, verify that MATLAB paths in setpath.m is correct)                   
                   

estimatemodel = 0;   % If 1, estimate the general equilibrium model. The optimized model parameters can be found in estimate.m. To
                     %        see the contents of this file, enter 'type estimate.m' at the MATLAB command prompt after optimization 
                     %        is complete. Inputs for estimation include initial parameters (in getparams.m, or can be overwritten as
                     %        indicated below). Other inputs include VAR impulse responses and sampling uncertainty, which are produced
                     %        by running with imp = 1, estvar = 1 the first time. The information is stored for later
                     %        runs in .mat files (see loadreducedform.m for more information.)
                     
maxx=10;            %Number of iterations (could be zero) for model estimation (irrelevant if estimatemodel not equal to 1)
                
                     
stderr        = 0;   % Only relevant if estimatemodel = 1. If 1, then compute the standard errors of the 
                     % estimated parameters in the model (these are defined
                     % in file setup.m).
                     
criterion     = 0;   % Only relevant if estimatemodel = 1. 
                     %If 0, use all three shocks in the estimation criterion. 
                     %If 1, use only the monetary policy shock.
                     %If 2, use only the embodied technology shock.
                     %If 3, use only the neutral technology shock.

                                      %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
                                      %   End of User-controlled Parameters      %
                                      %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if product > 0 && criterion > 0
    error('fatal (main) bad values for product and criterion')
end
%%%%%%%%%%%%%%%%%%%%%%%%
%   Read in the DATA   %
%%%%%%%%%%%%%%%%%%%%%%%%

%set vver to the version of MATLAB you are using...vver = 1 for version 7,
%and vver = 0 for version 6.5.

[vardata] = getdata(pinvestment,money,period,FR,sm,product,hours,vver);

%vardata(:,3)=vardata(:,3)*4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Estimate The VAR, if you want to    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if estvar == 1 || decomp ==1 || vardecomp == 1
    nvars   = size(vardata,2);
    %   identify a price of investment shock, a tech shock and a fed funds shock. (Fed Funds is the 9th variable in the VAR.)
    ffshk = 9;
    [impzout,vdout,simdataout,erzout,azeroout,a0betazout,var_explode,V,D] = mkimplrnew(vardata,nlags,nsteps,hascon,[],[],ffshk,'sortlp',1);
end
%mkimplrnew produces:
%Azeroout*y(t) = A(L)* y(t-1) + erzout(t), erzout has var covar matrix, V
%a0betazout=inv(Azeroout)*A(L)

%write the system as 
%y(t) = a0betazout*y(t-1) + C * erzz(t), erzz has var covar matrix, I.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   analysis of shock is (is=9 corresponds to policy), if ish = 1   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ish == 1 && period == 1
    [Il,Iu] = shockanalysis(is,erzout,nl,nlags);
end
%print -deps c:\sw20\docs\acel\may2004\figureshocks

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   go after impulse response functions, if imp = 1   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if imp == 1
    %   Compute Bootstrap confidence intervals for impulse response functions and graph the results
    %   output is saved to var20pi_yunits.mat and compare20pi_yunits.mat
    %PortStatData 3xlength(PortmanteauLags) vector with the actual statistics in the first row, asymptotic p-value in second, and dof in third 
    %PortStatSim ndrawsxlength(PortmanteauLags) matrix with the simulated statistics
    %see documentation on getvardecomp.m for a definition of the output of
    %gimpulses
    [EtechtabStd,NtechtabStd,montabStd,alltabStd,histhpStd,histbpStd,PortStatData,PortStatSim,...
            Etechtabmean,Ntechtabmean,montabmean,alltabmean,histhpmean,histbpmean] ...
        =gimpulses(vardata,impzout,nlags,nsteps,hascon,ffshk,ndraws,PortmanteauLags,a,b,lam);
    save decomp EtechtabStd NtechtabStd montabStd alltabStd histhpStd histbpStd PortStatData PortStatSim ...
        Etechtabmean Ntechtabmean montabmean alltabmean histhpmean histbpmean    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute the variance decompositions and print them in Scientific-word-readable form, if you want them (if so, must have imp=1   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if vardecomp == 1
    %want to isolate frequencies of oscillation with period a to frequencies of
    %oscillation with period b.
    %lam is the parameter in the HP filter
    [Etechtab,Ntechtab,montab,alltab,histhp,histbp,varnamz,hornmz] = getvardecomp(a,b,lam,simdataout,vdout,erzout,azeroout,a0betazout);
    printboot(Etechtab,Ntechtab,montab,histhp,histbp,ndraws,vardata,PortmanteauLags,nlags);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% graph the historical decompositions in terms of shocks, if decomp = 0  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if decomp == 1
    %  Graph historical decompositions of data, in terms of shocks
    gethistorical(simdataout);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% do experiments simulating the time-domain procedure for computing variance decompositions %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if simm == 1
    simulatetimedecomp(a0betazout,azeroout,erzout,a,b,lam,Il,Iu,nlags);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute impulse response functions from the model and compare them with the var estimated impulses %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if mimp==1
    
    %make sure that the MATLAB path includes subdirectories for software
    setpath
    
    %go and retrieve the model parameters
    getparams
    
    taux=[1 2 4 5 8 10 14 16];%The variables chosen before the realization of the current period monetary policy shock
                     %Explanation: 
                     %      All variables in the model are chosen after the current period technology shocks. Some of the 
                     %      variables are chosen before the current period monetary policy shock.
                     %      To compute the equilibrium of the model, it is necessary to list the variables that
                     %      are chosen before the technology shock.  
                     %      For this, it is convenient to associate each variable with a number.
                     %      In computing the equilibrium, 16 variables are solved for. Their names
                     %      and numbers are (in the case of variables that grow in steady state, it is
                     %      actually the scaled variable that is solved for):
                     %      (1) consumption;(2) real wage;(3) marginal utility of consumption;(4)
                     %      real, beginning-of-period monetary base; (5) inflation; (6) base growth; 
                     %      (7) real marginal cost; (8) investment; (9) hours worked; 
                     %      (10) end-of-period capital; (11) real transactions balances; (12) aggregate goods output; 
                     %      (13) nominal rate of interest; (14) real, date t price of end-of-period 
                     %      capital (i.e., Tobin's q); (15) shadow rental rate of capital; 
                     %      (16) rate of capital utilization 
                     %      Enter the numbers of the variables chosen before the monetary policy shock into taux. The
                     %      setting for taux in the ACEL paper is taux=[1 2 4 5 8 10 14 16]
                     %      Unfortunately, the code is currently not set up to allow flexible changes taux 
                     
    %load up some data pertaining to the var, for graphing purposes
    load var20pi_yunits.mat;
    load compare20pi_yunits.mat%
    
    warning off MATLAB:eigs:TooManyRequestedEigsForComplexNonsym
    
    %if unity, then perform various checks when solving the model
    chk=0;
    
    %xi_w=0.01;
    %gam=10000;
    [modirf1,modirf2,modirf3] = solveandsimulate(alph,b,bet,delta,epsilon,eta,lambda_f,lambda_w,mu_ups,mu_z,nu,psi_L, ...
        sigma_L,x,xi_w,V,chk, ...
        kappa,sigma_a,gam,squig,vartheta,rho_M,theta_M,rho_muz,theta_muz,c_z,cp_z,rho_xz,rho_muups,theta_muups,c_ups,cp_ups,rho_xups, ...
        taux,sig_muups,sig_muz,sig_M);
    
    %if you assign a different value to one of the model parameters at this
    %point (i.e., the inputs to solveandsimulate.m) the model impulses for
    %both parameterizations will be graphed
    
    %sigma_a=.00001;
    %kappa=.1;
    %xi_w=.001;
    %c_z=0;
    %cp_z=0;
    %c_ups=0;
    %cp_ups=0;
    %gam=10000;
    %lambda_f=2.05;
    %b=.01;
    
    [modirf1_f,modirf2_f,modirf3_f] = solveandsimulate(alph,b,bet,delta,epsilon,eta,lambda_f,lambda_w,mu_ups,mu_z,nu,psi_L, ...
        sigma_L,x,xi_w,V,chk, ...
        kappa,sigma_a,gam,squig,vartheta,rho_M,theta_M,rho_muz,theta_muz,c_z,cp_z,rho_xz,rho_muups,theta_muups,c_ups,cp_ups,rho_xups, ...
        taux,sig_muups,sig_muz,sig_M);

    %graph the impulse response functions of the model, as well as the
    %estimated ones from the VAR
    plotall%execute this if you want to see impulse responses of all model variables (lot's of output!)
    %plotsome%this is to just see a subset of variables
    
%     xi_w=0.7234;
%     gam=10000;
% 
%     [modirf1_ff,modirf2_ff,modirf3_ff] = solveandsimulate(alph,b,bet,delta,epsilon,eta,lambda_f,lambda_w,mu_ups,mu_z,nu,psi_L, ...
%         sigma_L,x,xi_w,V,chk, ...
%         kappa,sigma_a,gam,squig,vartheta,rho_M,theta_M,rho_muz,theta_muz,c_z,cp_z,rho_xz,rho_muups,theta_muups,c_ups,cp_ups,rho_xups, ...
%         taux,sig_muups,sig_muz,sig_M);
% 
%     plotmoney
 
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% estimate the DSGE model using the impulse responses computed with estvar = 1, and the associated standard deviations from imp = 1 %
% these are stored in *.mat files, so they need not be rerun unless you want to change the settings                                 % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if estimatemodel == 1
    
    %make sure the MATLAB path contains the appropriate directory:
    setpath 
    %variables chosen before the current period realization of the monetary
    %policy shock (for explanation, see above):
    taux=[1 2 4 5 8 10 14 16];
    % Model Parameters
    getparams
    %Inside the following program you can determine what parameters are to
    %be estimated and which are to be fixed. In the case of the parameters
    %to be estimated, you can indicate if they should be constrained to be
    %positive or to lie inside the unit circle, etc.
    setup
    %organize the parameters between the ones to be estimated (they are
    %placed in xx) and to be fixed (they are placed in par). To see what
    %the contents of xx and par are, look inside do.m
    do
    %Initial conditions for the parameters to be estimated are set in getparams
    %By setting pp=1 you can introduce some code here to over-ride those
    %initial conditions. Program adjust.m contains the pre-set code necessary to 
    %run all the cases reported in the paper. (Follow the instructions
    %there carefully).
    %If you're not interested in adjust.m, then just
    %enter the parameter values you want in the line right after 'adjust'.
    
    pp=0;
    if pp == 1
        adjust
    end

    taux=[1 2 4 5 8 10 14 16];%equations with limited information
        
    [yy] = goestimate(xx,par,maxx,stderr,nsteps,name,II,criterion,taux,FR,product,hours,nlags,ndraws);
    xx=yy;

    chk=0;
    makeplots

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute the value of ksip implied by the firm specific capital version of the model                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if firmspecific == 1
    
    alt=1;%if 0, use the model parameters in getparams (these are probably the benchmark parameters). Otherwise, you can supply your own
    if alt == 0
        getparams
    elseif alt ==1%estimate.m contains model parameters produced during the most recent run with estimatemodel == 1
        estimate
    end
    %lambda_f=1.20;
    %sigma_a=.01;
    ksiet=.98;
    ksiep=.98;
    [ksip,ksiph,kap1,kap2,kap3,kap4,kap5,psi0,psi1,psi2,psi3] = ...
        findksip(gam,lambda_f,lambda_w,mu_ups,mu_z,bet,delta,eta,b,sigma_L,psi_L,V,nu,x,epsilon,alph,sigma_a,kappa,ksiet,ksiep);
    
    sprintf(' gam = %5.3f, ksip under firm-specific capital model = %4.2f, the associated duration is %4.2f',gam,ksip,1/(1-ksip))
    sprintf('              ksip under homogeneous capital model = %4.2f, the associated duration is %4.2f ',ksiph,1/(1-ksiph))
    cross_section
        
end