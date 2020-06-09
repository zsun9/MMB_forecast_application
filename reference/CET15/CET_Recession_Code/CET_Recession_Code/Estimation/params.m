function [ydiffdataPercent,idiffdataPercent,alfa,rho,u,Q,sigma,pibar,betta,...
    lambda,deltak,nuf,etag,recSHAREpercent,b,xi,DSHARE,deltapercent,...
    Spp,sigmaa,rhoR,rpi,sig_epsR,kappaf,rhomupsi, sig_mupsi,profy,pibreve,...
    varkappaf,M,thetaG,L,phiL,s,elasttarget,rdeltay,rhomuzT,sigmuzTPratio,...
    rhomuz,sig_muz]=params
        
%Labor market parameters
u=0.055;                %unemp. rate
L=0.67;                 %Labor force 
s=0.8395;               %Probability of staying in labor force
rho=0.9;                %job survival rate
Q=0.7;                  %vacancy filling rate
sigma=0.4904;           %matching function share of unemp.
recSHAREpercent= 0.4945;%hiring/search cost para; share of hiring/search cost relative to output, in percent
DSHARE=0.3151;          %unempl. benefits as share of w (replacement ratio)
deltapercent=0.1298;    %prob. of barg. session determination
M=60;                   %Maximum bargaining rounds per quarter, needs to be an even number!!!!
phiL=1.2745;            %Adjustment cost for labor force
elasttarget=3;          %CES parameter market and home consumption ( (1-b)/(1-chi) is elasticity of substition)
                        %choose chi such that elasttarget is hit. see cet_steadystate.m                     
                        
if M<2, error('M must be at least equal to 2!');end
if mod(M,2)==1, error('M must be an even number so that the worker makes the last offer!');end 

%prices  
xi=0.7545;      %Calvo prices
pibar=1.005;    %inflation rate, gross, quarterly
kappaf=0;       %price indexation to past inflation
varkappaf=1;    %price indexation parameter; if kappaf=0 and varkappaf=1 and pibreve=1 -> no indexation at all.
pibreve=1;      %price indexation to value pibreve
lambda=1.3639;  %steady state price markup
nuf=0.5619;     %working capital fraction

%technology and adjustment cost
alfa=0.2273;    %capital share
deltak=0.025;   %depreciation rate of capital
Spp=4.3546;     %second derivative of invest. adjustment costs
sigmaa=0.0530;  %capacity utilization costs

%growth rates of investment and real GDP
idiffdataPercent=2.9; 
ydiffdataPercent=1.7; 

%Preferences
betta=0.996783170280770;    %discount factor households; implies 3% real rate
b=0.8992;                   %habit formation in consumption

%Monetary Policy by Taylor rule
rhoR=0.7503;    %Interest rate smoothing
rpi=1.6663;     %Coefficient on inflation
rdeltay=0.2471; %Coefficient on GDP growth rate

%Government
etag=0.2;       %Government spending-to-output in ss

%technology diffusion into gov. spending and other parameters of the model
thetaG = 0.1085;  %gov spending

% steady state profits as share of output
profy=0;

% standard deviation of shocks (%)
sig_mupsi=0.1286;   %unit root investment tech.
sig_epsR=0.6555;    %monetary policy
sig_muz=0.0384;     %unit root neutral tech. (permanent)
sigmuzTPratio=4.8476;%ratio of standard deviations
sigmuzT=sig_muz*sigmuzTPratio;%neutral tech. (transitory)

%AR(1)
rhomupsi=0.6623;   %unit root investment tech.
rhomuz=0.7652;     %unit root neutral tech.
rhomuzT=0.8475;    %neutral tech. (transitory)












      


