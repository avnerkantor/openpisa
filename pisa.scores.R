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
    gg<-ggplot(plotData3, aes(x=Year, y=Average, colour=GenderESCS)) +
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
      theme(plot.margin=unit(c(0,15,0,0), "pt"),
            panel.border = element_blank(),
            axis.ticks = element_blank(),
            panel.grid.major.x=element_blank(),
            panel.grid.major.y = element_line(colour="#e0e0e0", size=0.3),
            axis.line.x = element_line(color="#c7c7c7", size = 0.3),
            axis.line.y = element_line(color="#c7c7c7", size = 0.3)) +
      scale_x_continuous(breaks=c(2006, 2009, 2012)) +
      scale_y_continuous(
        #minor_breaks=SubjectExpertiseLevels[2],
        breaks=SubjectExpertiseLevels[2],
        labels=SubjectExpertiseLevels[1],
        limits=c(300,740))
    
    if("2012" %in% plotData3$Year) {
      if("2009" %in% plotData3$Year) {
      #gp<-
        gg+geom_line(size=1)
      #ggplotly(gp)
      
      } else{
      #gp<-
        gg+geom_point(size=2)
      #ggplotly(gp)
      
      }
    } 
    #else (gg <- ggplotly(p))
      #http://shiny.rstudio.com/reference/shiny/latest/Progress.html
    #   {
    #   gg+annotate("text", label = "Didn't participate", 
    #               x = 2012, y = 500, size = 6, 
    #               colour = "red")
    # }
    
  }
  #http://webcache.googleusercontent.com/search?q=cache:qSFaw5CtYcwJ:stackcode.xyz/sc%3Fid%3Dis38917101+&cd=1&hl=en&ct=clnk&gl=il&client=ubuntu
  # http://www.vardump.pw/sc?id=is38917101+&cd=1&hl=en&ct=clnk&gl=il&client=ubuntu
    tooltipPlotFunction<-function(country, hover){
    cnt<-Countries%>%filter(Hebrew==country)%>%select(CNT)
    plotData3 <- plotData2%>%filter(Country==cnt[1,1])

    x <- nearPoints(plotData3, hover, threshold = 40, maxpoints=3)
    y<-round(x$Average)
    paste(y, sep="\n")
  }
  if(!input$Country1==""){
    #print(input$Country1)
  output$Country1Plot<-renderPlot({
    scoresPlotFunction(input$Country1)
  })
  output$Country1PlotTooltip <- renderText({
    tooltipPlotFunction(input$Country1, input$scoresPlot_hover1)
  })
  
  output$Country2Plot<-renderPlot({
    scoresPlotFunction(input$Country2)
  })
  output$Country2PlotTooltip <- renderText({
    tooltipPlotFunction(input$Country2, input$scoresPlot_hover2)
  })
  
  output$Country3Plot<-renderPlot({
    scoresPlotFunction(input$Country3)
  })
  output$Country3PlotTooltip <- renderText({
    tooltipPlotFunction(input$Country3, input$scoresPlot_hover3)
  })
  
  output$Country4Plot<-renderPlot({
    scoresPlotFunction(input$Country4)
  })
  output$Country4PlotTooltip <- renderText({
    tooltipPlotFunction(input$Country4, input$scoresPlot_hover4)
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
