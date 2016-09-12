install.packages('https://cran.r-project.org/src/contrib/Archive/httr/httr_1.0.0.tar.gz', repos = NULL, type = 'source')
library(bigrquery)
library(httr)

endpoint_gce <- oauth_endpoints("google")
secrets_gce <- jsonlite::fromJSON("ShinyServer-41d749479100.json")
scope_gce_bigqr <- c("https://www.googleapis.com/auth/bigquery")
token <- oauth_service_token(endpoint = endpoint_gce,secrets = secrets_gce,scope = scope_gce_bigqr)
set_access_cred(token)

library(dplyr)
pisadb<-src_bigquery("r-shiny-1141", "pisa")
Student2012<- tbl(pisadb, "student2012")
General<-Student2012%>%filter(CNT=="ISR")%>%count_("IC01Q05")
General<-collect(General)
General<-General%>%mutate(freq = round(100 * n/sum(n), 1), group="General")%>%rename_(answer="IC01Q05")
General

#Debugging
#avnerkantor@opisa2:/var/log/shiny-server$ sudo cat tikhinuch5-shiny-20160828-061212-46633.log

