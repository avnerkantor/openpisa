###UI
observeEvent(input$calibrationCheck, {
  updateCheckboxGroupInput(session, inputId="Gender", selected = "")
})

# observeEvent(input$calibrationCheck, {
#   updateCheckboxGroupInput(session, inputId="Escs", selected = "")
# })

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
####
observe({
  
  SubjectExpertiseLevels<-ExpertiseLevels %>%
    select(Level, contains(input$Subject))%>%
    filter(!is.na(input$Subject))
  
  plotData1<-pisaData2%>%filter(Subject==input$Subject, Performers==0)%>%select(-Subject, -Performers)
  
  if(is.null(input$Gender)){
    if(is.null(input$Escs)){
      plotData2<-plotData1 %>%
        filter(Gender==0, ESCS==0)
    } else {
      plotData2<- plotData1 %>%
        filter(Gender == 0)%>%
        filter(ESCS %in% c(input$Escs))
    }
  } else {
    if(length(input$Gender)==1){
      if(is.null(input$Escs)) {
        plotData2<- plotData1 %>%
          filter(Gender  == input$Gender)%>%
          filter(ESCS == 0)
      } else {
        plotData2<- plotData1 %>%
          filter(Gender  == input$Gender)%>%
          filter(ESCS %in% c(input$Escs))
      }
    } else {
      plotData2<- plotData1 %>%
        filter(Gender %in% c(input$Gender))%>%
        filter(ESCS == 0)
    } 
  }
  
  scoresPlotFunction<-function(country){
    
    x<-Countries%>%filter(Hebrew==country)%>%select(CNT)
    plotData3 <- plotData2%>%filter(Country==x[1,1])
    
    gg<-ggplot(plotData3, aes(x=Year, y=Average, colour=GenderESCS, text=round(Average))) +
      scale_colour_manual(values = c(
        "General"="#b276b2", 
        "Male"="#5da5da", 
        "Female"="#f17cb0", 
        "GeneralLow"="#bc99c7", 
        "GeneralMedium"="#b276b2", 
        "GeneralHigh"="#7b3a96", 
        "MaleHigh"="#265dab", 
        "MaleLow"="#88bde6", 
        "MaleMedium"="#5da5da", 
        "FemaleHigh"="#e5126f", 
        "FemaleLow"="#f6aac9", 
        "FemaleMedium"="#f17cb0"
      )) +
      guides(colour=FALSE) +
      
      labs(title="", y="" ,x= "") +
      theme_bw() +
      #geom_label() +
      theme(plot.margin=unit(c(0,15,0,0), "pt"),
            panel.border = element_blank(),
            axis.ticks = element_blank(),
            panel.grid.major.x=element_blank(),
            panel.grid.major.y = element_line(colour="#e0e0e0", size=0.3),
            #axis.text.y = element_text(margin = margin(t = 20, b = 15)),
            #axis.title.y=element_text(vjust = 1),
            legend.position="none",
            axis.line.x = element_line(color="#c7c7c7", size = 0.3),
            axis.line.y = element_line(color="#c7c7c7", size = 0.3)
      ) +
      scale_x_continuous(breaks=c(2006, 2009, 2012)) +
      scale_y_continuous(
        #minor_breaks=SubjectExpertiseLevels[2],
        breaks=SubjectExpertiseLevels[2],
        labels=SubjectExpertiseLevels[1],
        limits=c(300,740))
    
    if("2012" %in% plotData3$Year) {
      if("2009" %in% plotData3$Year) {
       #https://plot.ly/r/axes/
        gp<-gg+geom_line(size=1)
        #https://github.com/plotly/plotly.js/blob/master/src/components/modebar/buttons.js
        ggplotly(gp, tooltip = c("text"))%>%config(p = ., staticPlot = FALSE, displayModeBar = TRUE, workspace = FALSE, editable = FALSE, sendData = FALSE, displaylogo = FALSE,
        modeBarButtonsToRemove = list("resetScale2d", "hoverCompareCartesian", "autoScale2d", "hoverClosestCartesian"))

      } else{
        gp<-gg+geom_point(size=2)
        ggplotly(gp, tooltip = c("text"))%>%config(p = ., staticPlot = FALSE, displayModeBar = TRUE, workspace = FALSE, editable = FALSE, sendData = FALSE, displaylogo = FALSE,
                                                   modeBarButtonsToRemove = list("resetScale2d", "hoverCompareCartesian", "autoScale2d"))
      }
    } 
    else 
    {
      gg+annotate("text", label = "לא נבחנה",
                  x = 2012, y = 500, size = 6, 
                  colour = "#c7c7c7")%>%config(p = ., staticPlot = FALSE, displayModeBar = TRUE, workspace = FALSE, editable = FALSE, sendData = FALSE, displaylogo = FALSE,
                                               modeBarButtonsToRemove = list("resetScale2d", "hoverCompareCartesian", "autoScale2d"))
    }
  }
  
  if(!input$Country1==""){
    output$Country1Plot<-renderPlotly({
      scoresPlotFunction(input$Country1)
    })
    output$Country2Plot<-renderPlotly({
      scoresPlotFunction(input$Country2)
    })
    output$Country3Plot<-renderPlotly({
      scoresPlotFunction(input$Country3)
    })
    output$Country4Plot<-renderPlotly({
      scoresPlotFunction(input$Country4)
    })
  }
})


observeEvent(input$Subject,{
  minLevel<-min(LevelExplenation%>%filter(Subject==input$Subject)%>%select(Level))
  maxLevel<-max(LevelExplenation%>%filter(Subject==input$Subject)%>%select(Level))
  
  updateNumericInput(session, "levelNumber", "", min=minLevel, max=maxLevel, value=3, step=1)
  
  output$ExplenationTable <- renderTable({
    LevelExplenation%>%filter(Subject==input$Subject, Level==input$levelNumber)%>%select(Explenation)
  }, include.rownames=FALSE, include.colnames=FALSE)
})
