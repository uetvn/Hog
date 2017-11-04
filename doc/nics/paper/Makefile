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

TITLE=$(shell grep -o "\\\title{.*}" ${MAINFILE}.tex | sed 's/^.*{//g;s/\s*}//g')
OUTFILE="$(TITLE)"


COMPILER=env max_print_line=1000 pdflatex \
		 -halt-on-error -file-line-error \
		 -interaction=nonstopmode \
		 -output-dir=build \
		 -jobname=$(OUTFILE)
		

.PHONY: diff
.PHONY: pdf

# Whole document
pdf:
	$(COMPILER) $(MAINFILE).tex
	bibtex build/$(OUTFILE).aux
	$(COMPILER) $(MAINFILE).tex


diff:
	git latexdiff \
		--verbose \
		--tmpdirprefix build/ \
		--bibtex \
		--latexopt -interaction=nonstopmode \
		--ignore-latex-errors \
		--whole-tree \
		--ignore-warnings \
		HEAD~1 HEAD

# Only part of document
$(OBJ_FILE) : %.pdf: %.tex
	$(COMPILER) index_only_$<

.PHONY: clean
clean:
	-rm -f build/*.pdf
	-rm -f build/*.ps
	-rm -f build/*.dvi
	-rm -f build/*.aux
	-rm -f build/*.log
	-rm -f build/*.bbl
	-rm -f build/*.blg
	-rm -f build/*.out

