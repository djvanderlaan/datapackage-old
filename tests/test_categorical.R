
library(testthat)

x <- as.factor(sample(c("man","vrouw", NA), 20, replace=TRUE))

m <- datapackage:::ft_is_categorical(x)

m$categories[[1]]$title <- toupper(m$categories[[1]]$name)
m$categories[[2]]$title <- toupper(m$categories[[2]]$name)

levels <- sapply(m$categories, function(d) d$name)
labels <- sapply(m$categories, function(d) d$title)

expect_that(levels, equals(c("man", "vrouw")))
expect_that(labels, equals(c("MAN", "VROUW")))

y <- datapackage:::cast_column(as.character(x), m)

expect_true(is.factor(y))
expect_that(levels(y), equals(c("MAN", "VROUW")))



