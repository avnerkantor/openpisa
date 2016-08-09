# Israel
#הוספת מגזרים בעקבות קבצי ראמה
#חמישה סך הכל

#Student 2012
student2012ISR<-student2012a%>%filter(CNT=="ISR")
rama2012<-read.csv("rama2012m.csv")
temp<-left_join(student2012ISR, rama2012, by=c("SCHOOLID"="SCHOOLID"))
temp<-temp%>%select(-CNT)
names(temp)[names(temp) == 'General.Stratum'] <- 'CNT'
student2012ISRGroups<-temp%>%select(-Language.of.test, -SES.Israeli)
temp<-temp%>%select(-CNT)
names(temp)[names(temp) == 'Language.of.test'] <- 'CNT'
student2012ISRLanguages<-temp%>%select(-SES.Israeli)
student2012b<-bind_rows(student2012a, student2012ISRGroups)
student2012b<-bind_rows(student2012a, student2012ISRLanguages)
save(student2012b, file="student2012b.rda")

#Pisa 2009
isrStudent2009<-student2009a%>%filter(CNT=="ISR")
rama2009<-read.csv("rama2009m.csv")
temp<-left_join(isrStudent2009, rama2009, by=c("SCHOOLID"="SCHOOLID"))
temp<-temp%>%select(-CNT)
names(temp)[names(temp) == 'General.Stratum'] <- 'CNT'
isrStudent2009Groups<-temp%>%select(-Language.of.test)
temp<-temp%>%select(-CNT)
names(temp)[names(temp) == 'Language.of.test'] <- 'CNT'
isrStudent2009Languages<-temp
student2009b<-bind_rows(student2009a, isrStudent2009Groups)
student2009b<-bind_rows(student2009b, isrStudent2009Languages)
save(student2009, file="student2009b.rda")

#pisa 2006
isrStudent2006<-student2006%>%filter(CNT=="ISR")
rama2006<-read.csv("rama2006m.csv")
temp<-left_join(isrStudent2006, rama2006, by=c("SCHOOLID"="SCHOOLID"))
temp<-temp%>%select(-CNT)
names(temp)[names(temp) == 'General.Stratum'] <- 'CNT'
isrStudent2006Groups<-temp%>%select(-Language.of.test)
temp<-temp%>%select(-CNT)
names(temp)[names(temp) == 'Language.of.test'] <- 'CNT'
isrStudent2006Languages<-temp%>%select(-SES.Israeli)
student2006b<-bind_rows(student2006a, isrStudent2006Groups)
student2006b<-bind_rows(student2006b, isrStudent2006Languages)
save(student2006b, file="student2006b.rda")

##Israel Financial Data
temp<-finStudent2012%>%filter(CNT=="ISR")
rama2012<-read.csv("rama2012m.csv")
temp<-left_join(temp, rama2012, by=c("SCHOOLID"="SCHOOLID"))
temp<-temp%>%select(-CNT)
names(temp)[names(temp) == 'General.Stratum'] <- 'CNT'
student2012ISRGroups<-temp%>%select(-Language.of.test, -SES.Israeli)
temp<-temp%>%select(-CNT)
names(temp)[names(temp) == 'Language.of.test'] <- 'CNT'
student2012ISRLanguages<-temp%>%select(-SES.Israeli)
finStudent2012<-bind_rows(finStudent2012, student2012ISRGroups)
finStudent2012<-bind_rows(finStudent2012, student2012ISRLanguages)
save(finStudent2012, file="finStudent2012.rda")

#CBA Israel Data
temp<-cbaStudent2012%>%filter(CNT=="ISR")
rama2012<-read.csv("rama2012m.csv")
temp<-left_join(temp, rama2012, by=c("SCHOOLID"="SCHOOLID"))
temp<-temp%>%select(-CNT)
names(temp)[names(temp) == 'General.Stratum'] <- 'CNT'
student2012ISRGroups<-temp%>%select(-Language.of.test, -SES.Israeli)
temp<-temp%>%select(-CNT)
names(temp)[names(temp) == 'Language.of.test'] <- 'CNT'
student2012ISRLanguages<-temp%>%select(-SES.Israeli)
cbaStudent2012<-bind_rows(cbaStudent2012, student2012ISRGroups)
cbaStudent2012<-bind_rows(cbaStudent2012, student2012ISRLanguages)
save(cbaStudent2012, file="cbaStudent2012.rda")

#School 2012
school2012ISR<-school2012%>%filter(CNT=="ISR")
rama2012<-read.csv("rama2012m.csv")
temp<-left_join(school2012ISR, rama2012, by=c("SCHOOLID"="SCHOOLID"))
temp<-temp%>%select(-CNT)
names(temp)[names(temp) == 'General.Stratum'] <- 'CNT'
school2012ISRGroups<-temp%>%select(-Language.of.test, -SES.Israeli)
temp<-temp%>%select(-CNT)
names(temp)[names(temp) == 'Language.of.test'] <- 'CNT'
school2012ISRLanguages<-temp%>%select(-SES.Israeli)
school2012b<-bind_rows(school2012, school2012ISRGroups)
school2012b<-bind_rows(school2012, school2012ISRLanguages)
save(school2012b, file="school2012b.rda")