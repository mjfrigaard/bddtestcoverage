
# FIXTURE DATA TESTS: ----
# Thet tests below use the data from tests/testthat/fixtures/test_data.rds
# helper called nside it() (in two nested describe() calls)  ==================
describe("Feature: (As a ..., In order to ..., I want to ...)", {
  describe("Background (Given ...)", {
      it("Scenario: (Given ... , When ..., Then ...)", {
          ## call helper ----
          test_logger(start = "mpaa", msg = "is.factor()/levels()")
          # load fixture
          test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
          tidy_ggp2 <- tidy_ggp2movies(test_data)
          expect_true(is.factor(tidy_ggp2$mpaa))
          expect_equal(
            object = levels(tidy_ggp2$mpaa),
            expected = c("G", "PG", "PG-13", "R", "NC-17")
          )
          test_logger(end = "mpaa", msg = "is.factor()/levels()")
        })
    })
})

# helper called inside test_that() (in two nested describe() calls) ============
describe("Feature: (As a ..., In order to ..., I want to ...)", {
    describe("Background (Given ...)", {
        test_that("Scenario: (Given ... , When ..., Then ...)", {
            ## call helper ----
            test_logger(start = "mpaa", msg = "is.factor()/levels()")
            # load fixture
            test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
            tidy_ggp2 <- tidy_ggp2movies(test_data)
            expect_true(is.factor(tidy_ggp2$mpaa))
            expect_equal(
              object = levels(tidy_ggp2$mpaa),
              expected = c("G", "PG", "PG-13", "R", "NC-17")
            )
            test_logger(end = "mpaa", msg = "is.factor()/levels()")
          })
      })
  })

# helper called inside it() with single describe() ============================
describe("Feature: (As a ..., In order to ..., I want to ...)", {
    it("Scenario: (Given ... , When ..., Then ...)", {
        ## call helper ----
        test_logger(start = "mpaa", msg = "is.factor()/levels()")
        # load fixture
        test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
        tidy_ggp2 <- tidy_ggp2movies(test_data)
        expect_true(is.factor(tidy_ggp2$mpaa))
        expect_equal(
          object = levels(tidy_ggp2$mpaa),
          expected = c("G", "PG", "PG-13", "R", "NC-17")
        )
        test_logger(end = "mpaa", msg = "is.factor()/levels()")
      })
  })

# nested describe()s, helper called inside test_that()  =================
describe("Feature: (As a ..., In order to ..., I want to ...)", {
    describe("Background: (Given ...)", {
        test_that("Scenario: (Given ... , When ..., Then ...)", {
            ## call helper ----
            test_logger(start = "mpaa", msg = "is.factor()/levels()")
            ## load fixture ----
            test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))

            tidy_ggp2 <- tidy_ggp2movies(test_data)
            expect_true(is.factor(tidy_ggp2$mpaa))
            expect_equal(
              object = levels(tidy_ggp2$mpaa),
              expected = c("G", "PG", "PG-13", "R", "NC-17")
            )
            test_logger(end = "mpaa", msg = "is.factor()/levels()")
          })
      })
  })

# helper used outside it(), but inside nested describe() =====================
describe("Feature: (As a ..., In order to ..., I want to ...)", {
    describe("Background: (Given ...)", {
        ## call helper ----
        test_logger(start = "mpaa", msg = "is.factor()/levels()")
        it("Scenario: (Given ... , When ..., Then ...)", {
            # load fixture
            test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
            tidy_ggp2 <- tidy_ggp2movies(test_data)
            expect_true(is.factor(tidy_ggp2$mpaa))
            expect_equal(
              object = levels(tidy_ggp2$mpaa),
              expected = c("G", "PG", "PG-13", "R", "NC-17")
            )
          })
        test_logger(end = "mpaa", msg = "is.factor()/levels()")
      })
  })
