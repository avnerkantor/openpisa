shinyServer(function(input, output, session) {
  PisaSelectIndex<-read.csv("data/PisaSelectIndex.csv", header = TRUE, sep=",")

  stuDict2006<-read.csv("data/dict/s2006dict.csv", header = TRUE, sep=",", quote = ";")
  schDict2006<-read.csv("data/dict/school2006dicta.csv", header = TRUE, sep=",", quote = ";")
  stuDict2009<-read.csv("data/dict/s2009dict.csv", header = TRUE, sep=",", quote = ";")
  schDict2009<-read.csv("data/dict/school2009dicta.csv", header = TRUE, sep=",", quote = ";")
  load("data/dict/stuDict2012.rda")
  load("data/dict/schDict2012.rda")
  
  source('pisa.dashboard.R', local=TRUE)
  source('pisa.scores.R', local=TRUE)
  source('pisa.expertise.R', local=TRUE)
  source('pisa.survey.R', local=TRUE)
  #source('pisa.analyze.R', local=TRUE)
  
  # options(shiny.error=browser)
  #http://stackoverflow.com/questions/28579711/display-r-console-logs-on-shiny-server
  # library(log4r)
  # loggerDebug <- create.logger()
  # logfile(loggerDebug) <- 'data/debugData.log'
  # level(loggerDebug) <- 'INFO'
  # 
  # loggerServer <- create.logger()
  # logfile(loggerServer) <- 'data/serverData.log'
  # level(loggerServer) <- 'INFO'
  
  #load("/srv/shiny-server/tikhinuch5/data/student2012.rda")
  
})



