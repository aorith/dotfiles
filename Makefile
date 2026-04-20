SHELL := bash

# find "$DOTFILES/topics" "$PRIVATE_DOTFILES/topics" -mindepth 2 -maxdepth 2 -type f -name "init.sh" -exec dirname -- {} \; | xargs -I {} basename -- {} | sort | xargs
TOPICS = alacritty aws emacs flatpak ghostty git githome go hammerspoon homebrew k8s macos misc rclone scripts-private shell ssh syncthing systemd taskfiles tcdn tmux vim vscodium


.PHONY: $(TOPICS:%=bootstrap-%)
$(TOPICS:%=bootstrap-%):
	@./bootstrap.sh $(@:bootstrap-%=%)


.PHONY: bootstrap
bootstrap:
	./bootstrap.sh
