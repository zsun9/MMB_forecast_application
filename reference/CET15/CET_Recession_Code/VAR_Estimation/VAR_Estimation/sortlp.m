function outimpz = sortlp(impz);
global cut_jobdata

%SORTLP does linear transformations to the data in the var
%to get them into the more interesting form we want to
%see in impulse response functions.

%variables in the var, i.e., in impz

% vardata=[data_REL_PINV_GROWTH(1) data_LAB_PROD_GROWTH(2) data_INFL(3) data_UNEMP(4) data_CAPUTIL(5) ...
%         data_HOURS_CAPITA(6) data_LAB_PROD_WAGE(7) data_CONS_GDP(8) data_INV_GDP(9)  ...
%         data_VACANCIES(10) data_HOURS_LABFORCE(11) data_SEPARATIONS(12) data_FINDINGS(13)  data_FEDFUNDS(14)];
 
impznew(:,1)  = cumsum(impz(:,1));%level, price of investment goods
impznew(:,2)  = cumsum(impz(:,2))+impz(:,6); %Output=sum of log productivity plus log hours
impznew(:,3)  =  impz(:,3); %Inflation
impznew(:,4:5) = impz(:,5:6); %capacity utilization, log hours
impznew(:,6)  = -1*impz(:,7)+impznew(:,2)-impznew(:,5); %real wage
impznew(:,7)  = impz(:,8) + impznew(:,2); %consumption
impznew(:,8)  = impz(:,9) + impznew(:,2)-impznew(:,1); % real investment 
impznew(:,9)  = impz(:,end); %fed funds
impznew(:,10) = impz(:,4); %unemployment
impznew(:,11) = impz(:,10); %vacancies
impznew(:,12) = -1*impz(:,11)+impz(:,6); %labor force
%impznew(:,13) = impz(:,14)+impznew(:,2);

%titz contains the names of the output data in outimp....

if cut_jobdata ~= 1
    impznew(:,13:14) = impz(:,12:13);%separation rate, finding rate
    outimpz  = impznew(:,[2 3 9 4 5 6 7 8 1 10 11 12 13 14]);
    titz = char('Log, output','Inflation','Fed Funds','Capacity Util','log hours','Log, real wage','Log, consumption','Log, investment','Price of Inv.','Unemployment','Vacancies','Labor Force','Separation Rate','Finding Rate');    
else
    outimpz  = impznew(:,[2 3 9 4 5 6 7 8 1 10 11 12]);
    titz = char('Log, output','Inflation','Fed Funds','Capacity Util','log hours','Log, real wage','Log, consumption','Log, investment','Price of Inv.','Unemployment','Vacancies','Labor Force');
end
  

 
 