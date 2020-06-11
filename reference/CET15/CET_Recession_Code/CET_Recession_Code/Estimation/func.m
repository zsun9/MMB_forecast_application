function [gg,rrho1,rrho2,rt]=func(x,rho1,rho2)

th1=x(1);
th2=x(2);
c=[1 -th1 -th2 ];
rt=roots(c);
d=1+th1^2+th2^2;
rrho1=-(1-th2)*th1/d;
rrho2=-th2/d;
ff=[ rho1-rrho1 rho2-rrho2];
%gg=max(abs(ff));
gg=sum(ff.^2);