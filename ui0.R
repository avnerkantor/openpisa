library(plotly)
shinyUI(fluidPage(
  
  includeCSS("www/style0.css"),  
  #tags$head(tags$script(src="custom.js")),
  #titlePanel("תיק חינוך"),
  tabsetPanel(type = "tabs", id="tabs", #selected = "analyze",
              tabPanel(value="scores", title="הישגים", class="hebrew",
                       #img(src="PISA_TopBG.jpg", class="header-image"),
                       h1('כיצד מתקדמת מערכת החינוך?', class="header-text"),
                       
                       fluidRow(
                         column(12,
                                h4("די טוב"),
                                
                                
                                radioButtons(inputId="Subject", label="", inline=T, choices = c(
                                  "מתמטיקה" = "Math",
                                  "מדעים" = "Science",
                                  "קריאה" = "Reading",
                                  "פתרון בעיות"="ProblemSolving",
                                  "פיננסים"="Financial"
                                ))
                                
                         )),
                       fluidRow(
                         column(6,
                                checkboxGroupInput(inputId="Escs", label="מדד סוציואקונומי", inline=T, choices = c(
                                  "גבוה"="High",
                                  "בינוני"="Medium",
                                  "נמוך"="Low"
                                )), selected=NULL),
                         column(2,
                                # actionButton("Female", "Female"),
                                # actionButton("Male", "Male")),
                                checkboxGroupInput(inputId="Gender", label="מגדר", inline=T, choices = c(
                                  "בנות"="Female",
                                  "בנים"="Male"
                                )), selected="בנות"),
                         column(1,
                                #actionButton("calibrationCheck", "Go!"),
                                checkboxInput(inputId="calibrationCheck", label="ראשי", value=TRUE)
                         ),
                         column(3,
                                radioButtons(inputId="worldOrIsrael", label="", inline=T, choices = c(
                                  "מדינות"="World",
                                  "ישראל"="Israel"
                                  
                                )))
                       ),
                       textOutput("text1"),
                       #tableOutput("table1")
                       
                       fluidRow(
                         column(3,
                                selectInput(inputId="Country4", label="", choices = ""),
                                plotOutput("Country4Plot", height = 200)
                         ),
                         column(3,
                                selectInput(inputId="Country3", label="", choices = ""),
                                plotOutput("Country3Plot", height = 200)
                         ),
                         column(3,
                                selectInput(inputId="Country2", label="", choices = ""),
                                plotOutput("Country2Plot", height = 200)
                         ),
                         column(3,
                                selectInput(inputId="Country1", label="", choices = ""),
                                plotlyOutput("Country1Plot", height = 200)
                         )
                       ),
                       br(),br(),br(),
                       fluidRow(
                         DT::dataTableOutput('pisaScoresTable')
                       ),
                       
                       fluidRow(
                         column(12,
                                h4("מידע"),
                                numericInput("levelNumber", "רמה", min=1, max=6, value=3, step=1, width = "8%"),
                                tableOutput("ExplenationTable"),
                                #sliderInput("levelSlider", "", min=1, max=6, value=3, width = "100%"),
                                h6('מקור: ראמ"ה'),
                                h5("פער של 35 נקודות הוא שווה ערך לפיגור בשנת לימודים שלמה."),
                                h5("הפער בין רמה לרמה הוא שווה ערך לפיגור בשתי שנות לימוד.")
                                
                         )
                       )
              ),
              tabPanel(value="expertise", title="בקיאות", class="hebrew",
                       h4("בקיאות")
              ),
              tabPanel(value="survey", title = "אקלים חינוכי", class="hebrew",
                       h4("מהו האקלים החינוכי?")
              ),
              tabPanel(value="analyze", title="ניתוח משתנים",
                       h4("אני  מנתח")
              ),
              tabPanel(value="blog", title = "בלוג", 
                       h4("redirect or iframe")
              ),
              tabPanel(value="about", title = "אודות", class="hebrew",
                       h4("מי אנחנו?")
              ),
              tabPanel(value="english", title="English",
                       h1("English")
              )
              
  )
))
