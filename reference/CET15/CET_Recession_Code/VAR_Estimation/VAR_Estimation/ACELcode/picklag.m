function [AI,AIlag,HQ,HQlag,SW,SWlag,qstatistic,degf,peevalue] = picklag(vardata)
%
% This routine returns information useful for selecting the lag length of
% the VAR.
%
% It returns the lag length selected by Akaike (AIlag), Hannan-Quinn (HQ),
%and Schwarz (SWlag) mehods. It also returns the criteria themselves, for
%lags 1, ...., 8.
% Finally, it returns multivariate q statistics in qstatistic. This is
% an 8 by 3 matrix, with rows corresponding to VAR lag length (1,...,8)
% and column corresponding to lags 6, 8, 10 for the computation of the
% multivariate q statistic.
% degf contains the corresponding degrees of freedom
%
nsteps  = 30;
hascon  = 1;
nvars   = size(vardata,2);
%   identify a price of investment shock, a tech shock and a fed funds shock. (Fed Funds is the 9th variable in the VAR.)
ffshk = 9;

for nlags=1:8
    disp('nlags = ')
    nlags
  
    [impzout,vdout,simdataout,erzout,azeroout,a0betazout,var_explode,V,D] = mkimplrnew(vardata,nlags,nsteps,hascon,[],[],ffshk,'sortlp',1);
    [V] = getV(erzout);
    ai=inv(azeroout);
    sigma=ai*V*(ai');
    L=log(det(sigma));
    nobs=size(erzout,1);
    AI(nlags)=L+2*(nvars+(nvars^2)*nlags)/nobs;
    HQ(nlags)=L+2*(nvars+(nvars^2)*nlags)*log(log(nobs))/nobs;
    SW(nlags)=L+  (nvars+(nvars^2)*nlags)*log(nobs)/nobs;
    [qstat,dof,pvalue] = mkqmv(erzout,6,nlags,1);
    [qstat1,dof1,pvalue1] = mkqmv(erzout,8,nlags,1);
    [qstat2,dof2,pvalue2] = mkqmv(erzout,10,nlags,1);
    qstatistic(nlags,1)=qstat;
    qstatistic(nlags,2)=qstat1;
    qstatistic(nlags,3)=qstat2;
    degf(nlags,1)=dof;
    degf(nlags,2)=dof1;
    degf(nlags,3)=dof2;
    peevalue(nlags,1)=pvalue;
    peevalue(nlags,2)=pvalue1;
    peevalue(nlags,3)=pvalue2;
end
[Y,AIlag]=min(AI);
[Y,HQlag]=min(HQ);
[Y,SWlag]=min(SW);
