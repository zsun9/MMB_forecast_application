function [z,s] = simulate(A,B,P,e)

%function [z,s] = simulate(A,B,P,e)
%
%this simulates the response of the following system 
% z(t) = A*z(t-1) + B*s(t),
% s(t) = P*s(t-1) + e(t).
%to a given sequence, 
%e(1),...,e(T)
% 
%the simulations are done subject to z(0)=s(0)=0,
%this program is written inefficiently, with a do-loop

[m,T] = size(e);
[mA,nA] = size(A);
[mB,nB] = size(B);
[mP,nP] = size(P);

if mA ~= nA
   error('fatal (simulate) input matrix A not square')
end

if mB ~= mA
   error('fatal (simulate) left dimension of input matrix B wrong')
end

if nB ~= m
   error('fatal (simulate) mismatch between right dimension of B and e')
end

if mP ~= nP
   error('fatal (simulate) input matrix P not square')
end

if mP ~= m
   error('fatal (simulate) number of input shocks wrong')
end


s(:,1) = e(:,1);
z(:,1) = B*s(:,1);
for ii = 2:T
   s(:,ii)=P*s(:,ii-1)+e(:,ii);
   z(:,ii)=A*z(:,ii-1)+B*s(:,ii);
end