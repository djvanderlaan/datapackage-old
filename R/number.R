
cast_column_number <- function(x, format) {
  as.numeric(x)
}

format_column_number <- function(x, meta) {
  res <- formatC(x)
  res[is.na(x)] <- ""
  res
}

ft_is_number <- function(field, name) {
  if (!is.numeric(field)) return(NULL)
  list(type = "number")
}

