datapackage
===========

Reading and writing datapackages from R


Creating a datapackage
----------------------

```
pkg <- datapackage(name="iris", title="Edgar Anderson's Iris Data", 
  description=paste("This famous (Fisher's or Anderson's) iris data set gives", 
     "the measurements in centimeters of the variables sepal length and", 
     "width and petal length and width, respectively, for 50 flowers", 
     "from each of 3 species of iris.  The species are 'Iris setosa',", 
     "'versicolor', and 'virginica'."), data=iris)
```



