SHELL := bash

# --- Home manager

HMCONFIG := ${USER}@$(shell uname -m -s | tr ' ' '-')

.PHONY: switch
switch:
	@mkdir -p ~/.local/state/nix/profiles
	@if type home-manager >/dev/null 2>&1; then\
		home-manager switch --flake .#$(HMCONFIG);\
	else\
		nix run nixpkgs#home-manager switch -- --flake .#$(HMCONFIG);\
	fi

.PHONY: news
news:
	@mkdir -p ~/.local/state/nix/profiles
	@if type home-manager >/dev/null 2>&1; then\
		home-manager news --flake .#$(HMCONFIG);\
	else\
		nix run nixpkgs#home-manager news -- --flake .#$(HMCONFIG);\
	fi

# --- Bootstrap

.PHONY: bootstrap
bootstrap:
	./bootstrap.sh

.PHONY: shell
shell:
	./bootstrap.sh shell
	./bootstrap.sh shell-private

.PHONY: scripts
scripts:
	./bootstrap.sh scripts
	./bootstrap.sh scripts-private
