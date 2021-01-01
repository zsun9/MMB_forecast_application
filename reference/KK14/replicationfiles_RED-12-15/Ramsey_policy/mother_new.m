
function [lnpriormom] = mother_new(data,Pstar,H,bayestopt_,T,trend)

% Code to implement notes on endogenous priors by Lawrence Christiano,
% specified in "endogenouspriors.tex" 

% call this function from DSGElikelihood.m with the following lines at the
% very end of that file:
% lnpriormom = mother_new(data,Pstar,H,bayestopt_,T,trend);
% fval    = (likelihood-lnpriormom-lnprior);

%this is the 'mother' of the priors on the model parameters.
%
%the priors include a metric across some choosen moments of the (supposedly
%pre-sample) data.
% *** Implemented file for variances, but in principle any moment
% *** could be matched
%As a default, the prior second moments are computed from the same sample
%used to find the posterior mode. This could be changed by making the
%appropriate adjustment to the following code.

end_prior=1;   % switch to turn on or off endogenous priors
if end_prior   % otherwise use std priors
    Y=data(:,1:end)';
    Tsamp=size(Y,1);    % sample length 
    n=size(Y,2);        % number of matched moments: here set equal to nr of observables

    Fhat=zeros(n,1);
    hmat=zeros(n,Tsamp);
    Ydemean=zeros(Tsamp,n);
    C0=zeros(n,n);
    C1=zeros(n,n);
    C2=zeros(n,n);
    
    % obtain GMM estimator of variance
    % this GMM-approach is probably overkill, and takes 0.3 seconds
%    x0=1;
%    opts=optimset('Display','on','MaxIter',10000,'MaxFunEvals',200000,'TolFun',1e-10,'TolX',1e-10);
%     for j=1:n
%         Ydemean(:,j)=Y(:,j)-mean(Y(:,j));
%         [yyy,fval]=fzero(@Fhat_est_scalar,x0,opts,Ydemean(:,j),Tsamp);
%         Fhat(j)=yyy;
%     end
    % Instead simply use: Fhat=diag(Ydemean'*Ydemean)/Tsamp, same results;
    for j=1:n
        Ydemean(:,j)=Y(:,j)-mean(Y(:,j));
    end
    Fhat=diag(Ydemean'*Ydemean)/Tsamp;
    
    % we need ht, where t=1,...,T
    for t=1:Tsamp
        hmat(:,t)=diag(Ydemean(t,:)'*Ydemean(t,:))-Fhat;
    end
   
% To calculate Shat we need C0, C1 and C2
for t=1:Tsamp  
    C0=C0+1/Tsamp*hmat(:,t)*hmat(:,t)';
end
 
for t=2:Tsamp  
    C1=C1+1/(Tsamp-1)*hmat(:,t)*hmat(:,t-1)';
end 

for t=3:Tsamp  
    C2=C2+1/(Tsamp-2)*hmat(:,t)*hmat(:,t-2)';
end 
    
     % Finally, we have the sampling uncertainty measure Shat:
     Shat=C0 +(1-1/(2+1))*(C1+C1')...
             +(1-2/(2+1))*(C2+C2');
   
    
    % Model variances below:
    mf=bayestopt_.mf;
    II=eye(size(T,2));
    Z=II(mf,:);
    %Ey=trend(:,1);
    % This is Ftheta, variance of model variables, given param vector theta:
    Ftheta=diag(Z*Pstar(:,mf));  % +H+Ey*Ey');
    

% below commented out line is for Del Negro Schorfheide style priors:
%     lnpriormom=-.5*n*TT*log(2*pi)-.5*TT*log(det(sigma))-.5*TT*trace(inv(sigma)*(gamyy-2*phi'*gamxy+phi'*gamxx*phi));
    lnpriormom=.5*n*log(Tsamp/(2*pi))-.5*log(det(Shat))-.5*Tsamp*(Fhat-Ftheta)'*inv(Shat)*(Fhat-Ftheta);
else

    lnpriormom=0;

end