######UI #####
observe({
  updateSelectInput(session, inputId="SurveyYear", label="", 
                    choices = c(2015, 2012), selected = 2015)
})

observeEvent(input$SurveyYear,{
  updateSelectInput(session, inputId="SurveySubject", label="", choices = c(
    unique(pisaDictionary%>%filter(Year==input$SurveyYear)%>%select(Subject))), 
    selected = "School Policies and Practices")
})

observeEvent(input$SurveySubject,{
  updateSelectInput(session, "SurveyCategory", "", as.vector(unlist(select(filter(pisaDictionary, Year == input$SurveyYear, Subject == input$SurveySubject), Category))))
})

observeEvent(input$SurveyCategory,{
  updateSelectInput(session, "SurveySubCategory", "", as.vector(unlist(select(filter(pisaDictionary, Year == input$SurveyYear, Subject == input$SurveySubject, Category==input$SurveyCategory), SubCategory)))
  )
})

observe({
  
  SurveySelectedID <- as.vector(unlist(select(filter(pisaDictionary, Year == input$SurveyYear, Subject == input$SurveySubject, Category==input$SurveyCategory, SubCategory==input$SurveySubCategory), ID))) 
  
  # output$SurveySelectedIDOutput <- renderText({
  # paste("Variable Name", SurveySelectedID[1])
  #   })
  
  surveyPlotFunction<-function(country) {
    
    switch(input$SurveyYear,
    "2015"={surveyData<-pisa2015},
    "2012"={surveyData<-pisa2012},
    "2009"={surveyData<-pisa2009},
    "2006"={surveyData<-pisa2006}
    )
      
    surveyData1<-surveyData%>%select_("COUNTRY", SurveySelectedID, "ST04Q01", "ESCS")%>%filter(COUNTRY==country)%>%na.omit
    
    if(is.null(v$Gender)){
      if(is.null(v$Escs)){
        #General
        surveyTable<-surveyData1%>%
          count_(SurveySelectedID)
         # surveyTable<-collect(surveyTable)
        surveyTable<-surveyTable%>% mutate(freq = round(100 * n/sum(n), 1), groupColour="General")%>%
          rename_(answer=SurveySelectedID)
      } else {
        # General Escs
        surveyTable<-surveyData1%>%
          filter(ESCS %in% c(v$Escs))%>%
          group_by_("ESCS", SurveySelectedID)%>%
          tally  %>%
          group_by(ESCS)
         # surveyTable<-collect(surveyTable)
        surveyTable<-surveyTable%>%   mutate(freq = round(100 * n/sum(n), 0))%>%
          rename_(answer=SurveySelectedID, group="ESCS") %>%
          mutate(groupColour=str_c("General", group))
      }
    } else {
      if(length(v$Gender)==1){
        if(is.null(v$Escs)) {
          #Only gender
          surveyTable<-surveyData1%>%
            filter(ST04Q01 %in% c(v$Gender))%>%
            group_by_("ST04Q01", SurveySelectedID)%>%
            tally  %>%
            group_by(ST04Q01)
           # surveyTable<-collect(surveyTable)
          surveyTable<-surveyTable%>%   mutate(freq = round(100 * n/sum(n), 0))%>%
            rename_(answer=SurveySelectedID, groupColour="ST04Q01") 
          
        } else {
          surveyTable<-surveyData1%>%
            filter(ST04Q01  %in% c(v$Gender))%>%
            filter(ESCS %in% c(v$Escs))%>%
            group_by_("ESCS", SurveySelectedID)%>%
            tally  %>%
            group_by(ESCS)
           # surveyTable<-collect(surveyTable)
          surveyTable<-surveyTable%>%  mutate(freq = round(100 * n/sum(n), 0), group1=v$Gender)%>%
            rename_(answer=SurveySelectedID, group="ESCS")%>%
            mutate(groupColour=str_c(group1, group))
          
        }
      } else {
        surveyTable<-surveyData1%>%
          filter(ST04Q01 %in% c(v$Gender))%>%
          group_by_("ST04Q01", SurveySelectedID)%>%
          tally  %>%
          group_by(ST04Q01)
         # surveyTable<-collect(surveyTable)
        surveyTable<-surveyTable%>%   mutate(freq = round(100 * n/sum(n), 0))%>%
          rename_(answer=SurveySelectedID, groupColour="ST04Q01")
      } 
    }
    
    gh<-ggplot(data=surveyTable, aes(x=answer, y=freq, text=paste0(round(freq, digits = 1), "%"))) +
      geom_bar(aes(colour=groupColour, fill=groupColour), stat="identity") +
      coord_flip() +
      scale_colour_manual(values =groupColours) +
      scale_fill_manual(values = groupColours) +
      labs(title="", y="" ,x= "") +
      theme_bw() +
      guides(colour=FALSE) +
      facet_grid(. ~groupColour) +
      scale_y_continuous(breaks=c(0, 100), limits = c(0, 100)) +
      theme(plot.margin=unit(c(0,0,0,0), "pt"),
        panel.border = element_blank(),
        panel.grid.major=element_blank(),
        axis.ticks = element_blank(),
        legend.position="none",
        strip.text.x = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.y = element_text(size=8, angle=0),
        panel.spacing.x=unit(2, "lines")
        #axis.line.x = element_line(color="#c7c7c7", size = 0.3),
        #axis.line.y = element_line(color="#c7c7c7", size = 0.3)
        ) 
    
    ggplotly(gh, tooltip = c("text"))%>%
      config(p = ., displayModeBar = FALSE)%>%
      layout(hovermode="y")
    }
  
  ### Plots ####  
  if(length(SurveySelectedID)==1){
    output$Country1SurveyPlot<-renderPlotly({
      surveyPlotFunction(input$Country1)
    })
    output$Country2SurveyPlot<-renderPlotly({
      surveyPlotFunction(input$Country2)
    })
    output$Country3SurveyPlot<-renderPlotly({
      surveyPlotFunction(input$Country3)
    })
    output$Country4SurveyPlot<-renderPlotly({
      surveyPlotFunction(input$Country4)
    })
  }
})

output$pisaScoresTable <- DT::renderDataTable(
  # filter='bottom',
  options=list(
    pageLength = 5,
    searching=TRUE,
    autoWidth = TRUE
  ), rownames= FALSE,
  {
    pisaDictionary%>%filter(Year==input$SurveyYear)%>%select(ID, Measure, Subject, Category, SubCategory)
  })
