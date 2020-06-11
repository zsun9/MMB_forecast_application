function [A,B]=hpmatrix(y,lam)
%
% this returns B=(I-inv(A)), such that yc=B*y is y-yt,
% and yc is the hp cycle and  yt is the hp trend of y, where
% yt solves the following programming problem:
%
% min {yt(1),...,yt(length(y))}
%    sum{t=1,...,length(y)} .5(yt(t)-y(t))^2
%  + sum{t=3,...,length(y)} lam*.5[yt(t)-2yt(t-1)+yt(t-2)]^2
%
ndat=length(y);
A=zeros(ndat);
for i=3:ndat-2
A(i,i)=6*lam+1;
A(i,i+1)=-4*lam;
A(i,i+2)=lam;
A(i,i-2)=lam;
A(i,i-1)=-4*lam;
end
A(2,2)=1+5*lam;
A(2,3)=-4*lam;
A(2,4)=lam;
A(2,1)=-2*lam;
A(1,1)=1+lam;
A(1,2)=-2*lam;
A(1,3)=lam;
A(ndat-1,ndat-1)=5*lam+1;
A(ndat-1,ndat)=-2*lam;
A(ndat-1,ndat-2)=-4*lam;
A(ndat-1,ndat-3)=lam;
A(ndat,ndat)=1+lam;
A(ndat,ndat-1)=-2*lam;
A(ndat,ndat-2)=lam;
B=eye(size(A))-inv(A);