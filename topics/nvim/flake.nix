{
  description = "Neovim with dependencies.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs: let
    eachSystem = f:
      inputs.nixpkgs.lib.genAttrs ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"]
      (system: f (import inputs.nixpkgs {inherit system;}));
  in rec {
    apps = eachSystem (pkgs: {
      nvim = {
        type = "app";
        program = "${packages.${pkgs.system}.neovimAorith}/bin/nvim";
      };
      default = apps.${pkgs.system}.nvim;
    });

    packages = eachSystem (pkgs: {
      neovimAorith = pkgs.neovim;
      default = pkgs.callPackage ./packages/neovim {inherit pkgs;};
    });

    formatter = eachSystem (pkgs: pkgs.nixpkgs-fmt);
  };
}
