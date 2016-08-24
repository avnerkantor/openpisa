load("data/pisaData2.rda")

observeEvent(input$calibrationCheck, {
  updateCheckboxGroupInput(session, inputId="Gender", selected = "")
})

observeEvent(input$calibrationCheck, {
  updateCheckboxGroupInput(session, inputId="Escs", selected = "")
})

#todo לעשות הודעת שגיאה של לא נבחנו במקצוע. אם אין מידע
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

######Survey #####
observe({
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
  selected="לימודי מתמטיקה")
})

observeEvent(input$SurveySubject,{
  updateSelectInput(session, "SurveyCategory", "", as.vector(unlist(select(filter(PisaSelectIndex, HebSubject == input$SurveySubject), HebCategory))))
  
})

observeEvent(input$SurveyCategory,{
  updateSelectInput(session, "SurveySubCategory", "", as.vector(unlist(select(filter(PisaSelectIndex, HebSubject == input$SurveySubject, HebCategory==input$SurveyCategory), HebSubCategory))))
})

observeEvent(input$SurveyYear,{
  updateSelectInput(session, inputId="SurveyYear", label="", 
                    choices = c(2015, 2012, 2009, 2006), selected = 2012)
})

