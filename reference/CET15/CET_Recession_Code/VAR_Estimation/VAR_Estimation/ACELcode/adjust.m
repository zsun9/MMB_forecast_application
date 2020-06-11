%These are the input parameters associated with alternative specifications
%of the benchmark model
%Remember that to estimate versions of the model that involve different
%specifications of the VAR (perhaps a different time period, or a different
%data set), you have to re-estimate the VAR and recompute the distribution
%of the impulse response functions. Look at loadreducedform.m for more information.

%these are the meanings of the various parameters

% period      = 1;     % if 1, sample 1959:Q2-2001:Q4; 2, sample 1959:Q2-1979:Q4; 3, sample 1980:Q1-2001:Q4; 4, sample 1982:Q1-2001:Q4
% money       = 1;     % if 1, use MZM as measure of money, otherwise use M2
% pinvestment = 1;     % if 1 use investment deflator for pi, otherwise use price of equipment
% FR          = 0;     % if 0, use benchmark data, with P16 for population; if 1, use Francis and Ramey's measure of population instead
%                      %      of P16; if 2, detrend the measure of per capita hours that results from using the FR population measure
% sm          = 0;     % if 1, replace whatever measure of population being used by its HP trend
% product     = 0;     % if 0, use labor productivity in benchmark dataset, if 1 use non-farm business labor productivity
%                      % if 2, use business labor productivity (data from Francis and Ramey)
% hours       = 0;     % if 0, use benchmark dataset (ie., use non-farm business hours); 1 use benchmark data set with business hours

if product == 2 & criterion == 0 & FR == 0 & sm == 0 & period == 1 & money == 1 & pinvestment == 1 & hours == 0

    %the new version of the model...
    % gam = 0.044, ksip under firm-specific capital model = 0.78, the associated duration is 4.47
    %         ksip under homogeneous capital model = 0.81, the associated duration is 5.35 
    %Criterion value  1121.9162
    %Following are the parameters that were estimated 
%Following are the parameters that were estimated 
rho_M       = 0.0659 ;
rho_xz      = 0.6273 ;
c_z         = 0.2540 ;
rho_muz     = 0.0720 ;
rho_xups    = 0.8511 ;
c_ups       = 0.1271 ;
rho_muups   = 0.0723 ;
sig_M       = 0.4135 ;
sig_muz     = 0.3327 ;
sig_muups   = 0.3111 ;
epsilon     = 1.0691 ;
kappa       = 3.5448 ;
xi_w        = 0.6351 ;
b           = 0.7452 ;
lambda_f    = 1.4421 ;
sigma_a     = 1.0102 ;
cp_z        = 0.1979 ;
cp_ups      = 0.1438 ;
gam         = 0.0443 ;
%Following are the parameters held fixed in the estimation 

psi_L       = 1.0000 ;
bet         = 0.9926 ;
mu_ups      = 1.0042 ;
mu_z        = 1.0001 ;
delta       = 0.0250 ;
alph        = 0.3600 ;
nu          = 1.0000 ;
psi_L       = 1.0000 ;
x           = 1.0170 ;
V           = 0.4500 ;
sigma_L     = 1.0000 ;
lambda_w    = 1.0500 ;
squig       = 1.0000 ;
vartheta    = 0.0000 ;
eta         = 0.0360 ;
theta_M     = 0.0000 ;
theta_muz   = 0.0000 ;
theta_muups = 0.0000 ;


yy=[  0.06587594466111   0.12031500743927
   0.62730802097746   0.35301541274478
   0.25402118262756   0.22423016366115
   0.07196848952559   0.37079480878780
   0.85107066559799   0.14475504192877
   0.12707233871207   0.28592843965939
   0.07230625339831   0.24822791252255
   0.41351224383870   0.07149152992055
   0.33272826034328   0.14611042111695
   0.31112960464267   0.04387797733827
   1.06909916196343   0.21485027675366
   3.54478149906347   2.14803470496537
   0.63513864247843   0.11122539136501
   0.74524688482267   0.04614853504938
   1.44210218984466   0.21173624555050
   1.01022518789772   1.75252005397838
   0.19786506042068   0.27429888813943
   0.14380553696474   0.28252990560731
   0.04432126566583   0.03632777924922];

xx=[0.06587594466111
   0.62730802097746
   0.25402118262756
   0.07196848952559
   0.85107066559799
   0.12707233871207
   0.07230625339831
   0.41351224383870
   0.33272826034328
   0.31112960464267
   1.06909916196343
   3.54478149906347
   0.63513864247843
   0.74524688482267
   1.44210218984466
   1.01022518789772
   0.19786506042068
   0.14380553696474
   0.04432126566583];

end

if product == 0 & criterion == 0 & FR == 0 & sm == 0 & period == 1 & money == 1 & pinvestment == 1 & hours == 1
    %V=1.43
    %parameters for the model estimated with business hours.
    %Verify that lambdaf is constrained to equal 1.01

    %     Parameter estimates and standard errors
    %
    %    0.23995370013550   0.13908406463557
    %    0.37261488175868   0.19784714360448
    %    3.38404586166813   1.85515916296402
    %    0.91620564867460   0.07208971331277
    %    0.67232614506173   0.18018393779636
    %    0.37171185069107   0.25386458259927
    %    0.19775843080495   0.23011702242945
    %    0.25866865420452   0.05308472262567
    %    0.06492641633430   0.02608831653955
    %    0.31426989708261   0.04453944805858
    %    1.07909285660833   0.24617015313616
    %    2.18987327164200   1.33302800064987
    %    0.71676619656296   0.15441043864339
    %    0.65161492509360   0.05504016313406
    %    1.93799273807096   2.44328723759001
    %    1.16373793961094   0.79222581959026
    %    0.26095510446404   0.17011345945175
    %    0.03405329200901   0.01755891146019
    % Criterion value  1017.4965

    xx=[0.23995370013550
        0.37261488175868
        3.38404586166813
        0.91620564867460
        0.67232614506173
        0.37171185069107
        0.19775843080495
        0.25866865420452
        0.06492641633430
        0.31426989708261
        1.07909285660833
        2.18987327164200
        0.71676619656296
        0.65161492509360
        1.93799273807096
        1.16373793961094
        0.26095510446404
        0.03405329200901];
    
    %verify that lambda_f is constrained
    %V = .45
    %gam = 0.040, ksip under firm-specific capital model = 0.34, the associated duration is 1.51
    %              ksip under homogeneous capital model = 0.82, the associated duration is 5.60
    %Criterion value  1063.3831
    %Following are the parameters that were estimated
    rho_M       = -0.0374 ;
    rho_xz      = 0.3430 ;
    c_z         = 2.9970 ;
    rho_muz     = 0.9022 ;
    rho_xups    = 0.8238 ;
    c_ups       = 0.2456 ;
    rho_muups   = 0.2406 ;
    sig_M       = 0.3309 ;
    sig_muz     = 0.0677 ;
    sig_muups   = 0.3026 ;
    epsilon     = 0.8081 ;
    kappa       = 3.2811 ;
    xi_w        = 0.7223 ;
    b           = 0.7064 ;
    sigma_a     = 1.9946 ;
    cp_z        = 1.3273 ;
    cp_ups      = 0.1346 ;
    gam         = 0.0402 ;
    %Following are the parameters held fixed in the estimation

    psi_L       = 1.0000 ;
    bet         = 0.9926 ;
    mu_ups      = 1.0042 ;
    mu_z        = 1.0001 ;
    delta       = 0.0250 ;
    alph        = 0.3600 ;
    nu          = 1.0000 ;
    psi_L       = 1.0000 ;
    x           = 1.0170 ;
    V           = 0.4500 ;
    sigma_L     = 1.0000 ;
    lambda_f    = 1.0100 ;
    lambda_w    = 1.0500 ;
    squig       = 1.0000 ;
    vartheta    = 0.0000 ;
    eta         = 0.0360 ;
    theta_M     = 0.0000 ;
    theta_muz   = 0.0000 ;
    theta_muups = 0.0000 ;

    yy=[ -0.03736630515711   0.10749144999496
        0.34300600408472   0.25469650835007
        2.99704971631039   1.97022874393011
        0.90219865156529   0.11236614923966
        0.82381809344731   0.11873379421271
        0.24558811702211   0.20697219736568
        0.24060981802975   0.22531678278447
        0.33091907327229   0.08406792531955
        0.06772101182634   0.03705581017115
        0.30259240782104   0.04358745995406
        0.80812565826818   0.20769337872715
        3.28114263919337   1.66327616398667
        0.72227203212408   0.12880617578026
        0.70640779788716   0.04455752243089
        1.99461018063184   2.30041793295459
        1.32734114719027   0.97830328572768
        0.13458518891379   0.21161893146496
        0.04015847851684   0.02035093181384];

    xx=[ -0.03736630515711
        0.34300600408472
        2.99704971631039
        0.90219865156529
        0.82381809344731
        0.24558811702211
        0.24060981802975
        0.33091907327229
        0.06772101182634
        0.30259240782104
        0.80812565826818
        3.28114263919337
        0.72227203212408
        0.70640779788716
        1.99461018063184
        1.32734114719027
        0.13458518891379
        0.04015847851684];
end

%this is the case where monetary policy shocks alone are used:
if product == 0 & criterion == 1 & FR == 0 & sm == 0 & period == 1 & money == 1 & pinvestment == 1 & hours == 0

%Criterion value  474.4746
%parameter values and names
%gam = 0.106, ksip under firm-specific capital model = 0.72, the associated duration is 3.59
%             ksip under homogeneous capital model = 0.73, the associated duration is 3.64 

%Following are the parameters that were estimated 
rho_M       = -0.0373 ;
sig_M       = 0.3333 ;
epsilon     = 0.8156 ;
kappa       = 3.6320 ;
xi_w        = 0.6223 ;
b           = 0.7276 ;
lambda_f    = 1.0801 ;
sigma_a     = 0.0067 ;
gam         = 0.1062 ;
%Following are the parameters held fixed in the estimation 

rho_xz      = 0.3276 ;
c_z         = 2.9973 ;
rho_muz     = 0.9041 ;
rho_xups    = 0.8217 ;
c_ups       = 0.2461 ;
rho_muups   = 0.2414 ;
sig_muz     = 0.0673 ;
sig_muups   = 0.3027 ;
psi_L       = 1.0000 ;
bet         = 0.9926 ;
mu_ups      = 1.0042 ;
mu_z        = 1.0001 ;
delta       = 0.0250 ;
alph        = 0.3600 ;
nu          = 1.0000 ;
psi_L       = 1.0000 ;
x           = 1.0170 ;
V           = 0.4500 ;
sigma_L     = 1.0000 ;
lambda_w    = 1.0500 ;
squig       = 1.0000 ;
vartheta    = 0.0000 ;
eta         = 0.0360 ;
theta_M     = 0.0000 ;
cp_z        = 1.4211 ;
theta_muz   = 0.0000 ;
cp_ups      = 0.1342 ;
theta_muups = 0.0000 ;

 yy=[-0.03730063232760   0.09490477184680
   0.33326251606135   0.07741459445132
   0.81559308393556   0.18765712624835
   3.63199308383916   1.72511470234436
   0.62226039498400   0.07197855485238
   0.72759458811570   0.04954037976027
   1.08006387856806   0.09900030336897
   0.00666313201970   0.00861831443357
   0.10617166908283   0.06087316929911];


xx=[-0.03730063232760
   0.33326251606135
   0.81559308393556
   3.63199308383916
   0.62226039498400
   0.72759458811570
   1.08006387856806
   0.00666313201970
   0.10617166908283];
end
%this is the case where there are only embodied technology shocks
if product == 0 & criterion == 2 & FR == 0 & sm == 0 & period == 1 & money == 1 & pinvestment == 1 & hours == 0
%Criterion value  152.3249
%gam = 0.033, ksip under firm-specific capital model = 0.31, the associated duration is 1.46
%      ksip under homogeneous capital model = 0.84, the associated duration is 6.10 
%Following are the parameters that were estimated 
rho_xups    = 0.9311 ;
c_ups       = 0.3937 ;
rho_muups   = 0.3022 ;
sig_muups   = 0.3018 ;
epsilon     = 1.2370 ;
kappa       = 0.8966 ;
xi_w        = 0.7042 ;
b           = 0.2332 ;
sigma_a     = 5.8392 ;
cp_ups      = -0.2364 ;
gam         = 0.0333 ;
%Following are the parameters held fixed in the estimation 

rho_M       = -0.0335 ;
rho_xz      = 0.3276 ;
c_z         = 2.9973 ;
rho_muz     = 0.9041 ;
sig_M       = 0.3285 ;
sig_muz     = 0.0673 ;
psi_L       = 1.0000 ;
bet         = 0.9926 ;
mu_ups      = 1.0042 ;
mu_z        = 1.0001 ;
delta       = 0.0250 ;
alph        = 0.3600 ;
nu          = 1.0000 ;
psi_L       = 1.0000 ;
x           = 1.0170 ;
V           = 0.4500 ;
sigma_L     = 1.0000 ;
lambda_f    = 1.0100 ;
lambda_w    = 1.0500 ;
squig       = 1.0000 ;
vartheta    = 0.0000 ;
eta         = 0.0360 ;
theta_M     = 0.0000 ;
cp_z        = 1.4211 ;
theta_muz   = 0.0000 ;
theta_muups = 0.0000 ;

yy=[ 0.93105994552150   0.06393661994368
   0.39365250050920   0.23742012264062
   0.30217670597700   0.18619567519900
   0.30178598267515   0.04782910297756
   1.23701695050706   0.70932964251997
   0.89663007177748   0.72985795198544
   0.70422489536284   0.36259804611791
   0.23315996215435   0.29324580213770
   5.83917284850409   8.02855667465423
  -0.23638661300399   0.23318839564207
   0.03332975705440   0.01983918251891];

xx=[  0.93105994552150
   0.39365250050920
   0.30217670597700
   0.30178598267515
   1.23701695050706
   0.89663007177748
   0.70422489536284
   0.23315996215435
   5.83917284850409
  -0.23638661300399
   0.03332975705440];
end
%this is the case where there are only neutral technology shocks
%at the moment, there are no standard errors for this model
if product == 0 & criterion == 3 & FR == 0 & sm == 0 & period == 1 & money == 1 & pinvestment == 1 & hours == 0

% Current function value: 163.121203 
%gam = 9535957.437, ksip under firm-specific capital model = 0.00, the associated duration is 1.00
%                   ksip under homogeneous capital model = 0.00, the associated duration is 1.00 
%Following are the parameters that were estimated 
rho_xz      = 1.0000 ;
c_z         = 0.8780 ;
rho_muz     = -0.1980 ;
sig_muz     = 0.2703 ;
epsilon     = 0.9727 ;
kappa       = 0.9995 ;
xi_w        = 0.9280 ;
b           = 0.0539 ;
lambda_f    = 2.0501 ;
sigma_a     = 22862004519062076000000000000000000000000000000.0000 ;
cp_z        = -1.0024 ;
gam         = 9535957.4369 ;
%Following are the parameters held fixed in the estimation 

rho_M       = -0.0335 ;
rho_xups    = 0.8217 ;
c_ups       = 0.2461 ;
rho_muups   = 0.2414 ;
sig_M       = 0.3285 ;
sig_muups   = 0.3027 ;
psi_L       = 1.0000 ;
bet         = 0.9926 ;
mu_ups      = 1.0042 ;
mu_z        = 1.0001 ;
delta       = 0.0250 ;
alph        = 0.3600 ;
nu          = 1.0000 ;
psi_L       = 1.0000 ;
x           = 1.0170 ;
V           = 0.4500 ;
sigma_L     = 1.0000 ;
lambda_w    = 1.0500 ;
squig       = 1.0000 ;
vartheta    = 0.0000 ;
eta         = 0.0360 ;
theta_M     = 0.0000 ;
theta_muz   = 0.0000 ;
cp_ups      = 0.1342 ;
theta_muups = 0.0000 ;

xx=[0.99995254852464
   0.87800573627435
  -0.19800676076198
   0.27028351744076
   0.97268116572189
   0.99951601571562
   0.92804240728938
   0.05389536245164
   2.05011143043697
    2.286200451906208e+046
  -1.00237829162690
  9.535957436871843e+006];

end

%The following settings let you run the benchmark model with some perturbation on the parameters
lamb=0;%high value of lambdaf
if lamb == 1
    lambdafhigh
end

capu=0;%variable capital utilization
if capu == 1
    vcapitalutilization
end


diary estimresults.txt;
disp('Starting values in the estimation');
xx
diary off;
