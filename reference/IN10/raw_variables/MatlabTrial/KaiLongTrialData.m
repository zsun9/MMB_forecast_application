cd 'C:\Users\jaspe\Documents\GitHub\MMB_forecast_application\reference\IN10\raw_variables\MatlabTrial'


[mydata, myheader] = xlsread('maunal_data_trial.xlsx');
for i = 1:length(myheader)
      % compose a command to assign each column to a variable with the same 
      % name as the header
      commandExec = [myheader{i}, ' = ', 'mydata(:,', num2str(i) , ');'];
      % execute the composed command to actually create the variable
      evalin('base', commandExec );
end

clear myheader mydata i commandExec date