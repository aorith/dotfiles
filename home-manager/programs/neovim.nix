{
  pkgs,
  inputs,
  ...
}: let
  plugFromInput = pname: src:
    pkgs.vimUtils.buildVimPlugin {
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
      # Tree sitter
      nvim-treesitter-textobjects
      (nvim-treesitter.withPlugins (p:
        with p; [
          # mandatory
          c
          lua
          vim
          vimdoc
          query

          # extra
          diff
          gitcommit
          gitignore
          go
          json
          jsonc
          luadoc
          markdown
          markdown_inline
          nix
          python
          regex
          terraform
          toml
          yaml
        ]))

      # dependencies
      nui-nvim
      nvim-web-devicons
      plenary-nvim

      catppuccin-nvim
      dracula-nvim
      gruvbox-nvim
      kanagawa-nvim
      nightfox-nvim

      dressing-nvim
      fzf-lua
      gitsigns-nvim
      lualine-nvim
      neo-tree-nvim
      trouble-nvim

      aerial-nvim
      neodev-nvim
      nvim-lspconfig

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
      (plugFromInput "github-nvim-theme" inputs.github-nvim-theme)
    ];
  };

  home = {
    packages = with pkgs; [
      tree-sitter
      gcc

      # formatters, linters, etc
      alejandra
      black
      djlint
      golangci-lint
      gotools
      isort
      nixpkgs-fmt
      nodePackages.prettier
      proselint
      ruff
      shellcheck
      shfmt
      stylua
      typos
      vale
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
