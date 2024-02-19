# STAT295
#Revision

a <- 1+1
a
1:100

now <- Sys.time()
now

#install.packages(c("devtools", "roxygen2", "testthat", "pkgdown","purr"))
usethis::use_git_config(
  user.name='boltainn',
  user.email='tureonder@gmail.com'
)
usethis::create_github_token()
gitcreds::gitcreds_set()

getwd()
