  function X=disclyap_fast(G,V,ch)
% =============================================================== 
% function X=disclyap_fast(G,V,ch)
% 
% Solve the discrete Lyapunov Equation 
% X=G*X*G'+V 
% Using the Doubling Algorithm 
%
% If ch==1 is defined then the code will check if the resulting X 
% is positive definite and generate an error message if it is not 
% 
% Joe Pearlman and Alejandro Justiniano 
% 3/5/2005 
% Modified 2/28/2007
% =================================================================
P0=V;A0=G; 
matd=1; 
while matd > 1e-16; 
    P1=P0+A0*P0*A0';A1=A0*A0;  
    matd=max(max(abs(P1-P0))); 
    P0=P1;A0=A1; 
end 
X=(P0+P0')/2; 
if nargin==2 || isempty(ch)==1 || ch==0
    return; 
end
[C,p]=chol(X);if p~=0;error('X is not positive definite');end; 