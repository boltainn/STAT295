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
library(purrr)

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

### Modeling 
##Multiple Models

str(gapminder)
summary(gapminder)

gapminder %>% 
  ggplot(aes(year, lifeExp, group=country))+
  geom_line(alpha=1/3)

gapminder %>% 
  ggplot(aes(year, lifeExp, group=country))+
  geom_line(aes(color=continent),linetype=1)+
  theme(legend.position = "none")

turkey <- filter(gapminder, country=="Turkey")

turkey %>%
  ggplot(aes(year,lifeExp))+
  geom_line()+
  ggtitle("Türkiye")

turkey_model <- lm(lifeExp ~ year, data = turkey)
summary(turkey_model)

turkey %>% 
  add_predictions(turkey_model) %>%
  ggplot(aes(year, pred))+
  geom_line()+
  ggtitle("Lineer Trend")

nested_country <- gapminder %>%
  group_by(country, continent)%>%
  nest()


nested_country$data[[1]]

country_model <- function(df){
  lm(lifeExp ~ year, data = df)
}

models <- map(nested_country$data, country_model)

nested_country <- nested_country %>%
  mutate(model=map(data, country_model))
nested_country

nested_country %>%
  filter(continent == "Europe")

nested_country %>%
  arrange(continent, country)

nested_country <- nested_country %>%
  mutate(resids = map2(data,model, add_residuals))
nested_country

resids <- unnest(nested_country, resids)
resids

resids %>%
  ggplot(aes(year,resids))+
  geom_line(aes(group=country), alpha = 1/3)+
  geom_smooth(se=FALSE)

library(broom)
glance(turkey_model)
glance <- nested_country %>%
  mutate(glance=map(model, broom::glance))%>%
  unnest(glance, .drop = FALSE)
glance %>%
  arrange(r.squared)

smaller_fit <- filter(glance, r.squared < 0.25)

gapminder %>%
  semi_join(smaller_fit, by = "country")%>%
  ggplot(aes(year,lifeExp, color=country))+
  geom_line()
