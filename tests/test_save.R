library(testthat)

generate_strings <- function(n, lmin, lmax) {
  nchar <- sample(seq.int(lmin, lmax), n, replace=TRUE)
  res <- character(n)
  for (l in seq.int(lmax)) {
    sel <- nchar >= l
    nsel <- sum(sel)
    c <- sample(letters, nsel, replace=TRUE)
    res[sel] <- paste0(res[sel], c)
  }
  res
}

data <- data.frame(
  integer = 1:100,
  number = round(rnorm(100), 2),
  boolean = rbinom(100, 1, 0.2) > 0.5,
  date = as.Date(sample(1:50000, 100), origin="1970-01-01"),
  time = as.POSIXct(runif(100, 0, 5E9), origin="1970-01-01"),
  string = generate_strings(100, 0, 10),
  factor = as.factor(sample(c("male", "female"), 10, replace=TRUE)),
  stringsAsFactors=FALSE
)
# need to round the time; since we now have fractional seconds (from runif);
# these are dropped when writing to file; resulting in incorrect comparison
# between data and result written to file
data$time <- round(data$time, "secs")

# add some missing values
for (col in names(data)) {
  # skip character columns; missing values in character columns can not be 
  # distinguished from empty strings
  if (is.character(data[[col]])) next
  is.na(data[[col]]) <- rbinom(100, 1, 0.1) > 0.5
}

meta <- datapackage(name="testpackage", data=data)

fn <- tempfile()
dir.create(fn)
dpsave(meta, fn, testpackage=data)

meta2 <- dpopen(fn)
data2 <- dpdata(meta2)

expect_that(data2, equals(data))

