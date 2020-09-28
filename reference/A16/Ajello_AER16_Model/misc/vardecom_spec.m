  function out=vardecom_spec(G1,A, ghx, ghu1,ghu,HH,SDX,zmat,freq,edgew,stloc,levindic)
% =========================================================================
% function out=vardecom_spec(G1,HH,SDX,zmat,freq,edgew,stloc,levindic)
%
%% DESCRIPTION: 
% Compute the variance and variance decomposition for a given frequency band 
% using a DSGE with the vector FREQ having all data frequencies in the band. EDGEW is a 2x1 
% vector with the distance to the edges for the lowest and highest frequency respectively. 
% Both FREQ & EDGEW are created by FREQ_VEC.m. Note, frequencies must be
% positive!  
%
%% Inputs: 
% GG,HH,SDX,ZMAT correspond to the solution of the DSGE Model
% TRANSITION Equation is
% $$ S_{t}= G1 * S_{t-1} + HH * e_{t} $$ where 
% $$ V( e_{t} ) = (SDX')*SDX $$ 
% Observation Equation is 
% $$ Y_{t} = zmat*( S{t} + C ) $$ and C is not used here. 
%
% FREQ:      Vector of frequencies 
% EDGEW:     Distance of edge to border 
% STLOC:     Location of rows of the state vector wish to analyze 
% LEVINDIC:  Indicator, ==1 will compute the level by applying difference
% filter
%
%% APPROXIMATION TO VARIANCE: 
% Let [WB,WU] be the frequency band wish to 
% approximate with all frequencies in that band in vector FREQ. 
% The variance for that frequency band is given by 
% 2*Integral(S(w)) which is discretely approximated as the area of a set of 
% rectangles. Rectangles associated with other than the first and last 
% frequency have area: S(w(j))*(w(j)-w(j-1)) where 
% width=w(j)-w(j-1)=2*pi/nobs, nobs is the number of observations. 
% For the frequencies at the edges the areas instead are: 
% a) S(w(1))*[w(1)-WB]           EDGEW(1)=w(1)-WB 
% b) S(w(end))*[WU-w(end)]       EDGEW(2)=WU-w(end) 
% Then the total variance is given by c
% sum(sw(2:end))*(4*pi/nobs)+2*edgew(1)*sw(1)+2*edgew(end)*sw(end) 
% The 2 is included in 2*2*pi and is required since only 
% frequencies > 0 are considered. See Hamilton Ch 6 for further details. 
%
% FILTER FOR STATES OTHER THAN OBSERVABLES: in addition to observables, 
% report selected states whose row position in model state vector given by STLOC 
% 
% INVERSE FILTER FOR LEVEL (VARIANCES ONLY): for those elements in STLOC, also allow for an inverse first
% difference filter, if levindic==1. This will report variance only.
% CROSS-SPECTRUMS will NOT be adjusted
% Example:
% STLOC=   [3 29] corresponding to hours and output growth
% levindic=[0  1] will compute  filter for   output level
%                 once Sdy(w) is available
%                      Sy(w) =[(1-e_iw)^-1]*Sdy(w)*[(1-e_iw)^-1]'
%
% LEVINDIC is hence of the same length than STLOC 

%%                                Output
% Dimension NF=# frequencies, NST=# states; NLEV=# states transformed to
%           levels
%
%1. VCVZ & VCVST    Usual variances for observables and selected states
%
%2. SPEC: Spectrum matrcies at each frequency
% -------------------------------------------
% SPECZ           [NZ NZ NF]    For observables
% SPECST          [NST NST NF]  For untransformed states
% SPECLEV         [NLEV NF]     If states transformed to levels,
%                 Diagonal elements only
%
% 3. VFB: total variance for this frequency band
% ------------------------------------------------
% VFBZ          [NZ 1] (observables)
% VFBST         [NST 1](unstranformed states)
% VBFLEV        [NLEV 1] Total variance for level states
%
% 4. SPECDEC    Variance decompsition for that frequency
%               Diagonal elements ONLY
% -------------------------------------------------------
% SPECDECZ      [NZ NX NF]
% SPECDECST     [NST NX NF]
% SPECDECLEV    [NLEV NX NF]
%
% 5.VFBDECL total Variance decompositon for this frequency band
% Ratio of the total variance in SPECDEC to the total variance in
% VFB
% ------------------------------------------------------------
% VFBDECZ      [NZ NX]
% VFBDECST     [NST NX]
% VFBDECLEV    [NLEV NX]
% 
% See TEST_VARSPECDEC.m for debugging and testing 
% To plot SPECDEC squeeze(jj,:,:)'  [NF NX] 
% Alejandro Justiniano (C)  October 22 2007 
%==========================================================================
%==========================================================================
ny=size(G1,1);nx=size(SDX,1);nz=size(zmat,1);nf=length(freq);
%1.FLAG_ST:  determine if states other than observables will be analyzed
%  levindic: in if some states will be transformed to levels
% -----------------------------------------------------------
if nargin < 7 || isempty(stloc);
    nst=0;
    flag_st=0;flag_dolev=0;
else
    flag_st=1;
    nst=length(stloc);flag_st=1;
    out.specst=zeros(nst,nst,nf);
    out.vfbst=zeros(nst,1);
    out.specdecst=zeros(nst,nx,nf);
    out.vfbdecst=zeros(nst,nx);
    if nargin < 8
        %levindic=zeros(1,length(stloc) );
        flag_dolev=0;
        
    else
        % Determine which states should be levels
        if length(stloc)~=length(levindic)
            error('STLOC and LEVINDIC do not match')
        end
        if any( levindic~=0 & levindic~=1 )
            error('LEVINDIC must be 0 or 1')
        end
        
        flag_dolev=any(levindic==1);
        if flag_dolev==1;
            % Transfer function for Inverse FD filter
            tflev=zeros(1,nf);
            % INDSTLEV indicated which of the reported states should be in
            % levels
            indstlev=find(levindic==1);
            nlev=length(indstlev);
            out.speclev=zeros(nlev,nf);
            out.specdeclev=zeros(nlev,nx,nf);
            out.vfblev=zeros(nlev,1);
            out.vfbdeclev=zeros(nlev,nx);
        end
    end
end
% 2. Compute standard variance for states and observables

SS = SDX;
cs = chol(SS)';
b1 = ghu1;
MM = b1*(cs'*cs)*b1';
G1 = A;
%MM=HH*(SDX'*SDX)*(HH');
pshatc=lyapunov_symm_freq(G1,MM);
pshat=disclyap_fast(G1,MM);

%pshat = ghx(iky,:)*pshat*ghx(iky,:)'+ghu(iky,:)*cs'*cs*ghu(iky,:)';
pshat = ghx*pshat*ghx'+ghu*cs'*cs*ghu';
%vx  = lyapunov_symm(A,b1*b1',options_.qz_criterium,options_.lyapunov_complex_threshold,1);

% if max(max(abs(pshatc-pshat))) > 1e-3
%     warning('Numerical Discrepancies LYAPUNOV SYMM and DISCLYAP_FAST')
% end
pshat=0.5*(pshat+pshat');
if flag_st==1
    out.vcvst=pshat(stloc,stloc);
else
    out.vcvst=[];
end
out.vcvz=zmat*pshat*zmat';
clear pshat; 
% ===============================
% 3. Spectral Filter matrices
% SYW
% SYWLEV
% ==============================
syw=zeros(ny,ny,nf);

%MM = HH*(cs'*cs)*(HH');
for jj=1:nf;
    if flag_dolev==1
        %% Transfer function inverse first difference filter
        % $$ TFLEV(\omega) = | 1-exp(-i \omega) |^(-1) $$
        tflev(jj)=abs(1/(1-(exp(-1i*freq(jj)))))^2;
    end
    %% VAR(1) Filter 
    % $$ SYW(\omega) = | I-G_{1} exp(-i \omega) |^(-1) $$
    syw(:,:,jj)=(eye(ny)-G1.*(repmat( exp(-1i*freq(jj)),[ny ny])))\eye(ny);
    %     a1=(exp(-i*freq(jj)))*ones(ny);
    %     a2=G1.*a1;
    %     a3=inv(eye(ny)-a2);
    %
    %     b1=(exp(i*freq(jj)))*ones(ny);
    %     b2=(G1').*b1;
    %     b3=inv(eye(ny)-b2);
    %     comparemat(syw(:,:,jj)',b3)
    %     Checked filter transfer function is correct  10/22/07
    
end
% ==============================================
% 4. Spectrum at different frequencies: SPECZ SPECST
%    Total Variance VFB 
% ================================================
% BINW=width of bins 

%% Length of bins
binw=zeros(1,nf);
binw(1)=edgew(1);binw(end)=edgew(end); 
if nf > 2
    binw(2:end-1)=(freq(2)-freq(1))*ones(1,nf-2);
end 
diagind=find(eye(ny)==1);
out.specz=zeros(nz,nz,nf);
out.vfbz=zeros(nz,1); 
for jj=1:nf;
    % Note: to compute the whole spectrum, including cospectrum
    % need allow for IM numbers. For the diagonal, however, enforce
    % real numbers only. Checked identical to machine precision
    temp_spec=syw(:,:,jj)*MM*(syw(:,:,jj)')/(2*pi);
    temp_spec(diagind)=diag(diag(real(temp_spec(diagind))));
    if flag_st==1
        out.specst(:,:,jj)=temp_spec(stloc,stloc);
        if flag_dolev==1
            % TFLEV is the frequency response function
            out.speclev(:,jj)=diag(tflev(jj)*(out.specst(indstlev,indstlev,jj)));
        end
    end
    out.specz(:,:,jj)= zmat*(ghx*(temp_spec)*ghx')*zmat';
    %out.specz(:,:,jj)=zmat*(temp_spec)*zmat';
    % Total Variances: areas of rectangles 
    %-------------------------------------
    out.vfbz=(out.vfbz)+2*(diag(out.specz(:,:,jj))*binw(jj));
    if flag_st==1
        out.vfbst=(out.vfbst)+2*(diag(out.specst(:,:,jj))*binw(jj));
    end
end
if flag_dolev==1 
    out.vfblev=2*sum( ((out.speclev).*(repmat(binw,[nlev 1]))),2 ); 
end 
% ========================================================
% 5. Variance Decompositions 
% =========================================================
out.vfbdecz=zeros(nz,nx); 
for hh=1:nx
    MM = b1*(cs(hh,:)'*cs(hh,:))*b1';
    %MM=HH*((SDX(hh,:)' )*SDX(hh,:))*(HH');
    for jj=1:nf
        temp_spec=syw(:,:,jj)*MM*(syw(:,:,jj)')/(2*pi);
        temp_spec(diagind)=diag(diag(real(temp_spec(diagind))));
        if flag_st==1
            out.specdecst(:,hh,jj)=diag(temp_spec(stloc,stloc))./(diag(out.specst(:,:,jj)));
            out.vfbdecst(:,hh)=(out.vfbdecst(:,hh))+2*(diag(temp_spec(stloc,stloc))*binw(jj));
            if flag_dolev==1
                % Extract states that will report
                temp_lev=diag(temp_spec(stloc,stloc));
                % Extrast levels from thise states 
                temp_lev=temp_lev(indstlev); 
                % TFLEV is the frequency response function
                out.specdeclev(:,hh,jj)=(tflev(jj)*temp_lev)./(out.speclev(:,jj));
                out.vfbdeclev(:,hh)=out.vfbdeclev(:,hh)+2*(tflev(jj)*temp_lev)*binw(jj); 
            end
        end
        out.specdecz(:,hh,jj)=diag(zmat*(ghx*(temp_spec)*ghx')*zmat')./(diag(out.specz(:,:,jj)));
        out.vfbdecz(:,hh)=(out.vfbdecz(:,hh))+2*(diag(zmat*(ghx*(temp_spec)*ghx')*zmat')*binw(jj));
    end
end
out.vfbdecz=out.vfbdecz./(repmat(out.vfbz,[1 nx])); 
% Check all variance decompositions add up to 1 
% Observables
if any( any(sum(out.vfbdecz,2) < 0.999) | any( sum(out.vfbdecz,2) > 1.001 ) )
    error('Total Variance decompositions observables, do not add up')
end
if any( any( squeeze(sum(out.specdecz,2)) < 0.999 | squeeze(sum(out.specdecz,2)) > 1.001 ) )
    error('Variance decompositions observables do not add up to one')
end
if flag_st==1
    % states 
    out.vfbdecst=out.vfbdecst./(repmat(out.vfbst,[1 nx])); 
    if any( any(sum(out.vfbdecst,2) < 0.999) | any( sum(out.vfbdecst,2) > 1.001 ) )
        error('Total Variance decompositions states, do not add up') 
    end 
    if any( any( squeeze(sum(out.specdecst,2)) < 0.999 | squeeze(sum(out.specdecst,2)) > 1.001 ) )
        error('Variances states do not add up to one')
    end
    if flag_dolev==1
        % Level 
        out.vfbdeclev=out.vfbdeclev./(repmat(out.vfblev,[1 nx])); 
        if any( any(sum(out.vfbdeclev,2) < 0.999) | any( sum(out.vfbdeclev,2) > 1.001 ) )
            error('Total Variance decompositions states, do not add up')
        end

        if any( any( squeeze(sum(out.specdeclev,2)) < 0.999 & squeeze(sum(out.specdeclev,2)) > 1.001 ) )
            error('Variances level states do not add up to one')
        end
    end
end