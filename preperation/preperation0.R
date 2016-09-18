#pisa2012
library(dplyr)
#library(data.table)
#library(dtplyr)
load(url("https://storage.googleapis.com/opisa/student2012b.rda"))
load("/srv/shiny-server/school2012.rda")
school2012<-school2012%>%select(-CNT, -SUBNATIO, -STRATUM, -OECD)
school2012$SCHOOLID<-as.integer(school2012$SCHOOLID)
pisa2012<-left_join(student2012, school2012, by=c("NC"="NC", "SCHOOLID"="SCHOOLID"))
#fwrite(pisa2012, "pisa2012.csv", verbose=TRUE, quote=TRUE)
write.csv(pisa2012, file="pisa2012.csv")
#read.csv("pisa2012.csv", header = TRUE, sep=",")
#fread('pisa2012.csv', header = T, sep = ',') 

gcloud compute --project "r-shiny-1141" ssh --zone "europe-west1-c" "opisa2"
gsutil -m cp pisa2012.csv gs://opisa/  
  bq load --autodetect --skip_leading_rows=1 --max_bad_records=100000000 pisa.pisa2012 gs://opisa/pisa2012.csv

load(url("https://storage.googleapis.com/opisa/newStudent2009.rda"))
#school2009<-school2009%>%select(-CNT, -SUBNATIO, -STRATUM, -OECD)
#escs<-as.numeric(newStudent2009$ESCS)
#newStudent2009$ESCS<-as.numeric(newStudent2009$ESCS)
school2009$SCHOOLID<-as.integer(school2009$SCHOOLID)

#3
#It's looks like the only solution because I tranform numeric to character while I still have numeric/character
low<-newStudent2009 %>%filter(ESCS < -0.2)
high<-newStudent2009%>%filter(ESCS > 0.7)
medium<-newStudent2009%>%filter(ESCS <= 0.7, ESCS >= -0.2)
myna<-newStudent2009%>%filter(is.na(ESCS))

low$ESCS<-"Low"
medium$ESCS<-"Medium"
high$ESCS<-"High"

pisa2009<-rbind(low, high, medium, myna)

#2
newStudent2009 %>%filter
mutate(ESCS1=replace(ESCS1, ESCS < -0.2, NA)) %>%
  as.data.frame()

#1
newStudent2009$ESCS[newStudent2009$ESCS < "-0.2"] <- "Low"
newStudent2009$ESCS[newStudent2009$ESCS > "0.7"] <- "High"
newStudent2009$ESCS[newStudent2009$ESCS >= -0.2 & newStudent2009$ESCS <= 0.7] <- "Medium"
table(newStudent2009$ESCS)

#1b
pisa2006$ESCS[pisa2006$ESCS < -0.2] <- "Low"
pisa2006$ESCS[pisa2006$ESCS > 0.7] <- "High"
pisa2006$ESCS[pisa2006$ESCS >= -0.2 & pisa2006$ESCS <= 0.7] <- "Medium"


pisa2009<-left_join(pisa2009, school2009, by=c("COUNTRY"="CNT", "SCHOOLID"="SCHOOLID"))

write.csv(pisa2009, file="pisa2009.csv")


load(url("https://storage.googleapis.com/opisa/newStudent2006.rda"))

low<-newStudent2006 %>%filter(ESCS < -0.2)
high<-newStudent2006%>%filter(ESCS > 0.7)
medium<-newStudent2006%>%filter(ESCS <= 0.7, ESCS >= -0.2)
myna<-newStudent2006%>%filter(is.na(ESCS))

low$ESCS<-"Low"
medium$ESCS<-"Medium"
high$ESCS<-"High"

pisa2006<-rbind(low, high, medium, myna)
school2006$SCHOOLID<-as.integer(school2006$SCHOOLID)

pisa2006<-left_join(pisa2006, school2006, by=c("COUNTRY"="CNT", "SCHOOLID"="SCHOOLID"))
write.csv(pisa2006, file="pisa2006.csv")
