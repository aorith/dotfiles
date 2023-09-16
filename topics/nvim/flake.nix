{
  description = "Neovim dependencies.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs: let
    eachSystem = f:
      inputs.nixpkgs.lib.genAttrs ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"]
      (system: f (import inputs.nixpkgs {inherit system;}));
  in {
    packages = eachSystem (pkgs: {
      neovimAorith = pkgs.neovim-deps;
      default = pkgs.callPackage ./packages/neovim-deps {inherit pkgs;};
    });

    formatter = eachSystem (pkgs: pkgs.nixpkgs-fmt);
  };
}
