function L=calc_conditional_WL(para0,row_WL)

global M_ oo_

NumberOfParameters = M_.param_nbr;                            % Number of deep parameters.
for i = 1:NumberOfParameters                                  % Loop...
  paramname = deblank(M_.param_names(i,:));                   %    Get the name of parameter i. 
  eval([ paramname ' = M_.params(' int2str(i) ');']);         %    Get the value of parameter i.
end  
 
etaWb=para0(1);
etaKb=para0(2);

NumberOfParameters = M_.param_nbr;
        for i = 1:NumberOfParameters
            paramname = deblank(M_.param_names(i,:));
            eval(['M_.params(' int2str(i) ')=' paramname ';']);
         
        end

bound_up=[10  0 ]';       
bound_low=[0 -10]';       


if any(para0>bound_up) || any(para0<bound_low)
    
    L=1e8;
else

[oo_.dr, info] =resol(oo_.steady_state,0);

if info(1)==0 && oo_.dr.ghs2(row_WL)/2>0
L=(oo_.dr.ys(oo_.dr.order_var(row_WL))+oo_.dr.ghs2(row_WL)/2)*100;

else
    
    L=10;
end

end