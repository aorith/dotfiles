{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "aorith";
    homeDirectory = "/var/home/aorith";

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Hack" "JetBrainsMono" "IBMPlexMono" "DejaVuSansMono"];})

      neovim

      # tools
      fd
      gitui
      silver-searcher
      terraform

      # formatters, linters, etc
      alejandra
      black
      djlint
      golangci-lint
      gotools
      isort
      nixpkgs-fmt
      nodePackages.prettier
      prettierd
      ruff
      shellcheck
      shfmt
      stylua
      yamlfmt
      yamllint

      # language servers
      emmet-ls
      gopls
      lua-language-server
      marksman
      nil
      nodePackages.bash-language-server
      nodePackages.pyright
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
      ruff-lsp
      sqls
      terraform-ls
      tflint
      vscode-langservers-extracted
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    stateVersion = "23.05"; # Please read the comment before changing.
  };

  programs = {
    fzf.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Enable on non-nixos linux systems
  targets.genericLinux.enable = true;
}
