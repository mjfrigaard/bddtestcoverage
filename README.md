bddtestcoverage
================

A small package for testing [`testthat`’s BDD
functions](https://testthat.r-lib.org/reference/describe.html).

## Example

``` r
install.packages('pak')
library(pak)
# install devtools/usethis and ggplot2movies
pak::pak('devtools')
```

## Package structure

``` default
├── DESCRIPTION
├── LICENSE
├── LICENSE.md
├── NAMESPACE
├── NEWS.md
├── R
│   ├── bddtestcoverage-package.R <- imports ggplot2movies::movies 
│   ├── collapse_movies_genres.R
│   └── data.R
├── README.Rmd
├── README.md
├── bddtestcoverage.Rproj
├── data
│   └── movies.rda     <- local version of ggplot2movies::movies
├── data-raw
│   └── movies.R       <- downloads/stores .csv version of ggplot2movies::movies 
├── inst
│   └── extdata
│       └── movies.csv <- .csv version of ggplot2movies::movies 
├── man
│   ├── bddtestcoverage-package.Rd
│   └── collapse_movies_genres.Rd
└── tests
    ├── testthat
    │   ├── fixtures
    │   │   ├── make_test_data.R <- takes sample from ggplot2movies::movies 
    │   │   └── test_data.rds    <- sample from ggplot2movies::movies 
    │   ├── helper.R             <- contains test_logger() helper function 
    │   └── test-collapse_movies_genres.R
    └── testthat.R

10 directories, 21 files
```

## Using `collapse_movies_genres()`

`collapse_movies_genres()` collapses the genre columns in the
`ggplot2movies::movies` data into a `genre_count` column, a single
`genres` column (with all genres separated by commas), a `genre` factor
column with either the single genre or `Multiple genres`.

``` r
library(bddtestcoverage)
movie_genres <- collapse_movies_genres(ggplot2movies::movies)
str(movie_genres)
#> Classes 'tbl_df', 'tbl' and 'data.frame':    58788 obs. of  10 variables:
#>  $ title      : chr  "$" "$1000 a Touchdown" "$21 a Day Once a Month" "$40,000" ...
#>  $ year       : int  1971 1939 1941 1996 1975 2000 2002 2002 1987 1917 ...
#>  $ length     : int  121 71 7 70 71 91 93 25 97 61 ...
#>  $ budget     : int  NA NA NA NA NA NA NA NA NA NA ...
#>  $ rating     : num  6.4 6 8.2 8.2 3.4 4.3 5.3 6.7 6.6 6 ...
#>  $ votes      : int  348 20 5 6 17 45 200 24 18 51 ...
#>  $ mpaa       : Factor w/ 5 levels "G","PG","PG-13",..: NA NA NA NA NA NA 4 NA NA NA ...
#>  $ genre_count: int  2 1 2 1 0 1 2 2 1 0 ...
#>  $ genres     : chr  "Comedy, Drama" "Comedy" "Animation, Short" "Comedy" ...
#>  $ genre      : Factor w/ 8 levels "Action","Animation",..: 6 3 6 3 NA 5 6 6 5 NA ...
```

``` r
head(movie_genres[c('genre_count', 'genres', 'genre')])
#>   genre_count           genres           genre
#> 1           2    Comedy, Drama Multiple genres
#> 2           1           Comedy          Comedy
#> 3           2 Animation, Short Multiple genres
#> 4           1           Comedy          Comedy
#> 5           0             <NA>            <NA>
#> 6           1            Drama           Drama
```

# Tests

``` default
tests
 └── tests
      ├── testthat
      │   ├── fixtures
      │   │   ├── make_test_data.R <- takes sample from ggplot2movies::movies 
      │   │   └── test_data.rds    <- sample from ggplot2movies::movies 
      │   ├── helper.R             <- contains test_logger() helper function 
      │   └── test-collapse_movies_genres.R
      └── testthat.R
```

The test file (`test-collapse_movies_genres.R`) contains the following
tests:

## Tests using helpers

``` r
# The tests below use the helper from tests/testthat/helper.R
describe("Feature: (As a ..., In order to ..., I want to ...)", {
    it("Scenario: (Given ... , When ..., Then ...)", {
      test_logger(start = "helper", msg = "inside describe(it())")
        movie_genres <- collapse_movies_genres(ggplot2movies::movies)
        expect_true(is.factor(movie_genres$mpaa))
        test_logger(end = "helper", msg = "inside describe(it())")
      })
  })

describe("Feature: (As a ..., In order to ..., I want to ...)", {
  test_logger(start = "helper", msg = "inside describe()")
  describe("Background (Given ...)", {
          it("Scenario: (Given ... , When ..., Then ...)", {
          movie_genres <- collapse_movies_genres(ggplot2movies::movies)
          expect_true(is.factor(movie_genres$mpaa))
        })
    })
  test_logger(end = "helper", msg = "inside describe()")
})

describe("Feature: (As a ..., In order to ..., I want to ...)", {
  describe("Background (Given ...)", {
    test_logger(start = "helper", msg = "inside describe(describe())")
          it("Scenario: (Given ... , When ..., Then ...)", {
          movie_genres <- collapse_movies_genres(ggplot2movies::movies)
          expect_true(is.factor(movie_genres$mpaa))
        })
    test_logger(end = "helper", msg = "inside describe(describe())")
    })
})

describe("Feature: (As a ..., In order to ..., I want to ...)", {
  describe("Background (Given ...)", {
      it("Scenario: (Given ... , When ..., Then ...)", {
          test_logger(start = "helper", msg = "inside describe(describe(it()))")
          movie_genres <- collapse_movies_genres(ggplot2movies::movies)
          expect_true(is.factor(movie_genres$mpaa))
          test_logger(end = "helper", msg = "inside describe(describe(it()))")
        })
    })
})
```

These tests all pass (and the helper is loaded with
`devtools:::test_active_file()`).

    devtools:::test_active_file()
    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 0 ]
    INFO [2023-10-31 06:42:20] [ START helper = inside describe(it())]
    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]
    INFO [2023-10-31 06:42:20] [ END helper = inside describe(it())]

    INFO [2023-10-31 06:42:20] [ START helper = inside describe()]
    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
    INFO [2023-10-31 06:42:21] [ END helper = inside describe()]

    INFO [2023-10-31 06:42:21] [ START helper = inside describe(describe())]
    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 3 ]
    INFO [2023-10-31 06:42:21] [ END helper = inside describe(describe())]

    INFO [2023-10-31 06:42:21] [ START helper = inside describe(describe(it()))]
    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
    INFO [2023-10-31 06:42:22] [ END helper = inside describe(describe(it()))]

### Coverage

<img src="man/figures/helper_coverage.png" width="90%" style="display: block; margin: auto;" />

## Tests using fixtures

The tests below use the data from
`tests/testthat/fixtures/test_data.rds`:

``` r
# inside it() with single describe() 
describe("Feature: (As a ..., In order to ..., I want to ...)", {
    it("Scenario: (Given ... , When ..., Then ...)", {
        # load fixture
        test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
        movie_genres <- collapse_movies_genres(test_data)
        expect_true(is.factor(movie_genres$mpaa))
      })
  })
# inside it() with nested describe() 
describe("Feature: (As a ..., In order to ..., I want to ...)", {
  describe("Background (Given ...)", {
          it("Scenario: (Given ... , When ..., Then ...)", {
          # load fixture
          test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
          movie_genres <- collapse_movies_genres(test_data)
          expect_true(is.factor(movie_genres$mpaa))
        })
    })
})
```

These tests pass:

    devtools:::test_active_file()
    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]

### Coverage

But the test coverage is 0.0%

<img src="man/figures/fixture_coverage.png" width="90%" style="display: block; margin: auto;" />

## Tests using helpers and fixtures

``` r
describe("Feature: (As a ..., In order to ..., I want to ...)", {
  ## call helper ----
  test_logger(start = "helper/fixture", msg = "inside describe()")
      it("Scenario: (Given ... , When ..., Then ...)", {
          # load fixture
          test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
          movie_genres <- collapse_movies_genres(test_data)
          expect_true(is.factor(movie_genres$mpaa))
        })
  ## call helper ----
  test_logger(end = "helper/fixture", msg = "inside describe()")
})
describe("Feature: (As a ..., In order to ..., I want to ...)", {
      it("Scenario: (Given ... , When ..., Then ...)", {
          ## call helper ----
          test_logger(start = "helper/fixture", msg = "inside describe(it())")
          # load fixture
          test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
          movie_genres <- collapse_movies_genres(test_data)
          expect_true(is.factor(movie_genres$mpaa))
          ## call helper ----
          test_logger(end = "helper/fixture", msg = "inside describe(it())")
        })
})
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
            ## call helper ----
            test_logger(end = "helper/fixture",
                        msg = "inside describe(describe(test_that()))")
          })
      })
  })
describe("Feature: (As a ..., In order to ..., I want to ...)", {
    describe("Background: (Given ...)", {
        it("Scenario: (Given ... , When ..., Then ...)", {
            ## call helper ----
            test_logger(start = "helper/fixture", 
                        msg = "inside describe(describe(it()))")
            ## load fixture ----
            test_data <- readRDS(file = test_path("fixtures", "test_data.rds"))
            movie_genres <- collapse_movies_genres(test_data)
            expect_true(is.factor(movie_genres$mpaa))
            ## call helper ----
            test_logger(end = "helper/fixture", 
                        msg = "inside describe(describe(it()))")
          })
      })
  })
```

These tests pass:

    devtools:::test_active_file()
    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 0 ]
    INFO [2023-10-31 07:03:53] [ START helper/fixture = inside describe()]
    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]
    INFO [2023-10-31 07:03:53] [ END helper/fixture = inside describe()]

    INFO [2023-10-31 07:03:53] [ START helper/fixture = inside describe(it())]
    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
    INFO [2023-10-31 07:03:53] [ END helper/fixture = inside describe(it())]

    INFO [2023-10-31 07:03:53] [ START helper/fixture = inside describe(describe(test_that()))]
    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 3 ]
    INFO [2023-10-31 07:03:53] [ END helper/fixture = inside describe(describe(test_that()))]

    INFO [2023-10-31 07:03:53] [ START helper/fixture = inside describe(describe(it()))]
    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
    INFO [2023-10-31 07:03:53] [ END helper/fixture = inside describe(describe(it()))]

### Coverage

But the test coverage is 0.0%

<img src="man/figures/fixture_helper_coverage.png" width="90%" style="display: block; margin: auto;" />
