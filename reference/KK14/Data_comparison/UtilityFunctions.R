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