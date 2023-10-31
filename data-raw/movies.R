## code to prepare `movies` dataset goes here
download.file('https://raw.githubusercontent.com/hadley/ggplot2movies/master/data-raw/movies.csv', destfile = 'inst/extdata/movies.csv')
movies <- read.csv(file = system.file('extdata', 'movies.csv', package = 'bddtestcoverage'))
usethis::use_data(movies, overwrite = TRUE)
