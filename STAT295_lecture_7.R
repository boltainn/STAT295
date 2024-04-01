##STAT295 Lecture 7
# install.packages("sqldf")
# install.packages("plotly")
# install.packages("gapminder")
# install.packages("modelr")
# install.packages("bindrcpp")
# install.packages("tidyverse")

library("sqldf")
library("plotly")
library("gapminder")
library("modelr")
library("bindrcpp")
library("tidyverse")

##SQLDF

data(tips, package = "reshape2")
head(tips)

head(sqldf("SELECT total_bill FROM tips"),1)
head(sqldf("select total_bill from tips"),1)

sqldf("SELECT * FROM tips")
##SQL is not case sensitive but r environment is case sensitive

sqldf("SELECT total_bill, sex FROM tips")

sqldf("SELECT * FROM tips LIMIT 10")
sqldf("SELECT DISTINCT day FROM tips")

sqldf("SELECT * FROM tips ORDER BY total_bill LIMIT 5")

sqldf("SELECT * FROM tips ORDER BY day ASC, total_bill DESC")

myfilter <- sqldf("SELECT  total_bill FROM tips WHERE tip > 6")
myfilter
class(myfilter)

sqldf("SELECT * FROM tips WHERE day == 'Sat' OR day == 'Sun'")

sqldf("SELECT * FROM tips WHERE day IN ('Sat', 'Sun') LIMIT 5")

sqldf("SELECT * FROM tips WHERE day NOT IN ('Sat','Sun') LIMIT 5")

sqldf("SELECT * FROM tips WHERE size>5 AND tip >5")

sqldf("SELECT * FROM tips WHERE NOT size>1")

sqldf("SELECT * FROM tips WHERE (size >10 AND tip > 0.01) OR total_bill >45")

sqldf("SELECT AVG(total_bill) FROM tips")

sqldf("SELECT sex, AVG(tip) AS mean_tip FROM tips GROUP BY sex")

sqldf("SELECT COUNT() AS number_rows FROM tips")
