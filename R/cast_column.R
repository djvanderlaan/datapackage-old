
cast_column <- function(x, type, format = NULL) {
  if (!is.character(type)) stop("type should be a character vector.")
  type <- type[1]
  fun <- paste0("cast_column_", type)
  if (!existsFunction(fun)) {
    warning("Unsupported field type: '", type, "'; reading as character field")
    x
  } else {
    do.call(fun, list(x, format))
  }
}


