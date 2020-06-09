function outdata = detrendrjv(vardata,trendval,vardetrend);
%Detrendrjv removes a time trend polynomial of order trendval
%from the variable in vardata denoted by vardetrend. 

[nobs,nvars] = size(vardata);  %number of variables

outdata = vardata;

   if trendval > 0;
      remtrnd = ones(nobs,1+trendval);
      for nx = 1:trendval;
         remtrnd(:,1+nx) = (1:nobs)'.^nx;
      end
      rtrndcoef = remtrnd\vardata;
      outdata(:,vardetrend) = vardata(:,vardetrend) - remtrnd(:,2:end)*rtrndcoef(2:end,vardetrend);
   end
 