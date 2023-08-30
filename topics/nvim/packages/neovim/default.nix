{pkgs}: let
  # https://github.com/NixOS/nixpkgs/blob/b4d8662c4a479b7641d28fe866b018adf8d8f2e1/pkgs/applications/editors/neovim/utils.nix
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/neovim/utils.nix
  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      telescope-fzf-native-nvim
    ];

    customRC = "source ~/.config/nvim/init.lua";
  };

  wrappedNeovim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (neovimConfig
    // {
      # neovimConfig has 'wrapperArgs' which sets all the required command line flags to load plugins, treesitter grammars, etc
      wrapRc = false;
    });
in
  pkgs.buildEnv {
    name = "nvim-env";
    paths = [
      wrappedNeovim

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
