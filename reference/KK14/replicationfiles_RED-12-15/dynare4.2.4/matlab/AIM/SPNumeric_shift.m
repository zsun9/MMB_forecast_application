%  [h,q,iq,nnumeric] = ...
%             SPNumeric_shift(h,q,iq,qrows,qcols,neq,condn)
%
% Compute the numeric shiftrights and store them in q.

% Original author: Gary Anderson
% Original file downloaded from:
% http://www.federalreserve.gov/Pubs/oss/oss4/code.html
% Adapted for Dynare by Dynare Team.
%
% This code is in the public domain and may be used freely.
% However the authors would appreciate acknowledgement of the source by
% citation of any of the following papers:
%
% Anderson, G. and Moore, G.
% "A Linear Algebraic Procedure for Solving Linear Perfect Foresight
% Models."
% Economics Letters, 17, 1985.
%
% Anderson, G.
% "Solving Linear Rational Expectations Models: A Horse Race"
% Computational Economics, 2008, vol. 31, issue 2, pages 95-113
%
% Anderson, G.
% "A Reliable and Computationally Efficient Algorithm for Imposing the
% Saddle Point Property in Dynamic Models"
% Journal of Economic Dynamics and Control, 2010, vol. 34, issue 3,
% pages 472-489

function [h,q,iq,nnumeric] = SPNumeric_shift(h,q,iq,qrows,qcols,neq,condn)

nnumeric = 0;
left     = 1:qcols;
right    = qcols+1:qcols+neq;

[Q,R,E]  = qr( h(:,right) );
zerorows = find( abs(diag(R)) <= condn );

while( any(zerorows) && iq <= qrows )
   h=sparse(h);
   Q=sparse(Q);
   h = Q'*h;
   nz = length(zerorows);
   q(iq+1:iq+nz,:) = h(zerorows,left);
   h(zerorows,:)   = SPShiftright( h(zerorows,:), neq );
   iq       = iq + nz;
   nnumeric = nnumeric + nz;
   [Q,R,E] = qr( full(h(:,right)) );
   zerorows = find( abs(diag(R)) <= condn );
end
