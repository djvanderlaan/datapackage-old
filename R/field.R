
#' Get list of fields in the file
#'
#' @param meta a \code{\link{datapackage}} object or a \code{\link{dpresource}}
#'   object in which case the \code{resource} argument is ignored.
#' @param resource an identifier of the the resource. This can be a numeric
#'   index, or a character with the name of the resource. 
#'
#' @return 
#' Returns a character vector with field names.
#'
#' @export
dpfields <- function(meta, resource = 1) {
  resource <- dpresource(meta, resource)
  fields   <- resource$schema$fields
  sapply(fields, function(d) d$name)
}

#' Get and set the meta data of a single field
#'
#' @param meta a \code{\link{datapackage}} object or a \code{\link{dpresource}}
#'   object in which case the \code{resource} argument is ignored.
#' @param resource an identifier of the the resource. This can be a numeric
#'   index, or a character with the name of the resource. 
#' @param field the name or number of the field. 
#' @param value a \code{dpfield} object to assign to the field.
#'
#' @return
#' \code{dpfield} returns an object of type \code{dpfield}.
#'
#' @rdname dpfield
#' @export
dpfield <- function(meta, field, resource = 1) {
  resource <- dpresource(meta, resource)
  if (is.numeric(field)) {
    var <- resource$schema$fields[[field]]
  } else if (is.character(field)) {
    var <- NULL
    for (i in seq_along(resource$schema$fields)) {
      tmp <- resource$schema$fields[[i]]
      if (tmp$name == field) {
        var <- tmp
        break;
      }
    }
  } else {
    stop("field needs to be either of type character or numeric.")
  }
  if (is.null(var)) 
    stop("field '", field, "' could not be found.")
  structure(var, class="dpfield")
}

#' @rdname dpfield
#' @export
`dpfield<-` <- function(meta, field, resource = 1, value) {
  if (!is(value, "dpfield")) stop("value should be a 'dpfield'.")
  r <- dpresource(meta, resource)
  if (length(field) != 1) stop("field needs to be of length 1.")
  index <- field
  if (is.character(field)) {
    index <- NULL
    for (i in seq_along(r$schema$fields)) {
      tmp <- r$schema$fields[[i]]
      if (tmp$name == field) {
        index <- i
        break;
      }
    }
    if (is.null(index)) 
      stop("Field '", field, "' does not exist in resource.")
  }
  if (!is.numeric(index))
    stop("field needs to be either of type character or numeric.")
  if (index < 0 || index > length(r$schema$fields))
    stop("Field does not exist in resource.")
  r$schema$fields[[index]] <- value
  if (is(meta, "datapackage")) 
    dpresource(meta, resource) <- r
  meta
}


#' Print a \code{\link{dpfield}} object
#'
#' @param x a \code{\link{dpfield}} object
#' @param ... ignored. 
#'
#' @importFrom yaml as.yaml
#' @export print.dpfield
print.dpfield <- function(x, ...) {
  cat("Datapackage field meta:\n")
  cat(as.yaml(x))
}

