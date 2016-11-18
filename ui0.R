shinyUI(bootstrapPage(  
  includeCSS("www/style.css"),  
  tags$head(tags$script(src="custom.js")),
  
  mainPanel(
  includeHTML("www/index1.html")
    #htmlOutput("inc")
  ))
)

#http://shiny.rstudio.com/articles/templates.html