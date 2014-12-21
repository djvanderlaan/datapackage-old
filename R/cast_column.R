
cast_column <- function(x, meta) {
  type <- meta$type
  if (!is.character(type)) stop("type should be a character vector.")
  type <- type[1]
  fun <- paste0("cast_column_", type)
  if (!existsFunction(fun)) {
    warning("Unsupported field type: '", type, "'; reading as character field")
    res <- x
  } else {
    res <- do.call(fun, list(x, meta))
  }
  if (!is.null(meta$categories)) {
    levels <- sapply(meta$categories, function(d) d$name)
    labels <- sapply(meta$categories, function(d) d$title)
    res <- factor(res, levels=levels, labels=labels)
  }
  res
}


