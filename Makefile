# http://www.gnu.org/software/make/manual/make.html

OUTFILENAME := talk.pdf
PLOTS       := \
		plots/uncertainties/DMh_MS_TB-5_Xt-1.pdf \
		plots/uncertainties/Mh_MS_TB-5_Xt-0.pdf \
		plots/FlexibleEFTHiggs-2/scan_Mh_Xt_TB-5_MS-2000.pdf

TEXDIRS     := $(PLOTSDIR)
BIBTEX      := bibtex

.PHONY: all clean

all: $(OUTFILENAME)

plots/uncertainties/DMh_MS_TB-5_Xt-1.pdf: plots/uncertainties/plot_DMh.sh plots/uncertainties/*.dat
	$<

plots/uncertainties/Mh_MS_TB-5_Xt-0.pdf: plots/uncertainties/plot_Mh.sh plots/uncertainties/*.dat
	$<

plots/FlexibleEFTHiggs-2/scan_Mh_Xt_TB-5_MS-2000.pdf: \
plots/FlexibleEFTHiggs-2/plot_FlexibleEFTHiggs_Mh_Xt.sh \
plots/FlexibleEFTHiggs-2/*.dat
	$<

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
