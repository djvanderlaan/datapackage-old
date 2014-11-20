
#' Create a \code{\link{datapackage}} object
#'
#' @param name the name of the datapackage
#' @param title the title of the datapackage
#' @param description the description of the datapackage
#' @param data a \code{data.frame} that is added as resource to the datapackage.
#'
#' @return
#' A \code{datapackage} object.
#'
#' @export
datapackage <- function(name, title, description="", data) {
  if (!missing(data) && !is.data.frame(data)) 
    stop("data needs to be a data.frame.")
  if (missing(name) && !missing(data))
    name <- deparse(substitute(data))
  if (missing(name)) stop("name is required.")
  if (missing(title)) title <- name
  if (!is.character(name) || length(name) != 1) 
    stop("name needs to be a character vector with length one.")
  if (!is.character(title) || length(title) != 1) 
    stop("title needs to be a character vector with length one.")
  if (!is.character(description) || length(description) != 1) 
    stop("description needs to be a character vector with length one.")
  meta <- list(name=name, title=title, description=description)
  meta$resources <- list()
  if (!missing(data)) meta <- dpadd_resource(meta, data, name=name, title=title)
  structure(meta, class="datapackage")
}

#' Print a \code{\link{datapackage}} object
#'
#' @param x a \code{\link{datapackage}} object
#' @param ... ignored. 
#'
#' @importFrom yaml as.yaml
#' @export
print.datapackage <- function(x, ...) {
  cat(as.yaml(x))
}

