library(testthat)

expect_that(datapackage:::cast_column_number(c("42", "-1.24", "")),
  equals(c(42, -1.24, NA)))

num <- c(42, -1.24, NA)
expect_that(datapackage:::format_column_number(num, list()), equals(c("42", "-1.24", "")))

expect_that(datapackage:::ft_is_number(num),equals(list(type="number")))
expect_that(datapackage:::ft_is_number(c("a", "b")),equals(NULL))

