function [s1,s2,s9,ss] = getvar(kk,a,b,N,Sy,Sy1,Sy2,Sy9,Syy)
aa=floor(N/a);
if aa > kk(end)
    error('fatal (getvar) trying to use too high a frequency')
end
bb=floor(N/b);
tt=bb:aa;
vary=diag(Sy(:,:,tt(1)));
vary1=diag(Sy1(:,:,tt(1)));
vary2=diag(Sy2(:,:,tt(1)));
vary9=diag(Sy9(:,:,tt(1)));
varyy=diag(Syy(:,:,tt(1)));

for ii = 2:length(tt)
    vary=vary+diag(Sy(:,:,tt(ii)));
    vary1=vary1+diag(Sy1(:,:,tt(ii)));
    vary2=vary2+diag(Sy2(:,:,tt(ii)));
    vary9=vary9+diag(Sy9(:,:,tt(ii)));
    varyy=varyy+diag(Syy(:,:,tt(ii)));
end

s1=vary1./vary;
s2=vary2./vary;
s9=vary9./vary;
ss=varyy./vary;