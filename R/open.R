
#' Open a data package
#' 
#' @param datapackage a directory containing a datapackage.
#'
#' @return
#' Return a \code{\link{datapackage}} object.
#'
#' @importFrom jsonlite fromJSON
#' @export
dpopen <- function(datapackage) {
  # normalise datapackage which should point to a directory containing a
  # datapackage.json
  stopifnot(is.character(datapackage))
  stopifnot(length(datapackage) == 1)
  if (grepl("datapackage\\.json$", datapackage)) 
    datapackage <- gsub("datapackage\\.json$", "", datapackage)
  # remove trailing (back)slash from path
  datapackage <- gsub("[\\/\\\\]$", "", datapackage)
  meta <- fromJSON(paste0(datapackage, "/datapackage.json"), 
    simplifyDataFrame = FALSE)
  structure(meta, class="datapackage", base_url=datapackage)
}

