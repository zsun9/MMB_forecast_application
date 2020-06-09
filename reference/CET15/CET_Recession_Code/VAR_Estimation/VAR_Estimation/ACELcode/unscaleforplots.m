function unscale    =   unscaleforplots(zz,s,alpha,R,pie)

capT    =   size(zz,2)-1;
% capTp1  =   capT+1;

mu_zt   =   s(3,1:capT);
mu_upst =   s(6,1:capT);
mu_zstt =   mu_zt+(alpha/(1-alpha))*mu_upst;
zt      =   cumsum(mu_zt);
upst    =   cumsum(mu_upst);
Zstart  =   alpha/(1-alpha)*upst+zt;

totmgrowth =   4*zz(6,1:capT);
output  =   zz(12,1:capT)+Zstart;
cons    =   zz(1,1:capT)+Zstart;
hours   =   zz(9,1:capT);
capa    =   zz(16,1:capT);
fedf    =   4*R*zz(13,1:capT);
infl    =   4*pie*zz(5,1:capT);
% vel     =   output-(zz(11,2:capTp1)+Zstart);
vel     =   output-(zz(11,1:capT)+Zstart);
rwage   =   zz(2,1:capT)+Zstart;
invest  =   zz(8,1:capT)+upst+Zstart;
pinv    =   -upst;
mgrowth =   [zz(11,1) diff(zz(11,1:capT))]+zz(5,1:capT)+mu_zstt;
mgrowth =   4*mgrowth;

unscale =   [output,mgrowth,infl,fedf,capa,hours,rwage,cons,invest,vel,pinv,totmgrowth];
