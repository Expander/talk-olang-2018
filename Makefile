TALK        := talk
PDF         := $(TALK).pdf
TEX         := $(TALK).tex
PLOTS       :=

.PHONY: all clean distclean

all: $(PDF)

clean:
	rm -f *~ *.bak *.aux *.log *.toc *.bbl *.blg *.nav *.out *.snm *.backup
	rm -f plots/*.aux plots/*.log
	rm -f $(PLOTS)

distclean: clean
	rm -f $(PDF)

$(PDF): $(TEX) $(PLOTS)
	pdflatex $<
	pdflatex $<
