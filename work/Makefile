

.PHONY: build, check

all: build check

build: 
	R --silent -e "library(roxygen2); roxygenise(\"../\")"
	R CMD build ../

check:
	R CMD check `ls datapackage*.tar.gz | tail -n 1`

install:
	R CMD INSTALL `ls datapackage*.tar.gz | tail -n 1`
