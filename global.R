library(shiny)
library(ggplot2)
#library(Cairo)
library(bigrquery)
library(dplyr)
#library(scales)
library(validate)

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


