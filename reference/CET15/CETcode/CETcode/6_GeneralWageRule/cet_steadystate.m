function [ys,check] = cet_steadystate(ys,junk,do_steady_print)

global M_

%read parameters from params.m
[ydiffdataPercent,idiffdataPercent,alfa,rho,u,Q,sigma,pibar,betta,lambda,deltak,tau,nuf,...
    etag,recSHAREpercent,b,xi,DSHARE,deltapercent,Spp,sigmaa,rhoR,rpi,ry,sig_epsR,kappaf,...
    iota,doNash,doEHL,sigmaL,xiw,lambdaw,kappaw,rhomupsi,rhomuz,sig_mupsi,sig_muz,...
    profy,dolagZBAR,varkappaw,pibreve,thetaw,varkappaf,M,thetaG, thetaPHI,...
    thetaKAP, thetaD, thetaGAM,do_given_bets,bet1,bet2,bet3,searchSHAREpercent,bet4,bet5,...
    bet6,bet7,bet8,bet9,bet10]=params;
 
if isnan(M_.params(:,:))==0
    %read parameter values from M_.params and assign to parameters names.
    %this overwrites parameters coming from params.m if estimation is done.
    
    ydiffdataPercent=M_.params(1);
    idiffdataPercent=M_.params(2);
    alfa            =M_.params(3);
    rho             =M_.params(4);
    u               =M_.params(5);
    Q               =M_.params(6);
    sigma           =M_.params(7);
    betta           =M_.params(8);
    lambda          =M_.params(9);
    deltak          =M_.params(10);
    tau             =M_.params(11);
    nuf             =M_.params(12);
    etag            =M_.params(13);
    kappa           =M_.params(14);
    b               =M_.params(15);
    xi              =M_.params(16);
    D               =M_.params(17);
    delta           =M_.params(18);
    gamma           =M_.params(19);
    Spp             =M_.params(20);
    sigmab          =M_.params(21);
    sigmaa          =M_.params(22);
    phi             =M_.params(23);
    rhoR            =M_.params(24);
    rpi             =M_.params(25);
    ry              =M_.params(26);
    sig_epsR        =M_.params(27);
    sigmam          =M_.params(28);
    kappaf          =M_.params(29);
    DSHARE          =M_.params(30);
    deltapercent    =M_.params(31);
    recSHAREpercent =M_.params(32);
    iota            =M_.params(33);
    doNash          =M_.params(34);
    eta             =M_.params(35);
    doEHL           =M_.params(36);
    xiw             =M_.params(37);
    lambdaw         =M_.params(38);
    AEHL            =M_.params(39);
    f               =M_.params(40);
    rhomupsi        =M_.params(41);
    rhomuz          =M_.params(42);
    sig_mupsi       =M_.params(43);
    sig_muz         =M_.params(44);
    thetaG          =M_.params(45);
    thetaPHI        =M_.params(46);
    thetaKAP        =M_.params(47);
    thetaD          =M_.params(48);
    dolagZBAR       =M_.params(49);
    profy           =M_.params(50);
    varkappaw       =M_.params(51);
    pibreve         =M_.params(52);
    thetaw          =M_.params(53);
    varkappaf       =M_.params(54);
    M               =M_.params(55);
    sigmaL          =M_.params(56);
    tau_SS          =M_.params(57);
    epsilon_SS      =M_.params(58);
    upsilon_SS      =M_.params(59);
    zetac_SS        =M_.params(60);
    g_SS            =M_.params(61);
    pibar           =M_.params(62);
    thetaGAM        =M_.params(63);
    kappaw          =M_.params(64);
    unemp_SS        =M_.params(65);
    vTot_SS         =M_.params(66);
    alp1            =M_.params(67);
    alp2            =M_.params(68);
    alp3            =M_.params(69);
    alp4            =M_.params(70);
    bet1            =M_.params(71);
    bet2            =M_.params(72);
    bet3            =M_.params(73);
    s               =M_.params(74);
    searchSHAREpercent=M_.params(75);
    bet4            =M_.params(76);
    bet5            =M_.params(77);
    bet6            =M_.params(78);
    bet7            =M_.params(79);
    bet8            =M_.params(80);
    bet9            =M_.params(81);
    bet10           =M_.params(82);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%force the below parameters to be identical to thetaG
thetaPHI=thetaG;%thetaPHI =1; %fixed cost of production
thetaKAP=thetaG;%thetaKAP =1; %hiring cost
thetaGAM=thetaG;%thetaGAM =1; %counteroffer cost
thetaD=thetaG;%thetaD =1; %unemp. benefits
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%first, some easy steady states
delta=deltapercent/100;
mu=exp(ydiffdataPercent/100/4);
mupsi=exp(idiffdataPercent/100/4)/mu;
muz=mu/mupsi^(alfa/(1-alfa));
if dolagZBAR==1,
    nG=mu^(-1/thetaG);
    nKAP=mu^(-1/thetaKAP);
    nD=mu^(-1/thetaD);
    nGAM=mu^(-1/thetaGAM);
    nPHI=mu^(-1/thetaPHI);
else
    nG=(1/mu)^((1-thetaG)/thetaG);
    nKAP=(1/mu)^((1-thetaKAP)/thetaKAP);
    nD=(1/mu)^((1-thetaD)/thetaD);
    nGAM=(1/mu)^((1-thetaGAM)/thetaGAM);
    nPHI=(1/mu)^((1-thetaPHI)/thetaPHI);
end
uk=1;
aofuk=0;
Stilde=0;
Sprimetilde=0;
l=1-u;
R=mu*pibar/betta;
pkprime=1;
Rk=pibar*mu/betta;

%Some more complicated steady states
sigmab=Rk*mupsi*pkprime/pibar-(1-deltak)*pkprime;
aofukprime=sigmab;
pitilde=pibar^kappaf*pibar^(1-kappaf-varkappaf)*pibreve^varkappaf;
mc=1/lambda*(1-betta*xi*(pitilde/pibar)^(lambda/(1-lambda)))/(1-betta*xi*(pitilde/pibar)^(1/(1-lambda)))...
    *((1-xi*(pitilde/pibar)^(1/(1-lambda)))/(1-xi))^(1-lambda);
phalo=((1-xi*(pitilde/pibar)^(1/(1-lambda)))/(1-xi))^(1-lambda)/((1-xi*(pitilde/pibar)^(lambda/(1-lambda)))/(1-xi))^((1-lambda)/lambda);
kl=(alfa*(mupsi*mu)^(1-alfa)*mc/sigmab/tau)^(1/(1-alfa));

%EHL as special case. Obviously, whalo has no meaning otherwise and is set
%to one!
piw=mu*pibar;
pitildew=(pibar)^kappaw*(pibar)^(1-kappaw-varkappaw)*pibreve^varkappaw*mu^thetaw;
whalo=doEHL*(((1-xiw*(pitildew/piw)^(1/(1-lambdaw)))/(1-xiw))^(1-lambdaw)...
    /((1-xiw*(pitildew/piw)^(lambdaw/(1-lambdaw)))/(1-xiw))^((1-lambdaw)/lambdaw))+(1-doEHL)*1;
varthet=(1-alfa)*mc/(tau*(mupsi*mu)^alfa*(nuf*R+1-nuf))*kl^alfa;
y=mc/( (phalo^(lambda/(1-lambda))-1)*mc+1-profy)*(kl/(mu*mupsi))^alfa*l*whalo^(lambdaw/(lambdaw-1));
k=kl*l*whalo^(lambdaw/(lambdaw-1));
phi=((k/(l*whalo^(lambdaw/(lambdaw-1)))/(mupsi*mu))^alfa*l*whalo^(lambdaw/(lambdaw-1))-y*phalo^(lambda/(1-lambda)))/nPHI;
i=(1-(1-deltak)/(mu*mupsi))*k;
c=(1-etag)*y-i-(1-doEHL)*recSHAREpercent/100*y-(1-doEHL)*searchSHAREpercent/100*y;
psi=(c-b*c/mu)^(-1)-betta*b*(c*mu-b*c)^(-1);
g=etag*y/nG;
gdp=g*nG+c+i;
K=lambda*psi*y*mc/(1-betta*xi*(pitilde/pibar)^(lambda/(1-lambda)));
F=psi*y/(1-betta*xi*(pitilde/pibar)^(1/(1-lambda)));

%steady states specific to unemployment models, except for real wage
%(switch)
x=1-rho;
f=x*l/(1-rho*l);
v=x/Q;
sigmam=x*l*(1-rho*l)^(-sigma)*(l*v)^(sigma-1);
kappa=recSHAREpercent/100/x/l*y/nKAP;
s=(searchSHAREpercent/100/((Q^(-1)*x))/l*y)/nKAP;
J=kappa*nKAP+s*nKAP*Q^(-1);
varthetp=varthet/(1-rho*betta);
wp=varthetp-J;
w=doEHL*(varthet)+(1-doEHL)*(wp*(1-rho*betta)); %EHL switch for wage
D=DSHARE*w/nD;
VminusU=(wp-nD*D/(1-rho*betta))/(1-(1-f)*betta*rho)*(1-rho*betta);
U=(nD*D+betta*f*VminusU)/(1-betta);
V=VminusU+U;
A=V-wp;



%AOB sharing rule
alp1=1-delta+(1-delta)^M;
alp2=1-(1-delta)^M;
alp3=alp2*(1-delta)/delta-alp1;
alp4=(1-delta)/(2-delta)*alp2/M+1-alp2;
if do_given_bets==0
    bet1=alp2/alp1;
    bet2=alp3/alp1;
    bet3=alp4/alp1;
    bet4=bet3;
    gamma=(bet1*(V-bet5*U)-J+bet3*varthet-bet4*nD*D)/(nGAM*bet2);
end

gamma=1e6;

recruiting=nKAP*kappa*x*l+nKAP*s*(Q^(-1)*x)*l;

%Worker surplus share under Nash sharing
eta=(V-U)/(V-U+J);

%EHL sticky wages
Kw=((l*whalo^(lambdaw/(lambdaw-1)))^(1+sigmaL))/(1-betta*xiw*(pitildew/piw)^(lambdaw*(1+sigmaL)/(1-lambdaw)));
if Kw<0, disp('Kw negative in steady state!'); end;
Fw=(psi/lambdaw*(l*whalo^(lambdaw/(lambdaw-1))))/(1-betta*xiw*(pitildew/piw)^(1/(1-lambdaw)));
AEHL=1/(Kw)*(Fw*w)*((1- xiw*(  pitildew/piw  )^(1/(1-lambdaw)))/(1-xiw))^(( 1-lambdaw*(1+sigmaL) ));

%parameters for dynare
tau_SS=log(tau); epsilon_SS=log(1); upsilon_SS=log(1);
zetac_SS=log(1); g_SS=log(g); unemp_SS=log(1-l); vTot_SS=log(v*l);

%steady state variables for ys vector (R economy)
psiR=log(psi); cR=log(c); RR=log(R);  piR=log(pibar);
iR=log(i); pkprimeR=log(pkprime); FR=log(F); KR=log(K);
ukR=log(uk); kbarR=log(k); lR=log(l); xR=log(x); varthetR=log(varthet);
phaloR=log(phalo); yR=log(y); VR=log(V); JR=log(J);   UR=log(U);
GDPR=log(gdp); fR=log(f); vR=log(v); unempR=log(u);
vTotR=log(v*l); QR=log(Q); piwR=log(piw); whaloR=log(whalo);
FwR=log(Fw); KwR=log(Kw); wR=log(w);  wpR=log(wp);
varthetpR=log(varthetp); AAR=log(A);


%steady state variables for ys vector (R economy)
psiF=log(psi); cF=log(c); RF=log(R);  piF=log(pibar);
iF=log(i); pkprimeF=log(pkprime); FF=log(F); KF=log(K);
ukF=log(uk); kbarF=log(k); lF=log(l); xF=log(x); varthetF=log(varthet);
phaloF=log(phalo); yF=log(y); VF=log(V); JF=log(J);   UF=log(U);
GDPF=log(gdp); fF=log(f); vF=log(v); unempF=log(u);  nDF=log(nD);
vTotF=log(v*l); QF=log(Q); piwF=log(piw);nPHIF=log(nPHI);wF=log(w);
whaloF=log(whalo); FwF=log(Fw); KwF=log(Kw); muzF=log(muz);
mupsiF=log(mupsi); muF=log(mu); nGF=log(nG); nGAMF=log(nGAM); nKAPF=log(nKAP);
AAF=log(A);wpF=log(wp); varthetpF=log(varthetp);


%AGG econ
GDPAGG=log(gdp); piAGG=log(pibar); RAGG=log(R); ukAGG=log(uk); lAGG=log(l);
wAGG=wF; cAGG=log(c); iAGG=log(i); unempAGG=log(u); vTotAGG=log(v*l);
fAGG=log(f); pinvestAGG=-log(mupsi);


%put steady states into ys vector

ys=NaN*ones(M_.orig_endo_nbr,1);
ys(                   1)=wpR                ;
ys(                   2)=wpF                ;
ys(                   3)=wR                 ;
ys(                   4)=wF                 ;
ys(                   5)=psiR               ;
ys(                   6)=cR                 ;
ys(                   7)=RR                 ;
ys(                   8)=piR                ;
ys(                   9)=iR                 ;
ys(                  10)=pkprimeR           ;
ys(                  11)=FR                 ;
ys(                  12)=KR                 ;
ys(                  13)=ukR                ;
ys(                  14)=kbarR              ;
ys(                  15)=lR                 ;
ys(                  16)=xR                 ;
ys(                  17)=varthetR           ;
ys(                  18)=phaloR             ;
ys(                  19)=yR                 ;
ys(                  20)=JR                 ;
ys(                  21)=UR                 ;
ys(                  22)=GDPR               ;
ys(                  23)=fR                 ;
ys(                  24)=vR                 ;
ys(                  25)=unempR             ;
ys(                  26)=VR                 ;
ys(                  27)=AAR                ;
ys(                  28)=vTotR              ;
ys(                  29)=QR                 ;
ys(                  30)=piwR               ;
ys(                  31)=whaloR             ;
ys(                  32)=FwR                ;
ys(                  33)=KwR                ;
ys(                  34)=varthetpR          ;
ys(                  35)=psiF               ;
ys(                  36)=cF                 ;
ys(                  37)=RF                 ;
ys(                  38)=piF                ;
ys(                  39)=iF                 ;
ys(                  40)=pkprimeF           ;
ys(                  41)=FF                 ;
ys(                  42)=KF                 ;
ys(                  43)=ukF                ;
ys(                  44)=kbarF              ;
ys(                  45)=lF                 ;
ys(                  46)=xF                 ;
ys(                  47)=varthetF           ;
ys(                  48)=phaloF             ;
ys(                  49)=yF                 ;
ys(                  50)=JF                 ;
ys(                  51)=UF                 ;
ys(                  52)=GDPF               ;
ys(                  53)=fF                 ;
ys(                  54)=vF                 ;
ys(                  55)=unempF             ;
ys(                  56)=VF                 ;
ys(                  57)=AAF                ;
ys(                  58)=vTotF              ;
ys(                  59)=QF                 ;
ys(                  60)=piwF               ;
ys(                  61)=whaloF             ;
ys(                  62)=FwF                ;
ys(                  63)=KwF                ;
ys(                  64)=muzF               ;
ys(                  65)=mupsiF             ;
ys(                  66)=muF                ;
ys(                  67)=nGF                ;
ys(                  68)=nPHIF              ;
ys(                  69)=nGAMF              ;
ys(                  70)=nDF                ;
ys(                  71)=nKAPF              ;
ys(                  72)=varthetpF          ;
ys(                  73)=GDPAGG             ;
ys(                  74)=piAGG              ;
ys(                  75)=RAGG               ;
ys(                  76)=ukAGG              ;
ys(                  77)=lAGG               ;
ys(                  78)=wAGG               ;
ys(                  79)=cAGG               ;
ys(                  80)=iAGG               ;
ys(                  81)=unempAGG           ;
ys(                  82)=vTotAGG            ;
ys(                  83)=fAGG               ;
ys(                  84)=pinvestAGG         ;


% saving s.s. values that are used as params in static file
M_.params(                   1)=ydiffdataPercent;
M_.params(                   2)=idiffdataPercent;
M_.params(                   3)=alfa            ;
M_.params(                   4)=rho             ;
M_.params(                   5)=u               ;
M_.params(                   6)=Q               ;
M_.params(                   7)=sigma           ;
M_.params(                   8)=betta           ;
M_.params(                   9)=lambda          ;
M_.params(                  10)=deltak          ;
M_.params(                  11)=tau             ;
M_.params(                  12)=nuf             ;
M_.params(                  13)=etag            ;
M_.params(                  14)=kappa           ;
M_.params(                  15)=b               ;
M_.params(                  16)=xi              ;
M_.params(                  17)=D               ;
M_.params(                  18)=delta           ;
M_.params(                  19)=gamma           ;
M_.params(                  20)=Spp             ;
M_.params(                  21)=sigmab          ;
M_.params(                  22)=sigmaa          ;
M_.params(                  23)=phi             ;
M_.params(                  24)=rhoR            ;
M_.params(                  25)=rpi             ;
M_.params(                  26)=ry              ;
M_.params(                  27)=sig_epsR        ;
M_.params(                  28)=sigmam          ;
M_.params(                  29)=kappaf          ;
M_.params(                  30)=DSHARE          ;
M_.params(                  31)=deltapercent    ;
M_.params(                  32)=recSHAREpercent ;
M_.params(                  33)=iota            ;
M_.params(                  34)=doNash          ;
M_.params(                  35)=eta             ;
M_.params(                  36)=doEHL           ;
M_.params(                  37)=xiw             ;
M_.params(                  38)=lambdaw         ;
M_.params(                  39)=AEHL            ;
M_.params(                  40)=f               ;
M_.params(                  41)=rhomupsi        ;
M_.params(                  42)=rhomuz          ;
M_.params(                  43)=sig_mupsi       ;
M_.params(                  44)=sig_muz         ;
M_.params(                  45)=thetaG          ;
M_.params(                  46)=thetaPHI        ;
M_.params(                  47)=thetaKAP        ;
M_.params(                  48)=thetaD          ;
M_.params(                  49)=dolagZBAR       ;
M_.params(                  50)=profy           ;
M_.params(                  51)=varkappaw       ;
M_.params(                  52)=pibreve         ;
M_.params(                  53)=thetaw          ;
M_.params(                  54)=varkappaf       ;
M_.params(                  55)=M               ;
M_.params(                  56)=sigmaL          ;
M_.params(                  57)=tau_SS          ;
M_.params(                  58)=epsilon_SS      ;
M_.params(                  59)=upsilon_SS      ;
M_.params(                  60)=zetac_SS        ;
M_.params(                  61)=g_SS            ;
M_.params(                  62)=pibar           ;
M_.params(                  63)=thetaGAM        ;
M_.params(                  64)=kappaw          ;
M_.params(                  65)=unemp_SS        ;
M_.params(                  66)=vTot_SS         ;
M_.params(                  67)=alp1            ;
M_.params(                  68)=alp2            ;
M_.params(                  69)=alp3            ;
M_.params(                  70)=alp4            ;
M_.params(                  71)=bet1            ;
M_.params(                  72)=bet2            ;
M_.params(                  73)=bet3            ;
M_.params(                  74)=s               ;
M_.params(                  75)=searchSHAREpercent;
M_.params(                  76)=bet4            ;
M_.params(                  77)=bet5            ;
M_.params(                  78)=bet6            ;
M_.params(                  79)=bet7            ;
M_.params(                  80)=bet8            ;
M_.params(                  81)=bet9            ;
M_.params(                  82)=bet10            ;


check=0;
if nargin==3 && check==0,
    disp(' ');
    disp('---------------------------- ');
    disp('steady state and parameters: ');
    disp('---------------------------- ');
    disp(' ');
    fprintf('        R = %6.4f,     mc = %6.4f,  pibar = %6.4f\n', R,mc, pibar)
    fprintf('        k = %6.3f, sigmab = %6.4f,      l = %6.4f\n', k,sigmab, l)
    fprintf('      psi = %6.4f,      y = %6.4f,     Rk = %6.4f\n', psi,y,Rk)
    fprintf('      k/y = %6.4f,     cy = %6.4f,     iy = %6.4f\n', k/y,c/y,i/y)
    fprintf('        c = %6.4f,      y = %6.4f,    GDP = %6.4f\n', c,y,c+i+g*nG)
    fprintf('   real R = %6.4f,      i = %6.4f,    phi = %6.4f\n\n',R/pibar,i,phi )
    
    fprintf('   mupsi = %6.4f,    alfa = %6.4f,   pibar = %6.4f\n',mupsi,alfa,pibar)
    fprintf('  sigmaa = %6.4f,    etag = %6.4f,     nuf = %6.4f\n',sigmaa, etag, nuf)
    fprintf('  lambda = %6.4f,   betta = %6.4f,      l  = %6.4f\n\n', lambda, betta,l)
    
    disp('   EHL parameters, if applicable')
    fprintf('        piw = %6.4f,   Fw = %6.4f,      Kw = %6.4f\n',piw,Fw,Kw)
    fprintf('     sigmaL = %6.4f,  xiw = %6.4f, lambdaw = %6.4f\n',sigmaL,xiw,lambdaw)
    fprintf('       AEHL = %6.4f \n\n',AEHL)
    
    fprintf('    sigmam  = %6.4f,    u = %6.4f,    rho  = %6.4f\n',sigmam,u,rho)
    fprintf('          f = %6.4f,    x = %6.4f,  kappa  = %6.4f\n', f,x, kappa)
    fprintf('      sigma = %6.4f,   sh = %6.4f,   vrate = %6.4f\n\n',sigma,100*recruiting/y,v/(v+l) )
    fprintf('          s = %6.4f,    recSHAREpercent = %6.4f,  searchSHAREpercent  = %6.4f\n', s,recSHAREpercent, searchSHAREpercent)
    
    fprintf('         J  = %6.4f,    V = %6.4f,       U = %6.4f\n',J,V,U)
    fprintf('         Q  = %6.4f,    v = %6.4f,      V-U = %6.4f\n',Q,v,V-U)
    fprintf('         w  = %6.4f,    D = %6.4f,    w*l/y = %6.4f\n',w,D,w*l/y)
    fprintf(' profits/y  = %6.4f,  eta = %6.4f,   delta  = %6.4f\n',profy,eta,delta)
    fprintf('   varthet  = %6.4f,varthetp = %6.4f,    wp = %6.4f\n',varthet,varthetp,wp)
    fprintf('         A  = %6.4f, a1 = %6.4f,       a2 = %6.4f\n',A,alp1,alp2)
    fprintf('        a3  = %6.4f,  a4 = %6.4f,    gamma = %6.4f\n\n',alp3,alp4,gamma)
    
    
    fprintf('  thetaG  = %6.4f,   nG  = %6.4f \n',   thetaG,nG)
    fprintf('thetaKAP  = %6.4f, nKAP  = %6.4f \n',   thetaKAP,nKAP)
    fprintf('thetaPHI  = %6.4f, nPHI  = %6.4f \n',   thetaPHI,nPHI)
    fprintf('  thetaD  = %6.4f,   nD  = %6.4f \n',   thetaD,nD)
    fprintf('thetaGAM  = %6.4f, nGAM  = %6.4f \n\n', thetaGAM,nGAM)
    
    fprintf('Counteroffer costs as share of daily revenue = %6.4f\n',nGAM*gamma/(varthet/M))
    fprintf('hiring cost as share of new hire quarterly wage = %6.4f\n\n',(recruiting/(x*l))/w)    
    
end

if Kw<0
    check=1;
end


if J<0,
    disp('J negative');
    check=1;
end



if V-U<0,
    disp('V-U negative');
    check=1;
end