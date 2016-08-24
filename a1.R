
updateSelectizeInput(session, 'x2', choices = list(
  Eastern = c(`Rhode Island` = 'RI', `New Jersey` = 'NJ'),
  Western = c(`Oregon` = 'OR', `Washington` = 'WA'),
  Middle = list(Iowa = 'IA')
), selected = 'IA')

output$values <- renderPrint({
  list(x1 = input$x1, x2 = input$x2, x3 = input$x3, x4 = input$x4)
})



output$choose_HebSubject<- renderUI({
  selectInput("tableSubject", "", unique(as.character(PisaSelectIndex$HebSubject)), selected = "מדדים")
})

observe({
  output$dictionaryTable <- DT::renderDataTable(options=list(
    pageLength = 5, order = list(3, 'dsc'), autoWidth = FALSE), rownames= FALSE,
  {
      PisaSelectIndex%>%filter(HebSubject==input$tableSubject) %>%
      select(ID, Measure, HebCategory, HebSubCategory)

  })

  output$pisaTable <- renderDataTable(options=list(
    pageLength = 5,
    searching=FALSE
  ),
  {
    pisaData3
  })
})
    output$downloadData <- downloadHandler(
      filename = function() {
        paste('PisaSelectIndex.csv')
      },
      content = function(file) {
        write.csv(PisaSelectIndex, file)
      }
    )
