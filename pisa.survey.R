####loading data####

pisadb<-src_bigquery("r-shiny-1141", "pisa")
pisa2012<- tbl(pisadb, "pisa2012")
pisa2009<- tbl(pisadb, "pisa2009")
pisa2006<- tbl(pisadb, "pisa2006")



######UI #####
observe({
  updateSelectInput(session, inputId="SurveyYear", label="", 
                    choices = c(2012)
                    #list(
                    #  'מבחן פיז"ה 2015 - בקרוב'=c('שאלון תלמידים'='student2015', 'שאלון בתי ספר'='school2015'),
                    #'מבחן פיז"ה 2012'=c('שאלון תלמידים'='student2012', 'שאלון בתי ספר'='school2012')
                    # 'מבחן פיז"ה 2009'=c("שאלון תלמידים"="student2009", "שאלון בתי ספר"="school2009"),
                    #  'מבחן פיז"ה 2006'=c("שאלון תלמידים"="student2006", "שאלון בתי ספר"="school2006"),
                    # 'שאלונים חוזרים - בקרוב'=c("זמינות ושימוש באמצעי תקשוב"="t1", "פתרון בעיות"="t2")
                    , selected = 2012)
})

observeEvent(input$SurveyYear,{
  switch (input$SurveyYear,
          "2012" = {
            updateSelectInput(session, inputId="SurveySubject", label="", choices = c(
              # "אוריינות פיננסית" = "אוריינות פיננסית"
              #"אוריינות מחשב" = "אוריינות מחשב",
              "זמינות ושימוש באמצעי תקשוב"="זמינות ושימוש באמצעי תקשוב",
              "משפחה ובית"="משפחה ובית",
              "פתרון בעיות"="פתרון בעיות",
              "לימודי מתמטיקה"="לימודי מתמטיקה",
              "אופי בית הספר"="אופי בית הספר",
              "מורים"="מורים",
              "משאבי בית הספר"="משאבי בית הספר",
              "תכנית הלימודים"="תכנית הלימודים",
              "בית הספר"="בית הספר",
              "מדיניות בית הספר"="מדיניות בית הספר"
              #"מנהיגות חינוכית"="מנהיגות חינוכית"
              
            ),
            selected="לימודי מתמטיקה"
            )
          },
          "2009"={print("asdf") }
  )
})




observeEvent(input$SurveySubject,{
  
  updateSelectInput(session, "SurveyCategory", "", as.vector(unlist(select(filter(pisaDictionary, Year == input$SurveyYear, HebSubject == input$SurveySubject), HebCategory))))
})

observeEvent(input$SurveyCategory,{
  updateSelectInput(session, "SurveySubCategory", "", as.vector(unlist(select(filter(pisaDictionary, Year == input$SurveyYear, HebSubject == input$SurveySubject, HebCategory==input$SurveyCategory), HebSubCategory)))
  )
})



observe({
  
  SurveySelectedID <- as.vector(unlist(select(filter(pisaDictionary, Year == input$SurveyYear, HebSubject == input$SurveySubject, HebCategory==input$SurveyCategory, HebSubCategory==input$SurveySubCategory), ID))) 
  surveyData<-pisa2012
  surveyPlotFunction<-function(country) {
    
    Country<-as.vector(unlist(Countries%>%filter(Hebrew==country)%>%select(CNT)))
    
    # switch (object,
    #   case = action
    # )
    
    if(input$SurveyYear==2012)
      surveyData<-pisa2012
    
    
    surveyData1<-surveyData%>%select_("CNT", SurveySelectedID, "ST04Q01", "ESCS")%>%filter(CNT==Country)
    
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
    
    
    ####ggplot####
    gh<-ggplot(data=surveyTable, aes(x=answer, y=freq, fill=group, text=round(freq))) +
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
    ggplotly(gh, tooltip = c("text"))%>%config(p = ., staticPlot = FALSE, displayModeBar = TRUE, workspace = FALSE, editable = FALSE, sendData = FALSE, displaylogo = FALSE,
                                               modeBarButtonsToRemove = list("resetScale2d", "hoverCompareCartesian", "autoScale2d", "hoverClosestCartesian"))
    
  }
  
  ### Plots ####  
  
  if(length(SurveySelectedID)==1){
    #print(is.data.frame(get("surveyData")))
    # print(exists("surveyData"))
    # print(is.null(surveyData))
    # print(is.data.frame(get("surveyData")))
    
    output$Country1SurveyPlot<-renderPlotly({
      surveyPlotFunction(input$Country1)
    })
    
    output$Country2SurveyPlot<-renderPlotly({
      surveyPlotFunction(input$Country2)
    })
    
    output$Country3SurveyPlot<-renderPlotly({
      surveyPlotFunction(input$Country3)
      
    })
    
    output$Country4SurveyPlot<-renderPlotly({
      surveyPlotFunction(input$Country4)
    })
    
  }
})