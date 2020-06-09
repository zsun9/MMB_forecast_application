function [IRFFF,IRFu,IRFz] = setcrit(IRFFF,IRFu,IRFz,criterion)

if criterion == 1
    IRFu=zeros(size(IRFu));
    IRFz=zeros(size(IRFz));
elseif criterion == 2
    IRFFF=zeros(size(IRFFF));
    IRFz=zeros(size(IRFz));
elseif criterion == 3
    IRFFF=zeros(size(IRFFF));
    IRFu=zeros(size(IRFu));
end