APIFILEPATH=docs/api/v1/
APIFILES=README.md general.md cache_option.md node.md node_state.md storage.md storage_type.md virt_method.md virt_node.md vm.md vm_state.md
PANDOC?=$(HOME)/.cabal/bin/pandoc
BUILDDIR=build

all: clean virtapi.pdf

$(APIFILES): %: setup
	cp $(APIFILEPATH)$@ $(BUILDDIR)/$@
	sed --in-place '1s|^|\\newpage\n\n|' $(BUILDDIR)/$@
	cat $(BUILDDIR)/$@ >> $(BUILDDIR)/SECOND.md

setup:
	mkdir -p $(BUILDDIR)

virtapi.pdf: $(APIFILES)
	cp README.md $(BUILDDIR)/FIRST.md
	cp project_information.md $(BUILDDIR)/
	cp CONTRIBUTING.md $(BUILDDIR)/
	sed --in-place --expression 's|database/images/virtapi.svg|https://rawgit.com/virtapi/virtapi/master/source/database/images/virtapi.svg|' $(BUILDDIR)/FIRST.md
	sed --in-place --expression '/#links-and-sources.*/a \+ [API Call Documentation](#api-call-documentation)' $(BUILDDIR)/FIRST.md
	sed --in-place '/defined our contribution rules in \[CONTRIBUTING.md\]/d' $(BUILDDIR)/FIRST.md
	sed --in-place --regexp-extended 's/(#{1,3})/\1#/g' $(BUILDDIR)/CONTRIBUTING.md
	sed --in-place --expression 's/#contribution/#checklist-for-contributing/' $(BUILDDIR)/FIRST.md
	sed --in-place --expression '/## Contribution/{r CONTRIBUTING.md' --expression 'd}' $(BUILDDIR)/FIRST.md
	sed --in-place '1s|^|\\newpage\n\n|' $(BUILDDIR)/project_information.md
#	$(PANDOC) -f markdown_github+raw_tex --latex-engine=xelatex -V documentclass=scrartcl -o $(BUILDDIR)/virtapi.pdf $(BUILDDIR)/FIRST.md $(BUILDDIR)/project_information.md $(BUILDDIR)/SECOND.md
	$(PANDOC) -f markdown_github+raw_tex -V documentclass=scrartcl -o $(BUILDDIR)/virtapi.pdf $(BUILDDIR)/FIRST.md $(BUILDDIR)/project_information.md $(BUILDDIR)/SECOND.md

clean:
	rm -rf build

.PHONY: clean all
