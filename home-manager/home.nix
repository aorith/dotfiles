{pkgs, ...}: {
  imports = [
    ./packages.nix
    ./programs/neovim.nix
    ./programs/misc.nix
  ];

  home = {
    username = "aorith";
    homeDirectory =
      if (pkgs.stdenv.isLinux)
      then "/home/aorith"
      else "/Users/aorith";

    stateVersion = "23.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Enable on non-nixos linux systems
  targets.genericLinux.enable = pkgs.stdenv.isLinux;
}