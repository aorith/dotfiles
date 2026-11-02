SHELL := bash

TOPICS := $(shell find "$$DOTFILES/topics" "$$PRIVATE_DOTFILES/topics" -mindepth 2 -maxdepth 2 -type f -name "init.sh" -exec dirname -- {} \; | xargs -I {} basename -- {} | sort | xargs)

.PHONY: $(TOPICS:%=%-bootstrap)
$(TOPICS:%=%-bootstrap):
	@./bootstrap.sh $(@:%-bootstrap=%)


.PHONY: bootstrap
bootstrap:
	./bootstrap.sh
