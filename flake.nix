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
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations.aorith = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home-manager/home.nix];
      extraSpecialArgs = {inherit inputs;};
    };
  };
}
