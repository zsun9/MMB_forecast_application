## --- Housekeeping-------------
rm(list = ls())
gen_data =0  # if 1, retrieve data from alfred
trytry = 0  # if 1, enforce the trial adjustments
# install.packages(c("fredr","writexl","dplyr","readxl","R.matlab"))
library(fredr)
library(writexl)
library(dplyr)
library(readxl)
library(R.matlab)

scriptloc = dirname(rstudioapi::getSourceEditorContext()$path)
fredr_set_key("52191461124b452b055bc68a63d07928")  #set alfred access key
ref.vin.date <- as.Date("2012-10-10")  # vintage date as reference
source("UtilityFunctions.R")   # self define functions
DATE1 <- as.Date("1983-01-01") # 1983Q1   
DATE2 <- as.Date("2008-08-30")  # 2008Q3  
datalist <- list() #initiate list to store data

## -- retrieve data from ALFRED -----------

# Define vector of series to be retrieved and their respective column names
DataCodeVec <- c("PRS85006023" ,  "CE16OV"  , "PCND"  , "PCESV" ,
                 "GPDI", "PCDG" , "A957RC1Q027SBEA" , "A787RC1Q027SBEA" , "AD08RC1Q027SBEA" , "A918RC1Q027SBEA",
                 "W780RC1Q027SBEA","COE", "A074RC1Q027SBEA", "W071RC1Q027SBEA", "PROPINC", "WASCUR", 
                 "RENTIN", "CPROFIT", 
                 "W255RC1Q027SBEA", #"BOGZ1FA086130003Q"
                 "B075RC1Q027SBEA", "B249RC1Q027SBEA", "CNP16OV",
                 "GDPCTPI" ,
                 "W014RC1Q027SBEA", #"W014RC1Q027SBEA" ,
                 "W011RC1Q027SBEA" ,"W020RC1Q027SBEA" ,"B232RC1Q027SBEA", "W006RC1Q027SBEA",
                 "W780RC1Q027SBEA","W009RC1Q027SBEA","B097RC1Q027SBEA" , "B096RC1Q027SBEA", "A091RC1Q027SBEA",
                 "MVGFD027MNFRBDAL")

DataNameVec <- c("PRS85006023" ,  "CE16OV"  , "PCND" , "PCESV" ,
                 "GPDI" , "PCDG", "GovConExp" , "GovGrossInv" , "GovNetPurNPAss" , "GovConsFixCap" ,
                 "CSI","EC", "IT", "SIT", "PRI" ,"W" ,
                 "rentalinc", "CPROFIT",
                 "interestinc"  ##
                 ,"CT", "PT" ,"popindex" ,
                 "deflator" ,
                 "CurTransPmt" , ##
                 "CurTransRpt" , "CapTransPmt" ,"CapTransRpt","CurTaxRpt",
                 "ConGovSocIns","IncRcptAss","CurSurpGovEntp" , "subsidies" , "IntPmt",
                 "MVFedDebtGross")

# cater for unit difference!! Everything should be in Billions!
# below vector is of other units
InMillions <- c("BOGZ1FA086130003Q")


check_vec <- cbind("name" =DataNameVec, "code" =DataCodeVec  )

if (gen_data ==1){

# data retrival
  for (iii in 1:length(DataCodeVec)){
    CodeName= DataCodeVec[iii]
    
    # raw data retrival from ALFRED
    tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = CodeName)[[1]])
    closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
    series.data <- as.data.frame(fredr_series_observations(series_id = CodeName, frequency = "q", vintage_dates = closest_date))
    series.data$date <- as.Date(series.data$date)
    
    # Indexation of population and nominalization of deflator
    if (CodeName == "CNP16OV") {
      series.data[, "value"] = series.data[, "value"]/series.data[series.data$date == "2005-10-01","value"]
    } else if ( CodeName == "GDPCTPI") {
      series.data[, "value"] = series.data[, "value"]*100/series.data[series.data$date == "2005-10-01","value"]
    } else {}
    
    # change units to billion
    if (CodeName == "BOGZ1FA086130003Q") {
      series.data[, "value"] =  series.data[, "value"]/1000
      }
    
    # renaming
    series.data = series.data[, c("date", "value")]
    names(series.data)[names(series.data) == "value"] <- DataNameVec[iii]
    series.data = series.data[,!(names(series.data) %in% "series_id")]
    
    # append to joint dataframe
    if (iii==1 ) {
      joinseries = series.data
    } else {
      joinseries=inner_join(joinseries, series.data, by = "date", copy = FALSE)
    }
  }
save(joinseries, file = "joinseries.RData")
} else {
  load("joinseries.RData")
}

if (trytry == 1) {
  series.data6 <- as.data.frame(read_excel("CSI_tab3_2_ln11.xls",sheet = "Tabelle1"))
  joinseries$CSI = as.vector(series.data6[,1])  # improves
  
  series.data6 <- as.data.frame(read_excel("PT_tab3_3.xls",sheet = "Tabelle1"))
  joinseries$PT = as.vector(series.data6[,1])  #improves
  
  #series.data6 <- as.data.frame(read_excel("table3_2_line_7.xls",sheet = "Tabelle1"))
  #joinseries$CT = as.vector(series.data6[,1])  # not improve
  
  series.data6 <- as.data.frame(read_excel("subsidies_tab3_2_ln32.xls",sheet = "Tabelle1"))
  joinseries$subsidies = as.vector(series.data6[,1])  
  
  
}


## --- Observables constructions according to online Appendix-----------
# construct c_obs
  c_nonadj = joinseries$PCND+joinseries$PCESV
  cons_obs = c_nonadj/(joinseries$popindex*joinseries$deflator)
  joinseries = cbind(joinseries, "cons_obs" = cons_obs , "ln_c_obs" = log(cons_obs))
  c_obs_tb = cbind.data.frame("date" = joinseries$date, "c_obs" =joinseries$ln_c_obs)
  c_obs_tb[-1,2] = diff(c_obs_tb[,2])
  c_obs_tb = betweendates(DATE1,DATE2,c_obs_tb)
  c_obs_tb[,2] = c_obs_tb[,2] - mean(c_obs_tb[,2])
  
# Construct lp -> hours worked
  lp_nonadj = joinseries$PRS85006023*joinseries$CE16OV
  lp_obs = lp_nonadj/(joinseries$popindex)
  joinseries = cbind(joinseries, "lp_obs" = lp_obs , "ln_lp_obs" = log(lp_obs))
  lp_obs_tb = cbind.data.frame("date" = joinseries$date, "lp" =joinseries$ln_lp_obs)
  lp_obs_tb = betweendates(DATE1,DATE2,lp_obs_tb)
  lp_obs_tb[,2] = lp_obs_tb[,2] - mean(lp_obs_tb[,2])
  

# Construct i_obs 
  PriInv =(joinseries$GPDI+joinseries$PCDG)/(joinseries$popindex*joinseries$deflator)
  joinseries = cbind(joinseries, "PriInv" = PriInv , "I_obs" = log(PriInv))
  I_obs_tb = cbind.data.frame("date" = joinseries$date, "I_obs" =joinseries$I_obs)
  I_obs_tb[-1,2] = diff(I_obs_tb[,2])
  I_obs_tb = betweendates(DATE1,DATE2,I_obs_tb)
  I_obs_tb[,2] = (I_obs_tb[,2] - mean(I_obs_tb[,2]))

# Construct g_obs (government expenditure)
  govexp_nonadj = (joinseries$GovConExp + joinseries$GovGrossInv + joinseries$GovNetPurNPAss - joinseries$GovConsFixCap)
  govexp    =  govexp_nonadj/(joinseries$popindex*joinseries$deflator)
  joinseries = cbind(joinseries,"govexp_nonadj"=govexp_nonadj,  "govexp" = govexp , "g_obs" = log(govexp))
  g_obs_tb = cbind.data.frame("date" = joinseries$date, "g_obs" =joinseries$g_obs)
  g_obs_tb[-1,2] = diff(g_obs_tb[,2])
  g_obs_tb = betweendates(DATE1,DATE2,g_obs_tb)
  g_obs_tb[,2] = (g_obs_tb[,2] - mean(g_obs_tb[,2]))

# get capital income
  series.data.CI = joinseries$rentalinc+joinseries$CPROFIT+joinseries$interestinc+joinseries$PRI/2
  joinseries = cbind(joinseries, "CI" = series.data.CI)


# calculate labor tax rate 
  tau_w = ((joinseries$IT+joinseries$SIT)/(joinseries$W+joinseries$PRI/2+joinseries$CI))*((joinseries$W+joinseries$PRI/2)/(joinseries$EC+joinseries$PRI/2))+joinseries$CSI/(joinseries$EC+joinseries$PRI/2)
  tau_w = 0.9*tau_w
  joinseries = cbind(joinseries ,"tau_w" =tau_w , "ln_tau_w" =log(tau_w))
# calculate capital tax rate  
  tau_k = (joinseries$IT/(joinseries$W + joinseries$PRI/2 + joinseries$CI))*(joinseries$CI/(joinseries$CI + joinseries$PT)) + (joinseries$CT + joinseries$PT)/(joinseries$CI + joinseries$PT)
  tau_k = 0.62*tau_k
  joinseries = cbind(joinseries ,"tau_k" =tau_k,"ln_tau_k"=log(tau_k) )

# extract taxrate observables
  tax_rate_table = joinseries[,c("date","ln_tau_w","ln_tau_k")]
  tax_rate_table = betweendates(DATE1,DATE2,tax_rate_table)  #truncation of data series between DATE1 and DATE2
  
  # demeaning the log tax rates (they are the observations in model)
  tax_rate_table[,"ln_tau_w"] = tax_rate_table[,"ln_tau_w"] - mean(tax_rate_table[,"ln_tau_w"] )
  tax_rate_table[,"ln_tau_k"] = tax_rate_table[,"ln_tau_k"] - mean(tax_rate_table[,"ln_tau_k"] )


# calculate tax_obs (gov tax revenue)
  govtaxrev_nonadj = (joinseries$tau_w*(joinseries$EC + joinseries$PRI/2) + joinseries$tau_k*(joinseries$CI + joinseries$PT))
  govtaxrev=govtaxrev_nonadj /(joinseries$popindex*joinseries$deflator)
  ln_taxrev = log(govtaxrev)
  joinseries = cbind(joinseries ,"govtaxrev_nonadj" = govtaxrev_nonadj,   "govtaxrev" = govtaxrev,  "tax_obs" =ln_taxrev )
  
  tax_obs = joinseries[, c("date" , "tax_obs")]
  tax_obs[-1,2] = diff(tax_obs[,2])
  tax_obs = betweendates(DATE1,DATE2,tax_obs) #truncation of data series between DATE1 and DATE2
  tax_obs[,2] = (tax_obs[,2] - mean(tax_obs[,2]))

# calculate government transfers
  govtrans_noadj = (joinseries$CurTransPmt- joinseries$CurTransRpt) +  # net current transfers
    (joinseries$CapTransPmt -joinseries$CapTransRpt) +  # net capital transfers
    joinseries$subsidies - # sibsidies
    (joinseries$CurTaxRpt + joinseries$ConGovSocIns + joinseries$IncRcptAss + joinseries$CurSurpGovEntp  - joinseries$govtaxrev_nonadj) # tax residual
  govtrans=govtrans_noadj/(joinseries$popindex*joinseries$deflator)
  joinseries = cbind(joinseries , "govtrans_noadj"=govtrans_noadj, "govtrans" = govtrans , "ln_govtrans" = log(govtrans))

# Then calculates b_obs (government debts)
  
  debt_vec =  joinseries$govexp_nonadj+joinseries$govtrans_noadj-joinseries$govtaxrev_nonadj+joinseries$IntPmt
  debt_vec = cumsum(debt_vec) - debt_vec[1]+ joinseries$MVFedDebtGross[1]# + 200

  
  govdebt = debt_vec/(joinseries$popindex*joinseries$deflator)
  joinseries = cbind(joinseries , "govdebt_noadj"=debt_vec, "govdebt" =govdebt , "ln_govdebt" = log(govdebt))
  
  
  
  b_obs_tb = joinseries[, c("date" , "ln_govdebt")]

  b_obs_tb[-1,2] = diff(b_obs_tb[,2])
  b_obs_tb = betweendates(DATE1,DATE2,b_obs_tb) #truncation of data series between DATE1 and DATE2
  b_obs_tb[,2] = (b_obs_tb[,2] - mean(b_obs_tb[,2]))


## -- Retrieve official data from replication package ------

# I first run "data_september2012.m" and then run "obsdata_first_diff2", and save the final observables in "ReplicData"
ReplicData = readMat(paste0(scriptloc,"/ReplicData.mat"))

# Append the data in ReplicData to the corresponding dataframes
tax_obs = cbind(tax_obs ,"Orig_tax_obs" = ReplicData[["tax.obs"]] )
tax_rate_table = cbind(tax_rate_table, "Orig_tau_k" = ReplicData[["tau.k"]], "Orig_tau_w" = ReplicData[["tau.w"]])
g_obs_tb = cbind(g_obs_tb, "Orig_g_obs" = ReplicData[["g.obs"]])
b_obs_tb = cbind(b_obs_tb, "Orig_b_obs" = ReplicData[["b.obs"]])
I_obs_tb = cbind(I_obs_tb, "Orig_I_obs" = ReplicData[["I.obs"]])
c_obs_tb = cbind(c_obs_tb, "Orig_c_obs" = ReplicData[["c.obs"]])
lp_obs_tb = cbind(lp_obs_tb, "Orig_lp" = ReplicData[["lp"]])
inf_p_tb = cbind(lp_obs_tb, "Orig_inf_p" = ReplicData[["inf.p"]])
W_tb = cbind(lp_obs_tb, "Orig_W" = ReplicData[["W"]])



## -- Compare the data with plotting -----
## For c_obs
plot2graphs_rep_ori(c_obs_tb[,"c_obs"],c_obs_tb[,"Orig_c_obs"],c_obs_tb[,"date"] ,"bottomleft")

## For lp
plot2graphs_rep_ori(lp_obs_tb[,"lp"],lp_obs_tb[,"Orig_lp"],lp_obs_tb[,"date"] ,"bottomleft")

## For I_obs
plot2graphs_rep_ori(I_obs_tb[,"I_obs"],I_obs_tb[,"Orig_I_obs"],I_obs_tb[,"date"] ,"bottomleft")

## For g_obs
plot2graphs_rep_ori(g_obs_tb[,"g_obs"],g_obs_tb[,"Orig_g_obs"],g_obs_tb[,"date"] ,"bottomleft")

## For tax_obs
plot2graphs_rep_ori(tax_obs[,"tax_obs"],tax_obs[,"Orig_tax_obs"],tax_obs[,"date"] ,"bottomleft")

## For tau_k
plot2graphs_rep_ori(tax_rate_table[,"ln_tau_k"],tax_rate_table[,"Orig_tau_k"],tax_rate_table[,"date"] ,"bottomleft")

## For tau_w
plot2graphs_rep_ori(tax_rate_table[,"ln_tau_w"],tax_rate_table[,"Orig_tau_w"],tax_rate_table[,"date"] ,"bottomleft")

## For b_obs
plot2graphs_rep_ori(b_obs_tb[,"ln_govdebt"],b_obs_tb[,"Orig_b_obs"],b_obs_tb[,"date"] ,"bottomleft")


## random try

  aaa=as.data.frame(b_obs_tb$Orig_b_obs) 
