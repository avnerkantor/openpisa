shinyServer(function(input, output, session) {
  #PisaSelectIndex<-read.csv("data/PisaSelectIndex.csv", header = TRUE, sep=",")
  load("data/pisaData2.rda")
  load("data/pisaDictionary.rda")
  #pisaDictionary<-read.csv("data/pisaDictionary.csv", header = TRUE, sep=",")
  
  oecdCountries<-read.csv("data/oecdCountries.csv", header = TRUE, sep=",")
  oecdList<-oecdCountries$CNT
  names(oecdList)<-oecdCountries$Hebrew
  israelCountries<-read.csv("data/israelCountries.csv", header = TRUE, sep=",")
  israelList<-israelCountries$CNT
  names(israelList)<-israelCountries$Hebrew
  Countries<-read.csv("data/countries.csv", header = TRUE, sep=",")
  countriesList<-Countries$CNT
  names(countriesList)<-Countries$Hebrew
  ExpertiseLevels<-read.csv("data/ExpertiseLevels.csv", header = TRUE, sep=",")
  LevelExplenation<-read.csv("data/LevelExplenation.csv", header = TRUE, sep=",")
  
  source('pisa.scores.R', local=TRUE)
  source('pisa.expertise.R', local=TRUE)
  source('pisa.survey.R', local=TRUE)
  #source('pisa.analyze.R', local=TRUE)

  
  #load("/srv/shiny-server/tikhinuch5/data/student2012.rda")
  
})



