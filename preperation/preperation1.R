library(dplyr)

#PISA 2012
load(url("https://storage.googleapis.com/opisa/newStudent2012.rda"))
PVREAD <-apply(newStudent2012%>%select(PV1READ:PV5READ), 1, mean)
PVMATH <-apply(newStudent2012%>%select(PV1MATH:PV5MATH), 1, mean)
PVSCIE <-apply(newStudent2012%>%select(PV1SCIE:PV5SCIE), 1, mean)

pisa2012<-newStudent2012%>%select(CNT, ST04Q01, ESCS, W_FSTUWT)
pisa2012<-cbind(pisa2012, PVMATH, PVREAD, PVSCIE)
save(pisa2012, file="pisa2012.rda")

#pisa 2009
load(url("https://storage.googleapis.com/opisa/newStudent2009.rda"))
PVREAD <-apply(newStudent2009%>%select(PV1READ:PV5READ), 1, mean)
PVMATH <-apply(newStudent2009%>%select(PV1MATH:PV5MATH), 1, mean)
PVSCIE <-apply(newStudent2009%>%select(PV1SCIE:PV5SCIE), 1, mean)

pisa2009<-newStudent2009%>%select(CNT, ST04Q01, ESCS, W_FSTUWT)
pisa2009<-cbind(pisa2009, PVMATH, PVREAD, PVSCIE)
save(pisa2009, file="pisa2009.rda")

#PISA 2006
load(url("https://storage.googleapis.com/opisa/newStudent2006.rda"))
PVREAD <-apply(newStudent2006%>%select(PV1READ:PV5READ), 1, mean)
PVMATH <-apply(newStudent2006%>%select(PV1MATH:PV5MATH), 1, mean)
PVSCIE <-apply(newStudent2006%>%select(PV1SCIE:PV5SCIE), 1, mean)
pisa2006<-newStudent2006%>%select(CNT, ST04Q01, ESCS, W_FSTUWT)
pisa2006<-cbind(pisa2006, PVMATH, PVREAD, PVSCIE)
save(pisa2006, file="pisa2006.rda")

#pisa 2012 fin
load(url("https://storage.googleapis.com/opisa/finStudent2012.rda"))
PVFIN <-apply(finStudent2012%>%select(PV1FLIT:PV5FLIT), 1, mean)
pisa2012fin<-finStudent2012%>%select(CNT, ST04Q01, ESCS, W_FSTUWT)
pisa2012fin<-cbind(pisa2012fin, PVFIN)
pisa2012fin$ST04Q01[pisa2012fin$ST04Q01 == 1] <- "Male"
pisa2012fin$ST04Q01[pisa2012fin$ST04Q01 == 2] <- "Female"
save(pisa2012fin, file="pisa2012fin.rda")

#pisa 2012 cba
load(url("https://storage.googleapis.com/opisa/cbaStudent2012.rda"))
PVCPRO <-apply(cbaStudent2012%>%select(PV1CPRO:PV5CPRO), 1, mean)
PVCMAT <-apply(cbaStudent2012%>%select(PV1CMAT:PV5CMAT), 1, mean)
PVCREA <-apply(cbaStudent2012%>%select(PV1CREA:PV5CREA), 1, mean)
pisa2012cpro<-cbaStudent2012%>%select(CNT, ST04Q01, ESCS, W_FSTUWT)
pisa2012cpro<-cbind(pisa2012cpro, PVCPRO, PVCMAT, PVCREA)
pisa2012cpro$ST04Q01[pisa2012cpro$ST04Q01 == 1] <- "Male"
pisa2012cpro$ST04Q01[pisa2012cpro$ST04Q01 == 2] <- "Female"
save(pisa2012cpro, file="pisa2012cpro.rda")