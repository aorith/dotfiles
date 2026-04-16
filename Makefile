SHELL := bash

# find "$DOTFILES/topics" "$PRIVATE_DOTFILES/topics" -mindepth 1 -maxdepth 1 -type d -exec basename -- {} \; | xargs
TOPICS = syncthing vim misc alacritty macos go shell systemd flatpak homebrew distrobox tmux hammerspoon git ghostty tcdn taskfiles cartero vscodium rclone k8s claude githome emacs ssh aws scripts-private


.PHONY: $(TOPICS:%=bootstrap-%)
$(TOPICS:%=bootstrap-%):
	@./bootstrap.sh $(@:bootstrap-%=%)


.PHONY: bootstrap
bootstrap:
	./bootstrap.sh
