# STAT295 Lecture 2
## Timing and Exceptions
options(show.error.locations = TRUE)
vec1 <- c(1,2,3)
vec2 <- c(1,2)
vec1*vec2

warn_test <- function(x){
  if(x <= 0){
    warning("Watch out!! 'x' is less than or equal 0. Set it 1")
  }
  return(2/x)
}
warn_test(0)
warn_test(3)

err_test <- function(x){
  if(x <=0){
    stop("'x' is less than or equal to 0... TERMİNATE")
  }
  return(2/x)
}
err_test(0)


myfibrec <- function(n){
  if(n<0){
    warning("n can not be negative")
    n <- n*-1
  }else if(n==0){
    stop("'n' can not be 0")
  }
  if(n==1 | n==2){
    return(1)
  }else{
    return(myfibrec(n-1)+myfibrec(n-2))
  }
}

myfibrec(20)
try(myfibrec(0),silent = TRUE)

attemt1 <- try(myfibrec(0),silent = TRUE)
attemt1

attemt2 <- try(myfibrec(1),silent = TRUE)
attemt2


myfibrecvector <- function(nvec){
  nterms <- length(nvec)
  result <- rep(0, nterms)
  for(i in 1:nterms){
    result[i] <- myfibrec(nvec[i])
  }
  return(result)
  }

foo



myfibrecvectorTRY <- function(nvec){
  nterms <- length(nvec)
  result <- rep(0, nterms)
  for(i in 1:nterms){
    
    if(nvec[i]==0){
      result[i]<- NA
    }else{
      result[i] <- myfibrec(nvec[i])
    }
  }
  return(result)
}

myfibrecvectorTRY_hoca <- function(nvec){
  nterms <- length(nvec)
  result <- rep(0, nterms)
  for(i in 1:nterms){
    attempt <- try(myfibrec(nvec[i]),silent = TRUE)
    if(class(attempt) == "try-error"){
      result[i] <- NA
    }else{
      result[i] <- myfibrec(nvec[i])
    }
    

  }
  return(result)
}

bar <- c(1,2,3,0,7,0,5,4,10)
myfibrecvectorTRY(bar)
myfibrecvectorTRY_hoca(bar)

myfibrec(-3)

attemp3 <- suppressWarnings(myfibrec(-3))
attemp3
suppressWarnings(myfibrec(-3))

myfibrecvector(c(1,4,0))

##Progress and Timing
Sys.sleep(10)

sleep_tet <- function(n){
  result <- 0
  for(i in 1:n){
    result <- result + 1
    Sys.sleep(0.5)
  }
  return(result)
}
sleep_tet(5)

prog_test<- function(n){
  result <- 0
  progbar <- txtProgressBar(min=0, max=n,style = 3, char = "=")
  for(i in 1:n){
    result <- result + 1
    Sys.sleep(0.5)
    setTxtProgressBar(progbar, value=i)
  }
  return(result)
}
prog_test(10)

# Measuring Completiton Time
Sys.time()

t1 <- Sys.time()
Sys.sleep(3)
t2 <- Sys.time()
t2-t1

x <- 5+9
seq(1,10)

a <- 10
b <- 5
sig_sq <- 0.5

x <- runif(100)
y <- a + b*x+ rnorm(100, sd = sqrt(sig_sq))
y


plot(x,y)
abline(a,b,col="purple")

#Avoid for Loops

d <- as.data.frame(cbind(runif(10000),runif(10000)))
d
head(d)

system.time(for(loop in 1:dim(d)[1]){
  d$mean2[loop] <-mean(c(d[loop,1],d[loop,2]))
})

system.time(d$mean1 <- apply(d,1,mean))

timecal <- function(n){
  a <- numeric(n)
  for(i in 1:n){
    a[i] <- 2*pi*sin(i)
  }
}
system.time(timecal(10000000))

timecal2 <- function(n){
  a <- numeric(n)
  for(i in 1:n){
    a[i] <- sin(i)
  }
  2*pi*a
}

system.time(timecal2(10000000))

##Piping. in R |>
library(tidyverse)
data(tips, package = "reshape2")
tips %>% 
  subset(total_bill>19) %>%
  aggregate(. ~ sex, .,mean)

tips |>
  subset(total_bill > 19) |>
  {function(x) aggregate(. ~ sex, data=x,FUN = mean)}()

tips |>
  subset(total_bill > 19) |>
  {\(x) aggregate(. ~ sex, data=x,FUN = mean)}()


#x %>% f(1)
#f(x,1)
#f(1,x)
#x %>% f(1,.)

tips %>% 
  subset(total_bill >19) %>% 
  aggregate(. ~ day, ., max)

a <- rnorm(10)
a
a1 <- abs(a)
a1
a2 <- log(a1)
a2
a3<-round(a2,1)
a3

round(log(abs(a)),1)

a %>% abs() %>% 
  log() %>% round(1)

a %<>% abs() %>% 
  log() %>% round(1)

assign("a",pi)

"a" %>% assign(20)
a
env <- environment()
"a" %>% assign(20,envir = env)
a

rnorm(100) %>% 
  matrix(ncol=2) %T>% 
  plot() %>% 
  str()



