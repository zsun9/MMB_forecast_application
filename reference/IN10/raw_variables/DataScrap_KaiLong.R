# install.packages("devtools")
# library(devtools)
# devtools::install_github("sboysel/fredr")
library(fredr)
fredr_set_key("52191461124b452b055bc68a63d07928")


# # List all the series ID to be downloaded
#  alfred_list <- c("PCEC96",
# "PNFIC1",
# "PRFIC1",
# "TB3MS",
# "IPDNBS",
# "PAYEMS",
# "USCONS",
# "AWHMAN",
# "AWHAECON",
# "CES2000000008")


##########################################
# Generate a excel file per series ID, vintage dates as column names
##########################################
# temp.vintagedates<- fredr_series_vintagedates(series_id = "PCEC96")
# temp.vintagedates<-as.Date(temp.vintagedates[[1]])
# vin.extract.tmp <- fredr(series_id = "PCEC96", vintage_dates = temp.vintagedates[length(temp.vintagedates)])
# alfred.data<-as.data.frame(vin.extract.tmp[,1])
# for (ii in 1:length(temp.vintagedates)){  # ii<-1
#   vin.extract.tmp <- fredr(series_id = "PCEC96", vintage_dates = temp.vintagedates[length(temp.vintagedates)+1-ii])
#   tmp.data <- vin.extract.tmp[,3]
#   colnames(tmp.data) <- paste("vintage",temp.vintagedates[length(temp.vintagedates)+1-ii], sep = "")
#   vin.specific<-cbind(vin.extract.tmp[,1],tmp.data)
#   alfred.data<-merge(x=alfred.data,y=vin.specific,by="date",all.x=TRUE)
# }

## code is not ready, API request fail using this method (too frequent)





#PCESVC96.vintagedates[[1]][2]
#as.Date(df$Date, "%m/%d/%Y %H:%M:%S")
library(writexl)
write_xlsx(x = CNP16OV, path = "CNP16OV.xlsx", col_names = TRUE)
