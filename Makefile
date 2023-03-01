TARGET=main
FINAL=submission
UNAME_S=$(shell uname -s)

default:
	pdflatex -file-line-error -shell-escape $(TARGET)

bib:
	-for i in 1 2 3; do \
		bibtex $(TARGET); \
		pdflatex -interaction nonstopmode $(TARGET) > /dev/null; \
	done

build_tables:
	cd tables/; ./create_tables.sh

spell:
	aspell --lang=en --mode=tex check $(TARGET).tex

font:
	pdftops $(TARGET).pdf $(TARGET).ps
	ps2pdf -dPDFSETTINGS=/prepress $(TARGET).ps $(FINAL).pdf
	rm main.ps

clean:
	rm -f \
      $(TARGET).aux \
      $(TARGET).bbl \
      $(TARGET).blg \
      $(TARGET).log \
      $(TARGET).out \
      $(TARGET).pdf

%.pdf: %.eps
	eps2pdf $<

all: build_tables default bib default default

final: all font
