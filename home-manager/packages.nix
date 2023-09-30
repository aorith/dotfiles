{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Hack" "JetBrainsMono" "IBMPlexMono" "Iosevka"];})

      # tools
      awscli
      fd
      gitui
      jq
      rclone
      silver-searcher
      terraform
      tmux
      yq-go

      go
    ];
  };
}
