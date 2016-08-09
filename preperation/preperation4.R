load(url("https://storage.googleapis.com/opisa/newStudent2012.rda"))
load(url("https://storage.googleapis.com/opisa/newStudent2009.rda"))
load(url("https://storage.googleapis.com/opisa/newStudent2006.rda"))
pisa2012<-names(newStudent2012)
pisa2009<-names(newStudent2009)
pisa2006<-names(newStudent2006)
write.csv(pisa2012, file="pisa2012.csv", row.names=FALSE, quote=F)
write.csv(pisa2009, file="pisa2009.csv", row.names=FALSE, quote=F)
write.csv(pisa2006, file="pisa2006.csv", row.names=FALSE, quote=F)

p2012<-read.csv("pisa2012.csv")
p2009<-read.csv("pisa2009.csv")
p2006<-read.csv("pisa2006.csv")

# inter0609<-as.data.frame(intersect(p2006$x, p2009$x))
# inter0912<-as.data.frame(intersect(p2009$x, p2012$x))
# inter0612<-as.data.frame(intersect(p2006$x, p2009$x))
# diff0609<-as.data.frame(setdiff(p2006$x, p2009$x))
# diff0912<-as.data.frame(setdiff(p2009$x, p2012$x))
# diff0612<-as.data.frame(setdiff(p2006$x, p2012$x))
#orrr
c<-semi_join(p2006,p2009, by="x")
answer: 241
c<-semi_join(p2009,p2012, by="x")
answer: 153
c<-semi_join(semi_join(p2006,p2009, by="x"),p2012, by="x")
answer: 99
psi<-read.csv("PisaSelectIndex.csv")
d<-left_join(b, psi, by=c("x"="ID"))

load("~/R/tikhinuch4/dict/student2012dict.rda")
s2012dict<-as.data.frame(student2012dict)

#newStudent2012
ids<-names(student2012dict)
myids<-ids[which(ids=="ST26Q01"):which(ids=="ST24Q03")]

cou<-read.csv("data/countries.csv", header = TRUE, sep=",", stringsAsFactors=F)
countries<-cou$CNT

load(url("https://storage.googleapis.com/opisa/newStudent2012.rda"))
data<-newStudent2012

df<-dm<-data.frame(Year=c(), Country=c(), ID=c(), Gender=c(), Performers=c(), ESCS=c(), Var1=c(),	Freq=c())

for (x in countries){
  d<-sapply(myids, function(y){
    round(prop.table(table(data%>%filter(CNT==x)%>%select_(.dots=c(y)), exclude=NULL))*100)
  })
  e<-melt(d, na.rm=T)
  dm<-data.frame(Year=2012, Country=x, ID=e$L1, Gender=0, Performers=e$labels, ESCS=0, Average=e$value)
  df<-rbind(df, dm)    
}
