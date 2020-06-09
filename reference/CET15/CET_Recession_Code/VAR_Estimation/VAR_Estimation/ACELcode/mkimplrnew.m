function [impzout,vdout,simdataout,erzout,azeroout,a0betazout,var_explode,V,D] = mkimplrnew(vardata,nlags,nstep,hasconst,trendval,vardetrend,fflocation,sortlev,testrestriction);
% modified RDC 05/31/2004 removed "fflocation" from simdataout to compare with jonas
% MKIMPLR : A program to estimate a Long Run VAR with a permanent shock to the price of investment and a permanent shock to productivity. 
% Optionally one can also impose a Fed Funds Restriction, in order to identify a monetary policy shock. 
% Calling the program. 
% mkimplrnew(vardata,nlags,nstep,hasconst,trendval,vardetrend,fflocation,sortlev);
% REQUIRED INPUTS
% vardata: Date used for the VAR, each variable is in a column. It is assumed that the permnent shocked variables are listed first. 
% In other words, that the price of investment is listed first and either labor productivity growth or output growth is listed second. 
% If you also identify a monetary policy shock then the other variables should be ordered as in a recursive monetary var
% NLAGS is the number of lags in the VAR. 
% NSTEP is the number of steps out to calculate the impulse responses. 
% OPTIONAL INPUTS 
% HASCONST determines whether the VAR has a constant. 1 equals yes. 
% TRENDVAL is the degree of the time-trend polynomial to remove from the variables listed in vardetrend
% VARDETREND is what variables are in teh VAR. 
% FFLOCATION describes where the Fed Funds rate is. (In other words for all variables above this will be assumeed to have 
% a block recursive form. 
% ie  A_0 = [A 0; B C] where A is (FFLocation-1) by (FFLocation-1) square. 
% SORTLEV is the name of the file used to sort out the variables and put them in level
% in other words, you might estimate the var (dp dy dh) and   want impulse responses for 
% for P, Y and H. The program sortlew will describe how to change (dp dy dh) into (p y h).
% TESTRESTRICTION = 1 if you want to test overidentifying restrictions
% OUTPUT FROM THE PROGRAM
% impzout are the impulse responses they are a multidimensional matrix that the number of rows is the number of steps.
% the columns are the variables and the third dimension (the worksheet) are the different shocks. 
% vdout  is the variance decompositions. 
% simdataout is the historical decompositions. 
% erzout are the residuals from the VAR
% azeroout the estimate of A0 matrix. 
% a0betazout  the estimate of the inv(A0)*A(L) matrix. 
% in other words the reduced form VAR is y(t) = a0betazout* y(t-1) + inv(Azeroout)*erz(t). 
% var_explode equals one if the VAR has eigenvalues outside the unit circle. 

%   By Robert Vigfusson August 2002
%   Modified by Riccardo DiCecio November 2002

[nobs,nvars] = size(vardata);  %number of variables

if nargin<9
    testrestriction=0;
end
if nargin <7
   fflocation = [];
   fflocationtrue = [];
end

%remove trend 
if nargin > 4
   if trendval > 0
      remtrnd = ones(nobs,1+trendval);
      for nx = 1:trendval
         remtrnd(:,1+nx) = (1:nobs)'.^nx;
      end
      rtrndcoef = remtrnd\vardata;
      vardata(:,vardetrend) = vardata(:,vardetrend) - remtrnd(:,2:end)*rtrndcoef(2:end,vardetrend);
   end
end


y   = vardata((nlags+1):end,1:end);
xx  = zeros(length(y),nlags*nvars);
x   = zeros(length(y),nlags*nvars);
erz = zeros(size(y));

for zx = 1:nlags
   xx(:,(zx-1)*nvars+1:zx*nvars)      = vardata((nlags+1+1)-zx:end-zx+1,:) -  vardata((nlags+1)-zx:end-zx,:);
   x(:,(zx-1)*nvars+1:zx*nvars)       = vardata((nlags+1)-zx:end-zx,:);
end
xx1=xx;

%replace double difference with first differnce for first variable
xx(:,1:nvars:end) = x(:,1:nvars:end);

if nargin > 6 & ~isempty(fflocation)
      %impose that a0,1 fflocation to nvars equals zero. 
      xx = xx(:,[1:fflocation-1 nvars+1:end]);   
end

if hasconst==1
   const = ones(size(xx,1),1);
else
   const = []
end


xmat = [const xx];
zmat = [const x];
xhat = zmat*(zmat\xmat);
yhat = zmat*(zmat\y(:,1));
b1 = xhat\yhat;

erz(:,1)  = y(:,1)-xmat*b1;

bcon = zeros(nvars,1);
if hasconst==1
    bcon(1)= b1(1);
end

b1 = b1(1+hasconst:end); %only does something if there is a constant. 
e1 = erz(:,1); %the price of investment shock
b1 = b1';

if nargin > 6 & ~isempty(fflocation) %imposing the fed funds identification.
      b1alt = zeros(size(b1)+[0 nvars-fflocation+1]);
      b1alt([1:fflocation-1 (nvars+1):end]) = b1;
      b1 = b1alt;   
end

azero = eye(nvars);
azero(1,2:end) = -1*b1(2:nvars);

betaz = zeros(nvars,nvars*nlags);
betaz(1,1:nvars:end) = b1(1:nvars:end);
bjnk = [b1 zeros(1,nvars)] -  [zeros(1,nvars) b1];

for zq=2:nvars
   betaz(1,zq:nvars:end) = bjnk(1,(nvars+zq):nvars:end);
end


%replace double difference with first differnce for first and second variable
xx1(:,1:nvars:end) = x(:,1:nvars:end);
xx1(:,2:nvars:end) = x(:,2:nvars:end);

if nargin > 6 & ~isempty(fflocation)
      %impose that a0,1 fflocation to nvars equals zero. 
      xx1 = xx1(:,[1:fflocation-1 nvars+1:end]);
end

xmat = [const y(:,1) xx1];
zmat = [const x erz(:,1)];
xhat = zmat*(zmat\xmat);
yhat = zmat*(zmat\y(:,2));
b2 = xhat\yhat;

erz(:,2)  = y(:,2)-xmat*b2;
if hasconst==1
bcon(2)= b2(1);
end
azero(2,1)  =   -1*b2(2);

b2 = b2(2+hasconst:end); %gets rid of a constant (if there is one) and of the coeff. on the contemp. variable 
e2 = erz(:,2); %the technology shock
b2 = b2';

if nargin > 6 & ~isempty(fflocation) %imposing the fed funds identification.
    b2alt = zeros(size(b2)+[0 nvars-fflocation+1]);
    b2alt([1:fflocation-1 (nvars+1):end]) = b2;
    b2 = b2alt;   
end

azero(2,3:end) = -1*b2(3:nvars);

betaz(2,1:nvars:end) = b2(1:nvars:end);
betaz(2,2:nvars:end) = b2(2:nvars:end);

bjnk = [b2 zeros(1,nvars)] -  [zeros(1,nvars) b2];

for zq=3:nvars
   betaz(2,zq:nvars:end) = bjnk(1,(nvars+zq):nvars:end);
end


xx = x; %replace double difference with first differnce

for zx=3:nvars
    %iv estimation
    xmat = [const y(:,1:(zx-1)) xx];
    zmat = [const x erz(:,1:(zx-1))];
    xhat = zmat*(zmat\xmat);
    yhat = zmat*(zmat\y(:,zx));
    btmp = xhat\yhat;
    erz(:,zx) = y(:,zx)-xmat*btmp;
    if hasconst
        bcon(zx)= btmp(1);
    end      
    btmp = btmp(1+hasconst:end); %only does something if there is a constant. 
    btmp = btmp';
    azero(zx,1:(zx-1)) = -1*btmp(1:(zx-1));
    btmp = btmp((zx-1)+1:end);
    betaz(zx,:) = btmp;   
end


a0inv = inv(azero);
zlag=zeros(1,nlags*nvars);

a0betaz = zeros(size(betaz));
for mx=1:nlags
   a0betaz(:,1+(mx-1)*nvars:mx*nvars) = a0inv*betaz(:,1+(mx-1)*nvars:mx*nvars);
end

if  hasconst
   a0betazout = [a0inv*bcon  a0betaz];
else
   a0betazout = a0betaz;
end

azeroout = azero;
erzout   = erz;
betaz= a0betaz';

% Testing Overid. restrictions
if testrestriction == 1
    uznew =y - [const x]*a0betazout';
    betavar = [const x]\y;
    uzur = y - [const x]*betavar;
    siguznew = cov(uznew,1);
    sigur   = cov(uzur,1);
    'test of over identifying restrictions'
    size(y,1)*(log(det(siguznew))-log(det(sigur)))
    ['critical value with ' num2str(2*(nvars-fflocation+1)) '  restrictions']
    [[0.9 0.95 0.99]' chi2inv([0.9 0.95 0.99]',2*(nvars-fflocation+1))]
    'A0 as a factor of the reduced form variance covariance matrix';
    azero*cov(uznew)*azero'-cov(erz);
end


bigA = [betaz'; kron(eye(nvars),eye(nlags-1)) zeros(nvars*(nlags-1),nvars)];
var_explode = sum(abs(eig(bigA))>1);
[V,D]=eig(bigA);

if var_explode > 0
   abs(eig(bigA));
   disp('VAR Explosive') 
end

%calculate moving average representation and through this the impulse responses.
%in calculating moving average representation include the std of the shocks.

marep = zeros([nvars nvars nstep]);

for allshks = 1:size(erz,2)
   shock = [std(erz(:,allshks))*a0inv(:,allshks)';zeros(nstep-1,nvars)];  
   zlag=zeros(1,nlags*nvars);   
   for jj=1:nstep
      imptmp = shock(jj,:)+zlag*betaz(1:length(betaz),:);
      marep(:,allshks,jj)=imptmp;
      zlag=[imptmp zlag(1,1:(nlags-1)*nvars)];
   end
end

if nargin < 7
   fflocation = nvars-1;
   %just assign a pointless fflocation 
   %otherwise we need too many other if statements in the following lines. 
elseif isempty(fflocation)
   fflocationtrue = [];
   fflocation = nvars-1;
   %just assign a pointless fflocation 
   %otherwise we need too many other if statements in the following lines. 
else
   fflocationtrue = fflocation;
end

 
   

if nargin<8
    %do everything in differences
    impzout = zeros(size(marep,3),size(marep,1),2);
    impzout(:,:,1) = squeeze(marep(:,1,:))';
    impzout(:,:,2) = squeeze(marep(:,2,:))';
    impzout(:,:,3) = squeeze(marep(:,fflocation,:))';
    impzout(:,:,4) = squeeze(marep(:,end,:))';
    
    if nargout > 1
        msed     = marep(:,:,1)*marep(:,:,1)';
        msedprice = marep(:,1,1)*marep(:,1,1)';
        msedtech = marep(:,2,1)*marep(:,2,1)';
        msedff   = marep(:,fflocation,1)*marep(:,fflocation,1)';
        nx = 1;
        vdprice      = zeros(nvars,nstep);
        vdtech      = zeros(nvars,nstep);
        vdff        = zeros(nvars,nstep);
        vdtech(:,nx) = diag(msedtech(:,:,nx))./diag(msed(:,:,nx));
        vdprice(:,nx) = diag(msedprice(:,:,nx))./diag(msed(:,:,nx));
        vdff(:,nx) = diag(msedff(:,:,nx))./diag(msed(:,:,nx));
        for nx = 2:size(marep,3)
            msed(:,:,nx)      = msed(:,:,nx-1)     + marep(:,:,nx)*marep(:,:,nx)';
            msedprice(:,:,nx)  = msedtech(:,:,nx-1) + marep(:,1,nx)*marep(:,1,nx)';
            msedtech(:,:,nx)  = msedtech(:,:,nx-1) + marep(:,2,nx)*marep(:,2,nx)';
            msedff(:,:,nx)    = msedff(:,:,nx-1)   + marep(:,fflocation,nx)*marep(:,fflocation,nx)';
            vdprice(:,nx)      = diag(msedprice(:,:,nx))./diag(msed(:,:,nx));
            vdtech(:,nx)      = diag(msedtech(:,:,nx))./diag(msed(:,:,nx));
            vdff(:,nx)        =   diag(msedff(:,:,nx))./diag(msed(:,:,nx));
        end
        vdout = cat(3,vdprice,vdtech,vdff);
    end
    
else 
   %report results in levels.
   nx = 1;
   malevtemp = feval(sortlev,squeeze(marep(:,nx,:))')';
   malev = zeros(size(malevtemp,1),nvars, size(malevtemp,2));
   malev(:,1,:) = malevtemp;
   for nx=2:size(marep,2)
      malev(:,nx,:) =  feval(sortlev,squeeze(marep(:,nx,:))')';
   end
   %impulse responses   
   impzout = zeros(size(malev,3),size(malev,1),3);
   impzout(:,:,1) = squeeze(malev(:,1,:))';
   impzout(:,:,2) = squeeze(malev(:,2,:))';
   impzout(:,:,3) = squeeze(malev(:,fflocation,:))';
   impzout(:,:,4) = squeeze(malev(:,end,:))';
   
   if nargout > 1
      %calculate mse 
      mselev             = zeros(size(malev,1),size(malev,1),nstep);
      mselevprice        = zeros(size(malev,1),size(malev,1),nstep);
      mselevtech         = zeros(size(malev,1),size(malev,1),nstep);
      mselevff           = zeros(size(malev,1),size(malev,1),nstep);
      mselevvel          = zeros(size(malev,1),size(malev,1),nstep);
      
      mselev(:,:,1)          = malev(:,:,1)*malev(:,:,1)';
      mselevprice(:,:,1)      = malev(:,1,1)*malev(:,1,1)';
      mselevtech(:,:,1)      = malev(:,2,1)*malev(:,2,1)';
      mselevff(:,:,1)        = malev(:,fflocation,1)*malev(:,fflocation,1)';
      mselevvel(:,:,1)       = malev(:,end,1)*malev(:,end,1)';
      
      vlevprice          = zeros(size(malev,1),nstep);
      vlevtech           = zeros(size(malev,1),nstep);
      vlevff             = zeros(size(malev,1),nstep);
      vlevvel            = zeros(size(malev,1),nstep);
      
      vlevprice(:,1) = diag(mselevprice(:,:,1))./diag(mselev(:,:,1));
      vlevtech(:,1) = diag(mselevtech(:,:,1))./diag(mselev(:,:,1));
      vlevff(:,1)   = diag(mselevff(:,:,1))./diag(mselev(:,:,1));
      vlevvel(:,1)   = diag(mselevvel(:,:,1))./diag(mselev(:,:,1));
      
      for nx = 2:size(malev,3)
         mselev(:,:,nx)      = mselev(:,:,nx-1)     + malev(:,:,nx)*malev(:,:,nx)';
         mselevprice(:,:,nx)  = mselevprice(:,:,nx-1) + malev(:,1,nx)*malev(:,1,nx)';
         mselevtech(:,:,nx)  = mselevtech(:,:,nx-1) + malev(:,2,nx)*malev(:,2,nx)';
         mselevff(:,:,nx)    = mselevff(:,:,nx-1)   + malev(:,fflocation,nx)*malev(:,fflocation,nx)';
         mselevvel(:,:,nx)    = mselevvel(:,:,nx-1)   + malev(:,end,nx)*malev(:,end,nx)';
         vlevprice(:,nx)      = diag(mselevprice(:,:,nx))./diag(mselev(:,:,nx));
         vlevtech(:,nx)      = diag(mselevtech(:,:,nx))./diag(mselev(:,:,nx));
         vlevff(:,nx)        =   diag(mselevff(:,:,nx))./diag(mselev(:,:,nx));
         vlevvel(:,nx)        =   diag(mselevvel(:,:,nx))./diag(mselev(:,:,nx));   
      end
      vdout = cat(3,vlevprice,vlevtech ,vlevff,vlevvel);
   end
end

if nargout > 2
   %simulate data.
   simdataprice =   zeros(nobs-nlags,nvars);
   simdatatech  = zeros(nobs-nlags,nvars); 
   simdataff  = zeros(nobs-nlags,nvars); 
   simdatavel  = zeros(nobs-nlags,nvars); 
   
   simdata  = zeros(nobs-nlags,nvars); 
   fullsimdata  = zeros(nobs-nlags,nvars);  
   zlag  = zeros(1,nlags*nvars);
   zlagff  = zeros(1,nlags*nvars);
   zlagprice  = zeros(1,nlags*nvars);
   zlagtech  = zeros(1,nlags*nvars);
   zlagfull  = zeros(1,nlags*nvars);
   zlagvel  = zeros(1,nlags*nvars);
   
   %calculate simulated data. 
   for jj=1:(nobs-nlags)
      simdataprice(jj,:)  =(erz(jj,1)*a0inv(:,1)')+zlagprice*betaz(1:length(betaz),:);
      zlagprice        = [simdataprice(jj,:) zlagprice(1,1:(nlags-1)*nvars)];   
      simdatatech(jj,:)  =(erz(jj,2)*a0inv(:,2)')+zlagtech*betaz(1:length(betaz),:);
      zlagtech        = [simdatatech(jj,:) zlagtech(1,1:(nlags-1)*nvars)];   
      simdataff(jj,:)  =(erz(jj,fflocation)*a0inv(:,fflocation)')+zlagff*betaz(1:length(betaz),:);
      zlagff       = [simdataff(jj,:) zlagff(1,1:(nlags-1)*nvars)];   
      simdatavel(jj,:)  =(erz(jj,end)*a0inv(:,end)')+zlagvel*betaz(1:length(betaz),:);
      zlagvel      = [simdatavel(jj,:) zlagvel(1,1:(nlags-1)*nvars)];   
      simdata(jj,:)  =(erz(jj,[1 2 fflocation])*a0inv(:,[1 2 fflocation])')+zlag*betaz(1:length(betaz),:); %RDC 05/31/2004 removed fflocation to compare with jonas
      zlag        = [simdata(jj,:) zlag(1,1:(nlags-1)*nvars)];   
      fullsimdata(jj,:)  = (a0inv*erz(jj,:)')'+zlagfull*betaz(1:length(betaz),:);
      zlagfull        = [fullsimdata(jj,:) zlagfull(1,1:(nlags-1)*nvars)];
   end 
   
   if nargin<8
      simdataout = cat(3,simdataprice,simdatatech,simdataff,simdata,fullsimdata);
   else
      simdataout = cat(3,feval(sortlev,simdataprice),feval(sortlev,simdatatech),feval(sortlev,simdataff),feval(sortlev,simdata),feval(sortlev,fullsimdata));
   end
end

% if or(nargin < 7,isempty(fflocationtrue))
%    %then fflocation is not defined and the ffunds shocks and velocity shock are really not defined. 
%    impzout  =  squeeze(impzout(:,:,1));
%    if nargout > 1
%       vdout = squeeze(vdout(:,:,1));
%    end
%    if nargout > 2
%       simdataout = simdataout(:,:,[1 end]);
%    end
% end
 