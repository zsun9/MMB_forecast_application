function printestimate(xx,par,II,name)

fid=fopen('estimate.m','w');
fprintf(fid,'%%Following are the parameters that were estimated \n');
ix=0;
for ii = 1:length(II(:,1))
    if II(ii,1) == 1
        aa=[name(ii,:),' = %6.4f ;\n'];
        ix=ix+1;
        fprintf(fid,aa,xx(ix));
    end            
end
fprintf(fid,'%%Following are the parameters held fixed in the estimation \n\n');
iy=0;
for ii = 1:length(II(:,1))
    if II(ii,1) == 0
        aa=[name(ii,:),' = %6.4f ;\n'];
        iy=iy+1;
        fprintf(fid,aa,par(iy));
    end
end
fclose(fid);