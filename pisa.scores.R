#choices = list("combined" = "combined", "male only" = "male", "female only" = "female")

load("data/pisaData2.rda")

#observe({
#  if(input$calibrationCheck){
#    updateCheckboxGroupInput(session, inputId="Gender", inline=T, label="", choices = c(
#      "בנות"="Female",
#      "בנים"="Male"
#    ), selected = NULL)
#    updateCheckboxGroupInput(session, inputId="Escs", inline=T, label="", choices = c(
#      "גבוה"="High",
#      "בינוני"="Medium",
#      "נמוך"="Low"
#    ), selected = NULL)
#  }
#})
#לעשות תנאי שאם יש פתרון בעיות או פיננסים אז להציג נקודות
#observe({
#  if(!is.null(input$Gender) || !is.null(input$Escs)){
#    updateCheckboxInput(session, inputId = "calibrationCheck", inline=T, label="", value=FALSE)
#  }
#})

#todo לעשות הודעת שגיאה של לא נבחנו במקצוע. אם אין מידע
observe({
  if (input$worldOrIsrael=="World") 
  {
    updateSelectInput(session, "Country1", choices = names(oecdList), selected = "ישראל")
    updateSelectInput(session, "Country2", choices = names(oecdList), selected = "בריטניה")
    updateSelectInput(session, "Country3", choices = names(oecdList), selected = "פינלנד")
    updateSelectInput(session, "Country4", choices = names(oecdList), selected = "דרום-קוריאה")
  } else {
    updateSelectInput(session, "Country1", choices = names(israelList), selected = "חינוך-ממלכתי")
    updateSelectInput(session, "Country2", choices = names(israelList), selected = "ממלכתי-דתי")
    updateSelectInput(session, "Country3", choices = names(israelList), selected = "חרדים-בנות")
    updateSelectInput(session, "Country4", choices = names(israelList), selected = "דוברי ערבית")
  }
})

observe({
  
  SubjectExpertiseLevels<-ExpertiseLevels %>%
    select(Level, contains(input$Subject))%>%
    filter(!is.na(input$Subject))
  
  plotData1<-pisaData2%>%filter(Subject==input$Subject, Performers==0)%>%select(-Subject, -Performers)
  
  if (!is.null(input$Gender)){
    if(!is.null(input$Escs)){
      plotData2<- plotData1 %>%
        filter(Gender %in% c(input$Gender))%>%
        filter(ESCS %in% c(input$Escs))
    } else {
      plotData2<- plotData1 %>%
        filter(Gender %in% c(input$Gender))%>%
        filter(ESCS == 0)
    }
  } else {
    if (!is.null(input$Escs)){
      plotData2<- plotData1 %>%
        filter(Gender == 0)%>%
        filter(ESCS %in% c(input$Escs))
    } else {
      plotData2<-plotData1 %>%
        filter(Gender==0, ESCS==0)
    }
  }
  
  #output$table1 <- renderTable({
  #SubjectExpertiseLevelsBreaks
  # plotData
  #})
  
  scoresPlotFunction<-function(country){
    plotData3 <- plotData2%>%
      filter(Country==
               as.vector(unlist(Countries%>%filter(Hebrew==country)%>%select(CNT))))%>%select(-Country)

    #ggplot(plotData3, aes(x=Year, y=Average, colour=ESCS, group=interaction(ESCS, Gender))) +
    #ggplot(plotData3, aes(x=Year, y=Average, colour=ESCS, fill=Gender)) +    
      ggplot(plotData3, aes(x=Year, y=Average, colour=GenderESCS)) +
      geom_line() +
      scale_colour_manual(values = c("General"="#b276b2", "Male"="#5da5da", "Female"="#f17cb0", "GeneralLow"="#bc99c7", "GeneralMedium"="#b276b2", "GeneralHigh"="#7b3a96", "MaleHigh"="#265dab", "MaleLow"="#88bde6", "MaleMedium"="#5da5da", "FemaleHigh"="#e5126f", "FemaleLow"="#f6aac9", "FemaleMedium"="#f17cb0")) +
      theme_bw()+
      guides(colour=FALSE) +
      scale_x_discrete(breaks=c(2006,2009,2012), limits=c(2006,2009, 2012)) +
      scale_y_continuous(breaks=SubjectExpertiseLevels[2], labels=SubjectExpertiseLevels[1], 
                         limits = c(min(SubjectExpertiseLevels[2], na.rm = TRUE), 
                                    max(SubjectExpertiseLevels[2], na.rm = TRUE))) +
      labs(title=" ", y="" ,x= " ") 
  }
  
  # output$pisaScoresTable <- DT::renderDataTable(options=list(
  #   pageLength = 5,
  #   searching=FALSE,
  #   autoWidth = TRUE
  # ), rownames= FALSE,
  # {
  #   plotData3<-plotData1%>%
  #     filter(Country=="ISR")%>%filter(Gender %in% c(input$Female, input$Male))
  #   
  # })
  # output$text1 <- renderText(
  #   paste(c(input$Female))
  # )
  output$Country1Plot<-renderPlot({
    scoresPlotFunction(input$Country1)
  })
  
  output$Country2Plot<-renderPlot({
    scoresPlotFunction(input$Country2)
  })
  
  output$Country3Plot<-renderPlot({
    scoresPlotFunction(input$Country3)
  })
  
  output$Country4Plot<-renderPlot({
    scoresPlotFunction(input$Country4)
  })
})


observeEvent(input$Subject,{
  minLevel<-min(LevelExplenation%>%filter(Subject==input$Subject)%>%select(Level))
  maxLevel<-max(LevelExplenation%>%filter(Subject==input$Subject)%>%select(Level))
  
  updateNumericInput(session, "levelNumber", "", min=minLevel, max=maxLevel, value=3, step=1)
  
  output$ExplenationTable <- renderTable({
    LevelExplenation%>%filter(Subject==input$Subject, Level==input$levelNumber)%>%select(Explenation)
  }, include.rownames=FALSE, include.colnames=FALSE)
})
