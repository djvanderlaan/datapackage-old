
library(devtools)
load_all("../")

for (file in list.files("../tests")) {
  cat("\nRunning", file, "\n===================================\n")
  source(file.path("../tests", file))
}

