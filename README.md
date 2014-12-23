datapackage
===========

Reading and writing datapackages from R


Creating a datapackage
----------------------

A datapackage can be created using the `datapackage` function, which needs a
name and optionally a title and description:


```r
examples <- datapackage(name="r_examples", title="Some example data sets from R",
  description="Contains a number of example data sets from base R.")
```

This datapackage  does not yet contain any datasets. Data can be added to the 
datapackage with `dpadd_resource`.  The minimum amount of information
`dpadd_resource` expects is a data frame and the datapackage to which the data
resource needs to be added.  Optionally, a name and title can be specified. 


```r
examples <- dpadd_resource(examples, data=iris, name="iris", 
  title="Edgar Anderson's Iris Data")

examples <- dpadd_resource(examples, data=as.data.frame(Titanic), name="titanic",
  title="Survival of Passengers on the Titanic")
```

To save the datapackage to file `dpsave` can be used. It expects the package,
the directory in which to save the package and the data: 


```r
dpsave(examples, path="./r_examples", iris=iris, titanic=as.data.frame(Titanic))
```

The reason for having to pass the data to `dpsave` is that the data is not
stored in the datapackage object. The reason for that is that we do not want to
create multiple copies of the same data set in R's memory. Perhaps in the future
we will add an option to `dpadd_resource` to store the data in the datapackage.


Opening a datapackage
---------------------

A datapackage can de opened using `dpopen`:


```r
pkg <- dpopen("https://raw.githubusercontent.com/djvanderlaan/datapackage/master/inst/examples/diabetes/datapackage.json")
```

A list of resources can be obtained using `dpresources`

```r
dpresources(pkg)
```

```
## [1] "diabetes"
```

The data belongin to a specific resource can be opened using `dpdata`

```r
head(dpdata(pkg, "diabetes"))
```

```
##         year       age   sex diabetes diabetes_type1 diabetes_type2
## 1 2001-01-01     Total Total      2.8            0.6            2.2
## 2 2001-01-01     Total   Men      3.5            0.8            2.7
## 3 2001-01-01     Total Women      2.2            0.5            1.7
## 4 2001-01-01 0 till 25 Total      0.3            0.3            0.0
## 5 2001-01-01 0 till 25   Men      0.3            0.3            0.0
## 6 2001-01-01 0 till 25 Women      0.3            0.3            0.0
##   underweight normalweight overweight obese
## 1         1.7         53.5       35.4   9.3
## 2         0.9         49.1       41.8   8.3
## 3         2.5         57.9       29.2  10.3
## 4         4.3         76.5       17.0   2.2
## 5         1.2         78.7       18.5   1.6
## 6         7.6         74.2       15.4   2.7
```
or since by default the first resource is opened `dpdata(pkg)` would give the
same result.



Manipulation datapackages
-------------------------


In the example below, we first retrieve the meta data belonging to the field
'Sepal.Length' of the `examples` datapackage we created above: 

```r
(f <- dpfield(examples, "Sepal.Length", resource="iris"))
```

```
## Datapackage field meta:
## name: Sepal.Length
## title: Sepal.Length
## description: ''
## type: number
```
The title and description of this field can be changed using `dptitle` and
`dpdescription` respectively: 

```r
dptitle(f) <- "Sepal length"
dpdescription(f) <- "Length of the sepal"
f
```

```
## Datapackage field meta:
## name: Sepal.Length
## title: Sepal length
## description: Length of the sepal
## type: number
```

Other commands that can be used are `dpname` and `dptype` and `dpformat`. The
last two are spefic for field descriptions. The other commands can also be used
to modify resources and datapackages. All of these functions are shortcuts for
the more general `dpattr` which can be used to set any attribute of a meta data
object. For example, `dptitle(f)` is just a shortcut for `dpattr(f, "title")`.
`dpattr` can be used to set fields which are not specifically defined in the
tabular datapackage format, such as a unit for a field:

```r
dpattr(f, "unit") <- "cm"
```

With the commands, the field `f` has been modified, but these modification are
not yet part of the datapackage `examples`. In order to modify the datapackage,
the newly defined field definition needs to be assigned to the datapackage:

```r
dpfield(examples, "Sepal.Length", resource="iris") <- f
```

It is also possible to change the field information directly in the datapackage
object by nesting the `dpfield` and `dpattr` calls as in:

```r
dptitle(dpfield(examples, "Sepal.Length", resource="iris")) <- "Sepal length"
```

As was mentioned above the `dpattr`, `dptitle`, ... commands can also be used
for resources and datapackages. For example, to change the title of a resource:


```r
dptitle(dpresource(examples, "iris")) <- "The Iris data set"
```










