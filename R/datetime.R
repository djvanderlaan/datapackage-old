
cast_column_datetime <- function(x, meta) {
  x[x == ""] <- NA
  as.POSIXct(strptime(x, "%Y-%m-%dT%H:%M:%SZ", tz="GMT"))
}

format_column_datetime <- function(x, meta) {
  res <- strftime(as.POSIXct(x), "%Y-%m-%dT%H:%M:%SZ", tz="GMT")
  res <- paste0('"', res, '"')
  res[is.na(x)] <- ""
  res
}

ft_is_datetime <- function(field, name) {
  if (!is(field, "POSIXt")) return(NULL)
  list(type = "datetime")
}

