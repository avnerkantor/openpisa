#Local RDA
load("../pisa-data/cbaStudent2012.rda")
load("../pisa-data/newStudent2009.rda")
load("../pisa-data/finStudent2012.rda")

#sqlite3
library(dplyr)
studTOT2006<- tbl(pisadb, "stu2006")
studTOT2009<- tbl(pisadb, "stu2009")
studTOT2012<- tbl(pisadb, "stu2012")

#Google Storage
load(url("https://storage.googleapis.com/opisa/newStudent2009.rda"))
load(url("https://storage.googleapis.com/opisa/newStudent2006.rda"))
load(url("https://storage.googleapis.com/opisa/newStudent2012.rda"))

#BigQuery - missing
library(bigrquery)
pisadb<-src_bigquery("r-shiny-1141", "pisa")
student2012<- tbl(pisadb, "student2012")
sql <- "SELECT AVG(PV1MATH) FROM [r-shiny-1141:pisa.student2012]"
sql <- "
  SELECT IC01Q05, COUNT(IC01Q05) AS Frequency
  FROM [r-shiny-1141:pisa.student2012]  
  Group By IC01Q05
"

query_exec(sql, project = "r-shiny-1141")

#data.table - missing
library(data.table)
