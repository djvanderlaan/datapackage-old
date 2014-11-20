
cast_column_integer <- function(x, format) {
  y <- as.integer(x)
  if (!isTRUE(all.equal(y, round(as.numeric(x)))))
    warning("Some non integer values are truncated.")
  y
}

format_column_integer <- function(x, meta) {
  res <- format.default(as.integer(x), trim=TRUE)
  res[is.na(x)] <- ""
  res
}

ft_is_integer <- function(field, name) {
  if (!is.numeric(field)) return(NULL)
  if (!isTRUE(all.equal(round(field), field))) return(NULL)
  list(type = "integer")
}

