pisaData1$Gender[pisaData1$Gender=="0"]<-"General"
pisaData1$ESCS[pisaData1$ESCS==0]<-""
pisaData1$GenderESCS<-paste0(pisaData1$Gender, pisaData1$ESCS)
unique(pisaData1$GenderESCS)
pisaData2<-pisaData1
pisaData2$Gender[pisaData1$Gender=="General"]<-0
pisaData2$ESCS[pisaData1$ESCS==""]<-0
save(pisaData2, file="pisaData2.rda")
