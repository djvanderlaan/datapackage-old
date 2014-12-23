library(testthat)
library(datapackage)

pkg <- datapackage(data=iris)

expect_that(dpname(pkg), equals("iris"))
expect_that(dptitle(pkg), equals("iris"))
expect_that(dpdescription(pkg), equals(""))
expect_that(dpattr(pkg, "name"), equals("iris"))

expect_error(dptype(pkg))
expect_error(dpformat(pkg))
expect_error(dpattr(pkg, 1))
expect_error(dpattr(pkg, c("name", "title")))

dptitle(pkg) <- "Iris"
expect_that(pkg[["title"]], equals("Iris"))

dpattr(pkg, "foobar") <- "Foo Bar"
expect_that(pkg[["foobar"]], equals("Foo Bar"))
expect_that(dpattr(pkg, "foobar"), equals("Foo Bar"))


fld <- dpfield(pkg, "Sepal.Length")
expect_that(dptype(fld), equals("number"))
expect_that(dpformat(fld), equals(NULL))

dpformat(fld) <- "foo bar"
expect_that(fld[["format"]], equals("foo bar"))


# Modify resource
r <- dpresource(pkg)
dptitle(r) <- "Iris"
dpresource(pkg) <- r
expect_that(pkg$resources[[1]]$title, equals("Iris"))



