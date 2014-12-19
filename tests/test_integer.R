library(testthat)
library(datapackage)

expect_that(datapackage:::cast_column_integer(c("42", "-124", "")),
  equals(c(42, -124, NA)))

num <- c(42, -124, NA)
expect_that(datapackage:::format_column_integer(num, list()), equals(c("42", "-124", "")))

expect_that(datapackage:::ft_is_integer(as.numeric(num)),equals(list(type="integer")))
expect_that(datapackage:::ft_is_integer(as.integer(num)),equals(list(type="integer")))
expect_that(datapackage:::ft_is_integer(c("a", "b")),equals(NULL))
expect_that(datapackage:::ft_is_integer(c(1.23, 1)),equals(NULL))

