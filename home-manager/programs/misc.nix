{pkgs, ...}: {
  programs = {
    bat.enable = true;
    fzf.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
    dircolors = {
      enable = true;
      enableBashIntegration = false;
      enableFishIntegration = false;
      enableZshIntegration = true;
    };
  };
}
