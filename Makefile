# http://www.gnu.org/software/make/manual/make.html

OUTFILENAME := talk.pdf
PLOTS       := plots/PlotScale-in-FH_new_low.pdf \
               plots/PlotScale-in-FH_new_low-selected.pdf \
               plots/PlotScale-in-FH_new_low-selected-high.pdf \
               plots/PlotScale-in-FH_new_low-notower.pdf \
               plots/PlotScale-in-FH_new_low-fhsusyhd.pdf \
               plots/PlotScale-in-FH_new_low-fhsusyhd-error.pdf \
               plots/PlotXt.pdf \
               plots/PlotXt-selected.pdf \
               plots/Xt_TB5_MS1000.pdf \
               plots/Xt_TB5_MS10000.pdf \
               plots/Xt_TB20_MS2000.pdf \
               plots/scale_MSSM_Xt-0.pdf \
               plots/FlexibleEFTHiggs/Mh_MS_TB-5_Xt-0.pdf \
               plots/FlexibleEFTHiggs/Mh_relative_MS_TB-5_Xt-0.pdf \
               plots/FlexibleEFTHiggs/Mh_MS_TB-5_Xt--2.pdf \
               plots/FlexibleEFTHiggs/Mh_relative_MS_TB-5_Xt--2.pdf \
               plots/FlexibleEFTHiggs/Mh_Xt_TB-5_MS-2000.pdf \
               plots/FlexibleEFTHiggs/Mh_relative_Xt_TB-5_MS-2000.pdf
TEXDIRS     := $(PLOTSDIR)
BIBTEX      := bibtex

.PHONY: all clean

all: $(OUTFILENAME)

plots/PlotScale-in-FH_new_low.pdf: plots/plot-mh-ms.gnuplot plots/PlotScale.in.FH_new_low
	cd plots && gnuplot $(shell basename $<)

plots/PlotScale-in-FH_new_low-selected.pdf: plots/plot-mh-ms-selected.gnuplot plots/PlotScale.in.FH_new_low
	cd plots && gnuplot $(shell basename $<)

plots/PlotScale-in-FH_new_low-selected-high.pdf: plots/plot-mh-ms-selected-high.gnuplot plots/scale_high_TB5.dat
	cd plots && gnuplot $(shell basename $<)

plots/PlotScale-in-FH_new_low-notower.pdf: plots/plot-mh-ms-notower.gnuplot plots/PlotScale.in.FH_new_low
	cd plots && gnuplot $(shell basename $<)

plots/PlotScale-in-FH_new_low-fhsusyhd.pdf: plots/plot-mh-ms-fhsusyhd.gnuplot plots/PlotScale.in.FH_new_low
	cd plots && gnuplot $(shell basename $<)

plots/PlotScale-in-FH_new_low-fhsusyhd-error.pdf: plots/plot-mh-ms-fhsusyhd-error.gnuplot plots/PlotScale.in.FH_new_low
	cd plots && gnuplot $(shell basename $<)

plots/PlotXt.pdf: plots/plot-mh-xt.gnuplot plots/PlotXt.in
	cd plots && gnuplot $(shell basename $<)

plots/PlotXt-selected.pdf: plots/plot-mh-xt-selected.gnuplot plots/PlotXt.in
	cd plots && gnuplot $(shell basename $<)

plots/Xt_*.pdf: plots/plot-mh-xt-alex.gnuplot plots/Xt_*.dat
	cd plots && gnuplot $(shell basename $<)

plots/scale_MSSM_Xt-0.pdf: plots/scale_MSSM.gnuplot plots/scale_MSSM.dat
	cd plots && gnuplot $(shell basename $<)

plots/FlexibleEFTHiggs/Mh_MS_TB-5_Xt-0.pdf \
plots/FlexibleEFTHiggs/Mh_relative_MS_TB-5_Xt-0.pdf \
plots/FlexibleEFTHiggs/Mh_MS_TB-5_Xt--2.pdf \
plots/FlexibleEFTHiggs/Mh_relative_MS_TB-5_Xt--2.pdf \
plots/FlexibleEFTHiggs/Mh_Xt_TB-5_MS-2000.pdf \
plots/FlexibleEFTHiggs/Mh_relative_Xt_TB-5_MS-2000.pdf \
: plots/FlexibleEFTHiggs/*.dat plots/FlexibleEFTHiggs/*.sh plots/FlexibleEFTHiggs/*.gnuplot
	cd plots/FlexibleEFTHiggs && ./plot.sh

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
