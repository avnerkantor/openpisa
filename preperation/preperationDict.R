load("~/R/tikhinuch4/dict/student2012dict.rda")
s2012dict<-as.data.frame(student2012dict)
s2012dict$id<-names(student2012dict)
rownames(s2012dict)<-c()
names(s2012dict)<-c("description", "id")

s2012dicta<-s2012dict%>%select(id=id, description2012=description)
studentDict<-full_join(s2012dicta, s2009dicta, by="id")
studentDict<-full_join(studentDict, s2006dicta, by="id")

#############################
school2006dicta<-as.data.frame(school2006dict)
school2006dicta$id<-names(school2006dict)
rownames(school2006dicta)<-c()
names(school2006dicta)<-c("description2006", "id")
school2006dicta<-school2006dicta%>%select(id, description2006)
save(school2006dicta, file="school2006dict.rda")

schooltDict<-full_join(school2012dicta, school2009dicta, by="id")
schooltDict<-full_join(schooltDict, school2006dicta, by="id")
save(schooltDict, file="schooltDict.rda")
