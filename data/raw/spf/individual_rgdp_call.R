library(readxl)
library(dplyr)
library(writexl)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))


# get the individual SPF forcasts ========================
main.data <- as.data.frame(read_excel("individual_rgdp.xlsx"))

#main.data <-  main.data %>% group_by(ID) %>% arrange(YEAR, QUARTER, .by_group = TRUE) #%>% arrange(QUARTER, .by_group = TRUE)
main.data <-  main.data %>% group_by(YEAR) %>% arrange(QUARTER, ID, .by_group = TRUE) #%>% arrange(QUARTER, .by_group = TRUE)

# all values in log, i.e. growth rate
nowcast <- (log(as.numeric(main.data$RGDP2)) - log(as.numeric(main.data$RGDP1)))*400
step1 <- (log(as.numeric(main.data$RGDP3)) - log(as.numeric(main.data$RGDP2)))*400
step2 <- (log(as.numeric(main.data$RGDP4)) - log(as.numeric(main.data$RGDP3)))*400
step3 <- (log(as.numeric(main.data$RGDP5)) - log(as.numeric(main.data$RGDP4)))*400
step4 <- (log(as.numeric(main.data$RGDP6)) - log(as.numeric(main.data$RGDP5)))*400


# merge it back
rgdpgrowthdat <- as.data.frame(cbind( "Year" = main.data$YEAR, "quater" =  main.data$QUARTER , "id" = main.data$ID , nowcast,  step1 ,  step2,
                       step3,step4 ))

# change the date format in to yyyyQx
tmp_date0 <- as.numeric()
tmp_date1 <- as.numeric()
tmp_type <- as.numeric()
for (ind0 in 1:nrow(rgdpgrowthdat)) {
  tmp_date0[ind0]<-as.numeric(paste0(rgdpgrowthdat$Year[ind0], ".",rgdpgrowthdat$quater[ind0] )) 
  tmp_date1[ind0]<-paste0(rgdpgrowthdat$Year[ind0], "Q",rgdpgrowthdat$quater[ind0] )
  tmp_type[ind0]<- paste0("SPFIndividual")
  
}

rgdpgrowthdat <- cbind("model" = tmp_type, "datenum" = tmp_date0, "date" = tmp_date1,  rgdpgrowthdat)

rgdpgrowthdat<- rgdpgrowthdat[rgdpgrowthdat[,"datenum"] > 1990.2,]

rgdpgrowthdat$datenum <- NULL
rgdpgrowthdat$Year <- NULL
rgdpgrowthdat$quater <- NULL

rgdpgrowthdat<-as.data.frame(rgdpgrowthdat)

# insert SPF mean data ============================================
mean.data <- as.data.frame(read_excel("meanLevel.xlsx", sheet = "RGDP"))
# all values in log, i.e. growth rate
nowcast <- (log(as.numeric(mean.data$RGDP2)) - log(as.numeric(mean.data$RGDP1)))*400
step1 <- (log(as.numeric(mean.data$RGDP3)) - log(as.numeric(mean.data$RGDP2)))*400
step2 <- (log(as.numeric(mean.data$RGDP4)) - log(as.numeric(mean.data$RGDP3)))*400
step3 <- (log(as.numeric(mean.data$RGDP5)) - log(as.numeric(mean.data$RGDP4)))*400
step4 <- (log(as.numeric(mean.data$RGDP6)) - log(as.numeric(mean.data$RGDP5)))*400
# merge it back

rgdpgrowthdat_mean <- as.data.frame(nd( "Year" = mean.data$YEAR, "quater" =  mean.data$QUARTER , "id" = as.numeric(rep(100000 , nrow(mean.data)) ) , nowcast,  step1 ,  step2,
                        step3,step4 ))

# same, change date type
tmp_date0 <- as.numeric()
tmp_date1 <- as.numeric()
tmp_type <- as.numeric()
tmp_id <- as.numeric()
for (ind0 in 1:nrow(rgdpgrowthdat_mean)) {
  tmp_date0[ind0]<-as.numeric(paste0(rgdpgrowthdat_mean$Year[ind0], ".",rgdpgrowthdat_mean$quater[ind0] )) 
  tmp_date1[ind0]<-paste0(rgdpgrowthdat_mean$Year[ind0], "Q",rgdpgrowthdat_mean$quater[ind0] )
  tmp_type[ind0]<- paste0("SPFMean")
  tmp_id[ind0]<- paste0("mean")
}

rgdpgrowthdat_mean$id <- tmp_id
rgdpgrowthdat_mean <- cbind("model" = tmp_type, "datenum" = tmp_date0, "date" = tmp_date1,  rgdpgrowthdat_mean)
rgdpgrowthdat_mean<- rgdpgrowthdat_mean[rgdpgrowthdat_mean[,"datenum"] > 1990.2,]
rgdpgrowthdat_mean$datenum <- NULL
rgdpgrowthdat_mean$Year <- NULL
rgdpgrowthdat_mean$quater <- NULL


rgdpgrowthdat_mean<-as.data.frame(rgdpgrowthdat_mean)


rgdgrowthmaindata<- rbind(rgdpgrowthdat,rgdpgrowthdat_mean)



#print results
write_xlsx(rgdgrowthmaindata, path = "spf_rggdp_sorted.xlsx", col_names = TRUE)

