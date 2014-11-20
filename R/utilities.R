#' Download a file from a URL into a local temporary file
#' 
#' @param url a character vector containing the url to the file. When the 
#'   protocal (\code{http}, \code{ftp}, \code{file} or \code{https}) is missing, 
#'   it is assumed that the url points to a local file; and the protocal 
#'   \code{file} is used. 
#' 
#' @details
#' Uses \code{\link{download.file}} to download the file; except when the URL 
#' points to an \code{https} address. In that case the package \code{RCurl} is
#' used. 
#' 
#' @return
#' Returns the name of the temporary file. 
#' 
download_file <- function(url) {
  https <- grepl("^https:", url)
  fn <- tempfile()
  if (https) {
    if (!requireNamespace("RCurl", quietly = TRUE)) 
      stop("Library RCurl is needed to download data from https URL's.")
    data <- RCurl::getURL(url)
    writeLines(data, fn)
  } else {
    protocol_missing <- !grepl("^(http://|file://|ftp://)", url)
    if (protocol_missing) url <- paste0("file://", url)
    download.file(url, fn, quiet = TRUE)
  }
  fn
}


#' Check is an URL is absolute or relative
#'
#' @param url the url(s) to check
#'
#' @return
#' Returns a logical vector indicating whether the path is absolute or relative.
#'
absolute_path <- function(url) {
  url <- as.character(url)
  res <- rep(FALSE, length(url))
  # match absolute url's
  res[grepl("^(http|https|file|ftp)://", url)] <- TRUE
  # match absolute paths on linux; and network folders
  res[grepl("^[\\/\\\\]+", url)] <- TRUE
  # match absolute paths on windows
  res[grepl("^[A-Za-z]:", url)] <- TRUE
  res
}

