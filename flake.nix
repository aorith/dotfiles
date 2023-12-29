{
  description = "Home Manager configuration of aorith";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"];
    eachSystemPkgs = f:
      forAllSystems (system: f (import nixpkgs {inherit system;}));
  in {
    # matches configuration names using '$USER@$(uname -m -s | tr ' ' '-')'
    homeConfigurations = {
      "aorith@Linux-x86_64" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./home-manager/home.nix ./home-manager/linux];
        extraSpecialArgs = {inherit inputs;};
      };

      "aorith@Darwin-arm64" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [./home-manager/home.nix];
        extraSpecialArgs = {inherit inputs;};
      };
    };

    formatter = eachSystemPkgs (pkgs: pkgs.alejandra);
  };
}
