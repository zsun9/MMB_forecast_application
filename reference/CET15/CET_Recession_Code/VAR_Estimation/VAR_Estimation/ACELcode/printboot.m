function printboot(Etechtab,Ntechtab,montab,histhp,histbp,ndraws,vardata,PortmanteauLags,nlags)

load decomp EtechtabStd NtechtabStd montabStd alltabStd histhpStd histbpStd PortStatData PortStatSim Etechtabmean Ntechtabmean montabmean alltabmean histhpmean histbpmean    
name='table.tex';
fid=setuptable(name);
heading='Embodied Technology Shock';
makedecomptable(EtechtabStd,Etechtabmean,Etechtab,fid,heading);
heading='Neutral Technology Shock';
makedecomptable(NtechtabStd,Ntechtabmean,Ntechtab,fid,heading);
heading='Policy Shock';
makedecomptable(montabStd,montabmean,montab,fid,heading);
heading='HP Filtered Data';
makedecomptable1(histhpmean,histhpStd,histhp,fid,heading);
heading='BP Filtered Data';
makedecomptable1(histbpmean,histbpStd,histbp,fid,heading);

for ii = 1:length(PortStatData)
    pval(ii)=length(find(PortStatSim(:,ii)>PortStatData(1,ii)))/ndraws;
end

makepvalues(PortStatData,PortStatSim,PortmanteauLags,nlags,fid);
%go after the Akaike and other diagnostics for choosing lag length in the VAR
[AI,AIlag,HQ,HQlag,SW,SWlag,qstatistic,degf,peevalue] = picklag(vardata);
makeaic(AI,HQ,SW,qstatistic,degf,fid);
fprintf(fid,' \\end{document} \n');
fclose(fid);
