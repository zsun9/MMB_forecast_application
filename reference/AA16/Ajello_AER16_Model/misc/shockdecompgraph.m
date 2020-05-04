for combine = [0 1]
%clear all; close all; 

outdir = '/msu/res1/m1axa04/Research/Ajello 2011/Ajello_Code_Dynare/output_7_23/';
indir = ''; '\msu/res1/m1axa04/Research/Ajello 2011/Ajello_Code_Dynare/output_7_23/';
addpath /mq/home/dynare/dynare-4.4.2/matlab/
addpath \\mqlx1\mq-home\dynare-4.4.2_win\matlab\

r = load([indir 'Ajello_JMP_results_Miguel'], 'oo_', 'M_', 'options_');
varlist = char('d_GDP');
firstyear = 1989; 
%oo_ = shock_decomposition(r.M_,r.oo_,r.options_,varlist);


shock_names = char([       'TFP                 ';...
                           'GOVT                ';...
                           'MON POL             ';...
                           'FIN                 ';...
                           'PREF                ';...
                           'P MARK-UP           ';...
                           'W MARK-UP           ';...
                           'FIN TRANS           ';...
                           '\epsilon_{\eta}     ';...
                           '\epsilon_{\eta}     ']); 
order = [1 2 3 4 8 5 6 7];
% Colormap
colorsetting = [0.1      0.39        0.5625; %TFP
               0.6       0.6        0.7625; %GOVT
               0.3       0.1875     1.0000; %MON POL
               .9        0.2875     0.0000; %FIN
               0.3500    1.0000     0.7500; %PREF
               0.8750    1.0000     0.1250; %P MARK-UP
                1        0.6875         0.0; %W MARK-UP
               1        0.4             0.4; %FIN TRANS
               0.2000    0.6000    1.0000; %\epsilon_{\eta}
               0.6000    0.8000    1.0000; %\epsilon_{\eta}
               0.5       0               0];%initial value

initial_date = r.options_.initial_date;
z = r.oo_.shock_decomposition;

%fix the order
colorsetting = colorsetting([order size(colorsetting,1)], :);
shock_names = shock_names(order, :); 
z = z(:,[order size(z,2)-1 size(z,2)],:);
tau_ind = 4;
tau_t_ind = 5;

%Combine financial shocks
if combine
    z(:,tau_ind,:) = z(:,tau_ind,:) + z(:,tau_t_ind,:);
    z(:,tau_t_ind,:) =[];
    colorsetting(tau_t_ind,:) = [];
    shock_names(tau_t_ind,:) = [];
end

%The rest of this, with slight modifications, is from the dynare 'graph_decomposition.m'
comp_nbr = size(z,2)-1;
gend = size(z,3);
freq = initial_date.freq;
initial_period = initial_date.period + initial_date.subperiod/freq;
x = initial_period-1/freq:(1/freq):initial_period+(gend-1)/freq;
x = x*.25 + firstyear;

i_var = NaN(size(varlist,1), 1);
for i = 1:length(i_var)
    i_var(i) = find((ismember(cellstr(r.M_.endo_names),deblank(varlist(i,:)))));
end

nvar = length(i_var);

for j=1:nvar
    z1 = squeeze(z(i_var(j),:,:));
    xmin = x(1);
    xmax = x(end);
    ix = z1 > 0;
    ymax = max(sum(z1.*ix))-1;
    ix = z1 < 0;
    ymin = min(sum(z1.*ix))+1.5;
    if ymax-ymin < 1e-6
        continue
    end
    f = figure;
    ax=axes('Position',[0.1 0.1 0.6 0.8]);
    plot(ax,x(2:end),z1(end,:),'k-','LineWidth',2)
    axis(ax,[xmin xmax ymin ymax]);
    hold on;
        text(xmin+(xmax-xmin)/3, ymax+.2,'Historical Decomposition of GDP Growth')
    for i=1:gend
        i_1 = i-1;
        yp = 0;
        ym = 0;
        for k = 1:comp_nbr
            zz = z1(k,i);
            if zz > 0
                fill([x(i) x(i) x(i+1) x(i+1)],[yp yp+zz yp+zz yp],colorsetting(k,:));
                yp = yp+zz;
            else
                fill([x(i) x(i) x(i+1) x(i+1)],[ym ym+zz ym+zz ym],colorsetting(k,:));
                ym = ym+zz;
            end
            hold on;
        end
    end
    plot(ax,x(2:end),z1(end,:),'k-','LineWidth',2)
    hold off;

    axes('Position',[0.75 0.1 0.2 0.8]);
    axis([0 1 0 1]);
    axis off;
    hold on;
    y1 = 0;
    height = 1/comp_nbr;
    labels = char(shock_names,'Initial values');

    for i=1:comp_nbr
        fill([-0.1 -0.1 0 0],[y1 y1+0.7*height y1+0.7*height y1],colorsetting(i,:));
        hold on
        text(0.1,y1+0.3*height,labels(i,:),'Interpreter','tex');
        hold on
        y1 = y1 + height;
    end
    combinetext = '';
    if combine; combinetext = 'comb'; end; 
    orient LANDSCAPE
    set(gcf, 'PaperSize', [15 8.5], 'PaperPositionMode', 'manual', 'PaperPosition', [0 0  15 8.5]);
    print(f,[r.M_.fname,'_shock_decomposition_',deblank(r.M_.endo_names(i_var(j),:)),combinetext, '.eps'],'-depsc');
    hold off
end
end
