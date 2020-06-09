function    x   =   imap(pars)

load restr

x(inzeroone)     =   log((1-pars(inzeroone))./pars(inzeroone));
x(inunitcircle)  =   log((1-pars(inunitcircle))./(1+pars(inunitcircle)));
x(nonneg)        =   log(pars(nonneg));
x(morethanoneohone)   =   log(pars(morethanoneohone)-1.01);
x(unrestr)       =   pars(unrestr);
