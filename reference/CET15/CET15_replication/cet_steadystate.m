function [ys,check] = cet_steadystate(ys,junk,do_steady_print)

global M_

%read parameters from params.m
[ydiffdataPercent,idiffdataPercent,alfa,rho,u,Q,sigma,pibar,betta,lambda,...
    deltak,nuf,etag,recSHAREpercent,b,xi,DSHARE,deltapercent,Spp,...
    sigmaa,rhoR,rpi,sig_epsR,kappaf,rhomupsi,...
    sig_mupsi,profy,pibreve,varkappaf,M,thetaG,L,phiL,s,...
    elasttarget,rdeltay,rhomuzT,sigmuzTPratio,rhomuz,sig_muz]=params;

if isnan(M_.params(:,:))==0
    %read parameter values from M_.params and assign to parameters names.
    %this overwrites parameters coming from params.m if estimation is done.
    num_para=size(M_.params,1);
    for idxxx=1:1:num_para
        define_string=[M_.param_names(idxxx,:),'=',sprintf('%20.20g',M_.params(idxxx))];
        evalc(define_string);
    end
end

%set chi such that elast. of subst. between c and cH is matched.
chi=1-(1-b)/elasttarget;
sigmuzT=sigmuzTPratio*sig_muz;

%first, some easy steady states
delta=deltapercent/100;
mu=exp(ydiffdataPercent/100/4);
mupsi=exp(idiffdataPercent/100/4)/mu;
muz=mu/mupsi^(alfa/(1-alfa));  
nG=mu^(-1/thetaG);
nKAP=mu^(-1/thetaG);
nD=mu^(-1/thetaG);
nGAM=mu^(-1/thetaG);
nPHI=mu^(-1/thetaG);
nL=mu^(-1/thetaG);
nH=mu^(-1/thetaG);
uk=1;
aofuk=0;
Stilde=0;
Sprimetilde=0;
Fcal=0;
FcalL=0;
FcalprimeL=0;
m=betta/mu;
l=L*(1-u);
R=pibar/m;
pkprime=1;
Rk=R;

%Some more complicated steady states
sigmab=Rk*mupsi*pkprime/pibar-(1-deltak)*pkprime;
aofukprime=sigmab;
pitilde=pibar^kappaf*pibar^(1-kappaf-varkappaf)*pibreve^varkappaf;
mc=1/lambda*(1-betta*xi*(pitilde/pibar)^(lambda/(1-lambda)))/(1-betta*xi*(pitilde/pibar)^(1/(1-lambda)))...
    *((1-xi*(pitilde/pibar)^(1/(1-lambda)))/(1-xi))^(1-lambda);
phalo=((1-xi*(pitilde/pibar)^(1/(1-lambda)))/(1-xi))^(1-lambda)/((1-xi*(pitilde/pibar)^(lambda/(1-lambda)))/(1-xi))^((1-lambda)/lambda);
kl=(alfa*(mupsi*mu)^(1-alfa)*mc/sigmab)^(1/(1-alfa));
piw=mu*pibar;
varthet=(1-alfa)*mc/((mupsi*mu)^alfa*(nuf*R+1-nuf))*kl^alfa;
y=mc/( (phalo^(lambda/(1-lambda))-1)*mc+1-profy)*(kl/(mu*mupsi))^alfa*l;
k=kl*l;
phi=((k/l/(mupsi*mu))^alfa*l-y*phalo^(lambda/(1-lambda)))/nPHI;
i=(1-(1-deltak)/(mu*mupsi))*k;
c=(1-etag)*y-i-recSHAREpercent/100*y;
g=etag*y/nG;
gdp=g*nG+c+i;

%steady states specific to unemployment models, except for real wage
%(switch)
x=1-rho;
f=x*l/(L-rho*l);
v=x/Q;
sigmam=x*l*(L-rho*l)^(-sigma)*(l*v)^(sigma-1);
kappa=(recSHAREpercent/100/((x))/l*y)/nKAP;
J=kappa*nKAP;
varthetp=varthet/(1-rho*m*mu);
wp=varthetp-J;
w=(wp*(1-rho*m*mu));
D=DSHARE*w/nD;
e=(L-s*(L-rho*l)-rho*l)/(1-L);

%solve for omega and pl such that equations 28 and 30 hold with equality. Along the way,
%we solve for further steady states.
xx=[0.465851400142442   0.927293850171153]; %initial guess.

%dbstop if error
options=optimset('MaxFunEvals',2000,'MaxIter',1000,'Display','off','TolX',1e-9,'TolFun',1e-9);

try
    [solut,fval,exitflag]=fsolve('find_paras',xx,options,s,e,wp,delta,M,J,...
        varthet,y,xi,pibar,L,l,c,b,D,rho,betta,f,mu,Fcal,FcalL,...
        FcalprimeL,nD,nGAM,nH,lambda,mc,pitilde,w,m,chi);
    
    if exitflag~=1,
        error('error: fsolve in steady state program did not terminate properly!');
    end
catch
    solut=1e10+xx; fval=1e10; exitflag=100;
    check=1;
    disp('could not solve steady state');
end

%get steady state at solution for omega and pl_SS
[ff,UcH, cH,gamma,alp1,alp2,alp3,alp4,V,A,U,N,K,F,...
    psi,omega,pl]=find_paras(solut,s,e,wp,delta,M,J,varthet,y,xi,pibar,L,l,...
    c,b,D,rho,betta,f,mu,Fcal,FcalL,FcalprimeL,nD,nGAM,nH,lambda,mc,...
    pitilde,w,m,chi);

%A check:
if e<0 || pl<0 || omega<0 || alfa>1 || alfa<0 || V<0 || U<0 || N<0 || A<0 || V<U || gamma<0 || omega>1
    fprintf('e=%6.4f pl=%6.4f omega=%6.4f \n\n',e,pl,omega);
    fprintf('alfa=%6.4f V=%6.4f\n\n',alfa,V);
    fprintf('U=%6.4f N=%6.4f A=%6.4f gamma=%6.4f\n\n',U,N,A,gamma);
    disp('Fatal: sign restrictions of e or pl in steady state not satisfied!')
    indicatorr=1;
    check=1;
else
    check=0;
    indicatorr=0;
end

%some further steady states
recruiting=nKAP*kappa*(x)*l;

%wold representation of components representation
try
    th1=1.3;
    th2=-0.4;
    [c0,c1,c2,theta1,theta2,sig_eta,rt]= blaschke(sig_muz,rhomuz,sigmuzT,rhomuzT,th1,th2);
    check=0;
catch
    %checkFAILED=1;
    theta1=0;
    theta2=0;
    sig_eta=1000;
    check=1;
end

%parameters for dynare
unemp_SS=log(1-l);vTot_SS=log(v*l);

%steady state variables for ys vector (R economy)
psiR=log(psi); cR=log(c); RR=log(R);  piR=log(pibar);
iR=log(i); pkprimeR=log(pkprime); FR=log(F); KR=log(K);
ukR=log(uk); kbarR=log(k); lR=log(l); xR=log(x); varthetR=log(varthet);
phaloR=log(phalo); yR=log(y); VR=log(V); JR=log(J);   UR=log(U);
GDPR=log(gdp); fR=log(f); vR=log(v); unempR=log(u); vTotR=log(v*l); 
QR=log(Q); wR=log(w);  wpR=log(wp); varthetpR=log(varthetp); AAR=log(A);
eR=log(e); NR=log(N); LR=log(L); cHR=log(cH); UcHR=log(UcH); plR=log(pl);

%steady state variables for ys vector (R economy)
psiF=log(psi); cF=log(c); RF=log(R);  piF=log(pibar);
iF=log(i); pkprimeF=log(pkprime); FF=log(F); KF=log(K);
ukF=log(uk); kbarF=log(k); lF=log(l); xF=log(x); varthetF=log(varthet);
phaloF=log(phalo); yF=log(y); VF=log(V); JF=log(J);   UF=log(U);
GDPF=log(gdp); fF=log(f); vF=log(v); unempF=log(u);  vTotF=log(v*l); 
QF=log(Q);wF=log(w); muzF=log(muz);mupsiF=log(mupsi); muF=log(mu); nGF=log(nG); 
AAF=log(A);wpF=log(wp); varthetpF=log(varthetp); eF=log(e); NF=log(N); LF=log(L); 
cHF=log(cH); UcHF=log(UcH); plF=log(pl); pi4F=4*log(pibar); LcalR=0;LcalF=0;

%AGG econ
GDPAGG=log(gdp); piAGG=log(pibar); RAGG=log(R); ukAGG=log(uk); lAGG=log(l);
wAGG=wF; cAGG=log(c); iAGG=log(i); unempAGG=log(u); vTotAGG=log(v*l);
fAGG=log(f); pinvestAGG=-log(mupsi); LAGG=log(L);

%put steady states into ys vector
ys=NaN*ones(M_.orig_endo_nbr,1);
for idyyy=1:1:M_.orig_endo_nbr, %number of endogenous variables
    define_string=['ys(',num2str(idyyy), ') =',M_.endo_names(idyyy,:)];
    evalc(define_string);
    %define_string2=['ys(',sprintf('%20.6g',idyyy),')=',M_.endo_names(idyyy,:),';'];
    %disp(define_string2)
end

% saving s.s. values that are used as params in static file
num_para=size(M_.params,1);

for idxxx=1:1:num_para
    define_string=['M_.params(idxxx)=',M_.param_names(idxxx,:),';'];
    evalc(define_string);
end

if nargin==3 && check==0,
    disp(' ');
    disp('---------------------------- ');
    disp('steady state and parameters: ');
    disp('---------------------------- ');
    disp(' ');
    fprintf('        R = %6.4f,     mc = %6.4f,  pibar = %6.4f\n', R,mc, pibar)
    fprintf('        k = %6.4f, sigmab = %6.4f,      l = %6.4f\n', k,sigmab, l)
    fprintf('      psi = %6.4f,     y = %6.4f,     Rk = %6.4f\n', psi,y,Rk)
    fprintf('      k/y = %6.4f,     cy = %6.4f,     iy = %6.4f\n', k/y,c/y,i/y)
    fprintf('        c = %6.4f,      y = %6.4f,    GDP = %6.4f\n', c,y,c+i+g*nG)
    fprintf('   real R = %6.4f,      i = %6.4f,    phi = %6.4f\n\n',R/pibar,i,phi )
    fprintf('   mupsi = %6.4f,    alfa = %6.4f,   pibar = %6.4f\n',mupsi,alfa,pibar)
    fprintf('  sigmaa = %6.4f,    etag = %6.4f,     nuf = %6.4f\n',sigmaa, etag, nuf)
    fprintf('  lambda = %6.4f,   betta = %6.4f,      l  = %6.4f\n\n', lambda, betta,l)    
    fprintf('    sigmam  = %6.4f,    u = %6.4f,    rho  = %6.4f\n',sigmam,u,rho)
    fprintf('          f = %6.4f,    x = %6.4f,  kappa  = %6.4f\n', f,x, kappa)
    fprintf('      sigma = %6.4f,   sh = %6.4f,   vrate = %6.4f\n\n',sigma,100*recruiting/y,v/(v+l) )   
    fprintf('         J  = %6.4f,    V = %6.4f,      U = %6.4f\n',J,V,U)
    fprintf('         Q  = %6.4f,    v = %6.4f,      V-U = %6.4f\n',Q,v,V-U)
    fprintf('         w  = %6.4f,    D = %6.4f,    w*l/y = %6.4f\n',w,D,w*l/y)
    fprintf(' profits/y  = %6.4f,  delta  = %6.4f\n',profy,delta)
    fprintf('   varthet  = %6.4f,varthetp = %6.4f,       wp = %6.4f\n',varthet,varthetp,wp)
    fprintf('         A  = %6.4f,    a1 = %6.4f,       a2 = %6.4f\n',A,alp1,alp2)
    fprintf('        a3  = %6.4f,      a4 = %6.4f,    gamma = %6.4f\n\n',alp3,alp4,gamma)
    fprintf('    thetaG  = %6.4f,     nG  = %6.4f,      pl  = %6.4f\n',   thetaG,nG,pl) 
    fprintf('         N  = %6.4f,     e = %6.4f , omega   = %6.4f\n',  N,e,omega);
    fprintf('         L  = %6.4f ,    cH  = %6.4f, substelast c,cH  = %6.4f \n\n',L,cH,(1-b)/(1-chi));
    fprintf('Counteroffer costs as share of daily revenue           = %6.4f\n',nGAM*gamma/(varthet/M))
    fprintf('hiring cost as share of new hire quarterly wage        = %6.4f\n\n',(recruiting/(x*l))/w)
    
    disp('Labor Market Transition Probabilities in Steady State')
    EE=rho+(1-rho)*s*f;     EU=(1-rho)*s*(1-f);    EN=(1-rho)*(1-s);
    UE=s*f;    UU=s*(1-f);    UN=1-s;    NE=e*f;    NU=e*(1-f);    NN=1-e;
    fprintf('             E             U             N \n',[],[]);
    fprintf('E %6.4f  EE  = %6.4f    EU = %6.4f    EN = %6.4f \n',[],EE,EU,EN);
    fprintf('U %6.4f  UE  = %6.4f    UU = %6.4f    UN = %6.4f \n',[],UE,UU,UN);
    fprintf('N %6.4f  NE  = %6.4f    NU = %6.4f    NN = %6.4f \n\n',[],NE,NU,NN);
end

if isnan(U)
    check=1;
end

if exitflag~=1,
    check=1;
end

if indicatorr==1,
    check=1;
end

