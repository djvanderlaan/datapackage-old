datapackage
===========

Reading and writing datapackages from R


Creating a datapackage
----------------------

A datapackage can be created using the `datapackage` function, which needs a
name and optionally a title and description:
```
pkg <- datapackage(name="r_examples", title="Some example data sets from R",
  description="Contains a number of example data sets from base R.")
```

This datapackage  does not yet contain any datasets. To add data to the
datapackage the `dpadd_resource` function can be used.  The minimum amount of
information `dpadd_resource` expects is a data frame and the datapackage to
which the data resource needs to be added.  Optionally, a name and title can be
specified. 

```
pkg <- dpadd_resource(pkg, data=iris, name="iris", 
  title="Edgar Anderson's Iris Data")

pkg <- dpadd_resource(pkg, data=as.data.frame(Titanic), name="titanic",
  title="Survival of Passengers on the Titanic"
```





