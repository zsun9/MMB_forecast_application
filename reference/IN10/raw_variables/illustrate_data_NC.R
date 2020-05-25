# install.packages("devtools")
# library(devtools)
# devtools::install_github("sboysel/fredr")
rm(list = ls())

library(fredr)
library(writexl)
library(dplyr)
library(readxl)
fredr_set_key("52191461124b452b055bc68a63d07928")

# set parameters =======================
ref.vin.date <- as.Date("2009-04-01")
source("UtilityFunctions.R")
DATE1 <- as.Date("1965-01-01")
DATE2 <- as.Date("2006-10-01")

# acquire data =======================
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

#truncate data ===========================
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
# write excel =======================
write_xlsx(x = Data1, path = "Data1.xlsx", col_names = TRUE)