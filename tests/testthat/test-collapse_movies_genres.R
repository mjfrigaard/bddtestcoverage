# HELPER TESTS: ----
## The tests below use the helper from tests/testthat/helper.R
# describe("Feature: (As a ..., In order to ..., I want to ...)", {
#     it("Scenario: (Given ... , When ..., Then ...)", {
#       test_logger(start = "helper", msg = "inside describe(it())")
#         movie_genres <- collapse_movies_genres(ggplot2movies::movies)
#         expect_true(is.factor(movie_genres$mpaa))
#         test_logger(end = "helper", msg = "inside describe(it())")
#       })
#   })
# describe("Feature: (As a ..., In order to ..., I want to ...)", {
#   test_logger(start = "helper", msg = "inside describe()")
#   describe("Background (Given ...)", {
#           it("Scenario: (Given ... , When ..., Then ...)", {
#           movie_genres <- collapse_movies_genres(ggplot2movies::movies)
#           expect_true(is.factor(movie_genres$mpaa))
#         })
#     })
#   test_logger(end = "helper", msg = "inside describe()")
# })
# describe("Feature: (As a ..., In order to ..., I want to ...)", {
#   describe("Background (Given ...)", {
#     test_logger(start = "helper", msg = "inside describe(describe())")
#           it("Scenario: (Given ... , When ..., Then ...)", {
#           movie_genres <- collapse_movies_genres(ggplot2movies::movies)
#           expect_true(is.factor(movie_genres$mpaa))
#         })
#     test_logger(end = "helper", msg = "inside describe(describe())")
#     })
# })
# describe("Feature: (As a ..., In order to ..., I want to ...)", {
#   describe("Background (Given ...)", {
#       it("Scenario: (Given ... , When ..., Then ...)", {
#           test_logger(start = "helper", msg = "inside describe(describe(it()))")
#           movie_genres <- collapse_movies_genres(ggplot2movies::movies)
#           expect_true(is.factor(movie_genres$mpaa))
#           test_logger(end = "helper", msg = "inside describe(describe(it()))")
#         })
#     })
# })


# FIXTURE TESTS: ----
# The tests below use the data from tests/testthat/fixtures/test_data.rds
# inside it() with single describe() ============================
# describe("Feature: (As a ..., In order to ..., I want to ...)", {
#     it("Scenario: (Given ... , When ..., Then ...)", {
#         # load fixture
#         test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
#         movie_genres <- collapse_movies_genres(test_data)
#         expect_true(is.factor(movie_genres$mpaa))
#       })
#   })
# # inside it() with nested describe() ============================
# describe("Feature: (As a ..., In order to ..., I want to ...)", {
#   describe("Background (Given ...)", {
#           it("Scenario: (Given ... , When ..., Then ...)", {
#           # load fixture
#           test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
#           movie_genres <- collapse_movies_genres(test_data)
#           expect_true(is.factor(movie_genres$mpaa))
#         })
#     })
# })


# FIXTURE DATA & HELPER TESTS: ----
describe("Feature: (As a ..., In order to ..., I want to ...)", {
  test_logger(start = "helper/fixture", msg = "inside describe()")
      it("Scenario: (Given ... , When ..., Then ...)", {
          # load fixture
          test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
          movie_genres <- collapse_movies_genres(test_data)
          expect_true(is.factor(movie_genres$mpaa))
        })
  test_logger(end = "helper/fixture", msg = "inside describe()")
})
# helper called inside it() (in single describe() call)  ==================
describe("Feature: (As a ..., In order to ..., I want to ...)", {
      it("Scenario: (Given ... , When ..., Then ...)", {
          ## call helper ----
          test_logger(start = "helper/fixture", msg = "inside describe(it())")
          # load fixture
          test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
          movie_genres <- collapse_movies_genres(test_data)
          expect_true(is.factor(movie_genres$mpaa))
          test_logger(end = "helper/fixture", msg = "inside describe(it())")
        })
})
# helper called inside test_that() (in two nested describe() calls) ============
describe("Feature: (As a ..., In order to ..., I want to ...)", {
    describe("Background (Given ...)", {
        test_that("Scenario: (Given ... , When ..., Then ...)", {
            ## call helper ----
            test_logger(start = "helper/fixture",
              msg = "inside describe(describe(test_that()))")
            # load fixture
            test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
            movie_genres <- collapse_movies_genres(test_data)
            expect_true(is.factor(movie_genres$mpaa))
            test_logger(end = "helper/fixture",
              msg = "inside describe(describe(test_that()))")
          })
      })
  })
# nested describe()s, helper called inside test_that()  =================
describe("Feature: (As a ..., In order to ..., I want to ...)", {
    describe("Background: (Given ...)", {
        it("Scenario: (Given ... , When ..., Then ...)", {
            ## call helper ----
            test_logger(start = "helper/fixture", msg = "inside describe(describe(it()))")
            ## load fixture ----
            test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
            movie_genres <- collapse_movies_genres(test_data)
            expect_true(is.factor(movie_genres$mpaa))
            test_logger(end = "helper/fixture", msg = "inside describe(describe(it()))")
          })
      })
  })


