# bddtestcoverage

A small package for testing [`testthat``s BDD functions](https://testthat.r-lib.org/reference/describe.html). 

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
  As a human
  I want a function that restructures the columns in the ggplot2movies::movies data
  In order to `tidy` the movie data
```

## Background

The `Background` keyword can be used to specify steps or conditions that exist before the `Scenario` in a `Feature`.

```gherkin
  Background:
    Given a `movies_data` dataframe with columns:
    `title`, `year`, `length`, `budget`, `rating`, 
    `votes`, `mpaa`, `Action`, `Animation`, `Comedy`, 
    `Drama`, `Documentary`, `Romance` and `Short`
```

## Scenarios

`Scenarios` are concrete examples illustrating a `Feature`. They include a title, `Given` (the preconditions or initial context for the test), `When` (an action or event), and `Then` (the expected outcome)

```gherkin
  Scenario: Create `genre_count` categorical column 
    When the function tidy_ggp2movies is applied to the movies_data
    Then the `genre_count` column should be of type integer
    And the new `genre_count` column should represent the sum of genres per movie
    
  Scenario: Create `genre` categorical column 
    When the function tidy_ggp2movies is applied to the movies_data
    Then the new `genres` column should list the genres per movie separated by commas
    And `genre` should be of type factor
    And `genre` should categorize movies with multiple genres as `Multiple genres`
    
  Scenario: Convert `mpaa` to factor with specified levels
    When the function tidy_ggp2movies is applied to the movies_data
    Then the `mpaa` column should be of type factor
    And have levels `G`, `PG`, `PG-13`, `R`, `NC-17`

  Scenario: Correct columns in tidy ggplot2movies::movies data
    When the function tidy_ggp2movies is applied to the movies_data
    Then the output dataframe should have columns:
    `title`,  `year`,  `length`,  `budget`,  `rating`,
    `votes`,  `mpaa`,  `genre_count`,  `genres` and `genre` 
```

The `Background` keyword can be used to reduce duplication: 

```gherkin
  Background:
    Given a `movies_data` dataframe with columns:
    `title`, `year`, `length`, `budget`, `rating`, 
    `votes`, `mpaa`, `Action`, `Animation`, `Comedy`, 
    `Drama`, `Documentary`, `Romance` and `Short`
   
```
