library(testthat)
library(datapackage)

testpackage <- system.file("examples/testpackage", package="datapackage")
p <- dpopen(testpackage)

expect_true(all(c("name", "resources") %in% names(p)))
expect_that(dpresources(p), equals(c("resource1", "resource2")))
expect_true(all(c("name", "path", "title", "schema") %in% names(dpresource(p))))
expect_that(dpfields(p, "resource1"), equals(c("integer", "string", "number", 
  "date", "datetime", "boolean" )))
expect_that(dpfields(p, "resource2"), equals(c("v1", "v2")))

fields <- dpfields(p)
for (field in fields) {
  cat("Checking field", field, "\n")
  expect_true(all(c("name", "title", "type") %in% names(dpfield(p, field))))
}

data <- dpdata(p)

expect_that(data$integer, equals(1:4))
expect_that(data$string, equals(c("jan", "pier", "tjorres", "korneel")))
expect_that(data$number, equals(c(12.12344, -1212.6, 0, NA)))
expect_that(data$date, equals(as.Date(c("2050-12-31", NA, "1900-05-04", "2010-11-30"))))
expect_that(data$datetime, equals(as.POSIXct(c("2050-12-31 14:12:33", "2014-01-01 00:00:01", NA, "2010-11-30 23:55:00"),
  format="%Y-%m-%d %H:%M:%S", tz="GMT")))
expect_that(data$boolean, equals(c(TRUE, FALSE, TRUE, NA)))

