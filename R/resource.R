
#' Get list of the resources in the datapackage.
#'
#' @param meta a \code{\link{datapackage}} object
#'
#' @return 
#' Returns a character vector with the resource names
#'
#' @export
dpresources <- function(meta) {
  sapply(meta$resources, function(r) {
    r$name
  })
}

#' Get or set the meta data of a specific resource from a datapackage
#' 
#' @param meta a \code{\link{datapackage}} object
#' @param resource an identifier of the resource. This can be a numeric
#'   index, or a character with the name of the resource. 
#' @param value a \code{dpresource} object
#'
#' @return 
#' \code{dpresource} returns a \code{dpresource} object. 
#' 
#' @rdname dpresource
#' @export
dpresource <- function(meta, resource = 1) {
  if (is(meta, "dpresource")) return(meta)
  res <- resource_index(meta, resource)
  if (is.null(res)) stop("Could not find resource '", resource, "'.")
  res <- meta$resources[[res]]
  structure(res, class="dpresource", base_url = attr(meta, "base_url"))
}

#' @rdname dpresource
#' @export
`dpresource<-` <- function(meta, resource = 1, value) {
  if (!is(value, "dpresource")) stop("value should be a 'dpresource'.")
  if (is(meta, "dpresource")) return(value)
  res <- resource_index(meta, resource)
  if (is.null(res)) stop("Could not find resource '", resource, "'.")
  meta$resources[[res]] <- value
  meta
}


#' Add a resource to a \code{\link{datapackage}}
#'
#' @param meta a \code{\link{datapackage}} object
#' @param data a \code{data.frame} that is added as resource to the datapackage.
#' @param name the name of the resource.
#' @param title the title of the resource.
#' @param description a description of the resource. 
#' @param replace replace an existing data resource with the same name (if such a 
#'   resource exists).
#' @param inline_data add the data to the resource, not just the description of 
#'   the data. 
#'
#' @return
#' Returns the original \code{meta} object with the new resource added. 
#'
#' @export
dpadd_resource <- function(meta, data, name, title, description = "", 
    replace = FALSE, inline_data = FALSE) {
  if (!is.data.frame(data)) stop("data needs to be a data.frame.")
  if (missing(name)) name <- deparse(substitute(data))
  if (missing(title)) title <- name
  if (!is.character(name) || length(name) != 1) 
    stop("name needs to be a character vector with length one.")
  if (!is.character(title) || length(title) != 1) 
    stop("title needs to be a character vector with length one.")
  if (!is.character(description) || length(description) != 1) 
    stop("description needs to be a character vector with length one.")
  # create resources if they do not yet exist
  if (is.null(meta$resources)) meta$resources <- list()
  # check if the new resource does not have the same name as an existing one
  resources <- dpresources(meta)
  exists <- name %in% resources
  if (exists && !replace) stop("Trying to add a resource with the same name ",
    "as an existing resource. Use 'replace=TRUE' when trying to replace an ",
    "existing resource.")
  # determine index of new resource
  index <- ifelse(exists, which(name == resources), length(resources)+1)
  # add the resource
  meta$resources[[index]] <- list(name=name, title=title)
  meta$resources[[index]]$schema <- list()
  # create data schema
  fields <- list()
  for (i in seq_along(data)) {
    field <- list()
    field$name = names(data)[i]
    field$title = names(data)[i]
    field$description = ""
    type <- field_type(data[[i]], names(data)[i])
    for (v in names(type)) field[[v]] <- type[[v]]
    fields[[i]] <- field
  }
  meta$resources[[index]]$schema$fields <- fields
  # add data
  if (inline_data) meta$resources[[index]]$data = data
  meta
}

#' Print a \code{\link{dpresource}} object
#'
#' @param x a \code{\link{dpresource}} object
#' @param ... ignored. 
#'
#' @importFrom yaml as.yaml
#' @export print.dpresource
print.dpresource <- function(x, ...) {
  cat("Datapackage resource:\n")
  cat(as.yaml(x))
  invisible(x)
}


#' Get the index of a resource in the \code{\link{datapackage}}
#'
#' Returns a numeric index. In case of a valid numeric value of \code{resource}
#' \code{resource} is returned. In case of a character value of \code{resource}
#' the index of the resource with the same name is returned. In case the 
#' resource could not be found the value \code{NULL} is returned. 
#'
#' @param meta a \code{\link{datapackage}} object
#' @param resource an identifier of the the resource. This can be a numeric
#'   index, or a character with the name of the resource. 
#'
resource_index <- function(meta, resource) {
  res <- NULL
  if (is.numeric(resource)) {
    if (resource > 0 && resource <= length(meta$resources)) 
      res <- resource
  } else if (is.character(resource)) {
    for (i in seq_along(meta$resources)) {
      if (meta$resources[[i]]$name == resource) {
        res <- i
        break
      }
    }
  } else {
    stop("resource needs to be either a numeric of character index")
  }
  res
}

