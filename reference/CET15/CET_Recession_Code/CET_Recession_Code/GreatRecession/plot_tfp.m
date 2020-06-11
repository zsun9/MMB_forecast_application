%tfp data from various sources
%sample is Q2 1947 to Q2 2013

%all data is in natural logs


% Fernald - raw
% Fernald - util adjusted
% Fernald - own, unemp. Proxy for util (Solow)
%     BLS - Manufacturing (interpolated)
%     BLS - Private Business (interpolated)
%     BLS - Private Nonfarm Business (interpolated)
%     BLS - Total (interpolated)
%     PENN world tables (interpolated)

sers=[0.0003	-0.0019	NaN	NaN	NaN	NaN	NaN	NaN
    -0.008	-0.0123	NaN	NaN	NaN	NaN	NaN	NaN
    -0.0001	-0.0046	NaN	NaN	NaN	NaN	NaN	NaN
    0.0238	0.0234	NaN	NaN	3.8042	3.9001	NaN	NaN
    0.0436	0.0529	0.0198	NaN	3.7958	3.8967	NaN	NaN
    0.0346	0.0584	0.0112	NaN	3.7881	3.8937	NaN	NaN
    0.036	0.0763	0.0125	NaN	3.7824	3.8922	NaN	NaN
    0.0208	0.075	0.0004	NaN	3.7808	3.8936	NaN	NaN
    0.0196	0.0805	0.0033	NaN	3.786	3.8999	NaN	NaN
    0.0368	0.0941	0.0232	NaN	3.7987	3.9115	NaN	NaN
    0.0299	0.0735	0.0174	NaN	3.8178	3.9276	NaN	NaN
    0.0722	0.0955	0.0576	NaN	3.84	3.9463	NaN	4.112174105
    0.0925	0.094	0.075	NaN	3.8603	3.9638	NaN	4.119231742
    0.1127	0.0978	0.0915	NaN	3.8754	3.9779	NaN	4.126131373
    0.114	0.0924	0.0915	NaN	3.8843	3.9874	NaN	4.132556981
    0.1083	0.0899	0.0833	NaN	3.8877	3.9924	NaN	4.138034547
    0.11	0.1016	0.0836	NaN	3.8884	3.9942	NaN	4.141932041
    0.1287	0.1309	0.1026	NaN	3.8886	3.9939	NaN	4.14426446
    0.1272	0.1348	0.1018	NaN	3.8899	3.9932	NaN	4.14569383
    0.1274	0.1323	0.1009	NaN	3.8937	3.9933	NaN	4.1475292
    0.1331	0.1289	0.1063	NaN	3.9003	3.9959	NaN	4.151726647
    0.1348	0.1205	0.1087	NaN	3.9094	4.0012	NaN	4.158794129
    0.1528	0.1337	0.1255	NaN	3.9197	4.0084	NaN	4.167791489
    0.1654	0.1514	0.1377	NaN	3.9289	4.0153	NaN	4.176330449
    0.1689	0.1707	0.1409	NaN	3.9339	4.0185	NaN	4.180574614
    0.1619	0.1858	0.1342	NaN	3.9337	4.0169	NaN	4.179111302
    0.1473	0.1925	0.1228	NaN	3.9294	4.0117	NaN	4.172951543
    0.1458	0.2043	0.1264	NaN	3.9243	4.0062	NaN	4.165530083
    0.1529	0.2126	0.1351	NaN	3.9241	4.0059	NaN	4.162705376
    0.1638	0.213	0.1466	NaN	3.9311	4.0132	NaN	4.167188741
    0.1793	0.2111	0.1599	NaN	3.9447	4.0274	NaN	4.178544358
    0.1969	0.2105	0.1753	NaN	3.9613	4.0444	NaN	4.193189267
    0.2087	0.2092	0.1861	NaN	3.9739	4.0569	NaN	4.20439337
    0.2094	0.2037	0.1857	NaN	3.9792	4.0611	NaN	4.208571575
    0.2042	0.1987	0.1809	NaN	3.9767	4.0569	NaN	4.205283794
    0.1992	0.1968	0.1752	NaN	3.9694	4.0475	NaN	4.197234945
    0.2033	0.2041	0.18	NaN	3.9637	4.0396	NaN	4.190274951
    0.1998	0.2022	0.1762	NaN	3.9628	4.037	NaN	4.187568651
    0.2164	0.22	0.1928	NaN	3.9675	4.0404	NaN	4.189595799
    0.2166	0.2236	0.1923	NaN	3.9755	4.0474	NaN	4.194151069
    0.2128	0.2271	0.1891	NaN	3.9818	4.0529	NaN	4.196344047
    0.216	0.2414	0.1926	NaN	3.9839	4.0543	NaN	4.193927092
    0.2152	0.2522	0.1941	NaN	3.9819	4.0514	NaN	4.187295335
    0.1991	0.2431	0.1827	NaN	3.9785	4.0471	NaN	4.179486674
    0.2061	0.248	0.1933	NaN	3.9787	4.0467	NaN	4.176181779
    0.2239	0.2536	0.2108	NaN	3.9851	4.0527	NaN	4.180147941
    0.2372	0.2473	0.2211	NaN	3.9977	4.0651	NaN	4.191239065
    0.2506	0.2399	0.2324	NaN	4.0135	4.0812	NaN	4.20639568
    0.262	0.2369	0.2414	NaN	4.0273	4.0952	NaN	4.219644929
    0.2565	0.228	0.2365	NaN	4.0358	4.1041	NaN	4.227420859
    0.2573	0.2377	0.2383	NaN	4.0383	4.1068	NaN	4.228564418
    0.2793	0.2773	0.2587	NaN	4.0364	4.1047	NaN	4.224323455
    0.2619	0.2792	0.2416	NaN	4.0338	4.1014	NaN	4.218352721
    0.2588	0.2906	0.2395	NaN	4.0333	4.0993	NaN	4.213331837
    0.2502	0.2874	0.2336	NaN	4.0361	4.1001	NaN	4.210965295
    0.2548	0.2876	0.2398	NaN	4.0423	4.1042	NaN	4.211982457
    0.281	0.3039	0.2667	NaN	4.0508	4.111	NaN	4.216137556
    0.29	0.3024	0.275	NaN	4.0606	4.1197	NaN	4.222837743
    0.3017	0.3081	0.2847	NaN	4.0706	4.1295	NaN	4.231143084
    0.3058	0.3126	0.2868	NaN	4.0802	4.1393	NaN	4.239766567
    0.3093	0.3219	0.2899	NaN	4.0888	4.1479	NaN	4.247074092
    0.3186	0.3393	0.2996	NaN	4.096	4.1549	NaN	4.252246963
    0.3281	0.3554	0.3087	NaN	4.1023	4.1606	NaN	4.255281882
    0.3304	0.3606	0.312	NaN	4.1084	4.1657	NaN	4.25699095
    0.3384	0.3676	0.3197	NaN	4.1156	4.172	NaN	4.259001668
    0.3534	0.3791	0.334	NaN	4.1243	4.1801	NaN	4.262260413
    0.3549	0.3768	0.3359	NaN	4.1345	4.1901	NaN	4.267032432
    0.3654	0.3847	0.346	NaN	4.1454	4.2009	NaN	4.27290185
    0.3698	0.3878	0.3494	NaN	4.1555	4.2107	NaN	4.278771663
    0.3779	0.395	0.3567	NaN	4.1641	4.2187	NaN	4.284105167
    0.3761	0.3912	0.355	NaN	4.1713	4.2248	NaN	4.288925952
    0.3926	0.4036	0.3711	NaN	4.178	4.2302	NaN	4.293817906
    0.3936	0.3991	0.3714	NaN	4.1857	4.2367	NaN	4.299925213
    0.4082	0.408	0.385	NaN	4.195	4.245	NaN	4.307486566
    0.422	0.4179	0.3976	NaN	4.2054	4.2548	NaN	4.31583516
    0.4369	0.4322	0.4118	NaN	4.2153	4.2643	NaN	4.323398699
    0.4305	0.4287	0.4051	NaN	4.222	4.2705	NaN	4.327699391
    0.4274	0.4312	0.402	NaN	4.2244	4.2723	NaN	4.327723874
    0.4297	0.4401	0.4039	NaN	4.223	4.2702	NaN	4.323923216
    0.4307	0.4472	0.4053	NaN	4.22	4.2664	NaN	4.318212911
    0.4348	0.4556	0.4094	NaN	4.219	4.265	NaN	4.313972887
    0.4351	0.4579	0.4097	NaN	4.2219	4.2678	NaN	4.313108983
    0.4375	0.4602	0.4125	NaN	4.2289	4.275	NaN	4.316052958
    0.4531	0.4737	0.4273	NaN	4.2383	4.2847	NaN	4.32176249
    0.4612	0.4784	0.4351	NaN	4.2466	4.2932	NaN	4.327721169
    0.4641	0.4773	0.4377	NaN	4.2518	4.298	NaN	4.332095634
    0.4618	0.4713	0.435	NaN	4.2528	4.2982	NaN	4.333735568
    0.4606	0.4681	0.4339	NaN	4.2503	4.2944	NaN	4.3321737
    0.4581	0.4661	0.4314	NaN	4.2457	4.2885	NaN	4.327625804
    0.4577	0.4693	0.4316	NaN	4.2408	4.2821	NaN	4.32082229
    0.4508	0.469	0.4247	NaN	4.2369	4.2769	NaN	4.313008204
    0.4453	0.4714	0.421	NaN	4.2353	4.2742	NaN	4.305943228
    0.4492	0.4821	0.4267	NaN	4.237	4.2751	NaN	4.301901678
    0.4605	0.4975	0.4393	NaN	4.2423	4.2798	NaN	4.301930612
    0.45	0.487	0.4307	NaN	4.2507	4.2877	NaN	4.305849825
    0.4731	0.5061	0.4541	NaN	4.2606	4.2974	NaN	4.31225185
    0.474	0.5007	0.455	NaN	4.2696	4.3065	NaN	4.31850196
    0.4826	0.5023	0.464	NaN	4.2768	4.3138	NaN	4.323192823
    0.482	0.4954	0.463	NaN	4.2822	4.3193	NaN	4.326144507
    0.4904	0.4989	0.4711	NaN	4.2871	4.3244	NaN	4.328404473
    0.5062	0.5104	0.4865	NaN	4.2942	4.3316	NaN	4.332247579
    0.5125	0.5122	0.4925	NaN	4.3042	4.3416	NaN	4.338463729
    0.5288	0.5233	0.5082	NaN	4.3162	4.3534	NaN	4.346357866
    0.5439	0.5327	0.5216	NaN	4.3272	4.3645	NaN	4.353749979
    0.5423	0.527	0.5201	NaN	4.3326	4.3704	NaN	4.356975099
    0.5309	0.5155	0.5084	NaN	4.3302	4.3689	NaN	4.354254618
    0.5318	0.5221	0.5093	NaN	4.3206	4.3603	NaN	4.345696296
    0.5124	0.5142	0.4908	NaN	4.3066	4.3471	NaN	4.333294251
    0.5062	0.5241	0.4849	NaN	4.2938	4.3341	NaN	4.320928969
    0.4947	0.5287	0.4747	NaN	4.2856	4.3245	NaN	4.311250734
    0.4889	0.535	0.4721	NaN	4.2839	4.3203	NaN	4.305679631
    0.4907	0.5418	0.4796	NaN	4.2881	4.3219	NaN	4.304405547
    0.5037	0.5526	0.4947	NaN	4.2963	4.328	NaN	4.306388168
    0.5178	0.5591	0.5074	NaN	4.3064	4.3374	NaN	4.310587819
    0.5214	0.5531	0.5103	NaN	4.317	4.3487	NaN	4.315965463
    0.5374	0.5612	0.5241	NaN	4.3269	4.36	NaN	4.321482703
    0.5418	0.5614	0.5282	NaN	4.3353	4.3696	NaN	4.326101778
    0.543	0.5621	0.5297	NaN	4.3418	4.3764	NaN	4.329294126
    0.545	0.5657	0.5321	NaN	4.3465	4.3805	NaN	4.331040383
    0.5493	0.5713	0.5353	NaN	4.3497	4.3825	NaN	4.331830382
    0.5589	0.58	0.5435	NaN	4.3525	4.3844	NaN	4.332663156
    0.5714	0.5887	0.5553	NaN	4.3553	4.3872	NaN	4.33416241
    0.5635	0.5747	0.5467	NaN	4.3586	4.3911	NaN	4.336576519
    0.5595	0.5638	0.5414	NaN	4.3623	4.3959	NaN	4.339778533
    0.5788	0.5775	0.5595	NaN	4.3661	4.4003	NaN	4.343266175
    0.5778	0.5741	0.5585	NaN	4.3695	4.4036	NaN	4.346401164
    0.5785	0.5764	0.559	NaN	4.3718	4.4048	NaN	4.34840922
    0.5766	0.5797	0.5571	NaN	4.3718	4.4033	NaN	4.348380061
    0.5651	0.5761	0.5449	NaN	4.3684	4.3987	NaN	4.345267403
    0.5612	0.5806	0.5417	NaN	4.3616	4.3914	NaN	4.339107402
    0.5575	0.5835	0.5383	NaN	4.3524	4.3825	NaN	4.331018649
    0.5567	0.5856	0.5384	NaN	4.3433	4.3742	NaN	4.323202172
    0.5355	0.563	0.5205	NaN	4.338	4.3692	NaN	4.318941439
    0.5363	0.5585	0.5226	NaN	4.3378	4.3685	NaN	4.319530938
    0.5515	0.5667	0.5368	NaN	4.3419	4.3712	NaN	4.32427618
    0.562	0.5716	0.5473	NaN	4.3472	4.3742	NaN	4.330493695
    0.554	0.5624	0.5393	NaN	4.3484	4.3727	NaN	4.33351104
    0.5643	0.5776	0.5496	NaN	4.3429	4.3647	NaN	4.331099065
    0.5449	0.5684	0.5329	NaN	4.3314	4.351	NaN	4.323471921
    0.5324	0.5686	0.5225	NaN	4.3172	4.3356	NaN	4.313287057
    0.5308	0.5773	0.5231	NaN	4.3064	4.325	NaN	4.305645219
    0.5249	0.5756	0.519	NaN	4.3028	4.323	NaN	4.303559306
    0.5266	0.5727	0.5235	NaN	4.3073	4.3303	NaN	4.307954373
    0.533	0.5664	0.5289	NaN	4.3183	4.3444	NaN	4.317667626
    0.5482	0.5652	0.543	NaN	4.3316	4.3599	NaN	4.329448425
    0.552	0.553	0.5441	NaN	4.344	4.3732	NaN	4.340979849
    0.5636	0.5538	0.5525	NaN	4.354	4.3823	NaN	4.350878693
    0.5763	0.5634	0.563	NaN	4.3608	4.3871	NaN	4.358695468
    0.5846	0.5762	0.5695	NaN	4.3655	4.389	NaN	4.364914403
    0.5856	0.5866	0.5705	NaN	4.3687	4.3894	NaN	4.369948199
    0.5848	0.5963	0.5693	NaN	4.3711	4.3895	NaN	4.374138029
    0.5889	0.6089	0.5731	NaN	4.3736	4.3902	NaN	4.377753541
    0.5866	0.6113	0.5712	NaN	4.3768	4.3922	NaN	4.380992851
    0.5971	0.6234	0.5813	NaN	4.381	4.3957	NaN	4.383931475
    0.5971	0.6233	0.5805	NaN	4.386	4.4004	NaN	4.386522326
    0.6039	0.63	0.5873	NaN	4.391	4.4053	NaN	4.388595714
    0.6042	0.6309	0.5884	NaN	4.3948	4.4088	NaN	4.389859347
    0.6062	0.6336	0.5897	NaN	4.397	4.4103	NaN	4.390314949
    0.6034	0.6304	0.5862	NaN	4.3975	4.4099	NaN	4.390258264
    0.6001	0.6249	0.5822	4.3277	4.3971	4.4086	4.4375	4.390279055
    0.6117	0.6324	0.5928	4.3353	4.3973	4.4083	4.4372	4.391261101
    0.6155	0.6316	0.5956	4.3426	4.3986	4.4098	4.4369	4.39363352
    0.6193	0.6317	0.5987	4.3495	4.4012	4.4132	4.4368	4.397370768
    0.624	0.6353	0.6031	4.3552	4.4043	4.4174	4.4369	4.401992639
    0.6245	0.6375	0.6029	4.3591	4.4067	4.4206	4.4375	4.406564263
    0.627	0.6437	0.6054	4.3609	4.4076	4.4219	4.4387	4.410513763
    0.6289	0.6493	0.6066	4.3605	4.4073	4.4213	4.4408	4.413632251
    0.6266	0.6489	0.604	4.3585	4.4066	4.4197	4.4443	4.416073829
    0.6189	0.6407	0.5962	4.3556	4.4072	4.4191	4.4493	4.418355591
    0.6188	0.6382	0.5961	4.3525	4.4097	4.4204	4.4556	4.420631066
    0.6156	0.6324	0.5936	4.3497	4.4136	4.4232	4.4619	4.42269022
    0.623	0.6389	0.6007	4.3476	4.4174	4.4262	4.4664	4.423959457
    0.6285	0.6458	0.6062	4.3464	4.4185	4.427	4.4663	4.423501616
    0.6254	0.6461	0.6044	4.3461	4.4161	4.4246	4.4607	4.4211746
    0.6152	0.6397	0.5956	4.3462	4.4107	4.4196	4.4507	4.417631371
    0.6107	0.6374	0.5928	4.3461	4.4047	4.414	4.4389	4.414319955
    0.6192	0.6454	0.6019	4.3447	4.402	4.4113	4.43	4.413483438
    0.6222	0.6453	0.6052	4.3418	4.4045	4.4134	4.4264	4.416141508
    0.6224	0.6412	0.6061	4.338	4.4119	4.42	4.4285	4.42209045
    0.6459	0.6611	0.6306	4.3344	4.4221	4.4292	4.4345	4.42990315
    0.6505	0.6643	0.6358	4.3333	4.4308	4.4372	4.4404	4.436929095
    0.6517	0.6667	0.6371	4.3356	4.4357	4.442	4.4438	4.441703263
    0.6536	0.6713	0.6383	4.3414	4.4363	4.443	4.4441	4.443946128
    0.6408	0.6608	0.6245	4.3496	4.434	4.4413	4.4421	4.444563655
    0.6414	0.6619	0.6251	4.3583	4.4321	4.4397	4.4402	4.445647303
    0.6364	0.6547	0.6191	4.3662	4.4322	4.4399	4.4399	4.448305036
    0.6489	0.6631	0.6309	4.3728	4.4348	4.4422	4.4417	4.452661321
    0.6448	0.6546	0.6268	4.3784	4.4388	4.4458	4.445	4.457857126
    0.6474	0.6547	0.628	4.384	4.4416	4.4486	4.4482	4.462049928
    0.643	0.6509	0.6229	4.39	4.442	4.4496	4.4504	4.464303489
    0.6527	0.6646	0.6312	4.3963	4.4401	4.4488	4.4516	4.464587865
    0.647	0.6653	0.6252	4.402	4.4371	4.4471	4.4523	4.463779401
    0.6456	0.6711	0.6245	4.4056	4.4356	4.4466	4.4537	4.463660732
    0.6493	0.6807	0.6282	4.4067	4.437	4.4481	4.4565	4.465271632
    0.652	0.6867	0.6306	4.4057	4.4414	4.4519	4.4606	4.468909015
    0.6596	0.6947	0.6379	4.4041	4.4477	4.4569	4.4653	4.474126931
    0.6694	0.7021	0.6477	4.4043	4.4536	4.4614	4.4696	4.479736571
    0.6734	0.7019	0.6509	4.4076	4.4579	4.4644	4.4725	4.484986086
    0.6759	0.6998	0.6534	4.414	4.46	4.4657	4.4741	4.489560587
    0.6732	0.6929	0.6504	4.4228	4.4607	4.4659	4.4747	4.493582145
    0.6807	0.6974	0.6571	4.4317	4.4614	4.4664	4.4752	4.497609791
    0.6899	0.7054	0.6659	4.4392	4.4631	4.4682	4.4763	4.501997311
    0.6927	0.7087	0.6681	4.4445	4.4661	4.4714	4.4783	4.506893241
    0.6973	0.715	0.6723	4.4473	4.4704	4.4758	4.4812	4.512240871
    0.7016	0.7213	0.6759	4.4479	4.475	4.4804	4.4848	4.517778245
    0.7108	0.7317	0.6855	4.4472	4.4796	4.4847	4.4887	4.523377855
    0.7107	0.731	0.685	4.4463	4.4839	4.4886	4.4927	4.529046647
    0.7219	0.7396	0.6959	4.4472	4.4882	4.4922	4.4963	4.534926017
    0.7179	0.7312	0.6919	4.4522	4.4928	4.4963	4.4992	4.541291811
    0.7207	0.7293	0.6944	4.4619	4.4979	4.5008	4.5014	4.548053623
    0.7319	0.737	0.7053	4.4749	4.5032	4.5058	4.5028	4.554754792
    0.7361	0.7401	0.7091	4.4882	4.5083	4.5107	4.504	4.560572403
    0.7454	0.7513	0.7181	4.497	4.5122	4.5143	4.5056	4.564317288
    0.742	0.7523	0.715	4.499	4.5146	4.5165	4.5078	4.565550571
    0.7447	0.7604	0.7174	4.4946	4.5157	4.5174	4.5107	4.56458367
    0.7412	0.7618	0.7149	4.4868	4.5164	4.5179	4.514	4.5624783
    0.7453	0.7694	0.7196	4.4814	4.5181	4.5195	4.5171	4.561046465
    0.7411	0.7669	0.7167	4.4814	4.5214	4.5229	4.5197	4.561307653
    0.7434	0.7699	0.7213	4.488	4.5267	4.5282	4.5219	4.563488831
    0.7601	0.7868	0.7387	4.4995	4.5334	4.5352	4.524	4.567024447
    0.7597	0.7869	0.7386	4.512	4.5407	4.5425	4.5265	4.57055643
    0.762	0.7899	0.7406	4.5233	4.5479	4.5495	4.5301	4.57333065
    0.762	0.7902	0.7413	4.5324	4.5547	4.5558	4.5347	4.575196922
    0.7717	0.7989	0.7509	4.5398	4.5611	4.5617	4.5404	4.576608999
    0.7869	0.8121	0.7669	4.5477	4.5675	4.5676	4.5467	4.578624582
    0.801	0.8233	0.7809	4.5571	4.5741	4.5738	4.5536	4.581786182
    0.8063	0.8262	0.7852	4.5679	4.5808	4.5803	4.5607	4.58612113
    0.8094	0.8285	0.7879	4.579	4.5872	4.5867	4.5682	4.59114157
    0.8154	0.8357	0.7936	4.5882	4.593	4.5925	4.576	4.595844463
    0.8218	0.8448	0.7992	4.5944	4.5976	4.5973	4.5841	4.599607833
    0.821	0.8469	0.7985	4.5978	4.6011	4.601	4.5921	4.60219077
    0.8264	0.8535	0.8035	4.5995	4.6034	4.6035	4.5992	4.603733425
    0.827	0.8527	0.8033	4.602	4.6049	4.605	4.6046	4.604757017
    0.8337	0.8553	0.8096	4.6064	4.6058	4.6059	4.6079	4.605628706
    0.8369	0.8531	0.8128	4.6128	4.6065	4.6063	4.609	4.606561596
    0.8472	0.8581	0.822	4.6204	4.6073	4.6068	4.6086	4.607614735
    0.8431	0.85	0.8175	4.627	4.6085	4.6077	4.6074	4.608693113
    0.8373	0.8418	0.8116	4.6314	4.6101	4.6093	4.6061	4.609717544
    0.8396	0.8428	0.8132	4.6336	4.612	4.6113	4.6048	4.610624657
    0.834	0.8356	0.8079	4.6343	4.6136	4.613	4.6033	4.611366906
    0.8334	0.8329	0.8074	4.6351	4.6141	4.6136	4.6012	4.611912562
    0.8299	0.8273	0.8046	4.6368	4.6131	4.6125	4.598	4.612092998
    0.8294	0.8266	0.8045	4.6389	4.6104	4.6097	4.5937	4.61160268
    0.8192	0.8205	0.795	4.6397	4.6065	4.6054	4.5882	4.609999174
    0.8212	0.832	0.7981	4.6367	4.6021	4.6004	4.5819	4.606703143
    0.8177	0.8429	0.7972	4.6293	4.598	4.5955	4.5753	4.601821852
    0.8014	0.8429	0.7842	4.6186	4.5949	4.5915	4.5691	4.596149164
    0.7942	0.8498	0.7824	4.6081	4.5937	4.5896	4.5645	4.591165544
    0.8025	0.8656	0.7947	4.6031	4.5953	4.5906	4.5628	4.589038057
    0.8141	0.876	0.8075	4.6063	4.5998	4.5949	4.5646	4.59078708
    0.8279	0.8804	0.8226	4.6174	4.6068	4.6019	4.5697	4.5962863
    0.8279	0.8656	0.8221	4.6336	4.6148	4.6103	4.577	4.604262717
    0.8344	0.8566	0.8277	4.6492	4.6218	4.618	4.5846	4.612296643
    0.8434	0.8537	0.8364	4.6607	4.6267	4.6237	4.5914	4.618796562
    0.8451	0.8492	0.8381	4.6663	4.6291	4.627	4.5968	4.622999133
    0.8434	0.8468	0.8342	4.6664	4.6297	4.6283	4.6007	4.624969188
    0.8461	0.8523	0.8369	4.663	4.6297	4.6291	4.6038	4.625599734
    0.8443	0.8538	0.8351	4.658	4.6301	4.63	4.6064	4.625560526
    0.8524	0.8636	0.842	4.6525	4.6315	4.6317	4.6088	4.625298066
    0.8587	0.8692	0.8466	NaN	4.6339	4.6341	NaN	NaN
    0.8528	0.8612	0.8403	NaN	4.637	4.6371	NaN	NaN
    0.8569	0.8636	0.8436	NaN	4.6403	4.6403	NaN	NaN
    0.859	0.8658	0.8448	NaN	4.6437	4.6436	NaN	NaN
    0.8604	0.8695	0.8458	NaN	NaN	NaN	NaN	NaN
    0.8611	0.8741	0.8461	NaN	NaN	NaN	NaN	NaN];


tfptime=1947.25:0.25:2013.25;

normobs=2007;
trendfrom=2001;
trenduntil=2008.25;
showfrom=2001;


idxnorm=find(tfptime==normobs);
idxshow=find(tfptime==showfrom);
idxtrendfrom=find(tfptime==trendfrom);
idxtrenduntil=find(tfptime==trenduntil);
obs=length(sers(:,1));

%normalize
sers=log(100*exp(sers)./repmat(exp(sers(idxnorm,:)),size(sers,1),1));


% 1. Fernald - raw
% 2. Fernald - util adjusted
% 3. Fernald - own, unemp. Proxy for util (Solow)
% 4.     BLS - Manufacturing (interpolated)
% 5.     BLS - Private Business (interpolated)
% 6.     BLS - Private Nonfarm Business (interpolated)
% 7.     BLS - Total (interpolated)
% 8.    PENN world tables (interpolated)


Fernaldraw=sers(:,1);
Fernaldrawtrend=Fernaldraw(idxtrendfrom:idxtrenduntil)-detrend(Fernaldraw(idxtrendfrom:idxtrenduntil),'linear');
Fernaldrawtrend=[NaN*ones(idxtrendfrom-1,1);Fernaldrawtrend;NaN*ones(obs-idxtrenduntil,1)];
Fernaldrawtrendforecast=cumsum([Fernaldrawtrend(idxtrenduntil);diff(Fernaldrawtrend(idxtrendfrom:idxtrendfrom+obs-idxtrenduntil))]);
Fernaldrawtrendforecast=[Fernaldrawtrend(1:idxtrenduntil);Fernaldrawtrendforecast(2:end)];
Fernaldrawdev=Fernaldraw-Fernaldrawtrendforecast;

Fernaldutil=sers(:,2);
Fernaldutiltrend=Fernaldutil(idxtrendfrom:idxtrenduntil)-detrend(Fernaldutil(idxtrendfrom:idxtrenduntil),'linear');
Fernaldutiltrend=[NaN*ones(idxtrendfrom-1,1);Fernaldutiltrend;NaN*ones(obs-idxtrenduntil,1)];
Fernaldutiltrendforecast=cumsum([Fernaldutiltrend(idxtrenduntil);diff(Fernaldutiltrend(idxtrendfrom:idxtrendfrom+obs-idxtrenduntil))]);
Fernaldutiltrendforecast=[Fernaldutiltrend(1:idxtrenduntil);Fernaldutiltrendforecast(2:end)];
Fernaldutildev=Fernaldutil-Fernaldutiltrendforecast;

FernaldutilSolow=sers(:,3);
FernaldutilSolowtrend=FernaldutilSolow(idxtrendfrom:idxtrenduntil)-detrend(FernaldutilSolow(idxtrendfrom:idxtrenduntil),'linear');
FernaldutilSolowtrend=[NaN*ones(idxtrendfrom-1,1);FernaldutilSolowtrend;NaN*ones(obs-idxtrenduntil,1)];
FernaldutilSolowtrendforecast=cumsum([FernaldutilSolowtrend(idxtrenduntil);diff(FernaldutilSolowtrend(idxtrendfrom:idxtrendfrom+obs-idxtrenduntil))]);
FernaldutilSolowtrendforecast=[FernaldutilSolowtrend(1:idxtrenduntil);FernaldutilSolowtrendforecast(2:end)];
FernaldutilSolowdev=FernaldutilSolow-FernaldutilSolowtrendforecast;

Penn=sers(:,8);
Penntrend=Penn(idxtrendfrom:idxtrenduntil)-detrend(Penn(idxtrendfrom:idxtrenduntil),'linear');
Penntrend=[NaN*ones(idxtrendfrom-1,1);Penntrend;NaN*ones(obs-idxtrenduntil,1)];
Penntrendforecast=cumsum([Penntrend(idxtrenduntil);diff(Penntrend(idxtrendfrom:idxtrendfrom+obs-idxtrenduntil))]);
Penntrendforecast=[Penntrend(1:idxtrenduntil);Penntrendforecast(2:end)];
Penndev=Penn-Penntrendforecast;



BLSmanuf=sers(:,4);
BLSmanuftrend=BLSmanuf(idxtrendfrom:idxtrenduntil)-detrend(BLSmanuf(idxtrendfrom:idxtrenduntil),'linear');
BLSmanuftrend=[NaN*ones(idxtrendfrom-1,1);BLSmanuftrend;NaN*ones(obs-idxtrenduntil,1)];
BLSmanuftrendforecast=cumsum([BLSmanuftrend(idxtrenduntil);diff(BLSmanuftrend(idxtrendfrom:idxtrendfrom+obs-idxtrenduntil))]);
BLSmanuftrendforecast=[BLSmanuftrend(1:idxtrenduntil);BLSmanuftrendforecast(2:end)];
BLSmanufdev=BLSmanuf-BLSmanuftrendforecast;

BLSpriv=sers(:,5);
BLSprivtrend=BLSpriv(idxtrendfrom:idxtrenduntil)-detrend(BLSpriv(idxtrendfrom:idxtrenduntil),'linear');
BLSprivtrend=[NaN*ones(idxtrendfrom-1,1);BLSprivtrend;NaN*ones(obs-idxtrenduntil,1)];
BLSprivtrendforecast=cumsum([BLSprivtrend(idxtrenduntil);diff(BLSprivtrend(idxtrendfrom:idxtrendfrom+obs-idxtrenduntil))]);
BLSprivtrendforecast=[BLSprivtrend(1:idxtrenduntil);BLSprivtrendforecast(2:end)];
BLSprivdev=BLSpriv-BLSprivtrendforecast;


BLSnonfarm=sers(:,6);
BLSnonfarmtrend=BLSnonfarm(idxtrendfrom:idxtrenduntil)-detrend(BLSnonfarm(idxtrendfrom:idxtrenduntil),'linear');
BLSnonfarmtrend=[NaN*ones(idxtrendfrom-1,1);BLSnonfarmtrend;NaN*ones(obs-idxtrenduntil,1)];
BLSnonfarmtrendforecast=cumsum([BLSnonfarmtrend(idxtrenduntil);diff(BLSnonfarmtrend(idxtrendfrom:idxtrendfrom+obs-idxtrenduntil))]);
BLSnonfarmtrendforecast=[BLSnonfarmtrend(1:idxtrenduntil);BLSnonfarmtrendforecast(2:end)];
BLSnonfarmdev=BLSnonfarm-BLSnonfarmtrendforecast;

BLStotal=sers(:,7);
BLStotaltrend=BLStotal(idxtrendfrom:idxtrenduntil)-detrend(BLStotal(idxtrendfrom:idxtrenduntil),'linear');
BLStotaltrend=[NaN*ones(idxtrendfrom-1,1);BLStotaltrend;NaN*ones(obs-idxtrenduntil,1)];
BLStotaltrendforecast=cumsum([BLStotaltrend(idxtrenduntil);diff(BLStotaltrend(idxtrendfrom:idxtrendfrom+obs-idxtrenduntil))]);
BLStotaltrendforecast=[BLStotaltrend(1:idxtrenduntil);BLStotaltrendforecast(2:end)];
BLStotaldev=BLStotal-BLStotaltrendforecast;



%%%BLS
show_all=1; %NBER recessions full 2007-2007 dates
figure;
subplot(2,2,1)

plot(tfptime(idxshow:end-6),BLSpriv(idxshow:end-6),'b-','LineWidth',3);hold on;
plot(tfptime(idxshow:end-6),BLSmanuf(idxshow:end-6),'g-','LineWidth',3);hold on;
plot(tfptime(idxshow:end-6),BLStotal(idxshow:end-6),'r-','LineWidth',3);hold on;


plot(tfptime(idxshow:end-6),BLSprivtrend(idxshow:end-6),'b--','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end-6),BLSmanuftrend(idxshow:end-6),'g--','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end-6),BLStotaltrend(idxshow:end-6),'r--','LineWidth',1.5);hold on;

plot(tfptime(idxshow:end-6),BLSprivtrendforecast(idxshow:end-6),'b:','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end-6),BLSmanuftrendforecast(idxshow:end-6),'g:','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end-6),BLStotaltrendforecast(idxshow:end-6),'r:','LineWidth',1.5);hold on;


axis tight
recession_bars;
%BLS
plot(tfptime(idxshow:end-6),BLSpriv(idxshow:end-6),'b-','LineWidth',3);hold on;
plot(tfptime(idxshow:end-6),BLSmanuf(idxshow:end-6),'g-','LineWidth',3);hold on;
plot(tfptime(idxshow:end-6),BLStotal(idxshow:end-6),'r-','LineWidth',3);hold on;


plot(tfptime(idxshow:end-6),BLSprivtrend(idxshow:end-6),'b--','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end-6),BLSmanuftrend(idxshow:end-6),'g--','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end-6),BLStotaltrend(idxshow:end-6),'r--','LineWidth',1.5);hold on;

plot(tfptime(idxshow:end-6),BLSprivtrendforecast(idxshow:end-6),'b:','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end-6),BLSmanuftrendforecast(idxshow:end-6),'g:','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end-6),BLStotaltrendforecast(idxshow:end-6),'r:','LineWidth',1.5);hold on;

plot(tfptime(idxshow:end-6),BLSpriv(idxshow:end-6),'b-','LineWidth',3);hold on;
plot(tfptime(idxshow:end-6),BLSmanuf(idxshow:end-6),'g-','LineWidth',3);hold on;
plot(tfptime(idxshow:end-6),BLStotal(idxshow:end-6),'r-','LineWidth',3);hold on;


set(gca,'FontSize',12);

axis tight
title('Log TFP','FontSize',12);
legend('BLS (Private Business)','BLS (Manufacturing)','BLS (Total)',2);
legend boxoff

text('String','Notes: Linear trend from 2001Q1-2008Q2 (dashed-dotted). Forecast 2008Q3 and beyond based on linear trend (dotted).',...
    'Position',[2003.553240916912 4.41048500415810005898999 0],'FontSize',10);


%%%Fernald, Penn
show_all=1; %NBER recessions full 2007-2007 dates
%level
subplot(2,2,2)

plot(tfptime(idxshow:end),Fernaldraw(idxshow:end),'g-','LineWidth',3);hold on;
plot(tfptime(idxshow:end),Fernaldutil(idxshow:end),'b-','LineWidth',3);hold on;
plot(tfptime(idxshow:end),Penn(idxshow:end),'r-','LineWidth',2);hold on;


plot(tfptime(idxshow:end),Fernaldrawtrend(idxshow:end),'g--','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end),Fernaldutiltrend(idxshow:end),'b--','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end),Penntrend(idxshow:end),'r--','LineWidth',1.5);hold on;

plot(tfptime(idxshow:end),Fernaldrawtrendforecast(idxshow:end),'g:','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end),Fernaldutiltrendforecast(idxshow:end),'b:','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end),Penntrendforecast(idxshow:end),'r:','LineWidth',1.5);hold on;


axis tight
recession_bars;
plot(tfptime(idxshow:end),Fernaldraw(idxshow:end),'g-','LineWidth',3);hold on;
plot(tfptime(idxshow:end),Fernaldutil(idxshow:end),'b-','LineWidth',3);hold on;
plot(tfptime(idxshow:end),Penn(idxshow:end),'r-','LineWidth',3);hold on;


plot(tfptime(idxshow:end),Fernaldrawtrend(idxshow:end),'g--','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end),Fernaldutiltrend(idxshow:end),'b--','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end),Penntrend(idxshow:end),'r--','LineWidth',1.5);hold on;

plot(tfptime(idxshow:end),Fernaldrawtrendforecast(idxshow:end),'g:','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end),Fernaldutiltrendforecast(idxshow:end),'b:','LineWidth',1.5);hold on;
plot(tfptime(idxshow:end),Penntrendforecast(idxshow:end),'r:','LineWidth',1.5);hold on;

plot(tfptime(idxshow:end),Fernaldraw(idxshow:end),'g-','LineWidth',3);hold on;
plot(tfptime(idxshow:end),Fernaldutil(idxshow:end),'b-','LineWidth',3);hold on;
plot(tfptime(idxshow:end),Penn(idxshow:end),'r-','LineWidth',3);hold on;


set(gca,'FontSize',12);

axis tight
title('Log TFP','FontSize',12);
legend('Fernald (Raw)','Fernald (Utilization Adjusted)','Penn World Tables',2);
legend boxoff

%deviations
show_all=0;
subplot(2,2,3:4)
plot(tfptime(idxtrenduntil+1:end),100*BLSprivdev(idxtrenduntil+1:idxtrenduntil+obs-idxtrenduntil),'b-','LineWidth',3);hold on;
plot(tfptime(idxtrenduntil+1:end),100*BLSmanufdev(idxtrenduntil+1:idxtrenduntil+obs-idxtrenduntil),'g-','LineWidth',3);hold on;
plot(tfptime(idxtrenduntil+1:end),100*BLStotaldev(idxtrenduntil+1:idxtrenduntil+obs-idxtrenduntil),'r-','LineWidth',3);hold on;
plot(tfptime(idxtrenduntil+1:end),100*Fernaldrawdev(idxtrenduntil+1:idxtrenduntil+obs-idxtrenduntil),'g--','LineWidth',3);hold on;
plot(tfptime(idxtrenduntil+1:end),100*Fernaldutildev(idxtrenduntil+1:idxtrenduntil+obs-idxtrenduntil),'b--','LineWidth',3);hold on;
plot(tfptime(idxtrenduntil+1:end),100*Penndev(idxtrenduntil+1:idxtrenduntil+obs-idxtrenduntil),'r--','LineWidth',3);hold on;
plot(tfptime(idxtrenduntil+1:end),tfphand(1:obs-idxtrenduntil),'k-o','LineWidth',3,'MarkerSize',4);hold on;
leg=legend('BLS (Private Business)','BLS (Manufacturing)','BLS (Total)','Fernald (Raw)','Fernald (Util. Adjusted)','Penn World Tables','Our Model',1);
set(leg,'FontSize',9);
legend boxoff
axis tight
axis([2008.5 2013.25 -10 2]);
recession_bars;
plot(tfptime(idxtrenduntil+1:end),100*BLSprivdev(idxtrenduntil+1:idxtrenduntil+obs-idxtrenduntil),'b-','LineWidth',3);hold on;
plot(tfptime(idxtrenduntil+1:end),100*BLSmanufdev(idxtrenduntil+1:idxtrenduntil+obs-idxtrenduntil),'g-','LineWidth',3);hold on;
plot(tfptime(idxtrenduntil+1:end),100*BLStotaldev(idxtrenduntil+1:idxtrenduntil+obs-idxtrenduntil),'r-','LineWidth',3);hold on;
plot(tfptime(idxtrenduntil+1:end),100*Fernaldrawdev(idxtrenduntil+1:idxtrenduntil+obs-idxtrenduntil),'g--','LineWidth',3);hold on;
plot(tfptime(idxtrenduntil+1:end),100*Fernaldutildev(idxtrenduntil+1:idxtrenduntil+obs-idxtrenduntil),'b--','LineWidth',3);hold on;
plot(tfptime(idxtrenduntil+1:end),100*Penndev(idxtrenduntil+1:idxtrenduntil+obs-idxtrenduntil),'r--','LineWidth',3);hold on;
plot(tfptime(idxtrenduntil+1:end),tfphand(1:obs-idxtrenduntil),'k-o','LineWidth',3,'MarkerSize',4);hold on;
time_str={'2008Q3',	 '2009Q1',	 '2009Q3',	 '2010Q1',	 '2010Q3',	 '2011Q1', 	'2011Q3', '2012Q1', 	'2012Q3', 	'2013Q1',	 };
set(gca,'Xticklabel',time_str);
set(gca,'FontSize',12);
axis([2008.5 2013.25 -10 2]);
title('TFP (% Deviation from Trend)','FontSize',12);

suptitle2('Figure 5: Measures of Total Factor Productivity (TFP): 2001 to 2013');


orient landscape
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [-.85 -.25 12.25 8.35]);

print -dpdf ModelvsTFPcollection; print -depsc ModelvsTFPcollection; saveas(gcf, 'ModelvsTFPcollection','fig');


