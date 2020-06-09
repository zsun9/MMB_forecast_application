function makepvalues(PortStatData,PortStatSim,PortmanteauLags,nlags,fid)

ndraws=size(PortStatSim,1);
for ii = 1:length(PortStatData)
    pval(ii)=length(find(PortStatSim(:,ii)>PortStatData(1,ii)))/ndraws;
end        

fprintf(fid,' \\begin{tabular}{lllll} \n');
fprintf(fid,' \\multicolumn{5}{l}{Table: Multivariate Portmanteau (Q) Test For Serial \n');
fprintf(fid,'     Correlation in VAR Residuals (Number of Lags in VAR = %2i)} \\\\ \n',nlags);
fprintf(fid,' \\#Sample Autocorrelations & q-statistic & degrees of freedom & asymptotic \n');
fprintf(fid,'     p-value & bootstrap p-value \\\\ \n');
for ii = 1:length(PortmanteauLags)-1
fprintf(fid,'  %2i   & %4.2f & %3i & %4.2f & %4.2f \\\\  \n',round(PortmanteauLags(ii)),PortStatData(1,ii),round(PortStatData(3,ii)),PortStatData(2,ii),pval(ii));
end
ii=length(PortmanteauLags);
fprintf(fid,'  %2i   & %4.2f & %3i & %4.2f & %4.2f \\\\ \n',round(PortmanteauLags(ii)),PortStatData(1,ii),round(PortStatData(3,ii)),PortStatData(2,ii),pval(ii));

fprintf(fid,' \\multicolumn{5}{l}{Note: Q-statistic taken from Johansen, S., 1995, \n');
fprintf(fid,' Likelihood-Based Inference in Cointegrated } \\\\  \n');
fprintf(fid,' \\multicolumn{5}{l}{Vector Autoregressive Models. New York: Oxford University \n');
fprintf(fid,' Press.} \n');
fprintf(fid,'   \\end{tabular} \n');