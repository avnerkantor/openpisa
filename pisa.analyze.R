surveyData<-pisa2015

observe({
  analyzeSelectedID <- as.vector(unlist(select(filter(pisaDictionary, Year == input$SurveyYear, Subject == input$SurveySubject, Category==input$SurveyCategory, SubCategory==input$SurveySubCategory), ID))) 
  
  switch (input$Subject,
          Math = {analyzeSubject<-"PV1MATH"},
          Science={analyzeSubject<-"PV1SCIE"},
          Reading={analyzeSubject<-"PV1READ"},
          ProblemSolving={analyzeSubject<-"PV1CPRO"},
          Financial={analyzeSubject<-"PV1FLIT"}
  )
  
  analyzePlotFunction<-function(country) {
    switch(input$SurveyYear,
           "2015"={surveyData<-pisa2015},
           "2012"={surveyData<-pisa2012},
           "2009"={surveyData<-pisa2009},
           "2006"={surveyData<-pisa2006}
    )
    
    analyzeData1<-surveyData%>%select_("COUNTRY", analyzeSelectedID, "ST04Q01", "ESCS", analyzeSubject)%>%filter(COUNTRY==country)
    # analyzeData1<-collect(analyzeData1)
    if(all(is.na(analyzeData1[,analyzeSelectedID]))){
      ggplot() + annotate("text", label = "Didn't participate",
                          x = 2012, y = 500, size = 6, 
                          colour = "#c7c7c7")+
        theme_void() + theme(legend.position="none")
    } else {
      if(is.null(v$Gender)){
        if(is.null(v$Escs)){
          #General
          analyzeData2<-analyzeData1%>%
            mutate(groupColour="General")
        } else {
          # General Escs
          analyzeData2<-analyzeData1%>%
            filter(ESCS %in% c(v$Escs))%>%
            group_by_("ESCS", analyzeSelectedID)%>%
            rename_(group="ESCS") %>%
            mutate(groupColour=str_c("General", group))
        }
      } else {
        if(length(v$Gender)==1){
          if(is.null(v$Escs)) {
            #Only gender
            analyzeData2<-analyzeData1%>%
              filter(ST04Q01 %in% c(v$Gender))%>%
              group_by_("ST04Q01", analyzeSelectedID)%>%
              rename_(groupColour="ST04Q01") 
          } else {
            analyzeData2<-analyzeData1%>%
              filter(ST04Q01  %in% c(v$Gender))%>%
              filter(ESCS %in% c(v$Escs))%>%
              group_by_("ESCS", analyzeSelectedID)%>%
              mutate(group1=v$Gender)%>%
              rename_(group="ESCS")%>%
              mutate(groupColour=str_c(group1, group))
          }
        } else {
          analyzeData2<-analyzeData1%>%
            filter(ST04Q01 %in% c(v$Gender))%>%
            group_by_("ST04Q01", analyzeSelectedID)%>%
            rename_(groupColour="ST04Q01") 
        } 
      }
      
      ggplot(data=analyzeData2, aes_string(y=analyzeSubject, x=analyzeSelectedID)) +
        geom_smooth(method="lm", aes(colour=groupColour), se=TRUE) + 
        geom_point(aes(colour=groupColour), alpha = 0.1) +
        #geom_text(data=analyzeData3, aes(x=0, y=800, label=paste("R²=", round(r.squared), digits=3), show_guide=F, colour=groupColour)) +
        scale_colour_manual(values = groupColours) +
        labs(title="", y="Score" ,x= "") +
        theme_bw() +
        guides(colour=FALSE) +
        scale_y_continuous(limits = c(0,800)) +
        theme(plot.margin=unit(c(0,15,10,10), "pt"),
              panel.border = element_blank(),
              axis.ticks = element_blank(),
              panel.grid.major.x=element_blank(),
              panel.grid.major.y = element_line(colour="#e0e0e0", size=0.3),
              legend.position="none",
              axis.line = element_line(color="#c7c7c7", size = 0.3),
              axis.title=element_text(colour="#777777"),
              strip.background = element_blank(),
              strip.text.x = element_blank(),
              axis.title.x=element_blank(),
              #axis.text.x=element_blank()
              axis.ticks.x=element_blank() 
        ) 
    }
  }
  
  analyzeFunction<-function(country) {
    analyzeData1<-surveyData%>%select_("COUNTRY", analyzeSelectedID, "ST04Q01", "ESCS", analyzeSubject)%>%filter(COUNTRY==country)
    if(all(is.na(analyzeData1[,analyzeSelectedID]))){
      paste("")
    } else {
      if(is.null(v$Gender)){
        if(is.null(v$Escs)){
          #General
          analyzeData2<-analyzeData1%>%
            mutate(groupColour="General")
        } else {
          # General Escs
          analyzeData2<-analyzeData1%>%
            filter(ESCS %in% c(v$Escs))%>%
            group_by_("ESCS", analyzeSelectedID)%>%
            rename_(group="ESCS") %>%
            mutate(groupColour=str_c("General", group))
        }
      } else {
        if(length(v$Gender)==1){
          if(is.null(v$Escs)) {
            #Only gender
            analyzeData2<-analyzeData1%>%
              filter(ST04Q01 %in% c(v$Gender))%>%
              group_by_("ST04Q01", analyzeSelectedID)%>%
              rename_(groupColour="ST04Q01") 
          } else {
            analyzeData2<-analyzeData1%>%
              filter(ST04Q01  %in% c(v$Gender))%>%
              filter(ESCS %in% c(v$Escs))%>%
              group_by_("ESCS", analyzeSelectedID)%>%
              mutate(group1=v$Gender)%>%
              rename_(group="ESCS")%>%
              mutate(groupColour=str_c(group1, group))
          }
        } else {
          analyzeData2<-analyzeData1%>%
            filter(ST04Q01 %in% c(v$Gender))%>%
            group_by_("ST04Q01", analyzeSelectedID)%>%
            rename_(groupColour="ST04Q01") 
        } 
      }
      
      analyzeData2[, analyzeSelectedID]<-as.numeric(unlist(analyzeData2[, analyzeSelectedID]))
      analyzeData2[, analyzeSubject]<-as.numeric(unlist(analyzeData2[, analyzeSubject]))
      analyzeData3<-analyzeData2 %>% group_by(groupColour) %>% do(glance(lm(get(analyzeSubject) ~ get(analyzeSelectedID), data=.)))
      # analyzeData4<-analyzeData2 %>% group_by(groupColour) %>% do(tidy(lm(get(analyzeSubject) ~ get(analyzeSelectedID), data=.)))
      
      paste0("\n", v$Gender, " ", v$Escs, " R²=", round(analyzeData3$r.squared, digits=3), ",\n df.residual=", analyzeData3$df.residual, ".")
      # paste0("Variables: ", analyzeSubject, ", ", analyzeSelectedID)
    }
  }
  
  if(length(analyzeSelectedID)==1){
    output$Country1AnalyzePlot<-renderPlot({
      analyzePlotFunction(input$Country1)
    })
    output$Country1AnalyzePlotText <-renderText({
      analyzeFunction(input$Country1)
    })
    output$Country2AnalyzePlot<-renderPlot({
      analyzePlotFunction(input$Country2)
    })
    output$Country2AnalyzePlotText <-renderText({
      analyzeFunction(input$Country2)
    })
    output$Country3AnalyzePlot<-renderPlot({
      analyzePlotFunction(input$Country3)
    })
    output$Country3AnalyzePlotText <-renderText({
      analyzeFunction(input$Country3)
    })
    output$Country4AnalyzePlot<-renderPlot({
      analyzePlotFunction(input$Country4)
    })
    output$Country4AnalyzePlotText <-renderText({
      analyzeFunction(input$Country4)
    })
    
  }
  
  #https://github.com/trestletech/shinyAce/tree/master/inst/examples
  #Security
  #https://github.com/Rapporter/sandboxR
  #
  # output$knitDoc <- renderUI({
  #   input$eval
  #   return(isolate(HTML(knit2html(text=input$rmd,  fragment.only = TRUE, quiet = TRUE))))
  # }) 
  # output$knitDoc <- renderPrint({
  #   input$eval
  #   return(isolate(eval(parse(text=input$rmd))))
  # })
})
