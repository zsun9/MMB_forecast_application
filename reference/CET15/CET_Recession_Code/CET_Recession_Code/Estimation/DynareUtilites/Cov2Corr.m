function [Stds,CorrMat]=Cov2Corr(CovMat)
% Transforms a covariance matrix into Correlation  matrix + vector of
% standard deviations.
Stds=sqrt(diag(CovMat))';
CorrMat=inv(diag(Stds))*CovMat*inv(diag(Stds));