pisadb<-src_bigquery("r-shiny-1141", "pisa")
Student2012<- tbl(pisadb, "student2012")

observe({
  SurveySelectedID <- as.vector(unlist(select(filter(PisaSelectIndex, HebSubject == input$SurveySubject, HebCategory==input$SurveyCategory, HebSubCategory==input$SurveySubCategory), ID)))      
  
  analuzeDataFunction<-function(country) {
    Country<-as.vector(unlist(Countries%>%filter(Hebrew==country)%>%select(CNT)))
    #General
    General<-Student2012%>%filter(CNT=="ISR")%>%select_("PV1MATH", "WEALTH")
    General<-collect(General)
    #Gender
    Male<-Student2012%>%filter(CNT==Country, ST04Q01=="Male")%>%select_(input$Subject, SurveySelectedID)
    Male<-collect(Male)
    Female<-Student2012%>%filter(CNT==Country, ST04Q01=="Female")%>%select_(input$Subject, SurveySelectedID)
    Female<-collect(Female)
    #ESCS
    High<-Student2012%>%filter(CNT==Country, ESCS>"0.7")%>%select_(input$Subject, SurveySelectedID)
    High<-collect(High)
    Medium<-Student2012%>%filter(CNT==Country,  ESCS<="0.7", ESCS>="0.2")%>%select_(input$Subject, SurveySelectedID)
    Medium<-collect(Medium)
    Low<-Student2012%>%filter(CNT==Country,  ESCS<"0.2")%>%select_(input$Subject, SurveySelectedID)
    Low<-collect(Low)
    #Low<-Low%>%mutate(freq = round(100 * n/sum(n), 1), group="Low")%>%rename_(answer=SurveySelectedID)
    
  }
})

fit <- lm(as.matrix(y) ~ as.matrix(x))

corPearson<-round(x=cor(FemaleX, FemaleY, use="complete.obs", method="pearson"), digits=2)
corSpearman<-round(cor(FemaleX, FemaleY, use="complete.obs", method="spearman"), digits=2)

paste("Pearson:", corPearson, "Spearman:", corSpearman, "DF:", summary(fit)$df[2])
print((summary(fit)))

ggplot(data=tempCountry4, aes_string(y=y, x=x)) + 
  geom_point(size=4, alpha=0.4) +
  geom_smooth(method = lm) +
  facet_wrap(~ST04Q01) 
