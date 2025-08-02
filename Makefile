.PHONY: clean
clean:
	rm -f *.aux *.bbl *.blg *.dvi *.log *.pdf *.ps *.out *.toc *.foo *.bar
	rm -f *.fdb_latexmk *.fls *.bcf *.tdo *.run.xml #dani-added
	rm -f tmp/book.tex tmp/index.tex
	rm -f stacks-project.tar.bz2

