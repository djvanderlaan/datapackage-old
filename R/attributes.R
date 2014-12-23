
#' Get and set the attributes in datapackage meta data
#'
#' @param meta the meta data for which the attribute needs to be set or get.
#'   This can be an object of type \code{\link{datapackage}},
#'   \code{\link{dpresource}} or \code{\link{dpfield}}. 
#' @param attribute the name of the attribute that needs to be set. 
#' @param ... currently unused. 
#'
#' @details
#' A \code{datapackage} contains one or more resources (\code{dpresource}),
#' which contain a number of fields (\code{dpfield}). Each of these objects
#' contain a number of attributes such as a name, title and description, that
#' describe the object. These attributes can be read and modified using the
#' methods presented here. 
#'
#' The objects \code{datapackage}, \code{dpresource} and \code{dpfield} are just
#' lists and can besides the methods presented here, also easily be modified
#' using the regular list operation, e.g. to change the title of an
#' \code{datapackage} one could also use \code{meta[['title']] <- "My title"}. 
#'
#' The methods \code{dptitle}, \code{dpname}, \code{dpdescription}, \code{type}
#' and \code{format} are just shortcuts for \code{dpattr('title')} etc. 
#'
#' @rdname attributes
#' @export
dpattr <- function(meta, attribute, ...) {
  if (!is.character(attribute) || length(attribute) != 1) 
    stop("attribute needs to be a character vector of length 1.")
  UseMethod("dpattr")
}

#' @rdname attributes
#' @export dpattr.datapackage
dpattr.datapackage <- function(meta, attribute, ...) {
  meta[[attribute]]
}

#' @rdname attributes
#' @export dpattr.dpresource
dpattr.dpresource <- function(meta, attribute, ...) {
  meta[[attribute]]
}

#' @rdname attributes
#' @export dpattr.dpfield
dpattr.dpfield <- function(meta, attribute, ...) {
  meta[[attribute]]
}



# ======= Some shortcuts =======

#' @rdname attributes
#' @export
dptitle <- function(meta, ...) {
  dpattr(meta, attribute="title", ...)
}

#' @rdname attributes
#' @export
dpname <- function(meta, ...) {
  dpattr(meta, attribute="name", ...)
}

#' @rdname attributes
#' @export
dpdescription <- function(meta, ...) {
  dpattr(meta, attribute="description", ...)
}

#' @rdname attributes
#' @export
dptype <- function(meta, ...) {
  if (!is(meta, "dpfield")) 
    stop("Only fields have a type. Meta should be of type 'dpfield'.")
  dpattr(meta, "type")
}

#' @rdname attributes
#' @export
dpformat <- function(meta, ...) {
  if (!is(meta, "dpfield")) 
    stop("Only fields have a format. Meta should be of type 'dpfield'.")
  dpattr(meta, "format")
}

