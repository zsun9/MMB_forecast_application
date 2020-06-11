function [ydiffdataPercent,idiffdataPercent,alfa,rho,u,Q,sigma,pibar,betta,lambda,deltak,nuf,...
    etag,recSHAREpercent,b,xi,DSHARE,deltapercent,Spp,sigmaa,rhoR,rpi,sig_epsR,kappaf,...
    pibreve,varkappaf,M,thetaG, L,phiL,s,do_impose_ZLB, rhomuzP, rhomuzT, sigmuzP, sigmuzT,...
    elasttarget,rdeltay,groot1,groot2,broot1, broot2,oroot1,riskyworkcap, horz,...
    do_load_results,ini_ntech]=params 


%Labor market parameters
u=0.055;                            %unemp. rate
L=0.67;                             %Labor force

s=0.839524092026314;                %Probability of staying in labor force
rho=0.9;                            %job survival rate
Q=0.7;                              %vacancy filling rate
sigma=0.490440844007615;            %matching function share of unemp.

recSHAREpercent=0.494523047757910;  %share of hiring cost relative to output, in percent
DSHARE=0.315077837940160;           %unempl. benefits as share of w (replacement ratio)

deltapercent=0.129818982202172;     %prob. of barg. session determination
M=60;                               %Maximum bargaining rounds per quarter, needs to be an even number!!!!

if M<2, error('M must be at least equal to 2!');end
if mod(M,2)==1, error('M must be an even number so that the worker makes the last offer!');end

%labor force/home production
phiL=1.274500970372604*100;         %Adjustment cost for labor force
elasttarget=3;                      %CES parameter market and home consumption ( (1-b)/(1-chi) is elasticity of substition)
 
%prices
xi=0.754488089403851;               %Calvo prices
pibar=1.005;                        %inflation rate, gross, quarterly
kappaf=0;                           %price indexation to past inflation
varkappaf=1;                        %price indexation parameter; if kappaf=0 and varkappaf=1 and pibreve=1 -> no indexation at all.
pibreve=1;                          %price indexation to value pibreve

lambda=1.363919923552998;           %steady state price markup
nuf=0.561897795328510;              %working capital fraction
 
%technology and adjustment cost
alfa=0.227253602467644;             %capital share
deltak=0.025;                       %depreciation rate of capital
Spp=4.354585562255764;              %second derivative of invest. adjustment costs
sigmaa=0.052984236888187;           %capacity utilization costs

%growth rates of investment and real GDP
idiffdataPercent=2.9;
ydiffdataPercent=1.7;

%Preferences
betta=0.996783170280770;            %discount factor. Implies 3% real rate
b=0.899194034103120;                %habit formation in consumption


%Monetary Policy by Taylor rule
rhoR	=	0.750333814155482;      %Interest rate smoothing
rpi     =	1.666310440977893;      %Coefficient on inflation
rdeltay =   0.247125511564811;      %Coefficient on output growth

%Government
etag=0.2;                           %Government spending-to-output in steady state

%technology diffusion into gov. spending and other parameters of the model
thetaG =0.108526552300145; 
 
%exogenous processes
sig_epsR= 0.655530179030148;        %monetary policy (not used in ZLB sim)
rhomupsi= 0.662334973837515;        %investment specific technology (not used in ZLB sim)
sig_mupsi= 0.128573081154863;


rhomuz= 0.765212544060833;          %permanent neutral technology
sig_muz= 0.038402338055920;

rhomuzT= 0.847469178442599;         %stationary neutral technology
sigmuzTPratio= 4.847610857531211;

rhomuzP=rhomuz;sigmuzP=sig_muz; sigmuzT=sigmuzTPratio*sigmuzP;

groot1=0.85; groot2=0.75;           %Gov. spending AR(1) and AR(2)

broot1=0.8; broot2=0.7;             %Flight to safety AR(1) and AR(2)

oroot1=0.5;                         %GZ spread AR(1) 

riskyworkcap=.33;                   %Share of working capital subject to risky rate

ini_ntech=-0.4;                     %inital fall in neutral technology


%some further options
horz=20;                            %number of periods to simulate

do_impose_ZLB=1;                    %impose ZLB (or not)

do_load_results=0;                  %load results from disk (or not)








