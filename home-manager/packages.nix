{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      age
      awscli2
      coreutils-full
      curl
      diffutils
      fd
      findutils
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
