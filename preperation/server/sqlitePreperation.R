#First try
#Terminal
sqlite3 pisadb
.mode csv
.import studTOT2012.csv studTOT2012
.import studTOT2009.csv studTOT2009
.import studTOT2006.csv studTOT2006

#Second Try
library(RSQLite)
# create new database
con <- dbConnect(SQLite(), dbname = "pisa.sqlite")
# load the driver to SQLite database
drv <- dbDriver("SQLite")
# read CSV file to R
studTOT2012<-read.csv("studTOT2012.csv")
# Import data frames into database
dbWriteTable(conn = con, name = "studTOT2012", value = studTOT2012, row.names = FALSE)
[1] TRUE
# list tables in the database (to see recently added HUC)
dbListTables(con)
[1] "studTOT2012"

# read table that was just imported into Database
dbReadTable(con, "studTOT2012")

http://scicomp2014.edc.uri.edu/posts/2014-04-21-Yanchuk.html
http://stackoverflow.com/questions/1727772/quickly-reading-very-large-tables-as-dataframes-in-r/1820610#1820610
https://cran.r-project.org/web/packages/dplyr/vignettes/databases.html

pisa_db<-src_sqlite("pisa.sqlite", create=T)
studTOT2012<-tbl(pisa_db, "studTOT2012")
