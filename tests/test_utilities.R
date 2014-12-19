library(testthat)
library(datapackage)

expect_true(datapackage:::absolute_path("\\\\foo\\bar"))
expect_true(datapackage:::absolute_path("c:\\foo"))
expect_true(datapackage:::absolute_path("http://foo.bar"))
expect_true(datapackage:::absolute_path("https://foo.bar"))
expect_true(datapackage:::absolute_path("ftp://foo.bar"))
expect_true(datapackage:::absolute_path("file://foobar"))
expect_true(datapackage:::absolute_path("/foo"))
expect_false(datapackage:::absolute_path("../foo"))
expect_false(datapackage:::absolute_path("foo/bar"))

