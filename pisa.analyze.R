#Analyze

observe({
  updateSelectizeInput(session, 'analyzeVariables',
                       choices = as.character(PisaSelectIndex$ID),
                       selected = "WEALTH",
                       options=list(placeholder="בחר משתנים"))
  
})
observe({
  
  updateSelectInput(session, inputId="statisticalFunction", label="", choices = c(
    "מתאם"="AB",
    "רגרסיה לינארית"="CD",
    "רגרסיה מרובה"="ED",
    "FG"="FG"
  ),
  selected="AB")
})

output$pisaScoresTable <- DT::renderDataTable(
  filter='bottom',
  colnames = c('משתנה', 'תיאור באנגלית', 'נושא', 'קטגוריה', 'תת-קטגוריה'),
  options=list(
    pageLength = 5,
    searching=TRUE,
    autoWidth = TRUE
  ), rownames= FALSE,
  {
    PisaSelectIndex%>%select(ID, Measure, HebSubject, HebCategory, HebSubCategory)%>%
      filter(HebSubject=="מדדים")
    
  })


##############33
pisadb<-src_bigquery("r-shiny-1141", "pisa")
student2012<- tbl(pisadb, "student2012")

observe({

  analyzePlotFunction<-function(country) {
    
    Country<-as.vector(unlist(Countries%>%filter(Hebrew==country)%>%select(CNT)))
    SurveySelectedID <- as.vector(unlist(select(filter(PisaSelectIndex, HebSubject == input$SurveySubject, HebCategory==input$SurveyCategory, HebSubCategory==input$SurveySubCategory), ID)))      
    
    
    switch ( input$Subject,
      Math = {analyzeSubject<-"PV1MATH"}
    )
    
    analyzeData1<-student2012%>%select_("CNT", SurveySelectedID, "ST04Q01", "ESCS",
                        analyzeSubject)%>%filter(CNT==Country)
    
    analyzeData1<-collect(analyzeData1)
#     #General
     # General<-student2012%>%filter(CNT=="ISR")%>%select_("PV1MATH", "WEALTH")
     # General<-collect(General)
     #Gender
# 
#     #ESCS
  # ggplot(data=General, aes_string(y="PV1MATH", x="WEALTH")) +
  #    geom_point(size=4, alpha=0.4) +
  #   geom_smooth(method = lm)
#     
#     fit <- lm(as.matrix(y) ~ as.matrix(x))
#     
#     corPearson<-round(x=cor(FemaleX, FemaleY, use="complete.obs", method="pearson"), digits=2)
#     corSpearman<-round(cor(FemaleX, FemaleY, use="complete.obs", method="spearman"), digits=2)
#     
#     paste("Pearson:", corPearson, "Spearman:", corSpearman, "DF:", summary(fit)$df[2])
#     print((summary(fit)))
#     
    ggplot(data=analyzeData1, aes_string(y=analyzeSubject, x=SurveySelectedID)) +
      geom_point(size=4, alpha=0.4) 
    #+
     # geom_smooth(method = lm) +
      #facet_wrap(~ST04Q01)


  }

  #### Plots ####
  output$Country1AnalyzePlot<-renderPlot({
    analyzePlotFunction(input$Country1)

  })

  output$Country2AnalyzePlot<-renderPlot({
    analyzePlotFunction(input$Country2)

  })


  output$Country3AnalyzePlot<-renderPlot({
    analyzePlotFunction(input$Country3)

  })


  output$Country4AnalyzePlot<-renderPlot({
    analyzePlotFunction(input$Country4)

  })

})


