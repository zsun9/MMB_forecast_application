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
#Data series CBHPI
# from excel
library("readxl")
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


DATE1 <- as.Date("1965-01-01")
DATE2 <- as.Date("2006-10-01")
IPDNBS.data <- betweendates(DATE1,DATE2,IPDNBS.data)

Data1<- IPDNBS.data[,-2]

Data1$value<- CBHPI.data$value/IPDNBS.data$value

Data1$value<- log(Data1$value)

log.ref.Data1<- Data1$value[1]

Data1$value<- Data1$value-log.ref.Data1



library(writexl)
write_xlsx(x = Data1, path = "Data1.xlsx", col_names = TRUE)
