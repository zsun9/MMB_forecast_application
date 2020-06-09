function [Il,Iu] = shockanalysis(is,erzout,nl,nlags,firstdate)
shk=erzout(:,is);
TT=size(erzout,1);
sa=zeros(TT,1);
ma=zeros(TT,1);
for ii = nl+1:TT-nl
    for jj = 1:2*nl+1
        a(jj)=shk(ii-nl-1+jj);
    end
    sa(ii)=std(a);
    ma(ii)=mean(a);
end

time(1)=firstdate+(nlags-4)*.25;
for ii = 2:TT
    time(ii)=time(ii-1)+.25;
end
tt=nl+1:TT-nl;
%periods 76 to 91 (inclusive) are the high variance periods
Il=find(time==1979.0);
Iu=find(time==1985.75);
subplot(223)
plot(time(tt),100*sa(tt),time(Il),100*sa(Il),'*',time(Iu),100*sa(Iu),'*')
st=['standard deviation, based on centered set of ',num2str(2*nl+1),' observations'];
title(st)
axis tight
subplot(224)
plot(time(tt),100*ma(tt),time(Il),100*ma(Il),'*',time(Iu),100*ma(Iu),'*')
st=['mean, ',num2str(2*nl+1),' quarter centered moving average'];
title(st)
axis tight
subplot(211)
plot(time,100*erzout(:,is),time(Il),100*erzout(Il,is),'*',time(Iu),100*erzout(Iu,is),'*')
title('actual shocks')
axis tight
if is == 9;hout=suptitle(['Analysis of Policy Shock']);end