    function outimpz = sortlp(impz);
%SORTLP transforms a set of impulse responses into a different set. 
%For example can translate the response by the growth rate of productivity into the 
%response by the level of productivity
 
%titz =  char('dlp','dp','cap','avg h','prod-wage','c-y','i-y','ffund','velocity') 

impznew(:,1) = cumsum(impz(:,1));
impznew(:,2) = cumsum(impz(:,2))+impz(:,5); %Output
impznew(:,3) =  impz(:,3); %Inflation
impznew(:,4:5) = impz(:,4:5); %capacity and average hours
impznew(:,6) = -1*impz(:,6)+impznew(:,2)-impznew(:,5); %wages
impznew(:,7) = impz(:,7) + impznew(:,2); %consumption
impznew(:,8) = impz(:,8) + impznew(:,2)-impznew(:,1); %investment
impznew(:,9) = impz(:,9); %fed funds
impznew(:,10) = (impz(:,10)); %velocity
impznew(:,11) = impznew(:,2)+cumsum(impznew(:,3)) -  impz(:,end); %M 
impznew(:,11) = 4*[impznew(1,11); diff(impznew(:,11))]; %dm 
impznew(:,3) = 4*impz(:,3); %Inflation

outimpz  = impznew(:,[2 11 3 9 4 5 6 7 8 10 1]);
titz = char('Output','M2 Growth','Inflation','Fed Funds','Capacity Util','Avg Hours','Real Wage','Consumption','Investment','Velocity','Price of Inv.');
 