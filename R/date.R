
cast_column_date <- function(x, meta) {
  format <- "yyyy-mm-dd"
  if (!missing(meta) && !is.null(meta) && meta$format != "")
    format <- meta$format
  format <- tolower(format)

  x[x == ""] <- NA
  year <- extract_date_part(x, "yyyy", format, required=TRUE)
  month <- extract_date_part(x, "mm", format, 1)
  day <- extract_date_part(x, "dd", format, 1)
  dates <- sprintf("%04d-%02d-%02d", year, month, day)
  dates[is.na(x)] <- NA
  as.Date(dates)
  #as.Date(sprintf("%04d-%02d-%02d", year, month, day))
}

format_column_date <- function(x, meta) {
  format <- meta$format
  if (missing(format) || is.null(format) || format == "")
    format <- "yyyy-mm-dd"
  format <- tolower(format)
  format <- gsub("yyyy", "%Y", format)
  format <- gsub("mm", "%m", format)
  format <- gsub("dd", "%d", format)
  res <- format.Date(x, format)
  res <- paste0('"', res, '"')
  res[is.na(x)] <- ""
  res
}

ft_is_date <- function(field, name) {
  if (!is(field, "Date")) return(NULL)
  list(type = "date")
}

extract_date_part <- function(x, pattern, format, default = NA, 
    required = FALSE) {
  pos <- regexpr(pattern, format, fixed=TRUE)
  pos2 <- pos + attr(pos, "match.length") - 1
  if (pos < 1) {
    if (required) stop("")
    return (rep(default, length(x)))
  }
  as.integer(substr(x, pos, pos2))
}

