
cast_column_datetime <- function(x, format) {
  x[x == ""] <- NA
  as.POSIXct(strptime(x, "%Y-%m-%dT%H:%M:%SZ", tz="GMT"))
}

format_column_datetime <- function(x, meta) {
  res <- strftime(x, "%Y-%m-%dT%H:%M:%SZ", tz="GMT")
  res <- paste0('"', res, '"')
  res[is.na(x)] <- ""
  res
}

