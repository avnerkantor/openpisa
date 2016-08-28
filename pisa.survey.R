# https://cran.r-project.org/web/packages/dplyr/vignettes/databases.html
# https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html

# https://bigquery.cloud.google.com/queries/r-shiny-1141

# ST04Q01 %IN% Gender
# ST04Q01 == Gender
# !is.na(ST04Q01 == Gender)

#Bigquery Approach
pisadb<-src_bigquery("r-shiny-1141", "pisa")
Student2012<- tbl(pisadb, "student2012")
#loading data
#Student2012<-load(url("https://storage.googleapis.com/opisa/newStudent2012.rda"))


observe({
  SurveySelectedID <- as.vector(unlist(select(filter(PisaSelectIndex, HebSubject == input$SurveySubject, HebCategory==input$SurveyCategory, HebSubCategory==input$SurveySubCategory), ID)))      
  
  # x<-Countries%>%filter(Hebrew==country)%>%select(CNT)
  # Country==x[1,1]
  surveyDataFunction<-function(country) {
    Country<-as.vector(unlist(Countries%>%filter(Hebrew==country)%>%select(CNT)))
    #General
    General<-Student2012%>%filter(CNT==Country)%>%count_(SurveySelectedID)
    General<-collect(General)
    General<-General%>%mutate(freq = round(100 * n/sum(n), 1), group="General")%>%rename_(answer=SurveySelectedID)
    
    #Gender
    Male<-Student2012%>%filter(CNT==Country, ST04Q01=="Male")%>%count_(SurveySelectedID)
    Male<-collect(Male)
    Male<-Male%>%mutate(freq = round(100 * n/sum(n), 1), group="Male")%>%rename_(answer=SurveySelectedID)
    
    Female<-Student2012%>%filter(CNT==Country, ST04Q01=="Female")%>%count_(SurveySelectedID)
    Female<-collect(Female)
    Female<-Female%>%mutate(freq = round(100 * n/sum(n), 1), group="Female")%>%rename_(answer=SurveySelectedID)

    #ESCS
    High<-Student2012%>%filter(CNT==Country, ESCS>"0.7")%>%count_(SurveySelectedID)
    High<-collect(High)
    High<-High%>%mutate(freq = round(100 * n/sum(n), 1), group="High")%>%rename_(answer=SurveySelectedID)
    
    Medium<-Student2012%>%filter(CNT==Country,  ESCS<="0.7", ESCS>="0.2")%>%count_(SurveySelectedID)
    Medium<-collect(Medium)
    Medium<-Medium%>%mutate(freq = round(100 * n/sum(n), 1), group="Medium")%>%rename_(answer=SurveySelectedID)
    
    Low<-Student2012%>%filter(CNT==Country,  ESCS<"0.2")%>%count_(SurveySelectedID)
    Low<-collect(Low)
    Low<-Low%>%mutate(freq = round(100 * n/sum(n), 1), group="Low")%>%rename_(answer=SurveySelectedID)
    
    surveyTable<-bind_rows(General, Male, Female, High, Medium, Low)
  }
      
  surveyPlotFunction<-function(surveyTable) {

    if (!is.null(input$Gender) & is.null(input$Escs)){
      surveyData<- surveyTable %>%
        filter(group %in% c(input$Gender))
    } else {
      surveyData<- surveyTable %>% filter(group=="General")
    }
    if (!is.null(input$Escs) & is.null(input$Gender)){
      surveyData<- surveyTable %>%
        filter(group %in% c(input$Escs))
    } else {
      surveyData<- surveyTable %>% filter(group=="General")
    }
    
    ggplot(data=surveyData, aes(x=answer, y=freq, fill=group)) +
      geom_bar(position="dodge",stat="identity") + 
      coord_flip() +
      labs(title="", y="" ,x= "") +
      #scale_y_discrete(breaks=c(0, 100))
      theme_bw() +
      facet_grid(. ~group) +
      theme(
        panel.border = element_blank(),
        panel.grid.major=element_blank(),
        axis.ticks = element_blank(),
        legend.position="none",
        strip.text.x = element_blank(),
        panel.grid.minor = element_blank() )
     }
  

    # output$text1 <- renderText(
    #   paste(Country)
    # )
  
#### Plots ####
  if(length(SurveySelectedID)==1){
  output$Country1SurveyPlot<-renderPlot({
    surveyTable<-surveyDataFunction(input$Country1)
    surveyPlotFunction(surveyTable)
  })
  # output$Country1PlotTooltip <- renderUI({
  #   tooltipExpertiseHighPlotFunction(input$Country1, input$plot_hover1)
  # })
  
  output$Country2SurveyPlot<-renderPlot({
    surveyTable<-surveyDataFunction(input$Country2)
    surveyPlotFunction(surveyTable)
    
  })
  # output$Country2PlotTooltip <- renderUI({
  #   tooltipExpertiseHighPlotFunction(input$Country2, input$plot_hover2)
  # })
  
  output$Country3SurveyPlot<-renderPlot({
    surveyTable<-surveyDataFunction(input$Country3)
    surveyPlotFunction(surveyTable)
    
  })
  # output$Country3PlotTooltip <- renderUI({
  #   tooltipExpertiseHighPlotFunction(input$Country3, input$plot_hover3)
  # })
  
  output$Country4SurveyPlot<-renderPlot({
    surveyTable<-surveyDataFunction(input$Country4)
    surveyPlotFunction(surveyTable)
    
  })
  # output$Country4PlotTooltip <- renderUI({
  #   tooltipExpertiseHighPlotFunction(input$Country4, input$plot_hover4)
  # })
  }
})