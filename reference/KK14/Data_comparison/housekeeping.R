# install.packages("devtools")
# library(devtools)
# devtools::install_github("sboysel/fredr")
rm(list = ls())

library(fredr)
library(writexl)
library(dplyr)
library(readxl)
fredr_set_key("52191461124b452b055bc68a63d07928")
ref.vin.date <- as.Date("2012-12-31")
source("UtilityFunctions.R")
DATE1 <- as.Date("1983-01-01") # 1983Q1
DATE2 <- as.Date("2008-09-30")  # 2008Q3  
########
# special definiation for real house prices due to data structure
data_ind <- 1    # 0 or 1, 0 means data length according to availbility, 
# 1 means data length is defined as between DATE1 and DATE2 
datalist <- list()
