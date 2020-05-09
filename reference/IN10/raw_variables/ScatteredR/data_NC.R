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


DATE1 <- as.Date("1965-01-01")
DATE2 <- as.Date("2006-10-01")

PAYEMS.data <- betweendates(DATE1,DATE2,PAYEMS.data)
USCONS.data <- betweendates(DATE1,DATE2,USCONS.data)
AWHMAN.data <- betweendates(DATE1,DATE2,AWHMAN.data)
CNP16OV.data <- betweendates(DATE1,DATE2,CNP16OV.data)

Data1<- PAYEMS.data[,-2]

Data1$value<- (PAYEMS.data$value-USCONS.data$value)*AWHMAN.data$value/CNP16OV.data$value

Data1$value<- log(Data1$value)

Data1<-vector_demean(Data1)








#PCESVC96.vintagedates[[1]][2]
#as.Date(df$Date, "%m/%d/%Y %H:%M:%S")
library(writexl)
write_xlsx(x = Data1, path = "Data1.xlsx", col_names = TRUE)
