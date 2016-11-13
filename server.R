(shiny.sanitize.errors = FALSE)
load("data/pisaData2.rda")
load("data/pisaDictionary.rda")
load("../pisa2012.rda")
# pisadb<-src_bigquery("r-shiny-1141", "pisa")
# pisa2012<- tbl(pisadb, "pisa2012")
#pisa2009<- tbl(pisadb, "pisa2009")
#pisa2006<- tbl(pisadb, "pisa2006")

oecdCountries<-read.csv("data/oecdCountries.csv", header = TRUE, sep=",")
oecdList<-oecdCountries$CNT
names(oecdList)<-oecdCountries$Country
Countries<-read.csv("data/countries.csv", header = TRUE, sep=",")
countriesList<-Countries$CNT
names(countriesList)<-Countries$Country
ExpertiseLevels<-read.csv("data/ExpertiseLevels.csv", header = TRUE, sep=",")
LevelExplenation<-read.csv("data/LevelExplenation.csv", header = TRUE, sep=",")
LevelExplenation<-read.csv("data/LevelExplenation.csv", header = TRUE, sep=",")
ExpertiseLevelsLimits<-read.csv("data/expertiseLevelsLimits.csv", header = TRUE, sep=",")

groupColours<- c(
  General="#b276b2", 
  Male="#5da5da", 
  Female="#f17cb0", 
  GeneralLow="#bc99c7", 
  GeneralMedium="#b276b2", 
  GeneralHigh="#7b3a96", 
  MaleHigh="#265dab", 
  MaleLow="#88bde6", 
  MaleMedium="#5da5da", 
  FemaleHigh="#e5126f", 
  FemaleLow="#f6aac9", 
  FemaleMedium="#f17cb0"
) 
shinyServer(function(input, output, session) {

  #setwd("/srv/shiny-server/opisaEn") 
  
  source('pisa.scores.R', local=TRUE)
  source('pisa.expertise.R', local=TRUE)
  source('pisa.survey.R', local=TRUE)
  source('pisa.analyze.R', local=TRUE)
  source('urlSearch.R', local=TRUE)

})



