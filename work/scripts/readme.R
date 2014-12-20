library(knitr)
library(devtools)
library(methods)
load_all("../")

knit("scripts/README.Rmd", output="../README.md")

