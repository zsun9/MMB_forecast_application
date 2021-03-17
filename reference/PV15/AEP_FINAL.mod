% Basic RBC Model 
% with consumption habits

%----------------------------------------------------------------
% 0. Housekeeping (close all graphic windows)
%----------------------------------------------------------------

close all;

%----------------------------------------------------------------
% 1. Defining variables
%----------------------------------------------------------------

var uh uc w r rr pi v d de n ne mk mc eta pic p c y yd h he hc  s_a s_g s_b s_i s_l s_n s_p s_w s_e s_r;
var z k i q u Phiu ku  
	mut_w wh pi_w mut_p mut_b
	ln_yd ln_y ln_pi ln_i ln_ne ln_rL ln_l ln_p ln_v
	y_obs c_obs i_obs pi_obs r_obs w_obs h_obs ne_obs rL_obs l_obs;
var rk rL l nn s omega mcb;
varexo e_a e_g e_b e_i e_l e_n e_p e_w e_e e_r;

parameters	beta alpha delta mu sigmaL chi Fe kappa_P xi_P epsilon gy hh chi_I chi_E psi rho phi_pi phi_pic phi_y phi_dy
			Q L_QK R eta_d N H RL sigmaC R obsFactor theta
			mu_P mu_W kappa_W xi_W u_p u_w 
			% shocks
			rho_a rho_g rho_b rho_i rho_l rho_n rho_p rho_w rho_e rho_r rho_ag;
parameters gamma wmin ka TT phi N_K varkappa epsilon_b kappa_L mu_B;

%----------------------------------------------------------------
% 2. Calibration
%----------------------------------------------------------------


%Parameters RBC Cycles
beta 		= 0.992; %Discount Factor
delta 		= 0.025;	%Depreciation rate
sigmaC 		= 1.5; %Elasticity of labor
sigmaL 		= 0.5; %Elasticity of labor
epsilon 	= 3.8; % Consumption habit
mu			= epsilon/(epsilon-1);
kappa_P 	= 40;
alpha 		= .4;
gy			= 0.18;
hh			= 0.7;
chi_I		= 8;
rho			= 0.8;
phi_pi		= 1.5;
phi_pic		= 0;
phi_dy		= 0.1;
phi_y		= 0.1;
psi			= .5;
chi_E 		= .5;

obsFactor	= 100;

mu_W 		= 1.5;
kappa_W  	= 45;
xi_W		= 0.5;
xi_P		= 0.5;

% autoregressive roots parameters
rho_a	= 0.92;
rho_g	= 0.95;
rho_b	= 0.95;
rho_i	= 0.8;
rho_l	= 0.8;
rho_n	= 0.8;
rho_p	= 0.8;
rho_w	= 0.8;
rho_e	= 0.2;
rho_r	= 0.2;
rho_ag	= 0;

u_p		= 0;
u_w		= 0;
Q 		= 1;
Fe 		= 5;
varkappa= 0.05;
kappa_L	= 20;
mu_B 	= 0.12;


%% Steady States
N_K		= 0.5;
L_QK	= 0.5;
eta_d 	= 0.02/4;
H 		= 1/3;

theta = 0.04*100;
gamma 		= 1;
R			= 1/beta;
RL			= (1+0.98/100)*R;

%----------------------------------------------------------------
% 3. Model
%----------------------------------------------------------------

model; 

	%%% HOUSEHOLD
	% utility derivative
	uh = chi*h^sigmaL;
	uc = (c-hh*c(-1))^-sigmaC;
	% labor supply
	uh/uc = wh;
	% Euler bond
	beta*uc(+1)/uc*rr*exp(s_b)=1;
	% Euler shares
	v = (1-delta)*(d(+1)+v(+1) + theta/100*de(+1) )/(rr*exp(s_b));	
	% dividends
	d = y*p*(1-kappa_P/2*(pi-1)^2-1/mk);

	%%% Unions
	% markup shock
	mut_w = mu_W*exp(s_w);
	% optimal wage setting
	w = mut_w*wh 
		- (mut_w-1)*w*kappa_W*( pi_w*pi + (pi_w*pic-(xi_W*pi(-1)+(1-xi_W))) )*(pi_w*pic-(xi_W*pic(-1)+(1-xi_W)))
		+ (mut_w-1)*w(+1)/(pi_w(+1)*pic(+1))*beta*uc(+1)/uc*kappa_W*( pi_w(+1)*pic(+1) - (xi_W*pi+(1-xi_W)) )*(pi_w(+1)*pic(+1))^2;
	% wage variation
	pi_w = w/w(-1);

	
	%%% FIRMS
	%% AGGREGATION
	% firms dynamics
	n = (1-delta)*(n(-1)+exp(s_e(-1))*(1-chi_E/2*(ne(-1)/ne(-2)-1)^2 )*ne(-1));
	% prices
	p = mk*mc;
	% variety effect
	%n*p^(1/(1-mut_p))=1;
	n*p^(1-epsilon)=1;
	% goods equilibrium
	n*y = (p^-epsilon)*yd;
	%% PRODUCTION DECISIONS
	% marginal cost
	mc = (1/exp(s_a))*(z/alpha)^alpha*(w/(1-alpha))^(1-alpha);
	% inputs
	w*hc/(1-alpha) = z*ku/alpha;
	% NK
	eta = pi*(pi-(xi_P*pi(-1)+(1-xi_P)))-beta*(1-delta)*( ((pi(+1)-(xi_P*pi+(1-xi_P)))^2)*(pi(+1)^2)*y(+1)*uc(+1)/(pic(+1)*uc*y) );
	% Markup effective vs desired
	mk = exp(s_p)*mut_p/((1-kappa_P*(pi-(xi_P*pi(-1)+(1-xi_P)))^2)+kappa_P*eta);
	mut_p = mu_P*exp(s_p);
	%% ENTRY DECISIONS
	% free entry
	Fe*w*(1+gamma*(rL/pic(+1)-1))/exp(s_a) = v*exp(s_e)*(1-chi_E/2*(3*(ne/ne(-1))^2+1-4*ne/ne(-1))) + beta*uc(+1)/uc*v(+1)*chi_E*exp(s_e(+1))*(ne(+1)/ne-1)*(ne(+1)/ne)^2;
	% prix relatifs
	pi/pic = p/p(-1);
	% production function
	n*y = exp(s_a)*(ku^alpha)*(hc^(1-alpha));
	% demand from entrant
	ne*Fe = exp(s_a)*he;

	
	
	%%% GENERAL EQUILIBRIUM
	% goods demand
	yd = c + i + gy*yd*exp(s_g) + Phiu*k(-1) + kappa_P/2*(pi-1)^2*yd + kappa_L/2*((rL-1)/(rL(-1)-1)-1)^2*yd;
	% labor market
	h = hc + he;


	%%% CAPITAL SUPPLIERS
	rk=(z*u-Phiu+(1-delta)*q)/q(-1);
	% investment equation
	exp(s_i)*(1-(chi_I/2)*(i/i(-1)-1)^2)*i = k-(1-delta)*k(-1);
	% asset price
	exp(s_i)*q = 1 + exp(s_i)*q*(chi_I/2)*( 1 + ( 3*i/i(-1)-4 )*i/i(-1) ) + beta*exp(s_i(+1))*uc(+1)/uc*(1-delta)*q(+1)*chi_I*(1-i(+1)/i)*(i(+1)/i)^2;
	% Optimal utilization rate
	z = STEADY_STATE(z)*exp((psi/(1-psi))*(u-1));
	% Cost function on utilization
	Phiu = ((1-psi)/psi)*STEADY_STATE(z)*(exp((psi/(1-psi))*(u-1))-1);
	% Capital Utilization
	ku = u*k(-1); 
	
	

    %%% ENTREPRENEUR
	% balance sheet
	l + nn = q*k + gamma*w*he;
	% Net wealth law of motion
	nn = (1-delta)*(1-theta/100)*de*n + TT ;
	% entrepreneurs
	de = ((wmin^ka)/(ka-1))*((omega^(1-ka))*rk*q(-1)*k(-1)/n)*exp(s_n);
	% Spread
	s = rk(+1)/(rL/pic(+1));
 	% FOC Cost-Of-Funds
	s = (phi^(((1-N_K)/N_K*varkappa)-1))*(((ka/(ka-1))*(l/(q*k)))^((1-N_K)/N_K*varkappa));
	% Ex post threshold
	omega*s(-1)*q(-1)*k(-1)=l(-1);
	
	
	
	%% Banks
	% Marginal cost of credit
	mcb = (r/( (wmin/omega(+1))^ka + (1-mu_B)*(1-(wmin/omega(+1))^ka)*(ka/(ka-1))*(((omega(+1)^(1-ka))-(wmin^(1-ka)))/((omega(+1)^(-ka))-(wmin^(-ka))))/omega(+1) ) -1);
	% NK rate
	(rL-1) = mut_b*mcb - (mut_b-1)*kappa_L*(rL-1)*((rL/rL(-1))-1)*(rL/rL(-1)) + kappa_L/(epsilon_b-1)*(rL-1)*beta*uc(+1)/uc*l(+1)/l*((rL(+1)/rL)-1)*(rL(+1)/rL);
	% mk
	mut_b = epsilon_b/(epsilon_b-1)*exp(s_l);
	
	% real rate
	rr = r/pic(+1);
	% MPR
	r-STEADY_STATE(r)= rho*(r(-1)-STEADY_STATE(r)) + (1-rho)*( phi_pi*(pic-1) + phi_pic*(pic-1) +  phi_y*(y-STEADY_STATE(y)) ) + phi_dy*(y-y(-1)) + s_r;
	
	
	%%% SHOCKS
	s_a = rho_a*s_a(-1)+e_a/obsFactor;
	s_g = rho_g*s_g(-1)+(e_g+rho_ag*e_a)/obsFactor;
	s_b = rho_b*s_b(-1)+e_b/obsFactor;
	s_i = rho_i*s_i(-1)+e_i/obsFactor;
	s_l = rho_l*s_l(-1)+100*e_l/obsFactor;
	s_n = rho_n*s_n(-1)+e_n/obsFactor;
	s_p = rho_p*s_p(-1)+100*(e_p-u_p*e_p(-1))/obsFactor;
	s_w = rho_w*s_w(-1)+100*(e_w-u_w*e_w(-1))/obsFactor;
	s_e = rho_e*s_e(-1)+e_e/obsFactor;
	s_r = rho_r*s_r(-1)+e_r/obsFactor;
	
	
	% Observables
	y_obs = obsFactor*log(yd/yd(-1));
	c_obs = obsFactor*log(c/c(-1));
	i_obs = obsFactor*log(i/i(-1));
	pi_obs = obsFactor*log(pic);
	r_obs = obsFactor*(r-STEADY_STATE(r));%
	w_obs = obsFactor*log(w/w(-1));
	h_obs = obsFactor*log(h/STEADY_STATE(h));
	ne_obs = obsFactor*( log(n/n(-1)/(1-delta)-1) - log(1/(1-delta)-1) );
	rL_obs = obsFactor*(rL/r-STEADY_STATE(rL)/STEADY_STATE(r));%
	l_obs = obsFactor*log(l/l(-1));%
	
	% log deviation
	ln_yd = log(yd/STEADY_STATE(yd));
	ln_y = log(y/STEADY_STATE(y));
	ln_pi = log(pi/STEADY_STATE(pi));
	ln_i = log(i/STEADY_STATE(i));
	ln_ne = log(ne/STEADY_STATE(ne));
	ln_rL = log(rL/STEADY_STATE(rL));
	ln_l = log(l/STEADY_STATE(l));
	ln_p = log(p/STEADY_STATE(p));
	ln_v = log(v/STEADY_STATE(v));

	
end;


resid(1);
steady;
check;

estimated_params;
//	PARAM NAME,		INITVAL,		LB,		UB,		PRIOR_SHAPE,		PRIOR_P1,		PRIOR_P2,		PRIOR_P3,		PRIOR_P4,		JSCALE
	stderr e_a,		0.5,		,		,		INV_GAMMA_PDF,		.1,				2;
	stderr e_g,		3,		,		,		INV_GAMMA_PDF,		.1,				2;
	stderr e_b,		0.4,		,		,		INV_GAMMA_PDF,		.1,				2;
	stderr e_i,		5.20,		,		,		INV_GAMMA_PDF,		.1,				2;
	stderr e_p,		0.07,		,		,		INV_GAMMA_PDF,		.1,				2;
	stderr e_w,		0.36,		,		,		INV_GAMMA_PDF,		.1,				2;
	stderr e_l,		0.27,		,		,		INV_GAMMA_PDF,		.1,				2;
	stderr e_r,		0.06,		,		,		INV_GAMMA_PDF,		.1,				2;
	stderr e_e,		2.40,		,		,		INV_GAMMA_PDF,		.1,				2;
	stderr e_n,		0.47,		,		,		INV_GAMMA_PDF,		.1,				2;
	rho_a,			0.95,		,		1,		beta_pdf,			.5,            	0.2;%root
	rho_g,			0.97,		,		1,		beta_pdf,			.5,             0.2;%root
	rho_b,			0.62,		,		1,		beta_pdf,			.5,             0.2;%root
	rho_i,			0.71,		,		1,		beta_pdf,			.5,             0.2;%root
	rho_p,			0.96,		,		1,		beta_pdf,			.5,             0.2;%root
	rho_w,			0.92,		,		1,		beta_pdf,			.5,             0.2;%root
	rho_l,			0.70,		,		1,		beta_pdf,			.5,             0.2;%root
	rho_e,			0.84,		,		1,		beta_pdf,			.5,             0.2;%root
	rho_n,			0.90,		,		1,		beta_pdf,			.5,             0.2;%root
	rho_r,			0.20,		,		1,		beta_pdf,			.5,             0.2;%root

	rho_ag,			0.85,		,		1,		beta_pdf,			.5,             0.2;%root

	u_p,			0.36,		,		1,		beta_pdf,			.5,             0.2;% ARMA
	u_w,			0.96,		,		1,		beta_pdf,			.5,             0.2;% ARMA
	

	sigmaC,			1.6,		,		,		normal_pdf,			1.5,			0.37; 
	sigmaL,			0.4,		,		,		beta_pdf,			.5,				.1; 
	phi_pi,			1.95,		1,		,		normal_pdf,			1.5,				0.15;
	phi_y,			0.0572,		0,		,		gamma_pdf,			0.125,			0.05;
	phi_dy,			0.2672,		0,		,		gamma_pdf,			0.125,			0.10;
	rho,			0.90,		,		1,		beta_pdf,			.75,             0.1;
	kappa_P,		47,			,		,		normal_pdf,			50,				5;
	xi_P,			0.2140,		,		,		beta_pdf,			.5,				0.15; 
	kappa_W,		60,			,		,		normal_pdf,			70,				5;
	xi_W,			0.2940,		,		,		beta_pdf,			.5,				0.15; 
	chi_I,			7.7818,		,		,		normal_pdf,			4,				1.5;
	hh,				0.60,		,		,		beta_pdf,			.7,				0.1;
	psi,			0.61,		,		,		beta_pdf,			0.5,             .10; 
	chi_E,			.7818,		,		,		normal_pdf,			.40,			0.10;
	varkappa,		0.05,		,		,		beta_pdf,			0.05,             .02; 
	mu_B,			.2,			,		,		beta_pdf,			.25,             .05; 
	kappa_L,		10,			,		,		normal_pdf,			10,				2.5;

	theta,		2,		,		,		normal_pdf,			5,             .75; 

end;

varobs 	y_obs h_obs pi_obs r_obs i_obs c_obs w_obs ne_obs  l_obs  rL_obs;% %      


estimation(
%datafile=data,xls_sheet=dataset,first_obs=2,nobs=198,xls_range=B1:G199
datafile=data,xls_sheet=datasetPV,presample=0,first_obs=1,nobs=78,xls_range=U173:AE252
%,mode_compute=0
,prefilter=1
,plot_priors=0
,lik_init=2
,mh_nblocks=4,mh_jscale=0.32,conf_sig = 0.90
%,mh_replic=120000
,mode_compute=0,mode_file=AEP_FINAL_mode,load_mh_file,mh_replic=0,mh_drop=.1 %if bug, use "mh_recover"
%,bayesian_irf,irf=20%,filtered_vars
) 
%y_obs h_obs pi_obs r_obs i_obs c_obs w_obs ne_obs  l_obs  rL_obs
ln_yd ln_y ln_pi ln_i ln_ne ln_rL ln_l ln_p ln_v;
