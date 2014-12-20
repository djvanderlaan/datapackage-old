

.PHONY: build check install test readme

all: build check

build: 
	R --silent -e "library(roxygen2); roxygenise(\"../\")"
	R CMD build ../

check: build
	R CMD check `ls datapackage*.tar.gz | tail -n 1`

install: build
	R CMD INSTALL `ls datapackage*.tar.gz | tail -n 1`

test: 
	Rscript scripts/test.R

readme: scripts/README.Rmd
	Rscript scripts/readme.R
