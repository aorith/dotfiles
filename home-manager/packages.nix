{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Hack" "JetBrainsMono" "IBMPlexMono"];})

      # tools
      awscli
      fd
      gitui
      rclone
      silver-searcher
      terraform

      go
    ];
  };
}
