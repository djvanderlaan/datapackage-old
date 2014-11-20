
#' Retrieve the data of  a resource
#'
#' @param meta a \code{datapackage} object or a \code{\link{dpresource}} object
#'   in which case the \code{resource} argument is ignored.
#' @param resource an identifier of the the resource. This can be a numeric
#'   index, or a character with the name of the resource. 
#'
#' @return
#' A \code{data.frame} containing the data of the resource. 
#'
#' @details
#' Currently the following types are supported:
#' \describe{
#'   \item{string}{a string (of arbitrary length)}
#'   \item{number}{a number including floating point numbers.}
#'   \item{integer}{an integer.}
#'   \item{date}{a date. This MUST be in ISO6801 format YYYY-MM-DD or, if not, a
#'   format field must be provided describing the structure.}
#'   \item{datetime}{a date-time. This MUST be in ISO 8601 format of
#'   YYYY-MM-DDThh:mm:ssZ in UTC time or, if not, a format field must be
#'   provided.}
#'   \item{boolean}{a boolean value (1/0, true/false).}
#' }
#' 
#' @export
dpdata <- function(meta, resource = 1) {
  res <- dpresource(meta, resource)
  path <- ifelse(is.null(res$path), res$url, res$path)
  if (is.null(path)) stop("Path and url are missing from resource.")
  # when the path only contains a file name, assume the file is located in the
  # datapackage directory; otherwise just used the path as given
  absolute <- absolute_path(path)
  if (!absolute) path <- paste0(attr(res, "base_url"), "/", path)
  localfn <- download_file(path)
  data <- read.csv(localfn, colClasses="character", stringsAsFactors=FALSE,
    header=TRUE, check.names=FALSE)
  fields <- dpfields(meta, resource)
  if (!all(names(data) %in% fields)) {
    extra <- names(data)[!(names(data) %in% fields)]
    stop("Columns in the resource not found the meta: ", paste0("'", extra, "'", collapse=", "), ".");
  }
  if (!(all(fields %in% names(data)))) {
    missing <- fields[!(fields %in% names(data))]
    stop("Fields missing from resource: ", paste0("'", missing, "'", collapse=", "), ".");
  }
  # convert each of the fields to the right R-type
  for (field in fields) {
    fieldmeta <- dpfield(meta, field, resource)
    data[[field]] <- cast_column(data[[field]], fieldmeta$type, fieldmeta$format)
  }
  data
}

