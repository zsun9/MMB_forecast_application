function [L11,L21,L31,F11,F22,F23]=get_kalman_matrices_ma(rhoP,rhoT,sigP,sigT)

%calculates matrices for kalman filter equations
%matrices
F=[rhoP, 0, 0; 0, rhoT, rhoT-1; 0,0,0]; %Transition matrix of state-space system
Q=[sigP, 0,0;0,0,0; 0, sigT,0]; %Standard deviations of structural shocks in state-space
Hprime=[1, 1,1];        %Measurement equation matrix

%numerical solution for kalman gain matrix (iteration on Ricatti
%equation)

Pold=rand(3,3); %initialize
diffs=1000;
while diffs>1e-12,
    Knum=F*Pold*Hprime'*inv(Hprime*Pold*Hprime'); %Kalman gain matrix
    Pnum=(F-Knum*Hprime)*Pold*(F'-Hprime'*Knum')+Q*Q'; %MSE matrix
    diffs=max(max(abs(Pold-Pnum)));
    Pold=Pnum;
end
Lnum=Pnum*Hprime'*inv(Hprime*Pnum*Hprime');

K=Knum;
L=Lnum;



%iterate on Ricatti equation to get P and L matrices
Pold=rand(3,3); %initialize
diffs=1000;
while diffs>1e-12,
    K=F*Pold*Hprime'*inv(Hprime*Pold*Hprime'); %Kalman gain matrix
    P=(F-K*Hprime)*Pold*(F'-Hprime'*K')+Q*Q'; %MSE matrix
    diffs=max(max(abs(Pold-P)));
    Pold=P;
end
L=P*Hprime'*inv(Hprime*P*Hprime');

%matrix elements for equations below
L11=L(1);
L21=L(2);
L31=L(3);
F11=F(1,1);
F22=F(2,2);
F23=F(2,3);
