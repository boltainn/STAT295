#STAT295 LECTURE 5
# ggplot

library(ggplot2)

x <- seq(-3, 3,0.3)
y <- x^3

qplot(x,y)

roll_dice <- function(){
  mydice <- 1:6
  mydices <- sample(mydice, size=2, replace=TRUE)
  sum(mydices)
}
roll_dice()
more_dice <- replicate(10000, roll_dice())
more_dice
qplot(more_dice, binwidth=1)

roll_dice2 <- function(){
  mydice <- 1:6
  mydices2 <- sample(mydice, size=2, replace=TRUE, prob = c(1/8,1/8, 1/8, 1/8, 1/8, 3/8))
  sum(mydices2)
}

more_dice2 <- replicate(10000, roll_dice2())
qplot(more_dice2, binwidth=1)

library(MASS)
library(tidyverse)

head(mammals)
str(mammals)


mammals %>%
  ggplot(aes(x=body, y=brain))+
  geom_point() +
  stat_smooth(method = "lm", col="purple")

mammals %>%
  ggplot(aes(body, brain))+
  geom_point()+
  coord_fixed()+
  scale_x_log10()+
  scale_y_log10()+
  stat_smooth(method = "lm")

library(reshape2)
library(gpairs)
library(GGally)
library(gridExtra)
library(tseries)
library(fpp2)
install.packages("plotly")
library(plotly)
data(tips, package = "reshape2")
head(tips)
class(tips)
str(tips)

l <- lattice::xyplot(tip ~ total_bill, data = tips)

minimal_plot <- ggplot(tips, aes(total_bill, tip))
minimal_plot

minimal_points <- minimal_plot + geom_point()
minimal_points

tips %>%
  ggplot(aes(total_bill,tip))+
  geom_point()+
  scale_x_continuous(name="Amount of Total Bill")+
  scale_y_continuous(name = "Amotunt of Total Tip")+
  labs(title = "Relationship of Total Bill and Total Bill")+
  theme_bw()

a <- tips %>%
  ggplot(aes(total_bill,tip, colour=sex))+
  geom_point()+
  scale_y_continuous(name = "Amotunt of Total Tip")+
  labs(title = "Relationship of Total Bill and Total Bill",x="Amount of Total Bill")+
  scale_color_manual(values = c("Female"="pink3", "Male"="blue"))+
  theme_bw()
b <- ggplotly(a)
b

p <- tips %>%
  ggplot(aes(total_bill,tip))+
  geom_point()

p+facet_wrap(~day, labeller = "label_both")+
  labs(title = "Facet Wrap for Days")

p + facet_wrap(~day + time, labeller="label_both")

p + facet_grid(day ~ time, labeller="label_both")

p + geom_smooth(method="lm", se=FALSE)+
  facet_grid(sex+smoker ~ time+day,
             labeller = "label_both")

gpairs::gpairs(tips)

pm <- ggpairs(tips, c("total_bill","tip", "smoker", "day"))
pm
pm[2,1]

replacement_plot <- ggally_text("Replacement\nPlot",
                                aes(color="red"),
                                size=3)
replacement_plot
pm[2,1] <- replacement_plot
pm

pm <- ggpairs(tips, c("total_bill","tip", "smoker", "day"),
              mapping=aes(color=smoker),
              legend=c(3,1))
pm

pm+ggplot2::theme(legend.position = "bottom")

ggpairs(tips, c("total_bill","smoker", "day", "tip"),
        upper= list(combo="denstrip"),lower = list(combo = "facetdensity"))

head(australia_PISA2012)

ggduo(australia_PISA2012,
      c("gender", "homework"),
      c("PV5MATH","PV5MATH","PV5SCIE"))

ggduo(tips,
      c("total_bill","smoker","day"),
      c("tip","time"))


