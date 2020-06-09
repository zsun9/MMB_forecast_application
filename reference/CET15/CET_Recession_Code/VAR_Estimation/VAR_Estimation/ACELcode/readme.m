%(If you run main.m at the MATLAB (7.0) command prompt, the program will go 10 iterations starting from
%the estimated benchmark parameters of the model.)

% These are the files to exectute most of the computations for the 
% project, Altig, Christiano, Eichenbaum and Linde, Firm-Specific Capital, Nominal Rigidities and the Business Cycle
% Materials relevant for this project can be found at http://www.faculty.econ.northwestern.edu/faculty/christiano/research/ACEL/acelweb.htm
% 
% There are three primary programs:
% 
% main.m - this allows you to estimate and analyze the var. Does most of the calculations
% maketables234.m - this takes the estimation results and prints them to Scientific-Word readable tables (table234.tex)
% loadreducedform.m - the bootstrap simulations in main.m to produce the inputs for estimation take a little time. 
%                     The results are prepackaged in this program.
% 
% Here are instructions for re=estimating the various versions of the model.
% 
% 1. BENCHMARK VERSION OF THE MODEL:
%
% a. run loadreducedform.m with lld=1. This ensures that the impulse responses and corresponding variance covariance matrices correspond
%    4-lag VAR estimated over the benchmark sample period with the benchmark data. 
% b. set vver=1 (or, 0 if you are using MATLAB 6.5), period = 1 (for full sample), money = 1 (use MZM for money), pinvestment = 1 (use
%    investment deflator for price of investment goods), FR =0 (use benchmark data set), sm = 0 (do not smooth population measure), 
%    product = 0 (leave labor productivity measure as it is in the benchmark data set), hours = 0 (use benchmark data set),
% 
%    estvar = 0 (do not re-estimate the var, since you have loaded in what you need in step a), nsteps = 20 (number of periods
%    for impulse response functions), nlags = 4 (number of lags in var - if you are estimating equilibrium model, this is used
%    to determine which set of initial conditions in getparams.m to use in model estimation), 
%    hascon = 1 (just information if only estimating ge model.
%    
%    ish = 0, is = 9, nl = 3 (latter two ignored if ish = 0), imp = 0 (do
%    not worry about bootstrapping var impulse response functions, since
%    they have been brought in in step a), vardecomp = 0, decomp = 0 (don't
%    worry about variance decompositions associated with var, since estvar = 0)
%    ndraws = 1000 (irrelevant if you are not bootstrapping the var), don't
%    worry about PortmanteauLags, a, b, lam, simm when not redoing the var
%    analysis.
%
%    firmspecific = 0 (set to unity if you want to execute mapping from
%    gamma and model parameters to ksip), mimp = 0 (don't need to graph
%    model impulses, which will come out anyway, after estimation), maxx =
%    5000 ( number of iterations for estimation, should initially be set to zero just to test things)
%    estimatemodel = 1 (this is the switch that says you want to estimate
%    the model), stderr = 1 (this means compute standard error of estimated
%    parameters after estimation), criterion = 0 (include all three shocks
%    in estimation criterion).
%
% c. Have a look at the code in the section of main.m that begins if estimatemodel == 1.Verify that there are no lines setting individual 
%    model parameter values in here. Set pp = 0. This will ensure that only the parameters in getparams are used. These are 
%    the parameter values that we estimated.
%
% d. Make sure setup.m is set correctly. This says which model parameters you want free and which fixed, during estimation.
%    (See instructions at the start of the file.) The settings should be:
%    
% % % II(1,1) = 1;II(1,2)=2;%rho_M  
% % % II(2,1) = 1;II(2,2)=2;%rho_xz  
% % % II(3,1) = 1;II(3,2)=5;%c_z     
% % % II(4,1) = 1;II(4,2)=2;%rho_muz 
% % % II(5,1) = 1;II(5,2)=2;%rho_xups
% % % II(6,1) = 1;II(6,2)=5;%c_ups   
% % % II(7,1) = 1;II(7,2)=2;%rho_muups
% % % II(8,1) = 1;II(8,2)=3;%sig_M    
% % % II(9,1) = 1;II(9,2)=3;%sig_muz  
% % % II(10,1) = 1;II(10,2)=3;%sig_muups
% % % II(11,1) = 1;II(11,2)=3;%epsilon  
% % % II(12,1) = 1;II(12,2)=3;%kappa    
% % % II(13,1) = 1;II(13,2)=1;%xi_w     
% % % II(14,1) = 1;II(14,2)=1;%b        
% % % II(15,1) = 0;II(15,2)=3;%psi_L    
% % % II(16,1) = 0;II(16,2)=1;%bet      
% % % II(17,1) = 0;II(17,2)=3;%mu_ups   
% % % II(18,1) = 0;II(18,2)=3;%mu_z     
% % % II(19,1) = 0;II(19,2)=1;%delta    
% % % II(20,1) = 0;II(20,2)=1;%alph     
% % % II(21,1) = 0;II(21,2)=1;%nu       
% % % II(22,1) = 0;II(22,2)=3;%psi_L    
% % % II(23,1) = 0;II(23,2)=3;%x        
% % % II(24,1) = 0;II(24,2)=3;%V        
% % % II(25,1) = 0;II(25,2)=3;%sigma_L  
% % % II(26,1) = 0;II(26,2)=4;%lambda_f 
% % % II(27,1) = 0;II(27,2)=4;%lambda_w 
% % % II(28,1) = 0;II(28,2)=2;%squig    
% % % II(29,1) = 0;II(29,2)=2;%vartheta
% % % II(30,1) = 1;II(30,2)=3;%sigma_a  
% % % II(31,1) = 0;II(31,2)=3;%eta      
% % % II(32,1) = 0;II(32,2)=5;%theta_M  
% % % II(33,1) = 1;II(33,2)=5;%cp_z     
% % % II(34,1) = 0;II(34,2)=5;%theta_muz
% % % II(35,1) = 1;II(35,2)=5;%cp_ups   
% % % II(36,1) = 0;II(36,2)=5;%theta_muups
% % % II(37,1) = 1;II(37,2)=3;%gam  
%
%
% e. Run main.m. This will initiate estimation at the parameter values we estimated in our benchmark run. The estimation
%    routine should determine that you are at the optimum. This takes a surprisingly long time. Verify that you get the same
%    function value that is reported in getparams.m. 
%
% 2. VERSION OF MODEL ESTIMATED ON IMPULSE RESPONSES FROM 6 - LAG VAR
%
% a. run loadreducedform.m with lld=2. 
% b. Same as in 1.b, except nlags = 6.
% c. Same as 1.c.
% d. Same as 1.d.
% e. Same as 1.e.
%
% 3. Version of Model With Business Labor Productivity.
% a. run loadreducedform.m with lld = 4.
% b. same as 1.b, except product = 2.
% c. Set pp = 1 in main.m. Make sure capu=0 and lamb=0 in adjust.m.
% d. Same as 1.d, except II(26,1)=1 (lambda_f is estimated freely).
% e. Same as 1.e, except you want to compare results with what is in the relevant portion of adjust.m.
%
% 4. VERSION OF THE MODEL WITH BUSINESS HOURS
% a. run loadreducedform.m with lld = 3.
% b. same as 1.b, except hours = 1.
% c. same as 3.c.
% d. same as 3.d.
% e. same as 3.e. 
%
% 5. VERSION OF MODEL WITH lambda_f RESTRICTED.
%
% a. run loadreducedform.m with lld=1, assuming it's the var (4) you want to run with.
% b. Same as in 1.b.
% c. Set the switch at the top of the file, lambdafhigh.m to get the value of lambda_f you want.
%    Set pp = 1 in main.m. Set lamb=1 in adjust.m (make sure capu=0 in adjust.m).     
% d. Same as in 1.d (i.e., make sure II(26,1)=0, so that you don't include lambda_f in the parameters to be estimated)
% e. Same as in 3.e.
%
% 6. VERSION OF THE MODEL WITH sigma_a RESTRICTED.
%
% a. same as 5.a.
% b. same as 5.b.
% c. Set pp = 1 in main.m. Set lamb=0, capu=1 in adjust.m. 
% d. In setup.m, set II(26,1) = 1 (lambda_f free) and II(30,1) = 0 (sigma_a
%    restricted). 
% e. same as 1.e.
%
% 7. VERSION OF THE MODEL WHICH ONLY FOCUSES ON NEUTRAL SHOCKS.
% a. same as 1.a.
% b. same as 1.b., except criterion=3. Also, it's best to set stderr=0,
%    because the routine is unlikely to be able to compute the standard error
%    in this case. Moreover, if it can't then the program stops with the
%    user left in a keyboard command.
% c. set pp = 1 in main.m. Set lamb=0=capu in adjust.m.
% d. make sure that lambda_f and sigma_a are free in estimation, so that II(26,1)=II(30,1) = 1. 
% e. same as 1.e. I had trouble getting this to converge. The function
%    value went to 163.1124 and then very gradually and slowly got further
%    improvement without converging. I think it was driving sigma_a to
%    infinity.
% 
% 8. VERSION OF THE MODEL WHICH ONLY FOCUSES ON MONETARY POLICY SHOCKS.
%    This is the same as 7, except criterion = 1.
%
% 9. VERSION OF THE MODEL WHICH ONLY FOCUSES ON EMBODIED POLICY SHOCKS.
%    This is the same as 7, except criterion = 2.