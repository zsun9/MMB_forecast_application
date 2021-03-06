/*
 * This file provides replication for the Galí, Jordá, Smets, Frank and Wouters, Rafael (2012)
 * model also estimated  in Smets, Frank, Anders Warne and Rafael Wouters (2014):
 * "Professsional forecasters and real-time forecasting with a DSGE model"
 * International Journal of Forecasting 30(4): 981-995
 * Implemented by Matyas Farkas based on the Yada code of Anders Warne (C)
 * and the SW07 model code of Johannes Pfeiffer (C)
 */

var 
    y           ${y}$           (long_name='Output')
    c           ${c}$           (long_name='Consumption')
    inve        ${i}$           (long_name='Investment')
    zcap        ${z}$           (long_name='Capital utilization rate') 
	lam 		${\lambda}$ 	(long_name='Log-linearlized Marginal Utility of Consumption')
    r           ${r}$           (long_name='nominal interest rate')
    pinf        ${\pi}$         (long_name='Inflation')
    lab         ${l}$           (long_name='hours worked')
    pk          ${q}$           (long_name='real value of existing capital stock') 
    rk          ${r^{k}}$       (long_name='rental rate of capital') 
    k           ${k^{s}}$       (long_name='Capital services') 
    kp          ${k}$           (long_name='Capital stock') 
    mc          ${\mu_p}$       (long_name='gross price markup') 
    w           ${w}$           (long_name='real wage')
	u 			${u}$ 			(long_name='unemployment')
	ex			${\kappa}$ 		(long_name='Smoothed trend in consumtion')
	ls			${l^{s}}$		(long_name='Labor supply')
	un			${u^n}$ 		(long_name='Natural rate of unemployment') // Not needed!
	e			${e}$			(long_name='Total employment')
    yf          ${y^{flex}}$    (long_name='Output flex price economy') 
    cf          ${c^{flex}}$    (long_name='Consumption flex price economy') 
    invef       ${i^{flex}}$    (long_name='Investment flex price economy') 
    zcapf       ${z^{flex}}$    (long_name='Capital utilization rate flex price economy') 
	lamf       	${\lambda^{flex}}$    (long_name='Log-linearlized Marginal Utility of Consumption flex price economy') 
    rrf         ${r^{flex}}$    (long_name='real interest rate flex price economy')
	labf        ${l^{flex}}$    (long_name='hours worked flex price economy') 
    pkf         ${q^{flex}}$    (long_name='real value of existing capital stock flex price economy')  
    rkf         ${r^{k,flex}}$  (long_name='rental rate of capital flex price economy') 
    kf          ${k^{s,flex}}$  (long_name='Capital services flex price economy') 
    kpf         ${k^{flex}}$    (long_name='Capital stock flex price economy') 
    wf          ${w^{flex}}$    (long_name='real wage flex price economy') 
	exf			${\kappa^{flex}}$ 	(long_name='Smoothed trend in consumtion flex price economy')
	ef			${e^{flex}}$		(long_name='Total employment flex price economy')
    g           ${\varepsilon^g}$       (long_name='Exogenous spending')
    b           ${c_2*\varepsilon_t^b}$ (long_name='Scaled risk premium shock')	
    qs          ${\varepsilon^i}$       (long_name='Investment-specific technology')	
	a           ${\varepsilon_a}$       (long_name='productivity process')
	spinf       ${\varepsilon^p}$       (long_name='Price markup shock process')
    epinfma     ${\eta^{p,aux}}$        (long_name='Auxiliary price markup moving average variable')  
	sw          ${\varepsilon^w}$       (long_name='Wage markup shock process')    
    ewma        ${\eta^{w,aux}}$ (long_name='Auxiliary wage markup moving average variable')  
    ms          ${\varepsilon^r}$       (long_name='Monetary policy shock process') 
	pss         ${\varepsilon^s}$       (long_name='Labor supply shock')
    ffr_obs        ${FEDFUNDS}$    (long_name='Federal funds rate') 
    gdpdef_obs     ${dlP}$         (long_name='Inflation') 
    gdp_rgd_obs    ${dlGDP}$       (long_name='Output growth rate') 
    c_rgd_obs      ${dlCONS}$      (long_name='Consumption growth rate') 
    ifi_rgd_obs    ${dlINV}$       (long_name='Investment growth rate') 
    wage_rgd_obs   ${dlWAG}$       (long_name='Wage growth rate') 
	emp_obs      ${dlE}$       	   (long_name='Total employment')
	unr_obs			${u}$       	   (long_name='Unemployment')
	;

/* Original SW07 observation variables are commented out
	hours_sw07_obs      ${lHOURS}$      (long_name='log hours worked') 
    ffr_obs        ${FEDFUNDS}$    (long_name='Federal funds rate') 
    gdpdef_obs     ${dlP}$         (long_name='Inflation') 
    gdp_rgd_obs          ${dlGDP}$       (long_name='Output growth rate') 
    c_rgd_obs          ${dlCONS}$      (long_name='Consumption growth rate') 
    ifi_rgd_obs       ${dlINV}$       (long_name='Investment growth rate') 
    wage_rgd_obs          ${dlWAG}$       (long_name='Wage growth rate') 
*/
        
 
varexo ea       ${\eta^a}$      (long_name='productivity shock')
    eb          ${\eta^b}$      (long_name='Investment-specific technology shock')
    eg          ${\eta^g}$      (long_name='Spending shock')
    eqs         ${\eta^i}$      (long_name='Investment-specific technology shock')
    em          ${\eta^m}$      (long_name='Monetary policy shock')
    epinf       ${\eta^{p}}$    (long_name='Price markup shock')  
    ew          ${\eta^{w}}$    (long_name='Wage markup shock') 
	es 			${\eta^{s}}$    (long_name='Labor supply shock') 
        ;  
 
parameters 
//curvw ${\varepsilon_w}$  (long_name='Curvature Kimball aggregator wages')  
    cgy         ${\rho_{ga}}$       (long_name='Feedback technology on exogenous spending')  
    curvp       ${\varepsilon_p}$   (long_name='Curvature Kimball aggregator prices')  
//    constelab   ${\bar l}$          (long_name='steady state hours')  
    constepinf  ${\bar \pi}$        (long_name='steady state inflation rate')  
    constebeta  ${100(\beta^{-1}-1)}$ (long_name='time preference rate in percent')  
    cmaw        ${\mu_w}$           (long_name='coefficient on MA term wage markup')  
    cmap        ${\mu_p}$           (long_name='coefficient on MA term price markup')  
    calfa       ${\alpha}$          (long_name='capital share')  
    czcap       ${\psi}$            (long_name='capacity utilization cost')  
    csadjcost   ${\varphi}$         (long_name='investment adjustment cost')  
    ctou        ${\delta}$          (long_name='depreciation rate')  
    csigma      ${\sigma_c}$        (long_name='risk aversion')  
    chabb       ${\lambda}$         (long_name='external habit degree')  
//    ccs         ${d_4}$             (long_name='Unused parameter')  
//    cinvs       ${d_3}$             (long_name='Unused parameter')  
    cfc         ${\phi_p}$          (long_name='fixed cost share')  
    cindw       ${\iota_w}$         (long_name='Indexation to past wages')  
    cprobw      ${\xi_w}$           (long_name='Calvo parameter wages')   
    cindp       ${\iota_p}$         (long_name='Indexation to past prices')  
    cprobp      ${\xi_p}$           (long_name='Calvo parameter prices')   
    csigl       ${\sigma_l}$        (long_name='Frisch elasticity')   
    clandaw     ${\phi_w}$          (long_name='Gross markup wages')   
//    crdpi       ${r_{\Delta \pi}}$  (long_name='Unused parameter')  
    crpi        ${r_{\pi}}$         (long_name='Taylor rule inflation feedback') 
    crdy        ${r_{\Delta y}}$    (long_name='Taylor rule output growth feedback') 
    cry         ${r_{y}}$           (long_name='Taylor rule output level feedback') 
    crr         ${\rho}$            (long_name='interest rate persistence')  
    crhoa       ${\rho_a}$          (long_name='persistence productivity shock')  
    // crhoas      ${d_2}$             (long_name='Unused parameter')  
    crhob       ${\rho_b}$          (long_name='persistence risk premium shock')  
    crhog       ${\rho_g}$          (long_name='persistence spending shock')  
	//   crhols      ${d_1}$             (long_name='Unused parameter')  
    crhoqs      ${\rho_i}$          (long_name='persistence risk premium shock')  
    crhoms      ${\rho_r}$          (long_name='persistence monetary policy shock')  
    crhopinf    ${\rho_p}$          (long_name='persistence price markup shock')  
    crhow       ${\rho_w}$          (long_name='persistence wage markup shock')  
    ctrend      ${\bar \gamma}$     (long_name='net growth rate in percent')  
    cg          ${\frac{\bar g}{\bar y}}$     (long_name='steady state exogenous spending share')  
	cupsilon   	${\upsilon}$     	(long_name='Weight on the marginal utility in consumption trend smoothing')
	cprobe      ${\xi_e}$           (long_name='Calvo parameter employment')
    crhos       ${\rho_s}$          (long_name='persistence labor supply shock')  
	cebar 		${\bar{e}}$ 		(long_name='steady state level of log total employment')
	//cubar 		${\bar{u}}$ 		(long_name='steady state level of log unemployment')	
    ;

// fixed parameters
ctou=.025; 			% POK
cg=0.18;			% POK
curvp=10;			% POK

csigma = 1;  % In SW it was estimated with init: csigma=1.5;
clandaw=1.5;		
//curvw=10;

// estimated parameters initialisation



csadjcost= 4; 		% POK
chabb=    0.55; 	% POK    
csigl=    3.4; 		% POK
cprobw=   0.65;		% POK
cprobp=   0.66;		% POK
cindw=    0.13;		% POK
cindp=    0.25;		% POK
czcap=    0.75;		% POK
cfc=	   1.5;     % POK
cupsilon = 0.15;	% POK
crpi=     1.8;  	% POK
crr=      0.86;		% POK
cry=      0.13;		% POK
crdy=     0.22;		% POK
constepinf=0.73; 	% POK
cprobe = 0.5;		% POK
cebar = 0.2; 		% POK
ctrend=0.32;		% POK

constebeta=0.7420;

calfa = 0.18; 		% POK
crhog=0.975;		% POK
cgy=0.55;			% POK	
crhob=0.25;			% POK
crhoqs=0.7;			% POK
crhoa=0.975;   		% POK
crhopinf=0.88;		% POK
crhow=0.975;		% POK
crhoms=0.06;		% POK
crhos = 0.999; 		% POK
cmap = 0;			% POK 
cmaw  = 0;			% POK	

// crhols=   0.9928;
// crhoas=1; 
//constelab=0;


model(linear); 
//deal with parameter dependencies; taken from usmodel_stst.mod 
#clandap=cfc;                   %fixed cost share/gross price markup

#cgamma=1+ctrend/100 ;          %gross growth rate OK
#cpie=1+constepinf/100;         %gross inflation rate OK
#cbeta=1/(1+constebeta/100);    %discount factor OK
#cbetabar=cbeta*cgamma^(-csigma);   %growth-adjusted discount factor in Euler equation OK 
#cr = 100*((cpie/cbetabar)-1);		%steady state net real interest rate OK  in SW: #cr=cpie/(cbeta*cgamma^(-csigma));  %steady state net real interest rate
//#cubar = (clandaw-1)/csigmal; 		%unemployment rate in SS  OK  NOT NEEDED!
#crk=1/cbetabar - (1-ctou); %R^k_{*}: steady state rental rate OK
#cw = (calfa^calfa*(1-calfa)^(1-calfa)/(clandap*crk^calfa))^(1/(1-calfa));      %steady state real wage OK
//cw = (calfa^calfa*(1-calfa)^(1-calfa)/(clandap*((cbeta^(-1))*(cgamma^csigma) - (1-ctou))^calfa))^(1/(1-calfa));
#cik=cgamma + ctou -1;    %i_k: investment-capital ratio OK
#clk=((1-calfa)/calfa)*(crk/cw);    %labor to capital ratio OK
#cky=cfc*(clk)^(calfa-1);           %k_y: steady state output ratio OK 
#ciy=cik*cky;                       %consumption-investment ratio OK 
#ccy=1-cg-ciy;                  	%consumption-output ratio OK
#crkky=crk*cky;                     %z_y=R_{*}^k*k_y
#whlcstar = (1-calfa)/(clandaw*ccy); % Steady-state real-wage bill to consumption ration
#cikbar=(1-(1-ctou)/cgamma);        %k_1 in equation LOM capital, equation (8)

//#cwhlc=(1/clandaw)*(1-calfa)/calfa*crk*cky/ccy; %W^{h}_{*}*L_{*}/C_{*} used in c_2 in equation (2)
//#cwly=1-crk*cky;                    %unused parameter
//#conster=(cr-1)*100;                %steady state federal funds rate ($\bar r$)


// flexible economy

		[name='Aggregate Production Function, flex price economy, GSW Equation (1), flex price']
          yf = cfc*( calfa*kf+(1-calfa)*labf +a ); % OK
		[name='Consumption Euler Equation, GSW Equation (2), flex price']
		  lamf = lamf(+1) + rrf - (csigma*(1+chabb/cgamma))/(1-chabb/cgamma) *b; % OK
	    [name='Log-linearized MU, GSW Equation (3), flex price']	
		  lamf = - csigma /(1-chabb/cgamma) * cf + csigma * chabb/cgamma /(1- chabb/cgamma) * cf(-1) + (csigma-1)* whlcstar /(1-chabb/cgamma) * labf; % OK
		[name='Investment Euler Equation, GSW Equation (4), flex price economy']
	      invef = (1/(1+cbetabar*cgamma))* (  invef(-1) + cbetabar*cgamma*invef(+1)+(1/(cgamma^2*csadjcost))*pkf ) +qs ; % OK
		[name='Arbitrage equation value of capital, GSW Equation (5), flex price economy']	
          pkf = -rrf-0*b+(1/((1-chabb/cgamma)/(csigma*(1+chabb/cgamma))))*b +(crk/(crk+(1-ctou)))*rkf(+1) +  ((1-ctou)/(crk+(1-ctou)))*pkf(+1) ; % OK
		[name='Aggregate Resource Constraint,  GSW Equation (6), flex price economy']
	      yf = ccy*cf+ciy*invef+g  +  crkky*zcapf ; % OK 
		[name='Definition capital services, GSW Equation (7), flex price economy']
	      kf =  kpf(-1)+zcapf ;		  
		[name='FOC capacity utilization, GSW Equation (8), flex price economy']
	      zcapf =  (1/(czcap/(1-czcap)))* rkf;
        [name='Law of motion for capital, GSW Equation (9), flex price economy ']              
	      kpf =  (1-cikbar)*kpf(-1)+(cikbar)*invef + (cikbar)*(cgamma^2*csadjcost)*qs;
        [name='FOC labor with mpl expressed as function of rk and w, GSW Equation (10), flex price economy']
	      0*(1-calfa)*a + 1*a =  calfa*rkf+(1-calfa)*(wf)  ;
	    [name='Firm FOC capital, GSW Equation (12), flex price economy']
	      rkf =  (wf)+labf-kf ;
        [name='Smoothed trend in Consumtion equation, GSW Equation (15), flex price']
		  exf = (1-cupsilon) * exf(-1) + (cupsilon/(1-chabb/cgamma)) * (cf - chabb/cgamma * cf(-1)); % OK
        [name='Wage equation, GSW Equation (16) and (17)flex price economy']
	      wf = csigl*labf 	
				+ exf - (1/(1-chabb/cgamma))*(cf - (chabb/cgamma)*cf(-1)) 
				- lamf 
				+ pss;  % OK
		[name='Auxilliary equation to link the observed total employment to the unobserved hours worked, GSW Equation (20) ,flex price'] 
          ef = cbeta * (ef(+1)-ef) + ef(-1) + (((1-cbeta*cprobe)*(1-cprobe))/cprobe)*(labf-ef); % OK

	      // [name='Consumption Euler Equation, flex price economy']
	      // cf = (chabb/cgamma)/(1+chabb/cgamma)*cf(-1) + (1/(1+chabb/cgamma))*cf(+1) +((csigma-1)*cwhlc/(csigma*(1+chabb/cgamma)))*(labf-labf(+1)) - (1-chabb/cgamma)/(csigma*(1+chabb/cgamma))*(rrf+0*b) + b ;


// sticky price - wage economy
		[name='Aggregate Resource Constraint, SW Equation (1), GSW Equation (1) ']
			y = ccy*c+ciy*inve+g  +  1*crkky*zcap ; % OK
		[name='Consumption Euler Equation, GSW Equation (2)']
			lam = lam(+1) + r - pinf(+1) - (csigma*(1+chabb/cgamma))/(1-chabb/cgamma) *b; % OK
					// 		[name='Consumption Euler Equation, SW Equation (2)']
					//	      c = (chabb/cgamma)/(1+chabb/cgamma)*c(-1) 
					//                + (1/(1+chabb/cgamma))*c(+1) 
					//               +((csigma-1)*cwhlc/(csigma*(1+chabb/cgamma)))*(lab-lab(+1)) 
					//               - (1-chabb/cgamma)/(csigma*(1+chabb/cgamma))*(r-pinf(+1) + 0*b) +b ;
		[name='Log-linearized MU, GSW Equation (3)']	
			lam = - csigma /(1-chabb/cgamma) * c + csigma * chabb/cgamma /(1- chabb/cgamma) * c(-1) + (csigma-1)* whlcstar /(1-chabb/cgamma) * lab; % OK
        [name='Investment Euler Equation, SW Equation (3), GSW Equation (4)']
			inve = (1/(1+cbetabar*cgamma))* (inve(-1) + cbetabar*cgamma*inve(+1)+(1/(cgamma^2*csadjcost))*pk ) +qs ; % OK
		[name='Arbitrage equation value of capital, SW Equation (4), GSW Equation (5)']
			pk = -r+pinf(+1)-0*b 
                + (1/((1-chabb/cgamma)/(csigma*(1+chabb/cgamma))))*b 
                + (crk/(crk+(1-ctou)))*rk(+1) 
                + ((1-ctou)/(crk+(1-ctou)))*pk(+1) ; %  OK
		[name='Aggregate Production Function, SW Equation (5), GSW Equation (6)']
			y = cfc*( calfa*k+(1-calfa)*lab +a ); % OK
		[name='Definition capital services, SW Equation (6), GSW Equation (7)']
			k =  kp(-1)+zcap ; % OK
		[name='FOC capacity utilization, SW Equation (7), GSW Equation (8)']
			zcap =  (1/(czcap/(1-czcap)))* rk ; % OK
		[name='Law of motion for capital, SW Equation (8), GSW Equation (9)']              
			kp =  (1-cikbar)*kp(-1)+cikbar*inve + cikbar*cgamma^2*csadjcost*qs ; % OK
		[name='FOC labor with mpl expressed as function of rk and w, SW Equation (9), GSW Equation (10)']
			mc =  calfa*rk+(1-calfa)*(w) - a ; % OK - did feature  "- 0*(1-calfa)*a " entry in SW
        [name='New Keynesian Phillips Curve, SW Equation (10), GSW Equation (11)']
			pinf =  (1/(1+cbetabar*cgamma*cindp)) * ( cbetabar*cgamma*pinf(+1) +cindp*pinf(-1) 
               +((1-cprobp)*(1-cbetabar*cgamma*cprobp)/cprobp)/((cfc-1)*curvp+1)*(mc)  )  + spinf ; % OK	     
        [name='Firm FOC capital, SW Equation (11), GSW Equation (12)']
			rk =  w+lab-k ; % OK
        [name='Wage Phillips Curve, SW Equation (12,13), GSW Equation (13)']
			w =  (1/(1+cbetabar*cgamma))*w(-1)
               +(cbetabar*cgamma/(1+cbetabar*cgamma))*(w(+1) + pinf(+1))
               -(1+cbetabar*cgamma*cindw)/(1+cbetabar*cgamma)*pinf
               +(cindw/(1+cbetabar*cgamma))*pinf(-1)
               -(((1-cbetabar*cgamma*cprobw)*(1-cprobw))/((1+cbetabar*cgamma)*cprobw*(clandaw*csigl/(clandaw-1))))*csigl*u				 
               + sw ; % OK
			   // Used to feature in 6th row the following +(1-cprobw)*(1-cbetabar*cgamma*cprobw)/((1+cbetabar*cgamma)*cprobw)*(1/((clandaw-1)*curvw+1))* (csigl*lab + (1/(1-chabb/cgamma))*c - ((chabb/cgamma)/(1-chabb/cgamma))*c(-1) -w)
        [name='Taylor rule, SW Equation (14), GSW Equation (14)']
			r =  crpi*(1-crr)*pinf
               +cry*(1-crr)*(y-yf)     
               +crdy*(y-yf-y(-1)+yf(-1))
               +crr*r(-1)
               +ms  ; % OK
        [name='Smoothed trend in Consumtion equation, GSW Equation (15)']
			ex = (1-cupsilon) * ex(-1) + (cupsilon/(1-chabb/cgamma)) * (c - chabb/cgamma * c(-1)); % OK
        [name='Labor supply Equation, GSW Equation (16) and (17) combined']
			w = csigl * ls 
				+ ex - (1/(1-chabb/cgamma))*(c-chabb/cgamma*c(-1))
				- lam 
				+ pss; % OK
        [name='Unemployment definition, GSW Equation (18)'] 
			u = ls - e ; % OK
        [name='Natural rate of unemployment, GSW Equation (19)'] 
			un = (((1 + (cbetabar*cgamma)) * cprobw *((clandaw *csigl)/(clandaw-1))/(1-(cbetabar*cgamma*cprobw))*(1-cprobw)*csigl))*sw; % OK
		[name='Auxilliary equation to link the observed total employment to the unobserved hours worked, GSW Equation (20)'] 
			e = cbeta * (e(+1)-e) + e(-1) + (((1-cbeta*cprobe)*(1-cprobe))/cprobe)*(lab-e); % OK
// Shock definitions 
		[name='Law of motion for productivity']                
	      a = crhoa*a(-1)  + ea; % OK 
        [name='Law of motion for risk premium']              
	      b = crhob*b(-1) + eb; % OK 
        [name='Law of motion for spending process']              
	      g = crhog*(g(-1)) + eg + cgy*ea; % OK 
	    [name='Law of motion for investment specific technology shock process']              
          qs = crhoqs*qs(-1) + eqs; % OK 
        [name='Law of motion for monetary policy shock process']              
	      ms = crhoms*ms(-1) + em; % OK 
        [name='Law of motion for price markup shock process']              
	      spinf = crhopinf*spinf(-1) + epinfma - cmap*epinfma(-1); % OK 
	      epinfma=epinf; % OK 
        [name='Law of motion for wage markup shock process']              
	      sw = crhow*sw(-1) + ewma - cmaw*ewma(-1) ; % OK 
	      ewma=ew; % OK 
		[name='Law of motion for labor supply shock process']              
		  pss = crhos * pss(-1) + es; % OK 
         

// measurement equations
[name='Observation equation output']              
gdp_rgd_obs=y-y(-1)+ctrend+cebar; % OK 
[name='Observation equation consumption']              
c_rgd_obs=c-c(-1)+ctrend+cebar; % OK
[name='Observation equation investment']              
ifi_rgd_obs=inve-inve(-1)+ctrend+cebar; % OK
[name='Observation equation real wage']              
wage_rgd_obs=w-w(-1)+ctrend; % OK
[name='Observation equation inflation']              
gdpdef_obs = 1*(pinf) + constepinf;  % OK
[name='Observation equation interest rate']              
ffr_obs =    1*(r) + 4*cr;  % OK
// [name='Observation equation hours worked']              
// hours_sw07_obs = lab + constelab;
[name='Observation equation for total employment ']              
emp_obs = e - e(-1) + cebar; % OK
[name='Observation equation for unemployment']              
unr_obs =u + 100 * (clandaw-1)/csigl; % OK
end; 

steady_state_model;
gdp_rgd_obs=ctrend+cebar; % OK
c_rgd_obs=ctrend + cebar; % OK
ifi_rgd_obs=ctrend + cebar; % OK 
wage_rgd_obs=ctrend; % OK 
gdpdef_obs = constepinf; % OK
ffr_obs = (((1+constepinf/100)/((1/(1+constebeta/100))*(1+ctrend/100)^(-csigma)))-1)*400; % OK
emp_obs = cebar; % OK
unr_obs = 100*(clandaw-1)/csigl; % OK
//hours_sw07_obs = constelab;
end;

shocks;
var ea;
stderr 0.48;
var eb;
stderr 1.8;
var eg;
stderr 0.49;
var eqs;
stderr 0.42;
var em;
stderr 0.22;
var epinf;
stderr 0.06;
var ew;
stderr 0.05;
var es;
stderr 1;
end;


estimated_params;
// PARAM NAME, INITVAL, LB, UB, PRIOR_SHAPE, PRIOR_P1, PRIOR_P2, PRIOR_P3, PRIOR_P4, JSCALE
// PRIOR_SHAPE: BETA_PDF, GAMMA_PDF, NORMAL_PDF, INV_GAMMA_PDF
csadjcost,	4,,,		NORMAL_PDF,4,1.5; % POK
chabb,0.55,0.001,0.999,	BETA_PDF,0.7,0.1; % POK
csigl,3.4,,,			NORMAL_PDF,2,0.75; % POK
cprobw,0.65,0.001,0.999,	BETA_PDF,0.5,0.05; 	% POK
cprobp,0.66,0.001,0.999,	BETA_PDF,0.5,0.1;  	% POK
cindw,0.13,0.001,0.999,		BETA_PDF,0.5,0.15;	% POK
cindp,0.25,0.001,0.999,		BETA_PDF,0.5,0.15;	% POK
czcap,0.75,0.001,0.999,		BETA_PDF,0.5,0.15;  % POK
cfc,1.5,,,					NORMAL_PDF,1.25,0.125; % POK
clandaw,1.5,,,				NORMAL_PDF,1.25,0.125; % POK
cupsilon,0.15,0,1,			BETA_PDF,0.2,0.05;  % POK
crpi,1.8,,,					NORMAL_PDF,1.5,0.25;% POK
crr,0.86,0,0.975,			BETA_PDF,0.75,0.10;	% POK
cry,0.13,,,					NORMAL_PDF,0.125,0.05; 	% POK , potentially limit to 0.001 and 0.5 if needed as in SW
crdy,0.22,,,				NORMAL_PDF,0.125,0.05; 	% POK , potentially limit to 0.001 and 0.5 if needed as in SW
constepinf,0.73,,,			GAMMA_PDF,0.625,0.1; 	% POK , if needed limit to 0.1,2.0
cprobe,0.5,0,1,				BETA_PDF,0.5,0.15;	% POK
constebeta,0.13,0.001,,		GAMMA_PDF,0.25,0.1;	% POK
cebar,0.2,,,				NORMAL_PDF,0.2,0.05;% POK
ctrend,0.32,,,				NORMAL_PDF,0.3,0.05; 		% POK in SW : ctrend,0.3982,0.1,0.8,NORMAL_PDF,0.4,0.10;
calfa,0.18,,,				NORMAL_PDF,0.3,0.05;		% POK
crhog,.975,.01,.9999,		BETA_PDF,0.5,0.20;	% POK
cgy,0.55,0.01,0.999,		BETA_PDF,0.5,0.20; 	% POK in SW: cgy,0.05,0.01,2.0,			NORMAL_PDF,0.5,0.25;
crhob,.25,.01,.9999,		BETA_PDF,0.5,0.20;	% POK
crhoqs,.7,.01,.9999,		BETA_PDF,0.5,0.20;	% POK
crhoa,.975 ,.01,.9999,		BETA_PDF,0.5,0.20;	% POK
crhopinf,.88,.01,.9999,		BETA_PDF,0.5,0.20;  % POK
crhow,.975,.001,.9999,		BETA_PDF,0.5,0.20;	% POK
crhoms,.06,.01,.9999,		BETA_PDF,0.5,0.20;	% POK
crhos,0.999,0,1,			BETA_PDF,0.5,0.20;	% POK
//cmap,.59,0.01,.9999,		BETA_PDF,0.5,0.2;	% THESE PARAMETERS ARE CALIBRATED TO BE ZERO!!! in SWW! SW had an initialisation .7652
//cmaw,.67,0.01,.9999,		BETA_PDF,0.5,0.2;	% THESE PARAMETERS ARE CALIBRATED TO BE ZERO!!! in SWW! SW had an initialisation .8936
stderr ea,0.48,0,5,			UNIFORM_PDF,2.5,1.443376; % POK SW used to be INV_GAMMA_PDF,0.1,2;
stderr eb,1.8,0,5,			UNIFORM_PDF,2.5,1.443376; % POK 
stderr eg,0.49,0,5,			UNIFORM_PDF,2.5,1.443376; % POK
stderr eqs,0.06,0,5,		UNIFORM_PDF,2.5,1.443376; % POK
stderr em,0.22,0,5,			UNIFORM_PDF,2.5,1.443376; % POK
stderr epinf,0.06,0,5,		UNIFORM_PDF,2.5,1.443376; % POK
stderr ew,0.05,0,5,			UNIFORM_PDF,2.5,1.443376; % POK
stderr es,1,0,5,			UNIFORM_PDF,2.5,1.443376; % POK
end;

varobs   ffr_obs    gdpdef_obs   gdp_rgd_obs    c_rgd_obs     ifi_rgd_obs    wage_rgd_obs   emp_obs      unr_obs;
//estimation(smoother,consider_all_endogenous,optim=('MaxIter',800),datafile=data,mode_compute=4,first_obs=1, presample=20,mh_replic=1000,mh_nblocks=2,mh_jscale=0.25,mh_drop=0.2,tex,nograph);
//write_latex_prior_table;  

/*
//****************************************************************************
//check the starting values for the steady state
//****************************************************************************
//resid;
//****************************************************************************
// compute steady state given the starting values
//****************************************************************************
//steady;
//****************************************************************************
// check Blanchard-Kahn-conditions
//****************************************************************************
//check;
//****************************************************************************
// compute policy function at first order, do IRFs and compute moments with HP-filter
//****************************************************************************
//stoch_simul(order=1,irf=40,hp_filter=1600) gdp_rgd_obs;
*/

estimation(nodisplay, smoother, order=1, prefilter=0, datafile=data_20200211, xls_sheet=s4, xls_range=B1:BE101, presample=4, mh_replic=1000000, mh_nblocks=1, mh_drop=0.3, mh_tune_jscale=0.3, sub_draws=5000, forecast=40, mode_compute=6) gdp_rgd_obs gdpdef_obs;