% Need package: Temporal disaggregation

clear all; clc;

%Private Business Sector
%Y = readmatrix('mfptable.xlsx','Sheet','Data','Range','F45:AK45')';
%Private Non-Farm Business Sector
Y = readmatrix('mfptable.xlsx','Sheet','Data','Range','F106:AK106')';

% Type of aggregation
ta = 3;   
% Minimizing the volatility of d-differenced series
d = 1;
% Frequency conversion 
sc = 4;    
% ---------------------------------------------
% Calling the function: output is loaded in a structure called res
res = bfl(Y,ta,d,sc);
% ---------------------------------------------
% Outputs

TFP_qua = res.y;
plot(TFP_qua);

%Private Business Sector
%xlswrite('mfptable.xlsx',TFP_qua,'__QuaterlyTFP', 'B2')
%Private Non-Farm Business Sector
xlswrite('mfptable.xlsx',TFP_qua,'__QuaterlyTFP', 'C2')

