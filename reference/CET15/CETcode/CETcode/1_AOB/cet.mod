//////////////////////////////////////////////////////////////////////////
//Medium-sized DSGE model of Christiano, Eichenbaum and Trabandt        //
//''Unemployment and Business Cycles'', Econometrica, forthcoming       //
//                                                                      //
//Based on parameters: AltOffer(AOB)/Nash bargaining, search/hiring cost//
//EHL labor market as nested cases. Checkout params.m                   //
//                                                                      //
//Parameters here are set such that the AOB Model is active. That model //
//is estimated here and the code reproduces the results.                //
//////////////////////////////////////////////////////////////////////////


//Wanted: monetary policy shock is not in period t information set of agents 
//(just as in VAR identified with Choleski decomp.) 
//All other shocks are in period t information set. 

//Solution: create two parallel economies which are structually identical. One which is 
//subject to the monetary shock only. This shock is not in period t info set. 
//The other economy has the other shocks with the standard info set.

//variables ending with 'F' are in the economy with full info set
//variables ending with 'R' are in the restricted info set economy
//variables ending with 'AGG' are aggregated variables from both economies

//Note that in the 'R' economy, all exogenous variables are set to their steady states, except the monetary shock
//likewise, in the 'F' economy, the monetary shock is set to zero while all other shocks are active

//Note that both steady states (i.e. 'R' and 'F' economy) are identical

//All Variables in logs.

//Dynare 4.4.3 used for computations 

 
// Endogenous variables (R economy)
var wpR wpF wR wF psiR cR RR piR iR pkprimeR FR KR ukR wR  
kbarR lR xR varthetR phaloR yR JR UR GDPR fR vR
unempR VR AAR vTotR QR piwR whaloR FwR KwR 
varthetpR;  

// Endogenous variables (F economy)
var psiF cF RF piF iF pkprimeF FF KF ukF wF  
kbarF lF xF varthetF phaloF yF JF UF GDPF fF 
vF unempF VF AAF vTotF QF piwF whaloF FwF KwF
muzF mupsiF muF nGF nPHIF nGAMF nDF nKAPF 
varthetpF;

// Endogenous variables (AGG economy)
var GDPAGG piAGG RAGG ukAGG lAGG wAGG cAGG 
iAGG unempAGG vTotAGG fAGG pinvestAGG; 

//Shocks
varexo epsR_eps muz_eps mupsi_eps;

parameters ydiffdataPercent,idiffdataPercent,alfa,rho,u,Q,sigma,
betta,lambda,deltak,tau,nuf,etag,kappa,b,xi,D,delta,gamma,Spp 
sigmab sigmaa phi rhoR rpi ry sig_epsR sigmam kappaf DSHARE deltapercent
recSHAREpercent iota doNash eta doEHL xiw lambdaw AEHL  
f rhomupsi rhomuz sig_mupsi sig_muz thetaG thetaPHI thetaKAP thetaD 
dolagZBAR profy varkappaw pibreve thetaw varkappaf M sigmaL 
tau_SS epsilon_SS upsilon_SS zetac_SS g_SS pibar thetaGAM kappaw
unemp_SS vTot_SS alp1 alp2 alp3 alp4 bet1 bet2 bet3 s searchSHAREpercent;
   

model;
///////////////////////////////////////////////////////////////////////////////////////
//R economy, monetary policy shock, current realization not in info set//////////////// 
///////////////////////////////////////////////////////////////////////////////////////
//information set in line with Choleski decomposition in VAR
//set exogenous variables to steady states (except monetary shock, of course)
#epsilonR=epsilon_SS;
#upsilonR=upsilon_SS;
#upsilonR_tp1=upsilon_SS;
#zetacR=zetac_SS;
#zetacR_tp1=zetac_SS;
#gR=g_SS;
#tauR=tau_SS;
#mupsiR=STEADY_STATE(mupsiF);
#mupsiR_tp1=STEADY_STATE(mupsiF);
#muzR=STEADY_STATE(muzF);
#muR=alfa/(1-alfa)*STEADY_STATE(mupsiF)+STEADY_STATE(muzF); 
#muR_tp1=STEADY_STATE(muF);
#nGR=STEADY_STATE(nGF);
#nPHIR=STEADY_STATE(nPHIF);
#nGAMR=STEADY_STATE(nGAMF);
#nDR=STEADY_STATE(nDF);
#nKAPR=STEADY_STATE(nKAPF);

//conditional expectations based on t-1 info;
#piR_tp1=EXPECTATION(-1)(piR(+1));
#FR_tp1=EXPECTATION(-1)(FR(+1));
#KR_tp1=EXPECTATION(-1)(KR(+1));
#cR_tp1=EXPECTATION(-1)(cR(+1));
#psiR_tp1=EXPECTATION(-1)(psiR(+1));
#pkprimeR_tp1=EXPECTATION(-1)(pkprimeR(+1));
#iR_tp1=EXPECTATION(-1)(iR(+1));
#UR_tp1=EXPECTATION(-1)(UR(+1));
#fR_tp1=EXPECTATION(-1)(fR(+1));
#wR_tp1=EXPECTATION(-1)(wR(+1));
#VR_tp1=EXPECTATION(-1)(VR(+1)); 
#ukR_tp1=EXPECTATION(-1)(ukR(+1));
#piwR_tp1=EXPECTATION(-1)(piwR(+1));
#KwR_tp1=EXPECTATION(-1)(KwR(+1));
#FwR_tp1=EXPECTATION(-1)(FwR(+1));
#wpR_tp1=EXPECTATION(-1)(wpR(+1));
#varthetpR_tp1=EXPECTATION(-1)(varthetpR(+1));
#AAR_tp1=EXPECTATION(-1)(AAR(+1));
#RRinfo=EXPECTATION(-1)(RR);

%abbreviations
#aofukprimeR=sigmab*sigmaa*(exp(ukR))+sigmab*(1-sigmaa);
#aofukprimeR_tp1=sigmab*sigmaa*(exp(ukR_tp1))+sigmab*(1-sigmaa);
#aofukR=0.5*sigmab*sigmaa*(exp(ukR))^2+sigmab*(1-sigmaa)*exp(ukR)+sigmab*((sigmaa/2)-1);
#aofukR_tp1=0.5*sigmab*sigmaa*(exp(ukR_tp1))^2+sigmab*(1-sigmaa)*exp(ukR_tp1)+sigmab*((sigmaa/2)-1);
#RkR_tp1=log(((exp(ukR_tp1)*aofukprimeR_tp1-aofukR_tp1)+(1-deltak)*exp(pkprimeR_tp1))/(exp(pkprimeR+mupsiR_tp1-piR_tp1)));
#StildeR=(0.5*(exp(sqrt(Spp)*(exp(iR)/exp(iR(-1))*exp(muR)*exp(mupsiR)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))+exp(-sqrt(Spp)*(exp(iR)/exp(iR(-1))*exp(muR)*exp(mupsiR)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-2));
#StildeprimeR=(0.5*sqrt(Spp)*(exp(sqrt(Spp)*(exp(iR)/exp(iR(-1))*exp(muR)*exp(mupsiR)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-exp(-sqrt(Spp)*(exp(iR)/exp(iR(-1))*exp(muR)*exp(mupsiR)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))));
#StildeprimeR_tp1=(0.5*sqrt(Spp)*(exp(sqrt(Spp)*(exp(iR_tp1)/exp(iR)*exp(muR_tp1)*exp(mupsiR_tp1)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-exp(-sqrt(Spp)*(exp(iR_tp1)/exp(iR)*exp(muR_tp1)*exp(mupsiR_tp1)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))));
#mcR=tauR+alfa*mupsiR+( (1-doEHL)*varthetR+doEHL*wR) +log(nuf*(exp(RRinfo))+1-nuf)-epsilonR-log(1-alfa)-alfa*(kbarR(-1)+ukR-muR-lR-(doEHL*(lambdaw/(lambdaw-1))*whaloR) ); 
#pitildewpiR=-piwR+kappaw*piR(-1)+(1-kappaw-varkappaw)*log(pibar)+varkappaw*log(pibreve)+thetaw*STEADY_STATE(muF);
#pitildewpiR_tp1=-piwR_tp1+kappaw*piR+(1-kappaw-varkappaw)*log(pibar)+varkappaw*log(pibreve)+thetaw*STEADY_STATE(muF);
#pitildepiR=-piR+kappaf*piR(-1)+(1-kappaf-varkappaf)*log(pibar)+varkappaf*log(pibreve);
#pitildepiR_tp1=-piR_tp1+kappaf*piR+(1-kappaf-varkappaf)*log(pibar)+varkappaf*log(pibreve);

//R1 - Consumption FOC
exp(psiR)=exp(zetacR)/(exp(cR)-b*exp(cR(-1))/exp(muR))-betta*b*(exp(zetacR_tp1)/
(exp(cR_tp1)*exp(muR_tp1)-b*exp(cR)));

//R2 - Bond FOC (Fisher equation) 
exp(psiR)=betta*exp(psiR_tp1)/exp(muR_tp1)*exp(RRinfo)/exp(piR_tp1);

//R3 - Investment FOC
1=exp(pkprimeR)*exp(upsilonR)*(1-StildeR-StildeprimeR*exp(muR)*exp(mupsiR)*exp(iR)/exp(iR(-1)))+betta*exp(psiR_tp1)/exp(psiR)*exp(pkprimeR_tp1)*exp(upsilonR_tp1)*StildeprimeR_tp1*(exp(iR_tp1)/exp(iR))^2*exp(muR_tp1)*exp(mupsiR_tp1);

//R4 - Capital FOC
1=betta*exp(psiR_tp1-psiR+RkR_tp1-muR_tp1-piR_tp1);

//R5 - Law of motion for physical capital
exp(kbarR)=(1-deltak)/(exp(muR)*exp(mupsiR))*exp(kbarR(-1))+exp(upsilonR)*(1-StildeR)*exp(iR);

//R6 - Cost minimization (opt. factor inputs)
0=aofukprimeR*exp(ukR)*exp(kbarR(-1))/(exp(muR)*exp(mupsiR))-alfa/(1-alfa)*(nuf*exp(RRinfo)+1-nuf)*exp(lR)*((1-doEHL)*(exp(varthetR))+doEHL*( exp(wR)*(exp(whaloR))^(lambdaw/(lambdaw-1))));

//R7 - Production
exp(yR)=exp(phaloR)^(lambda/(lambda-1))*(exp(epsilonR)*((doEHL*exp(whaloR)^(lambdaw/(lambdaw-1))+(1-doEHL)*1)*exp(lR))^(1-alfa)*
             (exp(kbarR(-1)+ukR)/(exp(muR)*exp(mupsiR)))^alfa-phi*exp(nPHIR)); 

//R8 - Resource Constraint
exp(yR)=exp(gR)*exp(nGR)+exp(cR)+exp(iR)+aofukR*exp(kbarR(-1))/(exp(mupsiR)*exp(muR)) 
  +(1-doEHL)*( s*exp(nKAPR)*exp(xR)/exp(QR)*exp(lR(-1))  +  kappa*exp(nKAPR)*exp(xR)*exp(lR(-1))   );

//R9 Monetary Policy Rule
RR=rhoR*RR(-1)+(1-rhoR)*(STEADY_STATE(RR)+rpi*(piR-STEADY_STATE(piF))+ry*(GDPR-STEADY_STATE(GDPF)))-sig_epsR*epsR_eps/400;

//R10 Pricing 1
exp(FR)-exp(psiR+yR)-betta*xi*exp( pitildepiR_tp1  /(1-lambda)+FR_tp1);

//R11 Pricing 2 
exp(KR)-lambda*exp(psiR+yR+mcR)-betta*xi*exp( pitildepiR_tp1 *lambda/(1-lambda)+KR_tp1);

//R12 Pricing 3
KR-FR=(1-lambda)*log((1-xi*exp( pitildepiR /(1-lambda)))/(1-xi));

//R13  Price dispersion
exp(phaloR*lambda/(1-lambda))-(1-xi)^(1-lambda)*(1-xi*exp( pitildepiR /(1-lambda)))^lambda
   -xi*(exp( pitildepiR +phaloR(-1)))^(lambda/(1-lambda));

//R14 Present value of wages
doEHL*(exp(wpR)-exp(STEADY_STATE(wpF)))=(1-doEHL)*(-exp(wpR)+exp(wR)+rho*betta*exp(psiR_tp1)/exp(psiR)*exp(wpR_tp1));

//R15 Present value of marginal revenue
doEHL*(exp(varthetpR)-exp(STEADY_STATE(varthetpF)))=(1-doEHL)*(-exp(varthetpR)+exp(varthetR)+rho*betta*exp(psiR_tp1)/exp(psiR)*exp(varthetpR_tp1));

//R16 Hiring FOC  - zero profit/free entry condition
doEHL*(exp(xR)-exp(STEADY_STATE(xF)))=(1-doEHL)*(  -s*exp(nKAPR)/exp(QR) -kappa*exp(nKAPR) + exp(JR)   );

//R17 Value of firm
doEHL*(exp(JR)-exp(STEADY_STATE(JF)))=(1-doEHL)*(-exp(JR)+exp(varthetpR)-exp(wpR));

//R18 Value of work
doEHL*(exp(VR)-exp(STEADY_STATE(VF)))=(1-doEHL)*(-exp(VR)+exp(wpR)+exp(AAR));

//R19 Present value of worker payoff after separation 
doEHL*(exp(AAR)-exp(STEADY_STATE(AAF)))=(1-doEHL)*(-exp(AAR)+(1-rho)*betta*exp(psiR_tp1)/exp(psiR)*(exp(fR_tp1)*exp(VR_tp1)
+(1-exp(fR_tp1))*exp(UR_tp1))+rho*betta*exp(psiR_tp1)/exp(psiR)*exp(AAR_tp1));

//R20 Unemployment value
doEHL*(exp(UR)-exp(STEADY_STATE(UF)))=(1-doEHL)*(-exp(UR)+D*exp(nDR)+betta*exp(psiR_tp1)/exp(psiR)*(exp(fR_tp1)*exp(VR_tp1)+(1-exp(fR_tp1))*exp(UR_tp1)));

//R21 Sharing rule
doEHL*(exp(varthetR)-STEADY_STATE(exp(varthetF)))=(1-doEHL)*(doNash*(exp(VR)-exp(UR)-eta*(exp(JR)+exp(VR)-exp(UR)))+(1-doNash)*(
  
-exp(JR)+bet1*(exp(VR)-exp(UR))-bet2*exp(nGAMR)*gamma+bet3*(exp(varthetR)-exp(nDR)*D)

));

//R22 GDP
exp(GDPR)=exp(gR)*exp(nGR)+exp(cR)+exp(iR);

//R23 Unempl. rate
doEHL*(exp(unempR)-exp(STEADY_STATE(unempF)))=(1-doEHL)*(-exp(unempR)+1-exp(lR));

//R24 Job finding rate
doEHL*(exp(fR)-exp(STEADY_STATE(fF)))=(1-doEHL)*(-exp(fR)+exp(xR)*exp(lR(-1))/(1-rho*exp(lR(-1)))); 

//R25 Matching function
doEHL*(exp(vTotR)-exp(STEADY_STATE(vTotF)))=(1-doEHL)*(-exp(xR)*exp(lR(-1))+sigmam*(1-rho*exp(lR(-1)))^sigma*(exp(vTotR))^(1-sigma));

//R26 Total vacancies
doEHL*(exp(vR)-exp(STEADY_STATE(vF)))=(1-doEHL)*(-exp(vTotR)+exp(vR)*exp(lR(-1)));

//R27 Vacancy filling rate
doEHL*(exp(QR)-exp(STEADY_STATE(QF)))=(1-doEHL)*(-exp(QR)+exp(xR)/exp(vR));

//R28 Wage inflation (EHL)
exp(piwR)=exp(piR)*exp(muR)*exp(wR)/exp(wR(-1));

//R29  Wage dispersion
doEHL*(exp(whaloR*lambdaw/(1-lambdaw))-(1-xiw)^(1-lambdaw)*(1-xiw*exp(pitildewpiR/(1-lambdaw)))^lambdaw
   -xiw*(exp(pitildewpiR+whaloR(-1)))^(lambdaw/(1-lambdaw)))=(1-doEHL)*(exp(whaloR)-exp(STEADY_STATE(whaloF)));

//R30 wage setting 1 (EHL)
doEHL*(-exp(FwR) + exp(psiR)/lambdaw*exp(whaloR)^( lambdaw/(lambdaw-1))*exp(lR) + betta*xiw*(exp(wR_tp1)/exp(wR))*(exp(pitildewpiR_tp1))^( 1/(1-lambdaw) )*exp(FwR_tp1))
=(1-doEHL)*(exp(FwR)-exp(STEADY_STATE(FwF)));

//R31 Law of motion of employment or EHL wage setting 2
doEHL*(-exp(KwR) + ( exp(whaloR)^( lambdaw/(lambdaw-1))*exp(lR))^(1+sigmaL) + betta*xiw*(exp(pitildewpiR_tp1))^( lambdaw*(1+sigmaL)/(1-lambdaw) )*exp(KwR_tp1))    
=(1-doEHL)*(-exp(lR)+(rho+exp(xR))*exp(lR(-1)));

//R32 wage setting 3 (EHL)
doEHL*(1-(1-xiw)*(AEHL*exp(KwR)/(exp(FwR)*exp(wR)))^( 1/( 1-lambdaw*(1+sigmaL) )) - xiw*(exp(pitildewpiR))^(1/(1-lambdaw)))=(1-doEHL)*(exp(KwR)-exp(STEADY_STATE(KwF)));

////////////////////////////////////////////////////////////////////// 
//F economy, other shocks, current realization in info set /////////// 
////////////////////////////////////////////////////////////////////// 
//set not needed exogenous variables to steady states 
#tauF=tau_SS;
#upsilonF=upsilon_SS;
#upsilonF_tp1=upsilon_SS;
#epsilonF=epsilon_SS;
#zetacF=zetac_SS;
#zetacF_tp1=zetac_SS;
#gF=g_SS;

%abbreviations
#aofukprimeF=sigmab*sigmaa*(exp(ukF))+sigmab*(1-sigmaa);
#aofukprimeF_tp1=sigmab*sigmaa*(exp(ukF(+1)))+sigmab*(1-sigmaa);
#aofukF=0.5*sigmab*sigmaa*(exp(ukF))^2+sigmab*(1-sigmaa)*exp(ukF)+sigmab*((sigmaa/2)-1);
#aofukF_tp1=0.5*sigmab*sigmaa*(exp(ukF(+1)))^2+sigmab*(1-sigmaa)*exp(ukF(+1))+sigmab*((sigmaa/2)-1);
#RkF_tp1=log(((exp(ukF(+1))*aofukprimeF_tp1-aofukF_tp1)+(1-deltak)*exp(pkprimeF(+1)))/(exp(pkprimeF+mupsiF(+1)-piF(+1))));
#StildeF=(0.5*(exp(sqrt(Spp)*(exp(iF)/exp(iF(-1))*exp(muF)*exp(mupsiF)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))+exp(-sqrt(Spp)*(exp(iF)/exp(iF(-1))*exp(muF)*exp(mupsiF)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-2));
#StildeprimeF=(0.5*sqrt(Spp)*(exp(sqrt(Spp)*(exp(iF)/exp(iF(-1))*exp(muF)*exp(mupsiF)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-exp(-sqrt(Spp)*(exp(iF)/exp(iF(-1))*exp(muF)*exp(mupsiF)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))));
#StildeprimeF_tp1=(0.5*sqrt(Spp)*(exp(sqrt(Spp)*(exp(iF(+1))/exp(iF)*exp(muF(+1))*exp(mupsiF(+1))-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-exp(-sqrt(Spp)*(exp(iF(+1))/exp(iF)*exp(muF(+1))*exp(mupsiF(+1))-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))));
#mcF=tauF+alfa*mupsiF+( (1-doEHL)*varthetF+doEHL*wF) +log(nuf*(exp(RF))+1-nuf)-epsilonF-log(1-alfa)-alfa*(kbarF(-1)+ukF-muF-lF-(doEHL*(lambdaw/(lambdaw-1))*whaloF) ); 
#pitildewpiF=-piwF+kappaw*piF(-1)+(1-kappaw-varkappaw)*log(pibar)+varkappaw*log(pibreve)+thetaw*STEADY_STATE(muF);
#pitildewpiF_tp1=-piwF(+1)+kappaw*piF+(1-kappaw-varkappaw)*log(pibar)+varkappaw*log(pibreve)+thetaw*STEADY_STATE(muF);
#pitildepiF=-piF+kappaf*piF(-1)+(1-kappaf-varkappaf)*log(pibar)+varkappaf*log(pibreve);
#pitildepiF_tp1=-piF(+1)+kappaf*piF+(1-kappaf-varkappaf)*log(pibar)+varkappaf*log(pibreve);

//F1 - Consumption FOC
exp(psiF)=exp(zetacF)/(exp(cF)-b*exp(cF(-1))/exp(muF))-betta*b*(exp(zetacF_tp1)/
(exp(cF(+1))*exp(muF(+1))-b*exp(cF)));

//F2 - Bond FOC (Fisher equation) 
exp(psiF)=betta*exp(psiF(+1))/exp(muF(+1))*exp(RF)/exp(piF(+1));

//F3 - Investment FOC
1=exp(pkprimeF)*exp(upsilonF)*(1-StildeF-StildeprimeF*exp(muF)*exp(mupsiF)*exp(iF)/exp(iF(-1)))+betta*exp(psiF(+1))/exp(psiF)*exp(pkprimeF(+1))*exp(upsilonF_tp1)*StildeprimeF_tp1*(exp(iF(+1))/exp(iF))^2*exp(muF(+1))*exp(mupsiF(+1));

//F4 - Capital FOC
1=betta*exp(psiF(+1)-psiF+RkF_tp1-muF(+1)-piF(+1));

//F5 - Law of motion for physical capital
exp(kbarF)=(1-deltak)/(exp(muF)*exp(mupsiF))*exp(kbarF(-1))+exp(upsilonF)*(1-StildeF)*exp(iF);

//F6 - Cost minimization (opt. factor inputs)
0=aofukprimeF*exp(ukF)*exp(kbarF(-1))/(exp(muF)*exp(mupsiF))-alfa/(1-alfa)*(nuf*exp(RF)+1-nuf)*exp(lF)*((1-doEHL)*(exp(varthetF))+doEHL*( exp(wF)*(exp(whaloF))^(lambdaw/(lambdaw-1))));

//F7 - Production
exp(yF)=exp(phaloF)^(lambda/(lambda-1))*(exp(epsilonF)*(     (doEHL*exp(whaloF)^(lambdaw/(lambdaw-1))+(1-doEHL)*1)*exp(lF)     )^(1-alfa)*
             (exp(kbarF(-1)+ukF)/(exp(muF)*exp(mupsiF)))^alfa-phi*exp(nPHIF)); 

//F8 - Resource Constraint
exp(yF)=exp(gF)*exp(nGF)+exp(cF)+exp(iF)+aofukF*exp(kbarF(-1))/(exp(mupsiF)*exp(muF)) 
  +(1-doEHL)*( s*exp(nKAPF)*exp(xF)/exp(QF)*exp(lF(-1))  +  kappa*exp(nKAPF)*exp(xF)*exp(lF(-1))   );


//F9 Monetary Policy Rule
RF=rhoR*RF(-1)+(1-rhoR)*(STEADY_STATE(RF)+rpi*(piF-STEADY_STATE(piF))+ry*(GDPF-STEADY_STATE(GDPF)));

//F10 Pricing 1
exp(FF)-exp(psiF+yF)-betta*xi*exp( pitildepiF_tp1 /(1-lambda)+FF(+1));

//F11 Pricing 2 
exp(KF)-lambda*exp(psiF+yF+mcF)-betta*xi*exp( pitildepiF_tp1*lambda/(1-lambda)+KF(+1));

//F12 Pricing 3
KF-FF=(1-lambda)*log((1-xi*exp( pitildepiF /(1-lambda)))/(1-xi));

//F13  Price dispersion
exp(phaloF*lambda/(1-lambda))-(1-xi)^(1-lambda)*(1-xi*exp( pitildepiF /(1-lambda)))^lambda
   -xi*(exp( pitildepiF +phaloF(-1)))^(lambda/(1-lambda));

//F14 Present value of wages
doEHL*(exp(wpF)-STEADY_STATE(exp(wpF)))=(1-doEHL)*(-exp(wpF)+exp(wF)+rho*betta*exp(psiF(+1))/exp(psiF)*exp(wpF(+1)));

//F15 Present value of marginal revenue
doEHL*(exp(varthetpF)-STEADY_STATE(exp(varthetpF)))=(1-doEHL)*(-exp(varthetpF)+exp(varthetF)+rho*betta*exp(psiF(+1))/exp(psiF)*exp(varthetpF(+1)));

//F16 Hiring FOC  - zero profit/free entry condition
doEHL*(exp(xF)-exp(STEADY_STATE(xF)))=(1-doEHL)*(  -s*exp(nKAPF)/exp(QF) - kappa*exp(nKAPF) + exp(JF)   );

//F17 Firm surplus
doEHL*(exp(JF)-STEADY_STATE(exp(JF)))=(1-doEHL)*(-exp(JF)+exp(varthetpF)-exp(wpF));

//F18 Value of work
doEHL*(exp(VF)-exp(STEADY_STATE(VF)))=(1-doEHL)*(-exp(VF)+exp(wpF)+exp(AAF));

//F19 Present value of worker payoff after separation 
doEHL*(exp(AAF)-exp(STEADY_STATE(AAF)))=(1-doEHL)*(-exp(AAF)+(1-rho)*betta*exp(psiF(+1))/exp(psiF)*(exp(fF(+1))*exp(VF(+1))+(1-exp(fF(+1)))*exp(UF(+1)))+rho*betta*exp(psiF(+1))/exp(psiF)*exp(AAF(+1)));
 
//F20 Unempoyment value
doEHL*(exp(UF)-exp(STEADY_STATE(UF)))=(1-doEHL)*(-exp(UF)+D*exp(nDF)+betta*exp(psiF(+1))/exp(psiF)*(exp(fF(+1))*exp(VF(+1))+(1-exp(fF(+1)))*exp(UF(+1))));

//R21 Sharing rule
doEHL*(exp(varthetF)-STEADY_STATE(exp(varthetF)))=(1-doEHL)*(doNash*(exp(VF)-exp(UF)-eta*(exp(JF)+exp(VF)-exp(UF)))+(1-doNash)*(

-exp(JF)+bet1*(exp(VF)-exp(UF))-bet2*exp(nGAMF)*gamma+bet3*(exp(varthetF)-exp(nDF)*D)

));

//F22 GDP
exp(GDPF)=exp(gF)*exp(nGF)+exp(cF)+exp(iF);

//F23 Unempl. rate
doEHL*(exp(unempF)-exp(STEADY_STATE(unempF)))=(1-doEHL)*(-exp(unempF)+1-exp(lF));

//F24 Finding rate
doEHL*(exp(fF)-exp(STEADY_STATE(fF)))=(1-doEHL)*(-exp(fF)+exp(xF)*exp(lF(-1))/(1-rho*exp(lF(-1)))); 

//F25 Matching function
doEHL*(exp(vTotF)-exp(STEADY_STATE(vTotF)))=(1-doEHL)*(-exp(xF)*exp(lF(-1))+sigmam*(1-rho*exp(lF(-1)))^sigma*(exp(vTotF))^(1-sigma));

//F26 Total vacancies
doEHL*(exp(vF)-exp(STEADY_STATE(vF)))=(1-doEHL)*(-exp(vTotF)+exp(vF)*exp(lF(-1)));

//F27 Vacancy filling rate
doEHL*(exp(QF)-exp(STEADY_STATE(QF)))=(1-doEHL)*(-exp(QF)+exp(xF)/exp(vF));

//F28 Wage inflation
exp(piwF)=exp(piF)*exp(muF)*exp(wF)/exp(wF(-1));

//F29  Wage dispersion
doEHL*(exp(whaloF*lambdaw/(1-lambdaw))-(1-xiw)^(1-lambdaw)*(1-xiw*exp(pitildewpiF/(1-lambdaw)))^lambdaw
   -xiw*(exp(pitildewpiF+whaloF(-1)))^(lambdaw/(1-lambdaw)))=(1-doEHL)*(exp(whaloF)-exp(STEADY_STATE(whaloF)));

//F30 wage setting 1 (EHL)
doEHL*(-exp(FwF) + exp(psiF)/lambdaw*exp(whaloF)^( lambdaw/(lambdaw-1))*exp(lF) + betta*xiw*(exp(wF(+1))/exp(wF))*(exp(pitildewpiF_tp1))^( 1/(1-lambdaw) )*exp(FwF(+1))    )
=(1-doEHL)*(exp(FwF)-exp(STEADY_STATE(FwF)));

//F31 Law of motion of employment or EHL wage setting 2  
doEHL*(-exp(KwF) + ( exp(whaloF)^( lambdaw/(lambdaw-1))*exp(lF))^(1+sigmaL) + betta*xiw*( exp(pitildewpiF_tp1) )^( lambdaw*(1+sigmaL)/(1-lambdaw) )*exp(KwF(+1)))    
=(1-doEHL)*(-exp(lF)+(rho+exp(xF))*exp(lF(-1)));

//F32 wage setting 3 (EHL)
doEHL*(1-(1-xiw)*(AEHL*exp(KwF)/(exp(FwF)*exp(wF)))^( 1/( 1-lambdaw*(1+sigmaL) )) - xiw*(  exp(pitildewpiF)   )^(1/(1-lambdaw)))=(1-doEHL)*(exp(KwF)-exp(STEADY_STATE(KwF)));
//////////////////////////
//Exogenous Variables/////
//////////////////////////

//E1 Composite technology growth
muF=alfa/(1-alfa)*mupsiF+muzF;

//E2 Unit root invest. Tech.
mupsiF=(1-rhomupsi)*STEADY_STATE(mupsiF)+rhomupsi*mupsiF(-1)+sig_mupsi*mupsi_eps/100;

//E3 Unit root neutral Tech.
muzF=(1-rhomuz)*STEADY_STATE(muzF)+rhomuz*muzF(-1)+sig_muz*muz_eps/100;

//E4 Diffusion of composite technology into gov. spending
(1-dolagZBAR)*(exp(nGF)-(exp(nGF(-1))/exp(muF))^(1-thetaG))=dolagZBAR*(exp(nGF)-(exp(nGF(-1)))^(1-thetaG)/exp(muF));

//E5  Diffusion of composite technology into fixed costs of production
nPHIF=nGF;

//E6  Diffusion of composite technology into firm delay costs of bargaining 
nGAMF=nGF;

//E7  Diffusion of composite technology into unemployment benefits
nDF=nGF;

//E8 Diffusion of composite technology into hiring/search costs 
nKAPF=nGF;
////////////////////////////////////////////////////////////////////// 
//Aggregating 'F' and 'R' economies, expressed in percent deviations// 
//////////////////////////////////////////////////////////////////////
//A1 
GDPAGG-STEADY_STATE(GDPF)=GDPR-STEADY_STATE(GDPF)+GDPF-STEADY_STATE(GDPF);
//A2 
piAGG-STEADY_STATE(piF)=piR-STEADY_STATE(piF)+piF-STEADY_STATE(piF);
//A3 
RAGG-STEADY_STATE(RF)=RR-STEADY_STATE(RF)+RF-STEADY_STATE(RF);
//A4 
ukAGG-STEADY_STATE(ukF)=ukR-STEADY_STATE(ukF)+ukF-STEADY_STATE(ukF);
//A5 
lAGG-STEADY_STATE(lF)=lR-STEADY_STATE(lF)+lF-STEADY_STATE(lF);
//A6 
wAGG-STEADY_STATE(wF)=wR-STEADY_STATE(wF)+wF-STEADY_STATE(wF);
//A7 
cAGG-STEADY_STATE(cF)=cR-STEADY_STATE(cF)+cF-STEADY_STATE(cF);
//A8 
iAGG-STEADY_STATE(iF)=iR-STEADY_STATE(iF)+iF-STEADY_STATE(iF);
//A9 
unempAGG-STEADY_STATE(unempF)=unempR-STEADY_STATE(unempF)+unempF-STEADY_STATE(unempF);
//A10 
vTotAGG-STEADY_STATE(vTotF)=vTotR-STEADY_STATE(vTotF)+vTotF-STEADY_STATE(vTotF);
//A11 
fAGG-STEADY_STATE(fF)=fR-STEADY_STATE(fF)+fF-STEADY_STATE(fF);
//A12
pinvestAGG=-mupsiF; 
end; 
/////////////////////////////////
//End Model            //////////
///////////////////////////////// 
 
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
xi,,,,beta_pdf,0.66,0.1; 
lambda,,1.001,,gamma_pdf,1.2,0.05;

rhoR,.85,,,beta_pdf,0.7,0.15; 
rpi ,1.45,,,gamma_pdf,1.7,0.15;
ry ,0.01,,,gamma_pdf,0.1,0.05;

b,,,,beta_pdf,0.5,0.15;
sigmaa,,,,gamma_pdf,0.5,0.3; 
Spp,,,,gamma_pdf,8,2; 
alfa,,,,beta_pdf,0.33,0.025;
thetaG,.1,,,beta_pdf,0.5,0.2;  

deltapercent,,,,gamma_pdf,0.5,0.4; 
DSHARE,,,,beta_pdf,0.4,0.1;
recSHAREpercent,,,,gamma_pdf,1,0.3; 
searchSHAREpercent,,,,gamma_pdf,.1,0.07; 
sigma,,,,beta_pdf,0.5,0.1; 

sig_epsR,,,,gamma_pdf,0.65,.05;     
sig_muz,,,,gamma_pdf,0.1,.05;
sig_mupsi,,,,gamma_pdf,0.1,.05;
rhomupsi,,,,beta_pdf,0.75,0.1;
end;      
 
 
 
///////////////////////////////////////////////////////////////////////////////////////////////////////
//BEGINNING OF ESTIMATION//////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
do_imp_resp_matching=1;                  %if =1, model estimated based on VAR impulse responses
if do_imp_resp_matching==1,
   addpath('DynareImpRespMatching');    %path with adjusted DYNARE functions dsge_likelihood.m and dynare_estimation_1.m  
   get_VAR_resp;                         %get VAR impulse responses: load VAR impulse responses and precision matrix
                                         %from .mat file; store them in global variables psihat and inv_Vhat
                                         %The model-VAR impulse response matching is done in dsge_likelihood.m (in folder DynareImpRespMatching). 
                                         %Check out lines 822-950 for the details. 
end 

///////////////////////////////////////////////////////////////////////////////////////////
//////Estimation///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
options_.mh_conf_sig= 0.95;
options_.prior_interval= 0.95;
options_.conf_sig= 0.95;

estimation(first_obs=1,
           datafile=data,
           %nograph,
           order=1,
           lik_init=1,
           mode_compute=0,
           mode_file=cet_mh_mode,
           %load_mh_file,
           mh_replic=0,%910000,%1500000,%720000,           
           mh_nblocks=11,
           mh_init_scale=.5,
           mh_jscale=.5,
           mh_drop=0.5);


//evaluate at MCMC joint mode
load cet_mh_mode.mat;
for ii=1:1:length(xparam1)
    para_idx=loc(M_.param_names,char(parameter_names(ii)));
    M_.params(para_idx)=xparam1(ii);
end


//call steady state
cet_steadystate([],[],1);

//plot VAR vs. Model resp.
stoch_simul(order=1,irf=400,nomoments,nocorr,nograph,noprint);
stack_model_responses;
model_resp_mon_baseline=model_resp_mon;model_resp_ntech_baseline=model_resp_ntech;model_resp_itech_baseline=model_resp_itech;
plot_var_model_irf; 


save resultsAltOffer
delete *.eps
  




 