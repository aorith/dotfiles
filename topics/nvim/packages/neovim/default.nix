{pkgs}:
pkgs.buildEnv {
  name = "nvim-env";
  paths = [
    pkgs.neovim
    pkgs.gcc # for tree-sitter
    pkgs.tree-sitter
    pkgs.cmake # fzf-native

    # utils
    pkgs.fd
    pkgs.fzf
    pkgs.git
    pkgs.gitui
    pkgs.ripgrep
    pkgs.silver-searcher

    # formatters, linters, etc
    pkgs.alejandra
    pkgs.black
    pkgs.golangci-lint
    pkgs.isort
    pkgs.jq
    pkgs.nodePackages.prettier
    pkgs.ruff
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.stylua
    pkgs.terraform
    pkgs.html-tidy
    pkgs.yamlfmt
    pkgs.yamllint

    # language servers
    pkgs.gopls
    pkgs.lua-language-server
    pkgs.marksman
    pkgs.nil
    pkgs.nodePackages.bash-language-server
    pkgs.nodePackages.pyright
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.yaml-language-server
    pkgs.ruff-lsp
    pkgs.sqls
    pkgs.terraform-ls
    pkgs.tflint
  ];
}
