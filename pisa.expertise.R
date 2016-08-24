

#pisaData3Expertise<-pisaData3%>%filter(Performers!=0)
#pisaData3Expertise$Average<-round(pisaData3Expertise$Average, digits = 1)


observe({

  
  plotHighData<-pisaData2%>%filter(Subject==input$Subject, Performers=="High")%>%select(-Subject)
  
  if (!is.null(input$Gender)){
    if(!is.null(input$Escs)){
      plotHighData2<- plotHighData %>%
        filter(Gender %in% c(input$Gender))%>%
        filter(ESCS %in% c(input$Escs))
    } else {
      plotHighData2<- plotHighData %>%
        filter(Gender %in% c(input$Gender))%>%
        filter(ESCS == 0)
    }
  } else {
    if (!is.null(input$Escs)){
      plotHighData2<- plotHighData %>%
        filter(Gender == 0)%>%
        filter(ESCS %in% c(input$Escs))
    } else {
      plotHighData2<-plotHighData %>%
        filter(Gender==0, ESCS==0)
    }
  }
  
  expertiseHighPlotFunction<-function(country){
    x<-Countries%>%filter(Hebrew==country)%>%select(CNT)
    plotHighData3 <- plotHighData2%>%filter(Country==x[1,1])
    
    ggplot(plotHighData3, aes(x=Year, y=Average, colour=GenderESCS)) +
      geom_line() +
      scale_colour_manual(values = c("General"="#b276b2", "Male"="#5da5da", "Female"="#f17cb0", "GeneralLow"="#bc99c7", "GeneralMedium"="#b276b2", "GeneralHigh"="#7b3a96", "MaleHigh"="#265dab", "MaleLow"="#88bde6", "MaleMedium"="#5da5da", "FemaleHigh"="#e5126f", "FemaleLow"="#f6aac9", "FemaleMedium"="#f17cb0")) +
      guides(colour=FALSE) +
      labs(title="", y="" ,x= "") +
      theme_bw() +
      theme(plot.margin=unit(c(0,15,0,0), "pt"),
            panel.border = element_blank(),
            #panel.grid.major=element_blank(),
            axis.ticks = element_blank(),
            #panel.grid.minor = element_line(colour="#e0e0e0", size=1),
            axis.line.x = element_line(color="#c7c7c7", size = 0.3),
            axis.line.y = element_line(color="#c7c7c7", size = 0.3)) 
      #scale_x_discrete(breaks=c(2006,2009,2012), limits=c(2006,2009, 2012)) +
      #scale_y_continuous(limits=c(0, 100))
  }
  #http://webcache.googleusercontent.com/search?q=cache:qSFaw5CtYcwJ:stackcode.xyz/sc%3Fid%3Dis38917101+&cd=1&hl=en&ct=clnk&gl=il&client=ubuntu
  # tooltipExpertiseHighPlotFunction<-function(country, hover){
  #   plotHighData3 <- plotHighData2%>%
  #     filter(Country==as.vector(unlist(Countries%>%
  #                                        filter(Hebrew==country)%>%select(CNT))))%>%select(-Country)
  #   x <- nearPoints(plotHighData3, hover, threshold = 10, maxpoints=1)
  #   y<-round(x$Average)
  #   paste(y)
  # }

  output$Country1HighPlot<-renderPlot({
    expertiseHighPlotFunction(input$Country1)
  })
  # output$Country1PlotTooltip <- renderUI({
  #   tooltipExpertiseHighPlotFunction(input$Country1, input$plot_hover1)
  # })
  
  output$Country2HighPlot<-renderPlot({
    expertiseHighPlotFunction(input$Country2)
  })
  # output$Country2PlotTooltip <- renderUI({
  #   tooltipExpertiseHighPlotFunction(input$Country2, input$plot_hover2)
  # })
  
  output$Country3HighPlot<-renderPlot({
    expertiseHighPlotFunction(input$Country3)
  })
  # output$Country3PlotTooltip <- renderUI({
  #   tooltipExpertiseHighPlotFunction(input$Country3, input$plot_hover3)
  # })
  
  output$Country4HighPlot<-renderPlot({
    expertiseHighPlotFunction(input$Country4)
  })
  # output$Country4PlotTooltip <- renderUI({
  #   tooltipExpertiseHighPlotFunction(input$Country4, input$plot_hover4)
  # })
})


##############################################


observe({
  
  
  plotLowData<-pisaData2%>%filter(Subject==input$Subject, Performers=="Low")%>%select(-Subject)
  
  if (!is.null(input$Gender)){
    if(!is.null(input$Escs)){
      plotLowData2<- plotLowData %>%
        filter(Gender %in% c(input$Gender))%>%
        filter(ESCS %in% c(input$Escs))
    } else {
      plotLowData2<- plotLowData %>%
        filter(Gender %in% c(input$Gender))%>%
        filter(ESCS == 0)
    }
  } else {
    if (!is.null(input$Escs)){
      plotLowData2<- plotLowData %>%
        filter(Gender == 0)%>%
        filter(ESCS %in% c(input$Escs))
    } else {
      plotLowData2<-plotLowData %>%
        filter(Gender==0, ESCS==0)
    }
  }
  
  expertiseLowPlotFunction<-function(country){
    x<-Countries%>%filter(Hebrew==country)%>%select(CNT)
    plotLowData3 <- plotLowData2%>%filter(Country==x[1,1])
      
    ggplot(plotLowData3, aes(x=Year, y=Average, colour=GenderESCS)) +
      geom_line() +
      scale_colour_manual(values = c("General"="#b276b2", "Male"="#5da5da", "Female"="#f17cb0", "GeneralLow"="#bc99c7", "GeneralMedium"="#b276b2", "GeneralHigh"="#7b3a96", "MaleHigh"="#265dab", "MaleLow"="#88bde6", "MaleMedium"="#5da5da", "FemaleHigh"="#e5126f", "FemaleLow"="#f6aac9", "FemaleMedium"="#f17cb0")) +
      guides(colour=FALSE) +
      labs(title="", y="" ,x= "") +
      theme_bw() +
      theme(plot.margin=unit(c(0,15,0,0), "pt"),
            panel.border = element_blank(),
            #panel.grid.major=element_blank(),
            axis.ticks = element_blank(),
            #panel.grid.minor = element_line(colour="#e0e0e0", size=1),
            axis.line.x = element_line(color="#c7c7c7", size = 0.3),
            axis.line.y = element_line(color="#c7c7c7", size = 0.3)) 
      #scale_x_discrete(breaks=c(2006,2009,2012), limits=c(2006,2009, 2012)) +
      #scale_y_continuous(limits=c(0, 100))
  }
  #http://webcache.googleusercontent.com/search?q=cache:qSFaw5CtYcwJ:stackcode.xyz/sc%3Fid%3Dis38917101+&cd=1&hl=en&ct=clnk&gl=il&client=ubuntu
  # tooltipExpertiseLowPlotFunction<-function(country, hover){
  #   plotLowData3 <- plotLowData2%>%
  #     filter(Country==as.vector(unlist(Countries%>%
  #                                        filter(Hebrew==country)%>%select(CNT))))%>%select(-Country)
  #   x <- nearPoints(plotLowData3, hover, threshold = 10, maxpoints=1)
  #   y<-round(x$Average)
  #   paste(y)
  # }
  
  output$Country1LowPlot<-renderPlot({
    expertiseLowPlotFunction(input$Country1)
  })
  # output$Country1PlotTooltip <- renderUI({
  #   tooltipExpertiseLowPlotFunction(input$Country1, input$plot_hover1)
  # })
  
  output$Country2LowPlot<-renderPlot({
    expertiseLowPlotFunction(input$Country2)
  })
  # output$Country2PlotTooltip <- renderUI({
  #   tooltipExpertiseLowPlotFunction(input$Country2, input$plot_hover2)
  # })
  
  output$Country3LowPlot<-renderPlot({
    expertiseLowPlotFunction(input$Country3)
  })
  # output$Country3PlotTooltip <- renderUI({
  #   tooltipExpertiseLowPlotFunction(input$Country3, input$plot_hover3)
  # })
  # 
  output$Country4LowPlot<-renderPlot({
    expertiseLowPlotFunction(input$Country4)
  })
  # output$Country4PlotTooltip <- renderUI({
  #   tooltipExpertiseLowPlotFunction(input$Country4, input$plot_hover4)
  # })
})

