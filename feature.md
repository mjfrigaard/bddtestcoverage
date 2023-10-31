## Feature

Features are testable pieces of functionality. They have a first person statement (`As a`), an action or behavior (`I want`), and the desired outcome (`In order to`):

```gherkin
Feature: collapse_movies_genres() Function
  As a human
  I want a function that restructures the genre columns in ggplot2movies::movies
  In order to visualize the movie data
```

## Scenarios

A `Scenario` is a concrete examples illustrating a `Feature`. They include a title, `Given` (the preconditions or initial context for the test), `When` (an action or event), and `Then` (the expected outcome)

```gherkin
  Scenario: Create genre_count categorical column 
    Given a movies_data dataframe with columns:
    title, year, length, budget, rating, 
    votes, mpaa, Action, Animation, Comedy, 
    Drama, Documentary, Romance and Short
    When the collapse_movies_genres() function is applied to the movies_data
    Then the genre_count column should be of type integer
    And the new genre_count column should represent the sum of genres per movie
    
  Scenario: Create genre categorical column 
    Given a movies_data dataframe with columns:
    title, year, length, budget, rating, 
    votes, mpaa, Action, Animation, Comedy, 
    Drama, Documentary, Romance and Short
    When the collapse_movies_genres() function is applied to the movies_data
    Then the new genres column should list the genres per movie separated by commas
    And genre should be of type factor
    And genre should categorize movies with multiple genres as Multiple genres
    
  Scenario: Convert mpaa to factor with specified levels
    Given a movies_data dataframe with columns:
    title, year, length, budget, rating, 
    votes, mpaa, Action, Animation, Comedy, 
    Drama, Documentary, Romance and Short
    When the collapse_movies_genres() function is applied to the movies_data
    Then the mpaa column should be of type factor
    And have levels G, PG, PG-13, R, NC-17

  Scenario: Correct columns in tidy ggplot2movies::movies data
    Given a movies_data dataframe with columns:
    title, year, length, budget, rating, 
    votes, mpaa, Action, Animation, Comedy, 
    Drama, Documentary, Romance and Short
    When the collapse_movies_genres() function is applied to the movies_data
    Then the output dataframe should have columns:
    title,  year,  length,  budget,  rating,
    votes,  mpaa,  genre_count,  genres and genre 
```

## Background

The `Background` keyword can be used to reduce duplication: 

```gherkin
  Background:
    Given a movies_data dataframe with columns:
    title, year, length, budget, rating, 
    votes, mpaa, Action, Animation, Comedy, 
    Drama, Documentary, Romance and Short
    
  Scenario: Create genre_count categorical column 
    When the collapse_movies_genres() function is applied to the movies_data
    Then the genre_count column should be of type integer
    And the new genre_count column should represent the sum of genres per movie
  
  Scenario: Create genre categorical column 
    When the collapse_movies_genres() function is applied to the movies_data
    Then the new genres column should list the genres per movie separated by commas
    And genre should be of type factor
    And genre should categorize movies with multiple genres as Multiple genres
    
  Scenario: Convert mpaa to factor with specified levels
    When the collapse_movies_genres() function is applied to the movies_data
    Then the mpaa column should be of type factor
    And have levels G, PG, PG-13, R, NC-17
    
  Scenario: Correct columns in tidy ggplot2movies::movies data
    When the collapse_movies_genres() function is applied to the movies_data
    Then the output dataframe should have columns:
    title,  year,  length,  budget,  rating,
    votes,  mpaa,  genre_count,  genres and genre
```
