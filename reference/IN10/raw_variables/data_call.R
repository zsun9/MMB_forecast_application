# install.packages("devtools")
# library(devtools)
# devtools::install_github("sboysel/fredr")
rm(list = ls())

library(fredr)
library(writexl)
library(dplyr)
library(readxl)
fredr_set_key("52191461124b452b055bc68a63d07928")
ref.vin.date <- as.Date("2009-04-01")
source("UtilityFunctions.R")
DATE1 <- as.Date("1965-01-01")
DATE2 <- as.Date("2006-10-01")
########
# special definiation for real house prices due to data structure
data_ind <- 1    # 0 or 1, 0 means data length according to availbility, 
                 # 1 means data length is defined as between DATE1 and DATE2 
datalist <- list()
#== real consumption, data_CC =====================
#Data series PCECC96
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "PCECC96")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
PCECC96.data <- as.data.frame(fredr_series_observations(series_id = "PCECC96", frequency = "q", vintage_dates = closest_date))
PCECC96.data$date <- as.Date(PCECC96.data$date)

# data series CNP16OV
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
CNP16OV.data <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
CNP16OV.data$date <- as.Date(CNP16OV.data$date)



if (data_ind == 0) {
  DATE1 <- max(PCECC96.data$date[1],CNP16OV.data$date[1])
  DATE2 <- min(PCECC96.data$date[length(PCECC96.data$date)],CNP16OV.data$date[length(CNP16OV.data$date)])
}

PCECC96.data <- betweendates(DATE1,DATE2,PCECC96.data)
CNP16OV.data <- betweendates(DATE1,DATE2,CNP16OV.data)

Data1<- PCECC96.data[,-2]
Data1$value<- PCECC96.data$value/CNP16OV.data$value
Data1$value<- log(Data1$value)
log.ref.Data1<- Data1$value[1]
Data1$value<- Data1$value-log.ref.Data1
#
datalist[["Data_CC"]] <- Data1
#write_xlsx(x = Data1, path = "Data1.xlsx", col_names = TRUE)
#=====================================================

#======== inflation, data_DP =====================
#Data series IPDNBS
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "IPDNBS")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data <- as.data.frame(fredr_series_observations(series_id = "IPDNBS", frequency = "q", vintage_dates = closest_date))
series.data$date <- as.Date(series.data$date)
Data1 <-  series.data[,-2]
#
if (data_ind == 0) {
  DATE1 <- series.data$date[1]
  DATE2 <- series.data$date[length(series.data$date)]
}
Data1 <- betweendates(DATE1,DATE2,Data1)
#
Data1$value = log(Data1$value)
Data1<-first_diff(Data1)
Data1 <- vector_demean(Data1)
# 
datalist[["Data_DP"]] <- Data1
#write_xlsx(list(pi_dm_obs = Data1), path = "Data1.xlsx", col_names = TRUE)
#=====================================================

#============== real residential investment, data_IH ================
#Data series PNFIC1
# from excel, vindate = 20031125 +2007
library("readxl")
# xls files
# PRFIC1.data <- as.data.frame(read_excel("PRFIC1_Self_create.xlsx", sheet = "data"))
# PRFIC1.data$date <- as.Date(PRFIC1.data$date)
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "PRFIC1")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
PRFIC1.data <- as.data.frame(fredr_series_observations(series_id = "PRFIC1", frequency = "q", vintage_dates = closest_date))
PRFIC1.data$date <- as.Date(PRFIC1.data$date)

# data series CNP16OV
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
CNP16OV.data <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
CNP16OV.data$date <- as.Date(CNP16OV.data$date)
#
if (data_ind == 0) {
  DATE1 <- max(PRFIC1.data$date[1],CNP16OV.data$date[1])
  DATE2 <- min(PRFIC1.data$date[length(PRFIC1.data$date)],CNP16OV.data$date[length(CNP16OV.data$date)])
}
PRFIC1.data <- betweendates(DATE1,DATE2,PRFIC1.data)
CNP16OV.data <- betweendates(DATE1,DATE2,CNP16OV.data)
#
Data1<- CNP16OV.data[,-2]
Data1$value<- PRFIC1.data$value/CNP16OV.data$value
Data1$value<- log(Data1$value)
log.ref.Data1<- Data1$value[1]
Data1$value<- Data1$value-log.ref.Data1
#
datalist[["Data_IH"]] <- Data1
#write_xlsx(x = Data1, path = "Data1.xlsx", col_names = TRUE)
#=====================================================

#============== real business investment, data_IK ================
#Data series PNFIC1
# from excel, vindate = 20031125 +2007
library("readxl")
# xls files
# PNFIC1.data <- as.data.frame(read_excel("PNFIC1_Self_create.xlsx"))
# PNFIC1.data$date <- as.Date(PNFIC1.data$date)
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "PNFIC1")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
PNFIC1.data <- as.data.frame(fredr_series_observations(series_id = "PNFIC1", frequency = "q", vintage_dates = closest_date))
PNFIC1.data$date <- as.Date(PNFIC1.data$date)

# data series CNP16OV
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
CNP16OV.data <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
CNP16OV.data$date <- as.Date(CNP16OV.data$date)
#
if (data_ind == 0) {
  DATE1 <- max(PNFIC1.data$date[1],CNP16OV.data$date[1])
  DATE2 <- min(PNFIC1.data$date[length(PNFIC1.data$date)],CNP16OV.data$date[length(CNP16OV.data$date)])
}
PNFIC1.data <- betweendates(DATE1,DATE2,PNFIC1.data)
CNP16OV.data <- betweendates(DATE1,DATE2,CNP16OV.data)
#
Data1<- CNP16OV.data[,-2]
Data1$value<- PNFIC1.data$value/CNP16OV.data$value
Data1$value<- log(Data1$value)
log.ref.Data1<- Data1$value[1]
Data1$value<- Data1$value-log.ref.Data1
#
datalist[["Data_IK"]] <- Data1
#write_xlsx(x = Data1, path = "Data1.xlsx", col_names = TRUE)
#=====================================================

#===================== hours worked in the goods sector, data_NC =====================
#Data series PAYEMS
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "PAYEMS")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
PAYEMS.data <- as.data.frame(fredr_series_observations(series_id = "PAYEMS", frequency = "q", vintage_dates = closest_date))
PAYEMS.data$date <- as.Date(PAYEMS.data$date)

# data series USCONS
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "USCONS")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
USCONS.data <- as.data.frame(fredr_series_observations(series_id = "USCONS", frequency = "q", vintage_dates = closest_date))
USCONS.data$date <- as.Date(USCONS.data$date)

# data series AWHMAN
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "AWHMAN")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
AWHMAN.data <- as.data.frame(fredr_series_observations(series_id = "AWHMAN", frequency = "q", vintage_dates = closest_date))
AWHMAN.data$date <- as.Date(AWHMAN.data$date)

# data series CNP16OV
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
CNP16OV.data <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
CNP16OV.data$date <- as.Date(CNP16OV.data$date)

#
if (data_ind == 0) {
  DATE1 <- max(PAYEMS.data$date[1],USCONS.data$date[1],AWHMAN.data$date[1],CNP16OV.data$date[1])
  DATE2 <- min(PAYEMS.data$date[length(PAYEMS.data$date)],USCONS.data$date[length(USCONS.data$date)],AWHMAN.data$date[length(AWHMAN.data$date)],CNP16OV.data$date[length(CNP16OV.data$date)])
}
PAYEMS.data <- betweendates(DATE1,DATE2,PAYEMS.data)
USCONS.data <- betweendates(DATE1,DATE2,USCONS.data)
AWHMAN.data <- betweendates(DATE1,DATE2,AWHMAN.data)
CNP16OV.data <- betweendates(DATE1,DATE2,CNP16OV.data)
#
Data1<- PAYEMS.data[,-2]
Data1$value<- (PAYEMS.data$value-USCONS.data$value)*AWHMAN.data$value/CNP16OV.data$value
Data1$value<- log(Data1$value)
Data1<-vector_demean(Data1)
#
datalist[["Data_NC"]] <- Data1
#write_xlsx(x = Data1, path = "Data1.xlsx", col_names = TRUE)
#=====================================================

#======== hours worked in the residential sector, data_NH ==================
# data series USCONS
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "USCONS")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
USCONS.data <- as.data.frame(fredr_series_observations(series_id = "USCONS", frequency = "q", vintage_dates = closest_date))
USCONS.data$date <- as.Date(USCONS.data$date)

# data series CES2000000007
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CES2000000007")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
CES2000000007.data <- as.data.frame(fredr_series_observations(series_id = "CES2000000007", frequency = "q", vintage_dates = closest_date))
CES2000000007.data$date <- as.Date(CES2000000007.data$date)

# data series CNP16OV
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
CNP16OV.data <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
CNP16OV.data$date <- as.Date(CNP16OV.data$date)

#
if (data_ind == 0) {
  DATE1 <- max(USCONS.data$date[1],CES2000000007.data$date[1],CNP16OV.data$date[1])
  DATE2 <- min(USCONS.data$date[length(USCONS.data$date)],CES2000000007.data$date[length(CES2000000007.data$date)],CNP16OV.data$date[length(CNP16OV.data$date)])
}
USCONS.data <- betweendates(DATE1,DATE2,USCONS.data)
CES2000000007.data <- betweendates(DATE1,DATE2,CES2000000007.data)
CNP16OV.data <- betweendates(DATE1,DATE2,CNP16OV.data)
#
Data1<- USCONS.data[,-2]
Data1$value<- USCONS.data$value*CES2000000007.data$value/CNP16OV.data$value
Data1$value<- log(Data1$value)
Data1<-vector_demean(Data1)
#
datalist[["Data_NH"]] <- Data1
#write_xlsx(x = Data1, path = "Data1.xlsx", col_names = TRUE)
#=====================================================

#======== real house prices, data_QQ ==================
#Data series CBHPI
# from excel
# xls files
CBHPI.data <- as.data.frame(read_excel("CBHPI.xlsx",sheet = "mimicdata"))
CBHPI.data <- betweendates(1965,2006,CBHPI.data)
CBHPI.data <- CBHPI.data[,-1]
#CBHPI.data$date <- as.Date(CBHPI.data$date)
CBHPI.data<-as.data.frame(matrix(t(CBHPI.data),ncol=1))
colnames(CBHPI.data) <- "value"
#indseq <- rep(1:length(CBHPI.data$value),each=4)
#CBHPI.data<- CBHPI.data[indseq,]

# data series IPDNBS
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "IPDNBS")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
IPDNBS.data <- as.data.frame(fredr_series_observations(series_id = "IPDNBS", frequency = "q", vintage_dates = closest_date))
IPDNBS.data$date <- as.Date(IPDNBS.data$date)
#
DATE1 <- as.Date("1965-01-01")
DATE2 <- as.Date("2006-10-01")
#

IPDNBS.data <- betweendates(DATE1,DATE2,IPDNBS.data)
Data1<- IPDNBS.data[,-2]
#
Data1$value<- CBHPI.data$value/IPDNBS.data$value
Data1$value<- log(Data1$value)
log.ref.Data1<- Data1$value[1]
Data1$value<- Data1$value-log.ref.Data1
#
datalist[["Data_QQ"]] <- Data1
# write_xlsx(x = Data1, path = "Data1.xlsx", col_names = TRUE)
#=====================================================

#============ Nominal interest rate, data_RR =====================
# TB3MS data
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "TB3MS")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
series.data <- as.data.frame(fredr_series_observations(series_id = "TB3MS", frequency = "q", vintage_dates = closest_date))
series.data$date <- as.Date(series.data$date)
#
if (data_ind == 0) {
  DATE1 <- series.data$date[1]
  DATE2 <- series.data$date[length(series.data$date)]
} 

Data1 <- betweendates(DATE1,DATE2,series.data)
Data1 <- Data1[,-2]
#
Data1$value <- Data1$value/400
Data1 <- vector_demean(Data1)
#
datalist[["Data_RR"]] <- Data1
#write_xlsx(x = Data1, path = "Data1.xlsx", col_names = TRUE)
#=====================================================

#===== Write list to excel ========================
write_xlsx(datalist, path = "datalist.xlsx", col_names = TRUE)

