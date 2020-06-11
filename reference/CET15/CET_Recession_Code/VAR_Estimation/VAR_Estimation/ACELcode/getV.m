function [V] = getV(erzout)
%compute the variance covariance matrix, V, of the fitted disturbances:
TT=size(erzout,1);
V=erzout(1,:)'*erzout(1,:);
for ii = 2:TT
    V=V+erzout(ii,:)'*erzout(ii,:);
end
V=V/TT;
