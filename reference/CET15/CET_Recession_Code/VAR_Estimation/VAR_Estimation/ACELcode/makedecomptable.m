function makedecomptable(EtechtabStd,Etechtabmean,Etechtab,fid,heading)

fprintf(fid,' \\begin{tabular}{|l|c|@{}c|c|@{}c|c|@{}c|c|} \n');
fprintf(fid,' \\hline \n');
cc=[' \\multicolumn{8}{|c|}{\\textbf{Table: Decomposition of Variance, '];
bb=['}} \\\\ \\hline \n'];
zz=[cc,heading,bb];
fprintf(fid,zz);
fprintf(fid,' \\textbf{Variable} & \\multicolumn{5}{|c}{\\textbf{Forecast Variance at \n');
fprintf(fid,' Indicated Horizon}} & \\multicolumn{2}{|c|}{\\textbf{Business Cycle \n');
fprintf(fid,' Frequencies}} \\\\ \\cline{2-8} \n');
fprintf(fid,' & \\textbf{1} & \\textbf{4} & \\textbf{8} & \\textbf{12} & \\textbf{30} & \\textbf{%% \n');
fprintf(fid,' HP 1600} & \\textbf{BP 8-32} \\\\ \\hline\\hline \n');

for jj = 1:11
    ix=0;
    for ii = 1:size(EtechtabStd,2);
        ix=ix+1;
        aa(jj,ix)=round(Etechtabmean(jj,ii));
        ix=ix+1;
        aa(jj,ix)=round(EtechtabStd(jj,ii));
        ix=ix+1;
        aa(jj,ix)=round(Etechtab(jj,ii));
    end
end
fprintf(fid,' \\textbf{Output} & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ \\\\ \\hline \n',aa(1,:));
fprintf(fid,' \\textbf{MZM Growth} & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ \\\\ \\hline \n',aa(2,:));
fprintf(fid,' \\textbf{Inflation} & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ \\\\ \\hline \n',aa(3,:));
fprintf(fid,' \\textbf{Fed Funds} & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ \\\\ \\hline \n',aa(4,:));
fprintf(fid,' \\textbf{Capacity Util.} & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ \\\\ \\hline \n',aa(5,:));
fprintf(fid,' \\textbf{Avg. Hours} & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ \\\\ \\hline \n',aa(6,:));
fprintf(fid,' \\textbf{Real Wage} &  $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ \\\\ \\hline \n',aa(7,:));
fprintf(fid,' \\textbf{Consumption} & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ \\\\ \\hline \n',aa(8,:));
fprintf(fid,' \\textbf{Investment} & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ \\\\ \\hline \n',aa(9,:));
fprintf(fid,' \\textbf{Velocity} & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ \\\\ \\hline \n',aa(10,:));
fprintf(fid,' \\textbf{Price of Inv.} & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ & $\\underset{(%3i) [%3i]}{%3i}$ \\\\ \\hline \n',aa(11,:));

fprintf(fid,' \\multicolumn{8}{|l|}{Notes: Numbers are point estimates, number in \n');
fprintf(fid,' parentheses are mean of point estimates across} \\\\ \\hline \n');
fprintf(fid,' \\multicolumn{8}{|l|}{bootstrap simulations; number in square brackets are \n');
fprintf(fid,' standard deviation of point estimates} \\\\ \\hline \n');
fprintf(fid,' \\multicolumn{8}{|l|}{across bootstrap simulations.} \\\\ \\hline \n');
fprintf(fid,' \\end{tabular} \n');