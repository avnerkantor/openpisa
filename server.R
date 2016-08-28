shinyServer(function(input, output, session) {
  PisaSelectIndex<-read.csv("data/PisaSelectIndex.csv", header = TRUE, sep=",")
  source('pisa.dashboard.R', local=TRUE)
  source('pisa.scores.R', local=TRUE)
  source('pisa.expertise.R', local=TRUE)
  source('pisa.survey.R', local=TRUE)
  #source('pisa.analyze.R', local=TRUE)
})



