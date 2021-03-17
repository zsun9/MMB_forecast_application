function [ys,check] = FA2c_2nd_loss_steadystate(ys,exe)
beta = NaN;alpha = NaN;sigma = NaN;gamma=NaN;

global M_ lgy_

if isfield(M_,'param_nbr') == 1
NumberOfParameters = M_.param_nbr;
for iii = 1:NumberOfParameters
  paramname = deblank(M_.param_names(iii,:));
  eval([ paramname ' = M_.params(' int2str(iii) ');']);
end
check = 0;
end
% ----------------------------------------------------------------------------------------------




% financial aspects
wmin 		= 1-L_QK;
ka			= 1/L_QK;
OMEGA 		= wmin*(1-eta_d)^(-1/ka);
MCL 		= (R/( (wmin/OMEGA)^ka + (1-mu_B)*(1-(wmin/OMEGA)^ka)*(ka/(ka-1))*(((OMEGA^(1-ka))-(wmin^(1-ka)))/((OMEGA^(-ka))-(wmin^(-ka))))/OMEGA ) );


mu_L		= (RL-1)/(MCL-1);
epsilon_b	= mu_L/(mu_L-1);
Rk 			= (RL/OMEGA)*(1-L_QK);
eta_d 		= 1-(wmin/OMEGA)^ka;
eta_s 		= (wmin/OMEGA)^ka;
w_sup 		= (ka/(ka-1))*OMEGA;
w_inf 		= (ka/(ka-1))*(((OMEGA^(1-ka))-(wmin^(1-ka)))/((OMEGA^(-ka))-(wmin^(-ka))));

Z		= Rk -(1-delta);
mu_P	= epsilon/(epsilon-1);
%N		= H/( (1-beta*(1-delta))/((mu_P-1)*beta*(1-delta))*Fe*(1+gamma*(RL-1))*(1-alpha)+delta/(1-delta)*Fe);
N		= H/( (1-beta*(1-delta))/((mu_P-1+theta/100*eta_s*OMEGA*Rk*Q*alpha/((ka-1)*Z))*beta*(1-delta))*Fe*(1+gamma*(RL-1))*(1-alpha)+delta/(1-delta)*Fe);
NE 		= delta/(1-delta)*N;
P 		= N^(1/(epsilon-1));
He 		= Fe*NE;
MC 		= P/mu_P;
HC		= H-He;
W 		= (1-alpha)*(MC*(alpha/Z)^alpha)^(1/(1-alpha));
K 		= alpha/(1-alpha)*W*HC/Z;
Y 		= K^alpha*HC^(1-alpha)/N;
I 		= delta*K;
Yd 		= N*Y*P^epsilon;
C 		= Yd*(1-gy) - I;
D 		= Y*P*(1-1/mu_P);
UC 		= (C-hh*C)^-sigmaC;
Wh 		= W/mu_W;
UH 		= UC*Wh;
chi 	= UH*H^-sigmaL;

L		= L_QK*Q*K;
NN 		= (Q*K+gamma*W*He-L);
DE		= ((wmin^ka)/(ka-1))*((OMEGA^(1-ka))*Rk*Q*K/N);%eta_s*(w_sup*Rk*K-RL*(K-NN));
phi 	= w_sup^(1-(((1-N_K)/N_K*varkappa)/(((1-N_K)/N_K*varkappa)-1)));
S 		= Rk/RL;
TT 		= NN - (1-delta)*(1-theta/100)*DE*N;
MCB		= (RL-1)*(epsilon_b-1)/(epsilon_b);
V 		= beta*(1-delta)/(1-beta*(1-delta))*(D+theta/100*DE);


	r = R;
	rr = R;
	eta = 0;
	mk = mu_P;
	mc = MC;
	hc = HC;
	pi = 1;
	pic = 1;
	d = D;
	n = N;
	ne = NE;
	p = P;
	y = Y;
	yd = Yd;
	c = C;
	uc = UC;
	uh = UH;
	he = He;
	v = V;
	w = W;
	n = N;
	h = H;
	z = Z;
	i = I;
	k = K;
	u = 1;
	Phiu = 0;
	ku = K;
	q = 1;
	rk = Rk;
	rL = RL;
	mcb = MCL-1;
	l = L;
	nn = NN;
	s = S;
	omega = OMEGA;
	mut_w = mu_W;
	mut_p = mu_P;
	mut_b = epsilon_b/(epsilon_b-1);
	wh = Wh;
	de = DE;
	pi_w = 1;
	s_a = 0;
	s_g = 0;
	s_b = 0;
	s_i = 0;
	s_l = 0;
	s_n = 0;
	s_p = 0;
	s_w = 0;
	s_e = 0;
	s_r = 0;
	
	ln_yd = 0; ln_y = 0; ln_pi = 0; ln_i = 0; ln_ne = 0; ln_rL = 0; ln_l = 0; ln_p = 0; ln_v = 0; 
	y_obs = 0; c_obs = 0; i_obs = 0; pi_obs = 0; r_obs = 0; w_obs = 0; h_obs = 0; ne_obs = 0; rL_obs = 0; l_obs = 0;
% disp(num2str(console_count))
%console_count = console_count +1;
% ----------------------------------------------------------------------------------------------
for iter = 1:length(M_.params)
	%if console_count > 2
	%	disp(['-- ' M_.param_names(iter,:) ' = (' num2str(M_.params(iter)) ');']);
	%end
	eval([ 'M_.params(' num2str(iter) ') = ' M_.param_names(iter,:) ';' ])
end

%if console_count > 2
%	eval([ 'M_.params(' num2str(length(M_.params)) ') = 0;' ])
%end


if isfield(M_,'param_nbr') == 1

	if isfield(M_,'orig_endo_nbr') == 1
		NumberOfEndogenousVariables = M_.orig_endo_nbr;
	else
		NumberOfEndogenousVariables = M_.endo_nbr;
	end

	ys = zeros(NumberOfEndogenousVariables,1);
	for iii = 1:NumberOfEndogenousVariables
		varname = deblank(M_.endo_names(iii,:));
		eval(['ys(' int2str(iii) ') = ' varname ';']);
	end
else
	ys=zeros(length(lgy_),1);
	for iii = 1:length(lgy_)
		ys(iii) = eval(lgy_(i,:));
	end
	check = 0;
end
end