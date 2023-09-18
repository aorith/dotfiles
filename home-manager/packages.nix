{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Hack" "JetBrainsMono" "IBMPlexMono" "DejaVuSansMono"];})

      # tools
      fd
      gitui
      silver-searcher
      terraform
    ];
  };
}
