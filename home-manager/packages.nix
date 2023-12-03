{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Hack" "JetBrainsMono" "IBMPlexMono" "Iosevka"];})

      age
      awscli2
      coreutils-full
      curl
      diffutils
      fd
      findutils
      gitFull
      gitui
      gnugrep
      gnused
      gnutar
      go
      jq
      pandoc
      rclone
      silver-searcher
      sops
      starship
      terraform
      tmux
      yq-go

      kubectl
      kubectl-tree
      kubectl-neat # clean yaml output
      kubectl-ktop
      kubectl-klock
    ];
  };
}
