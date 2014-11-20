
dpsave <- function(meta, path, ...) {
  # create directory
  tst <- file.info(path)
  if (!is.na(tst$isdir) && !tst$isdir)
    stop("'", path, "' already exists and is not a directory")
  dir.create(path, showWarnings=FALSE)
  tst <- file.info(path)
  if (is.na(tst$isdir) || !tst$isdir)
    stop("Creation of directory '", path, "' failed.")
  # check if we have access to all the necessary resources
  data <- list(...)
  resources <- dpresources(meta)
  if (!all(resources %in% names(data))) {
    t <- !(resources %in% names(data))
    stop("Resources missing: ", 
      paste0("'", resources[t], "'", collapse=", "), ".")
  }
  # save resources
  old_wd <- getwd()
  on.exit(setwd(old_wd))
  setwd(path)
  for (r in resources) {
    filename <- paste0(r, ".csv")
    # check if we have the data in ...
    d <- data[[r]]
    if (!is.null(d)) {
      res <- save_resource(meta, r, d, filename)
      index <- resource_index(meta, r)
      meta$resources[[index]] <- unclass(res)
    } else {
      # resources can also store there own data in which case we have to do 
      # nothing
      res <- dpresource(meta, r)
      if (is.null(res[[data]])) 
        stop("Data for resource '", r, "' is missing.")
    }
  }
  # save meta data
  attr(meta, "base_url") <- path
  data <- toJSON(unclass(meta), auto_unbox = TRUE)
  con <- file("datapackage.json", "wt", encoding = "UTF-8")
  writeLines(data, con = con)
  close(con)
  invisible(meta)
}

#' Save the data of a resource to file
#' 
#' @param meta a \code{datapackage} object or a \code{\link{dpresource}} object
#'   in which case the \code{resource} argument is ignored.
#' @param resource an identifier of the the resource. This can be a numeric
#'   index, or a character with the name of the resource. 
#' @param data the data of the resource. When omitted the \code{data} element 
#'   of the resource is used (if present).
#' @param path folder in which to save the data.
#'
#' @return 
#' Returns the \code{datapackage} object with the new path, and filename of the 
#' resource.
#' 
#' @export
save_resource <- function(meta, resource, data, filename) {
  res <- dpresource(meta, resource)
  # check data
  if (missing(data) || is.null(data)) {
    # look for data in the resource
    if (is.null(res$data)) 
      stop("No data specified as argument and no data in resource.")
    data <- res$data
  }
  if (!is.data.frame(data)) stop("Data needs to be a data.frame")
  # check fields
  fields <- dpfields(res)
  if (length(setdiff(fields, names(data)))) 
    stop("Fields in data do not match those in resource description.")
  # convert each of the fields to character
  for (field in fields) {
    m <- dpfield(res, field=field)
    data[[field]] <- format_column(data[[field]], m)
  }
  # save resource
  write.csv(data, filename, quote=FALSE, row.names=FALSE, 
    fileEncoding = "UTF-8", eol = "\n", na = "")
  # set path in resource
  res$path <- filename
  res
}

format_column <- function(x, meta) {
  type <- meta$type
  if (!is.character(type)) stop("type should be a character vector.")
  type <- type[1]
  fun <- paste0("format_column_", type)
  if (!existsFunction(fun)) 
    stop("Unsupported field type: '", type, "'.")
  do.call(fun, list(x, meta))
}

