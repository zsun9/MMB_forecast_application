function [qstat,dof,pvalue] = mkqmv(rez,s,nlags,test);
% 
% computes the multivariate Ljung-Box portmanteau or Q test for white noise, with s lags
% the 'data', rez, are residuals from a vector autoregression with nlags lags
% The technical details may be found in the Stata Technical Bulletin stb-60
% which adopted it from Hosking and Johansen 1995, p 22
%
% rez - the residuals, must have observations in rows and variables in columns
% qstat - the q statistic
% dof - under the null hypothesis of white noise, the qstatistic has a chi-square distribution with dof degrees of freedom
% pvalue - probability, under null hypothesis, that a chisquare with dof degrees of freedom will exceed qstat

[T,n]=size(rez);
if T < n
    error('fatal (mkqmv) rows must correspond to time and columns to variables')
end

j= 0;
c00 =   rez(j+1:end,:)' * rez(1:end-j,:) / T;
ic00 = inv(c00);
lb = 0;
for j=1:s;
    c0j =   rez(j+1:end,:)' * rez(1:end-j,:) / T;
    term = sum(diag(c0j*ic00*(c0j')*ic00))/(T-j);
    lb = lb + term;
 end
 
 lb = T*(T+2)*lb;
 qstat = lb;
 if test == 1
     dof=n*n*(s-nlags);
     pvalue=1-chi2cdf(qstat,dof);
 else
     dof=[];
     pvalue=[];
 end