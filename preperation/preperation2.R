#before prepatre table
library(dplyr)
load("~/R/tikhinuch4/prepare/pisa2012.rda")
data<-pisa2012cpro
cou<-read.csv("data/countries.csv", header = TRUE, sep=",", stringsAsFactors=F)
countries<-cou$CNT
Year<-Country<-Subject<-Gender<-Performers<-ESCS<-Average<-c()
expertisedf<-read.csv("data/expertise.csv", header = TRUE, sep=",", stringsAsFactors=F)

#files and subjects
#pisa2012:PVMATH, PVSCIE, PVREAD | more math
#pisa2009:PVMATH, PVSCIE, PVREAD
#pisa2006:PVMATH, PVSCIE, PVREAD
#pisa2012cpro: PVCPRO (ProblemSolving), PVCMAT (DigitalMath), PVCREA (DigitalReading)
#pisa2012fin: PVFIN (Financial)

#after prepare table tests
save(df, file="df.rda")

unique(df$Year)
unique(df$Subject)
unique(df$Gender)
unique(df$Performers)
unique(df$ESCS)
min(pisaData1$Average)
max(pisaData1$Average)

pisaData1<-df
pisaData1$Average<-round(pisaData1$Average, digits = 1)
save(pisaData1, file="pisaData1.rda")

p<-as.data.frame(pisa2012)
p<-as.data.frame(pisa2012, stringsAsFactors = F)
df$Gender[df$Gender == "Man"] <- "Male"
mynew[duplicated(mynew), ]
#Get rid of row names 
rownames(df)<-c()

pisaData<-filter(pisaData, Average<700)
pisaData<-filter(pisaData, Average!=0)

isrPerformers<-pisaData%>%filter(Performers!=0, Country=="ISR", Subject=="Math")
isrPerformers$Average<-round(isrPerformers$Average, digits = 1)
write.csv(isrPerformers, file="isrPerformers.csv", row.names = FALSE, quote = FALSE)




