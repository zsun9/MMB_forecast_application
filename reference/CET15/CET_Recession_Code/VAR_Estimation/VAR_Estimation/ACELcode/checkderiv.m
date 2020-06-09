
alphas          =   [alpha_0 alpha_1 alpha_2];
betas           =   [beta_0 beta_1];

vecder  =   [kron(ones(1,3),stst),ones(1,16)];
vecder(51)  =   mu_z;
vecder(54)  =   mu_ups;
vecder(59)  =   mu_z;
vecder(62)  =   mu_ups;

deriv_n =   tsemat(@foncs,[params_mat,steady],vecder)';
deriv_n =   deriv_n.*kron(ones(16,1),vecder);

for i=[1,3:4,6:9,11:12,14:16]
    [ii,jj,ss]    =   find([alphas(i,:),betas(i,:)]);
    chk_a(i,:)  =   [alphas(i,:),betas(i,:)]/alphas(i,jj(1));
    [ii,jj,ss]    =   find(deriv_n(i,:));
    chk_n(i,:)  =   deriv_n(i,:)/deriv_n(i,jj(1));
end
chk_a(2,:)  =   [alphas(2,:),betas(2,:)]/alphas(2,8);
chk_n(2,:)  =   deriv_n(2,:)/deriv_n(2,8);
if max(max(abs(chk_n-chk_a)))>1e-8,
    error('Numerical and analytical derivatives do not coincide')
end