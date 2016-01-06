# http://www.gnu.org/software/make/manual/make.html

OUTFILENAME := talk.pdf
PLOTSDIR    := plots
TEXDIRS     := $(PLOTSDIR)
BIBTEX      := bibtex

.PHONY: all clean

all: $(OUTFILENAME)

%.pdf: %.tex
	cd $(PLOTSDIR) && ./makeall.sh
	pdflatex $<
	cd Feynman && ./makeall.sh
	pdflatex $<

clean:
	rm -f *~ *.bak *.aux *.log *.toc *.bbl *.blg *.nav *.out *.snm *.backup

distclean: clean
	rm -f $(OUTFILENAME)
