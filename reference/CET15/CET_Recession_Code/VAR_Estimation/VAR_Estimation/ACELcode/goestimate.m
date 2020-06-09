function [yy] = goestimate(xx,par,maxx,stderr,nsteps,name,II,criterion,taux,FR,product,hours,nlags,ndraws)

%this contains the variance-covariance matrix of the impulse responses,
%used in defining the estimation criterion

load VAR_IRFsAndSEs;

[IRFFF1,IRFu1,IRFz1] = setcrit(IRFFF,IRFu,IRFz,criterion);%this eliminate responses you don't want included in the criterion
psihat = [IRFFF1; IRFu1; IRFz1];%point estimates

Vhat   = [IRFFFSE; IRFuSE; IRFzSE].^2;%variances for point estimates

%take the parameters to be estimated (which must live in a restricted space), and map them into a space where
%they are not restricted
init    =   imap(xx);
fq=quadform(init,par,taux,nsteps,psihat,Vhat,[],1,0,criterion);

diary initialparameters.txt;
disp('(goestimate) Parameter settings going into estimation routine');
printestimate(xx,par,II,name)
type estimate
disp(['Criterion value  ' num2str(fq)]);
disp(' ');
diary off;

options = optimset('Display','iter','TolFun',1e-10,'TolX',1e-8,'maxiter',maxx,'MaxFun',maxx,'LargeScale','off');
[DD,ValDD,exitflag]=fminsearch('quadform',init,options,par,taux,nsteps,psihat,Vhat,[],1,0,criterion);

if exitflag == 0
    disp('(goestimate) maximum number of function evaluations reached')
elseif exitflag > 0
    disp('(goestimate) converged to a solution')
elseif exitflag < 0
    error('(goestimate) did not converge to a solution')
end

if isnan(ValDD) == 1 | abs(imag(ValDD)) > .1e-0
    error('fatal (goestimate) optimized function value not a sensible number')
end

%map from the unrestricted space into the restricted
yy      =   map(DD);

%compute the standard errors of the parameter estimates
if stderr > 0;
    chk=0;
    disp('(goestimate) be patient, it takes a few minutes to get the standard errors and there are no messages until it''s done...')
    xxse = ComputeStdErrors(yy,par,taux,nsteps,chk,IRFFF,IRFFFSE,IRFu,IRFuSE,IRFz,IRFzSE,criterion);
else
    xxse=zeros(size(xx));
end

[n,m]=size(xxse);
if n < m
    xxse=xxse';
end

diary estimresults.txt;
disp('Parameter estimates and standard errors');
[yy' xxse]
disp(['Criterion value  ' num2str(ValDD)]);
printestimate(yy,par,II,name)
disp('parameter values and names');
type estimate
disp(' ');
disp('Settings used to generate VAR impulse responses - see the lines at the beginning of main.m for explanations');
FR
product
hours
nlags
ndraws
nsteps
diary off;