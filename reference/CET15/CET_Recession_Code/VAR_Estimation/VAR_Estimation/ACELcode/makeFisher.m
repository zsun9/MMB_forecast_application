function [aggspend,fisherPriceIndex] = makeFisher(price,spend);
%Makes Torn price index using price and spending matrices of identical
%dimensions

%Retruns row vector TornPriceIndex with same number of columns as price and
%spend.  NaNs 

if min((size(price)==size(spend))') == 0
   error('price and spend must be the same size') 
end

alldataexistindex = find(sum(isnan(price)+isnan(spend))==0);
alldataexistStart = alldataexistindex(1);
alldataexistEnd = alldataexistindex(end);

if alldataexistEnd - alldataexistStart < 1
   error('Need at least two adjacent time periods with all data'); 
end

priceT1 = price(:,alldataexistStart+1:alldataexistEnd);
priceT0 = price(:,alldataexistStart:alldataexistEnd-1);
spendT1 = spend(:,alldataexistStart+1:alldataexistEnd);
spendT0 = spend(:,alldataexistStart:alldataexistEnd-1);
sumspendT1 = repmat(sum(spendT1),size(spendT1,1),1);
sumspendT0 = repmat(sum(spendT0),size(spendT0,1),1);
spendshareT1 = spendT1./sumspendT1;
spendshareT0 = spendT0./sumspendT0;
rquantityT1 = spendT1./priceT1;
rquantityT0 = spendT0./priceT0;

    subLaSpayersNum = sum(priceT1.*rquantityT0);
    subLaSpayersDenom = sum(priceT0.*rquantityT0);
    subPaascheNum = sum(priceT1.*rquantityT1);
    subPaascheDenom = sum(priceT0.*rquantityT1);
    subcompFisherInflChain = ((subLaSpayersNum./subLaSpayersDenom).*(subPaascheNum./subPaascheDenom)).^.5;

fisherPriceIndex = [NaN(1,alldataexistStart-1) 1 cumprod(subcompFisherInflChain) NaN(1,size(price,2)-alldataexistEnd)];
aggspend = sum(spend);    
if ~(size(price,2)==size(fisherPriceIndex,2))
   error('something bad happened') 
end
end
