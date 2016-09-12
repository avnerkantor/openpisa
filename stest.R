library(shiny)
library(ggplot2)
library(Cairo)
library(bigrquery)
library(dplyr)
library(scales)

pisadb<-src_bigquery("r-shiny-1141", "pisa")
Student2012<- tbl(pisadb, "student2012")

#General
General<-Student2012%>%filter(CNT=="ISR")%>%count_("IC01Q05")
General<-collect(General)
General<-General%>%mutate(freq = round(100 * n/sum(n), 1), group="General")%>%rename_(answer="IC01Q05")

#Gender
Male<-Student2012%>%filter(CNT=="ISR", ST04Q01=="Male")%>%count_("IC01Q05")
Male<-collect(Male)
Male<-Male%>%mutate(freq = round(100 * n/sum(n), 1), group="Male")%>%rename_(answer="IC01Q05")

Female<-Student2012%>%filter(CNT=="ISR", ST04Q01=="Female")%>%count_("IC01Q05")
Female<-collect(Female)
Female<-Female%>%mutate(freq = round(100 * n/sum(n), 1), group="Female")%>%rename_(answer="IC01Q05")

#ESCS
High<-student2012%>%filter(CNT=="ISR", ESCS=="High")%>%count_("IC01Q05")
High<-collect(High)
High<-High%>%mutate(freq = round(100 * n/sum(n), 1), group="High")%>%rename_(answer="IC01Q05")

Medium<-Student2012%>%filter(CNT=="ISR",  ESCS<="0.7", ESCS>="0.2")%>%count_("IC01Q05")
Medium<-collect(Medium)
Medium<-Medium%>%mutate(freq = round(100 * n/sum(n), 1), group="Medium")%>%rename_(answer="IC01Q05")

Low<-Student2012%>%filter(CNT=="ISR",  ESCS<"0.2")%>%count_("IC01Q05")
Low<-collect(Low)
Low<-Low%>%mutate(freq = round(100 * n/sum(n), 1), group="Low")%>%rename_(answer="IC01Q05")

surveyTable<-bind_rows(General, Male, Female, High, Medium, Low)

if (!is.null(input$Gender) & is.null(input$Escs)){
  surveyData1<- surveyTable %>%
    filter(group %in% c("Male", "Female"))
} else {
  surveyData2<- surveyTable %>% filter(group=="General")
}
if (!is.null(input$Escs) & is.null(input$Gender)){
  surveyData3<- surveyTable %>%
    filter(group %in% c("High", "Medium", "Low"))
} else {
  surveyData2<- surveyTable %>% filter(group=="General")
}

surveyData3<-General
ggplot(data=surveyData3, aes(x=answer, y=freq, fill=group)) +
  geom_bar(position="dodge",stat="identity") + 
  coord_flip() +
  labs(title="", y="" ,x= "") +
  #scale_y_discrete(breaks=c(0, 100))
  theme_bw() +
  facet_grid(. ~group) +
  theme(
    panel.border = element_blank(),
    panel.grid.major=element_blank(),
    axis.ticks = element_blank(),
    legend.position="none",
    strip.text.x = element_blank(),
    panel.grid.minor = element_blank() )

#   ggplot(data=surveyData, aes(x=answer, y=freq)) +
#     geom_bar(position="dodge",stat="identity", fill="#b276b2") + 
#     coord_flip() +
#     labs(title="", y="" ,x= "") +
#     #scale_y_discrete(breaks=c(0, 100))
#     theme_bw() +

