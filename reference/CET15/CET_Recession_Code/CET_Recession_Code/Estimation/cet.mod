///////////////////////////////////////////////////////////////////////////
//Medium-sized model of Christiano, Eichenbaum and Trabandt (2015)       //
//'Understanding the Great Recession', American Economic Journal:        //
//Macroeconomics, forthcoming                                            //
//                                                                       //
//                                                                       //
//Dynare 4.4.3 and MATLAB R2012a used for computations                   //
//                                                                       //
//                                                                       //
//This code estimates the parameters of the model using Bayesian         //  
//impulse response matching.                                             //
//                                                                       //
///////////////////////////////////////////////////////////////////////////


//Notes on model implementation
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
 
// Endogenous variables (R economy)
var psiR cR RR piR iR pkprimeR FR KR ukR wR  
kbarR lR xR varthetR phaloR yR JR UR GDPR fR vR
unempR VR AAR vTotR QR wpR
varthetpR eR NR LR cHR UcHR plR LcalR;  

// Endogenous variables (F economy)
var psiF cF RF piF iF pkprimeF FF KF ukF wF  
kbarF lF xF varthetF phaloF yF JF UF GDPF fF 
vF unempF VF AAF vTotF QF muzF mupsiF muF nGF wpF
varthetpF eF NF LF cHF UcHF plF
pi4F LcalF;

// Endogenous variables (AGG economy)
var GDPAGG piAGG RAGG ukAGG lAGG wAGG cAGG 
iAGG unempAGG vTotAGG fAGG pinvestAGG LAGG; 

//Shocks
varexo epsR_eps muz_eps mupsi_eps;

parameters ydiffdataPercent,idiffdataPercent,alfa,rho,u,Q,sigma,
betta,lambda,deltak,nuf,kappa,b,xi,D,delta,gamma,Spp sigmab,
sigmaa phi rhoR rpi sig_epsR sigmam kappaf DSHARE deltapercent
recSHAREpercent f rhomupsi sig_mupsi thetaG profy pibreve varkappaf 
M pibar unemp_SS vTot_SS alp1 alp2 alp3 alp4 s omega phiL etag chi 
rdeltay rhomuzT sigmuzT rhomuz sig_muz sigmuzTPratio sig_eta theta1 
theta2 g;   

model;
///////////////////////////////////////////////////////////////////////////////////////
//R economy, monetary policy shock, current realization not in info set//////////////// 
///////////////////////////////////////////////////////////////////////////////////////
//information set in line with Choleski decomposition in VAR
//set exogenous variables to steady states (except monetary shock, of course)
#mupsiR=STEADY_STATE(mupsiF);
#mupsiR_tp1=STEADY_STATE(mupsiF);
#muR=alfa/(1-alfa)*STEADY_STATE(mupsiF)+STEADY_STATE(muzF); 
#muR_tp1=STEADY_STATE(muF);
#nGR=STEADY_STATE(nGF);

//conditional expectations based on t-1 info;
#piR_tp1=EXPECTATION(-1)(piR(+1));
#FR_tp1=EXPECTATION(-1)(FR(+1));
#KR_tp1=EXPECTATION(-1)(KR(+1));
#psiR_tp1=EXPECTATION(-1)(psiR(+1));
#pkprimeR_tp1=EXPECTATION(-1)(pkprimeR(+1));
#iR_tp1=EXPECTATION(-1)(iR(+1));
#UR_tp1=EXPECTATION(-1)(UR(+1));
#fR_tp1=EXPECTATION(-1)(fR(+1));
#VR_tp1=EXPECTATION(-1)(VR(+1)); 
#ukR_tp1=EXPECTATION(-1)(ukR(+1));
#wpR_tp1=EXPECTATION(-1)(wpR(+1));
#varthetpR_tp1=EXPECTATION(-1)(varthetpR(+1));
#AAR_tp1=EXPECTATION(-1)(AAR(+1));
#RRinfo=EXPECTATION(-1)(RR);
#LR_tp1=EXPECTATION(-1)(LR(+1));
#NR_tp1=EXPECTATION(-1)(NR(+1));
#eR_tp1=EXPECTATION(-1)(eR(+1));
#plR_tp1=EXPECTATION(-1)(plR(+1));
#UcHR_tp1=EXPECTATION(-1)(UcHR(+1));
#LcalR_tp1=EXPECTATION(-1)(LcalR(+1));

//abbreviations

//capacity utilization
#aofukprimeR=sigmab*sigmaa*(exp(ukR))+sigmab*(1-sigmaa);
#aofukprimeR_tp1=sigmab*sigmaa*(exp(ukR_tp1))+sigmab*(1-sigmaa);
#aofukR=0.5*sigmab*sigmaa*(exp(ukR))^2+sigmab*(1-sigmaa)*exp(ukR)+sigmab*((sigmaa/2)-1);
#aofukR_tp1=0.5*sigmab*sigmaa*(exp(ukR_tp1))^2+sigmab*(1-sigmaa)*exp(ukR_tp1)+sigmab*((sigmaa/2)-1);

//return on capital
#RkR_tp1=log(((exp(ukR_tp1)*aofukprimeR_tp1-aofukR_tp1)+(1-deltak)*exp(pkprimeR_tp1))/(exp(pkprimeR+mupsiR_tp1-piR_tp1)));

//investment adjustment cost
#StildeR=(0.5*(exp(sqrt(Spp)*(exp(iR)/exp(iR(-1))*exp(muR)*exp(mupsiR)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))+exp(-sqrt(Spp)*(exp(iR)/exp(iR(-1))*exp(muR)*exp(mupsiR)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-2));
#StildeprimeR=(0.5*sqrt(Spp)*(exp(sqrt(Spp)*(exp(iR)/exp(iR(-1))*exp(muR)*exp(mupsiR)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-exp(-sqrt(Spp)*(exp(iR)/exp(iR(-1))*exp(muR)*exp(mupsiR)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))));
#StildeprimeR_tp1=(0.5*sqrt(Spp)*(exp(sqrt(Spp)*(exp(iR_tp1)/exp(iR)*exp(muR_tp1)*exp(mupsiR_tp1)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-exp(-sqrt(Spp)*(exp(iR_tp1)/exp(iR)*exp(muR_tp1)*exp(mupsiR_tp1)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))));

//marginal cost
#mcR=alfa*mupsiR+varthetR+log(nuf*(exp(RRinfo))+1-nuf)-log(1-alfa)-alfa*(kbarR(-1)+ukR-muR-lR ); 

//indexation
#pitildepiR=-piR+kappaf*piR(-1)+(1-kappaf-varkappaf)*log(pibar)+varkappaf*log(pibreve);
#pitildepiR_tp1=-piR_tp1+kappaf*piR+(1-kappaf-varkappaf)*log(pibar)+varkappaf*log(pibreve);

//labor force adjustment cost
#FcalR=0.5*exp(nGR)*phiL*100*(exp(LR)/exp(LR(-1))-1)^2;                                                       
#FcalLR=exp(nGR)*phiL*100*(exp(LR)/exp(LR(-1))-1)*1/exp(LR(-1));                                              
#FcalprimeLR=-exp(nGR)*phiL*100*(exp(LR_tp1)/exp(LR)-1)*exp(LR_tp1)*(1/exp(LR))^2;  

//asset pricing kernel
#mR_tp1=betta*exp(psiR_tp1)/exp(psiR)*(exp(muR_tp1))^(-1); 

//composite consumption
#ctildeR=( (1-omega)*(exp(cR)-b*exp(cR(-1))/exp(muR))^chi+omega*(exp(cHR)-b*exp(cHR(-1))/exp(muR))^chi )^(1/chi);



//R1 - Consumption FOC
exp(psiR)=(1-omega)*(ctildeR)^(-chi)*(exp(cR)-b*exp(cR(-1))/exp(muR))^(chi-1);

//R2 - Bond FOC (Fisher equation) 
1=mR_tp1*exp(RRinfo)/exp(piR_tp1);

//R3 - Investment FOC
1=exp(pkprimeR)*(1-StildeR-StildeprimeR*exp(muR)*exp(mupsiR)*exp(iR)/exp(iR(-1)))+mR_tp1*exp(muR_tp1)*exp(pkprimeR_tp1)*StildeprimeR_tp1*(exp(iR_tp1)/exp(iR))^2*exp(muR_tp1)*exp(mupsiR_tp1);

//R4 - Capital FOC
1=mR_tp1*exp(RkR_tp1)/exp(piR_tp1);

//R5 - Law of motion for physical capital
exp(kbarR)=(1-deltak)/(exp(muR)*exp(mupsiR))*exp(kbarR(-1))+(1-StildeR)*exp(iR);

//R6 - Cost minimization (opt. factor inputs)
0=aofukprimeR*exp(ukR)*exp(kbarR(-1))/(exp(muR)*exp(mupsiR))-alfa/(1-alfa)*(nuf*exp(RRinfo)+1-nuf)*exp(lR)*((exp(varthetR)));

//R7 - Production
exp(yR)=exp(phaloR)^(lambda/(lambda-1))*((exp(lR))^(1-alfa)*(exp(kbarR(-1)+ukR)/(exp(muR)*exp(mupsiR)))^alfa-phi*exp(nGR)); 

//R8 - Resource Constraint
exp(yR)=g*exp(nGR)+exp(cR)+exp(iR)+aofukR*exp(kbarR(-1))/(exp(mupsiR)*exp(muR))+kappa*exp(nGR)*(exp(xR))*exp(lR(-1));

//R9 Monetary Policy Rule
#pi4R=piR+piR(-1)+piR(-2)+piR(-3);
RR=rhoR*RR(-1)+(1-rhoR)*(STEADY_STATE(RR)+rpi/4*(pi4R-STEADY_STATE(pi4R))+rdeltay/4*(GDPR-GDPR(-4)+4*STEADY_STATE(muR)-4*STEADY_STATE(muR)))-sig_epsR*epsR_eps/400;

//R10 Pricing 1
exp(FR)-exp(psiR+yR)-betta*xi*exp( pitildepiR_tp1  /(1-lambda)+FR_tp1);

//R11 Pricing 2 
exp(KR)-lambda*exp(psiR+yR+mcR)-betta*xi*exp( pitildepiR_tp1 *lambda/(1-lambda)+KR_tp1);

//R12 Pricing 3
KR-FR=(1-lambda)*log((1-xi*exp( pitildepiR /(1-lambda)))/(1-xi));

//R13  Price dispersion
exp(phaloR*lambda/(1-lambda))-(1-xi)^(1-lambda)*(1-xi*exp( pitildepiR /(1-lambda)))^lambda-xi*(exp( pitildepiR +phaloR(-1)))^(lambda/(1-lambda));

//R14 Present value of wages
-exp(wpR)+exp(wR)+rho*mR_tp1*exp(muR_tp1)*exp(wpR_tp1);

//R15 Present value of marginal revenue
-exp(varthetpR)+exp(varthetR)+rho*mR_tp1*exp(muR_tp1)*exp(varthetpR_tp1);

//R16 Hiring FOC  - zero profit/free entry condition
-kappa*exp(nGR)+exp(JR);

//R17 Value of firm
-exp(JR)+exp(varthetpR)-exp(wpR);

//R18 Value of work
-exp(VR)+exp(wpR)+exp(AAR);

//F19 Present value of worker payoff after separation 
-exp(AAR)+(1-rho)*mR_tp1*exp(muR_tp1)*(s*exp(fR_tp1)*exp(VR_tp1)+s*(1-exp(fR_tp1))*exp(UR_tp1)+(1-s)*(exp(NR_tp1)+LcalR_tp1))+rho*mR_tp1*exp(muR_tp1)*exp(AAR_tp1);
 
//F20 Unempoyment value
-exp(UR)+D*exp(nGR)+mR_tp1*exp(muR_tp1)*(s*exp(fR_tp1)*exp(VR_tp1)+s*(1-exp(fR_tp1))*exp(UR_tp1)+(1-s)*(exp(NR_tp1)+LcalR_tp1) );

//R21 Sharing rule
-alp1*exp(JR)+alp2*(exp(VR)-exp(UR))-alp3*exp(nGR)*gamma+alp4*(exp(varthetR)-exp(nGR)*D);

//R22 GDP
exp(GDPR)=g*exp(nGR)+exp(cR)+exp(iR);

//R23 Unempl. rate
-exp(unempR)+(exp(LR)-exp(lR))/exp(LR);

//R24 Job finding rate
-exp(fR)+exp(xR)*exp(lR(-1))/(exp(LR)-rho*exp(lR(-1))); 

//R25 Matching function
-exp(xR)*exp(lR(-1))+sigmam*(exp(LR)-rho*exp(lR(-1)))^sigma*(exp(vTotR))^(1-sigma);

//R26 Total vacancies
-exp(vTotR)+exp(vR)*exp(lR(-1));

//R27 Vacancy filling rate
-exp(QR)+exp(xR)/exp(vR);

//R28 Law of motion of employment  
-exp(lR)+(rho+exp(xR))*exp(lR(-1));

//R29 value of non-participation
-exp(NR)+exp(UcHR)/exp(psiR)*exp(nGR)+mR_tp1*exp(muR_tp1)*( exp(eR_tp1)*(exp(fR_tp1)*exp(VR_tp1)+(1-exp(fR_tp1))*exp(UR_tp1) - LcalR_tp1 )+(1-exp(eR_tp1))*exp(NR_tp1) );

//R30 probability of leaving non-participation
-exp(eR)+( exp(LR)-s*(exp(LR(-1))-rho*exp(lR(-1)))-rho*exp(lR(-1)) )/(1-exp(LR(-1)));
 
//R31 FOC employment
-exp(plR)+exp(wR)-exp(nGR)*D+mR_tp1*exp(muR_tp1)*exp(plR_tp1)*rho*(1-exp(fR_tp1));

//R32 FOC labor force participation 
exp(nGR)*D+exp(plR)*exp(fR)-exp(UcHR)/exp(psiR)*(exp(cHR)+FcalR)/(1-exp(LR))-exp(UcHR)/exp(psiR)*FcalLR-mR_tp1*exp(muR_tp1)*exp(UcHR_tp1)/exp(psiR_tp1)*FcalprimeLR;

//R33 home consumption
-exp(cHR)+exp(nGR)*(1-exp(LR))-FcalR; 

//R34 marginal utility of home consumption 
-exp(UcHR)+omega/(1-omega)*((exp(cHR)-b*exp(cHR(-1))/exp(muR))/(exp(cR)-b*exp(cR(-1))/exp(muR))   )^(chi-1)*exp(psiR);

//R35 LFP adjustment cost         
LcalR=exp(UcHR)/exp(psiR)*FcalLR+mR_tp1*exp(muR_tp1)*exp(UcHR_tp1)/exp(psiR_tp1)*FcalprimeLR;



////////////////////////////////////////////////////////////////////// 
//F economy, other shocks, current realization in info set /////////// 
////////////////////////////////////////////////////////////////////// 
%abbreviations (same as above)
#muzF_tp1=muzF(+1);
#muF_tp1=alfa/(1-alfa)*mupsiF(+1)+muzF_tp1;
#aofukprimeF=sigmab*sigmaa*(exp(ukF))+sigmab*(1-sigmaa);
#aofukprimeF_tp1=sigmab*sigmaa*(exp(ukF(+1)))+sigmab*(1-sigmaa);
#aofukF=0.5*sigmab*sigmaa*(exp(ukF))^2+sigmab*(1-sigmaa)*exp(ukF)+sigmab*((sigmaa/2)-1);
#aofukF_tp1=0.5*sigmab*sigmaa*(exp(ukF(+1)))^2+sigmab*(1-sigmaa)*exp(ukF(+1))+sigmab*((sigmaa/2)-1);
#RkF_tp1=log(((exp(ukF(+1))*aofukprimeF_tp1-aofukF_tp1)+(1-deltak)*exp(pkprimeF(+1)))/(exp(pkprimeF+mupsiF(+1)-piF(+1))));
#StildeF=(0.5*(exp(sqrt(Spp)*(exp(iF)/exp(iF(-1))*exp(muF)*exp(mupsiF)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))+exp(-sqrt(Spp)*(exp(iF)/exp(iF(-1))*exp(muF)*exp(mupsiF)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-2));
#StildeprimeF=(0.5*sqrt(Spp)*(exp(sqrt(Spp)*(exp(iF)/exp(iF(-1))*exp(muF)*exp(mupsiF)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-exp(-sqrt(Spp)*(exp(iF)/exp(iF(-1))*exp(muF)*exp(mupsiF)-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))));
#StildeprimeF_tp1=(0.5*sqrt(Spp)*(exp(sqrt(Spp)*(exp(iF(+1))/exp(iF)*exp(muF_tp1)*exp(mupsiF(+1))-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))-exp(-sqrt(Spp)*(exp(iF(+1))/exp(iF)*exp(muF_tp1)*exp(mupsiF(+1))-exp(STEADY_STATE(muF))*exp(STEADY_STATE(mupsiF))))));
#mcF=alfa*mupsiF+varthetF+log(nuf*(exp(RF))+1-nuf)-log(1-alfa)-alfa*(kbarF(-1)+ukF-muF-lF );
#pitildepiF=-piF+kappaf*piF(-1)+(1-kappaf-varkappaf)*log(pibar)+varkappaf*log(pibreve);
#pitildepiF_tp1=-piF(+1)+kappaf*piF+(1-kappaf-varkappaf)*log(pibar)+varkappaf*log(pibreve);
#FcalF=0.5*exp(nGF)*phiL*100*(exp(LF)/exp(LF(-1))-1)^2;                                                          
#FcalLF=exp(nGF)*phiL*100*(exp(LF)/exp(LF(-1))-1)*1/exp(LF(-1));                                                   
#FcalprimeLF=-exp(nGF(+1))*phiL*100*(exp(LF(+1))/exp(LF)-1)*exp(LF(+1))*(1/exp(LF))^2;
#mF_tp1=betta*exp(psiF(+1))/exp(psiF)*(exp(muF_tp1))^(-1); //asset pricing kernel
#ctildeF=( (1-omega)*(exp(cF)-b*exp(cF(-1))/exp(muF))^chi+omega*(exp(cHF)-b*exp(cHF(-1))/exp(muF))^chi )^(1/chi);




//F1 - Consumption FOC
exp(psiF)=(1-omega)*(ctildeF)^(-chi)*(exp(cF)-b*exp(cF(-1))/exp(muF))^(chi-1);

//F2 - Bond FOC (Fisher equation) 
1=mF_tp1*exp(RF)/exp(piF(+1));

//F3 - Investment FOC
1=exp(pkprimeF)*(1-StildeF-StildeprimeF*exp(muF)*exp(mupsiF)*exp(iF)/exp(iF(-1)))+mF_tp1*exp(muF_tp1)*exp(pkprimeF(+1))*StildeprimeF_tp1*(exp(iF(+1))/exp(iF))^2*exp(muF_tp1)*exp(mupsiF(+1));

//F4 - Capital FOC
1=mF_tp1*exp(RkF_tp1)/exp(piF(+1));

//F5 - Law of motion for physical capital
exp(kbarF)=(1-deltak)/(exp(muF)*exp(mupsiF))*exp(kbarF(-1))+(1-StildeF)*exp(iF);

//F6 - Cost minimization (opt. factor inputs)
0=aofukprimeF*exp(ukF)*exp(kbarF(-1))/(exp(muF)*exp(mupsiF))-alfa/(1-alfa)*(nuf*exp(RF)+1-nuf)*exp(lF)*exp(varthetF);

//F7 - Production
exp(yF)=exp(phaloF)^(lambda/(lambda-1))*( (exp(lF))^(1-alfa)*(exp(kbarF(-1)+ukF)/(exp(muF)*exp(mupsiF)))^alfa-phi*exp(nGF)); 

//F8 - Resource Constraint
exp(yF)=g*exp(nGF)+exp(cF)+exp(iF)+aofukF*exp(kbarF(-1))/(exp(mupsiF)*exp(muF))+kappa*exp(nGF)*exp(xF)*exp(lF(-1));

//F9 Monetary Policy Rule
RF=rhoR*RF(-1)+(1-rhoR)*(STEADY_STATE(RF)+rpi/4*(pi4F-STEADY_STATE(pi4F))+rdeltay/4*(GDPF-GDPF(-4)+muF+muF(-1)+muF(-2)+muF(-3)-4*STEADY_STATE(muF)));

//F10 Pricing 1
exp(FF)-exp(psiF+yF)-betta*xi*exp( pitildepiF_tp1 /(1-lambda)+FF(+1));

//F11 Pricing 2 
exp(KF)-lambda*exp(psiF+yF+mcF)-betta*xi*exp( pitildepiF_tp1*lambda/(1-lambda)+KF(+1));

//F12 Pricing 3
KF-FF=(1-lambda)*log((1-xi*exp( pitildepiF /(1-lambda)))/(1-xi));

//F13  Price dispersion
exp(phaloF*lambda/(1-lambda))-(1-xi)^(1-lambda)*(1-xi*exp( pitildepiF /(1-lambda)))^lambda-xi*(exp( pitildepiF +phaloF(-1)))^(lambda/(1-lambda));

//F14 Present value of wages
-exp(wpF)+exp(wF)+rho*mF_tp1*exp(muF_tp1)*exp(wpF(+1));

//F15 Present value of marginal revenue
-exp(varthetpF)+exp(varthetF)+rho*mF_tp1*exp(muF_tp1)*exp(varthetpF(+1));

//F16 Hiring FOC  - zero profit/free entry condition
-kappa*exp(nGF)+exp(JF);

//F17 Firm surplus
-exp(JF)+exp(varthetpF)-exp(wpF);

//F18 Value of work
-exp(VF)+exp(wpF)+exp(AAF);

//F19 Present value of worker payoff after separation 
-exp(AAF)+(1-rho)*mF_tp1*exp(muF_tp1)*(s*exp(fF(+1))*exp(VF(+1))+s*(1-exp(fF(+1)))*exp(UF(+1))+(1-s)*(exp(NF(+1))+LcalF(+1) ) )+rho*mF_tp1*exp(muF_tp1)*exp(AAF(+1));
 
//F20 Unemployment value
-exp(UF)+D*exp(nGF)+mF_tp1*exp(muF_tp1)*(s*exp(fF(+1))*exp(VF(+1))+s*(1-exp(fF(+1)))*exp(UF(+1))+(1-s)*(exp(NF(+1)) + LcalF(+1)) );

//F21 Sharing rule
-alp1*exp(JF)+alp2*(exp(VF)-exp(UF))-alp3*exp(nGF)*gamma+alp4*(exp(varthetF)-exp(nGF)*D);

//F22 GDP
exp(GDPF)=g*exp(nGF)+exp(cF)+exp(iF);

//F23 Unempl. rate
-exp(unempF)+(exp(LF)-exp(lF))/exp(LF);

//F24 Finding rate 
-exp(fF)+exp(xF)*exp(lF(-1))/(exp(LF)-rho*exp(lF(-1))); 

//F25 Matching function
-exp(xF)*exp(lF(-1))+sigmam*(exp(LF)-rho*exp(lF(-1)))^sigma*(exp(vTotF))^(1-sigma);

//F26 Total vacancies
-exp(vTotF)+exp(vF)*exp(lF(-1));

//F27 Vacancy filling rate
-exp(QF)+exp(xF)/exp(vF);

//F28 Law of motion of employment  
-exp(lF)+(rho+exp(xF))*exp(lF(-1));

//F29 Value of non-participation
-exp(NF)+exp(UcHF)/exp(psiF)*exp(nGF)+mF_tp1*exp(muF_tp1)*( exp(eF(+1))*(exp(fF(+1))*exp(VF(+1))+(1-exp(fF(+1)))*exp(UF(+1)) - LcalF(+1) )+(1-exp(eF(+1)))*exp(NF(+1)) );

//F30 Probability of leaving non-participation
-exp(eF)+( exp(LF)-s*(exp(LF(-1))-rho*exp(lF(-1)))-rho*exp(lF(-1)) )/(1-exp(LF(-1)));
 
//F31 FOC employment
-exp(plF)+exp(wF)-exp(nGF)*D+mF_tp1*exp(muF_tp1)*exp(plF(+1))*rho*(1-exp(fF(+1)));

//F32 FOC labor force participation 
exp(nGF)*D+exp(plF)*exp(fF)-exp(UcHF)/exp(psiF)*(exp(cHF)+FcalF)/(1-exp(LF))-exp(UcHF)/exp(psiF)*FcalLF-mF_tp1*exp(muF_tp1)*exp(UcHF(+1))/exp(psiF(+1))*FcalprimeLF;

//F33 Home consumption
-exp(cHF)+exp(nGF)*(1-exp(LF))-FcalF;  

//F34 Marginal utility of home consumption 
-exp(UcHF)+omega/(1-omega)*(   (exp(cHF)-b*exp(cHF(-1))/exp(muF))/(exp(cF)-b*exp(cF(-1))/exp(muF))   )^(chi-1)*exp(psiF);

//F35 LFP adjustment cost         
LcalF=exp(UcHF)/exp(psiF)*FcalLF+mF_tp1*exp(muF_tp1)*exp(UcHF(+1))/exp(psiF(+1))*FcalprimeLF;

//F36 Annual inflation (year-on-year)
pi4F=piF+piF(-1)+piF(-2)+piF(-3);


//////////////////////////
//Exogenous Variables/////
//////////////////////////

//E1 Composite technology growth
muF=alfa/(1-alfa)*mupsiF+muzF;

//E2 Unit root invest. Tech.
mupsiF=(1-rhomupsi)*STEADY_STATE(mupsiF)+rhomupsi*mupsiF(-1)+sig_mupsi*mupsi_eps/100;

//E3 Diffusion of composite technology 
exp(nGF)-(exp(nGF(-1)))^(1-thetaG)/exp(muF);

//E4 Shock to neutral technology growth (Wold representation of components representation)
muzF=( (1-rhomuz)*(1-rhomuzT) )*STEADY_STATE(muzF)+(rhomuz+rhomuzT)*muzF(-1)-(rhomuz*rhomuzT)*muzF(-2)+sig_eta*(muz_eps-theta1*muz_eps(-1)-theta2*muz_eps(-2))/100;

 
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
//A13
LAGG-STEADY_STATE(LF)=LR-STEADY_STATE(LF)+LF-STEADY_STATE(LF);
end; 
/////////////////////////////////
//End Model            //////////
/////////////////////////////////


//estimate model and display impulse responses
@# include "est_stoch_simulation.mod"

 
 