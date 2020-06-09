function [B,rho] = findB(P,A,beta_0,beta_1,alpha_0,alpha_1,alpha_2,rho_M,theta_M,tau,chk)
[n,n1]=size(P);
[m,n2]=size(beta_0);

if n1 ~= n2
    error('fatal (findB) beta_0 has wrong right dimension')
end

if n ~= n1
    error('fatal (findB) non-square P matrix')
end

nn=length(tau);

if nn > 0
    rho=zeros(n+2,n+2);
    rho([1:n],[1:n])=P;
    rho(n+1,1)=1;
    rho(n+2,2)=1;
    
    betat_0=[beta_0 zeros(m,2)];
    betat_1=[beta_1 zeros(m,2)];
    nnx=2;
else
    rho=P;
    betat_0=beta_0;
    betat_1=beta_1;
    nnx=0;
end

d=reshape(rho'*betat_0'+betat_1',(n+nnx)*m,1);
q=kron(alpha_0,rho')+kron(alpha_1,eye(n+nnx))+kron(alpha_0*A,eye(n+nnx));

if nn > 0
    R=zeros(m*(n+2)-nn*2,m*(n+nnx));
    i1=0;
    j1=0;
    for ii = 1:16
        RR([1:n+nnx],[1:n+nnx])=eye(n+nnx);
        if max([(tau==ii)]) == 1
            RR(9,1)=rho_M;
            RR(10,2)=theta_M;
            RR=RR([3:n+nnx],:);
        end
        [I1,J1]=size(RR);
        R(i1+[1:I1],j1+[1:J1])=RR;
        i1=i1+I1;
        j1=j1+J1;
    end
    
    dd=R*d;
    qq=R*q;
    ix=-1;
    for ii = 1:length(tau)
        ix=ix+2;
        ttau(ix)=(tau(ii)-1)*(n+nnx)+1;
        ttau(ix+1)=(tau(ii)-1)*(n+nnx)+2;
    end
    
    ix=0;
    for ii = 1:m*(n+nnx)
        if max([(ttau==ii)]) == 0
            ix=ix+1;
            qt(:,ix)=qq(:,ii);
        end
    end
    
else
    qt=q;
    dd=d;
end
    
[m1,m2]=size(qt);
if m1 ~= m2
    error('fatal (findB) qt not square')
end

if rank(qt) ~= m1
    error('fatal (findB) qt not full rank')
end


delt=-qt\dd;
if nn > 0
    ix=0;
    for ii = 1:m*(n+nnx)
        if max([(ttau==ii)]) == 1
            del(ii)=0;
        else
            ix=ix+1;
            del(ii)=delt(ix);
        end
    end
else
    del=delt;
end

B=reshape(del,n+nnx,m)';


if chk == 1
    
    tttau=ones(n,m);
    if nn > 0
        for ii = 1:m
            if max((tau==ii))
                tttau(1,ii)=0;
                tttau(2,ii)=0;
            end
        end
    end
    alphas          =   [alpha_0 alpha_1 alpha_2];
    betas           =   [beta_0 beta_1];
    [BB,Px]         =   solveb(A,alphas,betas,P,tttau);
    if max(max(abs(BB(:,[1:n+nnx])-B))) > .1e-10
        error('fatal (findB) solution for B not correct')
    end
    
end



