function [EtechtabStd,NtechtabStd,montabStd,alltabStd,histhpStd,histbpStd,PortStatData,PortSimMat,...
        Etechtabmean,Ntechtabmean,montabmean,alltabmean,histhpmean,histbpmean] ...
         =gimpulses(vardata,impzout,nlags,nsteps,hascon,ffshk,ndraws,PortmanteauLags,a,b,lam);

%Modified by Jesper Linde, returns the standard errors for the variance
%decompositions and bootstrapped p-values for the portmanteau test for null
%of no autocorrelation upto 6 and 8 lags.

warning off
[simimp,simvd,simdata,count_var_expl,EtechtabStd,NtechtabStd,montabStd,alltabStd,histhpStd,histbpStd,PortStatData,PortSimMat, ...
   Etechtabmean,Ntechtabmean,montabmean,alltabmean,histhpmean,histbpmean] ... 
= mkimplrnewci(vardata,nlags,nsteps,hascon,[],[],ffshk,'sortlp',ndraws,PortmanteauLags,a,b,lam);

save simforfilter simdata
warning on
varnamz = char('Output','MZM Growth','Inflation','Fed Funds','Capacity Util','Avg Hours','Real Wage','Consumption','Investment','Velocity','Price of Inv.');
% [impzout,vdout,simdataout,erzout,azeroout,a0betazout,var_explode,V,D] = mkimplrnew(vardata,nlags,nsteps,hascon,[],[],ffshk,'sortlp',0);
pnstep=20; 
figure, orient landscape
for zx=1:11
    subplot(4,3,zx)
    si = squeeze(simimp(1:pnstep,zx,1,:));
    stdirf1(:,zx)    =   std(si,1,2);
    plot(0:pnstep-1,-100*impzout(1:pnstep,zx,1),'k-')
    hold on
    grpyat = [(0:pnstep-1)' 100*(-impzout(1:pnstep,zx,1)-1.96*std(si,1,2)) ; (pnstep-1:-1:0)' 100*(-impzout(pnstep:-1:1,zx,1)+1.96*std(si(pnstep:-1:1,:),1,2))];
    patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]);     
    plot(0:pnstep-1,-100*impzout(1:pnstep,zx,1),'k-')
    title(varnamz(zx,:));
%     xlabel('Periods After Shock')
    axis tight
end
suptitle('Embodied Technology Shock'),print -dps2 figirfpi_lr

figure, orient landscape
for zx=1:11
    subplot(4,3,zx)
    si = squeeze(simimp(1:pnstep,zx,2,:));
    stdirf2(:,zx)    =   std(si,1,2);
    plot(0:pnstep-1,100*impzout(1:pnstep,zx,2),'k-')
    hold on
    grpyat = [(0:pnstep-1)' 100*(impzout(1:pnstep,zx,2)-1.96*std(si,1,2)) ; (pnstep-1:-1:0)' 100*(impzout(pnstep:-1:1,zx,2)+1.96*std(si(pnstep:-1:1,:),1,2))];
    patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]);     
    plot(0:pnstep-1,100*impzout(1:pnstep,zx,2),'k-')
    title(varnamz(zx,:));
%     xlabel('Periods After Shock')
    axis tight
end
suptitle('Neutral Technology Shock'),print -dps2 -append figirfpi_lr

figure, orient landscape
for zx=1:11
    subplot(4,3,zx)
    si = squeeze(simimp(1:pnstep,zx,3,:));
    stdirf3(:,zx)    =   std(si,1,2);
    plot(0:pnstep-1,-100*impzout(1:pnstep,zx,3),'k-')
    hold on
    grpyat = [(0:pnstep-1)' 100*(-impzout(1:pnstep,zx,3)-1.96*std(si,1,2)) ; (pnstep-1:-1:0)' 100*(-impzout(pnstep:-1:1,zx,3)+1.96*std(si(pnstep:-1:1,:),1,2))];
    patch(grpyat(:,1),grpyat(:,2),[0.7 0.7 0.7],'edgecolor',[0.65 0.65 0.65]);     
    plot(0:pnstep-1,-100*impzout(1:pnstep,zx,3),'k-')
    title(varnamz(zx,:));
%     xlabel('Periods After Shock')
    axis tight
end
suptitle('Fed Funds Shock'),print -dps2 -append figirfpi_lr

impztmp = impzout;
impzout(:,:,1)  =   -impzout(:,:,1);
impzout(:,:,3)  =   -impzout(:,:,3);
impzvar =   impzout(1:pnstep,:,1:3);
dimpzvar    =   diff(impzvar);
impzvar =   reshape(impzvar,1,[]);
dimpzvar    =   reshape(dimpzvar,1,[]);
tt      =   2*pnstep*size(varnamz,1);
mprestr =   [1:tt,find(abs(impzvar(tt+1:end))>1e-8)+tt];
impzvar =   impzvar(mprestr);
stdirf  =   [reshape(stdirf1,[],1);reshape(stdirf2,[],1);reshape(stdirf3,[],1)];
stdirf  =   stdirf(mprestr);
Vmat    =   sparse(diag(stdirf));
save var20pi_yunits impzvar dimpzvar Vmat%this is used in the plotting algorithm
save compare20pi_yunits simimp impzout pnstep

%Code modified here by JL 11/1/04
%Compute things needed to the estimation of the DSGE model

impzout = impztmp;

%convert to percentage units
impzout = impzout*100;
simimp = simimp*100; 

impzout =   impzout(1:nsteps,:,:);      % 20 steps IRF's to neutral tech. shock, embodied tech shock, monetary shock
stdbootout=std(simimp,[],4);            % std. dev. of bootstrapped IRF's
stdbootout =   stdbootout(1:nsteps,:,:);  % keep 20 steps for structural shocks only

IRFz   = [squeeze(impzout(:,:,2))];%point estimates for neutral shock
IRFzSE = [squeeze(stdbootout(:,:,2))];%std for neutral shock

IRFFF   = -[squeeze(impzout(:,:,3))]; %point estimates for fed funds shock
IRFFFSE = [squeeze(stdbootout(:,:,3))]; %std

IRFu   = [squeeze(impzout(:,:,1))]; %point estimates for positive p_i shock
IRFuSE = [squeeze(stdbootout(:,:,1))];%std

IRFFF = -IRFFF; %Take a negative policy shock.
IRFu  = -IRFu;  %Take a negative p_i shock, i.e. a positive investment specific shock

%Set the values of IRFFF exactly to zeros so they are taken out of the criterion below
IRFFF(1,[1 3 5:9 11])   = zeros(1,8);
IRFFFSE(1,[1 3 5:9 11]) = zeros(1,8);

save VAR_IRFsAndSEs IRFFF IRFFFSE IRFz IRFzSE IRFu IRFuSE;%these are used for the estimation

% Computing the weighting matrix used to compute the standard errors of the
% point estimates

nvarslev = size(simimp,2); %number of variables
nreps    = size(simimp,4); %number of repetitions

bigmat = zeros(3*nsteps*nvarslev-8-39,nreps); %minus 8 because zero restrictions in first period after policy shock,
                                              %then we also take out p_i
                                              %resp to policy and neutral
                                              %shock
 
 if nsteps == 20
     
     for i=1:nreps;
         poltmpmat = -squeeze(simimp(:,:,3,i));
         poltmpvec = 0;
         keepirff = [2 4 9 10^6]; %note 10^6 never used by the code
         for j=1:nvarslev;
             if j == keepirff(1)
                 poltmpvec = [poltmpvec; poltmpmat(:,j)];
                 keepirff = keepirff(2:end);
             elseif j ~= keepirff(1);
                 poltmpvec = [poltmpvec; poltmpmat(2:end,j)];
             end;
         end;
         poltmpvec = poltmpvec(2:end); %take away initial zero
         poltmpvec = poltmpvec(1:end-(nsteps-1)); %removing the cap price IRFs
         emttmpmat =-squeeze(simimp(:,:,1,i));
         emttmpvec = emttmpmat(:); %matrix to vector
         nettmpmat = squeeze(simimp(:,:,2,i));
         nettmpvec = nettmpmat(:); %matrix to vector
         nettmpvec = nettmpvec(1:end-nsteps); %removing the cap price IRFs
         bigmat(:,i) = [poltmpvec;emttmpvec;nettmpvec];
     end;    
     % NOTE: Structure of bigmat is IRFFF, IRFu, IRFx x ndraws 
     
     %Computing the covariance matrix for the IRFs
     WhatMat = cov(bigmat',1);
     
     save WhatMat WhatMat;
     
 end
 

