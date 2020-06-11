function [Sy,Sy1,Sy2,Sy9,Syy,dSy1,dSy2,dSy9,dSyy] = specthelp(DD,C,I1,I2,I9,II)
Sy=DD*C*C'*ctranspose(DD);
Sy1=DD*C*I1*C'*ctranspose(DD);
Sy2=DD*C*I2*C'*ctranspose(DD);
Sy9=DD*C*I9*C'*ctranspose(DD);
Syy=DD*C*II*C'*ctranspose(DD);

dSy1=real(diag(Sy1))./real(diag(Sy));
dSy2=real(diag(Sy2))./real(diag(Sy));
dSy9=real(diag(Sy9))./real(diag(Sy));
dSyy=real(diag(Syy))./real(diag(Sy));