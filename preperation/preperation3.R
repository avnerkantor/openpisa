
#### General ####
#1 General mean
GeneralMean<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x) %>% select(PVCREA, W_FSTUWT)
  weighted.mean(x=temp[,"PVCREA"], w=(temp[,"W_FSTUWT"]))
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender=0, Performers=0, ESCS=0, Average=GeneralMean)
#df<-dm
df<-rbind(df, dm)
#2 Male mean
MaleMean<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Male") %>% select(PVCREA, W_FSTUWT)
  weighted.mean(x=temp[,"PVCREA"], w=(temp[,"W_FSTUWT"]))
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Male", Performers=0, ESCS=0, Average=MaleMean)
df<-rbind(df, dm)

#3 Female mean
FemaleMean<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Female") %>% select(PVCREA, W_FSTUWT)
  weighted.mean(x=temp[,"PVCREA"], w=(temp[,"W_FSTUWT"]))
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Female", Performers=0, ESCS=0, Average=FemaleMean)
df<-rbind(df, dm)
#### Performers ####
#4 High Performers
HighPerformers<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, PVCREA>=expertisedf$PVCREA[1])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender=0, Performers="High", ESCS=0, Average=HighPerformers)
df<-rbind(df, dm)
#5 Low Performers
LowPerformers<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender=0, Performers="Low", ESCS=0, Average=LowPerformers)
df<-rbind(df, dm)
#6 High Performers Male Mean
HighPerformersMale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Male", PVCREA>=expertisedf$PVCREA[1])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Male", Performers="High", ESCS=0, Average=HighPerformersMale)
df<-rbind(df, dm)
#13 Low Performers Female Mean
LowPerformersFemale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Female", PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Female", Performers="Low", ESCS=0, Average=LowPerformersFemale)
df<-rbind(df, dm)
#7 High Performers Female Mean
HighPerformersFemale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Female", PVCREA>=expertisedf$PVCREA[1])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Female", Performers="High", ESCS=0, Average=HighPerformersFemale)
df<-rbind(df, dm)
#8 Low Performers Male Mean
LowPerformersMale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Male", PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Male", Performers="Low", ESCS=0, Average=LowPerformersMale)
df<-rbind(df, dm)
#### ESCS General #####

#14 Low Escs Mean
LowEscsMean<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ESCS < -0.2) %>% select(PVCREA, W_FSTUWT)
  weighted.mean(x=temp[,"PVCREA"], w=(temp[,"W_FSTUWT"]))
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender=0, Performers=0, ESCS="Low", Average=LowEscsMean)
df<-rbind(df, dm)
#15 Medium Escs Mean
MediumEscsMean<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ESCS >= -0.2 & ESCS <= 0.7) %>% select(PVCREA, W_FSTUWT)
  weighted.mean(x=temp[,"PVCREA"], w=(temp[,"W_FSTUWT"]))
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender=0, Performers=0, ESCS="Medium", Average=MediumEscsMean)
df<-rbind(df, dm)
#16 High Escs Mean
HighEscsMean<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ESCS > 0.7) %>% select(PVCREA, W_FSTUWT)
  weighted.mean(x=temp[,"PVCREA"], w=(temp[,"W_FSTUWT"]))
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender=0, Performers=0, ESCS="High", Average=HighEscsMean)
df<-rbind(df, dm)
#### ESCS Proficiency #####

##### General ESCS Proficiency ##### 
#1 High Performers Escs High
HighPerformersEscsHigh<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ESCS > 0.7, PVCREA>=expertisedf$PVCREA[1])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender=0, Performers="High", ESCS="High", Average=HighPerformersEscsHigh)
df<-rbind(df, dm)
#2 High Performers Escs Low
HighPerformersEscsLow<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ESCS < -0.2, PVCREA>=expertisedf$PVCREA[1])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender=0, Performers="High", ESCS="Low", Average=HighPerformersEscsLow)
df<-rbind(df, dm)
#3 Low Performers Escs High
LowPerformersEscsHigh<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ESCS > 0.7, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender=0, Performers="Low", ESCS="High", Average=LowPerformersEscsHigh)
df<-rbind(df, dm)
#4 Low Performers Escs Low
LowPerformersEscsLow<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ESCS < -0.2, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender=0, Performers="Low", ESCS="Low", Average=LowPerformersEscsLow)
df<-rbind(df, dm)
#5 Low Performers Escs Medium
LowPerformersEscMedium<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ESCS <= 0.7 & ESCS >= -0.2, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender=0, Performers="Low", ESCS="Medium", Average=LowPerformersEscMedium)
df<-rbind(df, dm)
#6 High Performers Escs Medium
HighPerformersEscsMedium<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x,ESCS <= 0.7 & ESCS >= -0.2, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender=0, Performers="High", ESCS="Medium", Average=HighPerformersEscsMedium)
df<-rbind(df, dm)
##### Male ESCS Proficiency ##### 
HighPerformersEscsHighMale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Male", ESCS > 0.7, PVCREA>=expertisedf$PVCREA[1])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Male", Performers="High", ESCS="High", Average=HighPerformersEscsHighMale)
df<-rbind(df, dm)
#2 High Performers Escs Low
HighPerformersEscsLowMale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Male", ESCS < -0.2, PVCREA>=expertisedf$PVCREA[1])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Male", Performers="High", ESCS="Low", Average=HighPerformersEscsLowMale)
df<-rbind(df, dm)
#3 Low Performers Escs High
LowPerformersEscsHighMale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Male", ESCS > 0.7, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Male", Performers="Low", ESCS="High", Average=LowPerformersEscsHighMale)
df<-rbind(df, dm)
#4 Low Performers Escs Low
LowPerformersEscsLowMale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Male", ESCS < -0.2, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Male", Performers="Low", ESCS="Low", Average=LowPerformersEscsLowMale)
df<-rbind(df, dm)
#5 Low Performers Escs Medium
LowPerformersEscMediumMale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Male", ESCS <= 0.7 & ESCS >= -0.2, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Male", Performers="Low", ESCS="Medium", Average=LowPerformersEscMediumMale)
df<-rbind(df, dm)
#6 High Performers Escs Medium
HighPerformersEscsMediumMale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x,ST04Q01 == "Male", ESCS <= 0.7 & ESCS >= -0.2, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Male", Performers="High", ESCS="Medium", Average=HighPerformersEscsMediumMale)
df<-rbind(df, dm)
##### Female ESCS Proficiency ##### 
HighPerformersEscsHighFemale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Female", ESCS > 0.7, PVCREA>=expertisedf$PVCREA[1])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Female", Performers="High", ESCS="High", Average=HighPerformersEscsHighFemale)
df<-rbind(df, dm)
#2 High Performers Escs Low
HighPerformersEscsLowFemale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Female", ESCS < -0.2, PVCREA>=expertisedf$PVCREA[1])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Female", Performers="High", ESCS="Low", Average=HighPerformersEscsLowFemale)
df<-rbind(df, dm)
#3 Low Performers Escs High
LowPerformersEscsHighFemale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Female", ESCS > 0.7, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Female", Performers="Low", ESCS="High", Average=LowPerformersEscsHighFemale)
df<-rbind(df, dm)
#4 Low Performers Escs Low
LowPerformersEscsLowFemale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Female", ESCS < -0.2, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Female", Performers="Low", ESCS="Low", Average=LowPerformersEscsLowFemale)
df<-rbind(df, dm)
#5 Low Performers Escs Medium
LowPerformersEscMediumFemale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Female", ESCS <= 0.7 & ESCS >= -0.2, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Female", Performers="Low", ESCS="Medium", Average=LowPerformersEscMediumFemale)
df<-rbind(df, dm)
#6 High Performers Escs Medium
HighPerformersEscsMediumFemale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x,ST04Q01 == "Female", ESCS <= 0.7 & ESCS >= -0.2, PVCREA<=expertisedf$PVCREA[2])
  nrow(temp)/nrow(data %>% filter(CNT==x))*100
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Female", Performers="High", ESCS="Medium", Average=HighPerformersEscsMediumFemale)
df<-rbind(df, dm)
#### ESCS Gender #####

#17 Low Escs Mean Male
LowEscsMeanMale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Male", ESCS < -0.2) %>% select(PVCREA, W_FSTUWT)
  weighted.mean(x=temp[,"PVCREA"], w=(temp[,"W_FSTUWT"]))
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Male", Performers=0, ESCS="Low", Average=LowEscsMeanMale)
df<-rbind(df, dm)
#18 Low Escs Mean Female
LowEscsMeanFemale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Female", ESCS < -0.2) %>% select(PVCREA, W_FSTUWT)
  weighted.mean(x=temp[,"PVCREA"], w=(temp[,"W_FSTUWT"]))
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Female", Performers=0, ESCS="Low", Average=LowEscsMeanFemale)
df<-rbind(df, dm)
#19 Medium Escs Mean Male
MediumEscsMeanMale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Male", ESCS >= -0.2 & ESCS <= 0.7) %>% select(PVCREA, W_FSTUWT)
  weighted.mean(x=temp[,"PVCREA"], w=(temp[,"W_FSTUWT"]))
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Male", Performers=0, ESCS="Medium", Average=MediumEscsMeanMale)
df<-rbind(df, dm)
#20 Medium Escs Mean Female
MediumEscsMeanFemale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Female", ESCS >= -0.2 & ESCS <= 0.7) %>% select(PVCREA, W_FSTUWT)
  weighted.mean(x=temp[,"PVCREA"], w=(temp[,"W_FSTUWT"]))
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Female", Performers=0, ESCS="Medium", Average=MediumEscsMeanFemale)
df<-rbind(df, dm)
#21 High Escs Mean Male
HighEscsMeanMale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Male", ESCS > 0.7) %>% select(PVCREA, W_FSTUWT)
  weighted.mean(x=temp[,"PVCREA"], w=(temp[,"W_FSTUWT"]))
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Male", Performers=0, ESCS="High", Average=HighEscsMeanMale)
df<-rbind(df, dm)
#22 High Escs Mean Female
HighEscsMeanFemale<-sapply(countries, function(x){
  temp<-data %>% filter(CNT==x, ST04Q01 == "Female", ESCS > 0.7) %>% select(PVCREA, W_FSTUWT)
  weighted.mean(x=temp[,"PVCREA"], w=(temp[,"W_FSTUWT"]))
})
dm<-data.frame(Year=2012, Country=countries, Subject="DigitalReading", Gender="Female", Performers=0, ESCS="High", Average=HighEscsMeanFemale)
df<-rbind(df, dm)