# download and take a sample of the data to be used locally
all_movies <- read.csv(file = "https://raw.githubusercontent.com/hadley/ggplot2movies/master/data-raw/movies.csv")
test_data <- all_movies[sample(nrow(all_movies), 10000), ]
saveRDS(object = test_data, file = "tests/testthat/fixtures/test_data.rds")
