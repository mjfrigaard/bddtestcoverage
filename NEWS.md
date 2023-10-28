

# ISSUES

## BDD `it()` function not loading test helpers

I noticed the new `it()` functions don't seem to load helper functions after `load_all()`. 

### `R/` folder:

```
R
├── bddtestcoverage-package.R
└── tidy_ggp2movies.R
```



### `tests/` folder:

```
tests
├── testthat
│   ├── fixtures
│   │   ├── make_test_data.R
│   │   └── test_data.rds
│   ├── helper.R
│   └── test-tidy_ggp2movies.R
└── testthat.R
```

### Helper function

In `tests/testthat/helper.R`, I have the following helper:

```r
test_logger <- function(msg, start = NULL, end = NULL) {
  if (is.null(start) & is.null(end)) {
    cat("\n")
    logger::log_info("{msg}")
  } else if (!is.null(start) & is.null(end)) {
    cat("\n")
    logger::log_info("\n[ START {start} = {msg}]")
  } else if (is.null(start) & !is.null(end)) {
    cat("\n")
    logger::log_info("\n[ END {end} = {msg}]")
  } else {
    cat("\n")
    logger::log_info("\n[ START {start} = {msg}]")
    cat("\n")
    logger::log_info("\n[ END {end} = {msg}]")
  }
}
```

In `test-tidy_ggp2movies.R`:

When the `test_logger()` helper is inside `it()` (with a nested `describe()`):

```r
testthat::describe(
  description = "
    Feature: tidy_ggp2movies Function
      In order to tidy up the movie data
      As a data scientist
      I want to convert ggplot2moves::movies into a 'tidy' data.frame", code = {
    testthat::describe(
      description = "
      Background:
      Given a dataframe 'movies_data' with columns:
        'title', 'year', 'length', 'budget', 'rating',
        'votes', 'mpaa', 'Action', 'Animation', 'Comedy',
        'Drama', 'Documentary', 'Romance', and 'Short'", code = {
        testthat::it(
          description = "
      Scenario: Correct formatting of mpaa as factor with specified levels and labels
          When the function tidy_ggp2movies is applied to the movies_data
          Then the 'mpaa' column should be of type factor
          And have levels 'G', 'PG', 'PG-13', 'R', 'NC-17'",
          code = {
            test_logger(start = "fixture", msg = "test_data.rds")
            # load fixture
            test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
            tidy_ggp2 <- tidy_ggp2movies(test_data)
            testthat::expect_true(is.factor(tidy_ggp2$mpaa))
            testthat::expect_equal(
              object = levels(tidy_ggp2$mpaa),
              expected = c("G", "PG", "PG-13", "R", "NC-17")
            )
            test_logger(end = "fixture", msg = "test_data.rds")
          })
      })
  })

```

```r
devtools::load_all(".")
ℹ Loading bddtestcoverage
```

The test fails (can't find the helper).

```r
devtools:::test_active_file()
[ FAIL 1 | WARN 0 | SKIP 0 | PASS 0 ]

── Error (test-tidy_ggp2movies.R:22:13): 
      Scenario: Correct formatting of mpaa as factor with specified levels and labels
          When the function tidy_ggp2movies is applied to the movies_data
          Then the 'mpaa' column should be of type factor
          And have levels 'G', 'PG', 'PG-13', 'R', 'NC-17' ──
Error in `test_logger(start = "fixture", msg = "test_data.rds")`: could not find function "test_logger"
[ FAIL 1 | WARN 0 | SKIP 0 | PASS 0 ]
```

And if I switch it to a single `describe()` function: 

```r
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
```

```r
devtools::load_all(".")
ℹ Loading bddtestcoverage
```

The test still fails:

```r
[ FAIL 1 | WARN 0 | SKIP 0 | PASS 0 ]

── Error (test-tidy_ggp2movies.R:54:9): 
      Scenario: Correct formatting of mpaa as factor with specified levels and labels
        Given a dataframe 'movies_data' with columns:
          'title', 'year', 'length', 'budget', 'rating',
          'votes', 'mpaa', 'Action', 'Animation', 'Comedy',
          'Drama', 'Documentary', 'Romance', and 'Short'
        When the function tidy_ggp2movies is applied to the movies_data
        Then the 'mpaa' column should be of type factor
        And have levels 'G', 'PG', 'PG-13', 'R', 'NC-17' ──
Error in `test_logger(start = "fixture", msg = "test_data.rds")`: could not find function "test_logger"
[ FAIL 1 | WARN 0 | SKIP 0 | PASS 0 ]
```

But if the helper is inside `test_that()` (with nested `describe()`):

```r
testthat::describe(
  description = "
    Feature: tidy_ggp2movies Function
      In order to tidy up the movie data
      As a data scientist
      I want to convert ggplot2moves::movies into a 'tidy' data.frame", code = {
    testthat::describe(
      description = "
      Background:
      Given a dataframe 'movies_data' with columns:
        'title', 'year', 'length', 'budget', 'rating',
        'votes', 'mpaa', 'Action', 'Animation', 'Comedy',
        'Drama', 'Documentary', 'Romance', and 'Short'", code = {
        testthat::test_that("
      Scenario: Correct formatting of mpaa as factor with specified levels and labels
          When the function tidy_ggp2movies is applied to the movies_data
          Then the 'mpaa' column should be of type factor
          And have levels 'G', 'PG', 'PG-13', 'R', 'NC-17'",
          code = {
            test_logger(start = "fixture", msg = "test_data.rds")
            # load fixture
            test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
            tidy_ggp2 <- tidy_ggp2movies(test_data)
            testthat::expect_true(is.factor(tidy_ggp2$mpaa))
            testthat::expect_equal(
              object = levels(tidy_ggp2$mpaa),
              expected = c("G", "PG", "PG-13", "R", "NC-17")
            )
            test_logger(end = "fixture", msg = "test_data.rds")
          })
      })
  })
```

```r
devtools::load_all(".")
ℹ Loading bddtestcoverage
```

The test passes. 

```r
devtools:::test_active_file()
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 0 ]
INFO [2023-10-28 12:11:58] [ START fixture = test_data.rds]
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
INFO [2023-10-28 12:11:59] [ END fixture = test_data.rds]
```


And if the helper is *inside* the nested `describe()`, but outside `it()`:

```r
testthat::describe(
  description = "
    Feature: tidy_ggp2movies Function
      In order to tidy up the movie data
      As a data scientist
      I want to convert ggplot2moves::movies into a 'tidy' data.frame", code = {
    testthat::describe(
      description = "
      Background:
      Given a dataframe 'movies_data' with columns:
        'title', 'year', 'length', 'budget', 'rating',
        'votes', 'mpaa', 'Action', 'Animation', 'Comedy',
        'Drama', 'Documentary', 'Romance', and 'Short'", code = {
        test_logger(start = "fixture", msg = "test_data.rds")
        testthat::it("
      Scenario: Correct formatting of mpaa as factor with specified levels and labels
          When the function tidy_ggp2movies is applied to the movies_data
          Then the 'mpaa' column should be of type factor
          And have levels 'G', 'PG', 'PG-13', 'R', 'NC-17'",
          code = {
            # load fixture
            test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
            tidy_ggp2 <- tidy_ggp2movies(test_data)
            testthat::expect_true(is.factor(tidy_ggp2$mpaa))
            testthat::expect_equal(
              object = levels(tidy_ggp2$mpaa),
              expected = c("G", "PG", "PG-13", "R", "NC-17")
            )
          })
        test_logger(end = "fixture", msg = "test_data.rds")
      })
  })
```


```r
devtools::load_all(".")
ℹ Loading bddtestcoverage
```

```r
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 0 ]
INFO [2023-10-28 12:13:37] [ START fixture = test_data.rds]
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
INFO [2023-10-28 12:13:37] [ END fixture = test_data.rds]
```

This also passes. 

I'm not sure if `test_that()` and `it()` are supposed to have different functionality (or if it changes with nested `describe()` calls)?

These `describe()` functions are great for Gherkin Features and Scenarios (and nesting is nice for combining Scenarios under Features.) :)

Thank you in advance for your time (and all your continued hard work on this package :)!)












