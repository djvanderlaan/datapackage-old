library(knitr)
library(devtools)
load_all("../")

knit("scripts/README.Rmd", output="../README.md")

