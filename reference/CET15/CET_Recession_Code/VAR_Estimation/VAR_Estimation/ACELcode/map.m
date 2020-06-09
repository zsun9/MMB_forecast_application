function pars   =   map(x)

load restr

pars(inzeroone)     =   1./(1+exp(x(inzeroone)));
pars(inunitcircle)  =   (1-exp(x(inunitcircle)))./(1+exp(x(inunitcircle)));
pars(nonneg)        =   exp(x(nonneg));
pars(morethanoneohone)   =   1.01+exp(x(morethanoneohone));
pars(unrestr)       =   x(unrestr);

