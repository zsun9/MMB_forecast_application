function [residual, g1, g2, g3] = dynamic(y, x, params, steady_state, it_)
    T = NaN(15, 1);
    if nargout <= 1
        residual = HLaEst2015BEP.dynamic_resid(T, y, x, params, steady_state, it_, true);
    elseif nargout == 2
        [residual, g1] = HLaEst2015BEP.dynamic_resid_g1(T, y, x, params, steady_state, it_, true);
    elseif nargout == 3
        [residual, g1, g2] = HLaEst2015BEP.dynamic_resid_g1_g2(T, y, x, params, steady_state, it_, true);
    else
        [residual, g1, g2, g3] = HLaEst2015BEP.dynamic_resid_g1_g2_g3(T, y, x, params, steady_state, it_, true);
    end
end
