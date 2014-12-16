
cast_column_string <- function(x, meta) {
  x
}

format_column_string <- function(x, meta) {
  res <- paste0('"', x, '"')
  res[is.na(x)] <- ""
  res
}

ft_is_string <- function(field, name) {
  list(type = "string")
}

