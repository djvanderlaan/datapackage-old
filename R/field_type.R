
field_type <- function(field, name) {
  tests <- list(ft_is_datetime, ft_is_date, ft_is_boolean, ft_is_integer, 
    ft_is_number, ft_is_string)
  for (test in tests) {
    res <- test(field, name)
    if (!is.null(res)) return (res);
  }
  stop("field type could not be determined for field '", field, "'.")
}

