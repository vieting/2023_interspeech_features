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

move_figures:
	sed -i 's/kHz/\\si{\\kilo\\hertz}/g' *.pgf
	sed -i 's/sffamily/rmfamily/g' *.pgf
	sed -i 's/Masked Filters/\\#Masked Filters/g' masked_filters.pgf
	sed -i 's/WER/WER [\\%]/g' masked_filters.pgf
	sed -i 's/\([a-z0-9_\-]*.png\)/figures\/\1/g' *.pgf
	mv *.png figures/ || echo "currently no png files available"
	mv *.pgf figures/

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
