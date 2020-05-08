# install.packages("devtools")
# library(devtools)
# devtools::install_github("sboysel/fredr")
rm(list = ls())

library(fredr)
fredr_set_key("52191461124b452b055bc68a63d07928")
#----------------------------------------------------------------------------------------
# function search for closest vintage date
clost_vin_search <- function(tmpdataset.vindates , tmpdate ){
  if (tmpdataset.vindates[1]< tmpdate) {
    tmpdate <- as.Date(tmpdate)
    trundates<-tmpdataset.vindates[tmpdataset.vindates <= tmpdate]
    the.date <- trundates[which(abs(trundates-tmpdate) == min(abs(trundates - tmpdate)))]
    
  } else {
    the.date <- as.Date(tmpdataset.vindates[1])
  }
  return(as.Date(the.date))
}
#----------------------------------------------------------------------------------------
# function that subset the data between dates
betweendates <- function(x,y,dataset123){dataset123[dataset123$date >= x & dataset123$date <= y,]}
#----------------------------------------------------------------------------------------
# demean function while preserving the dataset
vector_demean <- function(dataset123){
  dataset123$value <- dataset123$value - mean(dataset123$value,na.rm=TRUE)
  return(dataset123)
}
#----------------------------------------------------------------------------------------
# demean using steady state
ss_demean <- function(dataset123, ss){
  dataset123$value <- dataset123$value - ss
  return(dataset123)
}
#----------------------------------------------------------------------------------------
# First difference function while preserving the dataset
first_diff<- function(dataset){
  library(dplyr)
  dataset<-as.data.frame(dataset %>% group_by(series_id) %>% mutate_at(vars(value), list(~ .x - lag(.x))))
  return(dataset)
}
#----------------------------------------------------------------------------------------
ref.vin.date <- as.Date("2007-04-01")
#Data series PNFIC1
# from excel, vindate = 20031125 +2007
library("readxl")
# xls files
PNFIC1.data <- as.data.frame(read_excel("PNFIC1_Self_create.xlsx"))
PNFIC1.data$date <- as.Date(PNFIC1.data$date)
# tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "PNFIC1")[[1]])
# closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
# PNFIC1.data <- as.data.frame(fredr_series_observations(series_id = "PNFIC1", frequency = "q", vintage_dates = closest_date))
# PNFIC1.data$date <- as.Date(PNFIC1.data$date)

# data series CNP16OV
tmp.vindates<- as.Date(fredr_series_vintagedates(series_id = "CNP16OV")[[1]])
closest_date <- clost_vin_search(tmp.vindates, ref.vin.date )
CNP16OV.data <- as.data.frame(fredr_series_observations(series_id = "CNP16OV", frequency = "q", vintage_dates = closest_date))
CNP16OV.data$date <- as.Date(CNP16OV.data$date)



DATE1 <- as.Date("1965-01-01")
DATE2 <- as.Date("2006-10-01")

PNFIC1.data <- betweendates(DATE1,DATE2,PNFIC1.data)
CNP16OV.data <- betweendates(DATE1,DATE2,CNP16OV.data)

Data1<- CNP16OV.data[,-2]

Data1$value<- PNFIC1.data$value/CNP16OV.data$value

Data1$value<- log(Data1$value)

log.ref.Data1<- Data1$value[1]

Data1$value<- Data1$value-log.ref.Data1





#============= real business investment , PNFIC1/CNP160V



# Calculate inflation using the definition of the Appendix
# Definition: Quater change, ln , demean

# 
# 
# PCEC96.data <- fredr_series_observations(series_id = "PCEC96", frequency = "q", vintage_dates = as.Date("1994-09-30" ))
# CNP16OV.data<- fredr_series_observations(series_id = "PCEC96", frequency = "q", vintage_dates = as.Date("1996-12-06" ))
# 
# PCEC96.data<- as.data.frame(PCEC96.data)
# CNP16OV.data<- as.data.frame(CNP16OV.data)
# PCEC96.data$date <- as.Date(PCEC96.data$date)
# CNP16OV.data$date <- as.Date(CNP16OV.data$date)
# 
# 
# 
# 
# Test1 <- betweendates(DATE1,DATE2,PCEC96.data)
# Test2 <- betweendates(DATE1,DATE2,CNP16OV.data)
# 
# data_CC.table <- cbind(Test1[,c(1,3)],Test2[,c(3)])
# colnames(data_CC.table) <- c("data", "PCEC96", "CNP16OV")
# 
# ref.data <- log(data_CC.table[1,2]/data_CC.table[1,3])
# 
# data_CC <- log(data_CC.table[,2])/log(data_CC.table[,3]) - ref.data
# data_CC <- as.data.frame(data_CC)
# 
# 
# 





#PCESVC96.vintagedates[[1]][2]
#as.Date(df$Date, "%m/%d/%Y %H:%M:%S")
library(writexl)
write_xlsx(x = Data1, path = "Data1.xlsx", col_names = TRUE)
