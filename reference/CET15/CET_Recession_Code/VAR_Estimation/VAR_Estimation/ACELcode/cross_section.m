
%et - demand shock
%ep - supply shock

theta=lambda_f/(lambda_f-1);
siget=.0;
sigep=.01;
et(1)=randn*siget;
ep(1)=randn*sigep;

ki(1)=0;
ki(2)=0;

T=1000;
for ii = 2:T
    uet=rand;
    if uet > 1-ksiet;
        et(ii)=randn*siget;
    else
        et(ii)=et(ii-1);
    end
    uep=rand;
    if uep > 1-ksiep;
        ep(ii)=randn*sigep;
    else
        ep(ii)=ep(ii-1);
    end
    pi(ii)=-psi0*ki(ii)-psi1*ki(ii-1)+psi2*et(ii)+psi3*ep(ii);
    ki(ii+1)=kap1*ki(ii)+kap2*ki(ii-1)+kap3*pi(ii)+kap4*et(ii)+kap5*ep(ii);
    yi(ii)=(theta-1)*et(ii)-theta*pi(ii);
end

subplot(221)
hist(yi)
title('output')
subplot(222)
hist(pi)
title('prices')
tt=200:250;
subplot(223)
plot(tt,pi(tt),tt,yi(tt),'*',tt,yi(tt))
legend('prices','output')
subplot(224)
plot(tt,yi(tt))
title('output')