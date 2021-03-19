
## --- parepare raw data---------------
scriptloc = dirname(rstudioapi::getSourceEditorContext()$path)
source("UtilityFunctions.R")   # self define functions


#Generate vector of dates
years = 1955:2012
quarters = c("Q1","Q2","Q3","Q4")
quarterlydates= vector()
for (ii in years) {
  for (kk in quarters) {
        quadates = paste0(ii,kk)  
        quarterlydates = c(quarterlydates,quadates)
  }
}

quarterlydates = quarterlydates[-c((length(quarterlydates)-1):length(quarterlydates))]


data0812 = readMat(paste0(scriptloc,"/data0812.mat"))
data0812 = data0812[[1]]
data0812 = as.data.frame(cbind(data0812, "Quater" =quarterlydates )) 


data0812 = data0812[-c(1: ( which(data0812$Quater == "1959Q3")  -1 ) ),]

## -------------------------------------


as.numeric(data0812$V2) - joinseries$I_obs*100
save1 = as.numeric(data0812$V11) / joinseries$tau_w
save1 = as.numeric(data0812$V12) / joinseries$tau_k


exp(as.numeric(data0812$V8)/100)* (joinseries$popindex*joinseries$deflator)


mean(save1)

# plotting for analysis


plot2graphs_rep_ori(joinseries[,"tau_k"],data0812$V12,joinseries[,"date"],"bottomleft") # tau_k is soso...

plot2graphs_rep_ori(joinseries[,"tau_w"],data0812$V11,joinseries[,"date"],"topleft")  # tau_w is ok!

plot2graphs_rep_ori(joinseries[,"tax_obs"]*100,data0812$V10,joinseries[,"date"],"topleft")  # tax revenue is okay!!

plot2graphs_rep_ori(joinseries[,"g_obs"]*100,data0812$V4,joinseries[,"date"],"topleft") # gov expenditure is ok!




plot2graphs_rep_ori(joinseries$ln_govtrans*100,data0812$V8,joinseries[,"date"],"topleft") # gov expenditure is ok!


plot2graphs_rep_ori(joinseries$ln_govtrans*100, data0812$V8,joinseries[,"date"],"topleft")





# try to construct the debt series according the provided data
# (successful! now know the algorithm)
oridata=exp(as.numeric(data0812$V9)/100)#*(joinseries$popindex*joinseries$deflator)
plot2graphs_rep_ori(joinseries[,"govdebts"]+oridata[1],oridata,joinseries[,"date"],"topleft")


orig_govexp = exp(as.numeric(data0812$V4)/100)*(joinseries$popindex*joinseries$deflator)
orig_govtaxrev = exp(as.numeric(data0812$V10)/100)*(joinseries$popindex*joinseries$deflator)
orig_govtrans = exp(as.numeric(data0812$V8)/100)*(joinseries$popindex*joinseries$deflator)
try_intpmt = joinseries$IntPmt#/(joinseries$popindex*joinseries$deflator)
for (iii in 1:length(orig_govexp)) {
  if (iii == 1) {
    debt_t = 200 + orig_govexp[iii]+orig_govtrans[iii]-orig_govtaxrev[iii]+try_intpmt[iii]
    debt_vec = debt_t
  } else {
  debt_t = debt_t + orig_govexp[iii]+orig_govtrans[iii]-orig_govtaxrev[iii]+try_intpmt[iii]
  debt_vec = c(debt_vec,debt_t)
  }
}



theo_debt = (orig_govexp+orig_govtaxrev-orig_govtrans+try_intpmt)
theo_debt =theo_debt+ (as.numeric(data0812$V9[1])-theo_debt[1])
theo_ori_debt = log(theo_debt/(joinseries$popindex*joinseries$deflator))*100

plot2graphs_rep_ori(log(debt_vec/(joinseries$popindex*joinseries$deflator)), (as.numeric(data0812$V9)/100),joinseries[,"date"],"topleft")

# try to use my own constructed data


orig_govexp = joinseries$govexp_nonadj
orig_govtaxrev = joinseries$govtaxrev_nonadj
orig_govtrans = joinseries$govtrans_noadj
try_intpmt = joinseries$IntPmt#/(joinseries$popindex*joinseries$deflator)
for (iii in 1:length(orig_govexp)) {
  if (iii == 1) {
    debt_t = 700 + orig_govexp[iii]+orig_govtrans[iii]-orig_govtaxrev[iii]+try_intpmt[iii]
    debt_vec = debt_t
  } else {
    debt_t = debt_t + orig_govexp[iii]+orig_govtrans[iii]-orig_govtaxrev[iii]+try_intpmt[iii]
    debt_vec = c(debt_vec,debt_t)
  }
}

plot2graphs_rep_ori(log(debt_vec/(joinseries$popindex*joinseries$deflator)), (as.numeric(data0812$V9)/100),joinseries[,"date"],"topleft")
