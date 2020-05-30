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
    fAGG_epsR_eps'*M_.params(loc(M_.param_names,'f'));
    ];

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
    fAGG_muz_eps'*M_.params(loc(M_.param_names,'f'));
    ];

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
    fAGG_mupsi_eps'*M_.params(loc(M_.param_names,'f'));
    ];
