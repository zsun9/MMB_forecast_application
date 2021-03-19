# function that plots with adjusting y-axis
plot2graphs_rep_ori <- function(vec1, vec2, datevec, legpos) {
  line1=as.numeric(vec1)
  line2=as.numeric(vec2)
  plot(datevec,line1,type="l",col="black",ylab="", xlab="date", ylim=c(min(min(line1),min(line2)),max(max(line1),max(line2))))
  lines(datevec,line2,col="red")
  legend(legpos, legend = c("replicated", "original"), col=c("black", "red"),lty=1, pch=NA)
 }



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
  dataset<-as.data.frame(dataset #%>% group_by(series_id)
                         %>% mutate_at(vars(value), list(~ .x - lag(.x))))
  return(dataset)
}
#----------------------------------------------------------------------------------------