# bddtestcoverage

A small package for testing [`testthat`'s BDD functions](https://testthat.r-lib.org/reference/describe.html). 

## Example

```r
install.packages('pak')
library(pak)
pak::pak('mjfrigaard/bddtestcoverage')
# install devtools/usethis
pak::pak('devtools')
devtools::test()
```

## Feature

`Feature`s are testable pieces of functionality.

```gherkin
Feature: tidy_ggp2movies Function
  In order to tidy up the movie data
  As a data scientist
  I want to calculate, format and reduce columns in the movies_data dataframe
```

## Background

The `Background` keyword can be used to specify steps or conditions that exist before the `Scenario` in a `Feature`.

```gherkin
  Background:
    Given a dataframe "movies_data" with columns:
      | title | year | length | budget | rating | votes | mpaa | Action | Animation | Comedy | Drama | Documentary | Romance | Short |
```

## Scenarios

`Scenarios` are concrete examples illustrating a `Feature`. They include a title, `Given` (the preconditions or initial context for the test), `When` (an action or event), and `Then` (the expected outcome)

```gherkin
  Scenario: Correct calculation of genre_count
    When the function tidy_ggp2movies is applied to the movies_data
    Then a new column "genre_count" should be created representing the sum of genres for each movie

  Scenario: Correct assignment of genres to movies
    When the function tidy_ggp2movies is applied to the movies_data
    Then a new column "genres" should be created listing the genres a movie belongs to, separated by commas

  Scenario: Correct handling of multiple genres
    When the function tidy_ggp2movies is applied to the movies_data
    Then a new column "genre" should be created where movies with multiple genres should be labeled as "Multiple genres"

  Scenario: Correct formatting of genre_count as integer
    When the function tidy_ggp2movies is applied to the movies_data
    Then the "genre_count" column should be of type integer

  Scenario: Correct formatting of genre as factor
    When the function tidy_ggp2movies is applied to the movies_data
    Then the "genre" column should be of type factor

  Scenario: Correct formatting of mpaa as factor with specified levels and labels
    When the function tidy_ggp2movies is applied to the movies_data
    Then the "mpaa" column should be of type factor
    And have levels "G", "PG", "PG-13", "R", "NC-17"
    And have labels "G", "PG", "PG-13", "R", "NC-17"

  Scenario: Correct reduction of dataframe columns
    When the function tidy_ggp2movies is applied to the movies_data
    Then the output dataframe should only have columns:
      | title | year | length | budget | rating | votes | mpaa | genre_count | genres | genre |
```

