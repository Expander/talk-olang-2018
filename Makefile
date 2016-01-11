# http://www.gnu.org/software/make/manual/make.html

OUTFILENAME := talk.pdf
PLOTS       := plots/PlotScale-in-FH_new_low.pdf \
               plots/PlotScale-in-FH_new_low-selected.pdf \
               plots/PlotXt-selected.pdf
TEXDIRS     := $(PLOTSDIR)
BIBTEX      := bibtex

.PHONY: all clean

all: $(OUTFILENAME)

plots/PlotScale-in-FH_new_low.pdf: plots/plot-mh-ms.gnuplot plots/PlotScale.in.FH_new_low
	cd plots && gnuplot $(shell basename $<)

plots/PlotScale-in-FH_new_low-selected.pdf: plots/plot-mh-ms-selected.gnuplot plots/PlotScale.in.FH_new_low
	cd plots && gnuplot $(shell basename $<)

plots/PlotXt-selected.pdf: plots/plot-mh-xt-selected.gnuplot plots/PlotXt.in
	cd plots && gnuplot $(shell basename $<)

%.pdf: %.tex $(PLOTS)
	pdflatex $<
	cd Feynman && ./makeall.sh
	pdflatex $<

clean:
	rm -f *~ *.bak *.aux *.log *.toc *.bbl *.blg *.nav *.out *.snm *.backup
	rm -f plots/*.aux plots/*.log
	rm -f $(PLOTS)

distclean: clean
	rm -f $(OUTFILENAME)
