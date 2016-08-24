# https://cran.r-project.org/web/packages/dplyr/vignettes/databases.html
# https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html

# https://bigquery.cloud.google.com/queries/r-shiny-1141

# ST04Q01 %IN% Gender
# ST04Q01 == Gender
# !is.na(ST04Q01 == Gender)

pisadb<-src_bigquery("r-shiny-1141", "pisa")
Student2012<- tbl(pisadb, "student2012")

observe({
  SurveySelectedID <- as.vector(unlist(select(filter(PisaSelectIndex, HebSubject == input$SurveySubject, HebCategory==input$SurveyCategory, HebSubCategory==input$SurveySubCategory), ID)))      
  
  #### Function ####
  surveyPlotFunction<-function(country) {
    Country<-as.vector(unlist(Countries%>%
                                filter(Hebrew==country)%>%select(CNT)))
    
    if (is.null(input$Gender)){
      if(is.null(input$Escs)){
        c1<-Student2012%>%filter(CNT==Country)%>%count_(SurveySelectedID)
      } else {
        switch (ESCS,
                High = {
                  c1<-Student2012%>%filter(CNT==Country, ESCS>"0.7")%>%count_(SurveySelectedID)
                },
                Medium={
                  c1<-Student2012%>%filter(CNT==Country, ESCS<="0.7", ESCS>="0.2")%>%count_(SurveySelectedID)
                },
                Low={
                  c1<-Student2012%>%filter(CNT==Country, ESCS<"0.2")%>%count_(SurveySelectedID)
                })}
    }else{
      c1<-Student2012%>%filter(CNT==Country, ST04Q01==Gender)%>%count_(SurveySelectedID)
    }
    
    c2<-collect(c1)
    c3<-c2%>%mutate(freq = round(100 * n/sum(n), 1))%>%rename_(var=SurveySelectedID)
    
    ggplot(data=c3, aes(x=var, y=freq, fill=group)) +
      geom_bar(position="dodge",stat="identity", fill="#b276b2") + 
      coord_flip() +
      labs(title="", y="" ,x= "") +
      #scale_y_discrete(breaks=c(0, 100))
      theme_bw() +
      theme(
        panel.border = element_blank(),
        panel.grid.major=element_blank(),
        axis.ticks = element_blank(),
        panel.grid.minor = element_blank() )
  }
  
  
  # output$text1 <- renderText(
  #   paste(Country)
  # )
  
  #### Plots ####
  if(length(SurveySelectedID)==1){
    output$Country1SurveyPlot<-renderPlot({
      surveyPlotFunction(input$Country1)
    })
    # output$Country1PlotTooltip <- renderUI({
    #   tooltipExpertiseHighPlotFunction(input$Country1, input$plot_hover1)
    # })
    
    output$Country2SurveyPlot<-renderPlot({
      surveyPlotFunction(input$Country2)
    })
    # output$Country2PlotTooltip <- renderUI({
    #   tooltipExpertiseHighPlotFunction(input$Country2, input$plot_hover2)
    # })
    
    output$Country3SurveyPlot<-renderPlot({
      surveyPlotFunction(input$Country3)
    })
    # output$Country3PlotTooltip <- renderUI({
    #   tooltipExpertiseHighPlotFunction(input$Country3, input$plot_hover3)
    # })
    
    output$Country4SurveyPlot<-renderPlot({
      surveyPlotFunction(input$Country4)
    })
    # output$Country4PlotTooltip <- renderUI({
    #   tooltipExpertiseHighPlotFunction(input$Country4, input$plot_hover4)
    # })
  }
})