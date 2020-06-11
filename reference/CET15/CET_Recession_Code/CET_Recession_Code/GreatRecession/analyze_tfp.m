%compute TFP implied by model


showtime=100;

%scaled variables
widx=loc(M_.endo_names,'wF');
lidx=loc(M_.endo_names,'lF');
gdpidx=loc(M_.endo_names,'GDPF');
Ridx=loc(M_.endo_names,'RF');
taukidx=loc(M_.endo_names,'taukF');

ukidx=loc(M_.endo_names,'ukF');
kbaridx=loc(M_.endo_names,'kbarF');
muidx=loc(M_.endo_names,'muF');
mupsiidx=loc(M_.endo_names,'mupsiF');
muzidx=loc(M_.endo_names,'muzF');
tfpidx=loc(M_.endo_names,'tfpF');

w=exp(sim_mat(widx,1:showtime));
l=exp(sim_mat(lidx,1:showtime));
gdp=exp(sim_mat(gdpidx,1:showtime));
R=exp(sim_mat(Ridx,1:showtime));
tauk=sim_mat(taukidx,1:showtime);

uk=exp(sim_mat(ukidx,1:showtime));
kbar=[exp(sim_mat(kbaridx,1)), exp(sim_mat(kbaridx,1:showtime-1))];
mu=exp(sim_mat(muidx,1:showtime));
muz=exp(sim_mat(muzidx,1:showtime));
mupsi=exp(M_.params(loc(M_.param_names,'mupsi_SS')));

%parameters
sigmab=M_.params(loc(M_.param_names,'sigmab'));
sigmaa=M_.params(loc(M_.param_names,'sigmaa'));
alfa=M_.params(loc(M_.param_names,'alfa'));

aofukprime=sigmab*sigmaa*uk+sigmab*(1-sigmaa);
aofuk=0.5*sigmab*sigmaa*uk.^2+sigmab*(1-sigmaa)*uk+sigmab*(sigmaa/2-1);

betaF=w.*l./gdp; %labor share
alfaF=(aofukprime.*uk-aofuk).*kbar./(gdp.*mu.*mupsi); %capital share

%set shares to steady state values
alfaF=ones(size(alfaF))*alfaF(1);
betaF=ones(size(betaF))*(1-alfaF(1));

mupsi_lev=cumprod(mupsi);
mupsi_tm1_lev=cumprod([1,mupsi(1:end-1)]);
muz_lev=cumprod(muz);

muz_lev_noshock=cumprod(muz(1)*ones(1,length(muz)));

tfpmeas=log( muz_lev.^(1-alfaF).*mupsi_lev.^( (1-alfaF)*alfa/(1-alfa) )./mupsi_tm1_lev.^alfaF.*...
    gdp.*mu.^alfaF./( (uk.*kbar).^alfaF.*l.^betaF ) );

%no shock TFP
tfpmeas_noshock=log( muz_lev_noshock.^(1-alfaF(1)).*mupsi_lev.^( (1-alfaF(1))*alfa/(1-alfa) )./mupsi_tm1_lev.^alfaF(1).*...
    gdp(1).*mu(1).^alfaF(1)./( (uk(1).*kbar(1)).^alfaF(1).*l(1).^betaF(1) ) );

tfphand=100*(tfpmeas(2:end)-tfpmeas_noshock(2:end));

 
