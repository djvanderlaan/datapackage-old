
library(testthat)

expect_that(datapackage:::cast_column_datetime(c("2010-10-12T20:30:00Z", "")), 
  equals(as.POSIXct(c("2010-10-12 20:30:00", NA), format="%Y-%m-%d %H:%M:%S", tz="GMT")))

time <- as.POSIXct(c("2010-10-12 20:30:00", NA), "%Y-%m-%d %H:%M:%S")
expect_that(datapackage:::format_column_datetime(time, list()), equals(c("\"2010-10-12T20:30:00Z\"", "")))


#expect_that(datapackage:::ft_is_date(date),equals(list(type="date")))
#expect_that(datapackage:::ft_is_date(c(0,0)),equals(NULL))
#
