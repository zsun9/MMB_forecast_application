///////////////////////////////////////////////////////////////////////////
//Medium-sized model of Christiano, Eichenbaum and Trabandt (2015)       //
//'Understanding the Great Recession', American Economic Journal:        //
//Macroeconomics, forthcoming                                            //
//                                                                       //
//                                                                       //
//Dynare 4.3.3 and MATLAB R2012a used for computations                   //
//                                                                       //
//                                                                       //
//This code simulates the model economy through the Great Recession      //
//taking the zero lower bound constraint into account.                   //  
//                                                                       //
//Parameters are set to MCMC posterior mean (see Estimation folder code).//
//                                                                       //
//Economy with restricted information set (see Estimation folder code)   //
//has been removed to speed up simulation.                               //
//                                                                       //
///////////////////////////////////////////////////////////////////////////


// Endogenous variables: (almost) all in logs.
var psiF cF RF piF iF pkprimeF FF KF ukF wF  
kbarF lF xF varthetF phaloF yF JF UF GDPF fF 
vF unempF VF AAF vTotF muF nGF wpF varthetpF 
eF NF LF cHF UcHF  pi4F plF OmF deltabF muzFPhat 
muzFTminusEpsFThat muzEpsFThat muzF gF taukF LcalF;

//Shocks
varexo  muz_eps varsig_eps g_eps Om_eps 
eps_switch mpol_eps;

parameters ydiffdataPercent,idiffdataPercent,alfa,rho,u,Q,sigma,
betta,lambda,deltak,nuf,kappa,b,xi,D,g,delta,gamma,Spp sigmab sigmaa 
phi rhoR rpi sigmam kappaf DSHARE deltapercent recSHAREpercent f thetaG 
pibreve varkappaf M pibar unemp_SS vTot_SS alp1 alp2 alp3 alp4 s omega 
phiL do_impose_ZLB etag F11muz F22muz F23muz L11muz L21muz L31muz chi 
rdeltay rhomuzT sigmuzT rhomuzP groot1 groot2 broot1 broot2 oroot1 
riskyworkcap horz do_load_results ini_ntech mupsi_SS;
   

model;
//set not needed exogenous variables to steady states 

//abbreviations
//investment specific technology
#mupsiF=mupsi_SS;
#mupsiF_tp1=mupsi_SS;

//capacity utilization cost
#aofukprimeF=sigmab*sigmaa*(exp(ukF))+sigmab*(1-sigmaa);
#aofukprimeF_tp1=sigmab*sigmaa*(exp(ukF(+1)))+sigmab*(1-sigmaa);
#aofukF=0.5*sigmab*sigmaa*(exp(ukF))^2+sigmab*(1-sigmaa)*exp(ukF)+sigmab*((sigmaa/2)-1);
#aofukF_tp1=0.5*sigmab*sigmaa*(exp(ukF(+1)))^2+sigmab*(1-sigmaa)*exp(ukF(+1))+sigmab*((sigmaa/2)-1);

//return on capital
#RkF_tp1=log(((exp(ukF(+1))*aofukprimeF_tp1-aofukF_tp1)+(1-deltak)*exp(pkprimeF(+1)))/(exp(pkprimeF+mupsiF_tp1-piF(+1))));

//investment adjustment cost
#StildeF=(0.5*(exp(sqrt(Spp)*(exp(iF)/exp(iF(-1))*exp(muF)*exp(mupsiF)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))+exp(-sqrt(Spp)*(exp(iF)/exp(iF(-1))*exp(muF)*exp(mupsiF)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-2));
#StildeprimeF=(0.5*sqrt(Spp)*(exp(sqrt(Spp)*(exp(iF)/exp(iF(-1))*exp(muF)*exp(mupsiF)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-exp(-sqrt(Spp)*(exp(iF)/exp(iF(-1))*exp(muF)*exp(mupsiF)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))));
#StildeprimeF_tp1=(0.5*sqrt(Spp)*(exp(sqrt(Spp)*(exp(iF(+1))/exp(iF)*exp(muF(+1))*exp(mupsiF_tp1)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-exp(-sqrt(Spp)*(exp(iF(+1))/exp(iF)*exp(muF(+1))*exp(mupsiF_tp1)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))));

//marginal cost
#mcF=alfa*mupsiF+varthetF+log(nuf*(exp(RF)*(1+taukF*riskyworkcap))+1-nuf)-log(1-alfa)-alfa*(kbarF(-1)+ukF-muF-lF); 

//price indexation (relative to inflation)
#pitildepiF=-piF+kappaf*piF(-1)+(1-kappaf-varkappaf)*log(pibar)+varkappaf*log(pibreve);
#pitildepiF_tp1=-piF(+1)+kappaf*piF+(1-kappaf-varkappaf)*log(pibar)+varkappaf*log(pibreve);

//labor force adjustment cost
#FcalF=0.5*exp(nGF)*phiL*(exp(LF)/exp(LF(-1))-1)^2;                                                               
#FcalLF=exp(nGF)*phiL*(exp(LF)/exp(LF(-1))-1)*1/exp(LF(-1));                                            
#FcalprimeLF=-exp(nGF(+1))*phiL*(exp(LF(+1))/exp(LF)-1)*exp(LF(+1))*(1/exp(LF))^2;                                

//asset pricing kernel
#mF_tp1=betta*exp(psiF(+1))/exp(psiF)*(exp(muF(+1)))^(-1); //asset pricing kernel

//composite consumption
#ctildeF=( (1-omega)*(exp(cF)-b*exp(cF(-1))/exp(muF))^chi+omega*(exp(cHF)-b*exp(cHF(-1))/exp(muF))^chi )^(1/chi); //composite consumption




//F1 - Consumption FOC
exp(psiF)=(1-omega)*(ctildeF)^(-chi)*(exp(cF)-b*exp(cF(-1))/exp(muF))^(chi-1);

//F2 - Bond FOC (Fisher equation)
1=(1+deltabF)*mF_tp1*exp(RF)/exp(piF(+1));

//F3 - Investment FOC
1=exp(pkprimeF)*(1-StildeF-StildeprimeF*exp(muF)*exp(mupsiF)*exp(iF)/exp(iF(-1)))+mF_tp1*exp(muF(+1))*exp(pkprimeF(+1))*StildeprimeF_tp1*(exp(iF(+1))/exp(iF))^2*exp(muF(+1))*exp(mupsiF_tp1);

//F4 - Capital FOC
#finwedge=(1-taukF)*(1+deltabF);
1=finwedge*mF_tp1*exp(RkF_tp1)/exp(piF(+1));

//F5 - Law of motion for physical capital
exp(kbarF)=(1-deltak)/(exp(muF)*exp(mupsiF))*exp(kbarF(-1))+(1-StildeF)*exp(iF);

//F6 - Cost minimization (opt. factor inputs)
0=aofukprimeF*exp(ukF)*exp(kbarF(-1))/(exp(muF)*exp(mupsiF))-alfa/(1-alfa)*(nuf*exp(RF)*(1+taukF*riskyworkcap)+1-nuf)*exp(lF)*exp(varthetF);

//F7 - Production
exp(yF)=exp(phaloF)^(lambda/(lambda-1))*((exp(lF))^(1-alfa)*(exp(kbarF(-1)+ukF)/(exp(muF)*exp(mupsiF)))^alfa-phi*exp(nGF)); 

//F8 - Resource Constraint
exp(yF)=exp(gF)*exp(nGF)+exp(cF)+exp(iF)+aofukF*exp(kbarF(-1))/(exp(mupsiF)*exp(muF))+kappa*exp(nGF)*exp(xF)*exp(lF(-1));

//F9 Monetary Policy Rule
#Rnot=STEADY_STATE(RF)+rpi/4*(pi4F-STEADY_STATE(pi4F))+rdeltay/4*(GDPF-GDPF(-4)+muF+muF(-1)+muF(-2)+muF(-3)-4*STEADY_STATE(muF));
#Rnot_tm1=STEADY_STATE(RF)+rpi/4*(pi4F(-1)-STEADY_STATE(pi4F))+rdeltay/4*(GDPF(-1)-GDPF(-5)+muF(-1)+muF(-2)+muF(-3)+muF(-4)-4*STEADY_STATE(muF));
RF=max(STEADY_STATE(RF)-log(1.004825),rhoR*Rnot_tm1+(1-rhoR)*Rnot+mpol_eps);

//F10 Pricing 1
exp(FF)-exp(psiF+yF)-betta*xi*exp( pitildepiF_tp1 /(1-lambda)+FF(+1));

//F11 Pricing 2 
exp(KF)-lambda*exp(psiF+yF+mcF)-betta*xi*exp( pitildepiF_tp1*lambda/(1-lambda)+KF(+1));

//F12 Pricing 3
KF-FF=(1-lambda)*log((1-xi*exp( pitildepiF /(1-lambda)))/(1-xi));

//F13  Price dispersion
exp(phaloF*lambda/(1-lambda))-(1-xi)^(1-lambda)*(1-xi*exp( pitildepiF /(1-lambda)))^lambda-xi*(exp( pitildepiF +phaloF(-1)))^(lambda/(1-lambda));

//F14 Present value of wages
-exp(wpF)+exp(wF)+rho*mF_tp1*exp(muF(+1))*exp(wpF(+1));

//F15 Present value of marginal revenue
-exp(varthetpF)+exp(varthetF)+rho*mF_tp1*exp(muF(+1))*exp(varthetpF(+1));

//F16 Hiring FOC  - zero profit/free entry condition
-kappa*exp(nGF)+exp(JF);

//F17 Firm surplus
-exp(JF)+exp(varthetpF)-exp(wpF);

//F18 Value of work
-exp(VF)+exp(wpF)+exp(AAF);

//F19 Present value of worker payoff after separation 
-exp(AAF)+(1-rho)*mF_tp1*exp(muF(+1))*(s*exp(fF(+1))*exp(VF(+1))+s*(1-exp(fF(+1)))*exp(UF(+1))+(1-s)*(exp(NF(+1))+LcalF(+1)) )+rho*mF_tp1*exp(muF(+1))*exp(AAF(+1));
 
//F20 Unempoyment value
-exp(UF)+D*exp(nGF)+mF_tp1*exp(muF(+1))*(s*exp(fF(+1))*exp(VF(+1))+s*(1-exp(fF(+1)))*exp(UF(+1))+(1-s)*(exp(NF(+1))+LcalF(+1) ) );

//R21 Sharing rule
-alp1*exp(JF)+alp2*(exp(VF)-exp(UF))-alp3*exp(nGF)*gamma+alp4*(exp(varthetF)-exp(nGF)*D);

//F22 GDP
exp(GDPF)=exp(gF)*exp(nGF)+exp(cF)+exp(iF);

//F23 Unempl. rate
-exp(unempF)+(exp(LF)-exp(lF))/exp(LF);

//F24 Job finding rate 
-exp(fF)+exp(xF)*exp(lF(-1))/(exp(LF)-rho*exp(lF(-1))); 

//F25 Matching function
-exp(xF)*exp(lF(-1))+sigmam*(exp(LF)-rho*exp(lF(-1)))^sigma*(exp(vTotF))^(1-sigma);

//F26 Total vacancies
-exp(vTotF)+exp(vF)*exp(lF(-1));

//F27 Law of motion of employment 
-exp(lF)+(rho+exp(xF))*exp(lF(-1));

//F28 value of non-participation
-exp(NF)+exp(UcHF)/exp(psiF)*exp(nGF)+mF_tp1*exp(muF(+1))*( exp(eF(+1))*(exp(fF(+1))*exp(VF(+1))+(1-exp(fF(+1)))*exp(UF(+1)) - LcalF(+1)  )+(1-exp(eF(+1)))*exp(NF(+1)) );

//F29 probability of leaving non-participation
-exp(eF)+( exp(LF)-s*(exp(LF(-1))-rho*exp(lF(-1)))-rho*exp(lF(-1)) )/(1-exp(LF(-1)));
 
//F30 FOC employment
-exp(plF)+exp(wF)-exp(nGF)*D+mF_tp1*exp(muF(+1))*exp(plF(+1))*rho*(1-exp(fF(+1)));

//F31 FOC labor force participation 
exp(nGF)*D+exp(plF)*exp(fF)-exp(UcHF)/exp(psiF)*(exp(cHF)+FcalF)*(1/(1-exp(LF)))-exp(UcHF)/exp(psiF)*FcalLF-mF_tp1*exp(muF(+1))*exp(UcHF(+1))/exp(psiF(+1))*FcalprimeLF;

//F32 home consumption
-exp(cHF)+exp(nGF)*(1-exp(LF))-FcalF; 

//F33 marginal utility of home consumption 
-exp(UcHF)+omega/(1-omega)*(   (exp(cHF)-b*exp(cHF(-1))/exp(muF))/(exp(cF)-b*exp(cF(-1))/exp(muF))   )^(chi-1)*exp(psiF);

//F34 annual inflation (year-on-year)
pi4F=piF+piF(-1)+piF(-2)+piF(-3);

//F35 LFP adjustment cost         
LcalF=exp(UcHF)/exp(psiF)*FcalLF+mF_tp1*exp(muF(+1))*exp(UcHF(+1))/exp(psiF(+1))*FcalprimeLF;


//////////////////////////
//Exogenous Variables/////
//////////////////////////

//E1 Composite technology growth
muF=alfa/(1-alfa)*mupsiF+muzF;

//E2 Diffusion of composite technology into gov. spending and other parameters etc.
0=exp(nGF)-(exp(nGF(-1)))^(1-thetaG)/exp(muF);

//E3 gov. spending
gF=(1-groot1)*(1-groot2)*STEADY_STATE(gF)+(groot1+groot2)*gF(-1)-(groot1*groot2)*gF(-2)+g_eps/100;

//E4 Flight to safety
deltabF=(1-broot1)*(1-broot2)*STEADY_STATE(deltabF)+(broot1+broot2)*deltabF(-1)-(broot1*broot2)*deltabF(-2)+varsig_eps/100;

//E5 GZ spread
OmF=(1-oroot1)*STEADY_STATE(OmF)+(oroot1)*OmF(-1)+Om_eps/100;
 
//E6 Mapping from GZ spread to shock to return on capital 
OmF=(taukF+taukF(+1)+taukF(+2)+taukF(+3)+taukF(+4)+taukF(+5)+taukF(+6)+taukF(+7)+taukF(+8)+taukF(+9)+taukF(+10)+taukF(+11)+taukF(+12)+
+taukF(+13)+taukF(+14)+taukF(+15)+taukF(+16)+taukF(+17)+taukF(+18)+taukF(+19)+taukF(+20)+taukF(+21)+taukF(+22)+taukF(+23)+taukF(+24)+
taukF(+25)+taukF(+26)+taukF(+27))/7;

//switch
#switchshock=eps_switch;

//E7-E10 neutral technology growth (components representation: stationary and permanent technology shocks)
#muzFhat=muzFPhat+muzFTminusEpsFThat+muzEpsFThat;
#muzFsignal=muz_eps/100;
muzF=STEADY_STATE(muzF)+muzFhat;
muzFPhat=          switchshock*(F11muz*muzFPhat(-1)                                 +L11muz*(muzFsignal-F11muz*muzFPhat(-1)-F22muz*muzFTminusEpsFThat(-1)-F23muz*muzEpsFThat(-1)) )+(1-switchshock)*(F11muz*muzFPhat(-1));
muzFTminusEpsFThat=switchshock*(F22muz*muzFTminusEpsFThat(-1)+F23muz*muzEpsFThat(-1)+L21muz*(muzFsignal-F11muz*muzFPhat(-1)-F22muz*muzFTminusEpsFThat(-1)-F23muz*muzEpsFThat(-1)) )+(1-switchshock)*(F22muz*muzFTminusEpsFThat(-1)+F23muz*muzEpsFThat(-1));
muzEpsFThat=       switchshock*(0                                                   +L31muz*(muzFsignal-F11muz*muzFPhat(-1)-F22muz*muzFTminusEpsFThat(-1)-F23muz*muzEpsFThat(-1)) )+(1-switchshock)*(0);

end; 
/////////////////////////////////
//End Model            //////////
///////////////////////////////// 

  
/////////////////////////////////////////////////////////////////
//steady state
/////////////////////////////////////////////////////////////////
cet_steadystate;
steady;


/////////////////////////////////////////////////////////////////
//some options for solving and plotting
/////////////////////////////////////////////////////////////////
//prepare options
options_.maxit_=100;
M_.exo_det_length = 0;
M_.sigma_e_is_diagonal = 1;
options_.stack_solve_algo=0;
options_.periods = 400;
options_.slowc=1;
options_.dynatol.f=1e-8;
options_.dynatol.x=1e-8;

//some plotting options
ia=4; ib=3; ftsize=12; show_horz=29;


/////////////////////////////////////////////////////////////////
//get data for ZLB period
/////////////////////////////////////////////////////////////////
time=2008.5:0.25:2008.5+show_horz/4-0.25; 
load zlbtargetsdata.mat
npadd=size(time,2)-size(mean_range_mat,1);
ww=size(mean_range_mat,2);
mean_range_mat=[mean_range_mat;NaN*zeros(npadd,ww)]'; 
median_range_mat=[median_range_mat;NaN*zeros(npadd,ww)]'; 
min_range_mat =[min_range_mat;NaN*zeros(npadd,ww)]';
max_range_mat =[max_range_mat;NaN*zeros(npadd,ww)]';
dat1990_mat =[dat1990_mat;NaN*zeros(npadd,ww)]';
dat2001_mat=[dat2001_mat;NaN*zeros(npadd,ww)]';


/////////////////////////////////////////////////////////////////
//solve model, subject to Great Recession shocks
/////////////////////////////////////////////////////////////////
compute_solution;
 

/////////////////////////////////////////////////////////////////
//Plot Baseline Variables
/////////////////////////////////////////////////////////////////
plot_endog;     


/////////////////////////////////////////////////////////////////
//Plot Exogenous Variables
/////////////////////////////////////////////////////////////////
plot_exog;


/////////////////////////////////////////////////////////////////
//Plot Beveridge Curve
/////////////////////////////////////////////////////////////////
plot_beveridge; 


/////////////////////////////////////////////////////////////////
//Plot TFP
/////////////////////////////////////////////////////////////////
analyze_tfp;
plot_tfp;
plot_tfp_long; 

 
save results_baseline