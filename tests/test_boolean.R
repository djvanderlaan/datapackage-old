library(testthat)

expect_that(datapackage:::cast_column_boolean(c(" 1", "0 ", "")),
  equals(c(TRUE, FALSE, NA)))
expect_that(datapackage:::cast_column_boolean(c(" true", "false", "")),
  equals(c(TRUE, FALSE, NA)))
expect_that(datapackage:::cast_column_boolean(c(" TRUE", "FALSE", "")),
  equals(c(TRUE, FALSE, NA)))
expect_that(datapackage:::cast_column_boolean(c(" T", "F", "")),
  equals(c(TRUE, FALSE, NA)))

num <- c(TRUE, FALSE, NA)
expect_that(datapackage:::format_column_boolean(num, list()), equals(c("1", "0", "")))

expect_that(datapackage:::ft_is_boolean(num),equals(list(type="boolean")))
expect_that(datapackage:::ft_is_boolean(as.numeric(num)),equals(NULL))
expect_that(datapackage:::ft_is_boolean(c("a", "b")),equals(NULL))

