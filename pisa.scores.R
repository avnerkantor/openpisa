###UI

observe({
    updateSelectInput(session, "Country1", choices = names(countriesList), selected = "Israel")
    updateSelectInput(session, "Country2", choices = names(countriesList), selected = "Finland")
    updateSelectInput(session, "Country3", choices = names(countriesList), selected = "Spain")
    updateSelectInput(session, "Country4", choices = names(countriesList), selected = "United States of America")
})
####
observe({
  
  SubjectExpertiseLevels<-ExpertiseLevels %>%
    select(Level, contains(input$Subject))%>%
    filter(!is.na(input$Subject))
  
  plotData1<-pisaData%>%filter(Subject==input$Subject, Performers==0)%>%select(-Subject, -Performers)
  #print(input$Gender)#if(input$Gender=="General"){
  #TODO
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
    
    plotData3 <- plotData2%>%filter(Country==country)
    participatedNumber<-length(unique(plotData3$Year))

    gg<-ggplot(plotData3, aes(x=Year, y=Average, colour=GenderESCS, text=round(Average))) +
      scale_colour_manual(values = groupColours) +
      guides(colour=FALSE) +
      
      labs(title="", y="" ,x= "") +
      theme_bw() +
      #geom_label() +
      theme(plot.margin=unit(c(0,15,5,10), "pt"),
            panel.border = element_blank(),
            axis.ticks = element_blank(),
            panel.grid.major.x=element_blank(),
            panel.grid.major.y = element_line(colour="#e0e0e0", size=0.3),
            legend.position="none",
            axis.line.x = element_line(color="#c7c7c7", size = 0.3),
            axis.line.y = element_line(color="#c7c7c7", size = 0.3)
      ) +
      scale_x_continuous(breaks=c(2006, 2009, 2012, 2015)) +
      scale_y_continuous(
        #minor_breaks=SubjectExpertiseLevels[2],
        breaks=SubjectExpertiseLevels[2],
        labels=SubjectExpertiseLevels[1],
        #limits = c(200,700),
        limits=c(as.numeric(unlist(ExpertiseLevelsLimits[input$Subject])))
        )

    if(participatedNumber>0) {
      if(participatedNumber>1) {
       #https://plot.ly/r/axes/
        gp<-gg+geom_line(size=1)
        #https://plot.ly/r/reference
        #https://github.com/plotly/plotly.js/blob/master/src/components/modebar/buttons.js
        ggplotly(gp, tooltip = c("text"))%>%
          config(p = ., displayModeBar = FALSE)%>%
          layout(hovermode="x")

      } else{
        gp<-gg+geom_point(size=2)
        ggplotly(gp, tooltip = c("text"))%>%
          config(p = ., displayModeBar = FALSE)%>%
          layout(hovermode="x")
      }
    } 
    else 
    {
      gg+annotate("text", label = "Didn't Participate",
                  x = 2012, y = 500, size = 6, 
                  colour = "#c7c7c7")%>%config(p = ., displayModeBar = FALSE)
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
  
  updateNumericInput(session, "LevelNumber", "", min=minLevel, max=maxLevel, value=3, step=1)
  
  output$ExplenationTable <- renderTable({
    LevelExplenation%>%filter(Subject==input$Subject, Level==input$LevelNumber)%>%select(Explenation)
  }, include.rownames=FALSE, include.colnames=FALSE)
})




