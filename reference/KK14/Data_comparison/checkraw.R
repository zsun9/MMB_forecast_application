
## --- parepare raw data---------------
scriptloc = dirname(rstudioapi::getSourceEditorContext()$path)

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

mean(save1)

# plotting for analysis
plot(joinseries[,"date"],joinseries[,"tau_k"],type="l",col="black",ylab="", xlab="date")
lines(joinseries[,"date"],as.numeric(data0812$V12),col="red")
legend("topleft", legend = c("replicated", "original"), col=c("black", "red"),lty=1, pch=NA) 



plot(joinseries[,"date"],joinseries[,"tau_w"],type="l",col="black",ylab="", xlab="date")
lines(joinseries[,"date"],as.numeric(data0812$V11),col="red")
legend("topleft", legend = c("replicated", "original"), col=c("black", "red"),lty=1, pch=NA) 





plot(joinseries[,"date"],joinseries[,"tax_obs"]*100,type="l",col="black",ylab="", xlab="date")
lines(joinseries[,"date"],as.numeric(data0812$V10),col="red")
legend("topleft", legend = c("replicated", "original"), col=c("black", "red"),lty=1, pch=NA) 


joinseries$govtrans = -joinseries$govtrans

