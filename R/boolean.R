
cast_column_boolean <- function(x, format) {
  na <- x == ""
  true <- grepl("^[[:space:]]*(T|TRUE|true|1)[[:space:]]*$", x)
  false <- grepl("^[[:space:]]*(F|FALSE|false|0)[[:space:]]*$", x)
  if (!all(true[!na] != false[!na])) warning("Invalid boolean values detected.")
  true[na] <- NA
  true
}

format_column_boolean <- function(x, meta) {
  res <- ifelse(x, "1", "0")
  res[is.na(x)] <- ""
  res
}

ft_is_boolean <- function(field, name) {
  if (!is.logical(field)) return(NULL)
  list(type = "number")
}

