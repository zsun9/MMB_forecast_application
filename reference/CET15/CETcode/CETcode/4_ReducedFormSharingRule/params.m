function [ydiffdataPercent,idiffdataPercent,alfa,rho,u,Q,sigma,pibar,betta,lambda,deltak,tau,nuf,...
    etag,recSHAREpercent,b,xi,DSHARE,deltapercent,Spp,sigmaa,rhoR,rpi,ry,sig_epsR,kappaf,...
    iota,doNash,doEHL,sigmaL,xiw,lambdaw,kappaw,rhomupsi,rhomuz,sig_mupsi,sig_muz,...
    profy,dolagZBAR,varkappaw,pibreve,thetaw,varkappaf,M,thetaG, thetaPHI,... 
    thetaKAP, thetaD, thetaGAM, do_given_bets,bet1,bet2,bet3,searchSHAREpercent,bet4,bet5]=params
 

%model switches
doNash=0;    %if =0, alt offer barg. ; if =1, Nash bargaining; note: requires doEHL=0 below
doEHL=0;     %if=0, alt offer barg or Nash barg; if=1, EHL labor market

do_given_bets=1;  %if =1, given values for beta's in sharing rule
bet1 = 0.0907;    %Reduced form sharing rule coefficients
bet2 = 0;
bet3 = 0;


%Labor market parameters
u=0.055;                %unemp. rate
rho=0.9;                %job survival rate
sigma=0.5570;             %matching function share of unemp.
recSHAREpercent=0.5;     %hiring cost para; hiring cost relative to output, in percent
searchSHAREpercent=0.05;     %search cost para; hiring cost relative to output, in percent

DSHARE=0.6682;             %unempl. benefits as share of w (replacement ratio)
Q=0.7;                  %vacancy filling rate

deltapercent=0.3022;      %prob. of barg. session determination
M=60;                   %Maximum bargaining rounds per quarter 
 
if M<2, error('M must be at least equal to 2!');end
if mod(M,2)==1, error('M must be an even number so that the worker makes the last offer!');end 


%prices  
xi=0.5841;           %Calvo prices
pibar=1.00625;     %inflation rate, gross, quarterly
kappaf=0;          %price indexation to past inflation
varkappaf=1;       %price indexation parameter; if kappaf=0 and varkappaf=1 and pibreve=1 -> no indexation at all.
pibreve=1;         %price indexation to value pibreve

lambda=1.4256;     %steady state price markup
nuf=1;             %working capital fraction
tau=1;             %steady state markup shifter

%technology and adjustment cost
alfa=0.2366;       %capital share
deltak=0.025;      %depreciation rate of capital
Spp=13.6684;       %second derivative of invest. adjustment costs
sigmaa=0.0760;     %capacity utilization costs

%growth rates of investment and real GDP
idiffdataPercent=2.9; 
ydiffdataPercent=1.7; 

%Preferences
betta=0.996783170280770;    %discount factor households; implies 3% real rate
b=0.8320;                   %habit formation in consumption

%Monetary Policy by Taylor rule
rhoR	=	0.8555;   %Interest rate smoothing
rpi     =	1.3552;   %Coefficient on inflation
ry      =	0.0359;   %Coef. on GDP

%Government
etag=0.2;           %Government spending-to-output in ss

%technology diffusion into gov. spending and other parameters of the model
thetaG =0.0136;     %gov spending
thetaPHI=thetaG;    %fixed cost of production
thetaKAP=thetaG;    %hiring cost
thetaGAM=thetaG;	%cost of counteroffer
thetaD=0.7416;      %replacement ratio
dolagZBAR=1;        %if =1, diffusion speed: zbar_t=(zplus_t-1)^thetaj*(zbar_t-1)^(1-thetaj); 
                    %if =0, zbar_t=(zplus_t)^thetaj*(zbar_t-1)^(1-thetaj) for j=G,GAM,KAP,BU,PHI
                    %check cet_steadystate.m for further restrictions on
                    %theta parameters!

% steady state profits as share of output
profy=0;

%EHL parameter
lambdaw=1.2;  %wage markup (EHL)
xiw=0.75;     %Calvo wage stickiness (EHL)
sigmaL=1;     %inv. labor supply elast. (EHL)
kappaw=0;     %wage indexation to past inflation (EHL)  
varkappaw=1;  %wage indexation parameter; if kappaw=0 and varkappaw=1 and pibreve=1 and thetaw=0 -> no indexation at all.
thetaw=0;     %wage indexation to technology

    
% standard deviation of shocks (%)
sig_muz     =	0.1362;       %unit root neutral tech.
sig_mupsi	=	0.1100;       %unit root investment tech.
sig_epsR	=	0.6028;       %monetary policy

sig_epsilon	=	0;            %stationary neutral tech.
sig_upsilon	=	0;            %stationary invest. tech.
sig_g	    =	0;            %gov. spending
sig_taud	=	0;            %price markup
sig_zetac	=	0;            %cons. preference

%AR(1)
rhomupsi	=	0.7279; %unit root investment tech.
rhomuz      =	0;      %unit root neutral tech.

rhoepsilon	=	0;      %stationary neutral tech. 
rhoupsilon	=	0;      %stationary invest. tech.
rhozetac	=	0;      %cons. preference
rhog        =	0;      %gov. spending
rhotaud     =   0;      %price markup
rhosigmam	=	0;      %matching function shock

 

iota = 1;%Parameter does not appear in model any longer. Just ignore it.
bet4 = 1;%Parameter does not appear in model any longer. Just ignore it.
bet5 = 1;%Parameter does not appear in model any longer. Just ignore it.

