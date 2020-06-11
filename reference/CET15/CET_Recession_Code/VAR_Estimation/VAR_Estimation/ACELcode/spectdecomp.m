function [hp,bp,name] = spectdecomp(a,b,lam,erzout,azeroout,a0betazout)
%
%this program computes the fraction of variance in the variables in name,
%that are due to embodied technology shocks, neutral technology shocks and
%monetary policy shocks, respectively.
%
%erzout - fitted disturbances output by mkimplrnew.m, used to compute variance-covariance matrix of residuals
%azeroout, a0betazout - VAR parameters output by mkimplrnew.m
%
%hp - fraction of variance in hp-filtered data: column 1 - embodied; column 2 - neutral; column 3 - policy; column 4 - sum
%     rows correspond to the variables in name, lam is the value of lambda to use in the HP filter
%
%bp - same as hp, except for band-pass filtered data
%
%a, b - band pass filter passes components with period greater than a and less than b (business cycles: a=8, b=32 for quarterly data)
%

%Note: parameters set in the code below include N (number of ordinates to use in using Riemann approximation of integral,
%lam (lambda in the HP filter)

iplt=0;%if unity, plot variance decomposition in the frequency domain 

[n,m]=size(a0betazout);

nlag1=floor((m-1)/n);
nlag2=ceil((m-1)/n);
if nlag1 ~= nlag2
    error('fatal (spectdecomp) structure of a0betazout not as expected')
end
nlag=nlag2;

[V] = getV(erzout);

DD=diag(sqrt(diag(V)));
C=inv(azeroout)*DD;
N=200;
kk=1:N/2;

[g1,g2]=HP(lam);
H = -g2;

for ll = 1:length(kk)
    
    k=kk(ll);
    omeg=2*pi*k/N;
    i=sqrt(-1);
    z=exp(-i*omeg);
    hpfilt = H*(1-z)*(1-z)*(1-1/z)*(1-1/z)/((1-g1*z-g2*(z^2))*(1-g1/z-g2/(z^2)));
    
    F=zeros(10);
    F(1,10)=1-z;
    F(2,1)=1-z;
    F(2,6)=-(1-z);
    F(3,3)=1/4;
    F(4,5)=1;
    F(5,6)=1;
    F(6,1)=1;
    F(6,6)=-1;
    F(6,7)=-1;
    F(7,1)=-1;
    F(7,8)=1;
    F(8,1)=-1;
    F(8,9)=1;
    F(8,10)=1;
    F(9,4)=1;
    F(10,1)=1;
    F(10,2)=-(1/4)/(1-z);
    F(10,3)= (1/4)/(1-z);    
    
    G([[1:9],11],:)=eye(10);
    G(10,:)=zeros(1,10);
    G(10,1)=1;
    G(10,2)=1/(4*(1-z));
    G(10,3)=-G(10,2);
    
    A=a0betazout(:,[2:n+1])*z;
    if nlag > 1
        for ii = 2:nlag
            A=A+a0betazout(:,[2+n*(ii-1):2+n*(ii-1)+n-1])*(z^ii);
        end
    end
    
    I1=zeros(10,10);
    I2=zeros(10,10);
    I9=zeros(10,10);
    II=zeros(10,10);
    I1(1,1)=1;
    I2(2,2)=1;
    I9(9,9)=1;
    tt=[1 2 9];
    for jj = 1:3
        II(tt(jj),tt(jj))=1;
    end
    I=eye(10);
    DD=G*inv(F)*inv(I-A);
    [Sy(:,:,ll),Sy1(:,:,ll),Sy2(:,:,ll),Sy9(:,:,ll),Syy(:,:,ll),dSy1(:,:,ll),dSy2(:,:,ll),dSy9(:,:,ll),dSyy(:,:,ll)] ...
        = specthelp(DD,C,I1,I2,I9,II);
    DDHP=hpfilt*G*inv(F)*inv(I-A);
    [HPSy(:,:,ll),HPSy1(:,:,ll),HPSy2(:,:,ll),HPSy9(:,:,ll),HPSyy(:,:,ll),HPdSy1(:,:,ll),HPdSy2(:,:,ll),HPdSy9(:,:,ll),HPdSyy(:,:,ll)] ...
        = specthelp(DDHP,C,I1,I2,I9,II);
        
end

[b1,b2,b9,ball] = getvar(kk,a,b,N,Sy,Sy1,Sy2,Sy9,Syy);
bhp=N/kk(1);
ahp=N/kk(end);
[s1,s2,s9,ss] = getvar(kk,ahp,bhp,N,HPSy,HPSy1,HPSy2,HPSy9,HPSyy);

hp=[real(s1) real(s2) real(s9) real(ss)];
bp=[real(b1),real(b2),real(b9),real(ball)];
%the data whose spectral density is being computed is ordered as follows:
name = char('Output','Money Growth','Inflation','Fed Funds','Capacity Util','Avg Hours','Real Wage','Consumption','Investment','income velocity','Price of Inv.');

if iplt == 1
    aa=floor(N/a);
    bb=floor(N/b);
    for ii = 1:11
        subplot(3,4,ii)
        plot(2*pi*kk/N,dSy9(ii,:),2*pi*aa/N,dSy9(ii,aa),'*',2*pi*bb/N,dSy9(ii,bb),'*')
        title(name(ii,:))
        axis tight
    end
    hout=suptitle('monetary policy shock');
    figure
    for ii = 1:11
        subplot(3,4,ii)
        plot(2*pi*kk/N,dSy1(ii,:),2*pi*aa/N,dSy1(ii,aa),'*',2*pi*bb/N,dSy1(ii,bb),'*')
        title(name(ii,:))
        axis tight
    end
    hout=suptitle('embodied shock');
    
    figure
    for ii = 1:11
        subplot(3,4,ii)
        plot(2*pi*kk/N,dSy2(ii,:),2*pi*aa/N,dSy2(ii,aa),'*',2*pi*bb/N,dSy2(ii,bb),'*')
        title(name(ii,:))
        axis tight
    end
    hout=suptitle('neutral shock');
    
    figure
    for ii = 1:11
        subplot(3,4,ii)
        plot(2*pi*kk/N,dSyy(ii,:),2*pi*aa/N,dSyy(ii,aa),'*',2*pi*bb/N,dSyy(ii,bb),'*')
        title(name(ii,:))
        axis tight
    end
    hout=suptitle('all three identified shocks');
end