function [pars, cosnJ] = ident_bruteforce(J,n,TeX, pnames_TeX)
% function [pars, cosnJ] = ident_bruteforce(J,n,TeX, pnames_TeX)
%
% given the Jacobian matrix J of moment derivatives w.r.t. parameters
% computes, for  each column of  J, the groups of columns from 1 to n that
% can repliate at best the derivatives of that column
%
% OUTPUTS
%  pars  : cell array with groupf of params for each column of J for 1 to n
%  cosnJ : the cosn of each column with the selected group of columns

% Copyright (C) 2009 Dynare Team
%
% This file is part of Dynare.
%
% Dynare is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <http://www.gnu.org/licen
global M_ 

OutputDirectoryName = CheckPath('Identification');

k = size(J,2); % number of parameters

if nargin<2 || isempty(n)
    n = 4; % max n-tuple
end
if nargin<3 || isempty(TeX)
    TeX = 0; % max n-tuple
end

cosnJ=zeros(k,n);
pars{k,n}=[];
for ll = 1:n,
    h = waitbar(0,['Brute force collinearity for ' int2str(ll) ' parameters.']);
    for ii = 1:k
        tmp = find([1:k]~=ii);
        tmp2  = nchoosek(tmp,ll);
        cosnJ2=zeros(size(tmp2,1),1);
        for jj = 1:size(tmp2,1)
            cosnJ2(jj,1) = cosn([J(:,ii),J(:,tmp2(jj,:))]);
        end
        cosnJ(ii,ll) = max(cosnJ2(:,1));
        pars{ii,ll} = tmp2(find(cosnJ2(:,1)==max(cosnJ2(:,1))),:);
        waitbar(ii/k,h)
    end
    close(h),
    if TeX
        filename = [OutputDirectoryName '/' M_.fname '_collinearity_patterns' int2str(ll) '.TeX'];
        fidTeX = fopen(filename,'w');
        fprintf(fidTeX,'%% TeX-table generated by ident_bruteforce (Dynare).\n');
        fprintf(fidTeX,['%% Collinearity patterns with ',int2str(ll),' parameter(s)\n']);
        fprintf(fidTeX,['%% ' datestr(now,0)]);
        fprintf(fidTeX,' \n');
        fprintf(fidTeX,' \n');
        fprintf(fidTeX,'{\\tiny \n');
        fprintf(fidTeX,'\\begin{table}\n');
        fprintf(fidTeX,'\\centering\n');
        fprintf(fidTeX,'\\begin{tabular}{l|lc} \n');
        fprintf(fidTeX,'\\hline\\hline \\\\ \n');
        fprintf(fidTeX,'  Parameter & Explanatory & cosn \\\\ \n');
        fprintf(fidTeX,'            & parameter(s)   &  \\\\ \n');
        fprintf(fidTeX,'\\hline \\\\ \n');
        for i=1:k,
            plist='';
            for ii=1:ll,
                plist = [plist ' $' pnames_TeX(pars{i,ll}(ii),:) '$ '];
            end
            fprintf(fidTeX,'$%s$ & [%s] & %7.3f \\\\ \n',...
                pnames_TeX(i,:),...
                plist,...
                cosnJ(i,ll));
        end
        fprintf(fidTeX,'\\hline\\hline \n');
        fprintf(fidTeX,'\\end{tabular}\n ');
        fprintf(fidTeX,['\\caption{Collinearity patterns with ',int2str(ll),' parameter(s)}\n ']);
        fprintf(fidTeX,['\\label{Table:CollinearityPatterns:',int2str(ll),'}\n']);
        fprintf(fidTeX,'\\end{table}\n');
        fprintf(fidTeX,'} \n');
        fprintf(fidTeX,'%% End of TeX file.\n');
        fclose(fidTeX);
    end
end