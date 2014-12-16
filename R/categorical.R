
ft_is_categorical <- function(field, name) {
  if (!is.factor(field)) return(NULL)
  categories <- list()
  categories <- lapply(levels(field), function(l)
    list(name = l, title = l, description = ""))
  list(type= "string", categories=categories)
}

