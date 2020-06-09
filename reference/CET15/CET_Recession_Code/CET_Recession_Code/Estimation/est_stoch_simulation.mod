resid;
steady;
check;  
 

shocks; 
var epsR_eps        = 1; //monetary policy
var muz_eps         = 1; //neutral tech.
var mupsi_eps       = 1; //invest. tech.
end;    


///////////////////////////////////////////////////////////////////////////
////////////Observed variables (irrelevant for impulse response matching///
///////////////////////////////////////////////////////////////////////////
varobs yR; //check out data.m. We just pass-on random data to prevent Dynare
           //from getting stuck here. VAR impulse response data is loaded and 
           //handled below.


//add folder with modified Dynare functions and utilities
addpath('DynareUtilites');

/////////////////////////////////////////////////////////////////
// *** estim params priors begin ****////////////////////////////
/////////////////////////////////////////////////////////////////
estimated_params; 
xi,,,,beta_pdf,0.66,0.15; 
lambda,,1.001,,gamma_pdf,1.2,0.05;

rhoR,,,,beta_pdf,0.75,0.15; 
rpi ,,,,gamma_pdf,1.7,0.1; 
rdeltay ,,,,gamma_pdf,0.2,0.05; 

b,,,,beta_pdf,0.66,0.1; 
sigmaa,0.076,,,gamma_pdf,0.5,0.4; 
Spp,,,,normal_pdf,2,.5; 
alfa,.25,,,beta_pdf,0.33,0.025;
thetaG,.1,,,beta_pdf,0.5,0.2;

deltapercent,,,,gamma_pdf,0.25,0.1;  
DSHARE,,,,beta_pdf,0.25,0.1;  
recSHAREpercent,0.5,,,gamma_pdf,1,0.3; 
sigma,,,,beta_pdf,0.5,0.1; 

s,,,,beta_pdf,0.85,0.05; 
phiL,,,,normal_pdf,1,0.5; 
 
sig_epsR,,,,gamma_pdf,0.65,.05;   
rhomupsi,,,,beta_pdf,0.75,0.1; 
sig_mupsi,,,,gamma_pdf,0.1,.05;
  
rhomuz,,,,beta_pdf,0.5,0.065; 
sig_muz,,,,gamma_pdf,0.15,0.035; 
rhomuzT,,,,beta_pdf,0.75,0.065; 
sigmuzTPratio,,,,gamma_pdf,6,.45;

nuf,,,,beta_pdf,0.5,0.2;
end;  
    

estimated_params_init;
                 xi, 0.715252752966040;
             lambda, 1.313842395834855;
               rhoR, 0.781114974671637;
                rpi, 1.647971827854633;
            rdeltay, 0.206212666783536;
                  b, 0.928568260134543;
             sigmaa, 0.039012622528900;
                Spp, 2;%11.51621201685;
               alfa, 0.223515490582441;
             thetaG, 0.127868883726261;
       deltapercent, 0.131027823657360;
             DSHARE, 0.337444328290512;
    recSHAREpercent, 0.466659200995033;
              sigma, 0.532959443654565;
                  s, 0.866459626206860;
               phiL, 1.379271235614958;
           sig_epsR, 0.667017113049596;
           rhomupsi, 0.709206284818965;
          sig_mupsi, 0.112864434965684;
             rhomuz, 0.796939763525783;
            sig_muz, 0.033444721665126;
            rhomuzT, 0.903478257234313;
      sigmuzTPratio, 4.782573660092564;
                nuf, 0.730159613926600;
end; 
 
///////////////////////////////////////////////////////////////////////////////////////////////////////
//BEGINNING OF ESTIMATION//////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
do_imp_resp_matching=1;                  %if =1, model estimated based on VAR impulse responses
if do_imp_resp_matching==1,
   addpath('DynareImpRespMatching');     %path with adjusted DYNARE functions   
   get_VAR_resp;                         %get VAR impulse responses
end 

///////////////////////////////////////////////////////////////////////////////////////////
//////Options//////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////    
@#define do_mode=0
@#define do_mean=1
@#define do_mcmc=0

 
options_.do_use_csminwel_iteratively=1;  
options_.prior_trunc=1e-14;
options_.mh_conf_sig= 0.95;
options_.prior_interval= 0.95;
options_.conf_sig= 0.95;


//posterior mode estimation
@#if do_mode==1
    estimation(first_obs=1,datafile=data,order=1,nograph,lik_init=1,mode_compute=0,mode_file=cet_mode,mh_replic=0);
    load cet_mode.mat;
    for ii=1:1:length(xparam1)
        para_idx=loc(M_.param_names,char(parameter_names(ii)));
        M_.params(para_idx)=xparam1(ii);
    end 
@#endif         

//run mcmc
@#if do_mcmc==1
    estimation(first_obs=1,datafile=data,order=1,lik_init=1,mode_compute=0,mode_file=cet_mode,
          mh_replic=500000,mh_nblocks=1,mh_init_scale=0.1,mh_jscale=0.4,mh_drop=0.2,bayesian_irf) GDPAGG piAGG RAGG ukAGG lAGG wAGG cAGG iAGG pinvestAGG unempAGG vTotAGG LAGG fAGG muF mupsiF;  
    //,mode_check,nograph,load_mh_file,

    load cet_mode.mat; %to get parameter names
    for ii=1:1:length(oo_.posterior.metropolis.mean)
        para_idx=loc(M_.param_names,char(parameter_names(ii)));
        M_.params(para_idx)=oo_.posterior.metropolis.mean(ii);
    end
@#endif 


//display results at posterior mean
@#if do_mean==1
    //Watch out: mean parameters are loaded (cet_mean.mat) while command window
    //table with estimated parameters writes posterior mode (Dynare default).
    estimation(first_obs=1,datafile=data,order=1,nograph,lik_init=1,mode_compute=0,mode_file=cet_mean,mh_replic=0);

    load cet_mode.mat; //to get parameter_names
    load cet_mean.mat; //load mean parameters
    for ii=1:1:length(xparam1)
        para_idx=loc(M_.param_names,char(parameter_names(ii)));
        M_.params(para_idx)=xparam1(ii);
    end 
@#endif



//call steady state
cet_steadystate([],[],1);
check;

//plot VAR vs. Model resp.
stoch_simul(order=1,irf=40,nomoments,nocorr,nograph,noprint);

stack_model_responses;
model_resp_mon_baseline=model_resp_mon;model_resp_ntech_baseline=model_resp_ntech;model_resp_itech_baseline=model_resp_itech;

if options_.bayesian_irf==1
    model_resp_mon_HPDinf_baseline=model_resp_mon_HPDinf;model_resp_mon_HPDsup_baseline=model_resp_mon_HPDsup;model_resp_mon_Mean_baseline=model_resp_mon_Mean;
    model_resp_ntech_HPDinf_baseline=model_resp_ntech_HPDinf;model_resp_ntech_HPDsup_baseline=model_resp_ntech_HPDsup;model_resp_ntech_Mean_baseline=model_resp_ntech_Mean;
    model_resp_itech_HPDinf_baseline=model_resp_itech_HPDinf;model_resp_itech_HPDsup_baseline=model_resp_itech_HPDsup;model_resp_itech_Mean_baseline=model_resp_itech_Mean;
end

do_perturb=0;
plot_var_model_irf; 


save allresults
 
 


 

