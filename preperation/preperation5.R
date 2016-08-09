#Survey

#### General ####
#1 General mean
for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x)%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender=0, Performers=e$labels, ESCS=0, Average=e$value)
  df<-rbind(df, dm)    
} 

#2 Male mean
for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x, ST04Q01 == "Male")%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender="Male", Performers=e$labels, ESCS=0, Average=e$value)
  df<-rbind(df, dm)    
} 

#3 Female mean
for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x, ST04Q01 == "Female")%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender="Female", Performers=e$labels, ESCS=0, Average=e$value)
  df<-rbind(df, dm)    
} 
#### ESCS General #####

#14 Low Escs Mean
for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x, ESCS < -0.2)%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender=0, Performers=e$labels, ESCS="Low", Average=e$value)
  df<-rbind(df, dm)    
} 
#15 Medium Escs Mean
for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x, ESCS >= -0.2 & ESCS <= 0.7)%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender=0, Performers=e$labels, ESCS="Medium", Average=e$value)
  df<-rbind(df, dm)    
}
#16 High Escs Mean
for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x, ESCS > 0.7)%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender=0, Performers=e$labels, ESCS="High", Average=e$value)
  df<-rbind(df, dm)    
}
#### ESCS Gender #####

#17 Low Escs Mean Male
for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x, ESCS < 0.2, ST04Q01=="Male")%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender="Male", Performers=e$labels, ESCS="Low", Average=e$value)
  df<-rbind(df, dm)    
}
#18 Low Escs Mean Female
for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x, ESCS < 0.2, ST04Q01=="Female")%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender="Female", Performers=e$labels, ESCS="Low", Average=e$value)
  df<-rbind(df, dm)    
}
#19 Medium Escs Mean Male
for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x, ESCS >= -0.2 & ESCS <= 0.7, ST04Q01=="Male")%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender="Male", Performers=e$labels, ESCS="Medium", Average=e$value)
  df<-rbind(df, dm)    
}
#20 Medium Escs Mean Female
for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x, ESCS >= -0.2 & ESCS <= 0.7, ST04Q01=="Male")%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender="Female", Performers=e$labels, ESCS="Medium", Average=e$value)
  df<-rbind(df, dm)    
}
#21 High Escs Mean Male
for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x, ESCS > 0.7, ST04Q01=="Male")%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender="Male", Performers=e$labels, ESCS="High", Average=e$value)
  df<-rbind(df, dm)    
}
#22 High Escs Mean Female
for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x, ESCS > 0.7, ST04Q01=="Male")%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender="Female", Performers=e$labels, ESCS="High", Average=e$value)
  df<-rbind(df, dm)    
}