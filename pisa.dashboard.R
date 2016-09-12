load("data/pisaData2.rda")

observeEvent(input$calibrationCheck, {
  updateCheckboxGroupInput(session, inputId="Gender", selected = "")
})

# observeEvent(input$calibrationCheck, {
#   updateCheckboxGroupInput(session, inputId="Escs", selected = "")
# })

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
  updateSelectInput(session, inputId="SurveyYear", label="", 
                    choices = list(
                      'מבחן פיז"ה 2015 - בקרוב'=c('שאלון תלמידים'='student2015', 'שאלון בתי ספר'='school2015'),
                      'מבחן פיז"ה 2012'=c('שאלון תלמידים'='student2012', 'שאלון בתי ספר'='school2012'),
                      'מבחן פיז"ה 2009'=c("שאלון תלמידים"="student2009", "שאלון בתי ספר"="school2009"),
                      'מבחן פיז"ה 2006'=c("שאלון תלמידים"="student2006", "שאלון בתי ספר"="school2006"),
                      'שאלונים חוזרים - בקרוב'=c("זמינות ושימוש באמצעי תקשוב"="t1", "פתרון בעיות"="t2")
                    ), selected = "student2012")
    })

observeEvent(input$SurveyYear, {
  switch (input$SurveyYear,
          "student2012" = {
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
          }
  )
})

observeEvent(input$SurveySubject,{
  
  switch (input$SurveyYear,
          student2012 = {updateSelectInput(session, "SurveyCategory", "", as.vector(unlist(select(filter(stuDict2012, HebSubject == input$SurveySubject), HebCategory))))},
          school2012 = {updateSelectInput(session, "SurveyCategory", "", as.vector(unlist(select(filter(schDict2012, HebSubject == input$SurveySubject), HebCategory))))}
  )
})

observeEvent(input$SurveyCategory,{
  
  switch (input$SurveyYear,
          student2012 = {updateSelectInput(session, "SurveySubCategory", "", as.vector(unlist(select(filter(stuDict2012, HebSubject == input$SurveySubject, HebCategory==input$SurveyCategory), HebSubCategory))))
},
          school2012 = {updateSelectInput(session, "SurveySubCategory", "", as.vector(unlist(select(filter(schDict2012, HebSubject == input$SurveySubject, HebCategory==input$SurveyCategory), HebSubCategory))))
}
  )
  
})



#Analyze

observe({
  updateSelectizeInput(session, 'analyzeVariables',
                       choices = as.character(PisaSelectIndex$ID),
                       selected = "WEALTH",
                       options=list(placeholder="בחר משתנים"))

})
observe({

  updateSelectInput(session, inputId="statisticalFunction", label="", choices = c(
    "מתאם"="AB",
    "רגרסיה לינארית"="CD",
    "רגרסיה מרובה"="ED",
    "FG"="FG"
  ),
  selected="AB")
})

output$pisaScoresTable <- DT::renderDataTable(
  filter='bottom',
  colnames = c('משתנה', 'תיאור באנגלית', 'נושא', 'קטגוריה', 'תת-קטגוריה'),
  options=list(
    pageLength = 5,
    searching=TRUE,
    autoWidth = TRUE
  ), rownames= FALSE,
  {
    PisaSelectIndex%>%select(ID, Measure, HebSubject, HebCategory, HebSubCategory)%>%
      filter(HebSubject=="מדדים")
    
  })

