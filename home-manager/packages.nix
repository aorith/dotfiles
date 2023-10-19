{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Hack" "JetBrainsMono" "IBMPlexMono" "Iosevka"];})

      awscli
      fd
      gitui
      go
      jq
      pandoc
      rclone
      silver-searcher
      starship
      terraform
      tmux
      yq-go
    ];
  };
}
