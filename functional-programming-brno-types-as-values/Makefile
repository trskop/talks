# Based on https://github.com/FPBrno/slides-template/blob/master/Makefile by
# Matej Kollár under Creative Commons Attribution-ShareAlike 4.0 International
# License http://creativecommons.org/licenses/by-sa/4.0/.

PANDOC=pandoc
# PANDOC_OPTS+=-t slidy -S -s --webtex
PANDOC_OPTS+=-t slidy -S -s
# PANDOC_OPTS+=--mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
PANDOC_OPTS+=--css slides.css
PANDOC_OPTS+=--email-obfuscation=none

NAME = types-as-values
TARGETS = $(NAME).html

%.html: %.markdown
	# ./code-in-doc/dist/build/codeindoc/codeindoc $?
	$(PANDOC) $(PANDOC_OPTS) -o $@ $?
	# sed -i 's/http:\/\/www.w3.org\/Talks\/Tools\/Slidy2\/\(scripts\|styles\)\/slidy\.\(css\|js\)\(.gz\)\?"/slidy.\2"/' $@

all: $(TARGETS)

clean:
	rm $(TARGETS)

.PHONY: all clean
