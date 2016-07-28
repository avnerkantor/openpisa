#choices = list("combined" = "combined", "male only" = "male", "female only" = "female")

load("data/pisaData3.rda")

observe({
  if(input$calibrationCheck){
    updateCheckboxGroupInput(session, inputId="Gender", label="מגדר", inline=T, choices = c(
      "בנות"="Female",
      "בנים"="Male"
    ), selected = NULL)
    updateCheckboxGroupInput(session, inputId="Escs", label="מדד סוציואקונומי", inline=T, choices = c(
      "גבוה"="High",
      "בינוני"="Medium",
      "נמוך"="Low"
    ), selected = NULL)
  }

})

observe({
  if(!is.null(input$Gender) || !is.null(input$Escs)){
    updateCheckboxInput(session, inputId = "calibrationCheck", label="ראשי", value=FALSE)
  }
})

#todo לעשות הודעת שגיאה של לא נבחנו במקצוע. אם אין מידע
observeEvent(input$worldOrIsrael,{
  if (input$worldOrIsrael=="World") 
      {
            updateSelectInput(session, "Country1", choices = names(oecdList), selected = "ישראל")
            updateSelectInput(session, "Country2", choices = names(oecdList), selected = "ארצות-הברית")
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
  plotData<-pisaData3%>%filter(Subject==input$Subject, 
   Gender==ifelse(is.null(input$Gender), 0, input$Gender),
   ESCS==ifelse(is.null(input$Escs), 0, input$Escs),
   Performers==0)

  # output$text1 <- renderText(
  #   asSubjectExpertiseLevelsBreaks[1]
  # )
  
  
  output$Country1Plot<-renderPlot({
    plotData<-plotData %>% filter(Country==as.vector(unlist(Countries%>%filter(Hebrew==input$Country1)%>%select(CNT)))) %>%
      select(-Country)
    output$table1 <- renderTable({
      #SubjectExpertiseLevelsBreaks
      plotData
    })
    ggplot(plotData, aes(x=Year, y=Average, colour=Gender)) +
      geom_line() +
      geom_point() + 
      theme_bw()+
      guides(colour=FALSE) +
      scale_x_continuous(breaks=c(2006,2009,2012)) +
      scale_y_continuous(breaks=SubjectExpertiseLevels[2], labels=SubjectExpertiseLevels[1], limits = c(200, 800)) +
      labs(title=" ", y="" ,x= " ")
  })
  
  output$Country2Plot<-renderPlot({
    plotData<-plotData %>% filter(Country==as.vector(unlist(Countries%>%filter(Hebrew==input$Country2)%>%select(CNT)))) %>%
      select(-Country)
    output$table1 <- renderTable({
      #SubjectExpertiseLevelsBreaks
      plotData
    })
    ggplot(plotData, aes(x=Year, y=Average, colour=Gender)) +
      geom_line() +
      geom_point() + 
      theme_bw()+
      guides(colour=FALSE) +
      scale_x_continuous(breaks=c(2006,2009,2012)) +
      scale_y_continuous(breaks=SubjectExpertiseLevels[2], labels=SubjectExpertiseLevels[1], limits = c(200, 800)) +
      labs(title=" ", y="" ,x= " ")
  })
  
  output$Country3Plot<-renderPlot({
    plotData<-plotData %>% filter(Country==as.vector(unlist(Countries%>%filter(Hebrew==input$Country3)%>%select(CNT)))) %>%
      select(-Country)
    output$table1 <- renderTable({
      #SubjectExpertiseLevelsBreaks
      plotData
    })
    ggplot(plotData, aes(x=Year, y=Average, colour=Gender)) +
      geom_line() +
      geom_point() + 
      theme_bw()+
      guides(colour=FALSE) +
      scale_x_continuous(breaks=c(2006,2009,2012)) +
      scale_y_continuous(breaks=SubjectExpertiseLevels[2], labels=SubjectExpertiseLevels[1], limits = c(200, 800)) +
      labs(title=" ", y="" ,x= " ")
  })
  
  output$Country4Plot<-renderPlot({
    plotData<-plotData %>% filter(Country==as.vector(unlist(Countries%>%filter(Hebrew==input$Country4)%>%select(CNT)))) %>%
      select(-Country)
    output$table1 <- renderTable({
      #SubjectExpertiseLevelsBreaks
      plotData
    })
    ggplot(plotData, aes(x=Year, y=Average, colour=Gender)) +
      geom_line() +
      geom_point() + 
      theme_bw()+
      guides(colour=FALSE) +
      scale_x_continuous(breaks=c(2006,2009,2012)) +
      scale_y_continuous(breaks=SubjectExpertiseLevels[2], labels=SubjectExpertiseLevels[1], limits = c(200, 800)) +
      labs(title=" ", y="" ,x= " ")
  })
})

output$pisaScoresTable <- DT::renderDataTable(options=list(
  pageLength = 5,
  searching=FALSE,
  autoWidth = TRUE
), rownames= FALSE,
{
  pisaData3%>%select(-Performers)
  #%>%filter(Country==input)
})

observeEvent(input$Subject,{
  minLevel<-min(LevelExplenation%>%filter(Subject==input$Subject)%>%select(Level))
  maxLevel<-max(LevelExplenation%>%filter(Subject==input$Subject)%>%select(Level))
  
  updateNumericInput(session, "levelNumber", "רמה", min=minLevel, max=maxLevel, value=3, step=1)
  
  
  
  output$ExplenationTable <- renderTable({
  LevelExplenation%>%filter(Subject==input$Subject, Level==input$levelNumber)%>%select(Explenation)
  }, include.rownames=FALSE, include.colnames=FALSE)
})
