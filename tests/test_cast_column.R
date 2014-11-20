
library(testthat)

expect_that(datapackage:::cast_column_date("2010-10-12"), 
  equals(as.Date("2010-10-12")))
expect_that(datapackage:::cast_column_date("12-10-2010", "dd-mm-yyyy"), 
  equals(as.Date("2010-10-12")))
expect_that(datapackage:::cast_column_date("20101012", "yyyymmdd"), 
  equals(as.Date("2010-10-12")))
expect_that(datapackage:::cast_column_date("10/12/2010", "mm/dd/yyyy"), 
  equals(as.Date("2010-10-12")))
expect_that(datapackage:::cast_column_date("2010-10", "yyyy-mm"), 
  equals(as.Date("2010-10-01")))
expect_that(datapackage:::cast_column_date("2010", "yyyy"), 
  equals(as.Date("2010-01-01")))
expect_that(datapackage:::cast_column_date(c("2010-10-12", NA)), 
  equals(as.Date(c("2010-10-12", NA))))

