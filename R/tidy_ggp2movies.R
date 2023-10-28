#' Test function (tidy ggplot2movies::movies)
#'
#' @param movies_data `ggplot2movies::movies` data
#'
#' @return A tidy `movies` `data.frame`
#'
#' @export tidy_ggp2movies
#'
#'
#' @examples
#' require(ggplot2movies)
#' tidy_ggp2movies(ggplot2movies::movies)
tidy_ggp2movies <- function(movies_data) {
  # specify genre columns
  genre_cols <- c(
    "Action", "Animation",
    "Comedy", "Drama",
    "Documentary", "Romance",
    "Short"
  )
  # calculate row sum for genres
  movies_data$genre_count <- rowSums(movies_data[, genre_cols])
  # create aggregate 'genres' for multiple categories
  movies_data$genres <- apply(
    X = movies_data[, genre_cols],
    MARGIN = 1,
    FUN = function(row) {
      genres <- names(row[row == 1])
      if (length(genres) > 0) {
        return(paste(genres, collapse = ", "))
      } else {
        return(NA)
      }
    }
  )
  # format variables
  movies_data$genre_count <- as.integer(movies_data$genre_count)
  movies_data$genre <- ifelse(test = movies_data$genre_count > 1,
    yes = "Multiple genres",
    no = movies_data$genres
  )
  movies_data$genre <- as.factor(movies_data$genre)
  movies_data$mpaa <- factor(movies_data$mpaa,
    levels = c("G", "PG", "PG-13", "R", "NC-17"),
    labels = c("G", "PG", "PG-13", "R", "NC-17")
  )

  # reduce columns to only those in graph
  movies_data[, c(
    "title", "year", "length", "budget",
    "rating", "votes", "mpaa", "genre_count",
    "genres", "genre"
  )]
}
