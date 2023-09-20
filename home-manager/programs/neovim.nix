{
  pkgs,
  inputs,
  ...
}: let
  plugFromInput = pname: src:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      inherit pname src;
      version = src.shortRev;
    };
in {
  programs.neovim = {
    enable = true;
    withNodeJs = false;
    withRuby = false;
    withPython3 = false;

    plugins = with pkgs.vimPlugins; [
      # dependencies
      nui-nvim
      nvim-web-devicons
      plenary-nvim

      kanagawa-nvim

      dressing-nvim
      fzf-lua
      gitsigns-nvim
      lualine-nvim
      neo-tree-nvim
      trouble-nvim

      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars

      nvim-lspconfig
      neodev-nvim

      # completion
      cmp_luasnip
      lspkind-nvim
      luasnip
      (plugFromInput "nvim-cmp" inputs.nvim-cmp)
      (plugFromInput "nvim-cmp-lsp" inputs.nvim-cmp-lsp)
      (plugFromInput "nvim-cmp-path" inputs.nvim-cmp-path)
      (plugFromInput "nvim-cmp-buffer" inputs.nvim-cmp-buffer)

      (plugFromInput "vim-fugitive" inputs.vim-fugitive)
      (plugFromInput "mini-nvim" inputs.mini-nvim)
      (plugFromInput "conform-nvim" inputs.conform-nvim)
      (plugFromInput "nvim-lint" inputs.nvim-lint)
      (plugFromInput "nvim-base16" inputs.nvim-base16)
    ];
  };

  home = {
    packages = with pkgs; [
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
      typos
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
  };
}
