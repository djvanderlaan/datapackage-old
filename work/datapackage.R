library(jsonlite)
library(yaml)

files <- list.files("../R", "*\\.R$")
for (file in files) {
  source(file.path("../R", file))
}
rm(files, file)

