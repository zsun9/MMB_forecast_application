for levels = [0 1]
close all; 
clearvars -except levels
outdir = '/msu/res1/m1axa04/Research/Ajello 2011/Ajello_Code_Dynare/output_7_23/';
indir = '/msu/res1/m1axa04/Research/Ajello 2011/Ajello_Code_Dynare/Ajello_Code_Dynare_7_23/';

results = load([indir 'Ajello_JMP_results'], 'oo_');
results = results.oo_;
%results = oo_;

IRFmed = results.PosteriorIRF.dsge.Median;
IRFinf = results.PosteriorIRF.dsge.HPDinf;
IRFsup = results.PosteriorIRF.dsge.HPDsup;

%--------------------------------------------------------------------------------------%
%----------------------------------- SCALING ------------------------------------------%
%--------------------------------------------------------------------------------------%
IRFnames = fieldnames(IRFmed);
toScale = {'pi_ob_t', 'i_ob_t'};
scale   = 4*[1,1];
for var = 1:length(toScale)
    for i = 1:numel(IRFnames)
        if ~isempty(strfind(IRFnames{i}, toScale{var})) & strfind(IRFnames{i}, toScale{var}) == 1
            IRFmed.(IRFnames{i}) =  IRFmed.(IRFnames{i}) * scale(var); 
            IRFinf.(IRFnames{i}) =  IRFinf.(IRFnames{i}) * scale(var);         
            IRFsup.(IRFnames{i}) =  IRFsup.(IRFnames{i}) * scale(var);
        end
    end
end

%--------------------------------------------------------------------------------------%
%----------------------- Make Y Stationary in TFP Shock -------------------------------%
%--------------------------------------------------------------------------------------%
moments = {'med', 'inf', 'sup'};

periods = 30; 
for m = 1:length(moments)
    %Set up A
    A = NaN(periods+1,1);
    eval(['z = IRF' moments{m} '.z_t_eps_z;']);
    A(1) = 1;
    for t = 2:periods+1
        A(t) = A(t-1) * exp(z(t-1));
    end
    A = A(2:end);
    
    % Destationaryify y,i,c,w (replace their stationary values in the IRF structures)
    vars    = {'yhat', 'Ihat', 'chat', 'what_t'};
    replace = {'d_GDP', 'd_Ihat', 'd_chat', 'dlnwhat'};  
    
    for v = 1:length(vars)
        eval(['xhat = IRF' moments{m} '.' vars{v} '_eps_z;']);
        x = 100*(exp(xhat).* A -1); 
        %        eval(['IRF' moments{m} '.' replace{v} '_eps_z = x;']);
        eval(['IRF' moments{m} '.' vars{v}    '_eps_z = x;']);            
    end
end



%--------------------------------------------------------------------------------------%
%----------------------------------- PLOTTING -----------------------------------------%
%--------------------------------------------------------------------------------------%
shocks   = {'eps_tau', 'eps_z', 'eps_g', 'eps_i', 'eps_beta', 'eps_p', 'eps_w', 'eps_tau_trans'}; 
vars     = {'d_GDP', 'd_Ihat', 'd_chat', 'dlnwhat', 'pi_ob_t', 'i_ob_t',  'l_ob_t', 'Spread_ob_t', 'FGS_obs'}; 
varnames = {'GDP Growth', 'Investment Growth', 'Consumption Growth', 'Wage Growth', 'Inflation', 'FFR',  ...
            'Log Hours', 'Spread','Financial Gap Share'};
if levels 
    vars = {'yhat', 'Ihat', 'chat', 'what_t', 'pi_ob_t', 'i_ob_t',  'l_ob_t', 'Spread_ob_t', 'FGS_obs'}; 
    varnames = {'GDP', 'Investment', 'Consumption', 'Wages', 'Inflation', 'FFR', 'Log Hours', 'Spread', ...
          'Financial Gap Share'};    
end

titles = {'Impulse Response Functions - Financial Shock', ...
          'Impulse Response Functions - TFP Shock' ...
          'Impulse Response Functions - Government Shock' ...
          'Impulse Response Functions - Monetary Policy Shock' ...
          'Impulse Response Functions - Preference Shock' ...
          'Impulse Response Functions - Price mark-up Shock' ...
          'Impulse Response Functions - Wage mark-up Shock' ...
          'Impulse Response Functions - Financial (trans) Shock' };          
levellabel = ''; 
if levels  
    levellabel = '_levels';
end;

for sh = 1:length(shocks)
    f = figure;
    plotno = 1;
    for v = 1:length(vars)
        subplot(3,3,plotno);
        %Get the variables to plot
        eval(['varmed = IRFmed.' vars{v} '_' shocks{sh} ';']); 
        eval(['varinf = IRFinf.' vars{v} '_' shocks{sh} ';']);         
        eval(['varsup = IRFsup.' vars{v} '_' shocks{sh} ';']); 
        %X-axis 
        x = .5:length(varsup);
        %Plot the shaded areas
        area(x, varsup, min(varinf), 'FaceColor', [.8 .8 .8],'EdgeColor', [1 1 1]); 
        hold on 
        area(x, varinf, min(varinf), 'FaceColor', [1 1 1], 'EdgeColor', [1 1 1]); 
        %Draw gray lines to border the gray areas, blue lines to do the same, red line for 
        % zero and black line for median
        plot(x, varsup, x, varinf, 'LineWidth', 1, 'Color', [.8 .8 .8]);
        plot(x, 0*varmed, 'r-', 'LineWidth', 1);        
        plot(x, varsup, 'b--', x, varinf,'b--', 'LineWidth', 1);
        plot(x, varmed, 'k-', 'LineWidth', 1);
        %Bring the axes forward
        box on ; set(gca, 'Layer', 'top');
        %Set the title
        title(varnames{v})
        %Make sure the 0 line is visible by adding a padding around it to the axis
        yrange = get(gca, 'YLim'); 
        tick = abs(yrange(1) - yrange(2));         
        if min(ylim) == 0; ylim([-tick/10, max(ylim)]); 
        elseif max(ylim) == 0; ylim([min(ylim), tick/10]); end        
        xlim([0 30])
        hold off;
        plotno = plotno + 1;
    end
    mtit(titles{sh}, 'fontsize', 12) %Note that I update the mtit used here
    print(f,['IRF_' shocks{sh}  levellabel], '-depsc'); 
end
end
