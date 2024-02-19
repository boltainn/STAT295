# STAT295
#Revision

a <- 1+1
a
1:100

now <- Sys.time()
now
mil <- 10000000
now-mil
class(now)

#install.packages(c("devtools", "roxygen2", "testthat", "pkgdown","purr"))
# usethis::use_git_config(
#   user.name='boltainn',
#   user.email='tureonder@gmail.com'
# )
# usethis::create_github_token()
# gitcreds::gitcreds_set()
# 
# getwd()

data(iris)
str(iris)
summary(iris)
table(iris$Species)

Stats <- aggregate(Sepal.Length ~Species, data=iris,mean)
Stats

#Visualization

plot(iris$Sepal.Length, col=as.numeric(iris$Species),ylab = "Sepal Length")
legend("topleft", legend = levels(iris$Species),pch=1:3)

boxplot(Sepal.Length ~ Species, data =iris)

