%model responses, suitably stacked in the same order as in the VAR

%monetary shock
model_resp_mon=100*[GDPAGG_epsR_eps';
    4*piAGG_epsR_eps';
    4*RAGG_epsR_eps';
    ukAGG_epsR_eps';
    lAGG_epsR_eps';
    wAGG_epsR_eps';
    cAGG_epsR_eps' ;
    iAGG_epsR_eps';
    cumsum(pinvestAGG_epsR_eps');
    unempAGG_epsR_eps'*M_.params(loc(M_.param_names,'u'));
    vTotAGG_epsR_eps';
    LAGG_epsR_eps';
    fAGG_epsR_eps'*M_.params(loc(M_.param_names,'f'));
    ];

if options_.bayesian_irf==1,
    model_resp_mon_Mean=100*[oo_.PosteriorIRF.dsge.Mean.GDPAGG_epsR_eps';
        4*oo_.PosteriorIRF.dsge.Mean.piAGG_epsR_eps';
        4*oo_.PosteriorIRF.dsge.Mean.RAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.Mean.ukAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.Mean.lAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.Mean.wAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.Mean.cAGG_epsR_eps' ;
        oo_.PosteriorIRF.dsge.Mean.iAGG_epsR_eps';
        cumsum(oo_.PosteriorIRF.dsge.Mean.pinvestAGG_epsR_eps');
        oo_.PosteriorIRF.dsge.Mean.unempAGG_epsR_eps'*M_.params(loc(M_.param_names,'u'));
        oo_.PosteriorIRF.dsge.Mean.vTotAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.Mean.LAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.Mean.fAGG_epsR_eps'*M_.params(loc(M_.param_names,'f'));
        ];
    model_resp_mon_HPDinf=100*[oo_.PosteriorIRF.dsge.HPDinf.GDPAGG_epsR_eps';
        4*oo_.PosteriorIRF.dsge.HPDinf.piAGG_epsR_eps';
        4*oo_.PosteriorIRF.dsge.HPDinf.RAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.HPDinf.ukAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.HPDinf.lAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.HPDinf.wAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.HPDinf.cAGG_epsR_eps' ;
        oo_.PosteriorIRF.dsge.HPDinf.iAGG_epsR_eps';
        cumsum(oo_.PosteriorIRF.dsge.HPDinf.pinvestAGG_epsR_eps');
        oo_.PosteriorIRF.dsge.HPDinf.unempAGG_epsR_eps'*M_.params(loc(M_.param_names,'u'));
        oo_.PosteriorIRF.dsge.HPDinf.vTotAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.HPDinf.LAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.HPDinf.fAGG_epsR_eps'*M_.params(loc(M_.param_names,'f'));
        ];
    
    
    model_resp_mon_HPDsup=100*[oo_.PosteriorIRF.dsge.HPDsup.GDPAGG_epsR_eps';
        4*oo_.PosteriorIRF.dsge.HPDsup.piAGG_epsR_eps';
        4*oo_.PosteriorIRF.dsge.HPDsup.RAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.HPDsup.ukAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.HPDsup.lAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.HPDsup.wAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.HPDsup.cAGG_epsR_eps' ;
        oo_.PosteriorIRF.dsge.HPDsup.iAGG_epsR_eps';
        cumsum(oo_.PosteriorIRF.dsge.HPDsup.pinvestAGG_epsR_eps');
        oo_.PosteriorIRF.dsge.HPDsup.unempAGG_epsR_eps'*M_.params(loc(M_.param_names,'u'));
        oo_.PosteriorIRF.dsge.HPDsup.vTotAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.HPDsup.LAGG_epsR_eps';
        oo_.PosteriorIRF.dsge.HPDsup.fAGG_epsR_eps'*M_.params(loc(M_.param_names,'f'));
        ];
    
end

%neutral tech. shock
mulev=cumsum(muF_muz_eps);
mupsilev=cumsum(mupsiF_muz_eps);
model_resp_ntech=100*[GDPAGG_muz_eps'+mulev';
    4*piAGG_muz_eps';
    4*RAGG_muz_eps';
    ukAGG_muz_eps';
    lAGG_muz_eps';
    wAGG_muz_eps'+mulev';
    cAGG_muz_eps'+mulev';
    iAGG_muz_eps'+mulev'+mupsilev';
    cumsum(pinvestAGG_muz_eps');
    unempAGG_muz_eps'*M_.params(loc(M_.param_names,'u'));
    vTotAGG_muz_eps';
    LAGG_muz_eps';
    fAGG_muz_eps'*M_.params(loc(M_.param_names,'f'));
    ];


if options_.bayesian_irf==1,
    mulev=cumsum(oo_.PosteriorIRF.dsge.Mean.muF_muz_eps);
    mupsilev=cumsum(oo_.PosteriorIRF.dsge.Mean.mupsiF_muz_eps);
    model_resp_ntech_Mean=100*[oo_.PosteriorIRF.dsge.Mean.GDPAGG_muz_eps'+mulev';
        4*oo_.PosteriorIRF.dsge.Mean.piAGG_muz_eps';
        4*oo_.PosteriorIRF.dsge.Mean.RAGG_muz_eps';
        oo_.PosteriorIRF.dsge.Mean.ukAGG_muz_eps';
        oo_.PosteriorIRF.dsge.Mean.lAGG_muz_eps';
        oo_.PosteriorIRF.dsge.Mean.wAGG_muz_eps'+mulev';
        oo_.PosteriorIRF.dsge.Mean.cAGG_muz_eps'+mulev';
        oo_.PosteriorIRF.dsge.Mean.iAGG_muz_eps'+mulev'+mupsilev';
        cumsum(oo_.PosteriorIRF.dsge.Mean.pinvestAGG_muz_eps');
        oo_.PosteriorIRF.dsge.Mean.unempAGG_muz_eps'*M_.params(loc(M_.param_names,'u'));
        oo_.PosteriorIRF.dsge.Mean.vTotAGG_muz_eps';
        oo_.PosteriorIRF.dsge.Mean.LAGG_muz_eps';
        oo_.PosteriorIRF.dsge.Mean.fAGG_muz_eps'*M_.params(loc(M_.param_names,'f'));
        ];
    
    mulev=cumsum(oo_.PosteriorIRF.dsge.HPDsup.muF_muz_eps);
    mupsilev=cumsum(oo_.PosteriorIRF.dsge.HPDsup.mupsiF_muz_eps);
    model_resp_ntech_HPDsup=100*[oo_.PosteriorIRF.dsge.HPDsup.GDPAGG_muz_eps'+mulev';
        4*oo_.PosteriorIRF.dsge.HPDsup.piAGG_muz_eps';
        4*oo_.PosteriorIRF.dsge.HPDsup.RAGG_muz_eps';
        oo_.PosteriorIRF.dsge.HPDsup.ukAGG_muz_eps';
        oo_.PosteriorIRF.dsge.HPDsup.lAGG_muz_eps';
        oo_.PosteriorIRF.dsge.HPDsup.wAGG_muz_eps'+mulev';
        oo_.PosteriorIRF.dsge.HPDsup.cAGG_muz_eps'+mulev';
        oo_.PosteriorIRF.dsge.HPDsup.iAGG_muz_eps'+mulev'+mupsilev';
        cumsum(oo_.PosteriorIRF.dsge.HPDsup.pinvestAGG_muz_eps');
        oo_.PosteriorIRF.dsge.HPDsup.unempAGG_muz_eps'*M_.params(loc(M_.param_names,'u'));
        oo_.PosteriorIRF.dsge.HPDsup.vTotAGG_muz_eps';
        oo_.PosteriorIRF.dsge.HPDsup.LAGG_muz_eps';
        oo_.PosteriorIRF.dsge.HPDsup.fAGG_muz_eps'*M_.params(loc(M_.param_names,'f'));
        ];
    
    
    mulev=cumsum(oo_.PosteriorIRF.dsge.HPDinf.muF_muz_eps);
    mupsilev=cumsum(oo_.PosteriorIRF.dsge.HPDinf.mupsiF_muz_eps);
    model_resp_ntech_HPDinf=100*[oo_.PosteriorIRF.dsge.HPDinf.GDPAGG_muz_eps'+mulev';
        4*oo_.PosteriorIRF.dsge.HPDinf.piAGG_muz_eps';
        4*oo_.PosteriorIRF.dsge.HPDinf.RAGG_muz_eps';
        oo_.PosteriorIRF.dsge.HPDinf.ukAGG_muz_eps';
        oo_.PosteriorIRF.dsge.HPDinf.lAGG_muz_eps';
        oo_.PosteriorIRF.dsge.HPDinf.wAGG_muz_eps'+mulev';
        oo_.PosteriorIRF.dsge.HPDinf.cAGG_muz_eps'+mulev';
        oo_.PosteriorIRF.dsge.HPDinf.iAGG_muz_eps'+mulev'+mupsilev';
        cumsum(oo_.PosteriorIRF.dsge.HPDinf.pinvestAGG_muz_eps');
        oo_.PosteriorIRF.dsge.HPDinf.unempAGG_muz_eps'*M_.params(loc(M_.param_names,'u'));
        oo_.PosteriorIRF.dsge.HPDinf.vTotAGG_muz_eps';
        oo_.PosteriorIRF.dsge.HPDinf.LAGG_muz_eps';
        oo_.PosteriorIRF.dsge.HPDinf.fAGG_muz_eps'*M_.params(loc(M_.param_names,'f'));
        ];
end

%invest. tech. shock
mulev=cumsum(muF_mupsi_eps);
mupsilev=cumsum(mupsiF_mupsi_eps);
model_resp_itech=100*[GDPAGG_mupsi_eps'+mulev';
    4*piAGG_mupsi_eps';
    4*RAGG_mupsi_eps';
    ukAGG_mupsi_eps';
    lAGG_mupsi_eps';
    wAGG_mupsi_eps'+mulev';
    cAGG_mupsi_eps'+mulev';
    iAGG_mupsi_eps'+mulev'+mupsilev';
    cumsum(pinvestAGG_mupsi_eps');
    unempAGG_mupsi_eps'*M_.params(loc(M_.param_names,'u'));
    vTotAGG_mupsi_eps';
    LAGG_mupsi_eps';
    fAGG_mupsi_eps'*M_.params(loc(M_.param_names,'f'));
    ];

if options_.bayesian_irf==1,
    mulev=cumsum(oo_.PosteriorIRF.dsge.Mean.muF_mupsi_eps);
    mupsilev=cumsum(oo_.PosteriorIRF.dsge.Mean.mupsiF_mupsi_eps);
    model_resp_itech_Mean=100*[oo_.PosteriorIRF.dsge.Mean.GDPAGG_mupsi_eps'+mulev';
        4*oo_.PosteriorIRF.dsge.Mean.piAGG_mupsi_eps';
        4*oo_.PosteriorIRF.dsge.Mean.RAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.Mean.ukAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.Mean.lAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.Mean.wAGG_mupsi_eps'+mulev';
        oo_.PosteriorIRF.dsge.Mean.cAGG_mupsi_eps'+mulev';
        oo_.PosteriorIRF.dsge.Mean.iAGG_mupsi_eps'+mulev'+mupsilev';
        cumsum(oo_.PosteriorIRF.dsge.Mean.pinvestAGG_mupsi_eps');
        oo_.PosteriorIRF.dsge.Mean.unempAGG_mupsi_eps'*M_.params(loc(M_.param_names,'u'));
        oo_.PosteriorIRF.dsge.Mean.vTotAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.Mean.LAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.Mean.fAGG_mupsi_eps'*M_.params(loc(M_.param_names,'f'));
        ];
    
    
    mulev=cumsum(oo_.PosteriorIRF.dsge.HPDinf.muF_mupsi_eps);
    mupsilev=cumsum(oo_.PosteriorIRF.dsge.HPDinf.mupsiF_mupsi_eps);
    model_resp_itech_HPDinf=100*[oo_.PosteriorIRF.dsge.HPDinf.GDPAGG_mupsi_eps'+mulev';
        4*oo_.PosteriorIRF.dsge.HPDinf.piAGG_mupsi_eps';
        4*oo_.PosteriorIRF.dsge.HPDinf.RAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.HPDinf.ukAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.HPDinf.lAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.HPDinf.wAGG_mupsi_eps'+mulev';
        oo_.PosteriorIRF.dsge.HPDinf.cAGG_mupsi_eps'+mulev';
        oo_.PosteriorIRF.dsge.HPDinf.iAGG_mupsi_eps'+mulev'+mupsilev';
        cumsum(oo_.PosteriorIRF.dsge.HPDinf.pinvestAGG_mupsi_eps');
        oo_.PosteriorIRF.dsge.HPDinf.unempAGG_mupsi_eps'*M_.params(loc(M_.param_names,'u'));
        oo_.PosteriorIRF.dsge.HPDinf.vTotAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.HPDinf.LAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.HPDinf.fAGG_mupsi_eps'*M_.params(loc(M_.param_names,'f'));
        ];
    
    mulev=cumsum(oo_.PosteriorIRF.dsge.HPDsup.muF_mupsi_eps);
    mupsilev=cumsum(oo_.PosteriorIRF.dsge.HPDsup.mupsiF_mupsi_eps);
    model_resp_itech_HPDsup=100*[oo_.PosteriorIRF.dsge.HPDsup.GDPAGG_mupsi_eps'+mulev';
        4*oo_.PosteriorIRF.dsge.HPDsup.piAGG_mupsi_eps';
        4*oo_.PosteriorIRF.dsge.HPDsup.RAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.HPDsup.ukAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.HPDsup.lAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.HPDsup.wAGG_mupsi_eps'+mulev';
        oo_.PosteriorIRF.dsge.HPDsup.cAGG_mupsi_eps'+mulev';
        oo_.PosteriorIRF.dsge.HPDsup.iAGG_mupsi_eps'+mulev'+mupsilev';
        cumsum(oo_.PosteriorIRF.dsge.HPDsup.pinvestAGG_mupsi_eps');
        oo_.PosteriorIRF.dsge.HPDsup.unempAGG_mupsi_eps'*M_.params(loc(M_.param_names,'u'));
        oo_.PosteriorIRF.dsge.HPDsup.vTotAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.HPDsup.LAGG_mupsi_eps';
        oo_.PosteriorIRF.dsge.HPDsup.fAGG_mupsi_eps'*M_.params(loc(M_.param_names,'f'));
        ];
    
    
end
