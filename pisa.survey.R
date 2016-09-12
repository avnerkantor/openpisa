# https://cran.r-project.org/web/packages/dplyr/vignettes/databases.html
# https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html

# https://bigquery.cloud.google.com/queries/r-shiny-1141

# ST04Q01 %IN% Gender
# ST04Q01 == Gender
# !is.na(ST04Q01 == Gender)

#Bigquery Approach

# endpoint_gce <- oauth_endpoints("google")
# secrets_gce <- jsonlite::fromJSON("ShinyServer-41d749479100.json")
# scope_gce_bigqr <- c("https://www.googleapis.com/auth/bigquery")
# token <- oauth_service_token(endpoint = endpoint_gce,secrets = secrets_gce,scope = scope_gce_bigqr)
# set_access_cred(token)
pisadb<-src_bigquery("r-shiny-1141", "pisa")
student2012<- tbl(pisadb, "student2012")
school2012<- tbl(pisadb, "school2012")

#loading data


observe({
  SurveySelectedID <- as.vector(unlist(select(filter(PisaSelectIndex, HebSubject == input$SurveySubject, HebCategory==input$SurveyCategory, HebSubCategory==input$SurveySubCategory), ID)))      
  
  surveyPlotFunction<-function(country) {
    
    Country<-as.vector(unlist(Countries%>%filter(Hebrew==country)%>%select(CNT)))
    surveyData1<-student2012%>%select_("CNT", SurveySelectedID, "ST04Q01", "ESCS")%>%filter(CNT==Country)
    
    if(is.null(input$Gender)){
      if(is.null(input$Escs)){
        #General
        surveyTable<-surveyData1%>%
          count_(SurveySelectedID)
        surveyTable<-collect(surveyTable)
        surveyTable<-surveyTable%>% mutate(freq = round(100 * n/sum(n), 1), group="General")%>%
          rename_(answer=SurveySelectedID)
      } else {
        # General Escs
        surveyTable<-surveyData1%>%
          filter(ESCS %in% c(input$Escs))%>%
          group_by_("ESCS", SurveySelectedID)%>%
          tally  %>%
          group_by(ESCS)
        surveyTable<-collect(surveyTable)
        surveyTable<-surveyTable%>%   mutate(freq = round(100 * n/sum(n), 0))%>%
          rename_(answer=SurveySelectedID, group="ESCS")
      }
    } else {
      if(length(input$Gender)==1){
        if(is.null(input$Escs)) {
          surveyTable<-surveyData1%>%
            filter(ST04Q01 %in% c(input$Gender))%>%
            group_by_("ST04Q01", SurveySelectedID)%>%
            tally  %>%
            group_by(ST04Q01)
          surveyTable<-collect(surveyTable)
          surveyTable<-surveyTable%>%   mutate(freq = round(100 * n/sum(n), 0))%>%
            rename_(answer=SurveySelectedID, group="ST04Q01")
            
        } else {
          surveyTable<-surveyData1%>%
            filter(ST04Q01  %in% c(input$Gender))%>%
            filter(ESCS %in% c(input$Escs))%>%
            group_by_("ESCS", SurveySelectedID)%>%
            tally  %>%
            group_by(ESCS)
          surveyTable<-collect(surveyTable)
          surveyTable<-surveyTable%>%  mutate(freq = round(100 * n/sum(n), 0))%>%
            rename_(answer=SurveySelectedID, group="ESCS")
        }
      } else {
        surveyTable<-surveyData1%>%
          filter(ST04Q01 %in% c(input$Gender))%>%
          group_by_("ST04Q01", SurveySelectedID)%>%
          tally  %>%
          group_by(ST04Q01)
        surveyTable<-collect(surveyTable)
        surveyTable<-surveyTable%>%   mutate(freq = round(100 * n/sum(n), 0))%>%
          rename_(answer=SurveySelectedID, group="ST04Q01")
      } 
    }
    

    ggplot(data=surveyTable, aes(x=answer, y=freq, fill=group)) +
      geom_bar(position="dodge",stat="identity") + 
      coord_flip() +
      labs(title="", y="" ,x= "") +
      #scale_y_discrete(breaks=c(0, 100))
      theme_bw() +
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
      facet_grid(. ~group) +
      scale_y_continuous(breaks=c(0, 100)) +
      theme(
        panel.border = element_blank(),
        panel.grid.major=element_blank(),
        axis.ticks = element_blank(),
        legend.position="none",
        strip.text.x = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line.x = element_line(color="#c7c7c7", size = 0.3),
        axis.line.y = element_line(color="#c7c7c7", size = 0.3)) 
        
     }
 
    
### Plots ####
  if(length(SurveySelectedID)==1){
  output$Country1SurveyPlot<-renderPlot({
    surveyPlotFunction(input$Country1)
  })
  # output$Country1PlotTooltip <- renderUI({
  #   CountrySurvey1PlotTooltip(input$Country1, input$surveyPlot_hover1)
  # })
  output$Country2SurveyPlot<-renderPlot({
    surveyPlotFunction(input$Country2)
  })
  # output$Country2PlotTooltip <- renderUI({
  #   CountrySurvey2PlotTooltip(input$Country2, input$surveyPlot_hover2)
  # })
  output$Country3SurveyPlot<-renderPlot({
    surveyPlotFunction(input$Country3)
    
  })
  # output$Country3PlotTooltip <- renderUI({
  #   CountrySurvey3PlotTooltip(input$Country3, input$surveyPlot_hover3)
  # })
  
  output$Country4SurveyPlot<-renderPlot({
    surveyPlotFunction(input$Country4)
  })
  
  # output$Country4PlotTooltip <- renderUI({
  #   CountrySurvey4PlotTooltip(input$Country4, input$surveyPlot_hover4)
  # })
  
  }
})