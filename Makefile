SLIDES := slides.md

.PHONY: preview pdf html images

preview:
	npx @marp-team/marp-cli@latest $(SLIDES) --allow-local-files --html --preview

pdf:
	npx @marp-team/marp-cli@latest $(SLIDES) --allow-local-files --html --pdf -o presentation.pdf

html:
	npx @marp-team/marp-cli@latest $(SLIDES) --allow-local-files --html -o index.html

images:
	npx @marp-team/marp-cli@latest $(SLIDES) --allow-local-files --images png --image-scale 1.5
