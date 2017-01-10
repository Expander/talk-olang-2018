# http://www.gnu.org/software/make/manual/make.html

OUTFILENAME := talk.pdf
PLOTS       := \
		plots/FlexibleEFTHiggs/DMh_tower-1L_MS_TB-5_Xt-0.pdf \
		plots/FlexibleEFTHiggs/DMh_tower-1L_MS_TB-5_Xt--2.pdf \
		plots/FlexibleEFTHiggs/DMh_tower-1L_Xt_TB-5_MS-2000.pdf \
		plots/FlexibleEFTHiggs/DMh_tower-2L_MS_TB-5_Xt-0.pdf \
		plots/FlexibleEFTHiggs/DMh_tower-2L_MS_TB-5_Xt--2.pdf \
		plots/FlexibleEFTHiggs/DMh_tower-2L_Xt_TB-5_MS-2000.pdf \
		plots/FlexibleEFTHiggs/Mh_MS_TB-5_Xt-0.pdf \
		plots/FlexibleEFTHiggs/Mh_MS_TB-5_Xt--2.pdf \
		plots/FlexibleEFTHiggs/Mh_relative_MS_TB-5_Xt-0.pdf \
		plots/FlexibleEFTHiggs/Mh_relative_MS_TB-5_Xt--2.pdf \
		plots/FlexibleEFTHiggs/Mh_relative_Xt_TB-5_MS-2000.pdf \
		plots/FlexibleEFTHiggs/Mh_Xt_TB-5_MS-2000.pdf
TEXDIRS     := $(PLOTSDIR)
BIBTEX      := bibtex

.PHONY: all clean

all: $(OUTFILENAME)

$(PLOTS): plots/FlexibleEFTHiggs/*.dat plots/FlexibleEFTHiggs/MSSMtower-1L-nologs/*.dat plots/FlexibleEFTHiggs/*.sh plots/FlexibleEFTHiggs/*.gnuplot
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
