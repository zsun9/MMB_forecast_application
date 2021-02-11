
RunALL=1


#== Inflation ===========
if (exists("RunALL") == FALSE ) {source("housekeeping.R")} else if (RunALL==0){source("housekeeping.R")} 


series.data <- as.data.frame(read_excel("GDPCTPIindex2005.xls",sheet = "FRED"))
series.data$date <- as.Date(series.data$date)
series.data[,2] = log(series.data[,2])
series.data[-1,2] = diff(series.data[,2])
series.data[1,2] = NA
inf_p = betweendates(DATE1,DATE2,series.data)
inf_p[,2] = inf_p[,2] - mean(inf_p[,2])

datalist[["inf_p"]] <- inf_p





#== Gov expenditure =========
if (exists("RunALL") == FALSE ) {source("housekeeping.R")} else if (RunALL==0){source("housekeeping.R")} 

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "A957RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data1 <- as.data.frame(fredr_series_observations(series_id = "A957RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data1$date <- as.Date(series.data1$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "A787RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data2 <- as.data.frame(fredr_series_observations(series_id = "A787RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data2$date <- as.Date(series.data2$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "AD08RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data3 <- as.data.frame(fredr_series_observations(series_id = "AD08RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data3$date <- as.Date(series.data3$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "A918RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data4 <- as.data.frame(fredr_series_observations(series_id = "A918RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data4$date <- as.Date(series.data4$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data5 <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
series.data5$date <- as.Date(series.data5$date)
series.data5[, "value"] = series.data5[, "value"]/series.data5[series.data5$date == "2005-10-01","value"]

series.data6 <- as.data.frame(read_excel("GDPCTPIindex2005.xls",sheet = "FRED"))
series.data6$date <- as.Date(series.data6$date)



series.data=inner_join(series.data1, series.data2, by = "date", copy = FALSE, suffix = c(".A957RC1Q027SBEA", ".A787RC1Q027SBEA"))
series.data=inner_join(series.data, series.data3, by = "date", copy = FALSE, suffix = c("", ".AD08RC1Q027SBEA"))
series.data=inner_join(series.data, series.data4, by = "date", copy = FALSE, suffix = c("", ".A918RC1Q027SBEA"))
series.data=inner_join(series.data, series.data5, by = "date", copy = FALSE, suffix = c("", ".CNP16OV"))
series.data=inner_join(series.data, series.data6, by = "date", copy = FALSE, suffix = c("", ".GDPCTPI"))

#g_dataset = betweendates(DATE1,DATE2,series.data)
g_dataset=series.data
g_obs = cbind.data.frame("date" = g_dataset$date, "value" = log((g_dataset$value.A957RC1Q027SBEA+g_dataset$value.A787RC1Q027SBEA+g_dataset$value-g_dataset$value.A918RC1Q027SBEA)/(g_dataset$value.CNP16OV*g_dataset$GDPCTPI_NBD20051001)))
g_obs[-1,2] = diff(g_obs[,2])
g_obs = betweendates(DATE1,DATE2,g_obs)
g_obs[,2] = (g_obs[,2] - mean(g_obs[,2]))

#datalist <- list()
datalist[["g_obs"]] <- g_obs

#=== i_obs =======  log((GPDI+ PCDG)/(GDPDEF*pop index)) ========
if (exists("RunALL") == FALSE ) {source("housekeeping.R")} else if (RunALL==0){source("housekeeping.R")} 

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "GPDI")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data1 <- as.data.frame(fredr_series_observations(series_id = "GPDI", frequency = "q", vintage_dates = closest_date))
series.data1$date <- as.Date(series.data1$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "PCDG")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data2 <- as.data.frame(fredr_series_observations(series_id = "PCDG", frequency = "q", vintage_dates = closest_date))
series.data2$date <- as.Date(series.data2$date)


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data5 <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
series.data5$date <- as.Date(series.data5$date)
series.data5[, "value"] = series.data5[, "value"]/series.data5[series.data5$date == "2005-10-01","value"]

series.data6 <- as.data.frame(read_excel("GDPCTPIindex2005.xls",sheet = "FRED"))
series.data6$date <- as.Date(series.data6$date)


series.data=inner_join(series.data1, series.data2, by = "date", copy = FALSE, suffix = c(".GPDI", ".PCDG"))
series.data=inner_join(series.data, series.data5, by = "date", copy = FALSE, suffix = c("", ".CNP16OV"))
series.data=inner_join(series.data, series.data6, by = "date", copy = FALSE, suffix = c("", ".GDPCTPI"))

i_dataset=series.data
i_obs = cbind.data.frame("date" = i_dataset$date, "value" = log((i_dataset$value.GPDI+i_dataset$value.PCDG)/(i_dataset$value*i_dataset$GDPCTPI_NBD20051001)))
i_obs[-1,2] = diff(i_obs[,2])
i_obs = betweendates(DATE1,DATE2,i_obs)
i_obs[,2] = (i_obs[,2] - mean(i_obs[,2]))

datalist[["i_obs"]] <- i_obs


#=== c_obs =======  log((PCND+ PCESV)/(GDPDEF*pop index)) ========
if (exists("RunALL") == FALSE ) {source("housekeeping.R")} else if (RunALL==0){source("housekeeping.R")} 

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "PCND")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data1 <- as.data.frame(fredr_series_observations(series_id = "PCND", frequency = "q", vintage_dates = closest_date))
series.data1$date <- as.Date(series.data1$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "PCESV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data2 <- as.data.frame(fredr_series_observations(series_id = "PCESV", frequency = "q", vintage_dates = closest_date))
series.data2$date <- as.Date(series.data2$date)


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data5 <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
series.data5$date <- as.Date(series.data5$date)
series.data5[, "value"] = series.data5[, "value"]/series.data5[series.data5$date == "2005-10-01","value"]

series.data6 <- as.data.frame(read_excel("GDPCTPIindex2005.xls",sheet = "FRED"))
series.data6$date <- as.Date(series.data6$date)


series.data=inner_join(series.data1, series.data2, by = "date", copy = FALSE, suffix = c(".PCND", ".PCESV"))
series.data=inner_join(series.data, series.data5, by = "date", copy = FALSE, suffix = c("", ".CNP16OV"))
series.data=inner_join(series.data, series.data6, by = "date", copy = FALSE, suffix = c("", ".GDPCTPI"))

c_dataset=series.data
c_obs = cbind.data.frame("date" = c_dataset$date, "value" = log((c_dataset$value.PCND+c_dataset$value.PCESV)/(c_dataset$value*c_dataset$GDPCTPI_NBD20051001)))
c_obs[-1,2] = diff(c_obs[,2])
c_obs = betweendates(DATE1,DATE2,c_obs)
c_obs[,2] = (c_obs[,2] - mean(c_obs[,2]))

datalist[["c_obs"]] <- c_obs

# ======== R ==== DFF
if (exists("RunALL") == FALSE ) {source("housekeeping.R")} else if (RunALL==0){source("housekeeping.R")} 

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "DFF")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data1 <- as.data.frame(fredr_series_observations(series_id = "DFF", frequency = "q", vintage_dates = closest_date))
series.data1$date <- as.Date(series.data1$date)

R_dataset=series.data1
R_obs = R_dataset
R_obs = betweendates(DATE1,DATE2,R_obs)
R_obs[,3] = log(R_obs[,3])
R_obs[,3] = (R_obs[,3] - mean(R_obs[,3]))/100

datalist[["R_obs"]] <- R_obs


#=== lp =======  hour work,  log(PRS85006023*CE16OV index)/(pop index)========
if (exists("RunALL") == FALSE ) {source("housekeeping.R")} else if (RunALL==0){source("housekeeping.R")} 

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "PRS85006023")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data1 <- as.data.frame(fredr_series_observations(series_id = "PRS85006023", frequency = "q", vintage_dates = closest_date))
series.data1$date <- as.Date(series.data1$date)

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CE16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data2 <- as.data.frame(fredr_series_observations(series_id = "CE16OV", frequency = "q", vintage_dates = closest_date))
series.data2$date <- as.Date(series.data2$date)
series.data2[, "value"] = series.data2[, "value"]/series.data2[series.data2$date == "2005-10-01","value"]



tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data5 <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
series.data5$date <- as.Date(series.data5$date)
series.data5[, "value"] = series.data5[, "value"]/series.data5[series.data5$date == "2005-10-01","value"]




series.data=inner_join(series.data1, series.data2, by = "date", copy = FALSE, suffix = c(".PRS85006023", ".CE16OV"))
series.data=inner_join(series.data, series.data5, by = "date", copy = FALSE, suffix = c("", ".CNP16OV"))

lp_dataset=series.data
lp_obs = cbind.data.frame("date" = lp_dataset$date, "value" = log((lp_dataset$value.PRS85006023*lp_dataset$value.CE16OV)/(lp_dataset$value)))
lp_obs = betweendates(DATE1,DATE2,lp_obs)
lp_obs[,2] = (lp_obs[,2] - mean(lp_obs[,2]))

datalist[["lp_obs"]] <- lp_obs

# ===== construct wage_rgd_demean_obs for comparison ==============
if (exists("RunALL") == FALSE ) {source("housekeeping.R")} else if (RunALL==0){source("housekeeping.R")} 


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "COMPNFB")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data1 <- as.data.frame(fredr_series_observations(series_id = "COMPNFB", frequency = "q", vintage_dates = closest_date))
series.data1$date <- as.Date(series.data1$date)

series.data6 <- as.data.frame(read_excel("GDPCTPIindex2005.xls",sheet = "FRED"))
series.data6$date <- as.Date(series.data6$date)

series.data=inner_join(series.data1, series.data6, by = "date", copy = FALSE, suffix = c(".COMPNFB", ".GDPCTPIindex2005"))

wage_rgd_demean_obs_data=series.data
wage_rgd_demean_obs=cbind.data.frame("date" = wage_rgd_demean_obs_data$date, "value" = log(wage_rgd_demean_obs_data$value/wage_rgd_demean_obs_data$GDPCTPI_NBD20051001))
wage_rgd_demean_obs[-1,2] = diff(wage_rgd_demean_obs[,2])
wage_rgd_demean_obs = betweendates(DATE1,DATE2,wage_rgd_demean_obs)
wage_rgd_demean_obs[,2] = (wage_rgd_demean_obs[,2] - mean(wage_rgd_demean_obs[,2]))

datalist[["wage_rgd_demean_obs"]] <- wage_rgd_demean_obs


if (exists("RunALL") == FALSE ) {write_xlsx(datalist, path = "datalist.xlsx", col_names = TRUE)} else if (RunALL==0){write_xlsx(datalist, path = "datalist.xlsx", col_names = TRUE)} 

# === To get b_obs  government debt per capita, we need to get gov expenditure + transfer - tax reveunes plus interest payment =============
if (exists("RunALL") == FALSE ) {source("housekeeping.R")} else if (RunALL==0){source("housekeeping.R")} 

# get tax rate
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "W780RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.CSI <- as.data.frame(fredr_series_observations(series_id = "W780RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.CSI$date <- as.Date(series.data.CSI$date)
names(series.data.CSI)[names(series.data.CSI) == "value"] <- "CSI"
series.data.CSI = series.data.CSI[,-2]

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "COE")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.EC <- as.data.frame(fredr_series_observations(series_id = "COE", frequency = "q", vintage_dates = closest_date))
series.data.EC$date <- as.Date(series.data.EC$date)
names(series.data.EC)[names(series.data.EC) == "value"] <- "EC"
series.data.EC = series.data.EC[,-2]


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "A074RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.IT <- as.data.frame(fredr_series_observations(series_id = "A074RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.IT$date <- as.Date(series.data.IT$date)
names(series.data.IT)[names(series.data.IT) == "value"] <- "IT"
series.data.IT = series.data.IT[,-2]


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "W071RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.SIT <- as.data.frame(fredr_series_observations(series_id = "W071RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.SIT$date <- as.Date(series.data.SIT$date)
names(series.data.SIT)[names(series.data.SIT) == "value"] <- "SIT"
series.data.SIT = series.data.SIT[,-2]


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "PROPINC")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.PRI <- as.data.frame(fredr_series_observations(series_id = "PROPINC", frequency = "q", vintage_dates = closest_date))
series.data.PRI$date <- as.Date(series.data.PRI$date)
names(series.data.PRI)[names(series.data.PRI) == "value"] <- "PRI"
series.data.PRI = series.data.PRI[,-2]


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "WASCUR")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.W <- as.data.frame(fredr_series_observations(series_id = "WASCUR", frequency = "q", vintage_dates = closest_date))
series.data.W$date <- as.Date(series.data.W$date)
names(series.data.W)[names(series.data.W) == "value"] <- "W"
series.data.W = series.data.W[,-2]


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "RENTIN")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.rentalinc <- as.data.frame(fredr_series_observations(series_id = "RENTIN", frequency = "q", vintage_dates = closest_date))
series.data.rentalinc$date <- as.Date(series.data.rentalinc$date)
names(series.data.rentalinc)[names(series.data.rentalinc) == "value"] <- "rentalinc"
series.data.rentalinc = series.data.rentalinc[,-2]


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CPROFIT")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.CPROFIT <- as.data.frame(fredr_series_observations(series_id = "CPROFIT", frequency = "q", vintage_dates = closest_date))
series.data.CPROFIT$date <- as.Date(series.data.CPROFIT$date)
names(series.data.CPROFIT)[names(series.data.CPROFIT) == "value"] <- "CPROFIT"
series.data.CPROFIT = series.data.CPROFIT[,-2]


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "BOGZ1FA086130003Q")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.interestinc <- as.data.frame(fredr_series_observations(series_id = "BOGZ1FA086130003Q", frequency = "q", vintage_dates = closest_date))
series.data.interestinc$date <- as.Date(series.data.interestinc$date)
names(series.data.interestinc)[names(series.data.interestinc) == "value"] <- "interestinc"
series.data.interestinc = series.data.interestinc[,-2]


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "B075RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.CT <- as.data.frame(fredr_series_observations(series_id = "B075RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.CT$date <- as.Date(series.data.CT$date)
names(series.data.CT)[names(series.data.CT) == "value"] <- "CT"
series.data.CT = series.data.CT[,-2]


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "B249RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.PT <- as.data.frame(fredr_series_observations(series_id = "B249RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.PT$date <- as.Date(series.data.PT$date)
names(series.data.PT)[names(series.data.PT) == "value"] <- "PT"
series.data.PT = series.data.PT[,-2]

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.pop <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
series.data.pop$date <- as.Date(series.data.pop$date)
series.data.pop[, "value"] = series.data.pop[, "value"]/series.data.pop[series.data.pop$date == "2005-10-01","value"]
names(series.data.pop)[names(series.data.pop) == "value"] <- "popindex"
series.data.pop = series.data.pop[,-2]

series.data.def <- as.data.frame(read_excel("GDPCTPIindex2005.xls",sheet = "FRED"))
series.data.def$date <- as.Date(series.data.def$date)
names(series.data.def)[2] <- "deflator"


series.data.joint=inner_join(series.data.CSI, series.data.EC, by = "date", copy = FALSE)
series.data.joint=inner_join(series.data.joint, series.data.IT, by = "date", copy = FALSE)
series.data.joint=inner_join(series.data.joint, series.data.SIT, by = "date", copy = FALSE)
series.data.joint=inner_join(series.data.joint, series.data.PRI, by = "date", copy = FALSE)
series.data.joint=inner_join(series.data.joint, series.data.W, by = "date", copy = FALSE)
series.data.joint=inner_join(series.data.joint, series.data.rentalinc, by = "date", copy = FALSE)
series.data.joint=inner_join(series.data.joint, series.data.CPROFIT, by = "date", copy = FALSE)
series.data.joint=inner_join(series.data.joint, series.data.interestinc, by = "date", copy = FALSE)
series.data.joint=inner_join(series.data.joint, series.data.CT, by = "date", copy = FALSE)
series.data.joint=inner_join(series.data.joint, series.data.PT, by = "date", copy = FALSE)
series.data.joint=inner_join(series.data.joint, series.data.pop, by = "date", copy = FALSE)
series.data.joint=inner_join(series.data.joint, series.data.def, by = "date", copy = FALSE)


# get capital income
series.data.CI = series.data.joint$rentalinc+series.data.joint$CPROFIT+series.data.joint$interestinc+series.data.joint$PRI/2
series.data.joint = cbind(series.data.joint, "CI" = series.data.CI)

jointab = series.data.joint

# calculate labor tax rate
tau_w = ((jointab$IT+jointab$SIT)/(jointab$W+jointab$PRI/2+jointab$CI))*((jointab$W+jointab$PRI/2)/(jointab$EC+jointab$PRI/2))+jointab$CSI/(jointab$EC+jointab$PRI/2)
ln_tau_w = tau_w
jointab = cbind(jointab ,"tau_w" =tau_w , "ln_tau_w" =ln_tau_w)

tau_k = (jointab$IT/(jointab$W + jointab$PRI/2 + jointab$CI))*(jointab$CI/(jointab$CI + jointab$PT)) + (jointab$CT + jointab$PT)/(jointab$CI + jointab$PT)
ln_tau_k = log(tau_k)
jointab = cbind(jointab ,"tau_k" =tau_k,"ln_tau_k"=ln_tau_k )

tax_rate_table = jointab[,c("date","ln_tau_w","ln_tau_k")]
tax_rate_table = betweendates(DATE1,DATE2,tax_rate_table)
tax_rate_table[,"ln_tau_w"] = tax_rate_table[,"ln_tau_w"] - mean(tax_rate_table[,"ln_tau_w"] )
tax_rate_table[,"ln_tau_k"] = tax_rate_table[,"ln_tau_k"] - mean(tax_rate_table[,"ln_tau_k"] )


datalist[["tax_rate_table"]] <- tax_rate_table




# now calculate tax_obs (gov tax revenue)
ln_taxrev = log((jointab$tau_w*(jointab$EC + jointab$PRI/2) + jointab$tau_k*(jointab$CI + jointab$PT))/(jointab$popindex*jointab$deflator))
jointab = cbind(jointab ,"ln_taxrev" =ln_taxrev )

tax_obs = jointab[, c("date" , "ln_taxrev")]
tax_obs[-1,2] = diff(tax_obs[,2])
tax_obs = betweendates(DATE1,DATE2,tax_obs)
tax_obs[,2] = (tax_obs[,2] - mean(tax_obs[,2]))

datalist[["tax_obs"]] <- tax_obs


if (exists("RunALL") == FALSE ) {write_xlsx(datalist, path = "datalist.xlsx", col_names = TRUE)} else if (RunALL==0){write_xlsx(datalist, path = "datalist.xlsx", col_names = TRUE)} 

#===== b_obs , log real public debt per capita  ==============
if (exists("RunALL") == FALSE ) {source("housekeeping.R")} else if (RunALL==0){source("housekeeping.R")} 

# first calculate government transfer
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "W014RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.CurTransPay <- as.data.frame(fredr_series_observations(series_id = "W014RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.CurTransPay$date <- as.Date(series.data.CurTransPay$date)
names(series.data.CurTransPay)[names(series.data.CurTransPay) == "value"] <- "CurTransPay"
series.data.CurTransPay = series.data.CurTransPay[,-2]


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "W011RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.CurTransRpt <- as.data.frame(fredr_series_observations(series_id = "W011RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.CurTransRpt$date <- as.Date(series.data.CurTransRpt$date)
names(series.data.CurTransRpt)[names(series.data.CurTransRpt) == "value"] <- "CurTransRpt"
series.data.CurTransRpt = series.data.CurTransRpt[,-2]

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "W020RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.CapTransPmt <- as.data.frame(fredr_series_observations(series_id = "W020RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.CapTransPmt$date <- as.Date(series.data.CapTransPmt$date)
names(series.data.CapTransPmt)[names(series.data.CapTransPmt) == "value"] <- "CapTransPmt"
series.data.CapTransPmt = series.data.CapTransPmt[,-2]

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "B232RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.CapTransRpt <- as.data.frame(fredr_series_observations(series_id = "B232RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.CapTransRpt$date <- as.Date(series.data.CapTransRpt$date)
names(series.data.CapTransRpt)[names(series.data.CapTransRpt) == "value"] <- "CapTransRpt"
series.data.CapTransRpt = series.data.CapTransRpt[,-2]

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "W006RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.CurTaxRpt <- as.data.frame(fredr_series_observations(series_id = "W006RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.CurTaxRpt$date <- as.Date(series.data.CurTaxRpt$date)
names(series.data.CurTaxRpt)[names(series.data.CurTaxRpt) == "value"] <- "CurTaxRpt"
series.data.CurTaxRpt = series.data.CurTaxRpt[,-2]

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "W780RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.ConGovSocIns <- as.data.frame(fredr_series_observations(series_id = "W780RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.ConGovSocIns$date <- as.Date(series.data.ConGovSocIns$date)
names(series.data.ConGovSocIns)[names(series.data.ConGovSocIns) == "value"] <- "ConGovSocIns"
series.data.ConGovSocIns = series.data.ConGovSocIns[,-2]

tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "W009RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.IncRctAss <- as.data.frame(fredr_series_observations(series_id = "W009RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.IncRctAss$date <- as.Date(series.data.IncRctAss$date)
names(series.data.IncRctAss)[names(series.data.IncRctAss) == "value"] <- "IncRctAss"
series.data.IncRctAss = series.data.IncRctAss[,-2]


tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "B097RC1Q027SBEA")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data.IncRctAss <- as.data.frame(fredr_series_observations(series_id = "B097RC1Q027SBEA", frequency = "q", vintage_dates = closest_date))
series.data.IncRctAss$date <- as.Date(series.data.IncRctAss$date)
names(series.data.IncRctAss)[names(series.data.IncRctAss) == "value"] <- "IncRctAss"
series.data.IncRctAss = series.data.IncRctAss[,-2]




if (exists("RunALL") == FALSE ) {write_xlsx(datalist, path = "datalist.xlsx", col_names = TRUE)} else if (RunALL==0){write_xlsx(datalist, path = "datalist.xlsx", col_names = TRUE)} 

#===== Write list to excel ========================
write_xlsx(datalist, path = "datalist.xlsx", col_names = TRUE)

