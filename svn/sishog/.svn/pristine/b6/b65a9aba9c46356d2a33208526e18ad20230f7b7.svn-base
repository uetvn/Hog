#------------------------------------------------------------------------
# Project name   :
# File name      : !!FILE
# Created date   : !!DATE
# Author         : Ngoc-Sinh Nguyen
# Last modified  : !!DATE
# Guide          :
# 	- Compile part of document via `input`
#------------------------------------------------------------------------

ifndef MAINFILE
	MAINFILE = index
endif

IMGS := $(shell echo "imgs/*")
TEMP2 := $(shell mkdir -p build 2>/dev/null)

TEXS :=$(shell echo *.tex | sed 's/${MAINFILE}//g' )
BIB = $(shell echo *.bib)
OBJ_FILE := $(TEXS:.tex=.pdf)
DIFF_FILE := $(TEXS:.tex=.diff.pdf)
COMPILER=env max_print_line=1000 pdflatex -halt-on-error -file-line-error -interaction=nonstopmode -output-dir=build

.PHONY: $(MAINFILE).diff.pdf

# Whole document
$(MAINFILE).pdf: $(MAINFILE).tex
	$(COMPILER) $(MAINFILE).tex
	bibtex build/$(MAINFILE).aux
	$(COMPILER) $(MAINFILE).tex


$(MAINFILE).diff.pdf: $(MAINFILE).tex
	GitLatexDiff.sh -m $(MAINFILE).tex --view --output build/diff.pdf
	atril build/diff.pdf

# Only part of document
$(OBJ_FILE) : %.pdf: %.tex
	$(COMPILER) index_only_$<

.PHONY: clean
clean:
	-rm -f build/*.aux
	-rm -f build/*.log
	-rm -f build/*.toc
	-rm -f build/*.bbl
	-rm -f build/*.blg
	-rm -f build/*.out
	-rm -f build/bib

.PHONY: cleanall
cleanall: clean
	-rm -f build/*.pdf
	-rm -f build/*.ps
	-rm -f build/*.dvi
	rm -rf build/*
