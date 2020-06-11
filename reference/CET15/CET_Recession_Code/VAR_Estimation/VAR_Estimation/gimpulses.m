function  gimpulses(vardata,impzout,nlags,nsteps,hascon,ffshk,ndraws,PortmanteauLags,a,b,lam);

%the key output of this program is the mat file, VAR_IRFsAndSEs. This has
%in it:
%IRFFF, estimated impulse responses to the monetary policy shock, rows are
%        steps ahead and columns variables, in the order listed in varnamz below.
%IRFFFSE, standard errors of the corresponding elements in IRFFF
%IRFz, estimated responses to the neutral technology shock
%IRFzSE, standard errors of IRFz
%IRFu, estimated responses to embodied technology shock
%IRFuSE, standard errors of IRFu
%
%the program produces other output and mat files. Some of these have been
%disactivated. Others work, and may be useful later.

global cut_jobdata

warning off
[simimp,simvd,simdata,count_var_expl,EtechtabStd,NtechtabStd,montabStd,alltabStd,histhpStd,histbpStd,PortStatData,PortSimMat, ...
    Etechtabmean,Ntechtabmean,montabmean,alltabmean,histhpmean,histbpmean] ...
    = mkimplrnewci(vardata,nlags,nsteps,hascon,[],[],ffshk,'sortlp',ndraws,PortmanteauLags,a,b,lam);

%simimp is a nsteps by nvars by ndraws matrix of impulse responses...
%impzout has the empirical estimate of the impulse responses...

save simforfilter simdata
warning on
%varnamz = char('Output','MZM Growth','Inflation','Fed Funds','Capacity Util','Avg Hours','Real Wage','Consumption','Investment','Velocity','Price of Inv.');
if cut_jobdata == 1
    varnamz = char('Log, output','Inflation','Fed Funds','Capacity Util','log hours','Log, real wage','Log, consumption','Log, investment','log, Price of Inv.','Unemployment','log, Vacancies','Log labor force');
else
    varnamz = char('Log, output','Inflation','Fed Funds','Capacity Util','log hours','Log, real wage','Log, consumption','Log, investment','log, Price of Inv.','Unemployment','log, Vacancies','Log labor force', 'Separation Rate','Finding Rate');
end
% [impzout,vdout,simdataout,erzout,azeroout,a0betazout,var_explode,V,D] = mkimplrnew(vardata,nlags,nsteps,hascon,[],[],ffshk,'sortlp',0);
pnstep=nsteps;%20;
figure, orient landscape
n1=4;
n2=4;
zxmax=14;
if cut_jobdata == 1
    n1=3;
    zxmax=12;
end
for zx=1:zxmax
    subplot(n1,n2,zx)
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
suptitle('Embodied Technology Shock')
print -dpdf embodied

figure, orient landscape
for zx=1:zxmax
    subplot(n1,n2,zx)
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
suptitle('Neutral Technology Shock');
print -dpdf neutral

figure, orient landscape
for zx=1:zxmax
    subplot(n1,n2,zx)
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
suptitle('Fed Funds Shock')
print -dpdf policy

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

%impzvar is a column vector with the empirical impulse responses and the
%zxmax-1 zeros in the contemporaneous responses to policy shocks
%eliminated. Thus, the length of impzvar is nvars*nsteps*3 - (zxmax-1)
%the responses in impzvar are, first, the embodied shock, then the neutral
%and finally the policy shock. The variables are ordered in the same way
%that they appear in varnamz. So, the first 20 entries of varnamz is the 20
%responses of output to an embodied shock, the second is the 20 respones of
%inflation to an embodied shock, etc. The vector, stdirf, contains the
%standard errors of the objects in impzvar.

%save var20pi_yunits impzvar dimpzvar Vmat%this is used in the plotting algorithm
%save compare20pi_yunits simimp impzout pnstep

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
IRFFFSE = [squeeze(stdbootout(:,:,3))]; %std; diagonal of full covariance matrix

%get full covariance matrix
FedFundsResponses=squeeze(simimp(1:nsteps,[1:8,10,11,12],3,:)); %only for FEDFUNDS shock, take out relative price of investment and vacancies
FedFundsResponses_reshaped=reshape(FedFundsResponses,size(FedFundsResponses,1)*size(FedFundsResponses,2),size(FedFundsResponses,3)); %vectorize matrix for each draw
IRFFFCOV=cov(FedFundsResponses_reshaped');%calculate the covariance matrix

%check: IRFFFSE must be equal to square root of full covariance matrix
IRFFFSE2=reshape(sqrt(diag(IRFFFCOV)),size(FedFundsResponses,1),size(FedFundsResponses,2));

if max(max(abs(IRFFFSE(:,[1:8,10,11,12])-IRFFFSE2)))>1e-6,
    error('fatal (gimpulses): IRFFFSE not equal to IRFFFSE2');
end

IRFu   = [squeeze(impzout(:,:,1))]; %point estimates for positive p_i shock
IRFuSE = [squeeze(stdbootout(:,:,1))];%std

IRFFF = -IRFFF; %Take a negative policy shock.
IRFu  = -IRFu;  %Take a negative p_i shock, i.e. a positive investment specific shock

%Set the values of IRFFF exactly to zeros so they are taken out of the criterion below
IRFFF(1,[[1:2],[4:zxmax]])   = zeros(1,zxmax-1);
IRFFFSE(1,[[1:2],[4:zxmax]]) = zeros(1,zxmax-1);

%save all responses
save VAR_IRFsAndSEs IRFFF IRFFFSE  IRFz IRFzSE IRFu IRFuSE

% %take out relative price of investment and vacancies
% IRFFF=IRFFF(:,[1:8,10,11,12]);
% IRFFFSE=IRFFFSE(:,[1:8,10,11,12]);
% 
% % Computing the weighting matrix used to compute the standard errors of the
% % point estimates
% 
% nvarslev = size(simimp,2); %number of variables
% nreps    = size(simimp,4); %number of repetitions
% 
% bigmat = zeros(3*nsteps*nvarslev-(nvarslev-1)-39,nreps); %minus (nvarslev-1) because zero restrictions in first period after
% %monetary policy shock,
% %minus 39 because monetary policy (19) and neutral technology (20) have no impact
% %on price of investment goods
% 
% %the following stacks the impulse response functions into a big column vector, bigmat.
% %Impulse responses that are known to be zero are dropped (i.e., the impact effect of
% %monetary policy shocks on all but R and the dynamic effects of monetary
% %policy shocks and neutral technology shocks on the price of investment.
% %pol - refers to monetary policy shock; em - refers to embodied shock; ne - refers to neutral technology
% 
% if nsteps == 20
%     for i=1:nreps;
%         poltmpmat = -squeeze(simimp(:,:,3,i));
%         poltmpvec = 0;
%         keepirff = [3 10^6]; %note 10^6 never used by the code
%         for j=1:nvarslev;
%             if j == keepirff(1)
%                 poltmpvec = [poltmpvec; poltmpmat(:,j)];
%                 keepirff = keepirff(2:end);
%             elseif j ~= keepirff(1);
%                 poltmpvec = [poltmpvec; poltmpmat(2:end,j)];
%             end;
%         end;
%         poltmpvec = poltmpvec(2:end); %take away initial zero
%         poltmpvec = poltmpvec(1:end-(nsteps-1)); %removing the cap price IRFs
%         emttmpmat =-squeeze(simimp(:,:,1,i));
%         emttmpvec = emttmpmat(:); %matrix to vector
%         nettmpmat = squeeze(simimp(:,:,2,i));
%         nettmpvec = nettmpmat(:); %matrix to vector
%         nettmpvec = nettmpvec(1:end-nsteps); %removing the cap price IRFs
%         bigmat(:,i) = [poltmpvec;emttmpvec;nettmpvec];
%     end;
%     % NOTE: Structure of bigmat is IRFFF, IRFu, IRFx x ndraws
%     
%     %Computing the covariance matrix for the IRFs
%     WhatMat = cov(bigmat',1);
%     
%     save WhatMat WhatMat;
end


