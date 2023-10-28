# # Inside it(), with nested describe() ==========================================
# testthat::describe(
#   description = "
#     Feature: tidy_ggp2movies Function
#       In order to tidy up the movie data
#       As a data scientist
#       I want to convert ggplot2moves::movies into a 'tidy' data.frame", code = {
#     testthat::describe(
#       description = "
#       Background:
#       Given a dataframe 'movies_data' with columns:
#         'title', 'year', 'length', 'budget', 'rating',
#         'votes', 'mpaa', 'Action', 'Animation', 'Comedy',
#         'Drama', 'Documentary', 'Romance', and 'Short'", code = {
#         testthat::it(
#           description = "
#       Scenario: Correct formatting of mpaa as factor with specified levels and labels
#           When the function tidy_ggp2movies is applied to the movies_data
#           Then the 'mpaa' column should be of type factor
#           And have levels 'G', 'PG', 'PG-13', 'R', 'NC-17'",
#           code = {
#             test_logger(start = "fixture", msg = "test_data.rds")
#             # load fixture
#             test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
#             tidy_ggp2 <- tidy_ggp2movies(test_data)
#             testthat::expect_true(is.factor(tidy_ggp2$mpaa))
#             testthat::expect_equal(
#               object = levels(tidy_ggp2$mpaa),
#               expected = c("G", "PG", "PG-13", "R", "NC-17")
#             )
#             test_logger(end = "fixture", msg = "test_data.rds")
#           })
#       })
#   })

# Inside it(), with single describe() ==========================================
testthat::describe(
  description = "
    Feature: tidy_ggp2movies Function
      In order to tidy up the movie data
      As a data scientist
      I want to convert ggplot2moves::movies into a 'tidy' data.frame", code = {
    testthat::it(
      description = "
      Scenario: Correct formatting of mpaa as factor with specified levels and labels
        Given a dataframe 'movies_data' with columns:
          'title', 'year', 'length', 'budget', 'rating',
          'votes', 'mpaa', 'Action', 'Animation', 'Comedy',
          'Drama', 'Documentary', 'Romance', and 'Short'
        When the function tidy_ggp2movies is applied to the movies_data
        Then the 'mpaa' column should be of type factor
        And have levels 'G', 'PG', 'PG-13', 'R', 'NC-17'",
      code = {
        test_logger(start = "fixture", msg = "test_data.rds")
        # load fixture
        test_data <-
          readRDS(file = test_path("fixtures", "test_data.rds"))
        tidy_ggp2 <- tidy_ggp2movies(test_data)
        testthat::expect_true(is.factor(tidy_ggp2$mpaa))
        testthat::expect_equal(
          object = levels(tidy_ggp2$mpaa),
          expected = c("G", "PG", "PG-13", "R", "NC-17")
        )
        test_logger(end = "fixture", msg = "test_data.rds")
      })
  })

# Inside test_that(), with nested describe() ==========================================
# testthat::describe(
#   description = "
#     Feature: tidy_ggp2movies Function
#       In order to tidy up the movie data
#       As a data scientist
#       I want to convert ggplot2moves::movies into a 'tidy' data.frame", code = {
#     testthat::describe(
#       description = "
#       Background:
#       Given a dataframe 'movies_data' with columns:
#         'title', 'year', 'length', 'budget', 'rating',
#         'votes', 'mpaa', 'Action', 'Animation', 'Comedy',
#         'Drama', 'Documentary', 'Romance', and 'Short'", code = {
#         testthat::test_that("
#       Scenario: Correct formatting of mpaa as factor with specified levels and labels
#           When the function tidy_ggp2movies is applied to the movies_data
#           Then the 'mpaa' column should be of type factor
#           And have levels 'G', 'PG', 'PG-13', 'R', 'NC-17'",
#           code = {
#             test_logger(start = "fixture", msg = "test_data.rds")
#             # load fixture
#             test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
#             tidy_ggp2 <- tidy_ggp2movies(test_data)
#             testthat::expect_true(is.factor(tidy_ggp2$mpaa))
#             testthat::expect_equal(
#               object = levels(tidy_ggp2$mpaa),
#               expected = c("G", "PG", "PG-13", "R", "NC-17")
#             )
#             test_logger(end = "fixture", msg = "test_data.rds")
#           })
#       })
#   })

# Inside nested describe(), outside it() ==========================================
# testthat::describe(
#   description = "
#     Feature: tidy_ggp2movies Function
#       In order to tidy up the movie data
#       As a data scientist
#       I want to convert ggplot2moves::movies into a 'tidy' data.frame", code = {
#     testthat::describe(
#       description = "
#       Background:
#       Given a dataframe 'movies_data' with columns:
#         'title', 'year', 'length', 'budget', 'rating',
#         'votes', 'mpaa', 'Action', 'Animation', 'Comedy',
#         'Drama', 'Documentary', 'Romance', and 'Short'", code = {
#         test_logger(start = "fixture", msg = "test_data.rds")
#         testthat::it("
#       Scenario: Correct formatting of mpaa as factor with specified levels and labels
#           When the function tidy_ggp2movies is applied to the movies_data
#           Then the 'mpaa' column should be of type factor
#           And have levels 'G', 'PG', 'PG-13', 'R', 'NC-17'",
#           code = {
#             # load fixture
#             test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
#             tidy_ggp2 <- tidy_ggp2movies(test_data)
#             testthat::expect_true(is.factor(tidy_ggp2$mpaa))
#             testthat::expect_equal(
#               object = levels(tidy_ggp2$mpaa),
#               expected = c("G", "PG", "PG-13", "R", "NC-17")
#             )
#           })
#         test_logger(end = "fixture", msg = "test_data.rds")
#       })
#   })
