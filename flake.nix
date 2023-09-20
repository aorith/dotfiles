{
  description = "Home Manager configuration of aorith";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Vim plugins
    vim-fugitive.url = "github:tpope/vim-fugitive";
    vim-fugitive.flake = false;

    mini-nvim.url = "github:echasnovski/mini.nvim";
    mini-nvim.flake = false;

    conform-nvim.url = "github:stevearc/conform.nvim";
    conform-nvim.flake = false;

    nvim-lint.url = "github:mfussenegger/nvim-lint";
    nvim-lint.flake = false;

    nvim-cmp.url = "github:hrsh7th/nvim-cmp";
    nvim-cmp.flake = false;
    nvim-cmp-lsp.url = "github:hrsh7th/cmp-nvim-lsp";
    nvim-cmp-lsp.flake = false;
    nvim-cmp-buffer.url = "github:hrsh7th/cmp-buffer";
    nvim-cmp-buffer.flake = false;
    nvim-cmp-path.url = "github:hrsh7th/cmp-path";
    nvim-cmp-path.flake = false;

    nvim-base16.url = "github:RRethy/nvim-base16";
    nvim-base16.flake = false;
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    # matches configuration names using '$USER@$(uname -m -s | tr ' ' '-')'
    homeConfigurations = {
      "aorith@Linux-x86_64" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./home-manager/home.nix ./home-manager/linux/homelab.nix];
        extraSpecialArgs = {inherit inputs;};
      };

      "aorith@Darwin-arm64" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [./home-manager/home.nix];
        extraSpecialArgs = {inherit inputs;};
      };
    };
  };
}
