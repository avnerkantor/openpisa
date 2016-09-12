
observe({
  
  plotHighData<-pisaData2%>%filter(Subject==input$Subject, Performers=="High")%>%select(-Subject)
  
  if(is.null(input$Gender)){
    if(is.null(input$Escs)){
      plotHighData2<- plotHighData %>%
        filter(Gender==0, ESCS==0)
    } else {
      plotHighData2<- plotHighData %>%
        filter(Gender == 0)%>%
        filter(ESCS %in% c(input$Escs))
    }
  } else {
    if(length(input$Gender)==1){
      if(is.null(input$Escs)) {
        plotHighData2<- plotHighData %>%
          filter(Gender  == input$Gender)%>%
          filter(ESCS == 0)
      } else {
        plotHighData2<- plotHighData %>%
          filter(Gender  == input$Gender)%>%
          filter(ESCS %in% c(input$Escs))
      }
    } else {
      plotHighData2<- plotHighData %>%
        filter(Gender %in% c(input$Gender))%>%
        filter(ESCS == 0)
    } 
  }
  
  expertiseHighPlotFunction<-function(country){
    x<-Countries%>%filter(Hebrew==country)%>%select(CNT)
    plotHighData3 <- plotHighData2%>%filter(Country==x[1,1])
    
    gh<-ggplot(plotHighData3, aes(x=Year, y=Average, colour=GenderESCS)) +
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
      scale_y_continuous(limits=c(0, 100), breaks=c(0, 20, 40, 60, 80, 100),
                         expand = c(0,0))
    
    if("2012" %in% plotHighData3$Year) {
      if("2009" %in% plotHighData3$Year) {
        gh+geom_line(size=1)
      } else{
        gh+geom_point(size=2)
      }
    } else {
      gh+annotate("text", label = "Didn't participate", 
                  x = 2012, y = 500, size = 6, 
                  colour = "red")
    }
  }
  
  tooltipExpertiseHighPlotFunction<-function(country, hover){
    cnt<-Countries%>%filter(Hebrew==country)%>%select(CNT)
    plotHighData3 <- plotHighData2%>%filter(Country==cnt[1,1])
    
    x <- nearPoints(plotHighData3, hover, threshold = 40, maxpoints=3)
    y<-round(x$Average)
    paste(y, sep="\n")
  }
  
  if(!input$Country1==""){
  output$Country1HighPlot<-renderPlot({
    expertiseHighPlotFunction(input$Country1)
  })
  output$Country1PlotTooltip <- renderText({
    tooltipExpertiseHighPlotFunction(input$Country1, input$highPlot_hover1)
  })
  
  output$Country2HighPlot<-renderPlot({
    expertiseHighPlotFunction(input$Country2)
  })
  output$Country2PlotTooltip <- renderText({
    tooltipExpertiseHighPlotFunction(input$Country2, input$highPlot_hover2)
  })
  
  output$Country3HighPlot<-renderPlot({
    expertiseHighPlotFunction(input$Country3)
  })
  output$Country3PlotTooltip <- renderText({
    tooltipExpertiseHighPlotFunction(input$Country3, input$highPlot_hover3)
  })
  
  output$Country4HighPlot<-renderPlot({
    expertiseHighPlotFunction(input$Country4)
  })
  output$Country4PlotTooltip <- renderText({
    tooltipExpertiseHighPlotFunction(input$Country4, input$highPlot_hover4)
  })
  }
})

##############################################

observe({
  
  
  plotLowData<-pisaData2%>%filter(Subject==input$Subject, Performers=="Low")%>%select(-Subject)
  
  if(is.null(input$Gender)){
    if(is.null(input$Escs)){
      plotLowData2<- plotLowData %>%
        filter(Gender==0, ESCS==0)
    } else {
      plotLowData2<- plotLowData %>%
        filter(Gender == 0)%>%
        filter(ESCS %in% c(input$Escs))
    }
  } else {
    if(length(input$Gender)==1){
      if(is.null(input$Escs)) {
        plotLowData2<- plotLowData %>%
          filter(Gender  == input$Gender)%>%
          filter(ESCS == 0)
      } else {
        plotLowData2<- plotLowData %>%
          filter(Gender  == input$Gender)%>%
          filter(ESCS %in% c(input$Escs))
      }
    } else {
      plotLowData2<- plotLowData %>%
        filter(Gender %in% c(input$Gender))%>%
        filter(ESCS == 0)
    } 
  }
  
  
  expertiseLowPlotFunction<-function(country){
    x<-Countries%>%filter(Hebrew==country)%>%select(CNT)
    plotLowData3 <- plotLowData2%>%filter(Country==x[1,1])
    
    gh<-ggplot(plotLowData3, aes(x=Year, y=Average, colour=GenderESCS)) +
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
      scale_y_continuous(limits=c(0, 100), breaks=c(0, 20, 40, 60, 80, 100),
                         expand = c(0,0))
    
    if("2012" %in% plotLowData3$Year) {
      if("2009" %in% plotLowData3$Year) {
        gh+geom_line(size=1)
      } else{
        gh+geom_point(size=2)
      }
    } else {
      gh+annotate("text", label = "Didn't participate", 
                  x = 2012, y = 500, size = 6, 
                  colour = "red")
    }
  }
  
  tooltipExpertiseLowPlotFunction<-function(country, hover){
    cnt<-Countries%>%filter(Hebrew==country)%>%select(CNT)
    plotLowData3 <- plotLowData2%>%filter(Country==cnt[1,1])
    
    x <- nearPoints(plotLowData3, hover, threshold = 40, maxpoints=3)
    y<-round(x$Average)
    paste(y, sep="\n")
  }
  
  output$Country1LowPlot<-renderPlot({
    expertiseLowPlotFunction(input$Country1)
  })
  output$Country1PlotTooltip <- renderText({
    tooltipExpertiseLowPlotFunction(input$Country1, input$lowPlot_hover1)
  })
  
  output$Country2LowPlot<-renderPlot({
    expertiseLowPlotFunction(input$Country2)
  })
  output$Country2PlotTooltip <- renderText({
    tooltipExpertiseLowPlotFunction(input$Country2, input$lowPlot_hover2)
  })
  
  output$Country3LowPlot<-renderPlot({
    expertiseLowPlotFunction(input$Country3)
  })
  output$Country3PlotTooltip <- renderText({
    tooltipExpertiseLowPlotFunction(input$Country3, input$lowPlot_hover3)
  })
  
  output$Country4LowPlot<-renderPlot({
    expertiseLowPlotFunction(input$Country4)
  })
  output$Country4PlotTooltip <- renderText({
    tooltipExpertiseLowPlotFunction(input$Country4, input$lowPlot_hover4)
  })
})

