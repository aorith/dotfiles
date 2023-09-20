{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Hack" "JetBrainsMono" "IBMPlexMono"];})

      # tools
      fd
      gitui
      silver-searcher
      terraform

      go
    ];
  };
}
