shinyUI(fluidPage(
  
  includeCSS("www/style.css"),  
  tags$head(tags$script(src="custom.js")),
  #titlePanel("תיק חינוך"),
  tabsetPanel(type = "tabs", id="tabs", #selected = "analyze",
              tabPanel(value="scores", title="הישגים", class="hebrew",
                       img(src="PISA_TopBG.jpg", class="header-image"),
                       h1('כיצד מתקדמת מערכת החינוך?', class="header-text"),
                       
                       fluidRow(
                         column(12,
                                h4("די טוב"),
                                tags$div(HTML('<div id="Subject" class="form-group shiny-input-radiogroup shiny-input-container shiny-input-container-inline">
<div id="emotion" class="shiny-options-group">
<label class="radio-inline subjectText">
<input type="radio" name="Subject" value="Math" checked="checked"/>
<span><img src="math.png" class="subjectImage"/></span>
</label>
<label class="radio-inline subjectText">
<input type="radio" name="Subject" value="Science"/>
<span><img src="science.png" class="subjectImage"/></span>
</label>
<label class="radio-inline subjectText">
<input type="radio" name="Subject" value="Reading"/>
<span><img src="reading.png" class="subjectImage"/></span>
</label>
<label class="radio-inline subjectText">
<input type="radio" name="Subject" value="ProblemSolving"/>
<span><img src="problemSolving.png" class="subjectImage"/></span>
</label>
<label class="radio-inline subjectText">
<input type="radio" name="Subject" value="Financial"/>
<span><img src="financial.png" class="subjectImage"/></span>
</label>
</div>
</div>'))
                                
                                # radioButtons(inputId="Subject", label="", inline=T, choices = c(
                                #   "מתמטיקה" = "Math",
                                #   "מדעים" = "Science",
                                #   "קריאה" = "Reading",
                                #   "פתרון בעיות"="ProblemSolving",
                                #   "פיננסים"="Financial"
                                # ))
                                
                         )),
                       fluidRow(
                         column(6,
                                checkboxGroupInput(inputId="Escs", label="מדד סוציואקונומי", inline=T, choices = c(
                                  "גבוה"="High",
                                  "בינוני"="Medium",
                                  "נמוך"="Low"
                                )), selected=NULL),
                         column(2,
                                checkboxGroupInput(inputId="Gender", label="מגדר", inline=T, choices = c(
                                  "בנות"="Female",
                                  "בנים"="Male"
                                )), selected=NULL),
                         column(1,
                                checkboxInput(inputId="calibrationCheck", label="ראשי", value=TRUE)
                         ),
                         column(3,
                                radioButtons(inputId="worldOrIsrael", label="", inline=T, choices = c(
                                  "מדינות"="World",
                                  "ישראל"="Israel"
                                  
                                )))
                       ),
                       #textOutput("text1"),
                       #tableOutput("table1")
                       
                       fluidRow(
                         column(3,
                                selectInput(inputId="Country4", label="", choices = names(oecdList), selected = "דרום-קוריאה"),
                                plotOutput("Country4Plot", height = 200)
                         ),
                         column(3,
                                selectInput(inputId="Country3", label="", choices = names(oecdList), selected = "פינלנד"),
                                plotOutput("Country3Plot", height = 200)
                         ),
                         column(3,
                                selectInput(inputId="Country2", label="", choices = names(oecdList), selected = "ארצות-הברית"),
                                plotOutput("Country2Plot", height = 200)
                         ),
                         column(3,
                                selectInput(inputId="Country1", label="", choices = names(oecdList), selected = "ישראל"),
                                plotOutput("Country1Plot", height = 200)
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
                       sidebarPanel(
                         # use regions as option groups
                         selectizeInput('x1', 'X1', choices = list(
                           Eastern = c(`New York` = 'NY', `New Jersey` = 'NJ'),
                           Western = c(`California` = 'CA', `Washington` = 'WA')
                         ), multiple = TRUE),
                         
                         # use updateSelectizeInput() to generate options later
                         selectizeInput('x2', 'X2', choices = NULL),
                         
                         # an ordinary selectize input without option groups
                         selectizeInput('x3', 'X3', choices = setNames(state.abb, state.name)),
                         
                         # a select input
                         selectInput('x4', 'X4', choices = list(
                           Eastern = c(`New York` = 'NY', `New Jersey` = 'NJ'),
                           Western = c(`California` = 'CA', `Washington` = 'WA')
                         ), selectize = FALSE)
                       ),
                       mainPanel(
                         verbatimTextOutput('values')
                       ),
                       uiOutput("choose_HebSubject", class="hebrew"),
                       #br(),
                       DT::dataTableOutput('dictionaryTable')
                       #h4(tags$a(href="https://docs.google.com/spreadsheets/d/1NzknyOH5lrlcehOCpuwqJOAkMalgZvqFpsskRtg9EWY/edit#gid=1344723553&vpid=C2", "להורדת מילון המשתנים"))
                       
                       #dataTableOutput('pisaTable')
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

