function makeaic(AI,HQ,SW,qstatistic,degf,fid)

fprintf(fid,' \\begin{tabular}{lllllll} \n');
fprintf(fid,' \\multicolumn{7}{l}{Table: Standard VAR Lag Length Selection Criteria } \\\\ \n');
fprintf(fid,' $h$ & AIC & HQ & SC & Q(6) & Q(8) & Q(10) \\\\ \n');
for ii = 1:8
fprintf(fid,' %1i & %7.2f & %7.2f & %7.2f & $\\underset{(%7.2f)}{%7.2f}$ & $\\underset{(%7.2f)}{%7.2f}$ & $\\underset{(%7.2f)}{%7.2f}$ \\\\  \n',ii,AI(ii),HQ(ii),SW(ii),degf(ii,1),qstatistic(ii,1),degf(ii,2),qstatistic(ii,2),degf(ii,3),qstatistic(ii,3));
end

%fprintf(fid,' \\multicolumn{7}{l}{For AIC, HQ, SC, see Herman J. Bierens, Information } \\\\ \n'); 
%fprintf(fid,' \\multicolumn{7}{l}{Criteria and Model Selection, manuscript, Economics } \\\\ \n'); 
%fprintf(fid,' \\multicolumn{7}{l}{Department, Penn State.} \\\\ \n'); 
%fprintf(fid,' \\multicolumn{7}{l}{Q(n), multivariate Q statistic for null hypothesis that \n');
%fprintf(fid,' first} \\\\ \n'); 
%fprintf(fid,' \\multicolumn{7}{l}{n autocorrelations are zero. Asymptotically, the } \\\\ \n');
%fprintf(fid,' \\multicolumn{7}{l}{statistic is Chi-square with degrees of freedom indicated} \n');
%fprintf(fid,' \\multicolumn{7}{l}{in parentheses (see Johansen (1995)).} \n');

fprintf(fid,' \\multicolumn{7}{l}{Note: AIC - Akaike; HQ - Hannan-Quinn; SC - Schwarz} \\\\ \n');
fprintf(fid,' \\multicolumn{7}{l}{For AIC, HQ, SC, see Herman J. Bierens, Information} \\\\ \n'); 
fprintf(fid,' \\multicolumn{7}{l}{Criteria and Model Selection, manuscript, Economics } \\\\ \n'); 
fprintf(fid,' \\multicolumn{7}{l}{Department, Penn State.} \\\\ \n'); 
fprintf(fid,' \\multicolumn{7}{l}{Q(n), multivariate Q statistic for null hypothesis that} \\\\  \n');
fprintf(fid,' \\multicolumn{7}{l}{first n autocorrelations are zero. Asymptotically, the} \\\\  \n');
fprintf(fid,' \\multicolumn{7}{l}{statistic is Chi-square with degrees of freedom indicated} \\\\  \n');
fprintf(fid,' \\multicolumn{7}{l}{in parentheses (see Johansen (1995)).}%% \n');

%\multicolumn{7}{l}{Note: AIC - Akaike; HQ - Hannan-Quinn; SC - Schwarz} \\ 
%\multicolumn{7}{l}{For AIC, HQ, SC, see Herman J. Bierens, Information} \\ 
%\multicolumn{7}{l}{Criteria and Model Selection, manuscript, Economics } \\ 
%\multicolumn{7}{l}{Department, Penn State.} \\ 
%\multicolumn{7}{l}{Q(n), multivariate Q statistic for null hypothesis that}
%\\ 
%\multicolumn{7}{l}{first n autocorrelations are zero. Asymptotically, the}
%\\ 
%\multicolumn{7}{l}{statistic is Chi-square with degrees of freedom indicated}
%\\ 
%\multicolumn{7}{l}{in parentheses (see Johansen (1995)).}%

fprintf(fid,' \\end{tabular} \n');
